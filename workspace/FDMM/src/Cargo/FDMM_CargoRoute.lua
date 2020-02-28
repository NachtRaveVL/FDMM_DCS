---
-- FDMM Cargo Route Module.
-- @module FDMM_CargoRoute
env.info("---FDMM_CargoRoute Start---")

--- FDMM cargo route module.
fdmm.cargoRoute = {}

do --FDMMCargoRoute

  --- Cargo route class that manages what spawns and destinations are available per territory for cargo vessels.
  -- @type FDMMCargoRoute
  FDMMCargoRoute = {}
  FDMMCargoRoute.__index = FDMMCargoRoute
  setmetatable(FDMMCargoRoute, {
    __call = function (cls, ...)
      return cls.new(...)
    end,
  })

  --- Cargo route constructor.
  -- @param #string territoryName Territory name this cargo route belongs to.
  -- @param #Enums.CargoRouteType routeType Cargo route type.
  -- @return #FDMMCargoRoute New instance of #FDMMCargoRoute.
  function FDMMCargoRoute.new(territoryName, routeType)
    local self = setmetatable({}, FDMMCargoRoute)

    self.territoryName = territoryName
    self.routeType = routeType
    self.spawnLocs = {}
    self.facilityLocs = {}
    self.dirLinks = {}

    return self
  end

  --- Adds spawn point and optional egress points to list of spawn locations.
  -- @param #Enums.Faction spawnFaction Spawnable faction.
  -- @param DCS#Vec2 spawnPoint Spawn point location.
  -- @param #ListVec2 egressPoints Set of egress points to follow outbound of spawn point (typically to get on a road, navigate through a ship canal, etc.).
  function FDMMCargoRoute:addSpawnLocation(spawnFaction, spawnPoint, egressPoints)
    table.insert(self.spawnLocs, { spawnFaction = spawnFaction,
                                   spawnPoint = spawnPoint,
                                   egressPoints = egressPoints or {} })
  end

  --- Adds facility name, point, and optional ingress points to list of facility locations.
  -- @param #string facilityName Name of facility.
  -- @param DCS#Vec2 facilityPoint Facility location point.
  -- @param #ListVec2 ingressPoints Set of ingress points to follow inbound to facility point (typically to get on a road, navigate through a ship canal, etc.).
  function FDMMCargoRoute:addFacilityLocation(facilityName, facilityPoint, ingressPoints)
    table.insert(self.facilityLocs, { facilityName = facilityName,
                                      facilityPoint = facilityPoint,
                                      ingressPoints = ingressPoints or {} })
  end

  --- Adds directional linkage to list of directional navigation nodes.
  -- @param #string directionName Direction name (typically similar to FARP naming).
  -- @param DCS#Vec2 navigationPoint Navigation node point (typically in vacinity of a FARP). 
  -- @param #ListVec2 ingressPoints Set of ingress points to follow inbound to navigation node point (typically to get on a road, navigate through a ship canal, etc.).
  function FDMMCargoRoute:addDirectionalLink(directionName, navigationPoint, ingressPoints)
    table.insert(self.dirLinks, { directionName = directionName,
                                  navigationPoint = navigationPoint,
                                  ingressPoints = ingressPoints or {} })
  end

  --- Gets a random outbound starting route (along with egress points, if any) from a random spawn point for given faction.
  -- @param #Enums.Faction spawnFaction Spawn faction filter.
  -- @return #ListRoute List of DCS routing entries, otherwise nil if no routes exist.
  function FDMMCargoRoute:getOutboundRouteFromStart(spawnFaction)
    -- TODO: me.
  end

  --- Gets a random inbound facility route (along with ingress points, if any) to named facility.
  -- @param #string facilityName Facility facility name.
  -- @return #ListRoute List of DCS routing entries, otherwise nil if no routes exist.
  function FDMMCargoRoute:getInboundRouteToFacility(facilityName)
    -- TODO: me.
  end

  --- Gets a random outbound facility route (along with egress points, if any) from named facility.
  -- @param #string facilityName Facility facility name.
  -- @return #ListRoute List of DCS routing entries, otherwise nil if no routes exist.
  function FDMMCargoRoute:getOutboundRouteFromFacility(facilityName)
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
  --   GNPrefixes: CVRT_ CTRT_ CART_ CSRT_ (V=Vehicle/Land, T=Train, A=Air, S=Sea)
  --   WPList (ALL):
  --    WPs that are unnamed, or just contain the GN prefix only (w/o '_'), are skipped/unused.
  --    WP0 is generally named the GN prefix (w/o '_') to identify it as territory's main cargo routing group on map
  --      editor, or simply the GN prefix suffixed with _SP to specify a cargo unit's initial position as a territory
  --      spawn point.
  --    WPs are named such that successive WPs create 'routes' of waypoints that then link to one of the types of route
  --      creation methods:
  --      - All WPs for a particular route subset must contain the referenced point location name and use either:
  --          1) #Consts.CargoRouteGNPrefix and a required #Consts.CargoRouteWPRouteSuffix, or
  --          2) #Consts.CargoRouteWPRoutePrefix and any optional/applicable #Consts.CargoRouteWPRouteSuffix iff needed
  --      - Point locations get specified using the name of the facility or linkage direction (with corresponding
  --        prefix/suffix iff required). Consider this the primary point a route is attempting to reach/leave.
  --      - Facility and linkage direction can specify ingress points, which describe navigating-towards the location,
  --        via suffix _IP, typically appearing in the WP list before the point location WP.
  --      - Spawn points can specify egress points, which describe navigating-away-from the location, via suffix _EP,
  --        typically appearing in the WP list after the point location WP.
  --      - When routes are requested, any ingress/egress points will be properly reversed to supply assisted routing
  --        into/out-of a location from/to territory's main navigation grid.
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
      [fdmm.consts.CargoRouteGNPrefix.Land] = fdmm.config.gpCache[fdmm.consts.CargoRouteGNPrefix.Land] or {},
      [fdmm.consts.CargoRouteGNPrefix.Train] = fdmm.config.gpCache[fdmm.consts.CargoRouteGNPrefix.Train] or {},
      [fdmm.consts.CargoRouteGNPrefix.Air] = fdmm.config.gpCache[fdmm.consts.CargoRouteGNPrefix.Air] or {},
      [fdmm.consts.CargoRouteGNPrefix.Sea] = fdmm.config.gpCache[fdmm.consts.CargoRouteGNPrefix.Sea] or {}
    }

    function _processGroup(groupName, groupData, routeType)
      local territoryName = fdmm.utils.removeNumericSuffix(fdmm.utils.removeGroupingPrefix(groupName))
      local territory = fdmm.territories.all[territoryName]

      if territory ~= nil then
        local cargoRoute = fdmm.cargoRoutes[territoryName][routeType]
        local groupRoute = mist.getGroupRoute(groupName, false)
        local routeFaction = fdmm.utils.getFaction(string.notEmptyElse(groupData.units[1].unitName, groupData.country))
        local RouteType = routeType:upperFirst()
        local knownPrefixes = table.concatedWith(fdmm.consts.CargoRouteGNPrefix, fdmm.consts.CargoRouteWPRoutePrefix[RouteType])

        -- Scanner for parsing WP list
        local scanMode = nil
        local ScanMode = { Spawn = 'spawn', Linkage = 'linkage', Facility = 'facility', TBD = '_' }
        local name, point, pointList = nil, nil, {}

        function _updateScanner(nextScanMode, nextName)
          if scanMode == ScanMode.TBD and nextScanMode ~= nil and nextScanMode ~= ScanMode.TBD then
            scanMode = nextScanMode
          elseif scanMode ~= nil and scanMode ~= ScanMode.TBD and nextScanMode == ScanMode.TBD then
            nextScanMode = scanMode
          end

          if scanMode ~= nextScanMode or name ~= nextName then
            if scanMode then -- take care of last scan
              if scanMode == ScanMode.Spawn then
                if string.isNotEmpty(routeFaction) and point and pointList then
                  cargoRoute:addSpawnLocation(routeFaction, point, pointList)
                else
                  env.error('Cargo ' .. routeType .. ' routing group \'' .. groupName .. '\' failed to parse spawn route \'' .. (name or '<nil>') .. '\'.')
                end
              elseif scanMode == ScanMode.Linkage then
                if string.isNotEmpty(name) and point and pointList then
                  cargoRoute:addDirectionalLink(name, point, pointList)
                else
                  env.error('Cargo ' .. routeType .. ' routing group \'' .. groupName .. '\' failed to parse linkage route \'' .. (name or '<nil>') .. '\'.')
                end
              elseif scanMode == ScanMode.Facility then
                if string.isNotEmpty(name) and point and pointList then
                  cargoRoute:addFacilityLocation(name, point, pointList)
                else
                  env.error('Cargo ' .. routeType .. ' routing group \'' .. groupName .. '\' failed to parse facility route \'' .. (name or '<nil>') .. '\'.')
                end
              elseif scanMode ~= ScanMode.TBD then
                env.error('Cargo ' .. routeType .. ' routing group \'' .. groupName .. '\' encountered unrecognized scan mode \'' .. (nextScanMode or '<nil>') .. '\'.')
              end

              name, point, pointList = nil, nil, {}
            end

            scanMode = nextScanMode
            name = nextName
          end
        end

        for idx, routePoint in ipairs(groupRoute) do
          if string.isNotEmpty(routePoint.name) and (routePoint.name .. '_') ~= fdmm.consts.CargoRouteGNPrefix[RouteType] then -- only worried about named WPs
            local wpPrefix, wpName, wpSuffix = fdmm.utils.getGroupingComponentsWithSNC(routePoint.name, knownPrefixes, fdmm.consts.CargoRouteWPRouteSuffix)

            if wpPrefix == fdmm.consts.CargoRouteGNPrefix[RouteType] then
              -- WPs /w prefix C[V|T|A|S]RT_
              if wpSuffix == fdmm.consts.CargoRouteWPRouteSuffix.Egress or
                 wpSuffix == fdmm.consts.CargoRouteWPRouteSuffix.Ingress then
                _updateScanner(ScanMode.TBD, wpName)
                table.insert(pointList, fdmm.utils.rposFromRPoint(routePoint))
              elseif wpSuffix == fdmm.consts.CargoRouteWPRouteSuffix.Spawn then
                _updateScanner(ScanMode.Spawn, wpName)
                point = fdmm.utils.rposFromRPoint(routePoint)
              elseif wpSuffix == fdmm.consts.CargoRouteWPRouteSuffix.Linkage then
                _updateScanner(ScanMode.Linkage, wpName)
                point = fdmm.utils.rposFromRPoint(routePoint)
              elseif wpSuffix == fdmm.consts.CargoRouteWPRouteSuffix.Facility then
                _updateScanner(ScanMode.Facility, wpName)
                point = fdmm.utils.rposFromRPoint(routePoint)
              elseif not (string.isEmpty(wpName) and string.isEmpty(wpSuffix)) then -- not a stand-in WP name
                env.error('Cargo ' .. routeType .. ' routing group \'' .. groupName .. '\' unknown WP \'' .. (routePoint.name or '<nil>') .. '\' at WP index ' .. idx .. '.')
              end
            elseif wpPrefix == fdmm.consts.CargoRouteWPRoutePrefix[RouteType].Spawn then
              -- WPs /w prefix C[V|T|A|S]SP_
              if string.isEmpty(wpSuffix) then
                _updateScanner(ScanMode.Spawn, wpName)
                point = fdmm.utils.rposFromRPoint(routePoint)
              elseif wpSuffix == fdmm.consts.CargoRouteWPRouteSuffix.Egress then
                _updateScanner(ScanMode.Spawn, wpName)
                table.insert(pointList, fdmm.utils.rposFromRPoint(routePoint))
              elseif not (string.isEmpty(wpName) and string.isEmpty(wpSuffix)) then -- not a stand-in WP name
                env.error('Cargo ' .. routeType .. ' routing group \'' .. groupName .. '\' unknown spawn WP \'' .. (routePoint.name or '<nil>') .. '\' at WP index ' .. idx .. '.')
              end
            elseif wpPrefix == fdmm.consts.CargoRouteWPRoutePrefix[RouteType].Linkage then
              -- WPs /w prefix C[V|T|A|S]LK_
              if string.isEmpty(wpSuffix) then
                _updateScanner(ScanMode.Linkage, wpName)
                point = fdmm.utils.rposFromRPoint(routePoint)
              elseif wpSuffix == fdmm.consts.CargoRouteWPRouteSuffix.Ingress then
                _updateScanner(ScanMode.Linkage, wpName)
                table.insert(pointList, fdmm.utils.rposFromRPoint(routePoint))
              elseif not (string.isEmpty(wpName) and string.isEmpty(wpSuffix)) then -- not a stand-in WP name
                env.error('Cargo ' .. routeType .. ' routing group \'' .. groupName .. '\' unknown linkage WP \'' .. (routePoint.name or '<nil>') .. '\' at WP index ' .. idx .. '.')
              end
            elseif wpPrefix == fdmm.consts.CargoRouteWPRoutePrefix[RouteType].Facility then
              -- WPs /w prefix C[V|T|A|S]FC_
              if string.isEmpty(wpSuffix) then
                _updateScanner(ScanMode.Facility, wpName)
                point = fdmm.utils.rposFromRPoint(routePoint)
              elseif wpSuffix == fdmm.consts.CargoRouteWPRouteSuffix.Ingress then
                _updateScanner(ScanMode.Facility, wpName)
                table.insert(pointList, fdmm.utils.rposFromRPoint(routePoint))
              elseif not (string.isEmpty(wpName) and string.isEmpty(wpSuffix)) then -- not a stand-in WP name
                env.error('Cargo ' .. routeType .. ' routing group \'' .. groupName .. '\' unknown facility WP \'' .. (routePoint.name or '<nil>') .. '\' at WP index ' .. idx .. '.')
              end
            else
              env.error('Cargo ' .. routeType .. ' routing group \'' .. groupName .. '\' unknown routing WP \'' .. (routePoint.name or '<nil>') .. '\' at WP index ' .. idx .. '.')
            end
          end
        end
        _updateScanner(nil, nil)
      else
        env.error('Cargo ' .. routeType .. ' routing group \'' .. groupName .. '\' failed to find territory with same name.')
      end
    end

    -- Process CargoRouteGNPrefix.Land (CVRT_)
    for groupName, groupData in pairs(routeGroups[fdmm.consts.CargoRouteGNPrefix.Land]) do
      _processGroup(groupName, groupData, fdmm.enums.CargoRouteType.Land)
    end

    -- Process CargoRouteGNPrefix.Train (CTRT_)
    for groupName, groupData in pairs(routeGroups[fdmm.consts.CargoRouteGNPrefix.Train]) do
      _processGroup(groupName, groupData, fdmm.enums.CargoRouteType.Train)
    end

    -- Process CargoRouteGNPrefix.Air (CART_)
    for groupName, groupData in pairs(routeGroups[fdmm.consts.CargoRouteGNPrefix.Air]) do
      _processGroup(groupName, groupData, fdmm.enums.CargoRouteType.Air)
    end

    -- Process CargoRouteGNPrefix.Sea (CSRT_)
    for groupName, groupData in pairs(routeGroups[fdmm.consts.CargoRouteGNPrefix.Sea]) do
      _processGroup(groupName, groupData, fdmm.enums.CargoRouteType.Sea)
    end
  end

end -- FDMM_CargoRoute

env.info("---FDMM_CargoRoute End---")
