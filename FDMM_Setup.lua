-- FDMM Server Setup Script
-- Please edit this script to your liking to control your FDMM installation.

-- Server name, visible to players connecting.
-- (implementation pending/in progress)
fdmm.setup.serverName = "FDMM Server"

-- If MOTD text is shown to players after joining server.
-- NOTE: The MOTD can be changed by editing FDMM_MOTD.txt in the FDMM install folder.
-- (not yet implemented)
fdmm.setup.useMOTD = true

-- Loads DCS's JSON module, allowing saving of data to and from files.
-- NOTE: Requires sanitization of 'require' and 'io' in MissionScripting to be commented out,
--       i.e. comment out lines "require = nil" and "sanitizeModule('io')" in
--            <DCS[.openbeta]>/Scripts/MissionScripting.lua
-- WARNING: If disabled, you must manually load a JSON module, with :encode(tbl)/:decode(str)
--          methods, otherwise there will be no way to load from / save to JSON data files.
fdmm.setup.loadJSON = true

-- Loads DCS's Database module, allowing cross-referencing checks and unit technical
-- data to be imported from DCS fresh, not from packaged json data files. Can also be
-- set to "OnUpdate", which will load it only in the event that DCS has been updated.
-- NOTE: Requires sanitization of 'require' in MissionScripting to be commented out,
--       i.e. comment out line "require = nil" in <DCS[.openbeta]>/Scripts/MissionScripting.lua
-- WARNING: Enabling this will add some extra startup time, but allows one to update
--          their data tables to the latest DCS versions' values when a new DCS version
--          is detected. Best paired with "OnUpdate"
fdmm.setup.loadDB = true --"OnUpdate"

-- What year (up to and including) of equipment the server should allow usage of.
-- Also used to determine what the initial start year should be on campaign reset, what
-- era of weapons should be set, what regiments and forces are available, etc.
-- Some notable historical war years:
--   War on ISIS: 2014-current          Russo-Georgian War: 2008        Iraq War (Iraqi Freedom): 2003-2011
--   Bosnian War: 1992-1995             Georgian Civil War: 1991-1993   Gulf War (Desert Storm): 1991
--   Gulf War (Desert Shield): 1990-1991        Soviet nuclear false alarm incident: 1983
--   Iran–Iraq War: 1980–1988           Soviet–Afghan War: 1979-1989    Iranian Revolution: 1979-1983
--   Yom Kippur War: 1973               Dhofar Rebellion: 1963–1976     Cuban Missile Crisis: 1962
--   Bay of Pigs Invasion: 1961         Vietnam War: 1955-1975 (US involvement: 1964-1973)
--   Korean War: 1950-1953              Cold War: 1947-1991             Normandy Invasion: 1944
--   Battle of Britain: 1940-1941       World War II: 1939-1945
-- Some notable war movies taking place in year:
--   "Top Gun: Maverick"™: 2020         "Con Air"™: 1997            "Broken Arrow"™: 1996
--   "Behind Enemy Lines"™: 1995        "True Lies"™: 1994          "Hot Shots! Part Deux"™: 1993
--   "Hot Shots!"™: 1991                "Iron Eagle II"™: 1988      "Top Gun"™: 1986
--   "Iron Eagle": 1986                 "Red Dawn"™: 1984           "Firefox"™: 1982
--   "Flight of the Intruder"™: 1972    "Dr. Strangelove"™: 1964    "Memphis Belle"™: 1943
--   "Battle of Britain"™: 1940
-- (implementation pending/in progress)
fdmm.setup.equipmentYear = 1995

-- What GMT offset should be used to determine time-of-day. May specify a specific
-- number, such as 3 for Georgian-ST, -8 for US-PST, etc., or may use "FromMap" to load
-- specifically from theater Map location (e.g. Caucasus = 3, Nevada = -8, etc.), or may
-- use "FromServer" to use GMT relative to server location (aka real-time).
-- NOTE: "FromServer" Requires sanitization of 'os' in MissionScripting to be commented out,
--       i.e. comment out line "sanitizeModule('os')" in <DCS[.openbeta]>/Scripts/MissionScripting.lua
-- (implementation pending/in progress)
fdmm.setup.gmtOffset = "FromMap"

-- How many in-real-life days must pass before the tech year is incremented.
-- This just allows better units to become available as the map is played.
-- (not yet implemented/under proposal)
fdmm.setup.irlDaysPerTechYear = 14

-- How many in-real-life hours must pass before the game day is incremented, and a
-- night sequence passes by. This adjusts how frequent night sequences occur.
-- (not yet implemented/under proposal)
fdmm.setup.irlHoursPerGameDay = 24

-- How many full-on night sequences should be created, for every passed game-day.
-- Night sequences allow cover-of-night operations to commence, where visual
-- detection ranges are reduced and stealthy side missions are made available.
-- (not yet implemented)
fdmm.setup.nightSequencesPerGameDay = 1

-- Upper capacity of moving units that are allowed at once. A higher value means more
-- units can move, which provides a more engaging simulation, but can severly lag DCS
-- servers (a seemingly common gripe of DCS server administrators).
-- NOTE: This is not a strict maximum, but more like a throttling value that attempts
--       to be honored as the game progresses, i.e. critical actions may override this.
-- (not yet implemented)
fdmm.setup.movingUnitsCap = 64

-- Disabled mission types that the server administrator doesn't want to be made available.
-- For those who think certain missions are cheap, broken, or just not fun (in which
-- case you should let us know so we can try to make them better).
-- (not yet implemented)
fdmm.setup.disabledMissionTypes = {}
