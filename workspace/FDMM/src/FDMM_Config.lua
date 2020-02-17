---
-- FDMM Config Module.
-- @module FDMM_Config
env.info("---FDMM_Config Start---");

-- FDMM versioning.
fdmm.majorVersion = 0
fdmm.minorVersion = 2

--- FDMM enumerations.
fdmm.enums = {}
--- FDMM constants.
fdmm.consts = {}
--- FDMM config.
fdmm.config = {}
--- FDMM setup.
fdmm.setup = {}

--- A 2D points array.
-- @type ListVec2
-- @list <DCS#Vec2>

--- A 3D points array.
-- @type ListVec3
-- @list <DCS#Vec3>

--- Routing array.
-- @type ListRoute
-- @list <DCS#Route>

do --FDMM_Common_Defines

  --- Common factions.
  -- @type Enums.Faction
  fdmm.enums.Faction = {
    Red = 'Red',
    Blue = 'Blue',
    Neutral = 'Neutral', -- meant to be un-ownable; usable by any side but unclaimable
    USA = 'USA',
    Russia = 'Russia',
    Georgia = 'Georgia',
    Turkey = 'Turkey',
    Ukraine = 'Ukraine',
    Unused = 'Unused' -- no programatic application
  }

  --- Common error codes.
  -- @type Enums.ErrorCodes
  fdmm.enums.ErrorCodes = {
    Success = 0,
    Failure = 1,
    Incomplete = 2,
    Cancelled = 3,
    InvalidParam = 4,
    ShouldNotBeReached = 5
  }

  --- Mission user flags.
  -- @type Consts.UserFlags
  fdmm.consts.UserFlags = {
    DebugFlag = '99999'
  }

end --FDMM_Common_Defines

do --FDMM_CargoRoute_Defines

  --- Cargo route types.
  -- @type Enums.CargoRouteType
  fdmm.enums.CargoRouteType = {
    Land = 'land',
    Train = 'train',
    Air = 'air',
    Sea = 'sea',
    All = 'all' -- used only in filtering
  }

  --- Cargo route group naming prefixes.
  -- @type Consts.CargoRouteGNPrefix
  fdmm.consts.CargoRouteGNPrefix = {
    Land = 'CVRT_',
    Train = 'CTRT_',
    Air = 'CART_',
    Sea = 'CSRT_'
  }

  --- Cargo route waypoint naming route prefixes.
  -- @type Consts.CargoRouteWPRoutePrefix
  fdmm.consts.CargoRouteWPRoutePrefix = {
    Land = {
      Spawn = 'CVSP_',
      Linkage = 'CVLK_',
      Facility = 'CVFC_'
    },
    Train = {
      Spawn = 'CTSP_',
      Linkage = 'CTLK_',
      Facility = 'CTFC_'
    },
    Air = {
      Spawn = 'CASP_',
      Linkage = 'CALK_', -- ignored by planes, only used by helicopters needing to bypass mountainous terrain
      Facility = 'CAFC_' -- facility must have landing platform available (e.g. helipad for helicopters, runway for planes)
    },
    Sea = {
      Spawn = 'CSSP_',
      Linkage = 'CSLK_', -- available if needed, but often times unused/unnecessary
      Facility = 'CSFC_'
    }
  }

  --- Cargo route waypoint naming route suffixes.
  -- @type Consts.CargoRouteWPRouteSuffix
  fdmm.consts.CargoRouteWPRouteSuffix = {
    Egress = '_EP', -- generally appears after main route point, valid only for spawn points
    Ingress = '_IP', -- generally appears before main route point, valid only for facility and linkage points
    Spawn = '_SP',
    Linkage = '_LK',
    Facility = '_FC'
  }

end --FDMM_CargoRoute_Defines

do --FDMM_Facility_Defines

  --- Facility types.
  -- @type Enums.FacilityType
  fdmm.enums.FacilityType = {
    Airbase = 'airbase',
    ArmsPlant = 'armsPlant',
    CommandCenter = 'commandCenter',
    FARP = 'farp',
    OilField = 'oilField',
    Port = 'port',
    UnitFactory = 'unitFactory',
    All = 'all' -- used only in filtering
  }

end --FDMM_Facility_Defines

do --FDMM_ResourceUnit_Defines

  --- Resource point types.
  -- @type Enums.RPType
  fdmm.enums.RPType = {
    Fuel = 'fuel',
    Arms = 'arms',
    Unit = 'unit'
  }

  --- Resource point amount types.
  -- @type Enums.RPAmountType
  fdmm.enums.RPAmountType = {
    Tons = 'tons', -- specific amount, in tons
    PercentMaxSelf = 'percent_ms', -- percentage of self's maximum RP, values of [0.0, 1.0], /w 0.0->0%, 1.0->100%
    PercentMaxOther = 'percent_mo', -- percentage of other's maximum RP, values of [0.0, 1.0], /w 0.0->0%, 1.0->100%
    PercentCurrSelf = 'percent_cs', -- percentage of self's current RP, values of [0.0, 1.0], /w 0.0->0%, 1.0->100%
    PercentCurrOther = 'percent_co' -- percentage of other's current RP, values of [0.0, 1.0], /w 0.0->0%, 1.0->100%
  }

end --FDMM_ResourceUnit_Defines

do --FDMM_Territory_Defines

  --- Territory types.
  -- @type Enums.TerritoryType
  fdmm.enums.TerritoryType = {
    Land = 'land',
    Sea = 'sea',
    All = 'all' -- used only in filtering
  }

  --- Territory group naming prefixes.
  -- @type Consts.TerritoryGNPrefix
  fdmm.consts.TerritoryGNPrefix = {
    Define = 'TDEF_',
    Linkage = 'TLNK_',
    Facility = 'TFAC_'
  }

  --- Territory waypoint naming facility prefixes.
  -- @type Consts.TerritoryWPFacilityPrefix
  fdmm.consts.TerritoryWPFacilityPrefix = {
    Airbase = 'TARB_',
    ArmsPlant = 'TARM_',
    CommandCenter = 'TCMD_',
    FARP = 'TFRP_',
    OilField = 'TOIL_',
    Port = 'TPRT_',
    UnitFactory = 'TUNT_'
  }

end --FDMM_Territory_Defines

do --FDMM_UnitType_Defines

  fdmm.enums.UnitType = {
    Plane = 'plane',
    Helicopter = 'helicopter',
    Ground = 'ground',
    Train = 'train',
    Ship = 'ship',
    Static = 'static'
  }

end

do --FDMM_Config

  --- Runs user setup script, as modified by user.
  function fdmm.config.runUserSetupScript()
    fdmm.setup = {} -- clear
    dofile(fdmm.fullPath .. "FDMM_Setup.lua")
  end

  --- Creates group prefix cache from initial mission group placements.
  function fdmm.config.createGPCache()
    fdmm.config.gpCache = {}
    local layeredSplits = { 'AIRB_', 'ARMP_', 'CMDC_', 'FARP_', 'OILF_', 'PORT_', 'UNTF_' } -- prefixes that will have layered splits

    for groupName, groupData in pairs(mist.DBs.groupsByName) do
      local name, prefix = fdmm.utils.removeGroupingPrefix(groupName)

      if prefix ~= nil then
        if not fdmm.config.gpCache[prefix] then
          fdmm.config.gpCache[prefix] = {}
        end

        if table.contains(layeredSplits, prefix) then -- handle layered splitting
          local uPos = string.find(name, '_')

          if uPos ~= nil then
            local subName = name:sub(1, uPos - 1)
            if not fdmm.config.gpCache[prefix][subName] then
              fdmm.config.gpCache[prefix][subName] = {}
            end
            fdmm.config.gpCache[prefix][subName][groupName] = groupData
          else -- else put in all category specified by an _
            if not fdmm.config.gpCache[prefix]['_'] then
              fdmm.config.gpCache[prefix]['_'] = {}
            end
            fdmm.config.gpCache[prefix]['_'][groupName] = groupData
          end
        else -- else standard prefix split
          fdmm.config.gpCache[prefix][groupName] = groupData
        end
      end
    end
  end

end --FDMM_Config

fdmm.config.runUserSetupScript()

env.info("---FDMM_Config End---");
