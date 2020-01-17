---
-- FDMM Territory Module.
-- @module FDMM_Territory
env.info('---FDMM_Territory Start---')

--- FDMM territories module.
fdmm.territory = {}

do --FDMMTerritory

  --- Territory class that manages and marks territory boundaries, various points, FARP spawn locations, etc.
  FDMMTerritory = {}
  FDMMTerritory.__index = FDMMTerritory
  setmetatable(FDMMTerritory, {
    __call = function (cls, ...)
      return cls.new(...)
    end,
  })

  --- Territory constructor.
  -- @param #string groupName Group name with territory definition prefix ('TDEF_').
  -- @param #table groupData MIST group data object.
  function FDMMTerritory.new(groupName, groupData)
    local self = setmetatable({}, FDMMTerritory)

    self.groupName = groupName
    self.groupData = groupData or mist.DBs.groupsByName[groupName]

    self.name = self.groupName:sub(#fdmm.consts.TerritoryPrefix.Define + 1)
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

    self.linkedTerritories = {}
    self.linkedTerritoryDistances = {} -- TODO: Make TerritoryLink class and replace. -NR
    self.farpPoints = {}

    return self
  end

  --- Add linked territory.
  -- @param #table otherTerritory Other FDMMTerritory object to link with.
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

  --- Add FARP points.
  -- @param #list<#table> farpPoints List of vec2 coordinates of FARPs (first of which ignored). 
  function FDMMTerritory:addFARPPoints(farpPoints)
    -- TODO: This is currently a stand-in. Will expand out later. -NR
    for idx, point in ipairs(farpPoints) do
      if idx > 1 then
        table.insert(self.farpPoints, point)
      end
    end
  end

  --- Smokes territory polygon points (careful).
  -- @param #string smokeColor Smoke color (e.g. SMOKECOLOR.Blue).
  function FDMMTerritory:smokeBoundaries(smokeColor)
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

  -- Group Name Prefixes: TDEF_ TLNK_ TFRP_
  -- WPList(TDEF_): WP1->centerPoint, WP2-WP(n-1)->polygonPoints, WP(n)->capturePoint
  --- Creates territories from mission group placements.
  function fdmm.territory.createTerritories()
    fdmm.territories = {
      [fdmm.enums.TerritoryType.Land] = {},
      [fdmm.enums.TerritoryType.Sea] = {},
      [fdmm.enums.TerritoryType.All] = {}
    }
    local terrGroups = {
      [fdmm.consts.TerritoryPrefix.Define] = {},
      [fdmm.consts.TerritoryPrefix.Link] = {},
      [fdmm.consts.TerritoryPrefix.FARP] = {}
    }

    -- TODO: Make a common container for these group prefix filters. -NF
    for groupName, groupData in pairs(mist.DBs.groupsByName) do
      if groupName:find('_') ~= nil then -- all prefixes end in _, so if no _ no checks need made
        if groupName:find(fdmm.consts.TerritoryPrefix.Define) == 1 then
          terrGroups[fdmm.consts.TerritoryPrefix.Define][groupName] = groupData
        elseif groupName:find(fdmm.consts.TerritoryPrefix.Link) == 1 then
          terrGroups[fdmm.consts.TerritoryPrefix.Link][groupName] = groupData
        elseif groupName:find(fdmm.consts.TerritoryPrefix.FARP) == 1 then
          terrGroups[fdmm.consts.TerritoryPrefix.FARP][groupName] = groupData
        end
      end
    end

    -- Process TDEF_
    for groupName, groupData in pairs(terrGroups[fdmm.consts.TerritoryPrefix.Define]) do
      local territory = FDMMTerritory(groupName, groupData)

      fdmm.territories[territory.type][territory.name] = territory
      fdmm.territories.all[territory.name] = territory
    end

    -- Process TLNK_
    for groupName, groupData in pairs(terrGroups[fdmm.consts.TerritoryPrefix.Link]) do
      local territoryName = groupName:sub(#fdmm.consts.TerritoryPrefix.Link + 1)
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

    -- Process TFRP_
    for groupName, groupData in pairs(terrGroups[fdmm.consts.TerritoryPrefix.FARP]) do
      local territoryName = groupName:sub(#fdmm.consts.TerritoryPrefix.FARP + 1)
      local territory = fdmm.territories.all[territoryName]

      if territory ~= nil then
        territory:addFARPPoints(mist.getGroupPoints(groupName))
      else
        env.error('Territory FARP for group \'' .. groupName .. '\' failed to find territory with same name.')
      end
    end
  end

  --- Calculates closest territory to provided point.
  -- @param #table point Vec2 position.
  -- @param #string territoryType Optional territory type filter.
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

  --- Dump territories to debug log.
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
