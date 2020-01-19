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
  -- @return New instance of FDMMTerritory.
  function FDMMTerritory.newFromGroup(groupName, groupData)
    local self = setmetatable({}, FDMMTerritory)

    self.groupName = groupName
    self.groupData = groupData or mist.DBs.groupsByName[groupName]

    self.name = fdmm.utils.removeGroupingPrefix(groupName)
    if self.groupData.category == mist.DBs.Category.Ship then
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

  --- Add FARP to territory.
  -- @param #FDMMFARP FARP object. 
  function FDMMTerritory:addFARP(farp)
    -- TODO: This is currently a stand-in. Will expand out later. -NR
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

  --- Creates territories from mission group placements.
  -- Layout:
  --   GNPrefixes: TDEF_ TLNK_ TFRP_
  --   WPList(TDEF_): WP1->centerPoint, WP2-WP(n-1)->polygonPoints, WP(n)->capturePoint
  function fdmm.territory.createTerritories()
    fdmm.territories = {
      [fdmm.enums.TerritoryType.Land] = {},
      [fdmm.enums.TerritoryType.Sea] = {},
      [fdmm.enums.TerritoryType.All] = {}
    }
    local terrGroups = {
      [fdmm.consts.TerritoryPrefix.Define] = fdmm.config.gpCache[fdmm.consts.TerritoryPrefix.Define] or {},
      [fdmm.consts.TerritoryPrefix.Link] = fdmm.config.gpCache[fdmm.consts.TerritoryPrefix.Link] or {},
      [fdmm.consts.TerritoryPrefix.FARP] = fdmm.config.gpCache[fdmm.consts.TerritoryPrefix.FARP] or {}
    }

    -- Process TerritoryPrefix.Define (TDEF_)
    for groupName, groupData in pairs(terrGroups[fdmm.consts.TerritoryPrefix.Define]) do
      local territory = FDMMTerritory.newFromGroup(groupName, groupData)

      fdmm.territories[territory.type][territory.name] = territory
      fdmm.territories.all[territory.name] = territory
    end

    -- Process TerritoryPrefix.Link (TLNK_)
    for groupName, groupData in pairs(terrGroups[fdmm.consts.TerritoryPrefix.Link]) do
      local territoryName = fdmm.utils.removeGroupingPrefix(groupName)
      local territory = fdmm.territories.all[territoryName]

      if territory ~= nil then
        for idx, point in ipairs(mist.getGroupPoints(groupName)) do
          if idx > 1 then
            local closestTerritory = fdmm.territory.closestTerritoryToPoint(point, territory.type)

            if closestTerritory ~= nil then
              territory:addTerritoryLink(closestTerritory)
            else
              env.error('Territory link for group \'' .. groupName .. '\' failed to find a closest territory at index ' .. idx .. '.')
            end
          end
        end
      else
        env.error('Territory link for group \'' .. groupName .. '\' failed to find territory with same name.')
      end
    end

    -- Process TerritoryPrefix.FARP (TFRP_)
    for groupName, groupData in pairs(terrGroups[fdmm.consts.TerritoryPrefix.FARP]) do
      local territoryName = fdmm.utils.removeGroupingPrefix(groupName)
      local territory = fdmm.territories.all[territoryName]

      if territory ~= nil then
        for idx, point in ipairs(mist.getGroupPoints(groupName)) do
          -- TODO: me.
        end
      else
        env.error('Territory FARP for group \'' .. groupName .. '\' failed to find territory with same name.')
      end
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
      -- FIXME: Possible speed trap? I bet this could be sped up via usage of a spacial partitioning tree. -NR
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
