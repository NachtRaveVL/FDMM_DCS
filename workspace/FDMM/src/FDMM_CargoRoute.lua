---
-- FDMM Cargo Route Module.
-- @module FDMM_CargoRoute
env.info('---FDMM_CargoRoute Start---')

--- FDMM cargo route module.
fdmm.cargoRoute = {}

do --FDMMCargoRoute
  
  --- CargoRoute class that manages what spawns and destinations are available per territory for cargo vessels.
  FDMMCargoRoute = {}
  FDMMCargoRoute.__index = FDMMCargoRoute
  setmetatable(FDMMCargoRoute, {
    __call = function (cls, ...)
      return cls.new(...)
    end,
  })

  --- CargoRoute constructor.
  -- @param #table territory object.
  function FDMMCargoRoute.new(territory)
    local self = setmetatable({}, FDMMCargoRoute)
    self.territory = territory
  end

  --- Add spawn point to list of spawns locations.
  function FDMMCargoRoute:addSpawnPoint(routeType, spawnPoint, ingressPoint)
  end

  --- Add directional link to list of directional locations.
  function FDMMCargoRoute:addDirectionalLink(routeType, travelPoint)
  end

  --- Add warehouse link to list of warehouse locations.
  function FDMMCargoRoute:addWarehouseDest(routeType, warehouseName, travelPoint)
  end

end --FDMMCargoRoute

do -- FDMM_CargoRoute

  -- Group Name Prefixes: CVIN_ CTIN_ CAIN_ CSIN_ (V=Land, T=Train, A=Air, S=Sea)
  -- WPList (ALL): WP1->spawnPoint, WP2->ingressPoint, WH_<WHName>->WH dest, C[V|R]LK_<DIR>->TLNK dest
  --- Creates cargo routes from mission group placements.
  function fdmm.cargoRoute.createCargoRoutes()
    fdmm.cargoRoutes = {}
    for territoryName, territory in pairs(fdmm.territories.all) do
      fdmm.cargoRoutes[territoryName] = {
        [fdmm.enums.CargoRouteType.Land] = {},
        [fdmm.enums.CargoRouteType.Train] = {},
        [fdmm.enums.CargoRouteType.Air] = {},
        [fdmm.enums.CargoRouteType.Sea] = {},
        [fdmm.enums.CargoRouteType.All] = {}
      }
    end
    local routeGroups = {
      [fdmm.consts.CargoRoutePrefix.Land] = {},
      [fdmm.consts.CargoRoutePrefix.Train] = {},
      [fdmm.consts.CargoRoutePrefix.Air] = {},
      [fdmm.consts.CargoRoutePrefix.Sea] = {}
    }

    -- TODO: Make a common container for these group prefix filters. -NF
    for groupName, groupData in pairs(mist.DBs.groupsByName) do
      if groupName:find('_') ~= nil then -- all prefixes end in _, so if no _ no checks need made
        if groupName:find(fdmm.consts.CargoRoutePrefix.Land) == 1 then
          routeGroups[fdmm.consts.CargoRoutePrefix.Land][groupName] = groupData
        elseif groupName:find(fdmm.consts.CargoRoutePrefix.Train) == 1 then
          routeGroups[fdmm.consts.CargoRoutePrefix.Train][groupName] = groupData
        elseif groupName:find(fdmm.consts.CargoRoutePrefix.Air) == 1 then
          routeGroups[fdmm.consts.CargoRoutePrefix.Air][groupName] = groupData
        elseif groupName:find(fdmm.consts.CargoRoutePrefix.Sea) == 1 then
          routeGroups[fdmm.consts.CargoRoutePrefix.Sea][groupName] = groupData
        end
      end
    end

    -- Process CVIN_
    for groupName, groupData in pairs(routeGroups[fdmm.consts.CargoRoutePrefix.Land]) do
    end

    -- Process CTIN_
    for groupName, groupData in pairs(routeGroups[fdmm.consts.CargoRoutePrefix.Train]) do
    end

    -- Process CAIN_
    for groupName, groupData in pairs(routeGroups[fdmm.consts.CargoRoutePrefix.Air]) do
    end

    -- Process CSIN_
    for groupName, groupData in pairs(routeGroups[fdmm.consts.CargoRoutePrefix.Sea]) do
    end
  end

end -- FDMM_CargoRoute

env.info('---FDMM_CargoRoute End---')
