---
-- FDMM Weapon Types Module.
-- @module FDMM_WeaponTypes
env.info("---FDMM_WeaponTypes Start---");

require('Additions/FDMM_LuaAdditions')

--- FDMM weapon types module.
fdmm.weaponTypes = {}

do -- FDMM_WeaponTypes

  --- Weapons type table.
  -- A ridiculous structure mapping fdmmWeaponTypes to dcsWeaponTypes.
  -- Dates should be ranged [BeginningYear,EndingYear].
  -- Also contains a lot of categorization that FDMM relies upon.
  -- @note See something wrong? Say something! That way we can fix it.
  -- @type Consts.WeaponType
  fdmm.consts.WeaponType = {
    Missiles = {
    },
    Rockets = {
    },
    Guns = {
    },
    All = {}, -- resolved on startup processing
    Unavailable = {}, -- resolved on startup processing
    Available = {}, -- resolved on startup processing
    NATOReporting = {}, -- resolved on startup processing
    WTOReporting = {}, -- resolved on startup processing
  }

  fdmm.weaponTypes._resKeyFilter = { 'All', 'Unavailable', 'Available', 'NATOReporting', 'WTOReporting',
                                     'ReportNaming', 'ProperNaming' }                      

  function fdmm.weaponTypes._isReservedKey(key)
    return string.hasPrefix(key, '_') or table.contains(fdmm.weaponTypes._resKeyFilter, key)
  end

  function fdmm.weaponTypes.processEntries()
  end

  function fdmm.weaponTypes.createWeaponTypeAvailability()
    -- TODO: me.
  end

  function fdmm.weaponTypes.saveWeaponTypeAvailability()
    -- TODO: me.
  end

  function fdmm.weaponTypes.saveWeaponTypeAvailability()
    -- TODO: me.
  end

end -- /FDMM_WeaponTypes

env.info("---FDMM_WeaponTypes End---");
