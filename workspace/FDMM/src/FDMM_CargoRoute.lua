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
  -- @param #FDMMTerritory territory Territory object.
  -- @return New instance of FDMMCargoRoute.
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

  --- Creates cargo routes from initial mission group placements.
  -- Layout:
  --   GNPrefixes: CVIN_ CTIN_ CAIN_ CSIN_ (V=Land, T=Train, A=Air, S=Sea)
  --   WPList (ALL): WP1->spawnPoint, WP2->ingressPoint, WH_<WHName>->WH dest, C[V|R]LK_<DIR>->TLNK dest
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
      [fdmm.consts.CargoRoutePrefix.Land] = fdmm.config.gpCache[fdmm.consts.CargoRoutePrefix.Land] or {},
      [fdmm.consts.CargoRoutePrefix.Train] = fdmm.config.gpCache[fdmm.consts.CargoRoutePrefix.Train] or {},
      [fdmm.consts.CargoRoutePrefix.Air] = fdmm.config.gpCache[fdmm.consts.CargoRoutePrefix.Air] or {},
      [fdmm.consts.CargoRoutePrefix.Sea] = fdmm.config.gpCache[fdmm.consts.CargoRoutePrefix.Sea] or {}
    }

    -- Process CargoRoutePrefix.Land (CVIN_)
    for groupName, groupData in pairs(routeGroups[fdmm.consts.CargoRoutePrefix.Land]) do
    end

    -- Process CargoRoutePrefix.Train (CTIN_)
    for groupName, groupData in pairs(routeGroups[fdmm.consts.CargoRoutePrefix.Train]) do
    end

    -- Process CargoRoutePrefix.Air (CAIN_)
    for groupName, groupData in pairs(routeGroups[fdmm.consts.CargoRoutePrefix.Air]) do
    end

    -- Process CargoRoutePrefix.Sea (CSIN_)
    for groupName, groupData in pairs(routeGroups[fdmm.consts.CargoRoutePrefix.Sea]) do
    end
  end

end -- FDMM_CargoRoute

env.info('---FDMM_CargoRoute End---')
