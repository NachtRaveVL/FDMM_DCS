---
-- FDMM Config Module.
-- @module FDMM_Config
env.info("---FDMM_Config Start---");

--- FDMM enumerations.
fdmm.enums = {}
--- FDMM constants.
fdmm.consts = {}

do --FDMM_Config

    --- Mission user flags.
  fdmm.consts.UserFlags = {
    DebugFlag = '99999'
  }
  
  --- Territory types.
  fdmm.enums.TerritoryType = {
    Land = 'land',
    Sea = 'sea',
    All = 'all'
  }

  --- Territory group name prefixes.
  fdmm.consts.TerritoryPrefix = {
    Define = 'TDEF_',
    Link = 'TLNK_',
    FARP = 'TFRP_'
  }

  --- Cargo route types.
  fdmm.enums.CargoRouteType = {
    Land = 'land',
    Train = 'train',
    Air = 'air',
    Sea = 'sea',
    All = 'all'
  }

  --- Cargo route group name prefixes.
  fdmm.consts.CargoRoutePrefix = {
    Land = 'CVIN_',
    Train = 'CTIN_',
    Air = 'CAIN_',
    Sea = 'CSIN_'
  }

end --FDMM_Config

env.info("---FDMM_Config End---");
