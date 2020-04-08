---
-- FDMM Config Module.
-- @module FDMM_Config
env.info("---FDMM_Config Start---");

-- FDMM versioning.
fdmm.majorVersion = 0
fdmm.minorVersion = 0
fdmm.patchVersion = 3

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

do -- FDMM_Common_Defines

  --- Common alliances.
  -- @type Enums.Alliance
  fdmm.enums.Alliance = {
    NATO = 'NATO',
    WTO = 'WTO',
    UN = 'UN',
    Insurgent = 'Insurgent',
    Protestor = 'Protestor',
    ISIS = 'ISIS',
  }

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
    Unused = 'Unused', -- no programatic application
  }

  --- Theater maps.
  -- @type Enums.Theater
  fdmm.enums.Theater = {
    Caucasus = DCSMAP.Caucasus,
    Nevada = DCSMAP.NTTR,
    Normandy = DCSMAP.Normandy,
    PersianGulf = DCSMAP.PersianGulf,
  }

  --- Theater map's GMT offsets.
  -- @type Enums.TheaterGMTOffset
  fdmm.enums.TheaterGMTOffset = {
    [DCSMAP.Caucasus] = 3,
    [DCSMAP.NTTR] = -8,
    [DCSMAP.Normandy] = 1,
    [DCSMAP.PersianGulf] = 4,
  }

  --- Common error codes.
  -- @type Enums.ErrorCode
  fdmm.enums.ErrorCode = {
    Success = 0,
    Failure = 1,
    Incomplete = 2,
    Cancelled = 3,
    InvalidParam = 4,
    ShouldNotBeReached = 5,
  }

  --- Mission user flags.
  -- @type Consts.UserFlag
  fdmm.consts.UserFlag = {
    DebugFlag = '99999',
    TestFlag = '99998',
  }

end -- /FDMM_Common_Defines

do -- FDMM_CargoRoute_Defines

  --- Cargo route types.
  -- @type Enums.CargoRouteType
  fdmm.enums.CargoRouteType = { -- FIXME: Needs values uppercased first. tbd -NR
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
    Sea = 'CSRT_',
  }

  --- Cargo route waypoint naming route prefixes.
  -- @type Consts.CargoRouteWPRoutePrefix
  fdmm.consts.CargoRouteWPRoutePrefix = {
    Land = {
      Spawn = 'CVSP_',
      Linkage = 'CVLK_',
      Facility = 'CVFC_',
    },
    Train = {
      Spawn = 'CTSP_',
      Linkage = 'CTLK_',
      Facility = 'CTFC_',
    },
    Air = {
      Spawn = 'CASP_',
      Linkage = 'CALK_', -- ignored by planes, only used by helicopters needing to bypass mountainous terrain
      Facility = 'CAFC_', -- facility must have landing platform available (e.g. helipad for helicopters, runway for planes)
    },
    Sea = {
      Spawn = 'CSSP_',
      Linkage = 'CSLK_', -- available if needed, but often times unused/unnecessary
      Facility = 'CSFC_',
    },
  }

  --- Cargo route waypoint naming route suffixes.
  -- @type Consts.CargoRouteWPRouteSuffix
  fdmm.consts.CargoRouteWPRouteSuffix = {
    Egress = '_EP', -- generally appears after main route point, valid only for spawn points
    Ingress = '_IP', -- generally appears before main route point, valid only for facility and linkage points
    Spawn = '_SP',
    Linkage = '_LK',
    Facility = '_FC',
  }

end -- /FDMM_CargoRoute_Defines

do -- FDMM_Facility_Defines

  --- Facility types.
  -- @type Enums.FacilityType
  fdmm.enums.FacilityType = { -- FIXME: Needs values uppercased first. tbd -NR
    Airbase = 'airbase',
    ArmsPlant = 'armsPlant',
    CommandCenter = 'commandCenter',
    FARP = 'farp',
    OilField = 'oilField',
    Port = 'port',
    UnitFactory = 'unitFactory',
    All = 'all', -- used only in filtering
  }

end -- /FDMM_Facility_Defines

do -- FDMM_ResourceUnit_Defines

  --- Resource point types.
  -- @type Enums.RPType
  fdmm.enums.RPType = { -- FIXME: Needs values uppercased first. tbd -NR
    Fuel = 'fuel',
    Arms = 'arms',
    Unit = 'unit',
  }

  --- Resource point amount types.
  -- @type Enums.RPAmountType
  fdmm.enums.RPAmountType = {
    Tons = 'tons', -- specific amount, in tons
    PercentMaxSelf = 'percent_ms', -- percentage of self's maximum RP, values of [0.0, 1.0], /w 0.0->0%, 1.0->100%
    PercentMaxOther = 'percent_mo', -- percentage of other's maximum RP, values of [0.0, 1.0], /w 0.0->0%, 1.0->100%
    PercentCurrSelf = 'percent_cs', -- percentage of self's current RP, values of [0.0, 1.0], /w 0.0->0%, 1.0->100%
    PercentCurrOther = 'percent_co', -- percentage of other's current RP, values of [0.0, 1.0], /w 0.0->0%, 1.0->100%
  }

end -- /FDMM_ResourceUnit_Defines

do -- FDMM_Territory_Defines

  --- Territory types.
  -- @type Enums.TerritoryType
  fdmm.enums.TerritoryType = { -- FIXME: Needs values uppercased first. tbd -NR
    Land = 'land',
    Sea = 'sea',
    All = 'all', -- used only in filtering
  }

  --- Territory group naming prefixes.
  -- @type Consts.TerritoryGNPrefix
  fdmm.consts.TerritoryGNPrefix = {
    Define = 'TDEF_',
    Linkage = 'TLNK_',
    Facility = 'TFAC_',
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
    UnitFactory = 'TUNT_',
  }

end -- /FDMM_Territory_Defines

do -- FDMM_UnitType_Defines

  --- Unit types.
  -- @type Enums.UnitType
  fdmm.enums.UnitType = {
    Plane = 'Plane',
    Helicopter = 'Helicopter',
    Ground = 'Ground',
    Train = 'Train',
    Ship = 'Ship',
    Static = 'Static',
  }

  --- Plane unit types.
  -- @type Enums.UnitPlaneType
  fdmm.enums.UnitPlaneType = {
    Fighter = 'Fighter',
    Bomber = 'Bomber',
    Reconnaissance = 'Reconnaissance',
    AWACS = 'AWACS',
    Refueling = 'Refueling',
    Transport = 'Transport',
    Trainer = 'Trainer',
    Civilian = 'Civilian',
  }

  --- Fighter plane unit types.
  -- @type Enums.UnitPlaneFighterType
  fdmm.enums.UnitPlaneFighterType = {
    AirSuperiority = 'AirSuperiority',
    Interceptor = 'Interceptor',
    Strike = 'Strike',
    Multirole = 'Multirole',
    Light = 'Light',    
  }

  --- Bomber plane unit types.
  -- @type Enums.UnitPlaneBomberType
  fdmm.enums.UnitPlaneBomberType = {
    Strategic = 'Strategic',
    Tactical = 'Tactical',
    Attack = 'Attack',
    Stealth = 'Stealth',
    Light = 'Light',
    ASW = 'ASW',
  }

  --- Recon plane unit types.
  -- @type Enums.UnitPlaneReconType
  fdmm.enums.UnitPlaneReconType = {
    Arial = 'Arial',
    Bomber = 'Bomber',
    Drone = 'Drone',
  }

  --- Transport plane unit types.
  -- @type Enums.UnitPlaneTransportType
  fdmm.enums.UnitPlaneTransportType = {
    Strategic = 'Strategic',
    Tactical = 'Tactical',
  }

  --- Trainer plane unit types.
  -- @type Enums.UnitPlaneTrainerType
  fdmm.enums.UnitPlaneTrainerType = {
    Jet = 'Jet',
    Prop = 'Prop',
  }

  --- Civilian plane unit types.
  -- @type Enums.UnitPlaneCivilianType
  fdmm.enums.UnitPlaneCivilianType = {
    Aerobatic = 'Aerobatic',
    Transport = 'Transport',
  }

  --- Helicopter unit types.
  -- @type Enums.UnitHelicopterType
  fdmm.enums.UnitHelicopterType = {
    Attack = 'Attack',
    Reconnaissance = 'Reconnaissance',
    Light = 'Light',
    Transport = 'Transport',
    ASW = 'ASW',
  }

  --- Transport helicopter unit types.
  -- @type Enums.UnitHelicopterTransportType
  fdmm.enums.UnitHelicopterTransportType = {
    Strategic = 'Strategic',
    Tactical = 'Tactical',
    Assault = 'Assault',
  }

  --- Ground unit types.
  -- @type Enums.UnitGroundType
  fdmm.enums.UnitGroundType = {
    Tracked = 'Tracked',
    Wheeled = 'Wheeled',
    Towed = 'Towed',
    Infantry = 'Infantry',
    Fort = 'Fort',
    Civilian = 'Civilian',
    Animal = 'Animal',
  }

  --- Vehicle ground unit types.
  -- Types that apply to both tracked and wheeled vehicles.
  -- @type Enums.UnitGroundVehicleType
  fdmm.enums.UnitGroundVehicleType = {
    HQ = 'HQ',
    MBT = 'MBT',
    SPG = 'SPG',
    ATGM = 'ATGM',
    IFV = 'IFV',
    ARV = 'ARV',
    APC = 'APC',
    SSM = 'SSM',
    MLRS = 'MLRS',
    SPH = 'SPH',
    EWR = 'EWR',
    SAM = 'SAM',
    SPAAG = 'SPAAG',
    Power = 'Power',
    Fire = 'Fire',
    Transport = 'Transport',
    Car = 'Car',
  }

  --- Transport vehicle ground unit types.
  -- @type Enums.UnitGroundVehicleTransportType
  fdmm.enums.UnitGroundVehicleTransportType = {
    Armored = 'Armored',
    Open = 'Open',
    Covered = 'Covered',
    Lubricant = 'Lubricant',
    Fuel = 'Fuel',
  }

  --- Towed ground unit types.
  -- @type Enums.UnitGroundTowedType
  fdmm.enums.UnitGroundTowedType = {
    Drone = 'Drone',
    SSM = 'SSM',
    SAM = 'SAM',
    AAA = 'AAA',
  }

  --- Infantry ground unit types.
  -- @type Enums.UnitGroundInfantryType
  fdmm.enums.UnitGroundInfantryType = {
    Beacon = 'Beacon',
    Mortar = 'Mortar',
    SAM = 'SAM',
    MG = 'MG',
    Rifle = 'Rifle',
    RPG = 'RPG',
  }

  --- Infantry soldier ground unit types.
  -- @type Enums.UnitGroundInfantrySoldierType
  fdmm.enums.UnitGroundInfantrySoldierType = {
    Soldier = 'Soldier',
    Insurgent = 'Insurgent',
    Paratrooper = 'Paratrooper',
  }

  --- Civilian ground unit types.
  -- @type Enums.UnitGroundCivilianType
  fdmm.enums.UnitGroundCivilianType = {
    Trailer = 'Trailer',
    Fire = 'Fire',
    Transport = 'Transport',
    Bus = 'Bus',
    Car = 'Car',
  }

  --- Civilian transport ground unit types.
  -- @type Enums.UnitGroundCivilianTransportType
  fdmm.enums.UnitGroundCivilianTransportType = {
    Open = 'Open',
    Covered = 'Covered',
  }

  --- Civilian bus ground unit types.
  -- @type Enums.UnitGroundCivilianBusType
  fdmm.enums.UnitGroundCivilianBusType = {
    Double = 'Double',
    Single = 'Single',
  }

  --- SSM ground unit roles.
  -- @type Enums.UnitGroundSSMRole
  fdmm.enums.UnitGroundSSMRole = {
    SearchRadar = 'SearchRadar',
    Launcher = 'Launcher',
  }

  --- MLRS ground unit roles.
  -- @type Enums.UnitGroundMLRSRole
  fdmm.enums.UnitGroundMLRSRole = {
    FireControl = 'FireControl',
    Launcher = 'Launcher',
  }

  --- SAM ground unit roles.
  -- @type Enums.UnitGroundVehicleSAMRole
  fdmm.enums.UnitGroundSAMRole = {
    HQ = 'HQ',
    Power = 'Power',
    SearchRadar = 'SearchRadar',
    SearchTrackRadar = 'SearchTrackRadar',
    TrackRadar = 'TrackRadar',
    ContWaveAcqRadar = 'ContWaveAcqRadar',
    TrackOptical = 'TrackOptical',
    RadarArray = 'RadarArray',
    DataProcessing = 'DataProcessing',
    Loader = 'Loader',
    Launcher = 'Launcher',
    MasterLauncher = 'MasterLauncher',
    SlaveLauncher = 'SlaveLauncher',
  }

  --- Infantry SAM ground unit roles.
  -- @type Enums.UnitGroundInfantrySAMRole
  fdmm.enums.UnitGroundInfantrySAMRole = {
    Comm = 'Comm',
    Launcher = 'Launcher',
  }

  --- AAA ground unit roles.
  -- @type Enums.UnitGroundAAARole
  fdmm.enums.UnitGroundAAARole = {
    Fortified = 'Fortified',
    Emplacement = 'Emplacement',
  }

  --- Drone ground unit roles.
  -- @type Enums.UnitGroundDroneRole
  fdmm.enums.UnitGroundDroneRole = {
    HQ = 'HQ',
    Repeater = 'Repeater',
  }

  --- Train unit types.
  -- @type Enums.UnitTrainType
  fdmm.enums.UnitTrainType = {
    Transport = 'Transport',
    Civilian = 'Civilian',
  }

  --- Train car unit types.
  -- @type Enums.UnitTrainCarType
  fdmm.enums.UnitTrainCarType = {
    Locomotive = 'Locomotive',
    Wagon = 'Wagon',
  }

  --- Ship unit types.
  -- @type Enums.UnitShipType
  fdmm.enums.UnitShipType = {
    Carrier = 'Carrier',
    HeliCarrier = 'HeliCarrier', -- amphibious assault ship
    BattleCruiser = 'BattleCruiser',
    Cruiser = 'Cruiser',
    Destroyer = 'Destroyer',
    Frigate = 'Frigate',
    Corvette = 'Corvette',
    Submarine = 'Submarine',
    Gunboat = 'Gunboat',
    Transport = 'Transport',
    Civilian = 'Civilian',
  }

  --- Transport ship unit types.
  -- @type Enums.UnitShipTransportType
  fdmm.enums.UnitShipTransportType = {
    BulkCargo = 'BulkCargo',
    ISOCargo = 'ISOCargo',
    Refueler = 'Refueler',
  }

  --- Static unit types.
  -- @type Enums.UnitStaticType
  fdmm.enums.UnitStaticType = {
    Airbase = 'Airbase',
    Barrier = 'Barrier',
    Cargo = 'Cargo',
    Effect = 'Effect',
    Factory = 'Factory',
    FARP = 'FARP',
    Fort = 'Fort',
    Marker = 'Marker',
    OilField = 'OilField',
    Railway = 'Railway',
    SeaShelf = 'SeaShelf',
    Telecom = 'Telecom',
    Warehouse = 'Warehouse',
    Civilian = 'Civilian',
    Plane = 'Plane',
    Helicopter = 'Helicopter',
    Ground = 'Ground',
    Train = 'Train',
    Ship = 'Ship',
  }

end

do -- FDMM_Config

  --- Configuration settings storage table.
  -- Config values table that are saved out to and loaded from a json data file, allowing server config settings to be
  -- saved between runs.
  fdmm.config.configSettings = {
    _tableVer = 1, -- increment when contents changed
    updatedDCSDetected = false,
    lastDCSVersionSeen = nil,
    updatedFDMMDetected = false,
    lastFDMMVersionSeen = nil
  }

  --- Runs user setup script, as modified by user.
  function fdmm.config.runUserSetupScript()
    -- Note: Ran directly after config include, so no access to Utils, etc.
    env.info("FDDM: Running user setup script...")
    fdmm.setup = {} -- clear
    local status,retVal = pcall(dofile, fdmm.fullPath .. 'FDMM_Setup.lua')
    if status then -- validate user input
      fdmm.setup.equipmentYear = math.floor(math.max(1900, math.min(9999, fdmm.setup.equipmentYear)))
      if fdmm.setup.gmtOffset == "FromMap" then
        fdmm.setup.gmtOffset = fdmm.enums.TheaterGMTOffset[env.mission.theatre]
      elseif fdmm.setup.gmtOffset == "FromServer" then
        assert(os, "Missing module: os")
        local now = os.time()
        fdmm.setup.gmtOffset = os.difftime(now, os.time(os.date("!*t", now))) / (60 * 60)
      end
    else
      env.error("** FDMM_Setup.lua failed to load properly. Check for any syntax errors. **")
    end
  end

  --- Runs tests script from testing folder.
  function fdmm.config.runTestsScript()
    env.info("FDDM: Running tests script...")
    if not fdmm.testsPath then
      fdmm.fullTestsPath = lfs.normpath(fdmm.fullPath .. 'workspace/FDMM/tests/')
    end
    local status,retVal = pcall(dofile, fdmm.fullTestsPath .. 'FDMMTEST_TestsScript.lua')
    if not status then
      env.error("** FDMM tests script failure. **")
    end
  end

  --- Detects various version updates from previous run.
  function fdmm.config.detectVersions()
    env.info("FDDM: Detecting versions...")

    local dcsVersion = fdmm.utils.getDCSVersion()
    fdmm.config.configSettings.updatedDCSDetected = fdmm.config.configSettings.lastDCSVersionSeen == nil or
                                            fdmm.config.configSettings.lastDCSVersionSeen ~= dcsVersion
    fdmm.config.configSettings.lastDCSVersionSeen = dcsVersion
    if fdmm.config.configSettings.updatedDCSDetected then
      env.info("FDMM:   ...New DCS version detected: v" .. dcsVersion)
    end

    local fdmmVersion = fdmm.utils.getFDMMVersion()
    fdmm.config.configSettings.updatedFDMMDetected = fdmm.config.configSettings.lastFDMMVersionSeen == nil or
                                             fdmm.config.configSettings.lastFDMMVersionSeen ~= fdmmVersion
    fdmm.config.configSettings.lastFDMMVersionSeen = fdmmVersion
    if fdmm.config.configSettings.updatedFDMMDetected then
      env.info("FDMM:   ...New FDMM version detected: v" .. fdmmVersion)
    end

    -- Modify setup vars that are defined as "OnUpdate"
    local updateDetected = fdmm.config.configSettings.updatedDCSDetected or
                           fdmm.config.configSettings.updatedFDMMDetected
    for k,v in pairs(fdmm.setup) do
      if v == "OnUpdate" then
        fdmm.setup[k] = updateDetected
      end
    end
  end

  --- Attempts to load the DCS DB module.
  function fdmm.config.loadDCSDBIfAble()
    if not db and fdmm.setup.loadDB == true then
      env.info("FDDM: Loading DCS DB...")
      __DCS_VERSION__ = fdmm.utils.getDCSVersion()
      for attempt = 1,3 do
        -- First call usually fails, second call is usually fine.
        local status,retVal = pcall(require,'./Scripts/Database/db_scan')
        if status then break end
      end
      __DCS_VERSION__ = nil
    end
  end

  --- Attempts to load the DCS JSON module.
  function fdmm.config.loadDCSJSONIfAble()
    if not JSON and fdmm.setup.loadJSON == true then
      env.info("FDDM: Loading DCS JSON...")
      local status,retVal = pcall(require,'./Scripts/JSON')
      if status then JSON = retVal end
    end
  end

  --- Saves Config to disk.
  function fdmm.config.saveConfig()
    env.info("FDDM: Saving Config...")
    local configFilename = fdmm.fullPath .. "data/ConfigSettings.json"
    fdmm.utils.encodeToJSONFile(fdmm.config.configSettings, configFilename)
  end

  --- Loads Config from disk, else uses already existing default values.
  function fdmm.config.loadConfigOrDefaults()
    env.info("FDDM: Loading Config (or defaults)...")
    local configFilename = fdmm.fullPath .. "data/ConfigSettings.json"
    local status,diskConfig = pcall(fdmm.utils.decodeFromJSONFile, configFilename)
    if status and diskConfig then
      local currVer = fdmm.config.configSettings._tableVer
      if currVer == diskConfig._tableVer then
        fdmm.config.configSettings = diskConfig
      else
        env.info("FDDM:   ...Updating config to v" .. currVer .. ".")
        -- Put any necessary update code here.        
        table.concatWith(fdmm.config.configSettings, diskConfig)

        fdmm.config.configSettings._tableVer = currVer
      end
    else
      env.info("FDDM:   ...Config not found, using defaults.")
    end
  end

  --- Creates group prefix cache from initial mission group placements.
  function fdmm.config.createGPCache()
    env.info("FDDM: Creating GP cache...")
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

  --- Tears down any group prefix setup groups used in FDMM setup.
  function fdmm.config.tearDownGPCache()
    env.info("FDDM: Tearing down GP cache...")
    -- TODO: me.
  end

end -- /FDMM_Config

fdmm.config.runUserSetupScript()

env.info("---FDMM_Config End---");
