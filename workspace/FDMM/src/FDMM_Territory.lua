env.info('---FDMM_Territory Start---')

fdmm.territory = {}

do --FDMMTerritory
  FDMMTerritory = {}
  FDMMTerritory.__index = FDMMTerritory
  
  setmetatable(FDMMTerritory, {
    __call = function (cls, ...)
      return cls.new(...)
    end,
  })
  
  function FDMMTerritory.new(groupName, groupData)
    local self = setmetatable({}, FDMMTerritory)
    
    self.groupName = groupName
    self.groupData = groupData or mist.DBs.groupsByName[groupName]
    
    self.name = self.groupName:sub(#fdmm.config.consts.TerritoryGroupPrefix + 1)
    if self.groupData.category == 'ship' then
      self.type = fdmm.config.enums.TerritoryType.Sea
    else
      self.type = fdmm.config.enums.TerritoryType.Land
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
    
    return self
  end
  
  function FDMMTerritory:addTerritoryLink(otherTerritory)
    if self.name ~= otherTerritory.name then
      self.linkedTerritories[otherTerritory.name] = otherTerritory
      otherTerritory.linkedTerritories[self.name] = self
    else
      env.error('Cannot link territory \'' .. self.name .. '\' with itself.')
    end
  end
end --FDMMTerritory

do --FDMM_Territory
  fdmm.territory.landTerritories = {}
  fdmm.territory.seaTerritories = {}
  fdmm.territory.allTerritories = {}
  
  function fdmm.territory.createTerritories()
    local terrGroups = {}
    local terrLinks = {}
    local terrFARPs = {}
    
    for groupName, groupData in pairs(mist.DBs.groupsByName) do
      if groupName:find(fdmm.config.consts.TerritoryGroupPrefix) == 1 then
        terrGroups[groupName] = groupData
      elseif groupName:find(fdmm.config.consts.TerritoryLinkPrefix) == 1 then
        terrLinks[groupName] = groupData
      elseif groupName:find(fdmm.config.consts.TerritoryFarpPrefix) == 1 then
        terrFARPs[groupName] = groupData
      end
    end
    
    for groupName, groupData in pairs(terrGroups) do
      local territory = FDMMTerritory(groupName, groupData)
      
      if territory.type == fdmm.config.enums.TerritoryType.Sea then
        fdmm.territory.seaTerritories[territory.name] = territory        
      else
        fdmm.territory.landTerritories[territory.name] = territory
      end
      fdmm.territory.allTerritories[territory.name] = territory
    end
    
    for groupName, groupData in pairs(terrLinks) do
      local territoryName = groupName:sub(#fdmm.config.consts.TerritoryLinkPrefix + 1)
      local territory = fdmm.territory.allTerritories[territoryName]
      
      if territory ~= nil then
        for idx, point in ipairs(mist.getGroupPoints(groupName)) do
          if idx > 1 then
            local closestTerritory = fdmm.territory.closestTerritoryToPoint(point, territory.type)
            
            if closestTerritory ~= nil then
              territory:addTerritoryLink(closestTerritory)
            else
              env.error('Territory group \'' .. groupName .. '\' failed to find a closest territory at index ' .. idx .. '.')
            end
          end
        end
      else
        env.error('Territory group \'' .. groupName .. '\' failed to find territory with same name.')
      end
    end
  end

  function fdmm.territory.closestTerritoryToPoint(point, territoryType)
    local point = mist.utils.makeVec2(point)
    local closestTerritory = nil
    local closestDistSqrd = 0
    local territories = nil
    
    if (territoryType == fdmm.config.enums.TerritoryType.Land) then
      territories = fdmm.territory.landTerritories
    elseif (territoryType == fdmm.config.enums.TerritoryType.Sea) then
      territories = fdmm.territory.seaTerritories
    else
      territories = fdmm.territory.allTerritories
    end
    
    for territoryName, territory in pairs(territories) do
      local distSqrd = mist.utils.get2DDistSqrd(point, territory.centerPoint)
      
      if closestTerritory == nil or distSqrd < closestDistSqrd then
        closestTerritory = territory
        closestDistSqrd = distSqrd
      end
    end
    
    return closestTerritory
  end
  
  function fdmm.territory.dumpTerritories()
    env.info('--FDMM Territories Dump--')
    env.info('  Sea Territories:')
    for territoryName, territory in pairs(fdmm.territory.seaTerritories) do
      env.info('    ' .. territoryName .. ':')
      for linkedTerritoryName, linkedTerritory in pairs(territory.linkedTerritories) do
        env.info ('      Linked /w: \'' .. linkedTerritoryName .. '\'.')
      end
    end
    env.info('  Land Territories:')
    for territoryName, territory in pairs(fdmm.territory.landTerritories) do
      env.info('    ' .. territoryName .. ':')
      for linkedTerritoryName, linkedTerritory in pairs(territory.linkedTerritories) do
        env.info ('      Linked /w: \'' .. linkedTerritoryName .. '\'.')
      end
    end
  end
  
end --FDMM_Territory

env.info('---FDMM_Territory End---')
