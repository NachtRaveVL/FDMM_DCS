---
-- FDMM Cargo Route Module.
-- @module FDMM_CargoRoute
env.info('---FDMM_CargoRoute Start---')

--- FDMM cargo route module.
fdmm.cargoRoute = {}

do --FDMMCargoRoute

  --- CargoRoute class that manages what spawns and destinations are available per territory for cargo vessels.
  -- @type FDMMCargoRoute
  FDMMCargoRoute = {}
  FDMMCargoRoute.__index = FDMMCargoRoute
  setmetatable(FDMMCargoRoute, {
    __call = function (cls, ...)
      return cls.new(...)
    end,
  })

  --- CargoRoute constructor.
  -- @param #string territoryName Territory name this cargo route belongs to.
  -- @param #Enums.CargoRouteType routeType Cargo route type.
  -- @return #FDMMCargoRoute New instance of FDMMCargoRoute.
  function FDMMCargoRoute.new(territoryName, routeType)
    local self = setmetatable({}, FDMMCargoRoute)

    self.territoryName = territoryName
    self.routeType = routeType
    self.startLocations = {}
    self.warehouseLocations = {}
    self.directionalLinks = {}

    return self
  end

  --- Adds spawn point and optional egress points to list of start locations.
  -- @param #Enums.Faction spawnFaction Spawnable faction.
  -- @param DCS#Vec2 spawnPoint Spawn point location.
  -- @param #ListVec2 egressPoints Set of egress points to follow outbound of spawn point (typically to get on a road, navigate through a ship canal, etc.).
  function FDMMCargoRoute:addStartLocation(spawnFaction, spawnPoint, egressPoints)
    table.insert(self.startLocations, { spawnFaction = spawnFaction,
                                        spawnPoint = spawnPoint,
                                        egressPoints = egressPoints or {} })
  end

  --- Adds warehouse name, point, and optional ingress points to list of warehouse locations.
  -- @param #string warehouseName Name of warehouse.
  -- @param DCS#Vec2 warehousePoint Warehouse location point.
  -- @param #ListVec2 ingressPoints Set of ingress points to follow inbound to warehouse point (typically to get on a road, navigate through a ship canal, etc.).
  function FDMMCargoRoute:addWarehouseLocation(warehouseName, warehousePoint, ingressPoints)
    table.insert(self.warehouseLocations, { warehouseName = warehouseName,
                                            warehousePoint = warehousePoint,
                                            ingressPoints = ingressPoints or {} })
  end

  --- Adds directional linkage to list of directional navigation nodes.
  -- @param #string directionName Direction name (typically similar to FARP naming).
  -- @param DCS#Vec2 navigationPoint Navigation node point (typically in vacinity of a FARP). 
  -- @param #ListVec2 ingressPoints Set of ingress points to follow inbound to navigation node point (typically to get on a road, navigate through a ship canal, etc.).
  function FDMMCargoRoute:addDirectionalLink(directionName, navigationPoint, ingressPoints)
    table.insert(self.directionalLinks, { directionName = directionName,
                                          navigationPoint = navigationPoint,
                                          ingressPoints = ingressPoints or {} })
  end

  --- Gets a random outbound route (along with egress points, if any) from a random spawn point for given faction.
  -- @param #Enums.Faction spawnFaction Spawn faction filter.
  -- @return #ListRoute List of DCS routing entries, otherwise nil if no routes exist.
  function FDMMCargoRoute:getOutboundRouteFromSpawn(spawnFaction)
    -- TODO: me.
  end

  --- Gets a random inbound route (along with ingress points, if any) to named warehouse.
  -- @param #string warehouseName Warehouse name.
  -- @return #ListRoute List of DCS routing entries, otherwise nil if no routes exist.
  function FDMMCargoRoute:getInboundRouteToWarehouse(warehouseName)
    -- TODO: me.
  end

  --- Gets a random outbound route (along with egress points, if any) from named warehouse.
  -- @param #string warehouseName Warehouse name.
  -- @return #ListRoute List of DCS routing entries, otherwise nil if no routes exist.
  function FDMMCargoRoute:getOutboundRouteFromWarehouse(warehouseName)
    -- TODO: me.
  end

  --- Gets the closest directional navigation node linkage to specified point outside of cargo route's territory.
  -- Note: This method uses the territories center point to calculate likely navigation linkage node.
  -- @param DCS#Vec2 point Point outside of cargo route's territory, otherwise nil if no routes exists.
  function FDMMCargoRoute:getClosestDirectionalLinkageToOutsidePoint(point)
    -- TODO: me.
  end

end --FDMMCargoRoute

do -- FDMM_CargoRoute

  --- Creates cargo routes from initial mission group placements.
  -- Layout:
  --   GNPrefixes: CVRT_ CTRT_ CART_ CSRT_ (V=Land, T=Train, A=Air, S=Sea)
  --   WPList (ALL): WP1->spawnPoint, WP2->ingressPoint, C[V|T|A|S]WH_<WHName>->WH, C[V|T|A|S]LK_<DirName>->Dir
  function fdmm.cargoRoute.createCargoRoutes()
    fdmm.cargoRoutes = {}
    for territoryName, territory in pairs(fdmm.territories.all) do
      fdmm.cargoRoutes[territoryName] = {
        [fdmm.enums.CargoRouteType.Land] = FDMMCargoRoute.new(territoryName, fdmm.enums.CargoRouteType.Land),
        [fdmm.enums.CargoRouteType.Train] = FDMMCargoRoute.new(territoryName, fdmm.enums.CargoRouteType.Train),
        [fdmm.enums.CargoRouteType.Air] = FDMMCargoRoute.new(territoryName, fdmm.enums.CargoRouteType.Air),
        [fdmm.enums.CargoRouteType.Sea] = FDMMCargoRoute.new(territoryName, fdmm.enums.CargoRouteType.Sea)
      }
    end
    local routeGroups = {
      [fdmm.consts.CargoRoutePrefix.Land] = fdmm.config.gpCache[fdmm.consts.CargoRoutePrefix.Land] or {},
      [fdmm.consts.CargoRoutePrefix.Train] = fdmm.config.gpCache[fdmm.consts.CargoRoutePrefix.Train] or {},
      [fdmm.consts.CargoRoutePrefix.Air] = fdmm.config.gpCache[fdmm.consts.CargoRoutePrefix.Air] or {},
      [fdmm.consts.CargoRoutePrefix.Sea] = fdmm.config.gpCache[fdmm.consts.CargoRoutePrefix.Sea] or {}
    }
    function _makePos2FromRP(routePoint)
      return { x = routePoint.x or routePoint.point.x, y = routePoint.y or routePoint.point.y }
    end
    function _processGroup(groupName, groupData, routeType, locPrefixes)
      local territoryName = fdmm.utils.removeNumericSuffix(fdmm.utils.removeGroupingPrefix(groupName))
      local territory = fdmm.territories.all[territoryName]

      if territory ~= nil then
        local cargoRoute = fdmm.cargoRoutes[territoryName][routeType]
        local groupRoute = mist.getGroupRoute(groupName, false)
        local routeFaction = fdmm.utils.getFaction(string.notEmptyElse(groupData.units[1].unitName, groupData.country))

        -- Scanner for parsing WP list
        local scanMode = nil
        local ScanMode = { Spawn = 'spawn', Warehouse = 'warehouse', Linkage = 'linkage' }
        local name, point, pointList = nil, nil, {}

        function _updateScanner(nextScanMode, nextName)
          if scanMode ~= nextScanMode or name ~= nextName then
            if scanMode then -- take care of last scan
              if scanMode == ScanMode.Spawn then
                if string.isNotEmpty(routeFaction) and point and pointList then
                  cargoRoute:addStartLocation(routeFaction, point, pointList)
                else
                  env.error('Cargo ' .. routeType .. ' routing group \'' .. groupName .. '\' failed to parse spawn route \'' .. (name or '<nil>') .. '\'.')
                end
              elseif scanMode == ScanMode.Warehouse then
                if string.isNotEmpty(name) and point and pointList then
                  cargoRoute:addWarehouseLocation(name, point, pointList)
                else
                  env.error('Cargo ' .. routeType .. ' routing group \'' .. groupName .. '\' failed to parse warehouse route \'' .. (name or '<nil>') .. '\'.')
                end
              elseif scanMode == ScanMode.Linkage then
                if string.isNotEmpty(name) and point and pointList then
                  cargoRoute:addDirectionalLink(name, point, pointList)
                else
                  env.error('Cargo ' .. routeType .. ' routing group \'' .. groupName .. '\' failed to parse linkage route \'' .. (name or '<nil>') .. '\'.')
                end
              else
                env.error('Cargo ' .. routeType .. ' routing group \'' .. groupName .. '\' encountered unrecognized scan mode \'' .. nextScanMode .. '\'.')
              end

              name, point, pointList = nil, nil, {}
            end

            scanMode = nextScanMode
            name = nextName
          end
        end

        for idx, routePoint in ipairs(groupRoute) do
          if string.isNotEmpty(routePoint.name) then -- only worried about named WPs
            local wpPrefix, wpName, wpSuffix = fdmm.utils.getGroupingComponents(routePoint.name)

            -- Allowing some degree of flexibility here.
            if string.isEmpty(wpPrefix) and (wpName .. '_') == fdmm.consts.CargoRoutePrefix[routeType:upperFirst()] then
              wpPrefix = (wpName .. '_')
              wpName = nil
            elseif string.isEmpty(wpSuffix) and table.contains(fdmm.consts.RouteSuffix, ('_' .. wpName)) then
              wpSuffix = ('_' .. wpName)
              wpName = nil
            end

            if wpPrefix == fdmm.consts.CargoRoutePrefix[routeType:upperFirst()] then
              if wpSuffix == fdmm.consts.RouteSuffix.SpawnPoint then
                _updateScanner(ScanMode.Spawn, wpName)
                point = _makePos2FromRP(routePoint)
              elseif wpSuffix == fdmm.consts.RouteSuffix.EgressPoint then
                _updateScanner(ScanMode.Spawn, wpName)
                table.insert(pointList, _makePos2FromRP(routePoint))
              elseif string.isEmpty(wpName) and string.isEmpty(wpSuffix) then
                -- No spawn point
              else
                env.error('Cargo ' .. routeType .. ' routing group \'' .. groupName .. '\' unknown spawn WP \'' .. routePoint.name .. '\' at WP index ' .. idx .. '.')
              end
            elseif wpPrefix == locPrefixes.Warehouse then
              if string.isEmpty(wpSuffix) then
                _updateScanner(ScanMode.Warehouse, wpName)
                point = _makePos2FromRP(routePoint)
              elseif wpSuffix == fdmm.consts.RouteSuffix.IngressPoint then
                _updateScanner(ScanMode.Warehouse, wpName)
                table.insert(pointList, _makePos2FromRP(routePoint))
              else
                env.error('Cargo ' .. routeType .. ' routing group \'' .. groupName .. '\' unknown warehouse WP \'' .. routePoint.name .. '\' at WP index ' .. idx .. '.')
              end
            elseif wpPrefix == locPrefixes.Linkage then
              if string.isEmpty(wpSuffix) then
                _updateScanner(ScanMode.Linkage, wpName)
                point = _makePos2FromRP(routePoint)
              elseif wpSuffix == fdmm.consts.RouteSuffix.IngressPoint then
                _updateScanner(ScanMode.Linkage, wpName)
                table.insert(pointList, _makePos2FromRP(routePoint))
              else
                env.error('Cargo ' .. routeType .. ' routing group \'' .. groupName .. '\' unknown linkage WP \'' .. routePoint.name .. '\' at WP index ' .. idx .. '.')
              end
            else
              env.error('Cargo ' .. routeType .. ' routing group \'' .. groupName .. '\' unknown routing WP \'' .. routePoint.name .. '\' at WP index ' .. idx .. '.')
            end
          end
        end
        _updateScanner(nil, nil)
      else
        env.error('Cargo ' .. routeType .. ' routing group \'' .. groupName .. '\' failed to find territory with same name.')
      end
    end

    -- Process CargoRoutePrefix.Land (CVRT_)
    for groupName, groupData in pairs(routeGroups[fdmm.consts.CargoRoutePrefix.Land]) do
      _processGroup(groupName, groupData, fdmm.enums.CargoRouteType.Land, fdmm.consts.CargoRouteLocPrefix.Land)
    end

    -- Process CargoRoutePrefix.Train (CTRT_)
    for groupName, groupData in pairs(routeGroups[fdmm.consts.CargoRoutePrefix.Train]) do
      _processGroup(groupName, groupData, fdmm.enums.CargoRouteType.Train, fdmm.consts.CargoRouteLocPrefix.Train)
    end

    -- Process CargoRoutePrefix.Air (CART_)
    for groupName, groupData in pairs(routeGroups[fdmm.consts.CargoRoutePrefix.Air]) do
      _processGroup(groupName, groupData, fdmm.enums.CargoRouteType.Air, fdmm.consts.CargoRouteLocPrefix.Air)
    end

    -- Process CargoRoutePrefix.Sea (CSRT_)
    for groupName, groupData in pairs(routeGroups[fdmm.consts.CargoRoutePrefix.Sea]) do
      _processGroup(groupName, groupData, fdmm.enums.CargoRouteType.Sea, fdmm.consts.CargoRouteLocPrefix.Sea)
    end
  end

end -- FDMM_CargoRoute

env.info('---FDMM_CargoRoute End---')
