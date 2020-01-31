---
-- FDMM Config Module.
-- @module FDMM_Config
env.info("---FDMM_Config Start---");

-- don't change these
fdmm.majorVersion = 0
fdmm.minorVersion = 2
fdmm.build = 1

--- FDMM enumerations.
fdmm.enums = {}
--- FDMM constants.
fdmm.consts = {}
--- FDMM config.
fdmm.config = {}

--- A 2D points array.
-- @type ListVec2
-- @list <DCS#Vec2>

--- A 3D points array.
-- @type ListVec3
-- @list <DCS#Vec3>

--- Routing array.
-- @type ListRoute
-- @list <DCS#Route>

do --FDMM_Common_Defines

  --- Common factions.
  -- @type Enums.Faction
  fdmm.enums.Faction = {
    Red = 'Red',
    Blue = 'Blue',
    Neutral = 'Neutral', -- meant to be un-ownable; usable by any side but unclaimable
    USA = 'USA',
    Russia = 'Russia',
    Georgia = 'Georgia',
    Turkey = 'Turkey',
    Ukraine = 'Ukraine',
    Unused = 'Unused' -- no programatic application
  }

  --- Resource point types.
  -- @type Enums.RPType
  fdmm.enums.RPType = {
    Fuel = 'fuel',
    Arms = 'arms',
    Unit = 'unit'
  }

  --- Resource point amount type.
  -- @type Enums.RPAmountType
  fdmm.enums.RPAmountType = {
    Tons = 'tons',
    Percent = 'percent'
  }

  --- Error codes.
  fdmm.enums.ErrorCodes = {
    Success = 0,
    Failure = 1,
    Cancelled = 2,
    InvalidParam = 3,
    ShouldNotBeReached = 4
  }

  --- Mission user flags.
  -- @type Consts.UserFlags
  fdmm.consts.UserFlags = {
    DebugFlag = '99999'
  }

end --FDMM_Common_Defines

do --FDMM_Territory_Defines

  --- Territory types.
  -- @type Enums.TerritoryType
  fdmm.enums.TerritoryType = {
    Land = 'land',
    Sea = 'sea',
    All = 'all'
  }

  --- Territory group name prefixes.
  -- @type Consts.TerritoryPrefix
  fdmm.consts.TerritoryPrefix = {
    Define = 'TDEF_',
    Link = 'TLNK_',
    FARP = 'TFRP_',
    Port = 'TPRT_'
  }

end --FDMM_Territory_Defines

do --FDMM_CargoRoute_Defines

  --- Cargo route types.
  -- @type Enums.CargoRouteType
  fdmm.enums.CargoRouteType = {
    Land = 'land',
    Train = 'train',
    Air = 'air',
    Sea = 'sea',
    All = 'all'
  }

  --- Cargo route group name prefixes.
  -- @type Consts.CargoRoutePrefix
  fdmm.consts.CargoRoutePrefix = {
    Land = 'CVRT_',
    Train = 'CTRT_',
    Air = 'CART_',
    Sea = 'CSRT_'
  }

  --- Cargo route WP naming prefixes.
  -- @type Consts.CargoRouteWPPrefix
  fdmm.consts.CargoRouteWPPrefix = {
    Land = {
      Spawn = 'CVSP_',
      Warehouse = 'CVWH_',
      Linkage = 'CVLK_'
    },
    Train = {
      Spawn = 'CTSP_',
      Warehouse = 'CTWH_',
      Linkage = 'CTLK_'
    },
    Air = {
      Spawn = 'CASP_',
      Warehouse = 'CAWH_',  -- Only used for helicopters (planes must land at Airbases)
      Linkage = 'CALK_' -- Technically never used, but theoretically could be
    },
    Sea = {
      Spawn = 'CSSP_',
      Warehouse = 'CSWH_',
      Linkage = 'CSLK_' -- Technically never used, but theoretically could be
    }
  }

  --- Cargo route WP naming suffixes.
  -- @type Consts.CargoRouteWPSuffix
  fdmm.consts.CargoRouteWPSuffix = {
    Egress = '_EP',
    Ingress = '_IP',
    Spawn = '_SP',
    Warehouse = '_WH',
    Linkage = '_LK'
  }

end --FDMM_CargoRoute_Defines

do --FDMM_ResourceUnit_Defines

end --FDMM_ResourceUnit_Defines

do --FDMM_Config

  --- Creates group prefix cache from initial mission group placements.
  function fdmm.config.createGPCache()
    fdmm.config.gpCache = {}
    local layeredSplits = { 'FARP_', 'PORT_', 'AIRB_' } -- prefixes that will have layered splits

    for groupName, groupData in pairs(mist.DBs.groupsByName) do
      local name, prefix = fdmm.utils.removeGroupingPrefix(groupName)

      if prefix ~= nil then
        if not fdmm.config.gpCache[prefix] then
          fdmm.config.gpCache[prefix] = {}
        end

        if table.contains(layeredSplits, prefix) then -- handle layered splitting
          local uPos = string.find(name, '_')

          if uPos ~= nil then
            local subName = name:sub(1, uPos - 1)

            if not fdmm.config.gpCache[prefix][subName] then
              fdmm.config.gpCache[prefix][subName] = {}
            end
            fdmm.config.gpCache[prefix][subName][groupName] = groupData
          else -- else put in all category specified by an _
            if not fdmm.config.gpCache[prefix]['_'] then
              fdmm.config.gpCache[prefix]['_'] = {}
            end
            fdmm.config.gpCache[prefix]['_'][groupName] = groupData
          end
        else -- else standard prefix split
          fdmm.config.gpCache[prefix][groupName] = groupData
        end
      end
    end
  end

end --FDMM_Config

env.info("---FDMM_Config End---");
