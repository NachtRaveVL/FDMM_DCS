---
-- FDMM Unit Types Module.
-- @module FDMM_UnitTypes
env.info("---FDMM_UnitTypes Start---");

require('Additions/FDMM_LuaAdditions')

--- FDMM unit types module.
fdmm.unitTypes = {}

do --FDMM_UnitTypes

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
          Su33 = 'Su-33'
        },
        Interceptor = {
          F14A = 'F-14A', F14B = 'F-14B',
          F4E = 'F-4E',
          MiG21b = 'MiG-21Bis',
          MiG25PD = 'MiG-25PD',
          MiG31 = 'MiG-31'
        },
        Strike = {
          AJS37 = 'AJS37',
          F4E = 'F-4E',
          FA18A = 'F/A-18A', FA18C = 'F/A-18C', FA18Cl20 = 'FA-18C_hornet',
          Su17M4 = 'Su-17M4',
          Su34 = 'Su-34',
          TornadoGR4 = 'Tornado GR4', TornadoIDS = 'Tornado IDS'
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
          MiG29A = 'MiG-29A', MiG29G = 'MiG-29G', MiG29S = 'MiG-29S',
          Su27 = 'Su-27',
          Su30 = 'Su-30',
          Su33 = 'Su-33',
          TornadoGR4 = 'Tornado GR4', TornadoIDS = 'Tornado IDS'
        },
        Light = {
          F5E = 'F-5E', F5E3 = 'F-5E-3',
          F86F = 'F-86F Sabre',
          MiG15b = 'MiG-15bis',
          MiG19P = 'MiG-19P'
        },
      },
      Bomber = {
        Strategic = {
          B1B = 'B1-B',
          B52H = 'B-52H',
          Tu95MS = 'Tu-95MS',
          Tu160 = 'Tu-160'
        },
        Tactical = {
          Tu22M3 = 'Tu-22M3'
        },
        Attack = {
          A10A = 'A-10A', A10C = 'A-10C',
          AV8BNA = 'AV8BNA',
          MiG27K = 'MiG-27K',
          Su24M = 'Su-24M',
          Su25 = 'Su-25', Su25T = 'Su-25T', Su25TM = 'Su-25TM'
        },
        Stealth = {
          F117A = 'F-117A'
        },
        Light = {
          C101CC = 'C-101CC',
          L39ZA = 'L-39ZA'
        },
        ASW = {
          S3B = 'S-3B',
          Tu142 = 'Tu-142'
        },
      },
      Reconnaissance = {
        Arial = {
          An30M = 'An-30M',
          Tu142 = 'Tu-142'
        },
        Bomber = {
          MiG25RBT = 'MiG-25RBT',
          Su24MR = 'Su-24MR'
        },
        Drone = {
          MQ9 = 'MQ-9 Reaper',
          MQ1A = 'RQ-1A Predator'
        }
      },
      AWACS = {
        A50 = 'A-50',
        E2D = 'E-2C',
        E3A = 'E-3A',
        KJ2000 = 'KJ-2000'
      },
      Refueling = {
        IL78M = 'IL-78M',
        KC130 = 'KC130',
        KC135 = 'KC-135', KC135MPRS = 'KC135MPRS',
        S3BTanker = 'S-3B Tanker'
      },
      Transport = {
        Strategic = {
          C17A = 'C-17A',
          IL76MD = 'IL-76MD'
        },
        Tactical = {
          An26B = 'An-26B',
          C130 = 'C-130'
        },
        Civilian = {
          Yak40 = 'Yak-40'
        }
      },
      Trainer = {
        Jet = {
          C101EB = 'C-101EB',
          F16AMLU = 'F-16A MLU',
          HawkT1A = 'Hawk',
          L39C = 'L-39C'
        },
        Prop = {
          TF51D = 'TF-51D',
          Yak52 = 'Yak-52'
        }
      },
      Aerobatic = {
        CEII = 'Christen Eagle II'
      },
      All = {}, -- resolved on startup processing
      CarrierBorne = {
        AV8BNA = 'AV8BNA',
        E2D = 'E-2C',
        F4E = 'F-4E',
        FA18A = 'F/A-18A', FA18C = 'F/A-18C', FA18Cl20 = 'FA-18C_hornet',
        S3B = 'S-3B', S3BTanker = 'S-3B Tanker',
        Su33 = 'Su-33'
      },
      PlayerControllable = {
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
        MiG29A = 'MiG-29A', MiG29S = 'MiG-29S',
        Su25 = 'Su-25', Su25T = 'Su-25T',
        Su27 = 'Su-27',
        Su33 = 'Su-33',
        C101CC = 'C-101CC', C101EB = 'C-101EB',
        HawkT1A = 'Hawk',
        L39C = 'L-39C', L39ZA = 'L-39ZA',
        TF51D = 'TF-51D',
        Yak52 = 'Yak-52',
        CEII = 'Christen Eagle II'
      },
      NATOReporting = {
        ['A-50'] = 'Mainstay',
        ['An-26B'] = 'Curl',
        ['An-30M'] = 'Clank',
        ['IL-76MD'] = 'Candid',
        ['IL-78M'] = 'Midas',
        ['J-11A'] = 'Flanker-L',
        ['KJ-2000'] = 'Mainring',
        ['MiG-15bis'] = 'Fagot',
        ['MiG-19P'] = 'Farmer-B',
        ['MiG-21Bis'] = 'Fishbed-L/N',
        ['MiG-23MLD'] = 'Flogger-K',
        ['MiG-25RBT'] = 'Foxbat-B', ['MiG-25PD'] = 'Foxbat-E',
        ['MiG-27K'] = 'Flogger-J2',
        ['MiG-29A'] = 'Fulcrum-A', ['MiG-29S'] = 'Fulcrum-C',
        ['MiG-31'] = 'Foxhound',
        ['Su-17M4'] = 'Fitter-K',
        ['Su-24M'] = 'Fencer-D', ['Su-24MR'] = 'Fencer-E',
        ['Su-25'] = 'Frogfoot', ['Su-25T'] = 'Frogfoot', ['Su-25TM'] = 'Frogfoot',
        ['Su-27'] = 'Flanker', ['Su-30'] = 'Flanker-C', ['Su-33'] = 'Flanker-D',
        ['Su-34'] = 'Fullback',
        ['Tu-22M3'] = 'Backfire-C',
        ['Tu-95MS'] = 'Bear-H',
        ['Tu-142'] = 'Bear-F/J',
        ['Tu-160'] = 'Blackjack',
        ['Yak-40'] = 'Codling'
      },
      ChassisNaming = {
        ['A-10A'] = 'Thunderbolt II', ['A-10C'] = 'Thunderbolt II',
        ['AJS37'] = 'Viggen',
        ['AV8BNA'] = 'Harrier II',
        ['B1-B'] = 'Lancer',
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
        ['F-117A'] = 'Nighthawk',
        ['KC-135'] = 'Stratotanker', ['KC135MPRS'] = 'Stratotanker',
        ['L-39C'] = 'Albatros', ['L-39ZA'] = 'Albatros',
        ['S-3B'] = 'Viking', ['S-3B Tanker'] = 'Viking',
        ['TF-51D'] = 'Mustang'
      },
      ChassisNicknaming = {
        ['A-10A'] = 'Warthog', ['A-10C'] = 'Warthog',
        ['F-16A'] = 'Viper', ['F-16A MLU'] = 'Viper',
        ['F-16C bl.50'] = 'Viper', ['F-16C_50'] = 'Viper', ['F-16C bl.52d'] = 'Viper'
      }
    },
    Helicopter = {
      Attack = {
        AH1W = 'AH-1W',
        AH64A = 'AH-64A', AH64D = 'AH-64D',
        Ka50 = 'Ka-50',
        Mi24V = 'Mi-24V',
        Mi28N = 'Mi-28N'
      },
      Reconnaissance = {
        OH58D = 'OH-58D',
        SA342L = 'SA342L', SA342M = 'SA342M', SA342Mg = 'SA342Minigun', SA342Ms = 'SA342Mistral',
      },
      Light = {
        SA342L = 'SA342L', SA342M = 'SA342M', SA342Mg = 'SA342Minigun', SA342Ms = 'SA342Mistral',
        UH1H = 'UH-1H'
      },
      Transport = {
        Strategic = {
          CH47D = 'CH-47D',
          CH53E = 'CH-53E',
          Mi26 = 'Mi-26'
        },
        Tactical = {
          Mi8MTV2 = 'Mi-8MT',
          SH60B = 'SH-60B',
          UH1H = 'UH-1H',
          UH60A = 'UH-60A',
        },
        Assault = {
          Mi24V = 'Mi-24V',
          SH60B = 'SH-60B',
          UH1H = 'UH-1H',
          UH60A = 'UH-60A'
        }
      },
      ASW = {
        Ka27 = 'Ka-27'
      },
      All = {}, -- resolved on startup processing
      CarrierBorne = {
        CH53E = 'CH-53E',
        Ka27 = 'Ka-27',
        SH60B = 'SH-60B'
      },
      NATOReporting = {
        ['Ka-27'] = 'Helix',
        ['Ka-50'] = 'Hokum-A',
        ['Mi-8MT'] = 'Hip',
        ['Mi-24V'] = 'Hind-E',
        ['Mi-26'] = 'Halo',
        ['Mi-28N'] = 'Havoc'
      },
      ChassisNaming = {
        ['AH-1W'] = 'Cobra',
        ['AH-64A'] = 'Apache', ['AH-64D'] = 'Apache',
        ['CH-47D'] = 'Chinook',
        ['CH-53E'] = 'Sea Stallion',
        ['Ka-50'] = 'Black Shark',
        ['OH-58D'] = 'Kiowa',
        ['SA342L'] = 'Gazelle', ['SA342M'] = 'Gazelle', ['SA342Minigun'] = 'Gazelle', ['SA342Mistral'] = 'Gazelle',
        ['SH-60B'] = 'Seahawk',
        ['UH-1H'] = 'Huey',
        ['UH-60A'] = 'Black Hawk'
      },
      ChassisNicknaming = {
        ['Mi-24V'] = 'Crocodile',
      }
    },
    Ground = {
      Tracked = {
        HQ = {
          Sborka9S80M1 = 'Dog Ear radar'
        },
        MBT = {
          ChallengerII = 'Challenger2',
          Leclerc = 'Leclerc',
          Leopard1A3 = 'Leopard1A3',
          Leopard2 = 'Leopard-2',
          M1A2Abrams = 'M-1 Abrams',
          M60A3Patton = 'M-60',
          MerkavaMk4 = 'Merkava_Mk4',
          T55 = 'T-55',
          T72B = 'T-72B',
          T80U = 'T-80UD',
          T90 = 'T-90',
          ZTZ96B = 'ZTZ96B'
        },
        IFV = {
          BMD1 = 'BMD-1',
          BMP1 = 'BMP-1',
          BMP2 = 'BMP-2',
          BMP3 = 'BMP-3',
          M2A2Bradley = 'M-2 Bradley',
          Marder = 'Marder',
          MCV80 = 'MCV-80',
          ZBD04A = 'ZBD04A'
        },
        ARV = {
          BRDM2 = 'BRDM-2',
          BTRRD = 'BTR_D', -- airborne
          MTLBU_BOMAN = 'Boman'
        },
        APC = {
          AAV7 = 'AAV7', -- marines
          M1043HMMWVMg = 'M1043 HMMWV Armament',
          M1126StrykerICV = 'M1126 Stryker ICV',
          M113 = 'M-113',
          MTLB = 'MTLB'
        },
        MLRS = {
          M270 = { -- also has wheeled components
            _HasWheeledComps = true,
            Launcher = {
              M270Launcher = 'MLRS'
            }
          },
        },
        SPH = {
          M109Paladin = 'M-109',
          S2S1Gvozdika = 'SAU Gvozdika',
          S2S19Msta = 'SAU Msta',
          S2S3Akatsia = 'SAU Akatsia',
          S2S9Nona = 'SAU 2-C9',
          SpGHDana = 'SpGH_Dana'
        },
        EWR = {
          RolandEWR = 'Roland Radar'
        },
        SAM = {
          M48Chaparral = 'M48 Chaparral',
          M6Linebacker = 'M6 Linebacker',
          RolandADS = 'Roland ADS',
          SA6 = {
            SearchTrackRadar = {
              SA6KubSTR_1S91 = 'Kub 1S91 str'
            },
            Launcher = {
              SA6KubLN_2P25 = 'Kub 2P25 ln'
            }
          },
          SA11 = {
            HQ = {
              SA11BukCC_9S470M1 = 'SA-11 Buk CC 9S470M1'
            },
            SearchRadar = {
              SA11BukSR_9S18M1 = 'SA-11 Buk SR 9S18M1'
            },
            Launcher = {
              SA11BukLN_9A310M1 = 'SA-11 Buk LN 9A310M1'
            }
          },
          SA13Strela10M3_9A35M3 = 'Strela-10M3',
          SA15Tor_9A331 = 'Tor 9A331',
          SA19Tunguska_2S6 = '2S6 Tunguska'
        },
        AAA = {
          SPAAAGepard = 'Gepard',
          ZSU234Shilka = 'ZSU-23-4 Shilka',
          M163Vulcan = 'Vulcan'
        }
      },
      Wheeled = {
        HQ = {
          SKP11ATCMCP = 'SKP-11',
          Ural375PBU = 'Ural-375 PBU',
          ZIL131KUNG = 'ZIL-131 KUNG'
        },
        SPG = {
          M1128StrykerMGS = 'M1128 Stryker MGS'
        },
        ATGM = {
          M1024HMMWVTOW = 'M1045 HMMWV TOW',
          M1134StrykerATGM = 'M1134 Stryker ATGM'
        },
        ARV = {
          LAV25 = 'LAV-25'
        },
        APC = {
          BMT2Cobra = 'Cobra',
          BTR80 = 'BTR-80',
          M1025HMMWV = 'Hummer',
          TPzFuchs = 'TPZ'
        },
        SSM = {
          ScudBLauncher = 'Scud_B'
        },
        MLRS = {
          BM21Grad = 'Grad-URAL',
          BM279K57Uragan = 'Uragan_BM-27',
          BM309A52Smerch = 'Smerch',
          M270 = { -- also has tracked components
            _HasTrackedComps = true,
            HQ = {
              M270FDDM = 'MLRS FDDM'
            }
          }
        },
        EWR = {
          P1455G6 = '55G6 EWR',
          P181L13 = '1L13 EWR'
        },
        SAM = {
          AvengerM1097 = 'M1097 Avenger',
          HQ7 = {
            SearchTrackRadar = {
              HQ7STR = 'HQ-7_STR_SP'
            },
            Launcher = {
              HQ7LN = 'HQ-7_LN_SP'
            }
          },
          Patriot = { -- also has stationary components
            _HasStationaryComps = true,
            HQ = {
              PatriotECS_ANMSQ104 = 'Patriot ECS'
            },
            DataProcessing = {
              PatriotICC = 'Patriot cp'
            },
            Power = {
              PatriotEPPIII = 'Patriot EPP'
            },
            Antenna = {
              PatriotAMG_ANMRC137 = 'Patriot AMG'
            }
          },
          SA3S125 = { -- also has stationary components
            _HasStationaryComps = true,
            SearchRadar = {
              SA3S125SR_P19 = 'p-19 s-125 sr'
            }
          },
          SA8Osa_9A33 = 'Osa 9A33 ln',
          SA9Strela1_9P31 = 'Strela-1 9P31',
          SA10S300PS = { -- also has stationary components
            _HasStationaryComps = true,
            HQ = {
              SA10S300PSCP_54K6 = 'S-300PS 54K6 cp'
            },
            SearchRadar = {
              SA10S300PSSR_64H6E = 'S-300PS 64H6E sr'
            },
            MasterLauncher = {
              SA10S300PSLN_5P85C = 'S-300PS 5P85C ln'
            },
            SlaveLauncher = {
              SA10S300PSLN_5P85D = 'S-300PS 5P85D ln'
            }
          }
        },
        AAA = {
          Soldier = {
            ZU23Ural375 = 'Ural-375 ZU-23'
          },
          Insurgent = {
            ZU23Ural375_Insurgent = 'Ural-375 ZU-23 Insurgent'
          }
        },
        Power = {
          APA5D_Ural4320 = 'Ural-4320 APA-5D',
          APA80_ZIL131 = 'ZiL-131 APA-80'
        },
        Police = {
          Tigr_233036 = 'Tigr_233036'
        },
        Fire = {
          TFFTHEMTT = 'HEMTT TFFT',
          UralATsP6 = 'Ural ATsP-6'
        },
        Transport = {
          Armored = {
            Ural432031A = 'Ural-4320-31'
          },
          Open = {
            GAZ66 = 'GAZ-66',
            Ural375 = 'Ural-375'
          },
          Covered = {
            GAZ3308 = 'GAZ-3308',
            KAMAZ43101 = 'KAMAZ Truck',
            KrAZ6322 = 'KrAZ6322',
            LandRover101FC = 'Land_Rover_101_FC',
            M818 = 'M 818',
            Ural4320T = 'Ural-4320T'
          },
          Lubricant = {
            ATMZ5 = 'ATMZ-5'
          },
          Fuel = {
            ATZ10 = 'ATZ-10',
            M978HEMTT = 'M978 HEMTT Tanker'
          }
        },
        Car = {
          M1025HMMWV = 'Hummer',
          LandRover109S3 = 'Land_Rover_109_S3',
          UAZ469 = 'UAZ-469'
        }
      },
      Stationary = {
        DroneCommand = {
          HQ = {
            PreadtorGCS = 'Predator GCS'
          },
          Dish = {
            PredatorTS = 'Predator TrojanSpirit'
          }
        },
        SSM = {
          SSN2 = {
            SearchRadar = {
              SSN2SilkwormSR = 'Silkworm_SR'
            },
            Launcher = {
              SSN2SilkwormLN = 'hy_launcher'
            }
          }
        },
        SAM = {
          Hawk = {
            HQ = {
              HawkPCP = 'Hawk pcp'
            },
            ContWaveAcqRadar = {
              HawkCWAR = 'Hawk cwar'
            },
            SearchRadar = {
              HawkSR = 'Hawk sr'
            },
            TrackRadar = {
              HawkTR = 'Hawk tr'
            },
            Launcher = {
              HawkLN_M192 = 'Hawk ln'
            }
          },
          Patriot = { -- also has wheeled components
            _HasWheeledComps = true,
            Launcher = {
              Patriot_LNM901 = 'Patriot ln'
            },
            SearchTrackRadar = {
              PatriotSTR_ANMPQ53 = 'Patriot str'
            }
          },
          Rapier = {
            TrackRadar = {
              RapierFSATR = 'rapier_fsa_blindfire_radar'
            },
            TrackOptical = {
              RapierFSATO = 'rapier_fsa_optical_tracker_unit'
            },
            Launcher = {
              RapierFSALN = 'rapier_fsa_launcher'
            }
          },
          SA2S75 = {
            TrackRadar = {
              SA2S75TR_SNR75 = 'SNR_75V'
            },
            Launcher = {
              SA2S75LN_SM90 = 'S_75M_Volhov'
            }
          },
          SA3S125 = { -- also has wheeled components
            _HasWheeledComps = true,
            TrackRadar = {
              SA3S125TR_SNR = 'snr s-125 tr'
            },
            Launcher = {
              SA3S125L_N5P73 = '5p73 s-125 ln'
            }
          },
          SA10S300PS = { -- also has wheeled components
            _HasWheeledComps = true,
            SearchRadar = {
              SA10S300PSSR_5N66M = 'S-300PS 40B6MD sr'
            },
            TrackRadar = {
              SA10S300PSTR_30N6 = 'S-300PS 40B6M tr'
            }
          }
        },
        AAA = {
          Soldier = {
            Fortified = {
              ZU23Closed = 'ZU-23 Emplacement Closed'
            },
            Emplacement = {
              ZU23 = 'ZU-23 Emplacement'
            }
          },
          Insurgent = {
            Fortified = {
              ZU23Closed_Insurgent = 'ZU-23 Closed Insurgent'
            },
            Emplacement = {
              ZU23_Insurgent = 'ZU-23 Insurgent'
            }
          }
        }
      },
      Infantry = {
        Mortar = {
          M2B11 = '2B11 mortar'
        },
        SAM = {
          SA18 = {
            Soldier = {
              Comms = {
                SA18IGLAComms = 'SA-18 Igla comm'
              },
              Launcher = {
                IGLAMANPADS = 'SA-18 Igla manpad'
              }
            },
            Insurgent = {
              Comms = {
                SA18IGLAComms = 'SA-18 Igla comm'
              },
              Launcher = {
                SA18IGLAMANPADS_Insurgent = 'Igla manpad INS'
              }
            }
          },
          SA24 = {
            Comms = {
              IGLASComms = 'SA-18 Igla-S comm'
            },
            Launcher = {
              IGLASMANPADS = 'SA-18 Igla-S manpad'
            }
          },
          Stinger = {
            Comms = {
              StingerComms = 'Stinger comm', -- desert version adds ' dsr', resolved on startup processing  
            },
            Launcher = {
              StingerMANPADS = 'Soldier stinger'
            }
          }
        },
        MG = {
          SoldierM249 = 'Soldier M249'
        },
        Rifle = {
          Soldier = {
            GeorgianM4 = 'Soldier M4 GRG',
            SoldierM4 = 'Soldier M4',
            RussianAK = 'Infantry AK',
            SoldierAK = 'Soldier AK'
          },
          Insurgent = {
            InsurgentAK = 'Infantry AK Ins'
          },
          Paratrooper = {
            ParatroopAKS74 = 'Paratrooper AKS-74'
          }
        },
        RPG = {
          Soldier = {
            SoldierRPG = 'Soldier RPG'
          },
          Insurgent = {
            SoldierRPG = 'Soldier RPG'
          },
          Paratrooper = {
            ParatroopRPG16 = 'Paratrooper RPG-16'
          }
        }
      },
      Civilian = {
        Trailer = {
          MAZ6303 = 'MAZ-6303'
        },
        Truck = {
          Fire = {
            UralATsP6 = 'Ural ATsP-6'
          },
          Transport = {
            Open = {
              ZIL4331 = 'ZIL-4331'
            },
            Covered = {
              GAZ3307 = 'GAZ-3307'
            }
          }
        },
        Bus = {
          Double = {
            IKARUS280 = 'IKARUS Bus'
          },
          Single = {
            LAZ695 = 'LAZ Bus',
            ZIU9 = 'Trolley bus'
          }
        },
        Car = {
          VAZ2109 = 'VAZ Car'
        },
      },
      All = {}, -- resolved on startup processing
      Amphibious = { -- vehicles that can float on water (not just ford rivers)
        AAV7 = 'AAV7',
        BMP1 = 'BMP-1',
        BMP2 = 'BMP-2',
        BRDM2 = 'BRDM-2',
        BTRRD = 'BTR_D',
        LAV25 = 'LAV-25',
        MTLB = 'MTLB',
        MTLBU_BOMAN = 'Boman',
        SA8Osa_9A33 = 'Osa 9A33 ln',
        S2S1Gvozdika = 'SAU Gvozdika',
        S2S9Nona = 'SAU 2-C9'
      },
      HeavyWheeled = { -- wheeled vehicles less likely to get stuck in the mud
        TFFTHEMTT = 'HEMTT TFFT',
        M978HEMTT = 'M978 HEMTT Tanker',
        SA10S300PSCP_54K6 = 'S-300PS 54K6 cp',
        SA10S300PSSR_64H6E = 'S-300PS 64H6E sr',
        SA10S300PSLN_5P85C = 'S-300PS 5P85C ln',
        SA10S300PSLN_5P85D = 'S-300PS 5P85D ln',
        ScudBLauncher = 'Scud_B',
        TPzFuchs = 'TPZ'
      },
      NATOReporting = {
        ['Dog Ear radar'] = 'Dog Ear',
        ['S_75M_Volhov'] = 'Guideline', ['SNR_75V'] = 'Fan Song',
        ['5p73 s-125 ln'] = 'Goa', ['snr s-125 tr'] = 'Low Blow',
        ['p-19 s-125 sr'] = 'Flat Face B',
        ['Kub 2P25 ln'] = 'Gainful', ['Kub 1S91 str'] = 'Straight Flush',
        ['Strela-1 9P31'] = 'Gaskin',
        ['S-300PS 54K6 cp'] = 'Grumble', ['S-300PS 64H6E sr'] = 'Big Bird',
        ['S-300PS 5P85C ln'] = 'Grumble', ['S-300PS 5P85D ln'] = 'Grumble',
        ['S-300PS 40B6MD sr'] = 'Clam Shell', ['S-300PS 40B6M tr'] = 'Flap Lid A',
        ['SA-11 Buk CC 9S470M1'] = 'Gadfly', ['SA-11 Buk LN 9A310M1'] = 'Gadfly',
        ['SA-11 Buk SR 9S18M1'] = 'Tube Arm',
        ['Strela-10M3'] = 'Gopher',
        ['Tor 9A331'] = 'Gauntlet',
        ['SA-18 Igla comm'] = 'Grouse', ['SA-18 Igla manpad'] = 'Grouse', ['Igla manpad INS'] = 'Grouse',
        ['SA-18 Igla-S comm'] = 'Grinch', ['SA-18 Igla-S manpad'] = 'Grinch',
        ['2S6 Tunguska'] = 'Grison',
        ['55G6 EWR'] = 'Tall King',
        ['1L13 EWR'] = 'Spoon Rest D'
      },
      ChassisNaming = {
      },
      ChassisNicknaming = {
        ['Hummer'] = 'Humvee', ['M1043 HMMWV Armament'] = 'Humvee', ['M1045 HMMWV TOW'] = 'Humvee'
      }
    },
    Ship = {
      Carrier = {
      },
      HeliCarrier = {
      },
      Cruiser = {
      },
      Destroyer = {
      },
      Frigate = {
      },
      Corvette = {
      },
      Submarine = {
      },
      Transport = {
      },
      Civilian = {
      },
      All = {}, -- resolved on startup processing
      ChassisNaming = {
      },
      ChassisNicknaming = {
      }
    },
    Train = {
      Transport = {
        Locomotive = {
        },
        Closed = {
        },
        Open = {
        },
        Flatbed = {
        },
        Fuel = {
        },
      },
      Civilian = {
        Locomotive = {
        },
        Passenger = {
        }
      },
      All = {}, -- resolved on startup processing
      ChassisNaming = {
      },
      ChassisNicknaming = {
      }
    }
  }

  function fdmm.unitTypes.processEntries()
    if fdmm.utils.isDesertMap() then
       fdmm.consts.UnitType.Ground.Infantry.SAM.Stinger.Comms.StingerComms =
       fdmm.consts.UnitType.Ground.Infantry.SAM.Stinger.Comms.StingerComms .. ' dsr' 
    end

    local keyFilter = { 'All', 'PlayerControllable', 'CarrierBorne', 'HeavyWheeled', 'NATOReporting', 'ChassisNaming', 'ChassisNicknaming' }
    local function createAll_recurse(node, allList)
      for key, value in pairs(node) do
        if not (string.hasPrefix(key, '_') or table.contains(keyFilter, key)) then -- filter out keys
          if type(value) == 'table' then
            createAll_recurse(value, allList) -- recurse, b/c table
          elseif type(value) == 'string' then -- valid value
            if not allList[key] then -- not yet found
              allList[key] = value
            elseif allList[key] ~= value then -- different than what we have
              env.error("All list descrepancy for key=\'" .. key .. "\', allList[key]=\'" .. allList[key] .. "\' ~= value=\'" .. value .. "\'.")
            end
          end
        end
      end
    end

    createAll_recurse(fdmm.consts.UnitType.Plane, fdmm.consts.UnitType.Plane.All)
    createAll_recurse(fdmm.consts.UnitType.Helicopter, fdmm.consts.UnitType.Helicopter.All)
    createAll_recurse(fdmm.consts.UnitType.Ground, fdmm.consts.UnitType.Ground.All)
    createAll_recurse(fdmm.consts.UnitType.Ship, fdmm.consts.UnitType.Ship.All)
    createAll_recurse(fdmm.consts.UnitType.Train, fdmm.consts.UnitType.Train.All)
    -- createAll_recurse(fdmm.consts.UnitType.Fortification, fdmm.consts.UnitType.Fortification.All)
    -- createAll_recurse(fdmm.consts.UnitType.Static, fdmm.consts.UnitType.Fortification.Static)
  end

  function fdmm.unitTypes.isCarrierBorne(unitType)
  end

  function fdmm.unitTypes.isPlayerControllable(unitType)
  end

  function fdmm.unitTypes.isAmphibious(unitType)
  end

  function fdmm.unitTypes.isHeavyWheeled(unitType)
  end

  function fdmm.unitTypes.getNATOReporting(unitType)
  end

  function fdmm.unitTypes.getChassisName(unitType)
  end

  function fdmm.unitTypes.getChassisNickname(unitType)
  end

end --FDMM_UnitTypes

env.info("---FDMM_UnitTypes End---");
