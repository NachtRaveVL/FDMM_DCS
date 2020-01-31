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
    Neutral = 'Neutral', -- meant to be un-ownable, usable by any side
    USA = 'USA',
    Russia = 'Russia',
    Georgia = 'Georgia',
    Turkey = 'Turkey',
    Ukraine = 'Ukraine',
    Unused = 'Unused' -- no programatic application
  }

  --- Common route suffixes.
  -- @type Consts.RouteSuffix
  fdmm.consts.RouteSuffix = {
    SpawnPoint = '_SP',
    EgressPoint = '_EP',
    IngressPoint = '_IP'
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

  --- Cargo route location prefixes.
  -- @type Consts.CargoRouteLocPrefix
  fdmm.consts.CargoRouteLocPrefix = {
    Land = {
      Warehouse = 'CVWH_',
      Linkage = 'CVLK_'
    },
    Train = {
      Warehouse = 'CTWH_',
      Linkage = 'CTLK_'
    },
    Air = {
      Warehouse = 'CAWH_',  -- Only used for helicopters (planes must land at Airbases)
      Linkage = 'CALK_' -- Technically never used, but theoretically could be
    },
    Sea = {
      Warehouse = 'CSWH_',
      Linkage = 'CSLK_' -- Technically never used, but theoretically could be
    }
  }

end --FDMM_CargoRoute_Defines

do --FDMM_Config

  --- Creates group prefix cache from initial mission group placements.
  function fdmm.config.createGPCache()
    fdmm.config.gpCache = {}

    for groupName, groupData in pairs(mist.DBs.groupsByName) do
      local prefix = fdmm.utils.getGroupingPrefix(groupName)

      if prefix ~= nil then
        if not fdmm.config.gpCache[prefix] then
          fdmm.config.gpCache[prefix] = {}
        end
        fdmm.config.gpCache[prefix][groupName] = groupData
      end
    end
  end

end --FDMM_Config

env.info("---FDMM_Config End---");
