-- FDMM Server Setup Script
-- Please edit this script to your liking to control your FDMM installation.

-- Server name, visible to players connecting.
-- (not yet implemented)
fdmm.setup.serverName = "FDMM Server"

-- If MOTD text is shown to players after joining server.
-- (not yet implemented)
fdmm.setup.useMOTD = true

-- Loads DCS's Database module, allowing cross-referencing checks and unit technical
-- data to be imported from DCS fresh, not from packaged values.
-- NOTE: Requires sanitization of 'require' in MissionScripting to be commented out,
--       i.e. comment out line "require = nil" in <DCSWorldMainFolder>/Scripts/MissionScripting.lua
-- (not yet implemented)
fdmm.setup.loadDB = true

-- What year of technology the server should allow usage of, up to and including.
-- Also used to determine what the initial start year should be on map reset, what
-- era of weapons should be set, etc.
-- (not yet implemented)
fdmm.setup.techYear = 1991

-- What GMT offset should be used to determine time-of-day. May specify a specific
-- number, such as -8 for US-PST, 4 for Georgian-ST, etc., or may use "FromMap" to load
-- specifically from theater Map location (e.g. Caucasus = 4, Nevada = -7, etc.).
-- (not yet implemented)
fdmm.setup.gmtOffset = "FromMap"

-- How many in-real-life days must pass before the tech year is incremented.
-- This just allows better units to become available as the map is played.
-- (not yet implemented)
fdmm.setup.irlDaysPerTechYear = 14

-- How many in-real-life hours must pass before the game day is incremented, and a
-- night sequence passes by. This adjusts how frequent night sequences occur.
-- (not yet implemented)
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
--       to be honored as the game progresses.
-- (not yet implemented)
fdmm.setup.movingUnitsCap = 128

-- Disabled mission types that the server administrator doesn't want to be made available.
-- For those who think certain missions are cheap, broken, or just not fun (in which
-- case you should let us know so we can try to make them better).
-- (not yet implemented)
fdmm.setup.disabledMissionTypes = {}
