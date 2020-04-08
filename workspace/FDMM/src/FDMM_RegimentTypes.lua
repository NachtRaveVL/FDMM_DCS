---
-- FDMM Regiment Types Module.
-- @module FDMM_RegimentTypes
env.info("---FDMM_RegimentTypes Start---");

require('Additions/FDMM_LuaAdditions')
require('Utilities/FDMM_YearRange')

--- FDMM regiment types module.
fdmm.regimentTypes = {}

do -- FDMM_RegimentTypes

  --- Regiment type table.
  -- A structure of regiment types (composition, OoB, etc).
  -- Dates should be ranged [BeginningYear,EndingYear].
  -- Also contains a lot of categorization that FDMM relies upon.
  -- @note See something wrong? Say something! That way we can fix it.
  -- @type Consts.RegimentType
  fdmm.consts.RegimentType = {
    Caucasus = {
      Navy = {
        Russia = {
          BlackSeaFleet = { -- TODO: Fix all BSF active dates. They're in [,) instead of [,]. -NR
            Name = "Black Sea Fleet",
            Regiments = {
              ['30thSurfaceShip'] = {
                Name = "30th Surface Ship Division",
                Units = {
                  Moskva = { -- Slava Cruiser
                    Name = { [1982] = "Slava", [1995] = "Moskva" },
                    Type = fdmm.consts.UnitType.Ship.Cruiser.Slava_Moskva,
                    Command = true,
                    Active = { { 1982, 9999 } },
                    ReportNaming = "GRKR-%H %N",
                    HullNumbering = {
                      [1983] = {"126", "108"}, [1984] = "103", [1987] = "106", [1990] = "121",
                    }
                  },
                  Kuznetsov = { -- Kuznetsov Carrier
                    Name = "Admiral Kuznetsov",
                    Type = fdmm.consts.UnitType.Ship.Carrier.Kuznetsov_AdmiralKuznetsov,
                    Command = true,
                    Active = { { 1990, 9999 } },
                    ReportNaming = "TAKR-%H %N",
                    HullNumbering = {
                      [1989] = "111", [1990] = "113", ['1991?1995'] = { "082", "062" }, [1995] = "063",
                    },
                  },
                  Deyatelnyy = { -- Krivak Destroyer
                    Name = "Deyatelnyy",
                    Type = fdmm.consts.UnitType.Ship.Frigate.KrivakII_Rezky,
                    Active = { { 1975, 1995 } },
                    ReportNaming = "SKR-%H %N",
                    HullNumbering = {
                      [1975] = "193", [1976] = { "192", "533", "196" }, [1979] = { "800", "801" },
                      ['1980?1984'] = "810", [1984] = "814", [1986] = "813", [1992] = "811",
                    },
                  },
                  Bezukoriznennyy = { -- Krivak Destroyer
                    Name = "Bezukoriznennyy",
                    Type = fdmm.consts.UnitType.Ship.Frigate.KrivakII_Rezky,
                    Active = { { 1979, 1997 } },
                    ReportNaming = "SKR-%H %N",
                    HullNumbering = {
                      [1978] = "811", [1981] = "813", [1985] = "820", [1987] = "807", [1989] = "888", [1990] = "802",
                    },
                  },
                  Bezzavetnyy = { -- Krivak Destroyer
                    Name = "Bezzavetnyy",
                    Type = fdmm.consts.UnitType.Ship.Frigate.KrivakII_Rezky,
                    Active = { { 1977, 1997 } },
                    ReportNaming = "SKR-%H %N",
                    HullNumbering = {
                      ['1900?1978'] = "195", [1978] = { "192", "805", "878" }, [1981] = "811", [1984] = "817",
                      [1988] = "811", [1997] = "807",
                    },
                  },
                  Razitelnyy = { -- Krivak Destroyer
                    Name = "Razitelnyy",
                    Type = fdmm.consts.UnitType.Ship.Frigate.KrivakII_Rezky,
                    Active = { { 1976, 1997 } },
                    ReportNaming = "SKR-%H %N",
                    HullNumbering = {
                      [1976] = "235", [1977] = { "232", "249" }, [1978] = { "165", "808" }, [1979] = "812",
                      [1980] = "806", ['1981?1984'] = { "195", "801" }, [1984] = "804", [1987] = "821",
                      [1989] = "807", [1990] = "819",
                    },
                  },
                  Pylkiy = { -- Krivak Destroyer
                    Name = "Pylkiy",
                    Type = fdmm.consts.UnitType.Ship.Frigate.KrivakII_Rezky,
                    Active = { { 1978, 1993 } },
                    ReportNaming = "SKR-%H %N",
                    HullNumbering = {
                      [1978] = "518", [1981] = "806", ['1981?1982'] = { "810", "819", "813" }, [1982] = "807",
                      [1984] = "808", [1985] = "758", [1987] = "809", [1988] = "807", [1993] = "702",
                    },
                  },
                  Pytlivyy = { -- Krivak Destroyer
                    Name = "Pytlivyy",
                    Type = fdmm.consts.UnitType.Ship.Frigate.KrivakII_Rezky,
                    Active = { { 1981, 9999 } },
                    ReportNaming = "SKR-%H %N",
                    HullNumbering = {
                      [1981] = { "942", "751" }, ['1981?1982'] = "916", [1982] = { "759", "888" }, [1984] = "826",
                      [1988] = "889", [1990] = "808", [2016] = "868",
                    },
                  },
                  Ladny = { -- Krivak Destroyer
                    Name = "Ladny",
                    Type = fdmm.consts.UnitType.Ship.Frigate.KrivakII_Rezky,
                    Active = { { 1981, 9999 } },
                    ReportNaming = "SKR-%H %N",
                    HullNumbering = {
                      ['1900?1981'] = "802", [1981] = "815", [1986] = "824", [1990] = "801", [2016] = "861"
                    },
                  },
                }, -- /30th Surface Ship Units
                Reinforcements = {
                  Kalinin = { -- Kirov BattleCruiser
                    Name = { [1988] = "Kalinin", [2006] = "Admiral Nakhimov" },
                    Type = fdmm.consts.UnitType.Ship.BattleCruiser.Kirov_PyotrVelikiy,
                    Command = true,
                    Active = { { 1988, 9999 } },
                    Inactive = { { 2006, 2022 } },
                    ReportNaming = "RKA-%H %N",
                    HullNumbering = {
                      [1988] = "180", [1989] = "064", [1990] = "085", [1994] = "080",
                    },
                  },
                  Neustrashimy = { -- Neustrashimy Destroyer
                    Name = "Neustrashimy",
                    Type = fdmm.consts.UnitType.Ship.Destroyer.Neustrashimy_Neustrashimy,
                    Active = { { 1990, 9999 } },
                    ReportNaming = "BPK-%H %N",
                    HullNumbering = {
                      [1990] = "712", [2017] = "772",
                    },
                  },
                }, -- /30th Surface Ship Reinforcement Units
              }, -- /30th Surface Ship Regiment
              ['4thIndependentSubmarine'] = {
                Name = "4th Independent Submarine Brigade",
                Units = {
                  B871 = { -- Kilo Submarine
                    Name = "B-871 Alrosa",
                    Type = fdmm.consts.UnitType.Ship.Submarine.Kilo,
                    Active = { { 1990, 9999 } },
                    ReportNaming = "DPL-%H %N",
                    HullNumbering = {
                      [1990] = "596", [1993] = "554",
                    },
                  },
                  B380 = { -- Tango Submarine
                    Name = { [1982] = "Gorkovsky Komsomolets", [1992] = "B-380", [2008] = "Svyatoi Kniaz Georgy" },
                    Type = fdmm.consts.UnitType.Ship.Submarine.Tango,
                    Active = { { 1982, 2016 } },
                    ReportNaming = "DPL-%H %N",
                    HullNumbering = {
                      ['1900?1990'] = "594", [1990] = "572",
                    },
                  },
                  B498 = { -- Tango Submarine
                    Name = "B-498",
                    Type = fdmm.consts.UnitType.Ship.Submarine.Tango,
                    Active = { { 1975, 1995 } },
                    ReportNaming = "DPL-%H %N",
                    HullNumbering = {
                      [1989] = "244", [1991] = "450",
                    },
                  },
                }, -- /4th Independent Submarine Units
              }, -- /4th Independent Submarine Regiment
              ['68thCoastalDefense'] = {
                Name = "68th Coastal Defense Ship Brigade",
                Regiments = {
                  ['149thAntiSubmarineTactical'] = {
                    Name = "149th Anti-Submarine Ships Tactical Group",
                    Units = {
                      Alexandrovets = { -- Grisha Frigate
                        Name = { [1982] = "MPK-49", [2004] = "Alexandrovets" },
                        Type = fdmm.consts.UnitType.Ship.Frigate.GrishaV,
                        Active = { { 1982, 9999 } },
                        ReportNaming = "MPK-%H %N",
                        HullNumbering = {
                          [1987] = "057", [1989] = "082", [1990] = "059",
                        },
                      },
                      Suzdalets = { -- Grisha Frigate
                        Name = { [1983] = "Komsomolets Moldavii", [1992] = "MPK-118", [1999] = "Suzdalets" },
                        Type = fdmm.consts.UnitType.Ship.Frigate.GrishaV,
                        Active = { { 1983, 9999 } },
                        ReportNaming = "MPK-%H %N",
                        HullNumbering = {
                          [1983] = "053", [1990] = "071",
                        },
                      },
                      Muromets = { -- Grisha Frigate
                        Name = { [1982] = "Kievskiy komsomolets", [1992] = "MPK-134", [1999] = "Muromets" },
                        Type = fdmm.consts.UnitType.Ship.Frigate.GrishaV,
                        Active = { { 1982, 9999 } },
                        ReportNaming = "MPK-%H %N",
                        HullNumbering = {
                          [1983] = "085", [1985] = "073", [1987] = "061", [1989] = "064",
                        },
                      },
                    }, -- /149th Anti-Submarine Units
                  }, -- /149th Anti-Submarine Regiment
                  ['400thAntiSubmarineWarfare'] = {
                    Name = "400th Anti-Submarine Warfare Battalion",
                    Units = {
                      MPK5 = { -- Grisha Frigate
                        Name = "MPK-5",
                        Type = fdmm.consts.UnitType.Ship.Frigate.GrishaV,
                        Active = { { 1970, 1993 } },
                        ReportNaming = "MPK-%H %N",
                        HullNumbering = {
                          ['1900?1990'] = { "060", "077" }, [1990] = "072",
                        },
                      },
                      MPK6 = { -- Grisha Frigate
                        Name = "MPK-6",
                        Type = fdmm.consts.UnitType.Ship.Frigate.GrishaV,
                        Active = { { 1978, 1998 } },
                        ReportNaming = "MPK-%H %N",
                        HullNumbering = {
                          [1978] = "059", [1990] = "073",
                        },
                      },
                      MPK8 = { -- Grisha Frigate
                        Name = "MPK-8",
                        Type = fdmm.consts.UnitType.Ship.Frigate.GrishaV,
                        Active = { { 1973, 1992 } },
                        ReportNaming = "MPK-%H %N",
                        HullNumbering = {
                          [1973] = "274", [1975] = "288", [1979] = "054", [1981] = "052", [1991] = "069",
                        },
                      },
                      MPK43 = { -- Grisha Frigate
                        Name = { [1974] = "MPK-43", [1983] = "Odesskiy komsomolets", [1992] = "MPK-43" },
                        Type = fdmm.consts.UnitType.Ship.Frigate.GrishaV,
                        Active = { { 1974, 1997 } },
                        ReportNaming = "MPK-%H %N",
                        HullNumbering = {
                          [1975] = "274", [1976] = "297", [1979] = "092", [1981] = "081", [1983] = "054",
                          ['1984?1991'] = "052", [1991] = "075",
                        },
                      },
                      MPK52 = { -- Grisha Frigate
                        Name = "MPK-52",
                        Type = fdmm.consts.UnitType.Ship.Frigate.GrishaV,
                        Active = { { 1971, 1997 } },
                        ReportNaming = "MPK-%H %N",
                        HullNumbering = {
                          [1973] = "198", ['1974?1992'] = { "190", "057" }, [1992] = "068",
                        },
                      },
                      MPK127 = { -- Grisha Frigate
                        Name = { [1976] = "MPK-127", [1980] = "Komsomolets Gruzii", [1992] = "MPK-127" },
                        Type = fdmm.consts.UnitType.Ship.Frigate.GrishaV,
                        Active = { { 1976, 2005 } },
                        ReportNaming = "MPK-%H %N",
                        HullNumbering = {
                          ['1900?1989'] = "059", [1989] = "084", [1990] = "078",
                        },
                      },
                      MPK147 = { -- Grisha Frigate
                        Name = "MPK-147",
                        Type = fdmm.consts.UnitType.Ship.Frigate.GrishaV,
                        Active = { { 1970, 1994 } },
                        ReportNaming = "MPK-%H %N",
                        HullNumbering = {
                          [1971] = "279", [1973] = "277", ['1974?1981'] = { "274", "287" }, [1981] = "061",
                          [1988] = "071", [1992] = "070",
                        },
                      },
                    }, -- /400th Anti-Submarine Units
                  }, -- /400th Anti-Submarine Regiments
                }, -- /68th Coastal Defense Regiments
              }, -- /68th Coastal Defense Regiment
              ['184th Coastal Defense'] = {
                Name = {
                  [1961] = "184th Anti-Submarine Warfare Brigade",
                  [1976] = "184th Coastal Defense Ship Brigade",
                },
                Regiments = {
                  ['181thAntiSubmarineTactical'] = {
                    Name = "181th Anti-Submarine Ships Tactical Group",
                    Units = {
                      Povorino = { -- Grisha Frigate
                        Name = { [1989] = "MPK-207", [1999] = "Povorino" },
                        Type = fdmm.consts.UnitType.Ship.Frigate.GrishaV,
                        Active = { { 1989, 9999 } },
                        ReportNaming = "MPK-%H %N",
                        HullNumbering = {
                          [1989] = "093", [1990] = "053",
                        },
                      },
                      Eysk = { -- Grisha Frigate
                        Name = { [1989] = "MPK-217", [1999] = "Eysk" },
                        Type = fdmm.consts.UnitType.Ship.Frigate.GrishaV,
                        Active = { { 1989, 9999 } },
                        ReportNaming = "MPK-%H %N",
                        HullNumbering = {
                          [1989] = "094", [1990] = "054",
                        },
                      },
                      Kasimov = { -- Grisha Frigate
                        Name = { [1986] = "Komsomolets Armenii", [1992] = "MPK-199", [2001] = "Kasimov" },
                        Type = fdmm.consts.UnitType.Ship.Frigate.GrishaV,
                        Active = { { 1986, 9999 } },
                        ReportNaming = "MPK-%H %N",
                        HullNumbering = {
                          [1989] = "095", [1990] = "055",
                        },
                      },
                    }, -- /181th Anti-Submarine Units
                  }, -- /181th Anti-Submarine Regiment
                }, -- /184th Coastal Defense Regiments
              }, -- /184th Coastal Defense Regiment
              ['41thMissileBoat'] = {
                Name = {
                  [1958] = "41st Torpedo Boat Brigade",
                  [1961] = "41th Missile Boat Brigade",
                },
                Regiments = {
                  ['166thNovorossiyskyMissile'] = {
                    Name = "166th Novorossiysky Small Missile Ship Battalion",
                    Units = {
                      R46 = { -- Tarantul Corvette
                        Name = "R-46",
                        Type = fdmm.consts.UnitType.Ship.Corvette.TarantulIII,
                        Active = { { 1981, 1994 } },
                        ReportNaming = "RKA-%H %N",
                        HullNumbering = {
                          [1984] = "948", [1986] = "957", [1990] = "960",
                        },
                      },
                      R160 = { -- Tarantul Corvette
                        Name = { [1988] = "R-160", [1990] = "Poltavskiy komsomolets", [1992] = "R-160" },
                        Type = fdmm.consts.UnitType.Ship.Corvette.TarantulIII,
                        Active = { { 1988, 2018 } },
                        ReportNaming = "RKA-%H %N",
                        HullNumbering = {
                          [1987] = "870", [1988] = "965", [1991] = "709", [1997] = "700", [2004] = "054",
                        },
                      },
                      R239 = { -- Tarantul Corvette
                        Name = { [1992] = "R-239", [2018] = "R-239 Naberezhnye Chelny" },
                        Type = fdmm.consts.UnitType.Ship.Corvette.TarantulIII,
                        Active = { { 1992, 9999 } },
                        ReportNaming = "RKA-%H %N",
                        HullNumbering = {
                          [1989] = "973", [1990] = "953",
                        },
                      },
                    }, -- /166th Novorossiysky Small Missile Ship Units
                  }, -- /166th Novorossiysky Small Missile Ship Regiment
                  ['295thSulinskyMissile'] = {
                    Name = "295th Sulinsky Missile Boat Battalion",
                    Units = {
                      R60 = { -- Tarantul Corvette
                        Name = "R-60",
                        Type = fdmm.consts.UnitType.Ship.Corvette.TarantulIII,
                        Active = { { 1987, 9999 } },
                        Inactive = { 2005 },
                        ReportNaming = "RKA-%H %N",
                        HullNumbering = {
                          [1988] = "970", ['1989?1990'] = "953", [1990] = "955",
                        },
                      },
                      R109 = { -- Tarantul Corvette
                        Name = "R-109",
                        Type = fdmm.consts.UnitType.Ship.Corvette.TarantulIII,
                        Active = { { 1990, 9999 } },
                        ReportNaming = "RKA-%H %N",
                        HullNumbering = {
                          [1996] = "952",
                        },
                      },
                      Ivanovets = { -- Tarantul Corvette
                        Name = { [1989] = "R-334", [1998] = "Ivanovets" },
                        Type = fdmm.consts.UnitType.Ship.Corvette.TarantulIII,
                        Active = { { 1989, 9999 } },
                        ReportNaming = "RKA-%H %N",
                        HullNumbering = {
                          [1990] = "954",
                        },
                      },
                    }, -- /295th Sulinsky Missile Boat Units
                  }, -- /295th Sulinsky Missile Boat Regiment
                }, -- /41th Missile Boat Regiments
              }, -- /41th Missile Boat Regiment
            }, -- /Black Sea Fleet Regiments
          }, -- /Black Sea Fleet Division
        }, -- /Russia
        China = {
        }, -- /China
        USA = {
          SixthFleet = {
            Name = "Sixth Fleet",
            Regiments = {
              TaskForce60 = {
                Name = "Task Force 60",
                Units = {
                  USSMountWhitney = { -- Amphibious Command Ship
                    Name = "USS Mount Whitney",
                    Type = fdmm.consts.UnitType.Ship.HeliCarrier.Tarawa_LHA1Tarawa,
                    Command = true,
                    Active = { { 2005, 9999 } },
                    ReportNaming = "LCC/JCC-%H %N",
                    HullNumbering = "20",
                  },
                  USSLaSalle = { -- Command Frigate
                    Name = "USS La Salle",
                    Type = fdmm.consts.UnitType.Ship.Destroyer.OliverHazardPerry,
                    Command = true,
                    Active = { { 1972, 2004 } },
                    ReportNaming = "AGF-%H %N",
                    HullNumbering = "3",
                  },
                  USSYorktown = { -- Ticonderoga Cruiser
                    Name = "USS Yorktown",
                    Type = fdmm.consts.UnitType.Ship.Cruiser.Ticonderoga,
                    Active = { { 1985, 2004 } },
                    ReportNaming = "CG-%H %N",
                    HullNumbering = "48",
                  },
                  USSTaylor = { -- Oliver-Hazard-Perry Frigate
                    Name = "USS Taylor",
                    Type = fdmm.consts.UnitType.Ship.Destroyer.OliverHazardPerry,
                    Active = { { 2008, 2014 } }, -- Sochi Olympics 2014 (ran aground)
                    ReportNaming = "FFG-%H %N",
                    HullNumbering = "50",
                  },
                }, -- /Task Force 60 Units
                Regiments = {
                  CarrierStrikeGroup2 = {
                    Name = "Carrier Strike Group 2",
                    ReportNaming = "CSG-2",
                    Units = {
                      USSJohnFKennedy = { -- JFK Carrier
                        Name = "USS John F. Kennedy", -- This guy was the Bernie of the 60s.
                        Type = fdmm.consts.UnitType.Ship.Carrier.Nimitz_CVN70CarlVinson,
                        Command = true,
                        Active = { { 1968, 1978 }, { 1981, 1992 } },
                        ReportNaming = "CV-%H %N",
                        HullNumbering = "67",
                      },
                      USSTheodoreRoosevelt = { -- Nimitz Carrier
                        Name = "USS Theodore Roosevelt", -- This guy was also a progressive.
                        Type = {
                          [1993] = fdmm.consts.UnitType.Ship.Carrier.Nimitz_CVN70CarlVinson,
                          [2013] = fdmm.consts.UnitType.Ship.Carrier.Nimitz_CVN74JohnCStennis,
                        },
                        Command = true,
                        Active = { 1993, 1999, { 2002, 2006 }, 2008, { 2015, 2016 } },
                        ReportNaming = "CVN-%H %N",
                        HullNumbering = "71",
                      },
                      USSJohnCStennis = { -- Nimitz Carrier
                        Name = "USS John C. Stennis", -- This guy was a racist segregationist.
                        Type = fdmm.consts.UnitType.Ship.Carrier.Nimitz_CVN74JohnCStennis,
                        Command = true,
                        Active = { { 1995, 1998 } },
                        ReportNaming = "CVN-%H %N",
                        HullNumbering = "74",
                      },
                      USSHarrySTruman = { -- Nimitz Carrier
                        Name = "USS Harry S. Truman", -- This guy was responsible for NATO.
                        Type = fdmm.consts.UnitType.Ship.Carrier.Nimitz_CVN74JohnCStennis,
                        Command = true,
                        Active = { { 2000, 2001 }, 2007, 2013, 2020 },
                        ReportNaming = "CVN-%H %N",
                        HullNumbering = "75",
                      },
                      USSDwightDEisenhower = { -- Nimitz Carrier
                        Name = "USS Dwight D. Eisenhower", -- The general that helped beat the Nazis.
                        Type = fdmm.consts.UnitType.Ship.Carrier.Nimitz_CVN70CarlVinson,
                        Command = true,
                        Active = { 1994, { 2009, 2010 }, 2012, 2019 },
                        ReportNaming = "CVN-%H %N",
                        HullNumbering = "69",
                      },
                      USSGeorgeHWBush = { -- Nimitz Carrier
                        Name = "USS George H.W. Bush", -- The dude Trump said "hold my beer" towards.
                        Type = fdmm.consts.UnitType.Ship.Carrier.Nimitz_CVN74JohnCStennis,
                        Command = true,
                        Active = { 2011, 2014, { 2017, 2018 }, { 2021, 9999 } },
                        ReportNaming = "CVN-%H %N",
                        HullNumbering = "77",
                      },
                      USSSanJacinto = { -- Ticonderoga Cruiser
                        Name = "USS San Jacinto",
                        Type = fdmm.consts.UnitType.Ship.Cruiser.Ticonderoga,
                        Active = { { 1989, 1992 }, 1996, 1998, { 2000, 2001 }, { 2003, 2008 }, 2010, { 2013, 2014 },
                                   2016, 2019 },
                        ReportNaming = "CG-%H %N",
                        HullNumbering = "56",
                      },
                      USSHueCity = { -- Ticonderoga Cruiser
                        Name = "USS Hue City",
                        Type = fdmm.consts.UnitType.Ship.Cruiser.Ticonderoga,
                        Active = { 1993, 1995, 1997, 2012, 2018 },
                        ReportNaming = "CG-%H %N",
                        HullNumbering = "66",
                      },
                      USSAnzio = { -- Ticonderoga Cruiser
                        Name = "USS Anzio",
                        Type = fdmm.consts.UnitType.Ship.Cruiser.Ticonderoga,
                        Active = { 1994 },
                        ReportNaming = "CG-%H %N",
                        HullNumbering = "68",
                      },
                      USSVellaGulf = { -- Ticonderoga Cruiser
                        Name = "USS Vella Gulf",
                        Type = fdmm.consts.UnitType.Ship.Cruiser.Ticonderoga,
                        Active = { 1999, 2002 },
                        ReportNaming = "CG-%H %N",
                        HullNumbering = "72",
                      },
                      USSMonterey = { -- Ticonderoga Cruiser
                        Name = "USS Monterey",
                        Type = fdmm.consts.UnitType.Ship.Cruiser.Ticonderoga,
                        Active = { 2009, 2011 },
                        ReportNaming = "CG-%H %N",
                        HullNumbering = "61",
                      },
                      USSNormandy = { -- Ticonderoga Cruiser
                        Name = "USS Normandy",
                        Type = fdmm.consts.UnitType.Ship.Cruiser.Ticonderoga,
                        Active = { 2015, 2020 },
                        ReportNaming = "CG-%H %N",
                        HullNumbering = "60",
                      },
                      USSPhilippineSea = { -- Ticonderoga Cruiser
                        Name = "USS Philippine Sea",
                        Type = fdmm.consts.UnitType.Ship.Cruiser.Ticonderoga,
                        Active = { 2017, { 2021, 9999 } },
                        ReportNaming = "CG-%H %N",
                        HullNumbering = "58",
                      },
                    }, -- /Carrier Strike Group 2 Units
                    Regiments = {
                      DestroyerSquadron20 = {
                        Name = "Destroyer Squadron 20",
                        ReportNaming = "DESRON-20",
                        Units = {
                          -- USS O'Bannon (DD-987)
                          -- USS John Rodgers (DD-983)
                          -- USS Caron (DD-970)
                          -- USS Halyburton (FFG-40)
                          -- USS Underwood (FFG-36)
                          -- USS Stark (FFG-31)
                          -- USS McInerney (FFG-8)
                          -- USS Oscar Austin (DDG-79) 
                          -- USS Nitze (DDG-94)
                          -- USS Mason (DDG-87)
                          -- USS The Sullivans (DDG-68)
                          -- USS Truxtun (DDG-103)
                          -- USS Mitscher (DDG-57)
                          -- USS Roosevelt (DDG-80)
                          -- USS Arleigh Burke (DDG-51)
                        }, -- /Destroyer Squadron 20 Units
                        Reinforcements = {
                          Units = {
                          }, -- /Destroyer Squadron 20 Reinforcement Units
                        }, -- /Destroyer Squadron 20 Reinforcements
                      }, -- /Destroyer Squadron 20 Regiment
                    }, -- /Carrier Strike Group 2 Regiments
                    Reinforcements = {
                      Units = {
                        USSDwightDEisenhower = { -- Nimitz Carrier
                          Name = "USS Dwight D. Eisenhower", -- The general that beat the Nazis.
                          Type = fdmm.consts.UnitType.Ship.Carrier.Nimitz_CVN70CarlVinson,
                          Command = true,
                          Active = { { 1982, 1985 }, { 1987, 1992 }, { 1994, 1995 }, { 1997, 2000 }, { 2005, 2013 },
                                     { 2015, 9999 } },
                          ReportNaming = "CVN-%H %N",
                          HullNumbering = "69",
                        },
                        USSCapeStGeorge = { -- Ticonderoga Cruiser
                          Name = "USS Cape St. George",
                          Type = fdmm.consts.UnitType.Ship.Cruiser.Ticonderoga,
                          Active = { 1994, 1998, { 2000, 2007 } },
                          ReportNaming = "CG-%H %N",
                          HullNumbering = "71",
                        },
                        USSGettysburg = { -- Ticonderoga Cruiser
                          Name = "USS Gettysburg",
                          Type = fdmm.consts.UnitType.Ship.Cruiser.Ticonderoga,
                          Active = { { 1994, 2002 } },
                          ReportNaming = "CG-%H %N",
                          HullNumbering = "64",
                        },
                        USSLeyteGulf = { -- Ticonderoga Cruiser
                          Name = "USS Leyte Gulf",
                          Type = fdmm.consts.UnitType.Ship.Cruiser.Ticonderoga,
                          Active = { { 1989, 1996 }, 1999, { 2001, 2002 }, { 2004, 2006 }, { 2008, 2011 }, 2014, 
                                     { 2016, 9999 } },
                          ReportNaming = "CG-%H %N",
                          HullNumbering = "55",
                        },
                      }, -- /Carrier Strike Group 2 Reinforcement Units
                    }, -- /Carrier Strike Group 2 Reinforcements
                  }, -- /Carrier Strike Group 2 Regiment
                  DestroyerSquadron60 = {
                    Name = "Destroyer Squadron 60",
                    ReportNaming = "DESRON-60",
                    Units = {
                      USSDonaldCook = { -- Arleigh Burke Destroyer
                        Name = "USS Donald Cook",
                        Type = fdmm.consts.UnitType.Ship.Destroyer.OliverHazardPerry,
                        Active = { { 1972, 2005 } },
                        ReportNaming = "DDG-%H %N",
                        HullNumbering = "75",
                      },
                      USSRoss = { -- Arleigh Burke Destroyer
                        Name = "USS Ross",
                        Type = fdmm.consts.UnitType.Ship.Destroyer.OliverHazardPerry,
                        Active = { { 1999, 9999 } },
                        ReportNaming = "DDG-%H %N",
                        HullNumbering = "71",
                      },
                      USSCarney = { -- Arleigh Burke Destroyer
                        Name = "USS Carney",
                        Type = fdmm.consts.UnitType.Ship.Destroyer.OliverHazardPerry,
                        Active = { { 2007, 9999 } },
                        ReportNaming = "DDG-%H %N",
                        HullNumbering = "64",
                      },
                      USSPorter = { -- Arleigh Burke Destroyer
                        Name = "USS Porter",
                        Type = fdmm.consts.UnitType.Ship.Destroyer.OliverHazardPerry,
                        Active = { { 2007, 9999 } },
                        ReportNaming = "DDG-%H %N",
                        HullNumbering = "78",
                      },
                    }, -- /Destroyer Squadron 60 Units
                    Reinforcements = {
                      Units = {
                        USSRamage = { -- Arleigh Burke Destroyer
                          Name = "USS Ramage",
                          Type = fdmm.consts.UnitType.Ship.Destroyer.OliverHazardPerry,
                          Active = { { 1996, 9999 } },
                          ReportNaming = "DDG-%H %N",
                          HullNumbering = "61",
                        },
                        USSStout = { -- Arleigh Burke Destroyer
                          Name = "USS Stout",
                          Type = fdmm.consts.UnitType.Ship.Destroyer.OliverHazardPerry,
                          Active = { { 1996, 9999 } },
                          ReportNaming = "DDG-%H %N",
                          HullNumbering = "55",
                        },
                      }, -- /Destroyer Squadron 60 Reinforcement Units
                    }, -- /Destroyer Squadron 60 Reinforcements
                  }, -- /Destroyer Squadron 60 Regiment
                }, -- /Task Force 60 Regiments
                Reinforcements = {
                  Units = {
                    USSCoronado = { -- Command Frigate
                      Name = "USS Coronado",
                      Type = fdmm.consts.UnitType.Ship.Destroyer.OliverHazardPerry,
                      Command = true,
                      Active = { { 1980, 2006 } },
                      ReportNaming = "AGF-%H %N",
                      HullNumbering = "11",
                    },
                  }, --/Task Force 60 Reinforcement Units
                  Regiments = {
                    CarrierStrikeGroup8 = {
                      Name = "Carrier Strike Group 8",
                      ReportNaming = "CSG-8",
                      Units = {
                        USSHarrySTruman = { -- Nimitz Carrier
                          Name = "USS Harry S. Truman",
                          Type = fdmm.consts.UnitType.Ship.Carrier.Nimitz_CVN74JohnCStennis,
                          Command = true,
                          Active = { { 0, 9999 } },
                          ReportNaming = "CVN-%H %N",
                          HullNumbering = "75",
                        },
                        USSVellaGulf = { -- Ticonderoga Cruiser
                          Name = "USS Vella Gulf",
                          Type = fdmm.consts.UnitType.Ship.Cruiser.Ticonderoga,
                          Active = { { 2003, 2006 }, { 2008, 2015 } },
                          ReportNaming = "CG-%H %N",
                          HullNumbering = "72",
                        },
                        USSHueCity = { -- Ticonderoga Cruiser
                          Name = "USS Hue City",
                          Type = fdmm.consts.UnitType.Ship.Cruiser.Ticonderoga,
                          Active = { { 1997, 1998 }, { 2004, 2013 }, { 2015, 9999 } },
                          ReportNaming = "CG-%H %N",
                          HullNumbering = "66",
                        },
                      }, -- /Carrier Strike Group 8 Units
                      Regiments = {
                        DestroyerSquadron28 = {
                          Name = "Destroyer Squadron 28",
                          ReportNaming = "DESRON-28",
                          Units = {
                            USSRamage = { -- Arleigh Burke Destroyer
                              Name = "USS Ramage",
                              Type = fdmm.consts.UnitType.Ship.Destroyer.OliverHazardPerry,
                              Active = { 2000 },
                              ReportNaming = "DDG-%H %N",
                              HullNumbering = "61",
                            },
                            USSMitscher = { -- Arleigh Burke Destroyer
                              Name = "USS Mitscher",
                              Type = fdmm.consts.UnitType.Ship.Destroyer.OliverHazardPerry,
                              Active = { 2000 },
                              ReportNaming = "DDG-%H %N",
                              HullNumbering = "57",
                            },
                            USSForrestSherman = { -- Arleigh Burke Destroyer
                              Name = "USS Forrest Sherman",
                              Type = fdmm.consts.UnitType.Ship.Destroyer.OliverHazardPerry,
                              Active = { 2000 },
                              ReportNaming = "DDG-%H %N",
                              HullNumbering = "98",
                            },
                            USSLassen = { -- Arleigh Burke Destroyer
                              Name = "USS Lassen",
                              Type = fdmm.consts.UnitType.Ship.Destroyer.OliverHazardPerry,
                              Active = { 2000 },
                              ReportNaming = "DDG-%H %N",
                              HullNumbering = "82",
                            },
                            USSFarragut = { -- Arleigh Burke Destroyer
                              Name = "USS Farragut",
                              Type = fdmm.consts.UnitType.Ship.Destroyer.OliverHazardPerry,
                              Active = { 2000 },
                              ReportNaming = "DDG-%H %N",
                              HullNumbering = "99",
                            },
                          }, -- /Destroyer Squadron 28 Units
                        }, -- /Destroyer Squadron 28 Regiment
                      }, -- /Carrier Strike Group 8 Regiments
                    }, -- /Carrier Strike Group 8 Regiment
                  }, -- /Task Force 60 Reinforcement Regiments
                }, -- /Task Force 60 Reinforcements
              }, -- /Task Force 60 Regiment
            }, -- /Sixth Fleet Regiments
          }, -- /Sixth Fleet Division
        }, -- /USA
        Ukraine = {
        }, -- /Ukraine
        Georgia = {
        }, -- /Georgia
        Turkey = {
        }, -- /Turkey
      }, -- /Navy
    }, -- /Caucasus
    Nevada = {
      -- TODO: If/when we do a Nevada mission.
    }, -- /Nevada
    Normandy = {
      -- TODO: If/when we do a Normandy mission.
    }, -- /Normandy
    PersianGulf = {
      -- TODO: If/when we do a Persian Gulf mission.
    }, -- /PersianGulf
  }

  function fdmm.regimentTypes.processEntries()
    local function _makeRegimentActYearRange_recurse(regiment, activeYearRanges)
      local function _makeRegimentUnitActYearRange(regimentUnit, activeYearRanges)
        if not regimentUnit._yearRange then
          regimentUnit._yearRange = FDMMYearRange()

          if type(regimentUnit.Active) == 'table' and table.getn(regimentUnit.Active) > 0 then
            local status,retVal = pcall(regimentUnit._yearRange.addYearsFromList, regimentUnit._yearRange, regimentUnit.Active)
            if not status then
              env.error("FDMM: Failed parsing active years for regiment unit: \'" ..
                         fdmm.regimentTypes.getObjReportNameIn(regimentUnit) .. "\'.")
              env.error("FDMM:  Error: " .. tostring(retVal))
            end
          end
          if type(regimentUnit.Inactive) == 'table' and table.getn(regimentUnit.Inactive) > 0 then
            local status,retVal = pcall(regimentUnit._yearRange.removeYearsFromList, regimentUnit._yearRange, regimentUnit.Inactive)
            if not status then
              env.error("FDMM: Failed parsing inactive years for regiment unit: \'" ..
                         fdmm.regimentTypes.getObjReportNameIn(regimentUnit) .. "\'.")
              env.error("FDMM:  Error: " .. tostring(retVal))
            end
          end
        end

        local startYear, endYear = regimentUnit._yearRange:startYear(), regimentUnit._yearRange:endYear()
        if type(startYear) == 'number' and startYear < activeYearRanges[1] then activeYearRanges[1] = startYear end
        if type(endYear) == 'number' and endYear > activeYearRanges[2] then activeYearRanges[2] = endYear end
        return activeYearRanges
      end

      for _,regimentUnit in pairs(regiment.Units or {}) do
        activeYearRanges = _makeRegimentUnitActYearRange(regimentUnit, activeYearRanges)
      end
      for _,childRegiment in pairs(regiment.Regiments or {}) do
        activeYearRanges = _makeRegimentActYearRange_recurse(childRegiment, activeYearRanges)
      end
      if regiment.Reinforcements then
        for _,regimentUnit in pairs(regiment.Reinforcements.Units or {}) do
          activeYearRanges = _makeRegimentUnitActYearRange(regimentUnit, activeYearRanges)
        end
        for _,childRegiment in pairs(regiment.Reinforcements.Regiments or {}) do
          activeYearRanges = _makeRegimentActYearRange_recurse(childRegiment, activeYearRanges)
        end
      end

      regiment._Active = activeYearRanges
      return activeYearRanges
    end

    _makeRegimentActYearRange_recurse(fdmm.consts.RegimentType.Caucasus.Navy.USA.SixthFleet, {9999,0}) -- temp
  end

  function fdmm.regimentTypes._objForYear(obj, year)
    if type(obj) == 'table' then
      local prevValue = nil
      for idx,startYear in ipairs(table.sortedKeysList(obj)) do
        assert(type(startYear) == 'number', "Invalid format: startYear")
        local value = obj[startYear]
        assert(type(value) ~= 'nil', "Invalid format.")
        if year == startYear then return value end
        if year < startYear then return prevValue or value end
        prevValue = value
      end
      return prevValue
    end
    return obj
  end

  function fdmm.regimentTypes.getObjNameIn(unitOrRegiment, year)
    return fdmm.regimentTypes._objForYear(unitOrRegiment.Name, year)
  end

  function fdmm.regimentTypes.getObjReportNameIn(unitOrRegiment, year)
    local reportName = fdmm.regimentTypes._objForYear(unitOrRegiment.ReportNaming, year)
    if string.isNotEmpty(reportName) then
      local unitName = fdmm.regimentTypes.getObjNameIn(unitOrRegiment, year)
      local hullNum = fdmm.regimentTypes.getUnitHullNumberingIn(unitOrRegiment, year)
      if string.isNotEmpty(unitName) and string.contains(reportName, '%N') then
        reportName = reportName:gsub('%%N', unitName)
      end
      if string.isNotEmpty(hullNum) and string.contains(reportName, '%H') then
        reportName = reportName:gsub('%%H', hullNum)
      end
      return reportName
    end
    return fdmm.regimentTypes._objForYear(unitOrRegiment.Name, year)
  end

  function fdmm.regimentTypes.getUnitTypeIn(regimentUnit, year)
    return fdmm.regimentTypes._objForYear(regimentUnit.Type, year)
  end

  function fdmm.regimentTypes.getUnitHullNumberingIn(regimentUnit, year)
    return fdmm.regimentTypes._objForYear(regimentUnit.HullNumbering, year)
  end

  function fdmm.regimentTypes.isRegimentUnitAvailableIn(regimentUnit, year)
    assert(regimentUnit._yearRange, "Missing object: _yearRange")
    return regimentUnit._yearRange:containsYear(year)
  end

  function fdmm.regimentTypes.dumpRegimentYearlyAvailability(regiment, yearStart, yearEnd)
    env.info("FDMM: Dumping regiment yearly availability for years " ..
              tostring(yearStart) .. " to " .. tostring(yearEnd) .. "...")
    local function _dumpRegimentAvailability_recurse(regiment, year, shift)
      env.info("FDMM: " .. shift .. "Regiment: " .. fdmm.regimentTypes.getObjReportNameIn(regiment, year))
      for _,regimentUnit in pairs(regiment.Units or {}) do
        if fdmm.regimentTypes.isRegimentUnitAvailableIn(regimentUnit, year) then
          env.info("FDMM: " .. shift .. "  Unit: " .. fdmm.regimentTypes.getObjReportNameIn(regimentUnit, year))
        end
      end
      for _,childRegiment in pairs(regiment.Regiments or {}) do
        _dumpRegimentAvailability_recurse(childRegiment, year, shift .. "  ")
      end
      if regiment.Reinforcements then
        env.info("FDMM: " .. shift .. "  Reinforcements:")
        for _,regimentUnit in pairs(regiment.Reinforcements.Units or {}) do
          if fdmm.regimentTypes.isRegimentUnitAvailableIn(regimentUnit, year) then
            env.info("FDMM: " .. shift .. "    Unit: " .. fdmm.regimentTypes.getObjReportNameIn(regimentUnit, year))
          end
          for _,childRegiment in pairs(regiment.Reinforcements.Regiments or {}) do
            _dumpRegimentAvailability_recurse(childRegiment, year, shift .. "    ")
          end
        end
      end
    end
    for year = yearStart,yearEnd do
      env.info("FDMM: Year: " .. year)
      _dumpRegimentAvailability_recurse(regiment, year, "")
    end
  end

  function fdmm.regimentTypes.dumpRegimentActiveLists(regiment)
    env.info("FDMM: Dumping regiment year list...")
    local year = fdmm.setup.equipmentYear
    local function _dumpRegimentActiveLists_recurse(regiment, shift)
      env.info("FDMM: " .. shift .. "Regiment: " .. fdmm.regimentTypes.getObjReportNameIn(regiment, year))
      env.info("FDMM: " .. shift .. "  _Active: " .. JSON:encode(regiment._Active))
      for _,regimentUnit in pairs(regiment.Units or {}) do
        env.info("FDMM: " .. shift .. "  Unit: " .. fdmm.regimentTypes.getObjReportNameIn(regimentUnit, year))
        env.info("FDMM: " .. shift .. "    _Active: " .. JSON:encode(regimentUnit._yearRange:getYearList()))
      end
      for _,childRegiment in pairs(regiment.Regiments or {}) do
        _dumpRegimentActiveLists_recurse(childRegiment, shift .. "  ")
      end
      if regiment.Reinforcements then
        env.info("FDMM: " .. shift .. "  Reinforcements:")
        for _,regimentUnit in pairs(regiment.Reinforcements.Units or {}) do
          env.info("FDMM: " .. shift .. "    Unit: " .. fdmm.regimentTypes.getObjReportNameIn(regimentUnit, year))
          env.info("FDMM: " .. shift .. "      _Active: " .. JSON:encode(regimentUnit._yearRange:getYearList()))
        end
        for _,childRegiment in pairs(regiment.Reinforcements.Regiments or {}) do
          _dumpRegimentActiveLists_recurse(childRegiment, shift .. "    ")
        end
      end
    end
    _dumpRegimentActiveLists_recurse(regiment, "")
  end

end -- /FDMM_RegimentTypes

env.info("---FDMM_RegimentTypes End---");
