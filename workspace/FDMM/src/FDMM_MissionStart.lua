---
-- FDMM Mission Start Module.
-- @module FDMM_MissionStart
env.info('---FDMM_MissionStart Start---')
env.setErrorMessageBoxEnabled(false)

--- FDMM main module.
fdmm = {}

require('FDMM_Config')
require('FDMM_MISTAdditions')
require('FDMM_MooseAdditions')
require('FDMM_Utils')
require('FDMM_Territory')
require('FDMM_Port')
require('FDMM_CargoRoute')

do --FDMM_MissionStart

  fdmm.territory.createTerritories()
  --fdmm.territory.dumpTerritories()
  --fdmm.territory.landTerritories.Tblisi:smokeBoundaries(SMOKECOLOR.Blue)

  fdmm.cargoRoute.createCargoRoutes()
  --fdmm.cargoRoute.dumpCargoRoutes()

  trigger.action.outText('FDMM Started', 10)

end --FDMM_MissionStart

env.info('---FDMM_MissionStart End---')
