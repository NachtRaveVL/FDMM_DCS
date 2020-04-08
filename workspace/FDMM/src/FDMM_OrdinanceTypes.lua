---
-- FDMM Ordinance Types Module.
-- @module FDMM_OrdinanceTypes
env.info("---FDMM_OrdinanceTypes Start---");

require('Additions/FDMM_LuaAdditions')

--- FDMM equipment types module.
fdmm.ordinanceTypes = {}

do -- FDMM_OrdinanceTypes

  --- Ordinance type table.
  -- A ridiculous structure mapping fdmmOrdinanceTypes to dcsOrdianceTypes.
  -- Dates should be ranged [BeginningYear,EndingYear].
  -- Also contains a lot of categorization that FDMM relies upon.
  -- @note See something wrong? Say something! That way we can fix it.
  -- @type Consts.OrdinanceType
  fdmm.consts.OrdinanceType = {
    Missiles = {
      A2G = {
        IR = {
        },
        Optical = {
        },
        IROptical = {
        },
        GPS = {
        },
        DLOS = {
        },
      },
      A2A = {
        Fox1 = { -- Semi-active RDR
        },
        Fox2 = { -- IR
        },
        Fox3 = { -- Active RDR
        },
      },
      SAM = {
      },
      SSM = {
      },
    },
    Rockets = {
      A2G = {
      },
    },
    AutoCannons = {
      A2M = {
        MainGun = {
        },
        GunPods = {
        },
      },
      A2G = {
        MainGun = {
        },
        GunPods = {
        },
      },
    },
    ECM = {
      Jammer = {
      },
    },
    Rifles = {
      MG = {
      },
      Assault = {
      },
    },
    All = {}, -- resolved on startup processing
    Unavailable = {}, -- resolved on startup processing
    Available = {}, -- resolved on startup processing
    NATOReporting = {}, -- resolved on startup processing
    WTOReporting = {}, -- resolved on startup processing
  }

  fdmm.ordinanceTypes._resKeyFilter = { 'All', 'Unavailable', 'Available', 'NATOReporting', 'WTOReporting',
                                        'ReportNaming', 'ProperNaming' }                      

  function fdmm.ordinanceTypes._isReservedKey(key)
    return string.hasPrefix(key, '_') or table.contains(fdmm.OrdinanceTypes._resKeyFilter, key)
  end

  function fdmm.ordinanceTypes.processEntries()
    -- TODO: me.
  end

  function fdmm.ordinanceTypes.crossRefEntries()
    assert(db, "Missing module: db")
    assert(dbYears, "Missing module: dbYears")
    env.info("FDMM: Cross-referencing ordinances...")

    -- TODO: me.
  end

  function fdmm.ordinanceTypes.createOrdinanceTypeAvailability()
    -- TODO: me.
  end

  function fdmm.ordinanceTypes.saveOrdinanceTypeAvailability()
    -- TODO: me.
  end

  function fdmm.ordinanceTypes.loadOrdinanceTypeAvailability()
    -- TODO: me.
  end

end -- /FDMM_OrdinanceTypes

env.info("---FDMM_OrdinanceTypes End---");
