env.info("---FDMM_Config Start---");

fdmm.config = {}

do
  fdmm.config.enums = {}
  
  fdmm.config.enums.TerritoryType = {
    Land = 1,
    Sea = 2
  }
  
  fdmm.config.consts = {}
  
  fdmm.config.consts.TerritoryGroupPrefix = 'TERR_'
  fdmm.config.consts.TerritoryLinkPrefix = 'TLNK_'
  fdmm.config.consts.TerritoryFarpPrefix = 'TFRP_'
end

env.info("---FDMM_Config End---");
