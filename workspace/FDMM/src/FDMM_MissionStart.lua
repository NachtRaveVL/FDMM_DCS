---
-- FDMM Mission Start Module.
-- @module FDMM_MissionStart
env.info('---FDMM_MissionStart Start---')
env.setErrorMessageBoxEnabled(false)

--- FDMM main module.
fdmm = {}

-- Master include listing
require('FDMM_Config')
require('FDMM_LuaAdditions')
require('FDMM_MISTAdditions')
require('FDMM_MOOSEAdditions')
require('FDMM_Utils')
require('FDMM_Territory')
require('FDMM_Port')
require('FDMM_FARP')
require('FDMM_CargoRoute')

do --FDMM_MissionStart

  fdmm.config.createGPCache()
  fdmm.territory.createTerritories()
  --fdmm.territory.dumpTerritories()
  --fdmm.territory.landTerritories.Tbilisi:smokeBoundaries(SMOKECOLOR.Blue)

  fdmm.cargoRoute.createCargoRoutes()
  --fdmm.cargoRoute.dumpCargoRoutes()

  fdmm.farp.createFARPs()
  --fdmm.farp.dumpFARPs()

  trigger.action.outText('FDMM Started', 10)

end --FDMM_MissionStart

env.info('---FDMM_MissionStart End---')
