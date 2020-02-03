---
-- FDMM Mission Start Module.
-- @module FDMM_MissionStart
env.info('---FDMM_MissionStart Start---')
env.setErrorMessageBoxEnabled(false)

--- FDMM main module.
fdmm = {}

-- Master include listing
require('FDMM_Config')
require('FDMM_Utils')
require('Additions/FDMM_LuaAdditions')
require('Additions/FDMM_MISTAdditions')
require('Additions/FDMM_MOOSEAdditions')
require('Cargo/FDMM_ResourceUnit')
require('Cargo/FDMM_CargoRoute')
require('Territory/FDMM_Territory')
require('Territory/FDMM_Airbase')
require('Territory/FDMM_ArmsPlant')
require('Territory/FDMM_CommandCenter')
require('Territory/FDMM_FARP')
require('Territory/FDMM_OilField')
require('Territory/FDMM_Port')
require('Territory/FDMM_UnitFactory')

do --FDMM_MissionStart

  fdmm.config.createGPCache()
  fdmm.territory.createTerritories()
  fdmm.territory.createFacilities()
  fdmm.cargoRoute.createCargoRoutes()

  fdmm.territory.buildFacilities()

  --fdmm.territory.dumpTerritories()
  --fdmm.territory.landTerritories.Tbilisi:smokeBoundaries(SMOKECOLOR.Blue)
  --fdmm.cargoRoute.dumpCargoRoutes()

  trigger.action.outText('FDMM Started', 10)

end --FDMM_MissionStart

env.info('---FDMM_MissionStart End---')
