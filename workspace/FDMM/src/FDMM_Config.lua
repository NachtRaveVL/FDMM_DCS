---
-- FDMM Config Module.
-- @module FDMM_Config
env.info("---FDMM_Config Start---");

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

do --FDMM_Config

  --- Mission user flags.
  -- @type Consts.UserFlags
  fdmm.consts.UserFlags = {
    DebugFlag = '99999'
  }

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
    FARP = 'TFRP_'
  }

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
    Land = 'CVIN_',
    Train = 'CTIN_',
    Air = 'CAIN_',
    Sea = 'CSIN_'
  }

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
