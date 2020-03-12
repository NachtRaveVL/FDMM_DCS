---
-- FDMM Mission Start Module.
-- @module FDMM_MissionStart
env.info("---FDMM_MissionStart Start---")
env.setErrorMessageBoxEnabled(false)

--- FDMM main module.
fdmm = {}
fdmm_path = fdmm_path or '/Scripts/FDMM/'
fdmm.fullPath = lfs.normpath(lfs.writedir() .. fdmm_path)

fdmm.MapKind = {
  Both = 'Both', Setup = 'Setup', Runable = 'Runable'
}
fdmm.mapKind = fdmm.MapKind.Both -- set per branch
fdmm.RunMode = {
  Release = 'Release', Dev = 'Dev', DevWithPreTests = 'DevWithPreTests', DevWithPostTests = 'DevWithPostTests'
}
fdmm.runMode = fdmm.RunMode.DevWithPostTests -- set per branch

-- Master include listing (these should touch all necessary run files)
require('FDMM_Config')
require('FDMM_Utils')
require('FDMM_UnitTypes')
require('FDMM_RegimentTypes')
require('Additions/FDMM_LuaAdditions')
require('Additions/FDMM_MISTAdditions')
require('Additions/FDMM_MOOSEAdditions')
require('Utilities/FDMM_YearRange')
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

  --- Main mission start function.
  function fdmm.missionStart()
    local message = "FDMM: Starting " .. (fdmm.setup.serverName or "FDMM") .. "..."
    env.info(message)
    trigger.action.outText(message, 10)

    -- Main config setup
    fdmm.config.loadDCSDBIfAble()
    fdmm.config.loadDCSJSONIfAble()

    -- Process unit and regiment type entries.
    fdmm.unitTypes.processEntries()
    fdmm.regimentTypes.processEntries()

    if fdmm.utils.isDevRunMode() then
      -- Run pre-tests before main loads
      if fdmm.runMode == fdmm.RunMode.DevWithPreTests then
        fdmm.config.runTestsScript()
      end

      -- Cross reference unit type entries.
      fdmm.unitTypes.crossRefEntries()
    end

    if fdmm.utils.isSetupMapKind() then
      -- Create groups prefix cache.
      fdmm.config.createGPCache()

      -- Create territories, facilities, routes, etc. from groups placed on map.
      fdmm.territory.createTerritories()
      fdmm.territory.createFacilities()
      fdmm.cargoRoute.createCargoRoutes()

      -- Saves out to disk
      fdmm.territory.saveTerritories()
      fdmm.territory.saveFacilities()
      fdmm.cargoRoute.saveCargoRoutes()

      -- Tears down all group prefix cache setup groups.
      fdmm.config.tearDownGPCache()
    else
      -- Loads from disk
      fdmm.territory.loadTerritories()
      fdmm.territory.loadFacilities()
      fdmm.cargoRoute.loadCargoRoutes()
    end

    -- Builds facilities specified by setup. 
    fdmm.territory.buildFacilities()

    if fdmm.utils.isDevRunMode() then
      -- Optional to uncomment, dumps via env.info() to dcs.log
      --fdmm.unitTypes.dumpUnitReportNames()
      --fdmm.regimentTypes.dumpRegimentYearlyAvailability(fdmm.consts.RegimentType.Caucasus.Ship.USA.Divisions.SixthFleet, 1968, 2020) -- temp
      --fdmm.regimentTypes.dumpRegimentActiveLists(fdmm.consts.RegimentType.Caucasus.Ship.USA.Divisions.SixthFleet)
      --fdmm.territory.dumpTerritories()
      --fdmm.territory.landTerritories.Tbilisi:smokeBoundaries(SMOKECOLOR.Blue)
      --fdmm.cargoRoute.dumpCargoRoutes() -- not yet implemented, might get around to later

      -- Run post-tests after main loads
      if fdmm.runMode == fdmm.RunMode.DevWithPostTests then
        fdmm.config.runTestsScript()
      end
    end

    message = "FDMM: ...Started " .. (fdmm.setup.serverName or "FDMM") .. "!"
    env.info(message)
    trigger.action.outText(message, 10)
  end

  local status,retVal = pcall(fdmm.missionStart, nil)
  if not status then
    local message = "FDMM: Failed to Start " .. (fdmm.setup.serverName or "FDMM") .. "!"
    env.error(message)
    trigger.action.outText(message, 10)
    env.error("FDMM:   Error: " .. tostring(retVal))
  end
end --FDMM_MissionStart

env.info("---FDMM_MissionStart End---")
