env.info("---FDMM_Config Start---");

fdmm.config = {}

do --FDMM_Config

  fdmm.config.enums = {}

  fdmm.config.enums.TerritoryType = {
    Land = 1,
    Sea = 2
  }

  fdmm.config.consts = {}

  fdmm.config.consts.TerritoryGroupPrefix = 'TERR_'
  fdmm.config.consts.TerritoryLinkPrefix = 'TLNK_'
  fdmm.config.consts.TerritoryFARPPrefix = 'TFRP_'

end --FDMM_Config

env.info("---FDMM_Config End---");
