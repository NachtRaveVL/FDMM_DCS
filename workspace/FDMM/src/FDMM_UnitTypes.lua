---
-- FDMM Unit Types Module.
-- @module FDMM_UnitTypes
env.info("---FDMM_UnitTypes Start---");

require('Additions/FDMM_LuaAdditions')

--- FDMM unit types module.
fdmm.unitTypes = {}

do -- FDMM_UnitTypes

  --- Unit type table.
  -- A ridiculous structure mapping fdmmUnitTypes to dcsUnitTypes.
  -- Dates should be ranged [BeginningYear,EndingYear].
  -- Also contains a lot of categorization that FDMM relies upon.
  -- @note See something wrong? Say something! That way we can fix it.
  -- @type Consts.UnitType
  fdmm.consts.UnitType = {
    Plane = {
      Fighter = {
        AirSuperiority = {
          F14A = 'F-14A', F14B = 'F-14B',
          F15C = 'F-15C', F15E = 'F-15E',
          F16A = 'F-16A', F16Cb50 = 'F-16C bl.50', F16CMb50 = 'F-16C_50', F16Cb52d = 'F-16C bl.52d',
          J11A = 'J-11A',
          MiG29A = 'MiG-29A', MiG29G = 'MiG-29G', MiG29S = 'MiG-29S',
          Su27 = 'Su-27',
          Su33 = 'Su-33',
        },
        Interceptor = {
          F14A = 'F-14A', F14B = 'F-14B',
          F4E = 'F-4E',
          MiG21b = 'MiG-21Bis',
          MiG25PD = 'MiG-25PD',
          MiG31 = 'MiG-31',
        },
        Strike = {
          AJS37 = 'AJS37',
          F4E = 'F-4E',
          FA18A = 'F/A-18A', FA18C = 'F/A-18C', FA18Cl20 = 'FA-18C_hornet',
          Su17M4 = 'Su-17M4',
          Su34 = 'Su-34',
          TornadoGR4 = 'Tornado GR4', TornadoIDS = 'Tornado IDS',
        },
        Multirole = {
          AJS37 = 'AJS37',
          F4E = 'F-4E',
          F14A = 'F-14A', F14B = 'F-14B',
          F15C = 'F-15C', F15E = 'F-15E',
          F16A = 'F-16A', F16Cb50 = 'F-16C bl.50', F16CMb50 = 'F-16C_50', F16Cb52d = 'F-16C bl.52d',
          FA18A = 'F/A-18A', FA18C = 'F/A-18C', FA18Cl20 = 'FA-18C_hornet',
          J11A = 'J-11A', JF17 = 'JF-17',
          M2000C = 'M-2000C', M20005 = 'Mirage 2000-5',
          MiG21b = 'MiG-21Bis',
          MiG23MLD = 'MiG-23MLD',
          MiG29A = 'MiG-29A', MiG29G = 'MiG-29G', MiG29K = 'MiG-29K', MiG29S = 'MiG-29S',
          Su27 = 'Su-27',
          Su30 = 'Su-30',
          Su33 = 'Su-33',
          TornadoGR4 = 'Tornado GR4', TornadoIDS = 'Tornado IDS',
        },
        Light = {
          F5E = 'F-5E', F5E3 = 'F-5E-3',
          F86F = 'F-86F Sabre',
          MiG15b = 'MiG-15bis',
          MiG19P = 'MiG-19P',
        },
      },
      Bomber = {
        Strategic = {
          B1B = 'B-1B',
          B52H = 'B-52H',
          Tu95MS = 'Tu-95MS',
          Tu160 = 'Tu-160',
        },
        Tactical = {
          F111F = 'F-111F',
          Tu22M3 = 'Tu-22M3',
        },
        Attack = {
          A10A = 'A-10A', A10C = 'A-10C',
          AV8BNA = 'AV8BNA',
          MiG27K = 'MiG-27K',
          Su24M = 'Su-24M',
          Su25 = 'Su-25', Su25T = 'Su-25T', Su25TM = 'Su-25TM',
        },
        Stealth = {
          F117A = 'F-117A',
        },
        Light = {
          C101CC = 'C-101CC',
          L39ZA = 'L-39ZA',
        },
        ASW = {
          S3B = 'S-3B',
          Tu142 = 'Tu-142',
        },
      },
      Reconnaissance = {
        Arial = {
          An30M = 'An-30M',
          Tu142 = 'Tu-142',
        },
        Bomber = {
          MiG25RBT = 'MiG-25RBT',
          Su24MR = 'Su-24MR',
        },
        Drone = {
          MQ9 = 'MQ-9 Reaper',
          RQ1A = 'RQ-1A Predator',
        },
      },
      AWACS = {
        A50 = 'A-50',
        E2C = 'E-2C',
        E3A = 'E-3A',
        KJ2000 = 'KJ-2000',
      },
      Refueling = {
        IL78M = 'IL-78M',
        KC130 = 'KC130',
        KC135 = 'KC-135', KC135MPRS = 'KC135MPRS',
        S3BTanker = 'S-3B Tanker',
      },
      Transport = {
        Strategic = {
          C17A = 'C-17A',
          IL76MD = 'IL-76MD',
        },
        Tactical = {
          An26B = 'An-26B',
          C130 = 'C-130',
        },
      },
      Trainer = {
        Jet = {
          C101EB = 'C-101EB',
          F16AMLU = 'F-16A MLU',
          HawkT1A = 'Hawk',
          L39C = 'L-39C',
        },
        Prop = {
          TF51D = 'TF-51D',
          Yak52 = 'Yak-52',
        },
      },
      Civilian = {
        Aerobatic = {
         CEII = 'Christen Eagle II',
        },
        Transport = {
          Yak40 = 'Yak-40',
        },
      },
      All = {}, -- resolved on startup processing
      CarrierBorne = { -- planes able to be spawned on ships
        AV8BNA = 'AV8BNA',
        E2C = 'E-2C',
        F4E = 'F-4E',
        FA18A = 'F/A-18A', FA18C = 'F/A-18C', FA18Cl20 = 'FA-18C_hornet',
        MiG29K = 'MiG-29K',
        S3B = 'S-3B', S3BTanker = 'S-3B Tanker',
        Su33 = 'Su-33',
      },
      PlayerControllable = { -- planes that players can fly
        A10A = 'A-10A', A10C = 'A-10C',
        AJS37 = 'AJS37',
        AV8BNA = 'AV8BNA',
        F14B = 'F-14B', F15C = 'F-15C', F16CMb50 = 'F-16C_50', FA18Cl20 = 'FA-18C_hornet',
        F5E3 = 'F-5E-3', F86F = 'F-86F Sabre',
        JF17 = 'JF-17',
        M2000C = 'M-2000C',
        MiG15b = 'MiG-15bis',
        MiG19P = 'MiG-19P',
        MiG21b = 'MiG-21Bis',
        MiG29A = 'MiG-29A', MiG29G = 'MiG-29G', MiG29S = 'MiG-29S',
        Su25 = 'Su-25', Su25T = 'Su-25T',
        Su27 = 'Su-27',
        Su33 = 'Su-33',
        C101CC = 'C-101CC', C101EB = 'C-101EB',
        HawkT1A = 'Hawk',
        L39C = 'L-39C', L39ZA = 'L-39ZA',
        TF51D = 'TF-51D',
        Yak52 = 'Yak-52',
        CEII = 'Christen Eagle II',
      },
      Unavailable = { -- planes in the DB tables, but not spawnable
        F111F = 'F-111F',
        MiG29K = 'MiG-29K',
      },
      NATOReporting = {
        ['AV8BNA'] = ':(N/A)',
        ['A-50'] = ':\'Mainstay\'',
        ['An-26B'] = ':\'Curl\'',
        ['An-30M'] = ':\'Clank\'',
        ['IL-76MD'] = ':\'Candid\'',
        ['IL-78M'] = ':\'Midas\'',
        ['J-11A'] = ':\'Flanker-L\'',
        ['KJ-2000'] = ':\'Mainring\'',
        ['MiG-15bis'] = ':\'Fagot\'',
        ['MiG-19P'] = ':\'Farmer-B\'',
        ['MiG-21Bis'] = ':\'Fishbed-L/N\'',
        ['MiG-23MLD'] = ':\'Flogger-K\'',
        ['MiG-25RBT'] = ':\'Foxbat-B\'', ['MiG-25PD'] = ':\'Foxbat-E\'',
        ['MiG-27K'] = ':\'Flogger-J2\'',
        ['MiG-29A'] = ':\'Fulcrum-A\'', ['MiG-29K'] = ':\'Fulcrum-D\'', ['MiG-29S'] = ':\'Fulcrum-C\'',
        ['MiG-31'] = ':\'Foxhound\'',
        ['Su-17M4'] = ':\'Fitter-K\'',
        ['Su-24M'] = ':\'Fencer-D\'', ['Su-24MR'] = ':\'Fencer-E\'',
        ['Su-25'] = ':\'Frogfoot\'', ['Su-25T'] = ':\'Frogfoot\'', ['Su-25TM'] = ':\'Frogfoot\'',
        ['Su-27'] = ':\'Flanker-B\'', ['Su-30'] = ':\'Flanker-C\'', ['Su-33'] = ':\'Flanker-D\'',
        ['Su-34'] = ':\'Fullback\'',
        ['Tu-22M3'] = ':\'Backfire-C\'',
        ['Tu-95MS'] = ':\'Bear-H\'',
        ['Tu-142'] = ':\'Bear-F/J\'',
        ['Tu-160'] = ':\'Blackjack\'',
        ['Yak-40'] = ':\'Codling\'',
      },
      WTOReporting = {
        ['AV8BNA'] = ':(N/A)',
      },
      ReportNaming = {
        ['AJS37'] = 'AJS 37',
        ['AV8BNA'] = 'AV-8B',
        ['B-1B'] = 'B-1B',
        ['F-16C_50'] = 'F-16CM bl.50',
        ['FA-18C_hornet'] = 'F/A-18C l.20',
        ['F-86F Sabre'] = 'F-86F',
        ['KC130'] = 'KC-130',
        ['KC135MPRS'] = 'KC-135 MPRS',
        ['Hawk'] = 'Hawk T1A',
        ['M-2000C'] = 'Mirage 2000C',
        ['MiG-21Bis'] = 'MiG-21bis',
        ['MQ-9 Reaper'] = 'MQ-9',
        ['RQ-1A Predator'] = 'RQ-1A',
      },
      ProperNaming = {
        ['A-10A'] = 'Thunderbolt II', ['A-10C'] = 'Thunderbolt II',
        ['AJS37'] = 'Viggen',
        ['AV8BNA'] = 'Harrier II',
        ['B-1B'] = 'Lancer',
        ['B-52H'] = 'Stratofortress',
        ['C-101CC'] = 'Aviojet', ['C-101EB'] = 'Aviojet',
        ['C-17A'] = 'Globemaster III',
        ['C-130'] = 'Hercules',
        ['E-2C'] = 'Hawkeye',
        ['E-3A'] = 'Sentry',
        ['F-4E'] = 'Phantom II',
        ['F-5E'] = 'Tiger II', ['F-5E-3'] = 'Tiger II',
        ['F-14A'] = 'Tomcat', ['F-14B'] = 'Tomcat',
        ['F-15C'] = 'Eagle', ['F-15E'] = 'Strike Eagle',
        ['F-16A'] = 'Fighting Falcon', ['F-16A MLU'] = 'Fighting Falcon',
        ['F-16C bl.50'] = 'Fighting Falcon', ['F-16C_50'] = 'Fighting Falcon', ['F-16C bl.52d'] = 'Fighting Falcon',
        ['F/A-18A'] = 'Hornet', ['F/A-18C'] = 'Hornet', ['FA-18C_hornet'] = 'Hornet',
        ['F-86F Sabre'] = 'Sabre',
        ['F-111F'] = 'Aardvark',
        ['F-117A'] = 'Nighthawk',
        ['KC-135'] = 'Stratotanker', ['KC135MPRS'] = 'Stratotanker',
        ['L-39C'] = 'Albatros', ['L-39ZA'] = 'Albatros',
        ['M-2000C'] = 'Chasseur',
        ['MQ-9 Reaper'] = 'Reaper',
        ['RQ-1A Predator'] = 'Predator',
        ['S-3B'] = 'Viking', ['S-3B Tanker'] = 'Viking',
        ['TF-51D'] = 'Mustang',
      },
      Nicknaming = {
        ['A-10A'] = 'Warthog', ['A-10C'] = 'Warthog',
        ['F-16A'] = 'Viper', ['F-16A MLU'] = 'Viper',
        ['F-16C bl.50'] = 'Viper', ['F-16C_50'] = 'Viper', ['F-16C bl.52d'] = 'Viper',
      },
    },
    Helicopter = {
      Attack = {
        AH1W = 'AH-1W',
        AH64A = 'AH-64A', AH64D = 'AH-64D',
        Ka50 = 'Ka-50',
        Ka52 = 'Ka-52',
        Mi24V = 'Mi-24V',
        Mi28N = 'Mi-28N',
      },
      Reconnaissance = {
        OH58D = 'OH-58D',
        SA342L = 'SA342L', SA342M = 'SA342M', SA342Mg = 'SA342Minigun', SA342Ms = 'SA342Mistral',
      },
      Light = {
        SA342L = 'SA342L', SA342M = 'SA342M', SA342Mg = 'SA342Minigun', SA342Ms = 'SA342Mistral',
        UH1H = 'UH-1H',
      },
      Transport = {
        Strategic = {
          CH47D = 'CH-47D',
          CH53E = 'CH-53E',
          Mi26 = 'Mi-26',
        },
        Tactical = {
          Mi8MTV2 = 'Mi-8MT',
          SH3W = 'SH-3W',
          SH60B = 'SH-60B',
          UH1H = 'UH-1H',
          UH60A = 'UH-60A',
        },
        Assault = {
          Mi24V = 'Mi-24V',
          SH60B = 'SH-60B',
          UH1H = 'UH-1H',
          UH60A = 'UH-60A',
        },
      },
      ASW = {
        Ka27 = 'Ka-27',
        SH3W = 'SH-3W',
        SH60B = 'SH-60B',
      },
      All = {}, -- resolved on startup processing
      CarrierBorne = { -- helicopters able to be spawned on ship
        AH1W = 'AH-1W',
        CH53E = 'CH-53E',
        Ka27 = 'Ka-27',
        SH3W = 'SH-3W',
        SH60B = 'SH-60B',
      },
      PlayerControllable = { -- helicopters that players can fly
        Ka50 = 'Ka-50',
        SA342L = 'SA342L', SA342M = 'SA342M', SA342Mg = 'SA342Minigun', SA342Ms = 'SA342Mistral',
        UH1H = 'UH-1H',
        Mi8MTV2 = 'Mi-8MT',
      },
      Unavailable = { -- helicopters in the DB tables, but not spawnable
        Ka52 = 'Ka-52',
        SH3W = 'SH-3W',
      },
      NATOReporting = {
        ['Ka-27'] = ':\'Helix\'',
        ['Ka-50'] = ':\'Hokum-A\'',
        ['Ka-52'] = ':\'Hokum-B\'',
        ['Mi-8MT'] = ':\'Hip\'',
        ['Mi-24V'] = ':\'Hind-E\'',
        ['Mi-26'] = ':\'Halo\'',
        ['Mi-28N'] = ':\'Havoc\'',
      },
      WTOReporting = {
      },
      ReportNaming = {
        ['SA342L'] = 'SA 342L',
        ['SA342M'] = 'SA 342M', 
        ['SA342Minigun'] = 'SA 342 Mg',
        ['SA342Mistral'] = 'SA 342 Ms',
      },
      ProperNaming = {
        ['AH-1W'] = 'SuperCobra',
        ['AH-64A'] = 'Apache', ['AH-64D'] = 'Apache',
        ['CH-47D'] = 'Chinook',
        ['CH-53E'] = 'Sea Stallion',
        ['Ka-50'] = 'Black Shark',
        ['Ka-52'] = 'Alligator',
        ['OH-58D'] = 'Kiowa',
        ['SA342L'] = 'Gazelle', ['SA342M'] = 'Gazelle', ['SA342Minigun'] = 'Gazelle', ['SA342Mistral'] = 'Gazelle',
        ['SH-3W'] = 'Sea King',
        ['SH-60B'] = 'Seahawk',
        ['UH-1H'] = 'Huey',
        ['UH-60A'] = 'Black Hawk',
      },
      Nicknaming = {
        ['AH-1W'] = 'HueyCobra',
        ['Mi-24V'] = 'Crocodile',
      },
    },
    Ground = {
      Tracked = {
        HQ = {
          Sborka9S80M1 = 'Dog Ear radar',
        },
        MBT = {
          ChallengerII = 'Challenger2',
          AMX56Leclerc = 'Leclerc',
          Leopard1A3 = 'Leopard1A3',
          Leopard2A5 = 'Leopard-2',
          M1A2Abrams = 'M-1 Abrams',
          M60A3Patton = 'M-60',
          MerkavaMk4 = 'Merkava_Mk4',
          T55 = 'T-55',
          T72B = 'T-72B',
          T80U = 'T-80UD',
          T90 = 'T-90',
          ZTZ96B = 'ZTZ96B',
        },
        IFV = {
          BMD1 = 'BMD-1', -- airborne
          BMP1 = 'BMP-1',
          BMP2 = 'BMP-2',
          BMP3 = 'BMP-3',
          M2A2Bradley = 'M-2 Bradley',
          Marder1A3 = 'Marder',
          MCV80 = 'MCV-80',
          ZBD04A = 'ZBD04A',
        },
        ARV = {
          BRDM2 = 'BRDM-2',
          BTRRD = 'BTR_D', -- airborne
          MTLBuBoman = 'Grad_FDDM',
        },
        APC = {
          AAV7 = 'AAV7', -- marines
          M1043HMMWVMg = 'M1043 HMMWV Armament',
          M1126StrykerICV = 'M1126 Stryker ICV',
          M113 = 'M-113',
          MTLB = 'MTLB',
        },
        MLRS = {
          BM21 = { -- also has wheeled components
            _HasWheeledComps = true,
            FireControl = {
              MTLBuBoman = 'Grad_FDDM',
            },
          },
          M270 = { -- also has wheeled components
            _HasWheeledComps = true,
            Launcher = {
              M270MLRSLN = 'MLRS',
            },
          },
        },
        SPH = {
          M109Paladin = 'M-109',
          Gvozdika2S1 = 'SAU Gvozdika',
          Msta2S19 = 'SAU Msta',
          Akatsia2S3 = 'SAU Akatsia',
          NonaS2S9 = 'SAU 2-C9', -- airborne
          SpGHDana = 'SpGH_Dana',
        },
        EWR = {
          RolandEWR = 'Roland Radar',
        },
        SAM = {
          M48Chaparral = 'M48 Chaparral',
          M6Linebacker = 'M6 Linebacker',
          RolandADS = 'Roland ADS',
          SA6 = {
            SearchTrackRadar = {
              SA6KubSTR_1S91 = 'Kub 1S91 str',
            },
            Launcher = {
              SA6KubLN_2P25 = 'Kub 2P25 ln',
            },
          },
          SA11 = {
            HQ = {
              SA11BukCC_9S470M1 = 'SA-11 Buk CC 9S470M1',
            },
            SearchRadar = {
              SA11BukSR_9S18M1 = 'SA-11 Buk SR 9S18M1',
            },
            Launcher = {
              SA11BukLN_9A310M1 = 'SA-11 Buk LN 9A310M1',
            },
          },
          SA13Strela10M3_9A35M3 = 'Strela-10M3',
          SA15Tor_9A331 = 'Tor 9A331',
          SA19Tunguska_2S6 = '2S6 Tunguska',
        },
        SPAAG = {
          FlaKPzGepard1A2 = 'Gepard',
          ZSU234Shilka = 'ZSU-23-4 Shilka',
          M163Vulcan = 'Vulcan',
        },
      },
      Wheeled = {
        HQ = {
          LandRover101FC = 'Land_Rover_101_FC',
          SKP11ATCMCP = 'SKP-11',
          Ural375PBU = 'Ural-375 PBU',
          ZiL131KUNG = 'ZIL-131 KUNG',
        },
        SPG = {
          M1128StrykerMGS = 'M1128 Stryker MGS',
        },
        ATGM = {
          M1024HMMWVTOW = 'M1045 HMMWV TOW',
          M1134StrykerATGM = 'M1134 Stryker ATGM',
        },
        ARV = {
          LAV25 = 'LAV-25', -- marines
        },
        APC = {
          BMT2Cobra = 'Cobra',
          BTR80 = 'BTR-80',
          M1025HMMWV = 'Hummer',
          TPzFuchs = 'TPZ',
        },
        SSM = {
          SS1CScudBLN = 'Scud_B',
        },
        MLRS = {
          BM21 = {
            _HasTrackedComps = true,
            Launcher = {
              BM21Grad = 'Grad-URAL',
            },
          },
          BM27Uragan_9K57 = 'Uragan_BM-27',
          BM30Smerch_9A52 = 'Smerch',
          M270 = { -- also has tracked components
            _HasTrackedComps = true,
            FireControl = {
              M270MLRSFDDM = 'MLRS FDDM',
            },
          },
        },
        EWR = {
          P1455G6 = '55G6 EWR',
          P181L13 = '1L13 EWR',
        },
        SAM = {
          M1097Avenger = 'M1097 Avenger',
          HQ7 = {
            SearchTrackRadar = {
              HQ7SPSTR = 'HQ-7_STR_SP',
            },
            Launcher = {
              HQ7SPLN = 'HQ-7_LN_SP',
            },
          },
          Patriot = { -- also has towed components
            _HasTowedComps = true,
            HQ = {
              PatriotECS_ANMSQ104 = 'Patriot ECS',
            },
            DataProcessing = {
              PatriotICC = 'Patriot cp',
            },
            Power = {
              PatriotEPPIII = 'Patriot EPP',
            },
            RadarArray = {
              PatriotAMG_ANMRC137 = 'Patriot AMG',
            },
          },
          SA3S125 = { -- also has towed components
            _HasTowedComps = true,
            SearchRadar = {
              SA3S125SR_P19 = 'p-19 s-125 sr',
            },
          },
          SA8 = {
            Loader = {
              SA8OsaLD_9T217 = 'SA-8 Osa LD 9T217',
            },
            Launcher = {
              SA8OsaLN_9A33 = 'Osa 9A33 ln',
            },
          },
          SA9Strela1_9P31 = 'Strela-1 9P31',
          SA10S300PS = { -- also has towed components
            _HasTowedComps = true,
            HQ = {
              SA10S300PSCP_54K6 = 'S-300PS 54K6 cp',
            },
            SearchRadar = {
              SA10S300PSSR_64H6E = 'S-300PS 64H6E sr',
            },
            MasterLauncher = {
              SA10S300PSLN_5P85C = 'S-300PS 5P85C ln',
            },
            SlaveLauncher = {
              SA10S300PSLN_5P85D = 'S-300PS 5P85D ln',
            },
          },
        },
        SPAAG = {
          ZU23Ural375 = {
            Soldier = {
              ZU23Ural375 = 'Ural-375 ZU-23',
            },
            Insurgent = {
              ZU23Ural375_Insurgent = 'Ural-375 ZU-23 Insurgent',
            },
          },
        },
        Power = {
          APA5D_Ural4320 = 'Ural-4320 APA-5D',
          APA80_ZiL131 = 'ZiL-131 APA-80',
        },
        Fire = {
          M1142HEMTTTFFT = 'HEMTT TFFT',
          UralATsP6 = 'Ural ATsP-6',
        },
        Transport = {
          Armored = {
            Ural432031A = 'Ural-4320-31',
          },
          Open = {
            GAZ66 = 'GAZ-66',
            Ural375 = 'Ural-375',
          },
          Covered = {
            GAZ3308 = 'GAZ-3308',
            KamAZ43101 = 'KAMAZ Truck',
            KrAZ6322 = 'KrAZ6322',
            M818 = 'M 818',
            Ural4320T = 'Ural-4320T',
          },
          Lubricant = {
            ATMZ5 = 'ATMZ-5',
          },
          Fuel = {
            ATZ10 = 'ATZ-10',
            M978HEMTTTanker = 'M978 HEMTT Tanker',
          },
        },
        Car = {
          M1025HMMWV = 'Hummer',
          LandRover109S3 = 'Land_Rover_109_S3',
          Tigr_233036 = 'Tigr_233036',
          UAZ469 = 'UAZ-469',
        },
      },
      Towed = {
        Drone = {
          HQ = {
            PreadtorGCS = 'Predator GCS',
          },
          Repeater = {
            PredatorTS = 'Predator TrojanSpirit',
          },
        },
        SSM = {
          CSSC2 = { -- anti-ship
            SearchRadar = {
              CSSC2SilkwormSR = 'Silkworm_SR',
            },
            Launcher = {
              CSSC2SilkwormLN = 'hy_launcher',
            },
          },
        },
        SAM = {
          Hawk = {
            HQ = {
              HawkPCP = 'Hawk pcp',
            },
            ContWaveAcqRadar = {
              HawkCWAR_ANMPQ55 = 'Hawk cwar',
            },
            SearchRadar = {
              HawkSR_ANMPQ50 = 'Hawk sr',
            },
            TrackRadar = {
              HawkTR_ANMPQ46 = 'Hawk tr',
            },
            Launcher = {
              HawkLN_M192 = 'Hawk ln',
            },
          },
          Patriot = { -- also has wheeled components
            _HasWheeledComps = true,
            Launcher = {
              PatriotLN_M901 = 'Patriot ln',
            },
            SearchTrackRadar = {
              PatriotSTR_ANMPQ53 = 'Patriot str',
            },
          },
          Rapier = {
            TrackRadar = {
              RapierFSATR = 'rapier_fsa_blindfire_radar',
            },
            TrackOptical = {
              RapierFSATO = 'rapier_fsa_optical_tracker_unit',
            },
            Launcher = {
              RapierFSALN = 'rapier_fsa_launcher',
            },
          },
          SA2S75 = {
            TrackRadar = {
              SA2S75TR_SNR75 = 'SNR_75V',
            },
            Launcher = {
              SA2S75LN_SM90 = 'S_75M_Volhov',
            },
          },
          SA3S125 = { -- also has wheeled components
            _HasWheeledComps = true,
            TrackRadar = {
              SA3S125TR_SNR = 'snr s-125 tr',
            },
            Launcher = {
              SA3S125LN_5P73 = '5p73 s-125 ln',
            },
          },
          SA10S300PS = { -- also has wheeled components
            _HasWheeledComps = true,
            SearchRadar = {
              SA10S300PSSR_5N66M = 'S-300PS 40B6MD sr',
            },
            TrackRadar = {
              SA10S300PSTR_30N6 = 'S-300PS 40B6M tr',
            },
          },
        },
        AAA = {
          ZU23 = {
            Soldier = {
              Fortified = {
                ZU23Closed = 'ZU-23 Emplacement Closed',
              },
              Emplacement = {
                ZU23 = 'ZU-23 Emplacement',
              },
            },
            Insurgent = {
              Fortified = {
                ZU23Closed_Insurgent = 'ZU-23 Closed Insurgent',
              },
              Emplacement = {
                ZU23_Insurgent = 'ZU-23 Insurgent',
              },
            },
          },
        },
      },
      Infantry = {
        Beacon = {
          TACANBeacon_TTS3030 = 'TACAN_beacon',
        },
        Mortar = {
          M2B11 = '2B11 mortar',
        },
        SAM = {
          SA18 = {
            Soldier = {
              Comm = {
                SA18IGLAComm = 'SA-18 Igla comm',
              },
              Launcher = {
                SA18IGLAMANPAD = 'SA-18 Igla manpad',
              },
            },
            Insurgent = {
              Comm = {
                SA18IGLAComm = 'SA-18 Igla comm',
              },
              Launcher = {
                SA18IGLAMANPAD_Insurgent = 'Igla manpad INS',
              },
            },
          },
          SA24 = {
            Comm = {
              SA24IGLASComm = 'SA-18 Igla-S comm',
            },
            Launcher = {
              SA24IGLASMANPAD = 'SA-18 Igla-S manpad',
            },
          },
          Stinger = {
            Comm = {
              StingerComm = 'Stinger comm',
              IsraeliStingerComm = 'Stinger comm dsr',
            },
            Launcher = {
              StingerMANPAD = 'Soldier stinger',
            },
          },
        },
        MG = {
          Soldier = {
            SoldierM249 = 'Soldier M249',
          },
        },
        Rifle = {
          Soldier = {
            GeorgianM4 = 'Soldier M4 GRG',
            SoldierM4 = 'Soldier M4',
            RussianAK = 'Infantry AK',
            SoldierAK = 'Soldier AK',
          },
          Insurgent = {
            InsurgentAK = 'Infantry AK Ins',
          },
          Paratrooper = {
            ParatroopAKS74 = 'Paratrooper AKS-74',
          },
        },
        RPG = {
          Soldier = {
            SoldierRPG = 'Soldier RPG',
          },
          Insurgent = {
            SoldierRPG = 'Soldier RPG',
          },
          Paratrooper = {
            ParatroopRPG16 = 'Paratrooper RPG-16',
          },
        },
      },
      Fort = {
        Barracks = 'house1arm',
        House = 'houseA_arm',
        HillsideBunker = 'Sandbox',
        PillboxBunker = 'Bunker',
        Outpost = 'outpost',
        RoadOutpost = 'outpost_road',
        WatchTower = 'house2arm',
        WarningBoard = 'warning_board_a',
      },
      Civilian = {
        Trailer = {
          MAZ6303 = 'MAZ-6303',
        },
        Fire = {
          M1142HEMTTTFFT = 'HEMTT TFFT',
          UralATsP6 = 'Ural ATsP-6',
        },
        Transport = {
          Open = {
            ZiL4331 = 'ZIL-4331',
          },
          Covered = {
            GAZ3307 = 'GAZ-3307',
          },
        },
        Bus = {
          Double = {
            IKARUS280 = 'IKARUS Bus',
          },
          Single = {
            LAZ695 = 'LAZ Bus',
            ZIU9 = 'Trolley bus',
          },
        },
        Car = {
          VAZ2109 = 'VAZ Car',
        },
      },
      Animal = {
        Suidae = 'Suidae',
      },
      All = {}, -- resolved on startup processing
      Airborne = { -- vehicles that are considered a part of airborne assault units (capable of air drop)
        BMD1 = 'BMD-1',
        BTRRD = 'BTR_D',
        ParatroopAKS74 = 'Paratrooper AKS-74',
        ParatroopRPG16 = 'Paratrooper RPG-16',
      },
      Amphibious = { -- vehicles that can float on water, not just ford rivers (capable of sea crossing)
        AAV7 = 'AAV7',
        BMP1 = 'BMP-1',
        BMP2 = 'BMP-2',
        BRDM2 = 'BRDM-2',
        BTRRD = 'BTR_D',
        BTR80 = 'BTR-80',
        LAV25 = 'LAV-25',
        MTLB = 'MTLB',
        MTLBuBoman = 'Grad_FDDM',
        SA8OsaLD_9T217 = 'SA-8 Osa LD 9T217',
        SA8OsaLN_9A33 = 'Osa 9A33 ln',
        Gvozdika2S1 = 'SAU Gvozdika',
        NonaS2S9 = 'SAU 2-C9',
      },
      HeavyWheeled = { -- wheeled vehicles less likely to get stuck in the mud (reduced stuck-in-mud chance)
        M1142HEMTTTFFT = 'HEMTT TFFT',
        M978HEMTTTanker = 'M978 HEMTT Tanker',
        SA10S300PSCP_54K6 = 'S-300PS 54K6 cp',
        SA10S300PSSR_64H6E = 'S-300PS 64H6E sr',
        SA10S300PSLN_5P85C = 'S-300PS 5P85C ln',
        SA10S300PSLN_5P85D = 'S-300PS 5P85D ln',
        SS1CScudBLN = 'Scud_B',
        TPzFuchs = 'TPZ',
      },
      Marines = { -- vehicles that are considered a part of marine assault units (capable of amphibious launch)
        AAV7 = 'AAV7',
        LAV25 = 'LAV-25',
      },
      Unavailable = { -- vehicles in the DB tables, but not spawnable
        SA8OsaLD_9T217 = 'SA-8 Osa LD 9T217',
        Suidae = 'Suidae',
      },
      NATOReporting = {
        -- HQ
        ['Dog Ear radar'] = 'PPRU-M1 \'Dog Ear\' (Sborka-M1):\'Dog Ear\'',
        -- MBT
        ['T-55'] = ':(M1970)',
        ['T-72B'] = ':(M1988)',
        ['T-80UD'] = ':(M1989)',
        ['T-90'] = ':(M1990)',
        -- IFV
        ['BMD-1'] = ':(M1970)',
        ['BMP-1'] = ':(M1970)',
        ['BMP-2'] = ':(M1981)',
        ['BMP-3'] = ':(M1990/1)',
        -- ARV
        ['BRDM-2'] = ':(M1966)',
        ['BTR_D'] = ':(M1979)',
        ['Grad_FDDM'] = ':(M1974)',
        -- APC
        ['BTR-80'] = ':(M1987)',
        ['MTLB'] = ':(M1970)',
        -- SPH
        ['SAU 2-C9'] = 'SAU-120:(M1985)',
        ['SAU Akatsia'] = 'SAU-152:(M1973)',
        ['SAU Gvozdika'] = 'SAU-122:(M1974)',
        ['SAU Msta'] = 'SAU-152:(M1990)',
        -- MLRS
        ['Grad-URAL'] = 'BM-21:(M1964)',
        ['Uragan_BM-27'] = 'BM-27:(M1977)',
        ['Smerch'] = 'BM-30:(M1983)',
        -- SSM
        ['Scud_B'] = 'SS-1C \'Scud-B\' (R-17/MAZ-543):\'Scud-B\'',
        ['Silkworm_SR'] = 'CSS-C-2 \'Silkworm\':\'Silkworm\'',
        ['hy_launcher'] = 'CSS-C-2 \'Silkworm\':\'Silkworm\'',
        -- EWR
        ['55G6 EWR'] = 'P-14 \'Tall Rack\' (Nebo):\'Tall Rack\'',
        ['1L13 EWR'] = 'P-18 \'Spoon Rest-D\' (Nebo-SV):\'Spoon Rest-D\'',
        -- SAM
        ['S_75M_Volhov'] = 'SA-2D \'Guideline m.3\' (S-75M/SM-90):\'Guideline m.3\'',
        ['SNR_75V'] = 'SA-2D \'Fan Song-E\' (SNR-75V):\'Fan Song-E\'',
        ['5p73 s-125 ln'] = 'SA-3 \'Goa\' (S-125):\'Goa\'',
        ['p-19 s-125 sr'] = 'SA-3 \'Flat Face-B\' (S-125/P-19):\'Flat Face-B\'',
        ['snr s-125 tr'] = 'SA-3 \'Low Blow\' (SNR-125):\'Low Blow\'',
        ['Kub 1S91 str'] = 'SA-6 \'Straight Flush\' (Kub):\'Straight Flush\'',
        ['Kub 2P25 ln'] = 'SA-6 \'Gainful\' (Kub):\'Gainful\'',
        ['SA-8 Osa LD 9T217'] = 'SA-8 \'Gecko\' (Osa):\'Gecko\'',
        ['Osa 9A33 ln'] = 'SA-8 \'Gecko\' (Osa):\'Gecko\'',
        ['Strela-1 9P31'] = 'SA-9 \'Gaskin\' (Strela-1):\'Gaskin\'',
        ['S-300PS 40B6M tr'] = 'SA-10B \'Flap Lid-A\' (S-300PS):\'Flap Lid-A\'',
        ['S-300PS 40B6MD sr'] = 'SA-10B \'Clam Shell\' (S-300PS):\'Clam Shell\'',
        ['S-300PS 54K6 cp'] = 'SA-10B \'Grumble-B\' (S-300PS):\'Grumble-B\'',
        ['S-300PS 5P85C ln'] = 'SA-10B \'Grumble-B\' (S-300PS):\'Grumble-B\'',
        ['S-300PS 5P85D ln'] = 'SA-10B \'Grumble-B\' (S-300PS):\'Grumble-B\'',
        ['S-300PS 64H6E sr'] = 'SA-10B \'Big Bird\' (S-300PS):\'Big Bird\'',
        ['SA-11 Buk CC 9S470M1'] = 'SA-11 \'Gadfly\' (Buk):\'Gadfly\'',
        ['SA-11 Buk LN 9A310M1'] = 'SA-11 \'Gadfly\' (Buk):\'Gadfly\'',
        ['SA-11 Buk SR 9S18M1'] = 'SA-11 \'Tube Arm\' (Buk):\'Tube Arm\'',
        ['Strela-10M3'] = 'SA-13 \'Gopher\' (Strela-10M3):\'Gopher\'',
        ['Tor 9A331'] = 'SA-15 \'Gauntlet\' (Tor):\'Gauntlet\'',
        ['2S6 Tunguska'] = 'SA-19 \'Grison\' (Tunguska):\'Grison\'',
        -- SAM (Infantry)
        ['Igla manpad INS'] = 'SA-18 \'Grouse\' (Igla):\'Grouse\'',
        ['SA-18 Igla comm'] = 'SA-18 \'Grouse\' (Igla):\'Grouse\'',
        ['SA-18 Igla manpad'] = 'SA-18 \'Grouse\' (Igla):\'Grouse\'',
        ['SA-18 Igla-S comm'] = 'SA-24 \'Grinch\' (Igla-S):\'Grinch\'',
        ['SA-18 Igla-S manpad'] = 'SA-24 \'Grinch\' (Igla-S):\'Grinch\' ',
        -- SPAAG
        ['ZSU-23-4 Shilka'] = 'ZSU-23-4 \'Gun Dish\' (Shilka):\'Gun Dish\'',
      },
      WTOReporting = {
        -- HQ
        ['Dog Ear radar'] = '9S80M1 Sborka-M1:(PPRU-M1)',
        -- MBT
        ['T-55'] = ':(O.155)',
        ['T-72B'] = ':(O.174M)',
        ['T-80UD'] = ':(O.219AS)',
        ['T-90'] = ':(O.188)',
        -- IFV
        ['BMD-1'] = ':(O.915)',
        ['BMP-1'] = ':(O.765Sp2)',
        ['BMP-2'] = ':(O.675)',
        ['BMP-3'] = ':(O.688M)',
        -- ARV
        ['BRDM-2'] = ':(BTR-40P-2)',
        ['BTR_D'] = ':(O.925)',
        ['Grad_FDDM'] = ':(O.10)',
        -- APC
        ['BTR-80'] = ':(GAZ-5903)',
        ['MTLB'] = ':(O.6)',
        -- SPH
        ['SAU 2-C9'] = '2S9:(SO.120)',
        ['SAU Akatsia'] = '2S3:(SO.152)',
        ['SAU Gvozdika'] = '2S1:(SAU.122)',
        ['SAU Msta'] = '2S19:(SP.152)',
        -- MLRS
        ['Grad-URAL'] = '9K51 BM-21:',
        ['Uragan_BM-27'] = '9K57 BM-27:(9P140)',
        ['Smerch'] = '9K58 BM-30:',
        -- SSM
        ['Scud_B'] = '9K72 R-17 Elbrus:(9P117M)',
        ['Silkworm_SR'] = 'HY-1A:',
        ['hy_launcher'] = 'HY-1A:',
        -- EWR
        ['55G6 EWR'] = '55G6 Nebo:(P-14)',
        ['1L13 EWR'] = '1L13 Nebo-SV:(P-18)',
        -- SAM
        ['S_75M_Volhov'] = 'S-75M SM-90:',
        ['SNR_75V'] = 'S-75M SNR-75V:',
        ['5p73 s-125 ln'] = 'S-125 5P73:',
        ['p-19 s-125 sr'] = 'S-125 1RL134:(P-19)',
        ['snr s-125 tr'] = 'S-125 SNR-125:',
        ['Kub 1S91 str'] = '2K12 Kub 1S91:',
        ['Kub 2P25 ln'] = '2K12 Kub 2P25:',
        ['SA-8 Osa LD 9T217'] = '9K33 Osa 9T217:',
        ['Osa 9A33 ln'] = '9K33 Osa 9A33:',
        ['Strela-1 9P31'] = '9K31 Strela-1 9P31:',
        ['S-300PS 40B6M tr'] = 'S-300PS 30N6:',
        ['S-300PS 40B6MD sr'] = 'S-300PS 5N66M:',
        ['S-300PS 54K6 cp'] = 'S-300PS 54K6:',
        ['S-300PS 5P85C ln'] = 'S-300PS 5P85C:',
        ['S-300PS 5P85D ln'] = 'S-300PS 5P85D:',
        ['S-300PS 64H6E sr'] = 'S-300PS 64H6E:',
        ['SA-11 Buk CC 9S470M1'] = '9K37 Buk 9S470M1:',
        ['SA-11 Buk LN 9A310M1'] = '9K37 Buk 9A310M1:',
        ['SA-11 Buk SR 9S18M1'] = '9K37 Buk 9S18M1:',
        ['Strela-10M3'] = '9K35M Strela-10M3 9A35M3:',
        ['Tor 9A331'] = '9K330 Tor 9A331:',
        ['2S6 Tunguska'] = '2S6 Tunguska:',
        -- SAM (Infantry)
        ['Igla manpad INS'] = '9K38 Igla:',
        ['SA-18 Igla comm'] = '9K38 Igla:',
        ['SA-18 Igla manpad'] = '9K38 Igla:',
        ['SA-18 Igla-S comm'] = '9K338 Igla-S:',
        ['SA-18 Igla-S manpad'] = '9K338 Igla-S:',
        -- SPAAG
        ['ZSU-23-4 Shilka'] = 'ZSU-23-4 Shilka:',
      },
      ReportNaming = {
        -- HQ
        ['Dog Ear radar'] = '%R',
        ['Land_Rover_101_FC'] = 'Land Rover 101 FC',
        ['Predator TrojanSpirit'] = 'Predator TS',
        ['SKP-11'] = 'SKP-11 ATC MCP',
        ['ZIL-131 KUNG'] = 'ZiL-131 KUNG',
        -- MBT
        ['Challenger2'] = 'Challenger II',
        ['Leclerc'] = 'AMX-56 Leclerc',
        ['Leopard1A3'] = 'Leopard 1A3',
        ['Leopard-2'] = 'Leopard 2A5',
        ['M-1 Abrams'] = 'M1A2 Abrams',
        ['M-60'] = 'M60A3 Patton',
        ['Merkava_Mk4'] = 'Merkava Mk.IV',
        ['ZTZ96B'] = 'ZTZ-96B',
        -- IFV
        ['M-2 Bradley'] = 'M2A2 Bradley',
        ['Marder'] = 'Marder 1A3',
        ['MCV-80'] = 'MCV-80 Warrior',
        ['ZBD04A'] = 'ZBD-04A',
        -- SPG/ATGM
        ['M1045 HMMWV TOW'] = 'M1045 HMMWV TOW',
        ['M1128 Stryker MGS'] = 'M1128 Stryker MGS',
        ['M1134 Stryker ATGM'] = 'M1134 Stryker ATGM',
        -- ARV
        ['BTR_D'] = 'BTR-RD',
        ['Grad_FDDM'] = 'MT-LBu Boman',
        -- APC
        ['AAV7'] = 'AAV-7',
        ['Cobra'] = 'Cobra BMT-2',
        ['BTR-80'] = 'BTR-80',
        ['M1043 HMMWV Armament'] = 'M1043 HMMWV Mg',
        ['M1126 Stryker ICV'] = 'M1126 Stryker ICV', 
        ['M-113'] = 'M113 APC',
        ['MTLB'] = 'MT-LB',
        ['TPZ'] = 'TPz Fuchs',
        -- SPH
        ['SAU 2-C9'] = '%R Nona-S',
        ['SAU Akatsia'] = '%R Akatsia',
        ['SAU Gvozdika'] = '%R Gvozdika',
        ['SAU Msta'] = '%R Msta-S',
        ['M-109'] = 'M109 Paladin',
        ['SpGH_Dana'] = 'SpGH Dana',
        -- MLRS
        ['Grad-URAL'] = '%R Grad',
        ['Uragan_BM-27'] = '%R Uragan',
        ['Smerch'] = '%R Smerch',
        ['MLRS'] = 'M270 MLRS LN',
        ['MLRS FDDM'] = 'M270 MLRS FDDM',
        -- SSM
        ['Scud_B'] = '%R LN',
        ['Silkworm_SR'] = '%R SR',
        ['hy_launcher'] = '%R LN',
        -- EWR
        ['55G6 EWR'] = '%R EWR',
        ['1L13 EWR'] = '%R EWR',
        ['Roland Radar'] = 'Roland EWR',
        -- SAM
        ['Hawk cwar'] = 'Hawk AN/MPQ-55 CWAR',
        ['Hawk ln'] = 'Hawk M192 LN',
        ['Hawk pcp'] = 'Hawk PCP',
        ['Hawk sr'] = 'Hawk AN/MPQ-50 SR',
        ['Hawk tr'] = 'Hawk AN/MPQ-46 TR',
        ['HQ-7_LN_SP'] = 'HQ-7 SP LN',
        ['HQ-7_STR_SP'] = 'HQ-7 SP STR',
        ['Patriot AMG'] = 'Patriot AN/MRC-137 AMG',
        ['Patriot cp'] = 'Patriot ICC',
        ['Patriot ECS'] = 'Patriot AN/MSQ-104 ECS',
        ['Patriot EPP'] = 'Patriot EPP-III',
        ['Patriot ln'] = 'Patriot M901 LN',
        ['Patriot str'] = 'Patriot AN/MPQ-53 STR',
        ['rapier_fsa_blindfire_radar'] = 'Rapier FSA Blindfire TR',
        ['rapier_fsa_launcher'] = 'Rapier FSA LN',
        ['rapier_fsa_optical_tracker_unit'] = 'Rapier FSA OT',
        ['S_75M_Volhov'] = '%R LN',
        ['SNR_75V'] = '%R TR',
        ['5p73 s-125 ln'] = '%R LN',
        ['p-19 s-125 sr'] = '%R SR',
        ['snr s-125 tr'] = '%R TR',
        ['Kub 1S91 str'] = '%R STR',
        ['Kub 2P25 ln'] = '%R LN',
        ['SA-8 Osa LD 9T217'] = '%R LD',
        ['Osa 9A33 ln'] = '%R LN',
        ['Strela-1 9P31'] = '%R',
        ['S-300PS 40B6M tr'] = '%R TR',
        ['S-300PS 40B6MD sr'] = '%R SR',
        ['S-300PS 54K6 cp'] = '%R CP',
        ['S-300PS 5P85C ln'] = '%R M/LN',
        ['S-300PS 5P85D ln'] = '%R S/LN',
        ['S-300PS 64H6E sr'] = '%R SR',
        ['SA-11 Buk CC 9S470M1'] = '%R CC',
        ['SA-11 Buk LN 9A310M1'] = '%R LN',
        ['SA-11 Buk SR 9S18M1'] = '%R SR',
        ['Strela-10M3'] = '%R',
        ['Tor 9A331'] = '%R',
        ['2S6 Tunguska'] = '%R',
        -- SAM (Infantry)
        ['Igla manpad INS'] = 'Insurgent %R MANPAD',
        ['SA-18 Igla comm'] = '%R Comm',
        ['SA-18 Igla manpad'] = '%R MANPAD',
        ['SA-18 Igla-S comm'] = '%R Comm',
        ['SA-18 Igla-S manpad'] = '%R MANPAD',
        ['Stinger comm'] = 'Stinger Comm',
        ['Stinger comm dsr'] = 'Israeli Stinger Comm',
        ['Soldier stinger'] = 'Stinger MANPAD',
        -- SPAAG
        ['Gepard'] = 'FlaKPz Gepard 1A2',
        ['Vulcan'] = 'M163 Vulcan',
        ['ZSU-23-4 Shilka'] = '%R',
        ['Ural-375 ZU-23'] = 'ZU-23/Ural-375',
        ['Ural-375 ZU-23 Insurgent'] = 'Insurgent ZU-23/Ural-375',
        -- AAA
        ['ZU-23 Emplacement Closed'] = 'ZU-23 (fortified)',
        ['ZU-23 Closed Insurgent'] = 'Insurgent ZU-23 (fortified)',
        ['ZU-23 Emplacement'] = 'ZU-23',
        ['ZU-23 Insurgent'] = 'Insurgent ZU-23',
        -- Infantry
        ['TACAN_beacon'] = 'TTS3030 TACAN Beacon',
        ['2B11 mortar'] = '2B11 Mortar',
        ['Soldier M4 GRG'] = 'Georgian Soldier M4',
        ['Infantry AK Ins'] = 'Insurgent AK',
        ['Paratrooper AKS-74'] = 'Paratrooper AKS-74',
        ['Paratrooper RPG-16'] = 'Paratrooper RPG-16',
        -- Support
        ['Ural-4320 APA-5D'] = 'APA-5D/Ural-4320',
        ['ZiL-131 APA-80'] = 'APA-80/ZiL-131',
        ['HEMTT TFFT'] = 'M1142 HEMTT TFFT',
        -- Transport
        ['Ural-4320-31'] = 'Ural-4320-31 armored truck',
        ['GAZ-66'] = 'GAZ-66 truck',
        ['Ural-375'] = 'Ural-375 truck',
        ['GAZ-3308'] = 'GAZ-3308 truck',
        ['KAMAZ Truck'] = 'KamAZ-43101 truck',
        ['KrAZ6322'] = 'KrAZ-6322 truck',
        ['M 818'] = 'M818 truck',
        ['Ural-4320T'] = 'Ural-4320T truck',
        -- Car
        ['Hummer'] = 'M1025 HMMWV',
        ['Land_Rover_109_S3'] = 'Land Rover 109 S3',
        ['Tigr_233036'] = 'GAZ-233036 Tigr',
        ['UAZ-469'] = 'UAZ-469 car',
        -- Fort (armed)
        ['Bunker'] = 'Pillbox bunker',
        ['Sandbox'] = 'Hillside bunker',
        ['house1arm'] = 'Barracks',
        ['house2arm'] = 'Watch tower',
        ['houseA_arm'] = 'Holdout',
        ['outpost'] = 'Outpost',
        ['outpost_road'] = 'Road outpost',
        ['warning_board_a'] = 'Warning board',
        -- Civilian
        ['MAZ-6303'] = 'MAZ-6303 trailer',
        ['IKARUS Bus'] = 'IKARUS-280 bus',
        ['LAZ Bus'] = 'LAZ-695 bus',
        ['Trolley bus'] = 'ZIU-9 bus',
        ['VAZ Car'] = 'VAZ-2109 car',
        ['ZIL-4331'] = 'ZiL-4331 truck',
      },
      Nicknaming = {
        ['Hummer'] = 'Humvee', ['M1043 HMMWV Armament'] = 'Humvee', ['M1045 HMMWV TOW'] = 'Humvee',
      },
    },
    Train = {
      Transport = {
        Locomotive = {
          UnionPacificES44AH = 'ES44AH',
          RedStarCHME3T = 'Locomotive',
        },
        Wagon = {
          BoxCar = 'Boxcartrinity',
          FlatCar = 'Coach a platform',
          GondolaCar = 'Coach cargo open',
          StockCar = 'Coach cargo',
          TankCarBlackLg = 'Tankcartrinity',
          TankCarBlueSh = 'Coach a tank blue',
          TankCarYellowSh = 'Coach a tank yellow',
          WellCar = 'Wellcarnsc',
        },
      },
      Civilian = {
        Locomotive = {
          ElectricVL80 = 'Electric locomotive',
        },
        Wagon = {
          PassengerCar = 'Coach a passenger',
        },
      },
      All = {}, -- resolved on startup processing
      ReportNaming = {
        ['ES44AH'] = 'ES44AH locomotive',
        ['Locomotive'] = 'CHME3T locomotive',
        ['Boxcartrinity'] = 'Box car',
        ['Coach a platform'] = 'Flat car',
        ['Coach cargo open'] = 'Gondola car',
        ['Coach cargo'] = 'Stock car',
        ['Tankcartrinity'] = 'Large tank car',
        ['Coach a tank blue'] = 'Short tank car (blue)',
        ['Coach a tank yellow'] = 'Short tank car (yellow)',
        ['Wellcarnsc'] = 'Well car',
        ['Electric locomotive'] = 'VL80 locomotive',
        ['Coach a passenger'] = 'Passenger car',
      },
    },
    Ship = {
      Carrier = {
        Kuznetsov_AdmiralKuznetsov = 'KUZNECOW', -- 1143.5
        Nimitz_CVN74JohnCStennis = 'Stennis',
        Nimitz_CVN70CarlVinson = 'VINSON',
      },
      HeliCarrier = {
        Tarawa_LHA1Tarawa = 'LHA_Tarawa',
      },
      BattleCruiser = {
        Kirov_PyotrVelikiy = 'PIOTR', -- 1144.2
      },
      Cruiser = {
        Slava_Moskva = 'MOSCOW', -- 1164
        Ticonderoga = 'TICONDEROG',
      },
      Destroyer = {
        Neustrashimy_Neustrashimy = 'NEUSTRASH', -- 1154.0
        OliverHazardPerry = 'PERRY',
        Type052B = '052B',
        Type052C = '052C',
      },
      Frigate = {
        KrivakII_Rezky = 'REZKY', -- 1135M
        GrishaV = 'ALBATROS', -- 1124.4
        Type054A = '054A',
      },
      Corvette = {
        TarantulIII = 'MOLNIYA', -- 1241.1MP
      },
      Submarine = {
        Kilo = 'KILO', -- 877
        Tango = 'SOM', -- 641B
        Type093 = 'Type 093',
      },
      Gunboat = {
        Speedboat = 'speedboat' ,
      },
      Transport = {
        BulkCargo = {
          BulkCarrier_Yakushev = 'Dry-cargo ship-1',
        },
        ISOCargo = {
          ContainerShip_Ivanov = 'Dry-cargo ship-2',
        },
        Refueler = {
          Tanker_Elnya = 'ELNYA',
        },
      },
      Civilian = {
        Yacht_Zvezdny = 'ZWEZDNY',
      },
      All = {}, -- resolved on startup processing
      NATOReporting = {
        ['KUZNECOW'] = 'Kuznetsov:',
        ['PIOTR'] = 'Kirov:',
        ['MOSCOW'] = 'Slava:',
        ['NEUSTRASH'] = 'Neustrashimy:',
        ['052B'] = 'Luyang I:',
        ['052C'] = 'Luyang II:',
        ['REZKY'] = 'Krivak II:',
        ['ALBATROS'] = 'Grisha V:',
        ['054A'] = 'Jiangkai II:',
        ['MOLNIYA'] = 'Tarantul III:',
        ['KILO'] = 'Kilo:',
        ['SOM'] = 'Tango:',
        ['Type 093'] = 'Shang:',
        ['ELNYA'] = 'Altay::Tanker',
      },
      WTOReporting = {
        ['KUZNECOW'] = 'Orel:(P.1143.5)',
        ['PIOTR'] = 'Orlan:(P.1144.2)',
        ['MOSCOW'] = 'Atlant:(P.1164)',
        ['NEUSTRASH'] = 'Yastreb:(P.1154.0)',
        ['052B'] = 'Guangzhou:',
        ['052C'] = 'Lanzhou:',
        ['REZKY'] = 'Burevestnik M:(P.1135M)',
        ['ALBATROS'] = 'Albatros:(P.1124.4)',
        ['054A'] = 'Xuzhou:',
        ['MOLNIYA'] = 'Molniya:(P.1241.1MP)',
        ['KILO'] = 'Paltus:(P.877)',
        ['SOM'] = 'Som:(P.641B)',
        ['Type 093'] = '09-III:',
        ['ELNYA'] = 'Altay:(P.160):Oiler',
      },
      ReportNaming = {
        ['KUZNECOW'] = '%R-class Carrier',
        ['Stennis'] = 'Nimitz-class (late) Carrier',
        ['VINSON'] = 'Nimitz-class (early) Carrier',
        ['LHA_Tarawa'] = 'Tarawa-class Assault Ship',
        ['PIOTR'] = '%R-class BattleCruiser',
        ['MOSCOW'] = '%R-class Cruiser',
        ['TICONDEROG'] = 'Ticonderoga-class Cruiser',
        ['NEUSTRASH'] = '%R-class Destroyer',
        ['PERRY'] = 'Oliver Hazard Perry-class Destroyer',
        ['052B'] = 'Type 052B (%R-class) Destroyer',
        ['052C'] = 'Type 052C (%R-class) Destroyer',
        ['REZKY'] = '%R-class Frigate',
        ['ALBATROS'] = '%R-class Frigate',
        ['054A'] = 'Type 054A (%R-class) Frigate',
        ['MOLNIYA'] = '%R-class Corvette',
        ['KILO'] = '%R-class Submarine',
        ['SOM'] = '%R-class Submarine',
        ['Type 093'] = 'Type 093 (%R-class) Submarine',
        ['speedboat'] = 'Speedboat',
        ['Dry-cargo ship-1'] = 'Bulk carrier Ship',
        ['Dry-cargo ship-2'] = 'Container Ship',
        ['ELNYA'] = '%R-class %N',
        ['ZWEZDNY'] = 'Civilian Yacht',
      },
      Nicknaming = {
        ['052C'] = 'Chinese Aegis',
      },
    },
    Static = { -- values are in format "category:shape_name:type"
      Airbase = {
        AirshowCrowd = 'Fortifications:Crowd1:Airshow_Crowd',
        AirshowCone = 'Fortifications:Comp_cone:Airshow_Cone',
        FuelStorageTank = 'Fortifications:toplivo-bak:Fuel tank',
        HangarA = 'Fortifications:angar_a:Hangar A',
        HangarB = 'Fortifications:angar_b:Hangar B',
        ReinforcedHangar = 'Fortifications:ukrytie:Shelter',
        StorageShelter = 'Fortifications:ukrytie_b:Shelter B',
        RepairWorkshop = 'Fortifications:tech:Repair workshop',
        Windsock = 'Fortifications:H-Windsock_RW:Windsock',
      },
      Barrier = {
        RoadBarrier = 'Cargos:f_bar_cargo:f_bar_cargo',
        Tetrapod = 'Cargos:tetrapod_cargo:tetrapod_cargo',
        LogsLg = 'Cargos:trunks_long_cargo:trunks_long_cargo',
        LogsSh = 'Cargos:trunks_small_cargo:trunks_small_cargo',
        PipesLg = 'Cargos:pipes_big_cargo:pipes_big_cargo',
        PipesSh = 'Cargos:pipes_small_cargo:pipes_small_cargo',
      },
      Cargo = {
        AmmoBox = 'Cargos:ammo_box_cargo:ammo_cargo',
        Barrels = 'Cargos:barrels_cargo:barrels_cargo',
        Container = 'Cargos:bw_container_cargo:container_cargo',
        FuelTank = 'Cargos:fueltank_cargo:fueltank_cargo',
        ISOContainerLg = 'Cargos:iso_container_cargo:iso_container',
        ISOContainerSm = 'Cargos:iso_container_small_cargo:iso_container_small',
        M117Bombs = 'Cargos:m117_cargo:m117_cargo',
        OilTank = 'Cargos:oiltank_cargo:oiltank_cargo',
        SlungCargo = 'Cargos:ab-212_cargo:uh1h_cargo',
      },
      Effect = {
        BigSmoke = 'Effects::big_smoke',
        BigSmokePresets = { SmallSmokeAndFire = 1, MediumSmokeAndFire = 2, LargeSmokeAndFire = 3, HugeSmokeAndFire = 4,
                            SmallSmoke = 5, MediumSmoke = 6, LargeSmoke = 7, HugeSmoke = 8 }, -- effectPreset
        DustSmoke = 'Effects::dust_smoke',
        DustSmokePresets = { test1 = 1, test2 = 2, test3 = 3 }, -- effectPreset
        SmokingLine = 'Effects::smoking_line',
        SmokingLinePresets = { test1 = 1, test2 = 2, test3 = 3 }, -- effectPreset
        SmokyMarker = 'Effects::smoky_marker',
        SmokyMarkerPresets = { test1 = 1, test2 = 2, test3 = 3 }, -- effectPreset
      },
      Factory = {
        ChemicalTank = 'Fortifications:him_bak_a:Chemical tank A',
        ManufacturingPlant = 'Fortifications:kombinat:Tech combine',
        EquipmentHangar = 'Fortifications:ceh_ang_a:Tech hangar A',
        FactoryWorkshop = 'Fortifications:tec_a:Workshop A',
      },
      FARP = {
        AmmoStorage = 'Fortifications:SetkaKP:FARP Ammo Dump Coating',
        CommandPost = 'Fortifications:kp_ug:FARP CP Blindage',
        FuelDepot = 'Fortifications:GSM Rus:FARP Fuel Depot',
        Tent = 'Fortifications:PalatkaB:FARP Tent',
        Heliport = 'Heliports:FARPS:FARP',
        Helipad = 'Heliports:FARP:SINGLE_HELIPAD',
        HeliportCallsigns = { London = 1, Dallas = 2, Paris = 3, Moscow = 4, Berlin = 5, Rome = 6, Madrid = 7,
                              Warsaw = 8, Dublin = 9, Perth = 10 }, -- heliport_callsign_id
      },
      Fort = {
        Barracks = 'Fortifications::house1arm',
        Dormitory = 'Fortifications:kazarma2:Barracks 2',
        HillsideBunker = 'Fortifications::Sandbox',
        PillboxBunker = 'Fortifications::Bunker',
        CommandCenter = 'Fortifications:ComCenter:.Command Center',
        Generators = 'Fortifications:GeneratorF:GeneratorF',
        House = 'Fortifications::houseA_arm',
        Landmine = 'Fortifications:landmine:Landmine',
        Latrine = 'Fortifications:WC:WC',
        Outpost = 'Fortifications::outpost',
        RoadOutpost = 'Fortifications::outpost_road',
        StaffBuilding = 'Fortifications:aviashtab:Military staff',
        WatchTower = 'Fortifications::house2arm',
      },
      Marker = {
        RedFlag = 'Fortifications:H-flag_R:Red_Flag',
        WhiteFlag = 'Fortifications:H-Flag_W:White_Flag',
        BlackTire = 'Fortifications:H-tyre_B:Black_Tyre',
        WhiteTire = 'Fortifications:H-tyre_W:White_Tyre',
        BlackTireRedFlag = 'Fortifications:H-tyre_B_RF:Black_Tyre_RF',
        BlackTireWhiteFlag = 'Fortifications:H-tyre_B_WF:Black_Tyre_WF',
      },
      OilField = {
        OilDerrick = 'Fortifications:neftevyshka:Oil derrick',
        OilPlatform = 'Fortifications:plavbaza:Oil platform',
        OilPumpStation = 'Fortifications:nasos:Pump station',
      },
      Railway = {
        RailwayCrossingA = 'Fortifications:pereezd_big:Railway crossing A',
        RailwayCrossingB = 'Fortifications:pereezd_small:Railway crossing B',
        RailwayStation = 'Fortifications:r_vok_sd:Railway station',
      },
      SeaShelf = {
        GasPlatform = 'Heliports:gas_platform:Gas platform',
        OilRigPlatform = 'Heliports:oil_platform:Oil rig',
      },
      Telecom = {
        CommsTower = 'Fortifications:tele_bash_m:Comms tower M',
        BroadcastTower = 'Fortifications:tele_bash:TV tower',
      },
      Warehouse = {
        AmmunitionDepot = 'Warehouses:SkladC:.Ammunition depot',
        Tank1 = 'Warehouses:bak:Tank',
        Tank2 = 'Warehouses:airbase_tbilisi_tank_01:Tank 2',
        Tank3 = 'Warehouses:airbase_tbilisi_tank_02:Tank 3',
        Warehouse = 'Warehouses:sklad:Warehouse',
      },
      Civilian = {
        BoilerHouse = 'Fortifications:kotelnaya_a:Boiler-house A',
        Cafe = 'Fortifications:stolovaya:Cafe',
        ContainerBrown = 'Fortifications:konteiner_brown:Container brown',
        ContainerRed1 = 'Fortifications:konteiner_red1:Container red 1',
        ContainerRed2 = 'Fortifications:konteiner_red2:Container red 2',
        ContainerRed3 = 'Fortifications:konteiner_red3:Container red 3',
        ContainerWhite = 'Fortifications:konteiner_white:Container white',
        ElectricPowerBox = 'Fortifications:tr_budka:Electric power box',
        FarmA = 'Fortifications:ferma_a:Farm A',
        FarmB = 'Fortifications:ferma_b:Farm B',
        GarageA = 'Fortifications:garage_a:Garage A',
        GarageB = 'Fortifications:garage_b:Garage B',
        GarageSmA = 'Fortifications:garagh-small-a:Garage small A',
        GarageSmB = 'Fortifications:garagh-small-b:Garage small B',
        Restaurant = 'Fortifications:restoran1:Restaurant 1',
        Shop = 'Fortifications:magazin:Shop',
        HouseSmA = 'Fortifications:domik1a:Small house 1A',
        HouseSmB = 'Fortifications:domik1b:Small house 1B',
        HouseSmC = 'Fortifications:dom2c:Small house 2C',
        HouseFnA = 'Fortifications:domik1a-all:Small house 1A area',
        HouseFnB = 'Fortifications:domik1b-all:Small house 1B area',
        HouseFnC = 'Fortifications:dom2c-all:Small house 1C area',
        WarehouseSm1 = 'Fortifications:s1:Small werehouse 1',
        WarehouseSm2 = 'Fortifications:s2:Small werehouse 2',
        WarehouseSm3 = 'Fortifications:s3:Small werehouse 3',
        WarehouseSm4 = 'Fortifications:s4:Small werehouse 4',
        SubsidiarySt1 = 'Fortifications:hozdomik1:Subsidiary structure 1',
        SubsidiarySt2 = 'Fortifications:hozdomik2:Subsidiary structure 2',
        SubsidiarySt3 = 'Fortifications:hozdomik3:Subsidiary structure 3',
        SubsidiaryStA = 'Fortifications:saray-a:Subsidiary structure A',
        SubsidiaryStB = 'Fortifications:saray-b:Subsidiary structure B',
        SubsidiaryStC = 'Fortifications:saray-c:Subsidiary structure C',
        SubsidiaryStD = 'Fortifications:saray-d:Subsidiary structure D',
        SubsidiaryStE = 'Fortifications:saray-e:Subsidiary structure E',
        SubsidiaryStF = 'Fortifications:saray-f:Subsidiary structure F',
        SubsidiaryStG = 'Fortifications:saray-g:Subsidiary structure G',
        Supermarket = 'Fortifications:uniwersam_a:Supermarket A',
        WaterTower = 'Fortifications:wodokachka_a:Water tower A',
      },
      All = {}, -- resolved on startup processing
      Plane = {}, -- resolved on startup processing
      Helicopter = {}, -- resolved on startup processing
      Ground = {}, -- resolved on startup processing
      Ship = {}, -- resolved on startup processing
      Train = {}, -- resolved on startup processing
      ReportNaming = {
        -- Airbase
        ['Airshow_Crowd'] = 'Airshow crowd',
        ['Airshow_Cone'] = 'Airshow cone',
        ['Fuel tank'] = 'Fuel storage tank',
        ['Hangar A'] = 'Hangar (A)',
        ['Hangar B'] = 'Hangar (B)',
        ['Shelter'] = 'Reinforced hangar',
        ['Shelter B'] = 'Storage shelter',
        -- Barrier
        ['f_bar_cargo'] = 'Road barrier',
        ['tetrapod_cargo'] = 'Tetrapod',
        ['trunks_long_cargo'] = 'Long logs',
        ['trunks_small_cargo'] = 'Short logs',
        ['pipes_big_cargo'] = 'Long pipes',
        ['pipes_small_cargo'] = 'Short pipes',
        -- Cargo
        ['ammo_cargo'] = 'Ammo box',
        ['barrels_cargo'] = 'Barrels',
        ['container_cargo'] = 'Container',
        ['fueltank_cargo'] = 'Fuel tank',
        ['iso_container'] = 'Large ISO container',
        ['iso_container_small'] = 'Small ISO container',
        ['m117_cargo'] = 'M117 bombs',
        ['oiltank_cargo'] = 'Oil tank',
        ['uh1h_cargo'] = 'Slung cargo',
        -- Effect
        ['big_smoke'] = 'Big smoke',
        ['dust_smoke'] = 'Dust smoke',
        ['smoking_line'] = 'Smoking line',
        ['smoky_marker'] = 'Smoky marker',
        -- Factory
        ['Chemical tank A'] = 'Chemical tank',
        ['Tech combine'] = 'Manufacturing plant',
        ['Tech hangar A'] = 'Equipment hangar',
        ['Workshop A'] = 'Factory workshop',
        -- FARP
        ['FARP Ammo Dump Coating'] = 'Ammo storage',
        ['FARP CP Blindage'] = 'Command Post',
        ['FARP Fuel Depot'] = 'Fuel depot',
        ['FARP Tent'] = 'Tent',
        ['FARP'] = 'Heliport',
        ['SINGLE_HELIPAD'] = 'Helipad',
        -- Fort
        ['Barracks 2'] = 'Barracks dormitory',
        ['.Command Center'] = 'Command Center',
        ['GeneratorF'] = 'Generators',
        ['WC'] = 'Latrine',
        ['Military staff'] = 'Staff building',
        -- Marker
        ['Red_Flag'] = 'Red flag',
        ['White_Flag'] = 'White flag',
        ['Black_Tyre'] = 'Black tire',
        ['White_Tyre'] = 'White tire',
        ['Black_Tyre_RF'] = 'Black tire/Red flag',
        ['Black_Tyre_WF'] = 'Black tire/White flag',
        -- OilField
        ['Pump station'] = 'Oil pump station',
        -- Railway
        ['Railway crossing A'] = 'Railway crossing (A)',
        ['Railway crossing B'] = 'Railway crossing (B)',
        -- SeaShelf
        ['Oil rig'] = 'Oil rig platform',
        -- Telecom
        ['Comms tower M'] = 'Communications tower',
        ['TV tower'] = 'Broadcasting tower',
        -- Warehouse
        ['.Ammunition depot'] = 'Ammunition depot',
        ['Tank'] = 'Storage tank (1)',
        ['Tank 2'] = 'Storage tank (2)',
        ['Tank 3'] = 'Storage tank (3)',
        -- Civilian
        ['Boiler-house A'] = 'Boiler house',
        ['Container brown'] = 'Container (brown)',
        ['Container red 1'] = 'Container (red 1)',
        ['Container red 2'] = 'Container (red 2)',
        ['Container red 3'] = 'Container (red 3)',
        ['Container white'] = 'Container (white)',
        ['Farm A'] = 'Farm (A)',
        ['Farm B'] = 'Farm (B)',
        ['Garage A'] = 'Garage (A)',
        ['Garage B'] = 'Garage (B)',
        ['Garage small A'] = 'Small garage (A)',
        ['Garage small B'] = 'Small garage (B)',
        ['Restaurant 1'] = 'Restaurant',
        ['Small house 1A'] = 'Small house (A)',
        ['Small house 1B'] = 'Small house (B)',
        ['Small house 2C'] = 'Small house (C)',
        ['Small house 1A area'] = 'Fenced house (A)',
        ['Small house 1B area'] = 'Fenced house (B)',
        ['Small house 1C area'] = 'Fenced house (C)',
        ['Small werehouse 1'] = 'Small warehouse (1)',
        ['Small werehouse 2'] = 'Small warehouse (2)',
        ['Small werehouse 3'] = 'Small warehouse (3)',
        ['Small werehouse 4'] = 'Small warehouse (4)',
        ['Subsidiary structure 1'] = 'Subsidiary structure (1)',
        ['Subsidiary structure 2'] = 'Subsidiary structure (2)',
        ['Subsidiary structure 3'] = 'Subsidiary structure (3)',
        ['Subsidiary structure A'] = 'Subsidiary structure (A)',
        ['Subsidiary structure B'] = 'Subsidiary structure (B)',
        ['Subsidiary structure C'] = 'Subsidiary structure (C)',
        ['Subsidiary structure D'] = 'Subsidiary structure (D)',
        ['Subsidiary structure E'] = 'Subsidiary structure (E)',
        ['Subsidiary structure F'] = 'Subsidiary structure (F)',
        ['Subsidiary structure G'] = 'Subsidiary structure (G)',
        ['Supermarket A'] = 'Supermarket',
        ['Water tower A'] = 'Water tower',
      },
    },
    All = {}, -- resolved on startup processing
    Airborne = {}, -- resolved on startup processing
    Amphibious = {}, -- resolved on startup processing
    CarrierBorne = {}, -- resolved on startup processing
    HeavyWheeled = {}, -- resolved on startup processing
    Marines = {}, -- resolved on startup processing
    PlayerControllable = {}, -- resolved on startup processing
    Unavailable = {}, -- resolved on startup processing
    Available = {}, -- resolved on startup processing
    NATOReporting = {}, -- resolved on startup processing
    WTOReporting = {}, -- resolved on startup processing
    Nicknaming = {}, -- resolved on startup processing
  }

  fdmm.unitTypes._resKeyFilter = { 'All', 'Airborne', 'Amphibious', 'CarrierBorne', 'HeavyWheeled', 'Marines',
                                   'PlayerControllable', 'Unavailable', 'Available', 'NATOReporting', 'WTOReporting',
                                   'ReportNaming', 'ProperNaming', 'Nicknaming' }
  fdmm.unitTypes._resKeySuffixFilter = { 'Presets', 'Callsigns', 'Liveries' }                      

  function fdmm.unitTypes._isReservedKey(key)
    return string.hasPrefix(key, '_') or
           table.contains(fdmm.unitTypes._resKeyFilter, key) or
           string.hasAnySuffix(key, fdmm.unitTypes._resKeySuffixFilter)
  end

  function fdmm.unitTypes.processEntries()
    local categoryOverrides = { ['house1arm'] = 'Fortifications', ['houseA_arm'] = 'Fortifications',
                                ['Sandbox'] = 'Fortifications', ['Bunker'] = 'Fortifications',
                                ['outpost'] = 'Fortifications', ['outpost_road'] = 'Fortifications',
                                ['house2arm'] = 'Fortifications', ['TACAN_beacon'] = 'Fortifications' }

    local function _createGroupAll(unitTypeGroup)
      local function _createGroupAll_recurse(node, groupAllList)
        for key, value in pairs(node) do
          if not fdmm.unitTypes._isReservedKey(key) then
            if type(value) == 'table' then
              _createGroupAll_recurse(value, groupAllList) -- recurse, b/c table
            elseif type(value) == 'string' then -- valid value
              local fdmmUnitType = key
              local unitCategory, shapeName, unitType = fdmm.utils.splitTuple(value)
              unitType = unitType or value

              if not groupAllList[fdmmUnitType] then -- not yet found
                groupAllList[fdmmUnitType] = value

                if string.isNotEmpty(unitType) then
                  if not groupAllList._rev then groupAllList._rev = {} end
                  if not groupAllList._rev[unitType] then
                    groupAllList._rev[unitType] = fdmmUnitType
                  elseif groupAllList._rev[unitType] ~= fdmmUnitType then -- different reverse entry
                    env.error("Group all list reverse discrepancy for unitType=\'" .. unitType ..
                              "\', groupAllList._rev[unitType]=\'" .. groupAllList._rev[unitType] ..
                              "\' ~= fdmmUnitType=\'" .. fdmmUnitType .. "\'.")
                  end
                end

                if string.isNotEmpty(shapeName) then
                  if not groupAllList._revShape then groupAllList._revShape = {} end
                  if not groupAllList._revShape[shapeName] then
                    groupAllList._revShape[shapeName] = fdmmUnitType
                  elseif groupAllList._revShape[shapeName] ~= fdmmUnitType then -- different reverse entry
                    env.error("Group all list shape reverse discrepancy for shapeName=\'" .. shapeName ..
                              "\', groupAllList._revShape[shapeName]=\'" .. groupAllList._revShape[shapeName] ..
                              "\' ~= fdmmUnitType=\'" .. fdmmUnitType .. "\'.")
                  end
                end
              elseif groupAllList[fdmmUnitType] ~= value then -- different than what we have
                env.error("Group all list discrepancy for fdmmUnitType=\'" .. fdmmUnitType ..
                          "\', groupAllList[fdmmUnitType]=\'" .. groupAllList[fdmmUnitType] ..
                          "\' ~= value=\'" .. value .. "\'.")
              end
            end
          end
        end
      end
      _createGroupAll_recurse(unitTypeGroup, unitTypeGroup.All)
    end

    local function _copyGroupAllToStaticAll(groupAllList, staticAllList, category)
      for fdmmUnitType, unitType in pairs(groupAllList) do
        if not fdmm.unitTypes._isReservedKey(fdmmUnitType) then
          -- possible todo: determine shape name?
          staticAllList[fdmmUnitType] = (categoryOverrides[unitType] or category) .. '::' .. unitType
        end
      end
    end

    local function _copyGroupAllToMasterAll(allList, masterAllList)
      for fdmmUnitType, value in pairs(allList) do
        if not fdmm.unitTypes._isReservedKey(fdmmUnitType) then
          local unitType = fdmm.unitTypes.getUnitType(value)
          if not masterAllList[fdmmUnitType] then
            masterAllList[fdmmUnitType] = unitType
          elseif masterAllList[fdmmUnitType] ~= unitType then -- different entry
            env.error("Master all list discrepancy for fdmmUnitType=\'" .. fdmmUnitType ..
                      "\', masterAllList[fdmmUnitType]=\'" .. masterAllList[fdmmUnitType] ..
                      "\' ~= unitType=\'" .. unitType .. "\'.")
          end
        end
      end
    end

    local function _createGroupNamingIfNeeded(unitTypeGroup)
      if not unitTypeGroup.NATOReporting then unitTypeGroup.NATOReporting = {} end
      if not unitTypeGroup.WTOReporting then unitTypeGroup.WTOReporting = {} end
      if not unitTypeGroup.ReportNaming then unitTypeGroup.ReportNaming = {} end
      if not unitTypeGroup.ProperNaming then unitTypeGroup.ProperNaming = {} end
      if not unitTypeGroup.Nicknaming then unitTypeGroup.Nicknaming = {} end
    end

    local function _copyGroupReportingToStaticReporting(unitTypeGroup, staticUnitTypeGroup)
      local function _copyGroupNamingToStaticNaming(groupReportNaming, staticReportNaming)
        for unitType, reportNaming in pairs(groupReportNaming) do
          if not fdmm.unitTypes._isReservedKey(unitType) then
            if not staticReportNaming[unitType] then
              staticReportNaming[unitType] = reportNaming
            elseif staticReportNaming[unitType] ~= reportNaming then -- different entry
              env.error("Static report naming discrepancy for unitType=\'" .. unitType ..
                        "\', staticReportNaming[unitType]=\'" .. staticReportNaming[unitType] ..
                        "\' ~= reportNaming=\'" .. reportNaming .. "\'.")
            end
          end
        end
      end
      _copyGroupNamingToStaticNaming(unitTypeGroup.NATOReporting, staticUnitTypeGroup.NATOReporting)
      _copyGroupNamingToStaticNaming(unitTypeGroup.WTOReporting, staticUnitTypeGroup.WTOReporting)
      _copyGroupNamingToStaticNaming(unitTypeGroup.ReportNaming, staticUnitTypeGroup.ReportNaming)
      _copyGroupNamingToStaticNaming(unitTypeGroup.ProperNaming, staticUnitTypeGroup.ProperNaming)
      _copyGroupNamingToStaticNaming(unitTypeGroup.Nicknaming, staticUnitTypeGroup.Nicknaming)
    end

    local function _fillInReportNaming(unitTypeGroup)
      for fdmmUnitType, value in pairs(unitTypeGroup.All) do
        if not fdmm.unitTypes._isReservedKey(fdmmUnitType) then
          local unitType = fdmm.unitTypes.getUnitType(value)
          if not unitTypeGroup.ReportNaming[unitType] then
            unitTypeGroup.ReportNaming[unitType] = unitType
          end
        end
      end
    end

    _createGroupAll(fdmm.consts.UnitType.Plane)
    _createGroupAll(fdmm.consts.UnitType.Helicopter)
    _createGroupAll(fdmm.consts.UnitType.Ground)
    _createGroupAll(fdmm.consts.UnitType.Ship)
    _createGroupAll(fdmm.consts.UnitType.Train)

    _copyGroupAllToStaticAll(fdmm.consts.UnitType.Plane.All, fdmm.consts.UnitType.Static.Plane, 'Planes')
    _copyGroupAllToStaticAll(fdmm.consts.UnitType.Helicopter.All, fdmm.consts.UnitType.Static.Helicopter, 'Helicopters')
    _copyGroupAllToStaticAll(fdmm.consts.UnitType.Ground.All, fdmm.consts.UnitType.Static.Ground, 'Unarmed')
    _copyGroupAllToStaticAll(fdmm.consts.UnitType.Train.All, fdmm.consts.UnitType.Static.Train, 'Unarmed')
    _copyGroupAllToStaticAll(fdmm.consts.UnitType.Ship.All, fdmm.consts.UnitType.Static.Ship, 'Ships')

    _createGroupAll(fdmm.consts.UnitType.Static)

    _copyGroupAllToMasterAll(fdmm.consts.UnitType.Plane.All, fdmm.consts.UnitType.All)
    _copyGroupAllToMasterAll(fdmm.consts.UnitType.Helicopter.All, fdmm.consts.UnitType.All)
    _copyGroupAllToMasterAll(fdmm.consts.UnitType.Ground.All, fdmm.consts.UnitType.All)
    _copyGroupAllToMasterAll(fdmm.consts.UnitType.Train.All, fdmm.consts.UnitType.All)
    _copyGroupAllToMasterAll(fdmm.consts.UnitType.Ship.All, fdmm.consts.UnitType.All)
    _copyGroupAllToMasterAll(fdmm.consts.UnitType.Static.All, fdmm.consts.UnitType.All)

    table.concatWith(fdmm.consts.UnitType.Airborne, fdmm.consts.UnitType.Ground.Airborne)
    table.concatWith(fdmm.consts.UnitType.Amphibious, fdmm.consts.UnitType.Ground.Amphibious)
    table.concatWith(fdmm.consts.UnitType.CarrierBorne, fdmm.consts.UnitType.Plane.CarrierBorne)
    table.concatWith(fdmm.consts.UnitType.CarrierBorne, fdmm.consts.UnitType.Helicopter.CarrierBorne)
    table.concatWith(fdmm.consts.UnitType.HeavyWheeled, fdmm.consts.UnitType.Ground.HeavyWheeled)
    table.concatWith(fdmm.consts.UnitType.Marines, fdmm.consts.UnitType.Ground.Marines)
    table.concatWith(fdmm.consts.UnitType.PlayerControllable, fdmm.consts.UnitType.Plane.PlayerControllable)
    table.concatWith(fdmm.consts.UnitType.PlayerControllable, fdmm.consts.UnitType.Helicopter.PlayerControllable)
    table.concatWith(fdmm.consts.UnitType.Unavailable, fdmm.consts.UnitType.Plane.Unavailable)
    table.concatWith(fdmm.consts.UnitType.Unavailable, fdmm.consts.UnitType.Helicopter.Unavailable)
    table.concatWith(fdmm.consts.UnitType.Unavailable, fdmm.consts.UnitType.Ground.Unavailable)

    fdmm.utils.ensureReversedDict(fdmm.consts.UnitType.Plane.CarrierBorne)
    fdmm.utils.ensureReversedDict(fdmm.consts.UnitType.Plane.PlayerControllable)
    fdmm.utils.ensureReversedDict(fdmm.consts.UnitType.Plane.Unavailable)
    fdmm.utils.ensureReversedDict(fdmm.consts.UnitType.Helicopter.CarrierBorne)
    fdmm.utils.ensureReversedDict(fdmm.consts.UnitType.Helicopter.PlayerControllable)
    fdmm.utils.ensureReversedDict(fdmm.consts.UnitType.Helicopter.Unavailable)
    fdmm.utils.ensureReversedDict(fdmm.consts.UnitType.Ground.Airborne)
    fdmm.utils.ensureReversedDict(fdmm.consts.UnitType.Ground.Amphibious)
    fdmm.utils.ensureReversedDict(fdmm.consts.UnitType.Ground.HeavyWheeled)
    fdmm.utils.ensureReversedDict(fdmm.consts.UnitType.Ground.Marines)
    fdmm.utils.ensureReversedDict(fdmm.consts.UnitType.Ground.Unavailable)

    fdmm.utils.ensureReversedDict(fdmm.consts.UnitType.All)
    fdmm.utils.ensureReversedDict(fdmm.consts.UnitType.Airborne)
    fdmm.utils.ensureReversedDict(fdmm.consts.UnitType.Amphibious)
    fdmm.utils.ensureReversedDict(fdmm.consts.UnitType.CarrierBorne)
    fdmm.utils.ensureReversedDict(fdmm.consts.UnitType.HeavyWheeled)
    fdmm.utils.ensureReversedDict(fdmm.consts.UnitType.Marines)
    fdmm.utils.ensureReversedDict(fdmm.consts.UnitType.PlayerControllable)
    fdmm.utils.ensureReversedDict(fdmm.consts.UnitType.Unavailable)

    _createGroupNamingIfNeeded(fdmm.consts.UnitType.Plane)
    _createGroupNamingIfNeeded(fdmm.consts.UnitType.Helicopter)
    _createGroupNamingIfNeeded(fdmm.consts.UnitType.Ground)
    _createGroupNamingIfNeeded(fdmm.consts.UnitType.Ship)
    _createGroupNamingIfNeeded(fdmm.consts.UnitType.Train)
    _createGroupNamingIfNeeded(fdmm.consts.UnitType.Static)

    _fillInReportNaming(fdmm.consts.UnitType.Plane)
    _fillInReportNaming(fdmm.consts.UnitType.Helicopter)
    _fillInReportNaming(fdmm.consts.UnitType.Ground)
    _fillInReportNaming(fdmm.consts.UnitType.Ship)
    _fillInReportNaming(fdmm.consts.UnitType.Train)

    _copyGroupReportingToStaticReporting(fdmm.consts.UnitType.Plane, fdmm.consts.UnitType.Static)
    _copyGroupReportingToStaticReporting(fdmm.consts.UnitType.Helicopter, fdmm.consts.UnitType.Static)
    _copyGroupReportingToStaticReporting(fdmm.consts.UnitType.Ground, fdmm.consts.UnitType.Static)
    _copyGroupReportingToStaticReporting(fdmm.consts.UnitType.Ship, fdmm.consts.UnitType.Static)
    _copyGroupReportingToStaticReporting(fdmm.consts.UnitType.Train, fdmm.consts.UnitType.Static)

    _fillInReportNaming(fdmm.consts.UnitType.Static)

    table.concatWith(fdmm.consts.UnitType.Nicknaming, fdmm.consts.UnitType.Plane.Nicknaming)
    table.concatWith(fdmm.consts.UnitType.Nicknaming, fdmm.consts.UnitType.Helicopter.Nicknaming)
    table.concatWith(fdmm.consts.UnitType.Nicknaming, fdmm.consts.UnitType.Ground.Nicknaming)
    table.concatWith(fdmm.consts.UnitType.Nicknaming, fdmm.consts.UnitType.Train.Nicknaming)
    table.concatWith(fdmm.consts.UnitType.Nicknaming, fdmm.consts.UnitType.Ship.Nicknaming)
    table.concatWith(fdmm.consts.UnitType.Nicknaming, fdmm.consts.UnitType.Static.Nicknaming)
  end

  function fdmm.unitTypes.createUnitTypeAvailability()
    assert(db, "Missing module: db")
    assert(dbYears, "Missing module: dbYears")
    fdmm.consts.UnitType.Available = {}
    for fdmmUnitType, unitType in pairs(fdmm.consts.UnitType.All) do
      if not fdmm.unitTypes._isReservedKey(fdmmUnitType) then
        local availability = {}
        if dbYears[unitType] then
          local countries = db.getHistoricalCountres(unitType)
          for _, country in pairs(countries) do
            local begYear, endYear = db.getYearsLocal(unitType, country)
            availability[string.lower(string.trim(country))] = { begYear, endYear }
          end
        else
          availability['all'] = { 1900, 9999 }
        end
        fdmm.consts.UnitType.Available[unitType] = availability
      end
    end
  end

  function fdmm.unitTypes.saveUnitTypeAvailability()
    env.info("FDDM: Saving UnitType availability...")
    local availabilityFilename = fdmm.fullPath .. "data/UnitTypeAvailability.json"
    fdmm.utils.encodeToJSONFile(fdmm.consts.UnitType.Available, availabilityFilename)
  end

  function fdmm.unitTypes.loadUnitTypeAvailability()
    env.info("FDDM: Loading UnitType availability...")
    local availabilityFilename = fdmm.fullPath .. "data/UnitTypeAvailability.json"
    fdmm.consts.UnitType.Available = fdmm.utils.decodeFromJSONFile(availabilityFilename)
  end

  function fdmm.unitTypes.crossRefEntries()
    assert(db, "Missing module: db")
    assert(dbYears, "Missing module: dbYears")
    env.info("FDMM: Cross-referencing units...")
    local function _crossRefUnits(keyPath, unitArray)
      for idx,unitData in ipairs(unitArray) do
        local unitType = unitData.Name
        local unitTypeAliases = unit_aliases._rev[unitType]
        local fdmmUnitType = fdmm.consts.UnitType.All._rev[unitType]
        if not fdmmUnitType and unitTypeAliases then
          if type(unitTypeAliases) == 'string' then
            unitTypeAliases = { unitTypeAliases }
          end
          for _,unitTypeAlias in ipairs(unitTypeAliases) do
            fdmmUnitType = fdmm.consts.UnitType.All._rev[unitTypeAlias]
            if fdmmUnitType then
              env.warning("  unitTypeAlias=[\'" .. unitTypeAlias .. "\'] is now unitType=[\'" .. unitType .. "\'].")
              break
            end
          end
        end
        if not fdmmUnitType then
          env.info("  Missing fdmmUnitType for unitType=[\'" .. (unitType or "<null>") .. "\'] from " .. keyPath  .. "[" .. idx .. "].")
        end
      end
    end

    fdmm.utils.ensureReversedDict(unit_aliases)

    _crossRefUnits('db.Units.Animals', db.Units.Animals.Animal)
    _crossRefUnits('db.Units.Cargos', db.Units.Cargos.Cargo)
    _crossRefUnits('db.Units.Cars', db.Units.Cars.Car)
    _crossRefUnits('db.Units.Fortifications', db.Units.Fortifications.Fortification)
    _crossRefUnits('db.Units.Helicopters', db.Units.Helicopters.Helicopter)
    _crossRefUnits('db.Units.Heliports', db.Units.Heliports.Heliport)
    _crossRefUnits('db.Units.LTAvehicles', db.Units.LTAvehicles.LTAvehicle)
    _crossRefUnits('db.Units.Personnel', db.Units.Personnel.Personnel)
    _crossRefUnits('db.Units.Planes', db.Units.Planes.Plane)
    _crossRefUnits('db.Units.Ships', db.Units.Ships.Ship)
    _crossRefUnits('db.Units.WWIIstructures', db.Units.WWIIstructures.WWIIstructure)
    _crossRefUnits('db.Units.Warehouses', db.Units.Warehouses.Warehouse)

    local checkDBYears = false -- change to true to run the following
    if checkDBYears then
      local unitArray = {}
      for unitType,_ in pairs(dbYears) do
        table.insert(unitArray, {Name = unitType})
      end
      _crossRefUnits('dbYears', unitArray)
    end
  end

  function fdmm.unitTypes.whichAvailableToCountryIn(unitTypesDict, countryName, year)
    local retVal = {}
    local countryName = string.lower(countryName)
    for fdmmUnitType, value in pairs(unitTypesDict) do
      if not string.hasPrefix(fdmmUnitType, '_') then
        local unitType = fdmm.unitTypes.getUnitType(value)
        if not fdmm.unitTypes.isListedUnder(unitType, fdmm.consts.UnitType.Unavailable) then
          local availability = fdmm.consts.UnitType.Available[unitType]
          local yearRange = availability[countryName] or availability['all']
          if yearRange and year >= yearRange[1] and year <= yearRange[2] then
            retVal[fdmmUnitType] = value
          end
        end
      end
    end
    return retVal
  end

  function fdmm.unitTypes.anyAvailableToCountryIn(unitTypesDict, countryName, year)
    local countryName = string.lower(countryName)
    for fdmmUnitType, value in pairs(unitTypesDict) do
      if not string.hasPrefix(fdmmUnitType, '_') then
        local unitType = fdmm.unitTypes.getUnitType(value)
        if not fdmm.unitTypes.isListedUnder(unitType, fdmm.consts.UnitType.Unavailable) then
          local availability = fdmm.consts.UnitType.Available[unitType]
          local yearRange = availability[countryName] or availability['all']
          if yearRange and year >= yearRange[1] and year <= yearRange[2] then
            return true
          end
        end
      end
    end
    return false
  end

  function fdmm.unitTypes.isAvailableToCountryIn(unitType, countryName, year)
    local countryName = string.lower(countryName)
    if not fdmm.unitTypes.isListedUnder(unitType, fdmm.consts.UnitType.Unavailable) then
      local availability = fdmm.consts.UnitType.Available[unitType]
      local yearRange = availability[countryName] or availability['all']
      if yearRange and year >= yearRange[1] and year <= yearRange[2] then
        return true
      end
    end
    return false
  end

  function fdmm.unitTypes.whichListedUnder(unitTypesDict, listedTypesDict)
    fdmm.utils.ensureReversedDict(listedTypesDict)
    local retVal = {}
    for fdmmUnitType, value in pairs(unitTypesDict) do
      if not string.hasPrefix(fdmmUnitType, '_') then
        local unitType = fdmm.unitTypes.getUnitType(value)
        if listedTypesDict._rev[unitType] then
          retVal[fdmmUnitType] = value
        end
      end
    end
    return retVal
  end

  function fdmm.unitTypes.anyListedUnder(unitTypesDict, listedTypesDict)
    fdmm.utils.ensureReversedDict(listedTypesDict)
    for fdmmUnitType, value in pairs(unitTypesDict) do
      if not string.hasPrefix(fdmmUnitType, '_') then
        local unitType = fdmm.unitTypes.getUnitType(value)
        if listedTypesDict._rev[unitType] then
          return true
        end
      end
    end
    return false
  end

  function fdmm.unitTypes.isListedUnder(unitType, listedTypesDict)
    fdmm.utils.ensureReversedDict(listedTypesDict)
    if listedTypesDict._rev[unitType] then
      return true
    end
    return false
  end

  function fdmm.unitTypes.getUnitType(value)
    local unitCategory, shapeName, unitType = fdmm.utils.splitTuple(value)
    unitType = unitType or value
    return unitType
  end

  function fdmm.unitTypes.getUnitTypeGroup(unitType)
    if fdmm.consts.UnitType.Plane.All._rev[unitType] then
      return fdmm.consts.UnitType.Plane
    elseif fdmm.consts.UnitType.Helicopter.All._rev[unitType] then
      return fdmm.consts.UnitType.Helicopter
    elseif fdmm.consts.UnitType.Ground.All._rev[unitType] then
      return fdmm.consts.UnitType.Ground
    elseif fdmm.consts.UnitType.Train.All._rev[unitType] then
      return fdmm.consts.UnitType.Train
    elseif fdmm.consts.UnitType.Ship.All._rev[unitType] then
      return fdmm.consts.UnitType.Ship
    elseif fdmm.consts.UnitType.Static.All._rev[unitType] or
           fdmm.consts.UnitType.Static.All._revShape[unitType] then
      return fdmm.consts.UnitType.Static
    end
    return nil
  end

  function fdmm.unitTypes.getUnitReportName(allianceType, unitType, unitTypeGroup)
    local allianceReportingKey = allianceType .. 'Reporting'
    local reportName = fdmm.consts.UnitType[allianceReportingKey][unitType]
    if string.isEmpty(reportName) then
      local unitTypeGroup = unitTypeGroup or fdmm.unitTypes.getUnitTypeGroup(unitType)
      local allianceReporting = unitTypeGroup[allianceReportingKey][unitType]
      local reportingFront, reportingBack, accessoryName = fdmm.utils.splitTuple(allianceReporting)
      reportingFront = reportingFront or allianceReporting
      reportName = unitTypeGroup.ReportNaming[unitType]
      local properName = unitTypeGroup.ProperNaming[unitType]

      if string.isNotEmpty(reportingFront) and string.contains(reportName, '%R') then
        reportName = reportName:gsub('%%R', reportingFront)
      end

      if string.isNotEmpty(accessoryName) and string.contains(reportName, '%N') then
        reportName = reportName:gsub('%%N', accessoryName)
      end

      if string.isNotEmpty(properName) and not string.contains(reportName, properName) then
        reportName = reportName .. ' ' .. properName
      end

      if string.isNotEmpty(reportingBack) and not string.contains(reportName, reportingBack) then
        reportName = reportName .. ' ' .. reportingBack
      end

      fdmm.consts.UnitType[allianceReportingKey][unitType] = reportName
    end
    return reportName
  end

  function fdmm.unitTypes.getNATOUnitReportName(unitType, unitTypeGroup)
    return fdmm.unitTypes.getUnitReportName(fdmm.enums.Alliance.NATO, unitType, unitTypeGroup)
  end

  function fdmm.unitTypes.getWTOUnitReportName(unitType, unitTypeGroup)
    return fdmm.unitTypes.getUnitReportName(fdmm.enums.Alliance.WTO, unitType, unitTypeGroup)
  end

  function fdmm.unitTypes.dumpUnitReportNames()
    env.info("FDMM: Dumping unit report names...")
    local function _dumpReportNames(unitTypeGroup)
      for _,fdmmUnitType in pairs(table.sortedKeysList(unitTypeGroup.All)) do
        if not string.hasPrefix(fdmmUnitType, '_') then
          local value = unitTypeGroup.All[fdmmUnitType]
          local unitType = fdmm.unitTypes.getUnitType(value)
          env.info("  [\'" .. fdmmUnitType .. "\'] = \'" .. unitType .. "\':")
          env.info("    NATO: " .. fdmm.unitTypes.getNATOUnitReportName(unitType, unitTypeGroup))
          env.info("    WTO : " .. fdmm.unitTypes.getWTOUnitReportName(unitType, unitTypeGroup))
        end
      end
    end
    _dumpReportNames(fdmm.consts.UnitType.Static)
  end

end -- /FDMM_UnitTypes

env.info("---FDMM_UnitTypes End---");
