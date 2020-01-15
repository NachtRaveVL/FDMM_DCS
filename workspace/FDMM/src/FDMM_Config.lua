---
-- FDMM Config Module.
-- @module FDMM_Config
env.info("---FDMM_Config Start---");

--- FDMM enumerations.
fdmm.enums = {}
--- FDMM constants.
fdmm.consts = {}

do --FDMM_Config

  --- Territory types.
  fdmm.enums.TerritoryType = {
    Land = 'land',
    Sea = 'sea'
  }

  --- Mission user flags.
  fdmm.consts.UserFlags = {
    DebugFlag = '99999'
  }

  --- Territory group name prefixes.
  fdmm.consts.TerritoryPrefix = {
    Define = 'TDEF_',
    Link = 'TLNK_',
    FARP = 'TFRP_'
  }

end --FDMM_Config

env.info("---FDMM_Config End---");
