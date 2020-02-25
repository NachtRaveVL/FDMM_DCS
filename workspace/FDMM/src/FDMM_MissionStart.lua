---
-- FDMM Mission Start Module.
-- @module FDMM_MissionStart
env.info("---FDMM_MissionStart Start---")
env.setErrorMessageBoxEnabled(false)

--- FDMM main module.
fdmm = {}
fdmm_path = fdmm_path or "/Scripts/FDMM/"
fdmm.fullPath = lfs.normpath(lfs.writedir() .. fdmm_path)

fdmm.MapKind = {
  Both = 'Both', Setup = 'Setup', Runable = 'Runable'
}
fdmm.mapKind = fdmm.MapKind.Both -- may change later

-- Master include listing
require('FDMM_Config')
require('FDMM_Utils')
require('FDMM_UnitTypes')
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
  trigger.action.outText("FDMM Starting...", 10)

  -- Load unit and regiment type entries.
  fdmm.unitTypes.processEntries()
  --fdmm.regimentTypes.processEntries()
  if fdmm_loadDB and db then
    fdmm.unitTypes.crossRefEntries()
  end

  -- Create territories, facilities, routes, etc. from groups placed on map.
  fdmm.config.createGPCache()
  fdmm.territory.createTerritories()
  fdmm.territory.createFacilities()
  fdmm.cargoRoute.createCargoRoutes()

  -- Build facilities as a separate task because it can be a bit much to do. Might wrap in an async task, later.
  -- On the one hand, it's tearing things down in the setup mission.
  -- On the other hand, it's building facilities in the play mission, as their display quantity requested. 
  fdmm.territory.buildFacilities()

  -- Optional to uncomment, dumps to env.info
  --fdmm.territory.dumpTerritories()
  --fdmm.territory.landTerritories.Tbilisi:smokeBoundaries(SMOKECOLOR.Blue)
  --fdmm.cargoRoute.dumpCargoRoutes() -- not yet implemented, might get around to later
  fdmm.unitTypes.dumpUnitReportNames()

  trigger.action.outText("FDMM Started", 10)
end --FDMM_MissionStart

env.info("---FDMM_MissionStart End---")
