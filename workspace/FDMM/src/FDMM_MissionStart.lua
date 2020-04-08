---
-- FDMM Mission Start Module.
-- @module FDMM_MissionStart
env.info("---FDMM_MissionStart Start---")
env.setErrorMessageBoxEnabled(false)
assert(lfs, "Missing module: lfs") -- did you forget to desanitize MissionScripting.lua?

--- FDMM main module.
fdmm = {}
fdmm_path = fdmm_path or '/Scripts/FDMM/'
fdmm.fullPath = lfs.normpath(lfs.writedir() .. fdmm_path)

fdmm.MapKind = {
  Both = 'Both', Setup = 'Setup', Runnable = 'Runnable'
}
fdmm.mapKind = fdmm.MapKind.Both -- set per branch
fdmm.RunMode = {
  Release = 'Release', Dev = 'Dev', DevWithPreTests = 'DevWithPreTests', DevWithPostTests = 'DevWithPostTests'
}
fdmm.runMode = fdmm.RunMode.DevWithPostTests -- set per branch

-- Master include listing (below should touch all necessary run files)
require('FDMM_Config')
require('FDMM_Utils')
require('FDMM_UnitTypes')
require('FDMM_RegimentTypes')
require('FDMM_OrdinanceTypes')
require('Additions/FDMM_LuaAdditions')
require('Additions/FDMM_MISTAdditions')
require('Additions/FDMM_MOOSEAdditions')
require('Utilities/FDMM_RunLoop')
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

do -- FDMM_MissionStart

  --- Main mission start function.
  function fdmm.missionStart()
    local message = "FDMM: Starting " .. (fdmm.setup.serverName or "FDMM") .. "..."
    env.info(message)
    trigger.action.outText(message, 10)

    -- Main config setup (goes first).
    fdmm.config.loadDCSJSONIfAble()
    fdmm.config.loadConfigOrDefaults()
    fdmm.config.detectVersions()
    fdmm.config.loadDCSDBIfAble()

    -- Process unit, regiment, and equipment type entries.
    fdmm.unitTypes.processEntries()
    fdmm.regimentTypes.processEntries()
    fdmm.ordinanceTypes.processEntries()

    -- Create/save or load type entry data.
    if db and dbYears and fdmm.config.configSettings.updatedDCSDetected then
      fdmm.unitTypes.createUnitTypeAvailability()
      fdmm.unitTypes.saveUnitTypeAvailability()
      fdmm.ordinanceTypes.createOrdinanceTypeAvailability()
      fdmm.ordinanceTypes.saveOrdinanceTypeAvailability()
    else
      fdmm.unitTypes.loadUnitTypeAvailability()
      fdmm.ordinanceTypes.loadOrdinanceTypeAvailability()
    end

    if fdmm.utils.isDevRunMode() then
      -- Run pre-tests before main setup.
      if fdmm.runMode == fdmm.RunMode.DevWithPreTests then
        fdmm.config.runTestsScript()
      end

      -- Cross reference entries.
      if db and dbYears and fdmm.config.configSettings.updatedDCSDetected then
        fdmm.unitTypes.crossRefEntries()
        fdmm.ordinanceTypes.crossRefEntries()
      end
    end

    if fdmm.utils.isSetupMapKind() then
      -- Create groups prefix cache from groups placed on map.
      fdmm.config.createGPCache()

      -- Create territories, facilities, routes, etc.
      fdmm.territory.createTerritories()
      fdmm.territory.createFacilities()
      fdmm.cargoRoute.createCargoRoutes()

      -- Saves out to disk.
      fdmm.territory.saveTerritories()
      fdmm.territory.saveFacilities()
      fdmm.cargoRoute.saveCargoRoutes()

      if fdmm.utils.isRunnableMapKind() then
        -- Tears down all group prefix cache setup groups.
        fdmm.config.tearDownGPCache()
      end
    else
      -- Loads territories, facilities, routes, etc. from disk.
      fdmm.territory.loadTerritories()
      fdmm.territory.loadFacilities()
      fdmm.cargoRoute.loadCargoRoutes()
    end

    if fdmm.utils.isRunnableMapKind() then
      -- Builds facilities.
      fdmm.territory.buildFacilities()
    end

    -- Start run loops.
    fdmm.runLoop.startBaseRunLoops()

    -- Main config wrap-up (goes last).
    fdmm.config.saveConfig()

    if fdmm.utils.isDevRunMode() then
      -- Optional to uncomment, dumps via env.info() to dcs.log.
      --fdmm.unitTypes.dumpUnitReportNames()
      --fdmm.regimentTypes.dumpRegimentYearlyAvailability(fdmm.consts.RegimentType.Caucasus.Navy.USA.SixthFleet, 1968, 2020) -- temp
      --fdmm.regimentTypes.dumpRegimentActiveLists(fdmm.consts.RegimentType.Caucasus.Navy.USA.SixthFleet) -- temp
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

    if not fdmm.utils.isRunnableMapKind() then
      env.warning("FDMM: FDMM will now bail-out... (you may now exit from DCS mission)")
      fdmm.missionStop()
    end
  end

  function fdmm.saveState()
    -- TODO: me.
  end

  function fdmm.loadState()
    -- TODO: me.
  end

  function fdmm.missionStop()
    if fdmm.utils.isRunnableMapKind() then
      fdmm.saveState()
    end
    fdmm.runLoop.stopExtRunLoops()
    fdmm.runLoop.stopBaseRunLoops()
    fdmm = nil
  end

  local status,retVal = pcall(fdmm.missionStart, nil)
  if not status then
    local message = "FDMM: ...Failed to Start " .. (fdmm.setup.serverName or "FDMM") .. "!"
    env.error(message)
    trigger.action.outText(message, 10)
    env.error("FDMM:   Error: " .. tostring(retVal))
  end
end -- /FDMM_MissionStart

env.info("---FDMM_MissionStart End---")
