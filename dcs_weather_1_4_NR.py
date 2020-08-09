# Real time / weather update script for dcs world (tested under 2.5)
# Originally created by havoc-company.com, modified by NachtRaveVL.
# Licensed under MIT license. Distributed as a part of FDMM.
# Requirements:
#   Python3, pip, and requests library:
#     -> Python3 & pip: www.python.org/downloads/
#     -> Requests lib: pip install requests
#   API Key from CheckWX:
#     -> Register and request API key at: www.checkwx.com
#     -> Paste API key into a text file named checkwx_key.txt (or what user_api_key_filename_checkwx
#        is set to below), or paste key directly into this script via setting user_api_key_checkwx
#        below. Failure to do this step will result in the script aborting.
# Usage:
#   -> dcs_weather_1_4_NR.py <miz file|mission folder> <airport name/ICAO codes> <time control> <?search radius?>
#   Parameters:
#     - <miz file|mission folder> : Mission.miz file or folder of already unzipped .miz file.
#     - <airport name/ICAO codes> : Airport name (DCS name) or comma separated list of 4-charater ICAO
#           airport codes. See Notes for further details.
#     - <time control> : One of the following strings used to control how time is determined:
#       - real : Uses server time, at time of script execution, for mission time.
#       - rand : Uses a random start time for mission time.
#       - [0..7] : Enumerated time preset. See Notes for further details.
#       - GMT[+|-][N] : (e.g. GMT+3, GMT-7, etc.) Uses server time in UTC plus GMT+/-{offset}. Or:
#           - GeST : Georgian Standard Time (GMT+3).
#           - CEST : Central European Standard Time (GMT+1).
#           - GoST : Gulf Standard Time (GMT+4).
#           - PST : Pacific Standard Time (GMT-8).
#     - <?search radius?> : Optional parameter, if specified will search up to this distance away (in nautical
#           miles) to try and find a backup METAR station to use in the event the first one fails to report.
#   Examples:
#     - dcs_weather_1_4_NR.py Weapons_Training_v2.11.2.miz Batumi real
#     - dcs_weather_1_4_NR.py Weapons_Training_v2.11.2/ UGSB,UGKO GMT+3 250
#     - dcs_weather_1_4_NR.pw D:\MyCoolFolder\MyCoolMission.miz Min-Vody GeST
#   Notes:
#     - Time presets:
#       - Dawn = 0 1 2 3
#       - Dusk = 4 5 6 7 
#     - ICAO Codes:
#       - Get the ICAO code for airport you want to use: https://www.world-airport-codes.com/
#         e.g.: https://www.world-airport-codes.com/alphabetical/country-name/g.html#georgia
#     - Supported DCS airport names:
#       - Note: Spaces ' ', underscores '_', and dashes '-' are interchangable.
#       - Caucasus: Batumi, Kobuleti, Senaki (or Senaki-Kolkhi), Kutaisi (or Kopitnari), Sukhumi
#           (or Sukhumi-Babushara), Gudauta, Sochi (or Sochi-Adler), Tbilisi (or Tibilis-Lochini),
#           Soganlug or (Tibilis-Soganlug), Vaziani, Beslan, Mozdok, Nalchik, Mineralnye (or
#           Min[|eralnye|eralnyye]] Vody), Maykop (or Maykop-Khanskaya), Krasnodar (or
#           [Krasnodar|[Krasnodar ]Pashkovsky]), Krasnodar-Center (or
#           Krasnodar-[Center|Tsentralny]|Tsentralny]), Krymsk, Gelendzhik, Novorossiysk (or
#           Myskhako), and Anapa (or Anapa-Vityazevo).
#       - Nevada: Mina (or Mina[ Airport][ 3Q0]), Tonopah (or Tonopah Airport), Tonopah Range (or
#           Tonopah [Test ]Range[ Airfield]), Lincoln (or Lincoln County), Groom Lake (or
#           [Homey|Area 51|Groom Lake][ AFB]), Pahute Mesa (or Pahute Mesa Airstrip), Beatty (or
#           Beatty Airport), Creech (or Creech AFB), Mesquite, Echo Bay, Nellis (or Nellis AFB),
#           Las Vegas (or North Las Vegas), McCarran (or McCarran[ International][ Airport]), 
#           Henderson (or Henderson[ Executive][ Airport]), Boulder City (or Boulder City Airport),
#           Jean (or Jean Airport), and Laughlin (or Laughlin Airport).
#       - Normandy: Needs Oar (or Needs Oar Point), Funtington, Tangmere, Ford (or Ford[ |-|_]AF),
#           Chailey, Maupertus (or [Cherbourg-]Maupertus[ Airport]), Azeville, Biniville, Beuzeville,
#           Picauville, Brucheville, Cretteville, Meautis Lessay, Cardonville, Cricqueville (or
#           Cricqueville-en-Bessin), Deux Jumeaux, Saint Pierre (or Saint Pierre du Mont), Saint
#           Laurent (or Saint-Laurent[-sur-Mer]), Chippelle, Molay (or Le Molay), Lignerolles, Longues
#           (or Longues[-sur-Mer]), Sommervieu, Bazenville, Sainte-Croix (or Saint-Croix[-sur-Mer]),
#           Rucqueville, Lantheuil, Beny (or Beny[-sur-Mer]), Carpiquet (or Caen-Carpiquet[ Airport]),
#           Argentan (or Argentan Airport), Goulet, Vrigny, Hauterive, Essay, Barville, Conches (or
#           Conches-en-Ouche), and Evreux (or Evreux-Fauville).
#       - Persian Gulf: Shiraz (or Shiraz[ International][ Airport]), Kerman (or Kerman Airport),
#           Lar (or Lar[estan][ Airbase]), Jiroft (or Jiroft Airport), Lavan (or Lavan[ Island][ Airport]),
#           Kish (or Kish[ International][ Airport]), Bandar Lengeh (or [Bandar[-e-| ]]Lengeh), Qeshm
#           (or [Qeshm Island|Dayrestan]), Havadarya, Bandar Abbas (or [Bandar[-e-| ]]Abbas[ Intl]),
#           Bandar Jask (or [Bandar[-e-| ]]Jask[ airfield]), Tunb Borzorg (or
#           [Tunb|Tunb[-e-| ]Borzorg][ Island][ AFB]), Tunb Kochak (or [Tunb[-e-| ]]Kochak[ Airport]),
#           Sirri (or Sirri Island), Abu Musa (or Abu Musa[ Island][ Airport]), Khasab, Khaimah
#           (or Ras Al Khaimah), Fujairah (or Fujairah Intl), Sharjah (or Sharjah Intl), Dubai
#           (or Dubai Intl), Al Minhad (or [Al ]Minhad[ AB]), Al Maktoum (or [Al ]Maktoum[ Intl]),
#           Nuayr (or Sir Abu Nuayr), Al Ain (or [Al ]Ain[ International][ Airport]), Abu Dhabi
#           (or Abu Dhabi[ Internationl][ Airport]), Nakheel (or [Sas Al ]Nakheel[ Airport]),
#           Al-Bateen (or [Al-]Bateen[ Airport]), Al Dhafra (or [Al ]Dhafra[ AB]), and Liwa (or
#           [Liwa|[Al-]Safran][ Airbase]).

# You need to register with www.checkwx.com, create an account, then request an API key to use
# under you own account. Once activated your API key will appear in your API dashboard at:
#   www.checkwx.com/apikey
# Once you have your API key, then you can enter it directly below, or paste it as the first line
# of a text file as specified below.
# 1) Enter your CheckWX API key below between the quotes:
user_api_key_checkwx = "NOT_SET_YET"
# or 2) Enter in text file containing key:
user_api_key_filename_checkwx = "checkwx_key.txt"

# Optionally, we can try the same request against APWX, using the following if set. If not set,
# then APWX's "preview" API will attempt to be used.
# 1) Enter your AVWX API key below between the quotes:
user_api_key_avwx = "NOT_SET_YET"
# or 2) Enter in text file containing AVWX API key:
user_api_key_filename_avwx = "avwx_key.txt"

import os
import re
import sys
import json
import time
import zipfile
import datetime
import requests
import random as rd

# stuff I need to move up still:

# EGAA = int, URSS = sochi, URKK = Krasnador, UGTB = tibilsi, UGKS = kobuleti, UGGS = Sukhumi, UGSB = Batumi
# EGAC = city, OMDW = Al Maktoum, OMSJ = Sharjah, OOKB = khasab, OIKB = Bandar, OISS = Shiraz

s_version_info = "V1.4NR 2020.March"

class G:  # Globals class ...... to store all the data we need to mess with (populate with some defaults)
    s_api_key_checkwx = user_api_key_checkwx
    s_api_key_filename_checkwx = user_api_key_filename_checkwx
    s_api_key_avwx = user_api_key_avwx
    s_api_key_filename_avwx = user_api_key_filename_avwx
    s_filename_checkwx = 'data.checkwx.json'
    s_filename_avwx = 'data.avwx.json'

    b_change_time = True  # set to to False if you do NOT want to update time
    b_qnh_update = True  # set this to True if you want to have the QNH set by METAR data
    b_adjust_for_daylight_savings = False  # this controls if u want to add one hour to account for clock going forward

    b_debug_load = False  # (debug) debug testing only, leave False
    b_debug_checkwx = False # (debug) debug testing only, leave False
    b_daws_mission = False  # (depricated) DAWS has been abandoned, leave False
    b_update_weather = True  # (debug) Whenever or not to fetch new METAR weather, leave True
    b_json_save = True  # (debug) this is for saving then loading the json data to/from file, leave True

    d_dcs_ap_name_to_icao = { # airport names in lowercase for case-insensitive lookup, /w ' ' and '_' replaced by '-'
        # Caucasus
        "batumi" : "UGSB", # intl-airport 'BUS'/UGSB - METAR data available!
        "kobuleti" : "UGSB", # airfield UGKS - No METAR data, uses Batumi.
        "senaki" : "UGKO", # aka Senaki-Kolkhi: airbase no ICAO - No METAR data, uses Kutaisi.
        "kutaisi" : "UGKO", # aka Kopitnari: airport 'KUT'/UGKO - METAR data available!
        "sukhumi" : "URSS", # aka Sukhumi-Babushara: airport 'SUI'/UGSS - No METAR data, uses Sochi.
        "gudauta" : "URSS", # airbase UG0U - No METAR data, uses Sochi.
        "sochi" : "URSS", # aka Sochi-Adler: intl-airport 'AER'/URSS - METAR data available!
        "tbilisi" : "UGTB", # aka Tbilisi-Lochini: intl-airport 'TBS'/UGTB - METAR data available!
        "soganlug" : "UGTB", # aka Tbilisi-Soganlug: airbase UG24 - No METAR data, uses Tbilisi.
        "vaziani" : "UGTB", # airbase UG27 - No METAR data, uses Tbilisi.
        "beslan" : "URMO", # airport 'OGZ'/URMO - METAR data available!
        "mozdok" : "URMO", # airbase no ICAO - No METAR data, uses Beslan. Another option maybe: Stavropol/URMT.
        "nalchik" : "URMN", # airport 'NAL'/URMN - METAR data available!
        "mineralnye" : "URMM", # aka Min[|eralnye|eralnyye]] Vody: airport 'MRV'/URMM - METAR data available!
        "maykop" : "URKK", # aka Maykop-Khanskaya: airport URKM, airbase URKH - No METAR data, uses Krasnodar.
        "pashkovsky" : "URKK", # aka [Krasnodar|[Krasnodar ]Pashkovsky]: intl-airport 'KRR'/URKK - METAR data available!
        "tsentralny" : "URKK", # aka [Krasnodar-[Center|Tsentralny]|Tsentralny]: airbase no ICAO - No METAR data, uses Krasnodar.
        "krymsk" : "URKK", # airbase no ICAO - No METAR data, uses Krasnodar. Another option maybe: Anapa/URKA.
        "gelendzhik" : "URKA", # airport 'GDZ'/URKG - No METAR data, uses Anapa.
        "novorossiysk" : "URKA", # aka Myskhako: airport no ICAO - No METAR data, uses Anapa.
        "anapa" : "URKA", # aka Anapa-Vityazevo: airport 'AAQ'/URKA - METAR data available!
        # Nevada
        "mina" : "KTPH", # aka Mina[ Airport][ 3Q0]: airport '3Q0'/3Q0 - No METAR data, uses Tonopah.
        "tonopah" : "KTPH", # aka Tonopah Airport: airport 'TPH'/KTPH - METAR data available!
        "tonopah-range" : "KTPH", # aka Tonopah[ Test] Range[ Airport]: airport 'XSD'/KTNX - No METAR data, uses Tonopah.
        "lincoln" : "KINS", # aka Lincoln[ County][ Airport]: airport '1L1'/1L1 - No METAR data, uses Creech.
        "groom-lake" : "KINS", # aka [Homey|Area 51|Groom Lake][ AFB]: airbase KXTA - No METAR data, uses Creech.
        "pahute-mesa" : "KINS", # aka Pahute Mesa Airstrip: airport L23 - No METAR data, uses Creech.
        "beatty" : "KINS", # aka Beatty Airport: airport 'BTY'/KBTY - No METAR data, uses Creech.
        "creech" : "KINS", # aka Creech AFB: airbase 'INS'/KINS - METAR data available!
        "mesquite" : "KSGU", # aka Mesquite Airport: airport 'MFH'/67L - No METAR data, uses St.George.
        "echo-bay" : "KLSV", # aka Echo Bay Airport: airport '0L9'/K0L9 - No METAR data, uses Nellis.
        "nellis" : "KLSV", # aka Nellis AFB: airbase 'LSV'/KLSV - METAR data available!
        "las-vegas" : "KVGT", # aka [North ]Las Vegas[ Airport]: airport 'VGT'/KVGT - METAR data available!
        "mccarran" : "KLAS", # aka McCarran[ International][ Airport]: airport 'LAS'/KLAS - METAR data available!
        "henderson" : "KHND", # aka Henderson[ Executive][ Airport]: airport 'HSH'/KHND - METAR data available!
        "boulder-city" : "KBVU", # aka Boulder City[ Municipal][ Airport]: airport 'BLD'/KBVU - METAR data available!
        "jean" : "KHND", # aka Jean Airport: airport '0L7'/K0L7 - No METAR data, uses Henderson.
        "laughlin" : "KIFP", # aka [Laughlin|Bullhead][ International][ Airport]: airport 'IFP'/KIFP - METAR data available!
        # Normandy
        "needs-oar" : "EGHH", # aka Needs Oar Point: alg-airfield n/a - No METAR data, uses Bournemouth.
        "funtington" : "EGHI", # alg-airfield n/a - No METAR data, uses Southampton.
        "tangmere" : "EGKA", # alg-airfield EGUT - No METAR data, uses Shoreham.
        "ford" : "EGKA", # aka Ford[ |-|_]AF: alg-airfield n/a - No METAR data, uses Shoreham.
        "chailey" : "EGKK", # alg-airfield n/a - No METAR data, uses London Gatwick.
        "maupertus" : "LFRC", # aka [Cherbourg-]Maupertus[ Airport]: airport 'CER'/LFRC - METAR data available!
        "azeville" : "LFRC", # alg-airfield n/a - No METAR data, uses Maupertus.
        "biniville" : "LFRC", # alg-airfield n/a - No METAR data, uses Maupertus.
        "beuzeville" : "LFRC", # alg-airfield n/a - No METAR data, uses Maupertus.
        "picauville" : "LFRC", # alg-airfield n/a - No METAR data, uses Maupertus.
        "brucheville" : "LFRC", # alg-airfield n/a - No METAR data, uses Maupertus.
        "cretteville" : "LFRC", # alg-airfield n/a - No METAR data, uses Maupertus.
        "meautis" : "LFRC", # alg-airfield n/a - No METAR data, uses Maupertus.
        "lessay" : "LFRC", # alg-airfield n/a - No METAR data, uses Maupertus.
        "cardonville" : "LFRK", # alg-airfield n/a - No METAR data, uses Carpiquet.
        "cricqueville" : "LFRK", # aka Cricqueville-en-Bessin: alg-airfield n/a - No METAR data, uses Carpiquet.
        "deux-jumeaux" : "LFRK", # alg-airfield n/a - No METAR data, uses Carpiquet.
        "saint-pierre" : "LFRK", # aka Saint Pierre du Mont: alg-airfield n/a - No METAR data, uses Carpiquet.
        "saint-laurent" : "LFRK" # aka Saint-Laurent[-sur-Mer]: alg-airfield n/a - No METAR data, uses Carpiquet.
        "chippelle" : "LFRK", # alg-airfield n/a - No METAR data, uses Carpiquet.
        "molay" : "LFRK", # aka Le Molay: alg-airfield n/a - No METAR data, uses Carpiquet.
        "lignerolles" : "LFRK", # alg-airfield n/a - No METAR data, uses Carpiquet.
        "longues" : "LFRK", # aka Longues[-sur-Mer]: alg-airfield n/a - No METAR data, uses Carpiquet.
        "sommervieu" : "LFRK", # alg-airfield n/a - No METAR data, uses Carpiquet.
        "bazenville" : "LFRK", # alg-airfield n/a - No METAR data, uses Carpiquet.
        "sainte-croix" : "LFRK", # aka Saint-Croix[-sur-Mer]: alg-airfield n/a - No METAR data, uses Carpiquet.
        "rucqueville" : "LFRK", # alg-airfield n/a - No METAR data, uses Carpiquet.
        "lantheuil" : "LFRK", # alg-airfield n/a - No METAR data, uses Carpiquet.
        "beny" : "LFRK", # aka Beny[-sur-Mer]: alg-airfield n/a - No METAR data, uses Carpiquet.
        "carpiquet" : "LFRK", # aka Caen-Carpiquet Airport: airport 'CFR'/LFRK - METAR data available!
        "argentan" : "LFRM", # aka Argentan Airport: airport LFAJ - No METAR data, uses Le Mans.
        "goulet" : "LFRM", # alg-airfield n/a - No METAR data, uses Le Mans.
        "vrigny" : "LFRM", # alg-airfield n/a - No METAR data, uses Le Mans.
        "hauterive" : "LFRM", # alg-airfield n/a - No METAR data, uses Le Mans.
        "essay" : "LFRM", # alg-airfield n/a - No METAR data, uses Le Mans.
        "barville" : "LFRM", # alg-airfield n/a - No METAR data, uses Le Mans.
        "conches" : "LFOE", # aka Conches-en-Ouche: alg-airfield n/a - No METAR data, uses Evreux.
        "evreux" : "LFOE", # aka Evreux-Fauville: airbase 'EVX'/LFOE - METAR data available!
        # Persian Gulf
        "shiraz" : "OISS", # aka Shiraz[ International][ Airport]: intl-airport 'SYZ'/OISS - METAR data available!
        "kerman" : "OIKK", # aka Kerman Airport: airport 'KER'/OIKK - METAR data available!
        "lar" : "OISL", # aka Lar[estan][ Airbase]: airport 'LRR'/OISL - METAR data available!
        "jiroft" : "OIKK", # aka Jiroft Airport: airport OIKJ - No METAR data, uses Kerman.
        "lavan" : "OIBV", # aka Lavan[ Island][ Airport]: airport 'LVP'/OIBV - METAR data available!
        "kish" : "OIBK", # aka Kish[ International][ Airport]: intl-airport 'KIH'/OIBK - METAR data available!
        "lengeh" : "OIBL", # aka [Bandar[-e-| ]]Lengeh: airport 'BDH'/OIBL - METAR data available!
        "qeshm" : "OIKQ", # aka [Qeshm[ Island]|Dayrestan][ Airport]: airport OIKQ - METAR data available!
        "havadarya" : "OIKB", # airport 'HDR'/OIKP - No METAR data, uses Bandar Abbas.
        "abbas" : "OIKB", # aka [Bandar[-e-| ]]Abbas[ Intl]: intl-airport 'BND'/OIKB - METAR data available!
        "jask" : "OIZJ", # aka [Bandar[-e-| ]]Jask[ airfield]: airport OIZJ - METAR data available!
        "borzorg" : "OIBA", # aka [Tunb|Tunb[-e-| ]Borzorg][ Island][ AFB]: airport n/a - No METAR data, uses Abu Musa.
        "kochak" : "OIBA", # aka [Tunb[-e-| ]]Kochak[ Airport]: airport n/a - No METAR data, uses Abu Musa.
        "sirri" : "OIBS", # aka Sirri Island: airport 'SXI'/OIBS - METAR data available!
        "abu-musa" : "OIBA", # aka Abu Musa[ Island][ Airport]: airport 'AEU'/OIBA - METAR data available!
        "khasab" : "OMRK", # airbase 'KHS'/OOKB - No METAR data, uses Khaimah.
        "khaimah" : "OMRK", # aka Ras Al Khaimah: airport 'RKT'/OMRK - METAR data available!
        "fujairah" : "OMFJ", # aka Fujairah Intl: intl-airport OMFJ - METAR data available!
        "sharjah" : "OMSJ", # aka Sharjah Intl: intl-airport 'SHJ'/OMSJ - METAR data available!
        "dubai" : "OMDB", # aka Dubai Intl: intl-airport OMDB - METAR data available!
        "minhad" : "OMDB", # aka [Al ]Minhad[ AB]: airbase OMDM - No METAR data, uses Dubai.
        "maktoum" : "OMDW", # aka [Al ]Maktoum[ Intl]: intl-airport OMDW - METAR data available!
        "nuayr" : "OIBS", # aka Sir Abu Nuayr: airport OMSN - No METAR data, uses Sirri.
        "ain" : "OMAL", # aka [Al ]Ain[ International][ Airport]: intl-airport OMAL - METAR data available!
        "abu-dhabi" : "OMAA", # aka Abu Dhabi[ Internationl][ Airport]: intl-airport OMAA - METAR data available!
        "nakheel" : "OMAD", # aka [Sas Al ]Nakheel[ Airport]: airbase OMNK - No METAR data, uses Al-Bateen.
        "bateen" : "OMAD", # aka [Al-]Bateen[ Airport]: airport OMAD - METAR data available!
        "dhafra" : "OMAA", # aka [Al ]Dhafra[ AB]: airbase OMAM - No METAR data, uses Abu Dhabi.
        "liwa" : "OMAA" # aka [Liwa|Al-Safran][ Airbase]: airbase OMSM - No METAR data, uses Abu Dhabi.
    }

    d_icao_metar_backups = {
        "UGSB": "UGKO,LTCG",
        "UGKO": "UGSB,KQND",
        "URSS": "UGSB,URKA",
        "UGTB": "UDSG,UBBY",
        "URMO": "URMN,URMG",
        "URMN": "URMO,URMM",
        "URMM": "URMN,URMT",
        "URKK": "URKA,URSS",
        "URKA": "URKK,URSS",
        "KTPH": "",
        "KINS": "",
        "KSGU": "",
        "KLSV": "",
        "KVGT": "",
        "KLAS": "",
        "KHND": "",
        "KBVU": "",
        "KIFP": "",
        "EGHH": "",
        "EGHI": "",
        "EGKA": "",
        "EGKK": "",
        "LFRC": "",
        "LFRK": "",
        "LFRM": "",
        "LFOE": "",
        "OISS": "",
        "OIKK": "",
        "OISL": "",
        "OIBV": "",
        "OIBK": "",
        "OIBL": "",
        "OIKQ": "",
        "OIKB": "",
        "OIZJ": "",
        "OIBA": "",
        "OIBS": "",
        "OMRK": "",
        "OMFJ": "",
        "OMSJ": "",
        "OMDB": "",
        "OMDW": "",
        "OMAL": "",
        "OMAA": "",
        "OMAD": "",
    }

    s_cloud_base_min = '450'
    s_cloud_base_max = '5000'
    s_cloud_thickness_min = '200'
    s_cloud_thickness_max = '2000'
    s_fog_visibility_min = '1800'  # use this to limit how much fog visibility will effect things
    s_fog_visibility_max = '4200'  # was 6000
    s_fog_thickness_min = '0'
    s_fog_thickness_max = '1000'
    s_sand_visibility_min = '1600'
    s_sand_visibility_max = '2999'

    s_temperature = '8'

    s_cloud_base_m = '5000'
    s_cloud_thickness_m = '380'
    s_cloud_density = '0'  # no clouds by default
    s_iprecptns = '0'
    s_qnh = '760'

    s_wind_speed_8k = '15'
    s_wind_dir_8k = '0'
    s_wind_speed_2k = '10'
    s_wind_dir_2k = '0'
    s_wind_speed_gnd = '0'
    s_wind_dir_gnd = '180'

    s_turbulence = '20'

    s_fog_enable = 'false'  # fog off by default
    s_fog_visibility_m = '0'
    s_fog_thickness_m = '0'
    s_fog_density = '0'

    b_sand_storm = False
    s_sand_enable = 'false'
    s_sand_density_m = '0'

    s_airport_icao = ''
    s_mission_miz = ''                 # full name inc path
    s_mission_miz_filename = ''        # just filename
    s_mission_miz_path = ''            # path to miz file

    s_year = ''
    s_month = ''
    s_day = ''
    s_hour = ''
    s_mins = ''
    s_seconds = ''
    s_start_time = ''
    i_rand_template = 1

    # presets used if time is too late in day and dark eg autumn / winter, first block is Caucaus second Persian Gulf
    l_dates = [['2019', '03', '06', '7', '30'], ['2019', '06', '03', '5', '50'], ['2019', '09', '28', '7', '45'],
               ['2019', '12', '26', '8', '30'], ['2019', '03', '06', '14', '0'], ['2019', '06', '03', '16', '0'],
               ['2019', '09', '28', '14', '0'], ['2019', '12', '26', '13', '0'],
               ['2019', '03', '08', '6', '10'], ['2019', '06', '03', '5', '0'], ['2019', '09', '28', '5', '0'],
               ['2019', '12', '26', '6', '30'], ['2019', '03', '08', '12', '0'], ['2019', '06', '03', '13', '0'],
               ['2019', '09', '28', '12', '0'], ['2019', '12', '26', '12', '0']
              ]

    
    i_search_radius = 0
    i_time_index = 0
    json_weather = False

# make airport name aliases
G.d_dcs_ap_name_to_icao["senaki-kolkhi"] = G.d_dcs_ap_name_to_icao["senaki"]
G.d_dcs_ap_name_to_icao["kopitnari"] = G.d_dcs_ap_name_to_icao["kutaisi"]
G.d_dcs_ap_name_to_icao["sukhumi-babushara"] = G.d_dcs_ap_name_to_icao["sukhumi"]
G.d_dcs_ap_name_to_icao["sochi-adler"] = G.d_dcs_ap_name_to_icao["sochi"]
G.d_dcs_ap_name_to_icao["tbilisi-lochini"] = G.d_dcs_ap_name_to_icao["tbilisi"]
G.d_dcs_ap_name_to_icao["tbilisi-soganlug"] = G.d_dcs_ap_name_to_icao["soganlug"]
G.d_dcs_ap_name_to_icao["min-vody"] = G.d_dcs_ap_name_to_icao["mineralnye"]
G.d_dcs_ap_name_to_icao["mineralnye-vody"] = G.d_dcs_ap_name_to_icao["mineralnye"]
G.d_dcs_ap_name_to_icao["mineralnyye-vody"] = G.d_dcs_ap_name_to_icao["mineralnye"]
G.d_dcs_ap_name_to_icao["maykop-khanskaya"] = G.d_dcs_ap_name_to_icao["maykop"]
G.d_dcs_ap_name_to_icao["krasnodar"] = G.d_dcs_ap_name_to_icao["pashkovsky"]
G.d_dcs_ap_name_to_icao["krasnodar-pashkovsky"] = G.d_dcs_ap_name_to_icao["pashkovsky"]
G.d_dcs_ap_name_to_icao["krasnodar-center"] = G.d_dcs_ap_name_to_icao["tsentralny"]
G.d_dcs_ap_name_to_icao["krasnodar-tsentralny"] = G.d_dcs_ap_name_to_icao["tsentralny"]
G.d_dcs_ap_name_to_icao["myskhako"] = G.d_dcs_ap_name_to_icao["novorossiysk"]
G.d_dcs_ap_name_to_icao["anapa-vityazevo"] = G.d_dcs_ap_name_to_icao["anapa"]
G.d_dcs_ap_name_to_icao["mina-3q0"] = G.d_dcs_ap_name_to_icao["mina"]
G.d_dcs_ap_name_to_icao["tonopah-test-range"] = G.d_dcs_ap_name_to_icao["tonopah-range"]
G.d_dcs_ap_name_to_icao["homey"] = G.d_dcs_ap_name_to_icao["groom-lake"]
G.d_dcs_ap_name_to_icao["area-51"] = G.d_dcs_ap_name_to_icao["groom-lake"]
G.d_dcs_ap_name_to_icao["north-las-vegas"] = G.d_dcs_ap_name_to_icao["las-vegas"]
G.d_dcs_ap_name_to_icao["henderson-executive"] = G.d_dcs_ap_name_to_icao["henderson"]
G.d_dcs_ap_name_to_icao["bullhead"] = G.d_dcs_ap_name_to_icao["laughlin"]
G.d_dcs_ap_name_to_icao["cherbourg-maupertus"] = G.d_dcs_ap_name_to_icao["maupertus"]
G.d_dcs_ap_name_to_icao["cricqueville-en-bessin"] = G.d_dcs_ap_name_to_icao["cricqueville"]
G.d_dcs_ap_name_to_icao["saint-pierre-du-mont"] = G.d_dcs_ap_name_to_icao["saint-pierre"]
G.d_dcs_ap_name_to_icao["saint-laurent-sur-mer"] = G.d_dcs_ap_name_to_icao["saint-laurent"]
G.d_dcs_ap_name_to_icao["le-molay"] = G.d_dcs_ap_name_to_icao["molay"]
G.d_dcs_ap_name_to_icao["longues-sur-mer"] = G.d_dcs_ap_name_to_icao["longues"]
G.d_dcs_ap_name_to_icao["sainte-croix-sur-mer"] = G.d_dcs_ap_name_to_icao["sainte-croix"]
G.d_dcs_ap_name_to_icao["caen-carpiquet"] = G.d_dcs_ap_name_to_icao["carpiquet"]
G.d_dcs_ap_name_to_icao["conches-en-ouche"] = G.d_dcs_ap_name_to_icao["conches"]
G.d_dcs_ap_name_to_icao["evreux-fauville"] = G.d_dcs_ap_name_to_icao["evreux"]
G.d_dcs_ap_name_to_icao["beny-sur-mer"] = G.d_dcs_ap_name_to_icao["beny"]
G.d_dcs_ap_name_to_icao["bandar-lengeh"] = G.d_dcs_ap_name_to_icao["lengeh"]
G.d_dcs_ap_name_to_icao["dayrestan"] = G.d_dcs_ap_name_to_icao["qeshm"]
G.d_dcs_ap_name_to_icao["bandar-abbas"] = G.d_dcs_ap_name_to_icao["abbas"]
G.d_dcs_ap_name_to_icao["bandar-e-abbas"] = G.d_dcs_ap_name_to_icao["abbas"]
G.d_dcs_ap_name_to_icao["bandar-jask"] = G.d_dcs_ap_name_to_icao["jask"]
G.d_dcs_ap_name_to_icao["bandar-e-jask"] = G.d_dcs_ap_name_to_icao["jask"]
G.d_dcs_ap_name_to_icao["tunb"] = G.d_dcs_ap_name_to_icao["borzorg"]
G.d_dcs_ap_name_to_icao["tunb-borzorg"] = G.d_dcs_ap_name_to_icao["borzorg"]
G.d_dcs_ap_name_to_icao["tunb-e-borzorg"] = G.d_dcs_ap_name_to_icao["borzorg"]
G.d_dcs_ap_name_to_icao["tunb-kochak"] = G.d_dcs_ap_name_to_icao["kochak"]
G.d_dcs_ap_name_to_icao["tunb-e-kochak"] = G.d_dcs_ap_name_to_icao["kochak"]
G.d_dcs_ap_name_to_icao["ras-al-khaimah"] = G.d_dcs_ap_name_to_icao["khaimah"]
G.d_dcs_ap_name_to_icao["al-minhad"] = G.d_dcs_ap_name_to_icao["minhad"]
G.d_dcs_ap_name_to_icao["al-maktoum"] = G.d_dcs_ap_name_to_icao["maktoum"]
G.d_dcs_ap_name_to_icao["sir-abu-nuayr"] = G.d_dcs_ap_name_to_icao["nuayr"]
G.d_dcs_ap_name_to_icao["al-ain"] = G.d_dcs_ap_name_to_icao["ain"]
G.d_dcs_ap_name_to_icao["sas-al-nakheel"] = G.d_dcs_ap_name_to_icao["nakheel"]
G.d_dcs_ap_name_to_icao["al-bateen"] = G.d_dcs_ap_name_to_icao["bateen"]
G.d_dcs_ap_name_to_icao["al-dhafra"] = G.d_dcs_ap_name_to_icao["dhafra"]
G.d_dcs_ap_name_to_icao["safran"] = G.d_dcs_ap_name_to_icao["liwa"]
G.d_dcs_ap_name_to_icao["al-safran"] = G.d_dcs_ap_name_to_icao["liwa"]

def set_airport_icao_from_input(s_input):
    s_input = s_input.strip(" \"\'\r\n\t")
    s_ap_name = s_input.replace(" ", "-").lower()
    s_ap_name = s_ap_name.replace("-county", "").replace("-municipal","").replace("-international", "")
    s_ap_name = s_ap_name.replace("-point", "").replace("-island","")
    s_ap_name = s_ap_name.replace("-airfield","").replace("-airport","").replace("-airstrip", "").replace("-airbase","")
    if s_ap_name.endswith("-intl"):
        s_ap_name = s_ap_name[:-5]
    if s_ap_name.endswith("-afb"):
        s_ap_name = s_ap_name[:-4]
    if s_ap_name.endswith("-af"):
        s_ap_name = s_ap_name[:-3]
    if s_ap_name.endswith("-ab"):
        s_ap_name = s_ap_name[:-3]
    s_icao_lookup = G.d_dcs_ap_name_to_icao.get(s_ap_name)
    if s_icao_lookup != None:
        G.s_airport_icao = s_icao_lookup
    else:
        G.s_airport_icao = s_input

def set_time_index_from_input(s_input):
    s_input = s_input.strip(" \"\'\r\n\t")
    G.b_change_time = True
    s_time_index = s_input.strip(" \"\'\r\n\t").lower()
    if s_time_index == 'real':
        G.i_time_index = 99
    elif s_time_index == 'rand':
        G.i_time_index = 100
    # TODO: More handling of time index.
    else:
        G.i_time_index = int(s_time_index)

# TODO better less shite command line parsing (but this is test version to see if any problems)
# parse commandline stuff eg airport code / time
if len(sys.argv) < 4:
    print("Not enough arguments, need more input.")
    print("Usage example:")
    print("  dcs_weather_1_4_NR.py Weapons_Training_v2.11.2.miz Batumi real")
    exit(1)
if len(sys.argv) >= 3:
    set_airport_icao_from_input(str(sys.argv[2]))
if len(sys.argv) >= 4:
    set_time_index_from_input(str(sys.argv[3]))
if len(sys.argv) >= 5:
    G.i_search_radius = int(str(sys.argv[2]))

#  TODO maybe add check for number before setting this

# deal with filename and paths
G.s_mission_miz = sys.argv[1]
G.s_mission_miz_path, G.s_mission_miz_filename = os.path.split(sys.argv[1])
#G.s_mission_miz_path = G.s_mission_miz_path + '\\'


def change_mission_data_item(l_mission, s_item, i_new_value, s_tab='\t\t'):  # used to change single unique item value
    i_mission_size = len(l_mission)
    i_count = 0
    s_new_item = s_tab + s_item + str(i_new_value) + ","

    while i_count < i_mission_size:
        if s_item in l_mission[i_count]:
            l_mission[i_count] = s_new_item
            break
        i_count += 1


# used to change single unique item value between 2 boundries
def change_mission_data_item_v2(l_mission, s_item, i_new_value, i_start_pos, i_end_pos, s_tab='\t\t'):
    s_new_item = s_tab + s_item + str(i_new_value) + ","

    while i_start_pos < i_end_pos:
        if s_item in l_mission[i_start_pos]:
            l_mission[i_start_pos] = s_new_item
            break
        i_start_pos += 1


def change_newline_chars_in_file(s_filename):  # used to deal with extra chars being written to file (0x0D)
    with open(s_filename, "rb") as input_file:
        content = input_file.read()
    content = content.replace(b"\x0D", b"\x0A")
    with open(s_filename, "wb") as output_file:
        output_file.write(content)


def check_weather_limits():
    # created this to make sure values fall within the acceptable range that can be configured in the DCS editor
    # dcs has a hard base limit of 300m, think we should be above it as people bitch about it
    s_base_tmp = G.s_cloud_base_m

    if int(G.s_cloud_base_m) <= int(G.s_cloud_base_min):  # going for ?
        i_diff = abs(int(s_base_tmp) - int(G.s_cloud_base_min))
        G.s_cloud_base_m = G.s_cloud_base_min
        G.s_cloud_thickness_m = str(int(G.s_cloud_thickness_m) + int(i_diff))

    if int(G.s_cloud_thickness_m) <= int(G.s_cloud_thickness_min):
        G.s_cloud_thickness_m = '200'
    if G.s_fog_enable == 'true':
        if int(G.s_fog_visibility_m) >= int(G.s_fog_visibility_max):  # make sure its not out of bounds for DCS
            G.s_fog_visibility_m = G.s_fog_visibility_max
        if int(G.s_fog_visibility_m) <= int(G.s_fog_visibility_min):
            G.s_fog_visibility_m = G.s_fog_visibility_min
    else:
        G.s_fog_visibility_m = '0'

    if G.s_sand_enable == 'true':
        if int(G.s_sand_density_m) >= int(G.s_sand_visibility_max):  # make sure its not out of bounds for DCS
            G.s_sand_density_m = G.s_sand_visibility_max
        if int(G.s_sand_density_m) <= int(G.s_sand_visibility_min):
            G.s_sand_density_m = G.s_sand_visibility_min
    else:
        G.s_sand_density_m = '0'

    if int(G.s_cloud_density) >= 9 or G.s_fog_enable == 'true' and int(G.s_cloud_base_m) <= 2000:
        G.s_cloud_base_m = '2000'


def convert_feet_to_meters(f_feet):  # cos we get data in feet
    # 1 foot = 0.3048 meters
    f_meters = float(f_feet) * 0.3048
    return str(int(f_meters))


def convert_to_hr_and_min_to_seconds():  # DCS uses seconds from 00:00 as time of day (this converts hr&min to this)
    G.s_start_time = str(int(G.s_hour) * 3600 + (int(G.s_mins) * 60) + int(G.s_seconds))


def convert_knots_to_m_per_sec(f_knots):  # used to convert the supplied knots value to meters per second
    # 1 knot = 0.514444 m per sec
    f_mps = float(f_knots) * 0.514444
    return str(int(f_mps))


def convert_hpa_to_mmhg(f_kpa):  # cos we get data in kPa
    #  1 kPa = 7.5006157584566 mmHg
    f_mmhg = float(f_kpa) * 0.75006157584566
    return str(int(round(f_mmhg, 1)))


def debug_load():
    if G.b_debug_checkwx:
        G.json_weather = load_json_data(G.s_filename_checkwx)
        get_checkwx_all_weather_parameters(G.json_weather)
    else:
        G.json_weather = load_json_data(G.s_filename_avwx)
        get_avwx_all_weather_parameters(G.json_weather)


def extract_mission_file(s_file_path, s_miz_filename, s_file_to_extract): # extracts file from .miz archive
    s_zip_to_open = s_file_path + s_miz_filename
    if os.path.isfile(G.s_mission_miz):
        archive = zipfile.ZipFile(s_zip_to_open)
        for file in archive.namelist():
            if file.startswith(s_file_to_extract):
                archive.extract(file, s_file_path)
        archive.close()
    else:
        print("WARNING: specified miz file does not exist")
        exit(1)

def repack_mission_file(s_file_path, s_miz_filename, s_file_to_repack): # repacks file to .miz archive
    s_zip_to_open = s_file_path + s_miz_filename
    if os.path.isfile(G.s_mission_miz):
        archive = zipfile.ZipFile(s_zip_to_open)
        archive.write(s_file_path + s_file_to_repack, s_file_to_repack)
        archive.close()
    else:
        print("WARNING: specified miz file does not exist")
        exit(1)

def find_item_index_from_start(l_mission, s_search):  # used to find which index (first list item) something is
    i_index = 0
    i_max = len(l_mission)
    ret_val = False
    while i_index < i_max:
        if s_search in l_mission[i_index]:
            ret_val = i_index
            # print("index " , i_index , "    ", l_mission[i_index])
            break
        i_index += 1
    return ret_val


def find_item_index(l_mission, s_search, i_stop_position, i_start_position=0):  # used to find index of item with params
    ret_val = False
    i_index = i_start_position
    while i_index != i_stop_position:
        if s_search in l_mission[i_index]:
            return i_index
        i_index += 1
    return ret_val


def gen_rand_dev(s_value, i_min, i_max):  # used to change values for wind speed / direction at diff alts
    i_deviation = rd.randint(i_min, i_max)
    i_value = int(s_value) + i_deviation
    if i_value < 0:
        i_value = 360 + i_value
    if i_value >= 360:
        i_value -= 360
    return str(i_value)


def get_weather1():
    # first try the primary (first site) and see of we get data ok
    G.json_weather = weather_read_url_checkwx()
    if G.json_weather is not False:
        if G.b_json_save:
            save_json_data(G.json_weather, G.s_filename_checkwx)
            G.json_weather = load_json_data(G.s_filename_checkwx)
        # set values in G array
        get_checkwx_all_weather_parameters(G.json_weather)


def get_weather2():
    # try secondary
    G.json_weather = weather_read_url_avwx()

    if G.json_weather is not False:
        if G.b_json_save:
            save_json_data(G.json_weather, G.s_filename_avwx)
            G.json_weather = load_json_data(G.s_filename_avwx)
        # set values in G array
        get_avwx_all_weather_parameters(G.json_weather)


def not_setup_correctly():
    print("")
    print("ERROR: You have not set-up you API KEY YET")
    print("you need to register with www.checkwx.com/ create an account,")
    print("then request an api key (takes 24hrs or less)")
    print("once activated your key will appear in your API dashboard")
    print(" www.checkwx.com/apikey ")
    print("enter your key in s_api_key_checkwx variable near the top of this script")
    time.sleep(2)


def get_avwx_all_weather_parameters(json_weather_l):  # going to read ALL weather info from json then stick it in G vars
    G.s_temperature = str(get_avwx_json_temperature(json_weather_l))
    get_avwx_weather_cloud_atmosphere(json_weather_l)
    get_avwx_weather_wind(json_weather_l)
    s_raw_report = get_avwx_json_raw_report(json_weather_l)
    get_avwx_fog_visibility(json_weather_l)

    get_weather_fog(s_raw_report)
    get_weather_sand_storm(s_raw_report)

    get_weather_turbulence()

    get_avwx_weather_qnh(json_weather_l)
    check_weather_limits()  # used to check we are within the limits DCS editor has


def get_avwx_json_other_list(json_weather_l):
    return json_weather_l['other']


def get_avwx_json_raw_report(json_weather_l):
    return json_weather_l['raw']


def get_avwx_json_temperature(json_weather_l):

    return json_weather_l['temperature']['value']


def get_avwx_json_wind_direction(json_weather_l):
    if not json_weather_l.get('wind_direction'):
        print("NO wind_speed data")
        return

    s_direction = str(json_weather_l['wind_direction']['value'])
    if s_direction is None:
        s_direction = 'VRB'

    if s_direction in 'VRB':  # variable means not measured (unknown)
        return str(rd.randint(0, 359))
    elif s_direction == '000':
        return '0'
    else:
        return s_direction


def get_avwx_fog_visibility(json_weather_l):
    # set fog view visibility distance (how far you can see before fog obscures stuff)
    G.s_fog_visibility_m = json_weather_l['visibility']['value']
    G.s_sand_density_m = json_weather_l['visibility']['value']
    if int(G.s_fog_visibility_m) > int(G.s_fog_visibility_max):  # make sure its not out of bounds for DCS
        G.s_fog_visibility_m = G.s_fog_visibility_max
    if int(G.s_sand_density_m) > int(G.s_sand_visibility_max):  # make sure its not out of bounds for DCS
        G.s_sand_density_m = G.s_sand_visibility_max


def get_avwx_weather_qnh(json_weather_l):
    G.s_qnh = convert_hpa_to_mmhg(json_weather_l['altimeter']['value'])


def get_avwx_weather_cloud_atmosphere(json_weather_l):  # read json and set the cloud settings from it
    # get record count - how many cloud data items do we have
    s_raw_report = get_avwx_json_raw_report(json_weather_l)
    print("raw ", s_raw_report)
    if "CAVOK" in s_raw_report:
        return

    b_tmp = json_weather_l.get('clouds')
    if not b_tmp:
        G.s_cloud_density = '0'
        return
    else:
        i_max_cloud_records = len(b_tmp)
        if i_max_cloud_records == 0:
            G.s_cloud_density = '0'
            return

    # need to make sure there are some clouds first ? is Zero its a CLR day
    if i_max_cloud_records == 0:
        s_cloud_base = 5000
    else:
        s_cloud_base = json_weather_l['clouds'][0]['altitude']  # set cloud base as first record height (lowest clouds)

    if i_max_cloud_records == 1:
        # if only one cloud record then set cloud alt and cloud type
        G.s_cloud_thickness_m = str(rd.randint(200, 300))
        G.s_cloud_base_m = convert_feet_to_meters((int(s_cloud_base) * 100))
        s_cloud_cover = json_weather_l['clouds'][0]['type']

    elif i_max_cloud_records > 1:
        # if we have multiple cloud records use difference between max and min for cloud depth
        G.s_cloud_base_m = convert_feet_to_meters((int(s_cloud_base)) * 100)
        s_cloud_alt_max_ft = int(json_weather_l['clouds'][i_max_cloud_records - 1]['altitude']) * 100  # height alt ft
        s_cloud_alt_min_ft = int(json_weather_l['clouds'][0]['altitude']) * 100  # get low
        G.s_cloud_thickness_m = str(convert_feet_to_meters(s_cloud_alt_max_ft - s_cloud_alt_min_ft))  # top to bottom
        s_cloud_cover = json_weather_l['clouds'][i_max_cloud_records - 1]['type']  # get last record cloud type
    else:
        s_cloud_cover = 'CLR'  # stick a default value here (if there is no cloud records)

    # common parse could cover type into number
    G.s_cloud_density = '0'  # default value
    if s_cloud_cover in ('SKC', 'NCD', 'CLR', 'NSC'):
        G.s_cloud_density = '0'
    elif s_cloud_cover in 'FEW':
        G.s_cloud_density = str(rd.randint(1, 2))
    elif s_cloud_cover in 'SCT':
        G.s_cloud_density = str(rd.randint(3, 4))
    elif s_cloud_cover in 'BKN':
        G.s_cloud_density = str(rd.randint(5, 8))
    elif s_cloud_cover in 'OVC':
        G.s_cloud_density = '9'
        G.s_cloud_thickness_m = '200'
    elif s_cloud_cover in 'VV':
        G.s_cloud_density = str(rd.randint(2, 8))

    # Rules cloud >= 5 then, ["iprecptns"] = 0 = none , 1 = rain , 2 = thunderstorm(if cloud>=9)
    # if temp <=0 then,  3 = snow, 4 = snowstorm(if cloud>=9)
    s_raw_report = get_avwx_json_raw_report(json_weather_l)
    l_rain = ['RA', 'DZ', 'GR', 'UP']
    l_snow = ['SN', 'SG', 'PL']
    l_other = ['TS']  # thunderstorm

    if any(x in s_raw_report for x in l_rain):
        #  print("RA found")
        G.s_iprecptns = '1'  # rain
    elif any(x in s_raw_report for x in l_snow):
        if int(G.s_temperature) <= 2:  # is it cold enough for snow/snow storm ?
            if int(G.s_cloud_density) >= 9:
                G.s_iprecptns = '4'  # snow storm
            else:
                G.s_iprecptns = '3'  # snow
    elif any(x in s_raw_report for x in l_other):
        G.s_cloud_density = '9'  # over ride this to match DCS
        G.s_iprecptns = '2'  # thunderstorm
    else:
        G.s_iprecptns = '0'  # no rain at all


def get_avwx_weather_wind(json_weather_l):  # read json weather data and set the wind info from it
    # weather at ground

    if 'wind_speed' not in json_weather_l:
        print("AVWX: No wind speed data")
        return

    s_knots = json_weather_l['wind_speed']['value']
    s_mps = convert_knots_to_m_per_sec(float(s_knots))
    G.s_wind_speed_gnd = s_mps

    G.s_wind_dir_gnd = get_avwx_json_wind_direction(json_weather_l)  # this function will get a bullshit or real value

    l_wind_variable_dir = get_avwx_wind_variable_dir(json_weather_l)
    if not l_wind_variable_dir:
        i_winds_size = 0
    else:
        i_winds_size = len(l_wind_variable_dir)
    #  print("l_wind_variable_dir ",  l_wind_variable_dir, " size is ", i_winds_size)

    # if l_wind_variable_dir is None:
    if i_winds_size == 0:
        G.s_wind_speed_gnd = str(rd.randint(0, 10))
        G.s_wind_dir_2k = gen_rand_dev(G.s_wind_dir_gnd, -10, 10)
        G.s_wind_dir_8k = gen_rand_dev(G.s_wind_dir_gnd, -20, 20)
    else:
        if represents_int(l_wind_variable_dir[0]['repr']):
            if i_winds_size > 1:  # must have at least 2
                G.s_wind_dir_2k = l_wind_variable_dir[0]['repr']
                G.s_wind_dir_8k = l_wind_variable_dir[1]['repr']
            elif i_winds_size == 1:  # single
                G.s_wind_dir_2k = l_wind_variable_dir[0]['repr']
                G.s_wind_dir_8k = gen_rand_dev(G.s_wind_dir_gnd, -20, 20)  # randomise gnd dir
        else:
            print("No variable wind ")
            G.s_wind_dir_2k = gen_rand_dev(G.s_wind_dir_gnd, -10, 10)
            G.s_wind_dir_8k = gen_rand_dev(G.s_wind_dir_gnd, -20, 20)

    # wind at 2k - we use ground level value and randomise
    G.s_wind_speed_2k = gen_rand_dev(s_mps, 1, 3)

    # wind at 8k - we use ground level value and randomise a bit more
    G.s_wind_speed_8k = gen_rand_dev(s_mps, 2, 8)


def get_avwx_wind_variable_dir(json_weather_l):
    if not json_weather_l.get('wind_variable_direction'):
        return False
    else:
        return json_weather_l['wind_variable_direction']


def get_checkwx_json_raw_report(json_weather_l):
    return json_weather_l['data'][0].get('raw_text')


def get_checkwx_json_temperature(json_weather_l):
    # get temperature
    return str(json_weather_l['data'][0]['temperature']['celsius'])


def get_checkwx_weather_cloud_atmosphere(json_weather_l):
    # get clouds / atmosphere
    s_raw_report = get_checkwx_json_raw_report(json_weather_l)
    if "CAVOK" in s_raw_report:
        return

    if not json_weather_l['data'][0].get('clouds'):
        print("NO cloud data")
        G.s_cloud_density = '0'
        return

    i_max_cloud_records = len(json_weather_l['data'][0]['clouds'])
    # print("Max records is ", i_max_cloud_records)  # debug info

    s_cloud_cover = json_weather_l['data'][0]['clouds'][0]['code']
    if s_cloud_cover not in ('SKC', 'NCD', 'CLR', 'NSC', 'CAVOK'):

        if i_max_cloud_records == 0:
            s_cloud_base_m = 5000
        else:
            s_cloud_base_m = str(int(convert_feet_to_meters((round(json_weather_l['data'][0]['clouds'][0]
                                                                   ['base_feet_agl'], 0)))))
            # set cloud base as first record height (lowest clouds)

        if i_max_cloud_records == 1:
            # if only one cloud record then set cloud alt and cloud type
            G.s_cloud_thickness_m = str(rd.randint(200, 800))
            G.s_cloud_base_m = s_cloud_base_m
            s_cloud_cover = json_weather_l['data'][0]['clouds'][0]['code']
        elif i_max_cloud_records > 1:
            # if we have multiple cloud records use difference between max and min for cloud depth
            G.s_cloud_base_m = s_cloud_base_m
            s_cloud_alt_max_m = int(convert_feet_to_meters(round(json_weather_l['data'][0]['clouds']
                                                                 [i_max_cloud_records-1]['base_feet_agl'], 0)))
            s_cloud_alt_min_m = int(convert_feet_to_meters(round(json_weather_l['data'][0]['clouds'][0]
                                                                 ['base_feet_agl'], 0)))
            G.s_cloud_thickness_m = str(s_cloud_alt_max_m - s_cloud_alt_min_m)
            s_cloud_cover = json_weather_l['data'][0]['clouds'][i_max_cloud_records - 1]['code']
        else:
            s_cloud_cover = 'CLR'  # stick a default value here (if there is no cloud records)

    # common parse could cover type into number
    G.s_cloud_density = '0'  # default value
    if s_cloud_cover in ('SKC', 'CLR', 'NSC', 'CAVOK'):
        G.s_cloud_density = '0'
    elif s_cloud_cover in 'FEW':
        G.s_cloud_density = str(rd.randint(1, 2))
    elif s_cloud_cover in 'SCT':
        G.s_cloud_density = str(rd.randint(3, 4))
    elif s_cloud_cover in 'BKN':
        G.s_cloud_density = str(rd.randint(5, 8))
    elif s_cloud_cover in 'OVC':
        G.s_cloud_density = '9'
        G.s_cloud_thickness_m = '200'
    elif s_cloud_cover in 'VV':
        G.s_cloud_density = str(rd.randint(2, 8))

    s_raw_report = str(json_weather_l['data'][0]['raw_text'])
    # print("raw is ", s_raw_report)
    l_rain = ['RA', 'DZ', 'GR', 'UP']
    l_snow = ['SN', 'SG', 'PL']
    l_other = ['TS']  # thunderstorm

    if any(x in s_raw_report for x in l_rain):
        #  print("RA found")
        G.s_iprecptns = '1'  # rain
    elif any(x in s_raw_report for x in l_snow):
        if int(G.s_temperature) <= 2:  # is it cold enough for snow/snow storm ?
            if int(G.s_cloud_density) >= 9:
                G.s_iprecptns = '4'  # snow storm
            else:
                G.s_iprecptns = '3'  # snow
    elif any(x in s_raw_report for x in l_other):
        G.s_cloud_density = '9'  # over ride this to match DCS
        G.s_iprecptns = '2'  # thunderstorm
    else:
        G.s_iprecptns = '0'  # no rain at all


def get_checkwx_weather_qnh(json_weather_l):
    G.s_qnh = convert_hpa_to_mmhg(json_weather_l['data'][0]['barometer']['mb'])


def get_checkwx_weather_wind(json_weather_l):
    # get wind
    if not json_weather_l['data'][0].get('wind'):
        print("NO wind data")
        return

    i_wind_records = len(json_weather_l['data'][0]['wind'])
    s_direction = str(json_weather_l['data'][0]['wind']['degrees'])
    if s_direction is None:
        s_direction = '0'

    if 'VRB' in s_direction:  # variable means not measured (unknown)
        s_direction = str(rd.randint(0, 359))
        s_mps = str(rd.randint(0, 20))
        G.s_wind_speed_gnd = str(s_mps)
    else:
        if i_wind_records > 1:
            s_mps = int(json_weather_l['data'][0]['wind']['speed_mps'])
            G.s_wind_speed_gnd = str(s_mps)
        else:
            s_direction = '0'

    G.s_wind_dir_gnd = str(s_direction)
    G.s_wind_dir_2k = gen_rand_dev(G.s_wind_dir_gnd, -10, 10)
    G.s_wind_dir_8k = gen_rand_dev(G.s_wind_dir_gnd, -20, 20)
    G.s_wind_speed_2k = gen_rand_dev(G.s_wind_speed_gnd, 1, 3)
    G.s_wind_speed_8k = gen_rand_dev(G.s_wind_speed_gnd, 2, 8)


def get_checkwx_fog_visibility(json_weather_l):
    # set fog view visibility distance (how far you can see before fog obscures stuff)
    if not json_weather_l['data'][0].get('visibility'):
        print("NO visibility data")
        return

    i_tmp = json_weather_l['data'][0]['visibility']['meters']
    i_tmp = re.sub('[,+]', '', i_tmp)
    G.s_fog_visibility_m = i_tmp
    G.s_sand_density_m = i_tmp
    # print(G.s_fog_visibility_m)


def get_checkwx_all_weather_parameters(json_weather_l):
    G.s_temperature = get_checkwx_json_temperature(json_weather_l)
    get_checkwx_weather_cloud_atmosphere(json_weather_l)
    get_checkwx_weather_wind(json_weather_l)

    s_raw_report = json_weather_l['data'][0]['raw_text']

    get_checkwx_fog_visibility(json_weather_l)

    get_weather_fog(s_raw_report)
    get_weather_sand_storm(s_raw_report)

    # turbulence
    get_weather_turbulence()
    get_checkwx_weather_qnh(json_weather_l)
    # weather limits
    check_weather_limits()


def get_weather_turbulence():
    # 0 is nothing, 60 is crap your pants time ....  0.1* m = 6mps
    i_min_turbulence = 0
    i_max_turbulence = 20
    i_wind_speed_gnd = int(G.s_wind_speed_gnd)
    #  print("wind sped gnd ", i_wind_speed_gnd)
    if i_wind_speed_gnd <= 5:
        i_min_turbulence = 0
        i_max_turbulence = 12
    if 6 <= i_wind_speed_gnd <= 10:
        i_min_turbulence = 12
        i_max_turbulence = 25
    if 11 <= i_wind_speed_gnd <= 15:
        i_min_turbulence = 15
        i_max_turbulence = 35
    if 16 <= i_wind_speed_gnd <= 20:
        i_min_turbulence = 25
        i_max_turbulence = 50
    if 21 <= i_wind_speed_gnd <= 25:
        i_min_turbulence = 30
        i_max_turbulence = 60
    if i_wind_speed_gnd > 30:
        i_min_turbulence = 35
        i_max_turbulence = 70
    #  print("Turb min ", i_min_turbulence, " max ", i_max_turbulence)
    G.s_turbulence = str(rd.randint(i_min_turbulence, i_max_turbulence))


def get_mission_date_time():  # get the time date store in G.
    if G.i_time_index == 100:
        G.s_start_time = str(rd.randint(0, 86400))
        print("Using Random time")
        return

    elif G.i_time_index == 99:  # this is for real server time to set mission time
        print("Real time")
        # do real time calc stuff here
        a = datetime.datetime.now()
        now = a + datetime.timedelta(0, 180)  # add 180 seconds as it takes this long to spool the server up and load
        # due to summer/winter time check if between change date then + 1
        d_start = datetime.date(now.year, 10, 29)
        d_now_date = datetime.date(now.year, now.month, now.day)
        d_end = datetime.date(now.year + 1, 3, 26)
        if G.b_adjust_for_daylight_savings:
            if d_start < d_now_date < d_end:
                now = a + datetime.timedelta(0, 3780)  # add 1 hour 180 seconds forward

        G.s_year = str(now.year)
        G.s_month = str(now.month)
        G.s_day = str(now.day)
        G.s_hour = str(now.hour)
        G.s_mins = str(now.minute)
        G.s_seconds = str(now.second)
    else:
        # do time array stuff here
        print("Using array time/date # ", G.i_time_index)
        G.s_year = G.l_dates[G.i_time_index][0]
        G.s_month = G.l_dates[G.i_time_index][1]
        G.s_day = G.l_dates[G.i_time_index][2]
        G.s_hour = G.l_dates[G.i_time_index][3]
        G.s_mins = G.l_dates[G.i_time_index][4]
        G.s_seconds = str(0)
    convert_to_hr_and_min_to_seconds()


def get_weather_sand_storm(s_raw_report):
    if not G.b_sand_storm:
        print("NOT persian gulf mission")
        return
    print("Persian Gulf mission")
    l_sand = ['DU', 'SA']  # should I add 'HZ' to this array ?
    if not any(x in s_raw_report for x in l_sand):  # search it for ANY sand storm tags
        G.s_sand_enable = 'false'
        return False
    G.s_sand_enable = 'true'
    # G.s_fog_enable = 'false'


def get_weather_fog(s_raw_report):  # read raw report and see if any fog markers
    l_fog = ['BR', 'FG', 'FU', 'VA', 'HZ', 'PY']  # codes for obscure weather
    if not any(x in s_raw_report for x in l_fog):  # search it for ANY fog tags
        #  print("Fog NOT found")  # debug info
        if int(G.s_fog_visibility_m) >= 6000 or G.s_iprecptns == '0':  # if def val for dist intact? or greater than
            G.s_fog_enable = 'false'
            return False  # bail out and leave defaults as is

    G.s_fog_enable = 'true'
    G.s_fog_thickness_m = str(500 + rd.randint(-50, 200))  # generate a random thickness value
    G.s_fog_density = '7'  # set it to ON


def is_sandstorm_terrain(l_mission):
    s_persian_gulf = '["theatre"] = "PersianGulf"'
    if find_item_index_from_start(l_mission, s_persian_gulf):
        return True
    else:
        return False


def load_json_data(filename):
    with open(filename) as infile:
        data = json.load(infile)
        infile.close()
        return data


def read_mission_file(s_filename_to_read):  # read actual file mission into a list for changing
    file = open(s_filename_to_read, "rU", encoding="utf8")
    l_content = list(file)
    l_content = [x.rstrip('\x0A\x0D') for x in l_content]
    if l_content[0] == 'mission = {}':   # is this a DAWS mission file ?
        G.b_daws_mission = True
    return l_content


def retrieve_json_data_from_web(s_request, s_header=None):  # connect to url and grab METAR data
    print(s_request)
    try:  # Can we get connect to the website..... Better check first verify=False
        response = requests.get(s_request, headers=s_header, timeout=8, verify=True)
        response.raise_for_status()
    except requests.exceptions.HTTPError:
        print(requests.exceptions.HTTPError)
        return False
    except requests.exceptions.ReadTimeout:
        print("HTTP read time out")
        return False
    except requests.exceptions.Timeout:
        print("HTTP time out")
        return False
    except requests.exceptions.TooManyRedirects:
        print("Too many re-directs")
        return False
    except requests.exceptions.RequestException as e:  # catch any problem and print out what it is here
        print(e)
        sys.exit(1)
    else:
        #  print(response.text)  # print out raw data
        json_object = json.loads(response.text)
        if json_object is False:
            return False
        if 'Error' in json_object:  # this is to cover sometimes getting an error string from the server
            # print(json_object)
            return False
        # print(json_object)
        return json_object


def save_json_data(json_data, filename):
    with open(filename, 'w') as outfile:
        json.dump(json_data, outfile)
        outfile.close()


def save_date_and_time(l_mission):  # save time/date info into mission list
    s_year = 'mission["date"]["Year"] ='
    s_day = 'mission["date"]["Day"] = '
    s_month = 'mission["date"]["Month"] = '
    i_mission_size = len(l_mission)

    if G.b_daws_mission:
        if G.i_time_index != 100:
            i_date_start = find_item_index(l_mission, 'mission["date"] = {}', i_mission_size)
            l_mission[i_date_start + 1] = s_year + G.s_year
            l_mission[i_date_start + 2] = s_day + G.s_day
            l_mission[i_date_start + 3] = s_month + G.s_month
        else:
            change_mission_data_item(l_mission, 'mission["start_time"] = ', str(G.s_start_time), '')
    else:
        if G.i_time_index != 100:
            print("Setting date")
            # set year , month and date in mission
            change_mission_data_item(l_mission, '["Year"] = ', str(G.s_year))
            # month
            change_mission_data_item(l_mission, '["Month"] = ', str(G.s_month))
            # day
            change_mission_data_item(l_mission, '["Day"] = ', str(G.s_day))
            # time, hmm tricky find ["forcedOptions"] then -1 write value cos it will be start_time in seconds 00:00
            # because start_time appears a lot thru the mission file

    i_forced = find_item_index(l_mission, '["forcedOptions"]', i_mission_size)
    l_mission[i_forced-1] = '\t' + '["start_time"] = ' + G.s_start_time + ','
    print("Writing seconds start value ", G.s_start_time)


def save_cloud_atmosphere(l_mission):  # save cloud data into mission file list
    s_cloud_start = '["clouds"]'
    s_daws_cloud_start = 'mission["weather"]["clouds"]["thickness"] = '
    s_thickness = '["thickness"] = '
    s_dense = '["density"] = '
    s_cloud_base = '["base"] = '
    s_cloud_rain = '["iprecptns"] = '

    i_max_line = len(l_mission)

    if G.b_daws_mission:
        i_start_clouds = find_item_index(l_mission, s_daws_cloud_start, i_max_line)
        l_mission[i_start_clouds] = s_daws_cloud_start + G.s_cloud_thickness_m  # thickness of clouds
        l_mission[i_start_clouds + 1] = 'mission["weather"]["clouds"]["density"] = ' + G.s_cloud_density
        l_mission[i_start_clouds + 2] = 'mission["weather"]["clouds"]["base"] = ' + G.s_cloud_base_m
        l_mission[i_start_clouds + 3] = 'mission["weather"]["clouds"]["iprecptns"] = ' + G.s_iprecptns

    else:
        # get record count (mission list size)
        i_start_clouds = find_item_index(l_mission, s_cloud_start, i_max_line)  # omitting start means begin index @ 0

        l_mission[i_start_clouds + 2] = '\t\t\t' + s_thickness + G.s_cloud_thickness_m + ","  # thickness of clouds
        l_mission[i_start_clouds + 3] = '\t\t\t' + s_dense + G.s_cloud_density + ","  # density of clouds
        l_mission[i_start_clouds + 4] = '\t\t\t' + s_cloud_base + G.s_cloud_base_m + ","  # cloud base

        change_mission_data_item(l_mission, s_cloud_rain, G.s_iprecptns, '\t\t\t')
        #  l_mission[i_start_clouds + 5] = '\t\t\t' + s_cloud_rain + G.s_iprecptns + ","


def save_data_to_mission(l_mission):  # save all data we have into mission list
    s_temp = '["temperature"] = '
    s_temp_daws = 'mission["weather"]["season"]["temperature"] = '
    s_turb = '["groundTurbulence"] = '
    s_turb_daws = 'mission["weather"]["groundTurbulence"] = '

    save_fog(l_mission)
    save_sand(l_mission)
    save_cloud_atmosphere(l_mission)
    save_wind(l_mission)
    save_qnh(l_mission)
    if G.b_daws_mission:
        i_max_line = len(l_mission)
        i_start_turb = find_item_index(l_mission, s_turb_daws, i_max_line)
        l_mission[i_start_turb] = s_turb_daws + G.s_turbulence
        i_start_temp = find_item_index(l_mission, s_temp_daws, i_max_line)
        l_mission[i_start_temp] = s_temp_daws + G.s_temperature
    else:
        change_mission_data_item(l_mission, s_turb, G.s_turbulence, '\t\t')
        change_mission_data_item(l_mission, s_temp, G.s_temperature, '\t\t\t')


def save_fog(l_mission):  # save fog data into mission list
    s_fog_start = '["fog"]'
    s_fog_vis = '["visibility"] = '
    s_fog_enable = '["enable_fog"] = '
    s_fog_enable_daws = 'mission["weather"]["enable_fog"] = '
    s_thickness = '["thickness"] = '
    s_fog_start_daws = 'mission["weather"]["fog"]["thickness"] = '

    i_max_line = len(l_mission)

    if G.b_daws_mission:
        i_fog_start = find_item_index(l_mission, s_fog_start_daws, i_max_line)
        l_mission[i_fog_start] = s_fog_start_daws + G.s_fog_thickness_m
        l_mission[i_fog_start + 1] = 'mission["weather"]["fog"]["visibility"] = ' + G.s_fog_visibility_m
        # l_mission[i_fog_start + 2] = 'mission["weather"]["fog"]["density"] = ' + G.s_fog_density
        i_fog_en = find_item_index(l_mission, s_fog_enable_daws, i_max_line)
        l_mission[i_fog_en] = s_fog_enable_daws + G.s_fog_enable
    else:
        # find start of fog data stuff
        i_fog_start = find_item_index_from_start(l_mission, s_fog_start)
        i_fog_end = find_item_index_from_start(l_mission, 'end of ["fog"]')

        change_mission_data_item(l_mission_data, s_fog_enable, G.s_fog_enable, '\t\t')  # enable fog flag
        # set fog thickness (height above ground before fog
        change_mission_data_item_v2(l_mission, s_thickness, G.s_fog_thickness_m, i_fog_start, i_fog_end, s_tab='\t\t\t')
        # l_mission[i_fog_start + 2] = '\t\t\t' + s_thickness + G.s_fog_thickness_m + ","  # fog view thickness

        # set fog view visibility distance (how far you can see before fog obscures stuff)
        change_mission_data_item_v2(l_mission, s_fog_vis, G.s_fog_visibility_m, i_fog_start, i_fog_end, s_tab='\t\t\t')
        # l_mission[i_fog_start + 3] = '\t\t\t' + s_fog_vis + G.s_fog_visibility_m + ","  # fog view visibility

        # set fog density - fuck knows what this does but 7 seems ok
        # l_mission[i_fog_start + 3] = '\t\t\t' + s_fog_density + G.s_fog_density + ","  # fog density


def save_qnh(l_mission):
    s_qnh = '["qnh"] = '
    s_qnh_daws = 'mission["weather"]["qnh"] = '
    if not G.b_qnh_update:
        return
    if G.b_daws_mission:
        i_max_line = len(l_mission)
        i_start_qnh = find_item_index(l_mission, s_qnh_daws, i_max_line)
        l_mission[i_start_qnh] = s_qnh_daws + G.s_qnh
    else:
        change_mission_data_item(l_mission_data, s_qnh, G.s_qnh, '\t\t')


def save_sand(l_mission):
    s_sand_enable = '["enable_dust"] = '
    s_sand_density = '["dust_density"] = '
    change_mission_data_item(l_mission_data, s_sand_enable, G.s_sand_enable, '\t\t')
    change_mission_data_item(l_mission_data, s_sand_density, G.s_sand_density_m, '\t\t')


def save_wind(l_mission):  # save wind speed direction info into mission list
    s_wind_speed = '["speed"] = '
    s_wind_dir = '["dir"] = '
    s_wind_at_8k = '["at8000"]'
    s_wind_at_gnd = '["atGround"]'
    s_wind_at_2k = '["at2000"]'
    s_wind_start8k = 'mission["weather"]["wind"]["at8000"]["speed"] = '
    s_wind_startgnd = 'mission["weather"]["wind"]["atGround"]["speed"] = '
    s_wind_start2k = 'mission["weather"]["wind"]["at2000"]["speed"] = '

    i_max_line = len(l_mission)

    if G.b_daws_mission:
        i_start_wind8k = find_item_index(l_mission, s_wind_start8k, i_max_line)
        l_mission[i_start_wind8k] = s_wind_start8k + G.s_wind_speed_8k
        l_mission[i_start_wind8k + 1] = 'mission["weather"]["wind"]["at8000"]["dir"] = ' + G.s_wind_dir_8k

        i_start_windgnd = find_item_index(l_mission, s_wind_startgnd, i_max_line)
        l_mission[i_start_windgnd] = s_wind_startgnd + G.s_wind_speed_gnd
        l_mission[i_start_windgnd + 1] = 'mission["weather"]["wind"]["atGround"]["dir"] = ' + G.s_wind_dir_gnd

        i_start_wind2k = find_item_index(l_mission, s_wind_start2k, i_max_line)
        l_mission[i_start_wind2k] = s_wind_start2k + G.s_wind_speed_2k
        l_mission[i_start_wind2k + 1] = 'mission["weather"]["wind"]["at2000"]["dir"] = ' + G.s_wind_dir_2k

    else:
        # find start of WIND ground section
        i_start_wind_at_gnd = find_item_index(l_mission, s_wind_at_gnd, i_max_line)  # omitting start  begin index @ 0
        l_mission[i_start_wind_at_gnd + 2] = '\t\t\t\t' + s_wind_speed + G.s_wind_speed_gnd + ","
        l_mission[i_start_wind_at_gnd + 3] = '\t\t\t\t' + s_wind_dir + G.s_wind_dir_gnd + ","

        # find start of WIND 2K section
        i_start_wind_at_2k = find_item_index(l_mission, s_wind_at_2k, i_max_line)  # omitting start begin index @ 0
        l_mission[i_start_wind_at_2k + 2] = '\t\t\t\t' + s_wind_speed + G.s_wind_speed_2k + ","
        l_mission[i_start_wind_at_2k + 3] = '\t\t\t\t' + s_wind_dir + G.s_wind_dir_2k + ","

        # find start of WIND 8K section
        i_start_wind_at_8k = find_item_index(l_mission, s_wind_at_8k, i_max_line)  # omitting start  begin index @ 0
        l_mission[i_start_wind_at_8k + 2] = '\t\t\t\t' + s_wind_speed + G.s_wind_speed_8k + ","
        l_mission[i_start_wind_at_8k + 3] = '\t\t\t\t' + s_wind_dir + G.s_wind_dir_8k + ","


def print_all_data():  # debug just so we can see what values we have
    print("b_daws_mission is ", G.b_daws_mission)
    print("s_temperature is ", G.s_temperature)
    print("s_cloud_thickness_m is ", G.s_cloud_thickness_m)
    print("s_cloud_density is ", G.s_cloud_density)
    print("s_cloud_base_m is ", G.s_cloud_base_m)
    print("s_iprecptns is ", G.s_iprecptns)
    print("s_qnh is ", G.s_qnh)
    print("s_wind_speed_8k is ", G.s_wind_speed_8k)
    print("s_wind_dir_8k is ", G.s_wind_dir_8k)
    print("s_wind_speed_2k is ", G.s_wind_speed_2k)
    print("s_wind_dir_2k is ", G.s_wind_dir_2k)
    print("s_wind_speed_gnd is ", G.s_wind_speed_gnd)
    print("s_wind_dir_gnd is ", G.s_wind_dir_gnd)
    print("s_turbulence is ", G.s_turbulence)
    print("s_fog_enable ", G.s_fog_enable)
    print("s_fog_visibility_m ", G.s_fog_visibility_m)
    print("s_fog_thickness_m ", G.s_fog_thickness_m)
    print("s_fog_density ", G.s_fog_density)
    print("s_sand_enable ", G.s_sand_enable)
    print("s_sand_density ", G.s_sand_density_m)
    print("s_airport_icao ", G.s_airport_icao)
    print("s_backup_airport ", G.s_backup_airport)
    print("s_year ", G.s_year)
    print("s_month ", G.s_month)
    print("s_day ", G.s_day)
    print("s_hour ", G.s_hour)
    print("s_mins ", G.s_mins)
    print("s_seconds ", G.s_seconds)
    print("s_start_time ", G.s_start_time)
    print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")


def represents_int(s_value):
    try:
        int(s_value)
        return True
    except ValueError:
        return False


def weather_read_url_checkwx():  # try to read metar data for airport(s) from internet
    if G.s_api_key_checkwx == 'NOT_SET_YET':
        not_setup_correctly()

    s_url1 = 'https://api.checkwx.com/metar/' + G.s_airport_icao + '/decoded'
    s_url2 = 'https://api.checkwx.com/metar/' + G.s_backup_airport + '/decoded'
    s_headers = {'X-API-Key': G.s_api_key_checkwx}

    json_object = False  # just stuck this here to stick pycharm whining like a little bitch
    # we should try primary twice with a 5 second wait between attempts
    i_count = 0
    while i_count < 1:
        json_object = retrieve_json_data_from_web(s_url1, s_headers)  # try primary airport
        if json_object is not False:
            break
        time.sleep(5)
        i_count += 1

    if json_object is False:
        i_count = 0
        while i_count < 2:
            json_object = retrieve_json_data_from_web(s_url2, s_headers)  # try backup airport
            if json_object is not False:
                break
            time.sleep(5)
            i_count += 1

    return json_object


def weather_read_url_avwx():  # try to read metar data for airport(s) from internet
    s_url_base = "https://avwx.rest/api/preview/metar/"
    # s_url_base = "https://avwx.rest/api/metar/"
    s_url1 = s_url_base + G.s_airport_icao
    s_url2 = s_url_base + G.s_backup_airport
    json_object = False  # just stuck this here to stick pycharm whining like a little bitch

    # we should try primary twice with a 5 second wait between attempts
    i_count = 0
    while i_count < 1:
        json_object = retrieve_json_data_from_web(s_url1)  # try primary airport
        if json_object is not False:
            break
        time.sleep(5)
        i_count += 1

    if json_object is False:
        i_count = 0
        while i_count < 2:
            json_object = retrieve_json_data_from_web(s_url2)  # try backup airport
            if json_object is not False:
                break
            time.sleep(5)
            i_count += 1

    return json_object


def write_mission_file(s_filename_to_write, l_mission):  # write mission list into mission file
    f = open(s_filename_to_write, 'w', encoding="utf8")
    s1 = '\x0D'.join(l_mission)
    f.write(s1)
    f.close()
    change_newline_chars_in_file(s_filename_to_write)  # do not ask ..... problems with extra chars being added


# extract mission file from mission miz
extract_mission_file(G.s_mission_miz_path, G.s_mission_miz_filename, 'mission')

# read mission file into a list item
l_mission_data = read_mission_file(G.s_mission_miz_path + 'mission')

G.b_sand_storm = is_sandstorm_terrain(l_mission_data)

# get realtime date and change in mission file (if necessary)
if G.b_change_time:
    get_mission_date_time()
    save_date_and_time(l_mission_data)

print_all_data()  # debug just for seeing what things started at

if G.b_update_weather:
    if G.b_debug_load:
        debug_load()
    else:
        if G.s_api_key_checkwx == 'NOT_YET_SET':
            not_setup_correctly()
            # exit(1)

        get_weather1()
        if G.json_weather is False:
            get_weather2()

            if G.json_weather is False:
                print("WARNING - METAR data read failure")
                print("Using default weather values instead")

print(G.json_weather)
save_data_to_mission(l_mission_data)  # write G. global variables for weather into mission list

print_all_data()  # debug just for seeing what things actually are in the file

write_mission_file('mission', l_mission_data)  # now take mission list and write it back to file

repack_mission_file(G.s_mission_miz_path, G.s_mission_miz_filename, 'mission') # saves mission file back to miz

os.remove(G.s_mission_miz_path + 'mission')

print("weather.py", s_version_info, " exiting")
