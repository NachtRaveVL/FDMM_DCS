---
-- FDMM Territory Module.
-- @module FDMM_Territory
env.info('---FDMM_Territory Start---')

--- FDMM territories module.
fdmm.territory = {}

do --FDMMTerritory

  --- Territory class that manages and marks territory boundaries, various points, FARP spawn locations, etc.
  -- @type FDMMTerritory
  FDMMTerritory = {}
  FDMMTerritory.__index = FDMMTerritory
  setmetatable(FDMMTerritory, {
    __call = function (cls, ...)
      return cls.newFromGroup(...)
    end,
  })

  --- Territory constructor from group name/data.
  -- @param #string groupName Group name with territory definition prefix ('TDEF_').
  -- @param #table groupData MIST group data object.
  -- @return #FDMMTerritory New instance of #FDMMTerritory.
  function FDMMTerritory.newFromGroup(groupName, groupData)
    local self = setmetatable({}, FDMMTerritory)

    self.name = fdmm.utils.removeGroupingPrefix(groupName)
    if groupData.category == mist.DBs.Category.Ship then
      self.type = fdmm.enums.TerritoryType.Sea
    else
      self.type = fdmm.enums.TerritoryType.Land
    end

    self.polygonPoints = {}
    local groupPoints = mist.getGroupPoints(groupName)
    for idx, point in ipairs(groupPoints) do
      if idx > 1 and idx < #groupPoints then
        table.insert(self.polygonPoints, point)
      elseif idx == 1 then
        self.centerPoint = point
      else
        self.capturePoint = point
      end
    end
    -- Remove last point in polygonPoint if it's too close to first point (typical situation)
    local cyclicDistSqrd = mist.utils.get2DDist(self.polygonPoints[1], self.polygonPoints[#self.polygonPoints])
    if cyclicDistSqrd <= 25*25 then
      table.remove(self.polygonPoints, #self.polygonPoints)
    end

    self.polygonZone = ZONE_POLYGON:NewFromPoints(self.name, self.polygonPoints)

    self.linkedTerritories = {}
    self.linkedTerritoryDistances = {} -- TODO: Make TerritoryLink class and replace. -NR

    self.facilities = {}

    return self
  end

  --- Add linked territory to territory.
  -- @param #FDMMTerritory otherTerritory Other territory object to link with.
  function FDMMTerritory:addTerritoryLink(otherTerritory)
    if self.name ~= otherTerritory.name then
      self.linkedTerritories[otherTerritory.name] = otherTerritory
      otherTerritory.linkedTerritories[self.name] = self

      local dist = mist.utils.get2DDist(self.centerPoint, otherTerritory.centerPoint)
      self.linkedTerritoryDistances[otherTerritory.name] = dist
      otherTerritory.linkedTerritoryDistances[self.name] = dist
    else
      env.error('Cannot link territory \'' .. self.name .. '\' with itself.')
    end
  end

  --- Adds facility to territory.
  -- @param #FDMMFacility facility Facility object.
  function FDMMTerritory:addFacility(facility)
    self.facilities[facility.name] = facility
  end

  --- Builds all facilities in territory.
  function FDMMTerritory:buildFacilities()
    for facilityName, facility in pairs(self.facilities) do
      facility:buildFacility()
    end
  end

  --- Smokes territory polygon points (careful - can cause a fair bit of lag for large territories).
  -- @param Utilities.Utils#SMOKECOLOR smokeColor Optional smoke color, otherwise SMOKECOLOR.Blue.
  function FDMMTerritory:smokeBoundaries(smokeColor)
    smokeColor = smokeColor or SMOKECOLOR.Blue
    local tol = 10000.0 / 25.0 -- ~25 flares per ~10000 distance
    local lastPoint3 = nil
    for idx, point in ipairs(self.polygonPoints) do
      if idx > 1 then
        local point3 = mist.utils.makeVec3(point)
        local diffVec3 = mist.vec.sub(point3, lastPoint3)
        local distance = mist.vec.mag(diffVec3)
        local unitVec3 = mist.vec.scalarMult(diffVec3, 1.0 / distance) 
        local cuts = 1
        local cutDistance = distance / cuts
        while cutDistance > tol do
          cuts = cuts + 1
          cutDistance = distance / cuts
        end
        while cuts >= 0 do
          local offVec3 = mist.vec.scalarMult(unitVec3, cuts * cutDistance)
          local smokePoint3 = mist.vec.add(lastPoint3, offVec3);
          COORDINATE:NewFromVec2(mist.utils.makeVec2(smokePoint3)):Smoke(smokeColor)
          cuts = cuts - 1
        end
      end
      lastPoint3 = mist.utils.makeVec3(point)
    end
  end

end --FDMMTerritory

do --FDMM_Territory

  --- Creates territories from initial mission group placements.
  -- Layout:
  --   GNPrefixes: TDEF_ TLNK_ TFAC
  --   WPList(TDEF_): WP0->centerPoint, WP(1,n-1)->polygonPoints, WP(n)->capturePoint
  --   WPList(TLNK_): WP0->typically unused/named TLNK for map editor visibility
  --                  WP(1,n)->unnamed WPs provide territory linkage (via closest territory centerPoint to routePoint)
  --   WPList(TFAC_): WP0->typically unused/named TFAC for map editor visibility
  --                  WP(1,n)->Named WPs with #Consts.TerritoryWPFacilityPrefix provide facility type and centerPoint
  function fdmm.territory.createTerritories()
    fdmm.territories = {
      [fdmm.enums.TerritoryType.Land] = {},
      [fdmm.enums.TerritoryType.Sea] = {},
      [fdmm.enums.TerritoryType.All] = {}
    }
    local terrGroups = {
      [fdmm.consts.TerritoryGNPrefix.Define] = fdmm.config.gpCache[fdmm.consts.TerritoryGNPrefix.Define] or {},
      [fdmm.consts.TerritoryGNPrefix.Linkage] = fdmm.config.gpCache[fdmm.consts.TerritoryGNPrefix.Linkage] or {},
      [fdmm.consts.TerritoryGNPrefix.Facility] = fdmm.config.gpCache[fdmm.consts.TerritoryGNPrefix.Facility] or {}
    }
    local knownPrefixes = table.concatedWith(fdmm.consts.TerritoryGNPrefix, fdmm.consts.TerritoryWPFacilityPrefix)

    -- Process TerritoryGNPrefix.Define (TDEF_)
    for groupName, groupData in pairs(terrGroups[fdmm.consts.TerritoryGNPrefix.Define]) do
      local territory = FDMMTerritory.newFromGroup(groupName, groupData)

      fdmm.territories[territory.type][territory.name] = territory
      fdmm.territories.all[territory.name] = territory
    end

    -- Process TerritoryGNPrefix.Linkage (TLNK_)
    for groupName, groupData in pairs(terrGroups[fdmm.consts.TerritoryGNPrefix.Linkage]) do
      local territoryName = fdmm.utils.removeGroupingPrefix(groupName)
      local territory = fdmm.territories.all[territoryName]

      if territory ~= nil then
        for idx, routePoint in ipairs(mist.getGroupRoute(groupName, false)) do
          if string.isEmpty(routePoint.name) then -- only worried about unnamed WPs
            local closestTerritory = fdmm.territory.closestTerritoryToPoint(fdmm.utils.rposFromRPoint(routePoint), territory.type)

            if closestTerritory ~= nil then
              territory:addTerritoryLink(closestTerritory)
            else
              env.error('Territory linkage group \'' .. groupName .. '\' failed to find a closest territory at WP index ' .. idx .. '.')
            end
          end
        end
      else
        env.error('Territory linkage group \'' .. groupName .. '\' failed to find territory named \'' .. territoryName .. '\'.')
      end
    end

    -- Process TerritoryGNPrefix.Facility (TFAC_)
    for groupName, groupData in pairs(terrGroups[fdmm.consts.TerritoryGNPrefix.Facility]) do
      local territoryName = fdmm.utils.removeGroupingPrefix(groupName)
      local territory = fdmm.territories.all[territoryName]

      if territory ~= nil then
        for idx, routePoint in ipairs(mist.getGroupRoute(groupName, false)) do
          if string.isNotEmpty(routePoint.name) and (routePoint.name .. '_') ~= fdmm.consts.TerritoryGNPrefix.Facility then -- only worried about named WPs
            local wpPrefix, wpName, wpSuffix = fdmm.utils.getGroupingComponentsWithSNC(routePoint.name, knownPrefixes, nil)

            if wpPrefix == fdmm.consts.TerritoryWPFacilityPrefix.Airbase and string.isNotEmpty(wpName) then
              local airbase = territory.facilities[wpName] or FDMMAirbase.new(wpName, fdmm.utils.rposFromRPoint(routePoint), territoryName)
              territory:addFacility(airbase)
            elseif wpPrefix == fdmm.consts.TerritoryWPFacilityPrefix.ArmsPlant and string.isNotEmpty(wpName) then
              local armsPlant = territory.facilities[wpName] or FDMMArmsPlant.new(wpName, fdmm.utils.rposFromRPoint(routePoint), territoryName)
              territory:addFacility(armsPlant)
            elseif wpPrefix == fdmm.consts.TerritoryWPFacilityPrefix.CommandCenter and string.isNotEmpty(wpName) then
              local commandCenter = territory.facilities[wpName] or FDMMCommandCenter.new(wpName, fdmm.utils.rposFromRPoint(routePoint), territoryName)
              territory:addFacility(commandCenter)
            elseif wpPrefix == fdmm.consts.TerritoryWPFacilityPrefix.FARP and string.isNotEmpty(wpName) then
              local farp = territory.facilities[wpName] or FDMMFARP.new(wpName, fdmm.utils.rposFromRPoint(routePoint), territoryName)
              territory:addFacility(farp)
            elseif wpPrefix == fdmm.consts.TerritoryWPFacilityPrefix.OilField and string.isNotEmpty(wpName) then
              local oilField = territory.facilities[wpName] or FDMMOilField.new(wpName, fdmm.utils.rposFromRPoint(routePoint), territoryName)
              territory:addFacility(oilField)
            elseif wpPrefix == fdmm.consts.TerritoryWPFacilityPrefix.Port and string.isNotEmpty(wpName) then
              local port = territory.facilities[wpName] or FDMMPort.new(wpName, fdmm.utils.rposFromRPoint(routePoint), territoryName)
              territory:addFacility(port)
            elseif wpPrefix == fdmm.consts.TerritoryWPFacilityPrefix.UnitFactory and string.isNotEmpty(wpName) then
              local unitFactory = territory.facilities[wpName] or FDMMUnitFactory.new(wpName, fdmm.utils.rposFromRPoint(routePoint), territoryName)
              territory:addFacility(unitFactory)
            elseif not (string.isEmpty(wpName) and string.isEmpty(wpSuffix)) then -- not a stand-in WP name
              env.error('Territory group \'' .. groupName .. '\' unknown facility WP \'' .. (routePoint.name or '<nil>') .. '\' at WP index ' .. idx .. '.')
            end
          end
        end
      else
        env.error('Territory facility group \'' .. groupName .. '\' failed to find territory named \'' .. territoryName .. '\'.')
      end
    end
  end

  --- Builds associated facilities that exist inside territories.
  function fdmm.territory.buildFacilities()
    for territoryName, territory in pairs(fdmm.territories.all) do
      territory:buildFacilities()
    end
  end

  --- Calculates closest territory to provided point.
  -- @param DCS#Vec point Point position.
  -- @param FDMM#Enum.TerritoryType territoryType Optional territory type filter.
  -- @return FDMM#FDMMTerritory Closest territory to point.
  function fdmm.territory.closestTerritoryToPoint(point, territoryType)
    local point = mist.utils.makeVec2(point)
    local closestTerritory = nil
    local closestDistSqrd = 0
    local territoryType = territoryType or fdmm.enums.TerritoryType.All
    local territories = fdmm.territories[territoryType]

    for territoryName, territory in pairs(territories) do
      -- FIXME: Speed trap! Replace with spacial partitioning tree later. -NR
      local distSqrd = mist.utils.get2DDistSqrd(point, territory.centerPoint)

      if closestTerritory == nil or distSqrd < closestDistSqrd then
        closestTerritory = territory
        closestDistSqrd = distSqrd
      end
    end

    return closestTerritory
  end

  --- Dumps territories to debug log.
  function fdmm.territory.dumpTerritories()
    function _envInfoTerritory(territoryName, territory)
      env.info('    \'' .. territoryName .. '\':')
      env.info('      ' .. 'centerPoint: ' .. fdmm.utils.pos2ToLoggableString(territory.centerPoint))
      env.info('      ' .. 'capturePoint: ' .. fdmm.utils.pos2ToLoggableString(territory.capturePoint))
      for linkedTerritoryName, linkedTerritory in pairs(territory.linkedTerritories) do
        env.info ('      ' .. 'Linked /w: \'' .. linkedTerritoryName .. '\'.')
      end
    end
    env.info('--FDMM Territories Dump--')
    env.info('  Sea Territories:')
    for territoryName, territory in pairs(fdmm.territories.sea) do
      _envInfoTerritory(territoryName, territory)
    end
    env.info('  Land Territories:')
    for territoryName, territory in pairs(fdmm.territories.land) do
      _envInfoTerritory(territoryName, territory)
    end
  end

end --FDMM_Territory

env.info('---FDMM_Territory End---')
