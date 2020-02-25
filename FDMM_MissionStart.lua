if __DISTILLER==nil then
__DISTILLER=nil
__DISTILLER={FACTORIES={},__nativeRequire=require,require=function(e)assert(type(e)=="string","require invalid id:"..tostring(e))if package.loaded[e]then
return package.loaded[e]end
if __DISTILLER.FACTORIES[e]then
local n=__DISTILLER.FACTORIES[e]package.loaded[e]=n(__DISTILLER.require)or true
return package.loaded[e]end
return __DISTILLER.__nativeRequire(e)end,define=function(i,e,n)assert(type(e)=="string","invalid id:"..tostring(e))assert(type(n)=="function","invalid factory:"..tostring(n))if package.loaded[e]==nil and i.FACTORIES[e]==nil then
i.FACTORIES[e]=n
else
print("[__DISTILLER::define] module "..tostring(e).." is already defined")end
end,exec=function(e,n)local e=e.FACTORIES[n]assert(e,"missing factory method for id "..tostring(n))e(__DISTILLER.require)end}end
__DISTILLER:define("FDMM_Config",function(e)env.info("---FDMM_Config Start---");fdmm.majorVersion=0
fdmm.minorVersion=2
fdmm.enums={}fdmm.consts={}fdmm.config={}fdmm.setup={}do
fdmm.enums.Faction={Red='Red',Blue='Blue',Neutral='Neutral',USA='USA',Russia='Russia',Georgia='Georgia',Turkey='Turkey',Ukraine='Ukraine',Unused='Unused'}fdmm.enums.ErrorCodes={Success=0,Failure=1,Incomplete=2,Cancelled=3,InvalidParam=4,ShouldNotBeReached=5}fdmm.consts.UserFlags={DebugFlag='99999'}end
do
fdmm.enums.CargoRouteType={Land='land',Train='train',Air='air',Sea='sea',All='all'}fdmm.consts.CargoRouteGNPrefix={Land='CVRT_',Train='CTRT_',Air='CART_',Sea='CSRT_'}fdmm.consts.CargoRouteWPRoutePrefix={Land={Spawn='CVSP_',Linkage='CVLK_',Facility='CVFC_'},Train={Spawn='CTSP_',Linkage='CTLK_',Facility='CTFC_'},Air={Spawn='CASP_',Linkage='CALK_',Facility='CAFC_'},Sea={Spawn='CSSP_',Linkage='CSLK_',Facility='CSFC_'}}fdmm.consts.CargoRouteWPRouteSuffix={Egress='_EP',Ingress='_IP',Spawn='_SP',Linkage='_LK',Facility='_FC'}end
do
fdmm.enums.FacilityType={Airbase='airbase',ArmsPlant='armsPlant',CommandCenter='commandCenter',FARP='farp',OilField='oilField',Port='port',UnitFactory='unitFactory',All='all'}end
do
fdmm.enums.RPType={Fuel='fuel',Arms='arms',Unit='unit'}fdmm.enums.RPAmountType={Tons='tons',PercentMaxSelf='percent_ms',PercentMaxOther='percent_mo',PercentCurrSelf='percent_cs',PercentCurrOther='percent_co'}end
do
fdmm.enums.TerritoryType={Land='land',Sea='sea',All='all'}fdmm.consts.TerritoryGNPrefix={Define='TDEF_',Linkage='TLNK_',Facility='TFAC_'}fdmm.consts.TerritoryWPFacilityPrefix={Airbase='TARB_',ArmsPlant='TARM_',CommandCenter='TCMD_',FARP='TFRP_',OilField='TOIL_',Port='TPRT_',UnitFactory='TUNT_'}end
do
fdmm.enums.UnitType={Plane='plane',Helicopter='helicopter',Ground='ground',Train='train',Ship='ship',Static='static'}end
do
function fdmm.config.runUserSetupScript()fdmm.setup={}dofile(fdmm.fullPath.."FDMM_Setup.lua")end
function fdmm.config.createGPCache()fdmm.config.gpCache={}local i={'AIRB_','ARMP_','CMDC_','FARP_','OILF_','PORT_','UNTF_'}for n,r in pairs(mist.DBs.groupsByName)do
local t,e=fdmm.utils.removeGroupingPrefix(n)if e~=nil then
if not fdmm.config.gpCache[e]then
fdmm.config.gpCache[e]={}end
if table.contains(i,e)then
local i=string.find(t,'_')if i~=nil then
local i=t:sub(1,i-1)if not fdmm.config.gpCache[e][i]then
fdmm.config.gpCache[e][i]={}end
fdmm.config.gpCache[e][i][n]=r
else
if not fdmm.config.gpCache[e]['_']then
fdmm.config.gpCache[e]['_']={}end
fdmm.config.gpCache[e]['_'][n]=r
end
else
fdmm.config.gpCache[e][n]=r
end
end
end
end
end
fdmm.config.runUserSetupScript()env.info("---FDMM_Config End---");end)__DISTILLER:define("FDMM_Utils",function(e)env.info("---FDMM_Utils Start---");fdmm.utils={}do
function fdmm.utils.pos2ToLoggableString(e)if e.z~=nil then e=mist.utils.makeVec2(e)end
return'~{'..mist.utils.round(e.x,-2)..','..mist.utils.round(e.y,-2)..'}'end
function fdmm.utils.pos3ToLoggableString(e)if e.z==nil then e=mist.utils.makeVec3(e)end
return'~{'..mist.utils.round(e.x,-2)..','..mist.utils.round(e.z,-2)..',a:'..mist.utils.round(e.y,-1)..'}'end
function fdmm.utils.getGroupingPrefix(e)if e then
local n=string.find(e,'_')if n~=nil then
local e=e:sub(1,n)if e==e:upper()then
return e
end
end
end
return nil
end
function fdmm.utils.removeGroupingPrefix(e)local n=fdmm.utils.getGroupingPrefix(e)if n~=nil then
return e:sub(#n+1),n
end
return e,nil
end
function fdmm.utils.getNumericSuffix(e)if e then
local i,n=e:reverse():find('# ')if n~=nil then
local e=e:sub(-n)if e==e:match(' #[%d]+')then
return e
end
end
end
return nil
end
function fdmm.utils.removeNumericSuffix(e)local n=fdmm.utils.getNumericSuffix(e)if n~=nil then
return e:sub(1,-#n-1),n
end
return e,nil
end
function fdmm.utils.getGroupingSuffix(e)if e then
local n=e:reverse():find('_')if n~=nil then
return e:sub(-n)end
end
return nil
end
function fdmm.utils.removeGroupingSuffix(e)local n=fdmm.utils.getGroupingSuffix(e)if n~=nil then
return e:sub(1,-#n-1),n
end
return e,nil
end
function fdmm.utils.getGroupingComponents(e)if e then
local n,i
e=fdmm.utils.removeNumericSuffix(e)e,n=fdmm.utils.removeGroupingPrefix(e)e,i=fdmm.utils.removeGroupingSuffix(e)return n,e,i
end
return nil,nil,nil
end
function fdmm.utils.getGroupingComponentsWithSNC(e,r,t)local n,e,i=fdmm.utils.getGroupingComponents(e)if string.isEmpty(n)and table.contains(r or{},(e..'_'))then
n=(e..'_')e=nil
elseif string.isEmpty(i)and table.contains(t or{},('_'..e))then
i=('_'..e)e=nil
end
return n,e,i
end
function fdmm.utils.rposFromRPoint(e)return{x=e.x or e.point.x,y=e.y or e.point.y,routePoint=mist.utils.deepCopy(e)}end
function fdmm.utils.getFaction(e)if e then
e=fdmm.utils.removeNumericSuffix(e)for n,i in pairs(fdmm.enums.Faction)do
if i:lower()==e:lower()then
return n
end
end
end
return fdmm.enums.Faction.Unused
end
function fdmm.utils.reversedDict(r)local n={}for i,e in pairs(r)do
if(type(i)=='string'or type(i)=='number')and(type(e)=='string'or type(e)=='number')then
if not n[e]then
n[e]=i
elseif n[e]~=i then
if type(n[e])~='table'then
n[e]={n[e]}end
if not r.contains(n[e],i)then
r.insert(n[e],i)end
end
end
end
return n
end
function fdmm.utils.splitDoublet(e)if e then
return e:match("([^:]*):([^:]*)")end
return nil,nil
end
function fdmm.utils.splitTriplet(e)if e then
return e:match("([^:]*):([^:]*):([^:]*)")end
return nil,nil,nil
end
function fdmm.utils.isUserFlagSet(e)local e=trigger.misc.getUserFlag(e)return(type(e)=='number'and e~=0)or(type(e)=='boolean'and e~=false)or(type(e)=='string'and e:lower()~='false'and e~='0'and e:lower()~='off'and e:lower()~='no')end
function fdmm.utils.isDebugFlagSet()return fdmm.utils.isUserFlagSet(fdmm.consts.UserFlags.DebugFlag)end
function fdmm.utils.isDesertMap()return env.mission.theatre==DCSMAP.NTTR or env.mission.theatre==DCSMAP.PersianGulf
end
end
env.info("---FDMM_Utils End---");end)__DISTILLER:define("Additions/FDMM_LuaAdditions",function(e)env.info('---FDMM_LuaAdditions Start---')do
function string.contains(e,n)return string.find(e,n,0,true)~=nil
end
function string.hasPrefix(n,e)return string.sub(n,1,#e)==e
end
function string.hasAnyPrefix(e,n)for i,n in pairs(n)do
if string.hasPrefix(e,n)then
return true
end
end
return false
end
function string.hasSuffix(n,e)return string.sub(n,-#e)==e
end
function string.hasAnySuffix(n,e)for i,e in pairs(e)do
if string.hasSuffix(n,e)then
return true
end
end
return false
end
function string.isEmpty(e)return e==nil or#e==0
end
function string.isNotEmpty(e)return e~=nil and#e>0
end
function string.notEmptyElse(e,n)if e~=nil and#e>0 then
return e
end
return n
end
function string.upperFirst(e)return e:sub(1,1):upper()..e:sub(2)end
function table.contains(n,e)for i,n in pairs(n)do
if n==e then
return true
end
end
return false
end
function table.concatedWith(n,i)local e=nil
if n or i then
e={}if n then
for i,n in pairs(n)do
e[i]=n
end
end
if i then
for i,n in pairs(i)do
e[i]=n
end
end
end
return e
end
function table.concatWith(i,e)if e then
for e,n in pairs(e)do
i[e]=n
end
end
end
function table.concatedWithi(n,i)local e=nil
if n or i then
e={}if n then
for i,n in ipairs(n)do
table.insert(e,n)end
end
if i then
for i,n in ipairs(i)do
table.insert(e,n)end
end
end
return e
end
function table.concatWithi(n,e)if e then
for i,e in ipairs(e)do
table.insert(n,e)end
end
end
function table.keysList(n)local e={}for n,i in pairs(n)do
table.insert(e,n)end
return e
end
function table.sortedKeysList(e)local e=table.keysList(e)table.sort(e)return e
end
end
env.info('---FDMM_LuaAdditions End---')end)__DISTILLER:define("FDMM_UnitTypes",function(e)env.info("---FDMM_UnitTypes Start---");e('Additions/FDMM_LuaAdditions')fdmm.unitTypes={}do
fdmm.consts.UnitType={Plane={Fighter={AirSuperiority={F14A='F-14A',F14B='F-14B',F15C='F-15C',F15E='F-15E',F16A='F-16A',F16Cb50='F-16C bl.50',F16CMb50='F-16C_50',F16Cb52d='F-16C bl.52d',J11A='J-11A',MiG29A='MiG-29A',MiG29G='MiG-29G',MiG29S='MiG-29S',Su27='Su-27',Su33='Su-33'},Interceptor={F14A='F-14A',F14B='F-14B',F4E='F-4E',MiG21b='MiG-21Bis',MiG25PD='MiG-25PD',MiG31='MiG-31'},Strike={AJS37='AJS37',F4E='F-4E',FA18A='F/A-18A',FA18C='F/A-18C',FA18Cl20='FA-18C_hornet',Su17M4='Su-17M4',Su34='Su-34',TornadoGR4='Tornado GR4',TornadoIDS='Tornado IDS'},Multirole={AJS37='AJS37',F4E='F-4E',F14A='F-14A',F14B='F-14B',F15C='F-15C',F15E='F-15E',F16A='F-16A',F16Cb50='F-16C bl.50',F16CMb50='F-16C_50',F16Cb52d='F-16C bl.52d',FA18A='F/A-18A',FA18C='F/A-18C',FA18Cl20='FA-18C_hornet',J11A='J-11A',JF17='JF-17',M2000C='M-2000C',M20005='Mirage 2000-5',MiG21b='MiG-21Bis',MiG23MLD='MiG-23MLD',MiG29A='MiG-29A',MiG29G='MiG-29G',MiG29K='MiG-29K',MiG29S='MiG-29S',Su27='Su-27',Su30='Su-30',Su33='Su-33',TornadoGR4='Tornado GR4',TornadoIDS='Tornado IDS'},Light={F5E='F-5E',F5E3='F-5E-3',F86F='F-86F Sabre',MiG15b='MiG-15bis',MiG19P='MiG-19P'},},Bomber={Strategic={B1B='B1-B',B52H='B-52H',Tu95MS='Tu-95MS',Tu160='Tu-160'},Tactical={Tu22M3='Tu-22M3'},Attack={A10A='A-10A',A10C='A-10C',AV8BNA='AV8BNA',MiG27K='MiG-27K',Su24M='Su-24M',Su25='Su-25',Su25T='Su-25T',Su25TM='Su-25TM'},Stealth={F117A='F-117A'},Light={C101CC='C-101CC',L39ZA='L-39ZA'},ASW={S3B='S-3B',Tu142='Tu-142'},},Reconnaissance={Arial={An30M='An-30M',Tu142='Tu-142'},Bomber={MiG25RBT='MiG-25RBT',Su24MR='Su-24MR'},Drone={MQ9='MQ-9 Reaper',RQ1A='RQ-1A Predator'}},AWACS={A50='A-50',E2C='E-2C',E3A='E-3A',KJ2000='KJ-2000'},Refueling={IL78M='IL-78M',KC130='KC130',KC135='KC-135',KC135MPRS='KC135MPRS',S3BTanker='S-3B Tanker'},Transport={Strategic={C17A='C-17A',IL76MD='IL-76MD'},Tactical={An26B='An-26B',C130='C-130'}},Trainer={Jet={C101EB='C-101EB',F16AMLU='F-16A MLU',HawkT1A='Hawk',L39C='L-39C'},Prop={TF51D='TF-51D',Yak52='Yak-52'}},Civilian={Aerobatic={CEII='Christen Eagle II'},Transport={Yak40='Yak-40'}},CarrierBorne={AV8BNA='AV8BNA',E2C='E-2C',F4E='F-4E',FA18A='F/A-18A',FA18C='F/A-18C',FA18Cl20='FA-18C_hornet',MiG29K='MiG-29K',S3B='S-3B',S3BTanker='S-3B Tanker',Su33='Su-33'},PlayerControllable={A10A='A-10A',A10C='A-10C',AJS37='AJS37',AV8BNA='AV8BNA',F14B='F-14B',F15C='F-15C',F16CMb50='F-16C_50',FA18Cl20='FA-18C_hornet',F5E3='F-5E-3',F86F='F-86F Sabre',JF17='JF-17',M2000C='M-2000C',MiG15b='MiG-15bis',MiG19P='MiG-19P',MiG21b='MiG-21Bis',MiG29A='MiG-29A',MiG29G='MiG-29G',MiG29S='MiG-29S',Su25='Su-25',Su25T='Su-25T',Su27='Su-27',Su33='Su-33',C101CC='C-101CC',C101EB='C-101EB',HawkT1A='Hawk',L39C='L-39C',L39ZA='L-39ZA',TF51D='TF-51D',Yak52='Yak-52',CEII='Christen Eagle II'},All={},NATOReporting={['A-50']=":'Mainstay'",['An-26B']=":'Curl'",['An-30M']=":'Clank'",['IL-76MD']=":'Candid'",['IL-78M']=":'Midas'",['J-11A']=":'Flanker-L'",['KJ-2000']=":'Mainring'",['MiG-15bis']=":'Fagot'",['MiG-19P']=":'Farmer-B'",['MiG-21Bis']=":'Fishbed-L/N'",['MiG-23MLD']=":'Flogger-K'",['MiG-25RBT']=":'Foxbat-B'",['MiG-25PD']=":'Foxbat-E'",['MiG-27K']=":'Flogger-J2'",['MiG-29A']=":'Fulcrum-A'",['MiG-29K']=":'Fulcrum-D'",['MiG-29S']=":'Fulcrum-C'",['MiG-31']=":'Foxhound'",['Su-17M4']=":'Fitter-K'",['Su-24M']=":'Fencer-D'",['Su-24MR']=":'Fencer-E'",['Su-25']=":'Frogfoot'",['Su-25T']=":'Frogfoot'",['Su-25TM']=":'Frogfoot'",['Su-27']=":'Flanker'",['Su-30']=":'Flanker-C'",['Su-33']=":'Flanker-D'",['Su-34']=":'Fullback'",['Tu-22M3']=":'Backfire-C'",['Tu-95MS']=":'Bear-H'",['Tu-142']=":'Bear-F/J'",['Tu-160']=":'Blackjack'",['Yak-40']=":'Codling'"},ReportNaming={['AJS37']='AJS 37',['AV8BNA']='AV-8B N/A',['B1-B']='B-1B',['F-16C_50']='F-16CM bl.50',['FA-18C_hornet']='F/A-18C l.20',['F-86F Sabre']='F-86F',['KC130']='KC-130',['KC135MPRS']='KC-135 MPRS',['Hawk']='Hawk T1A',['M-2000C']='Mirage 2000C',['MiG-21Bis']='MiG-21bis',['MQ-9 Reaper']='MQ-9',['RQ-1A Predator']='RQ-1A',},ProperNaming={['A-10A']='Thunderbolt II',['A-10C']='Thunderbolt II',['AJS37']='Viggen',['AV8BNA']='Harrier II',['B1-B']='Lancer',['B-52H']='Stratofortress',['C-101CC']='Aviojet',['C-101EB']='Aviojet',['C-17A']='Globemaster III',['C-130']='Hercules',['E-2C']='Hawkeye',['E-3A']='Sentry',['F-4E']='Phantom II',['F-5E']='Tiger II',['F-5E-3']='Tiger II',['F-14A']='Tomcat',['F-14B']='Tomcat',['F-15C']='Eagle',['F-15E']='Strike Eagle',['F-16A']='Fighting Falcon',['F-16A MLU']='Fighting Falcon',['F-16C bl.50']='Fighting Falcon',['F-16C_50']='Fighting Falcon',['F-16C bl.52d']='Fighting Falcon',['F/A-18A']='Hornet',['F/A-18C']='Hornet',['FA-18C_hornet']='Hornet',['F-86F Sabre']='Sabre',['F-117A']='Nighthawk',['KC-135']='Stratotanker',['KC135MPRS']='Stratotanker',['L-39C']='Albatros',['L-39ZA']='Albatros',['M-2000C']='Chasseur',['MQ-9 Reaper']='Reaper',['RQ-1A Predator']='Predator',['S-3B']='Viking',['S-3B Tanker']='Viking',['TF-51D']='Mustang'},Nicknaming={['A-10A']='Warthog',['A-10C']='Warthog',['F-16A']='Viper',['F-16A MLU']='Viper',['F-16C bl.50']='Viper',['F-16C_50']='Viper',['F-16C bl.52d']='Viper'}},Helicopter={Attack={AH1W='AH-1W',AH64A='AH-64A',AH64D='AH-64D',Ka50='Ka-50',Mi24V='Mi-24V',Mi28N='Mi-28N'},Reconnaissance={OH58D='OH-58D',SA342L='SA342L',SA342M='SA342M',SA342Mg='SA342Minigun',SA342Ms='SA342Mistral',},Light={SA342L='SA342L',SA342M='SA342M',SA342Mg='SA342Minigun',SA342Ms='SA342Mistral',UH1H='UH-1H'},Transport={Strategic={CH47D='CH-47D',CH53E='CH-53E',Mi26='Mi-26'},Tactical={Mi8MTV2='Mi-8MT',SH60B='SH-60B',UH1H='UH-1H',UH60A='UH-60A',},Assault={Mi24V='Mi-24V',SH60B='SH-60B',UH1H='UH-1H',UH60A='UH-60A'}},ASW={Ka27='Ka-27',SH60B='SH-60B'},CarrierBorne={AH1W='AH-1W',CH53E='CH-53E',Ka27='Ka-27',SH60B='SH-60B'},PlayerControllable={Ka50='Ka-50',SA342L='SA342L',SA342M='SA342M',SA342Mg='SA342Minigun',SA342Ms='SA342Mistral',UH1H='UH-1H',Mi8MTV2='Mi-8MT'},All={},NATOReporting={['Ka-27']=":'Helix'",['Ka-50']=":'Hokum-A'",['Mi-8MT']=":'Hip'",['Mi-24V']=":'Hind-E'",['Mi-26']=":'Halo'",['Mi-28N']=":'Havoc'"},ReportNaming={['SA342L']='SA 342L',['SA342M']='SA 342M',['SA342Minigun']='SA 342 Mg',['SA342Mistral']='SA 342 Ms'},ProperNaming={['AH-1W']='SuperCobra',['AH-64A']='Apache',['AH-64D']='Apache',['CH-47D']='Chinook',['CH-53E']='Sea Stallion',['Ka-50']='Black Shark',['OH-58D']='Kiowa',['SA342L']='Gazelle',['SA342M']='Gazelle',['SA342Minigun']='Gazelle',['SA342Mistral']='Gazelle',['SH-60B']='Seahawk',['UH-1H']='Huey',['UH-60A']='Black Hawk'},Nicknaming={['AH-1W']='HueyCobra',['Mi-24V']='Crocodile'}},Ground={Tracked={HQ={Sborka9S80M1='Dog Ear radar'},MBT={ChallengerII='Challenger2',AMX56Leclerc='Leclerc',Leopard1A3='Leopard1A3',Leopard2A5='Leopard-2',M1A2Abrams='M-1 Abrams',M60A3Patton='M-60',MerkavaMk4='Merkava_Mk4',T55='T-55',T72B='T-72B',T80U='T-80UD',T90='T-90',ZTZ96B='ZTZ96B'},IFV={BMD1='BMD-1',BMP1='BMP-1',BMP2='BMP-2',BMP3='BMP-3',M2A2Bradley='M-2 Bradley',Marder1A3='Marder',MCV80='MCV-80',ZBD04A='ZBD04A'},ARV={BRDM2='BRDM-2',BTRRD='BTR_D',MTLBuBoman='Boman'},APC={AAV7='AAV7',M1043HMMWVMg='M1043 HMMWV Armament',M1126StrykerICV='M1126 Stryker ICV',M113='M-113',MTLB='MTLB'},MLRS={M270={_HasWheeledComps=true,Launcher={M270MLRSLN='MLRS'}},},SPH={M109Paladin='M-109',Gvozdika2S1='SAU Gvozdika',Msta2S19='SAU Msta',Akatsia2S3='SAU Akatsia',Nona2S9='SAU 2-C9',SpGHDana='SpGH_Dana'},EWR={RolandEWR='Roland Radar'},SAM={M48Chaparral='M48 Chaparral',M6Linebacker='M6 Linebacker',RolandADS='Roland ADS',SA6={SearchTrackRadar={SA6KubSTR_1S91='Kub 1S91 str'},Launcher={SA6KubLN_2P25='Kub 2P25 ln'}},SA11={HQ={SA11BukCC_9S470M1='SA-11 Buk CC 9S470M1'},SearchRadar={SA11BukSR_9S18M1='SA-11 Buk SR 9S18M1'},Launcher={SA11BukLN_9A310M1='SA-11 Buk LN 9A310M1'}},SA13Strela10M3_9A35M3='Strela-10M3',SA15Tor_9A331='Tor 9A331',SA19Tunguska_2S6='2S6 Tunguska'},AAA={FlakPzGepard1A2='Gepard',ZSU234Shilka='ZSU-23-4 Shilka',M163Vulcan='Vulcan'}},Wheeled={HQ={LandRover101FC='Land_Rover_101_FC',SKP11ATCMCP='SKP-11',Ural375PBU='Ural-375 PBU',ZiL131KUNG='ZIL-131 KUNG'},SPG={M1128StrykerMGS='M1128 Stryker MGS'},ATGM={M1024HMMWVTOW='M1045 HMMWV TOW',M1134StrykerATGM='M1134 Stryker ATGM'},ARV={LAV25='LAV-25'},APC={BMT2Cobra='Cobra',BTR80='BTR-80',M1025HMMWV='Hummer',TPzFuchs='TPZ'},SSM={ScudBLauncher='Scud_B'},MLRS={BM21Grad='Grad-URAL',BM27Uragan_9K57='Uragan_BM-27',BM30Smerch_9A52='Smerch',M270={_HasTrackedComps=true,HQ={M270MLRSFDDM='MLRS FDDM'}}},EWR={P1455G6='55G6 EWR',P181L13='1L13 EWR'},SAM={AvengerM1097='M1097 Avenger',HQ7={SearchTrackRadar={HQ7SPSTR='HQ-7_STR_SP'},Launcher={HQ7SPLN='HQ-7_LN_SP'}},Patriot={_HasPortableComps=true,HQ={PatriotECS_ANMSQ104='Patriot ECS'},DataProcessing={PatriotICC='Patriot cp'},Power={PatriotEPPIII='Patriot EPP'},Antenna={PatriotAMG_ANMRC137='Patriot AMG'}},SA3S125={_HasPortableComps=true,SearchRadar={SA3S125SR_P19='p-19 s-125 sr'}},SA8Osa_9A33='Osa 9A33 ln',SA9Strela1_9P31='Strela-1 9P31',SA10S300PS={_HasPortableComps=true,HQ={SA10S300PSCP_54K6='S-300PS 54K6 cp'},SearchRadar={SA10S300PSSR_64H6E='S-300PS 64H6E sr'},MasterLauncher={SA10S300PSLN_5P85C='S-300PS 5P85C ln'},SlaveLauncher={SA10S300PSLN_5P85D='S-300PS 5P85D ln'}}},AAA={Soldier={ZU23Ural375='Ural-375 ZU-23'},Insurgent={ZU23Ural375_Insurgent='Ural-375 ZU-23 Insurgent'}},Power={APA5D_Ural4320='Ural-4320 APA-5D',APA80_ZiL131='ZiL-131 APA-80'},Fire={M1142HEMTTTFFT='HEMTT TFFT',UralATsP6='Ural ATsP-6'},Transport={Armored={Ural432031A='Ural-4320-31'},Open={GAZ66='GAZ-66',Ural375='Ural-375'},Covered={GAZ3308='GAZ-3308',KAMAZ43101='KAMAZ Truck',KrAZ6322='KrAZ6322',M818='M 818',Ural4320T='Ural-4320T'},Lubricant={ATMZ5='ATMZ-5'},Fuel={ATZ10='ATZ-10',M978HEMTTTanker='M978 HEMTT Tanker'}},Car={M1025HMMWV='Hummer',LandRover109S3='Land_Rover_109_S3',Tigr_233036='Tigr_233036',UAZ469='UAZ-469'}},Portable={DroneCommand={HQ={PreadtorGCS='Predator GCS'},Dish={PredatorTS='Predator TrojanSpirit'}},SSM={CSSC2={SearchRadar={CSSC2SilkwormSR='Silkworm_SR'},Launcher={CSSC2SilkwormLN='hy_launcher'}}},SAM={Hawk={HQ={HawkPCP='Hawk pcp'},ContWaveAcqRadar={HawkCWAR_ANMPQ55='Hawk cwar'},SearchRadar={HawkSR_ANMPQ50='Hawk sr'},TrackRadar={HawkTR_ANMPQ46='Hawk tr'},Launcher={HawkLN_M192='Hawk ln'}},Patriot={_HasWheeledComps=true,Launcher={PatriotLN_M901='Patriot ln'},SearchTrackRadar={PatriotSTR_ANMPQ53='Patriot str'}},Rapier={TrackRadar={RapierFSATR='rapier_fsa_blindfire_radar'},TrackOptical={RapierFSATO='rapier_fsa_optical_tracker_unit'},Launcher={RapierFSALN='rapier_fsa_launcher'}},SA2S75={TrackRadar={SA2S75TR_SNR75='SNR_75V'},Launcher={SA2S75LN_SM90='S_75M_Volhov'}},SA3S125={_HasWheeledComps=true,TrackRadar={SA3S125TR_SNR='snr s-125 tr'},Launcher={SA3S125LN_5P73='5p73 s-125 ln'}},SA10S300PS={_HasWheeledComps=true,SearchRadar={SA10S300PSSR_5N66M='S-300PS 40B6MD sr'},TrackRadar={SA10S300PSTR_30N6='S-300PS 40B6M tr'}}},AAA={Soldier={Fortified={ZU23Closed='ZU-23 Emplacement Closed'},Emplacement={ZU23='ZU-23 Emplacement'}},Insurgent={Fortified={ZU23Closed_Insurgent='ZU-23 Closed Insurgent'},Emplacement={ZU23_Insurgent='ZU-23 Insurgent'}}}},Infantry={Beacon={TACANBeacon_TTS3030='TACAN_beacon'},Mortar={M2B11='2B11 mortar'},SAM={SA18={Soldier={Comm={SA18IGLAComm='SA-18 Igla comm'},Launcher={SA18IGLAMANPAD='SA-18 Igla manpad'}},Insurgent={Comm={SA18IGLAComm='SA-18 Igla comm'},Launcher={SA18IGLAMANPAD_Insurgent='Igla manpad INS'}}},SA24={Comm={SA24IGLASComm='SA-18 Igla-S comm'},Launcher={SA24IGLASMANPAD='SA-18 Igla-S manpad'}},Stinger={Comm={StingerComm='Stinger comm',StingerComm_ISR='Stinger comm dsr',},Launcher={StingerMANPAD='Soldier stinger'}}},MG={Soldier={SoldierM249='Soldier M249'}},Rifle={Soldier={GeorgianM4='Soldier M4 GRG',SoldierM4='Soldier M4',RussianAK='Infantry AK',SoldierAK='Soldier AK'},Insurgent={InsurgentAK='Infantry AK Ins'},Paratrooper={ParatroopAKS74='Paratrooper AKS-74'}},RPG={Soldier={SoldierRPG='Soldier RPG'},Insurgent={SoldierRPG='Soldier RPG'},Paratrooper={ParatroopRPG16='Paratrooper RPG-16'}}},Fort={Barracks1='house1arm',House='houseA_arm',HillsideBunker='Sandbox',PillboxBunker='Bunker',Outpost='outpost',RoadOutpost='outpost_road',WatchTower='house2arm',WarningBoard='warning_board_a'},Civilian={Trailer={MAZ6303='MAZ-6303'},Truck={Fire={UralATsP6='Ural ATsP-6'},Transport={Open={ZiL4331='ZIL-4331'},Covered={GAZ3307='GAZ-3307'}}},Bus={Double={IKARUS280='IKARUS Bus'},Single={LAZ695='LAZ Bus',ZIU9='Trolley bus'}},Car={VAZ2109='VAZ Car'},},Amphibious={AAV7='AAV7',BMP1='BMP-1',BMP2='BMP-2',BRDM2='BRDM-2',BTRRD='BTR_D',LAV25='LAV-25',MTLB='MTLB',MTLBuBoman='Boman',SA8Osa_9A33='Osa 9A33 ln',Gvozdika2S1='SAU Gvozdika',Nona2S9='SAU 2-C9'},HeavyWheeled={M1142HEMTTTFFT='HEMTT TFFT',M978HEMTTTanker='M978 HEMTT Tanker',SA10S300PSCP_54K6='S-300PS 54K6 cp',SA10S300PSSR_64H6E='S-300PS 64H6E sr',SA10S300PSLN_5P85C='S-300PS 5P85C ln',SA10S300PSLN_5P85D='S-300PS 5P85D ln',ScudBLauncher='Scud_B',TPzFuchs='TPZ'},All={},NATOReporting={['Dog Ear radar']="PPRU-M1 'Dog Ear' (Sborka):'Dog Ear'",['SAU 2-C9']='SAU:(2S9)',['SAU Akatsia']='SAU:(M1973)',['SAU Gvozdika']='SAU:(M1974)',['SAU Msta']='SAU:(M1990)',['55G6 EWR']="P-14 'Tall Rack' (Nebo):'Tall Rack'",['1L13 EWR']="P-18 'Spoon Rest D' (Nebo-SV):'Spoon Rest D'",['Scud_B']="SS-1C 'Scud B' (R-17/MAZ-543):'Scud B'",['Silkworm_SR']="CSS-C-2 'Silkworm':'Silkworm'",['hy_launcher']="CSS-C-2 'Silkworm':'Silkworm'",['Grad-URAL']='BM-21:(M1964)',['Uragan_BM-27']='BM-27:(M1977)',['Smerch']='BM-30:(M1983)',['S_75M_Volhov']="SA-2D 'Guideline m.3' (S-75M) SM-90:'Guideline m.3'",['SNR_75V']="SA-2D 'Fan Song E' (SNR-75V):'Fan Song E'",['5p73 s-125 ln']="SA-3 'Goa' (S-125):'Goa'",['p-19 s-125 sr']="SA-3 'Flat Face B' (S-125/P-19):'Flat Face B'",['snr s-125 tr']="SA-3 'Low Blow' (SNR-125):'Low Blow'",['Kub 1S91 str']="SA-6 'Straight Flush' (Kub):'Straight Flush'",['Kub 2P25 ln']="SA-6 'Gainful' (Kub):'Gainful'",['Osa 9A33 ln']="SA-8 'Gecko' (Osa):'Gecko'",['Strela-1 9P31']="SA-9 'Gaskin' (Strela-1):'Gaskin'",['S-300PS 40B6M tr']="SA-10B 'Flap Lid A' (S-300PS):'Flap Lid A'",['S-300PS 40B6MD sr']="SA-10B 'Clam Shell' (S-300PS):'Clam Shell'",['S-300PS 54K6 cp']="SA-10B 'Grumble B' (S-300PS):'Grumble B'",['S-300PS 5P85C ln']="SA-10B 'Grumble B' (S-300PS):'Grumble B'",['S-300PS 5P85D ln']="SA-10B 'Grumble B' (S-300PS):'Grumble B'",['S-300PS 64H6E sr']="SA-10B 'Big Bird' (S-300PS):'Big Bird'",['SA-11 Buk CC 9S470M1']="SA-11 'Gadfly' (Buk):'Gadfly'",['SA-11 Buk LN 9A310M1']="SA-11 'Gadfly' (Buk):'Gadfly'",['SA-11 Buk SR 9S18M1']="SA-11 'Tube Arm' (Buk):'Tube Arm'",['Strela-10M3']="SA-13 'Gopher' (Strela-10M3):'Gopher'",['Tor 9A331']="SA-15 'Gauntlet' (Tor):'Gauntlet'",['Igla manpad INS']="SA-18 'Grouse' (Igla):'Grouse'",['SA-18 Igla comm']="SA-18 'Grouse' (Igla):'Grouse'",['SA-18 Igla manpad']="SA-18 'Grouse' (Igla):'Grouse'",['2S6 Tunguska']="SA-19 'Grison' (Tunguska):'Grison'",['SA-18 Igla-S comm']="SA-24 'Grinch' (Igla-S):'Grinch'",['SA-18 Igla-S manpad']="SA-24 'Grinch' (Igla-S):'Grinch' ",},WTOReporting={['Dog Ear radar']='9S80M1 Sborka:',['SAU 2-C9']='2S9:(SO.120)',['SAU Akatsia']='2S3:(SO.152)',['SAU Gvozdika']='2S1:(SAU.122)',['SAU Msta']='2S19:(SP.152)',['55G6 EWR']='55G6 Nebo:(P-14)',['1L13 EWR']='1L13 Nebo-SV:(P-18)',['Scud_B']='9K72 R-17 Elbrus:(9P117)',['Silkworm_SR']='HY-1A:',['hy_launcher']='HY-1A:',['Grad-URAL']='9K51 BM-21:',['Uragan_BM-27']='9K57 BM-27:(9P140)',['Smerch']='9K58 BM-30:',['S_75M_Volhov']='S-75M SM-90:',['SNR_75V']='S-75M SNR-75V:',['5p73 s-125 ln']='S-125 5P73:',['p-19 s-125 sr']='S-125 1RL134:(P-19)',['snr s-125 tr']='S-125 SNR-125:',['Kub 1S91 str']='2K12 Kub 1S91:',['Kub 2P25 ln']='2K12 Kub 2P25:',['Osa 9A33 ln']='9K33 Osa 9A33:',['Strela-1 9P31']='9K31 Strela-1 9P31:',['S-300PS 40B6M tr']='S-300PS 30N6:',['S-300PS 40B6MD sr']='S-300PS 5N66M:',['S-300PS 54K6 cp']='S-300PS 54K6:',['S-300PS 5P85C ln']='S-300PS 5P85C:',['S-300PS 5P85D ln']='S-300PS 5P85D:',['S-300PS 64H6E sr']='S-300PS 64H6E:',['SA-11 Buk CC 9S470M1']='9K37 Buk 9S470M1:',['SA-11 Buk LN 9A310M1']='9K37 Buk 9A310M1:',['SA-11 Buk SR 9S18M1']='9K37 Buk 9S18M1:',['Strela-10M3']='9K35M Strela-10M3 9A35M3:',['Tor 9A331']='9K330 Tor 9A331:',['Igla manpad INS']='9K38 Igla:',['SA-18 Igla comm']='9K38 Igla:',['SA-18 Igla manpad']='9K38 Igla:',['2S6 Tunguska']='2S6 Tunguska:',['SA-18 Igla-S comm']='9K338 Igla-S:',['SA-18 Igla-S manpad']='9K338 Igla-S:',},ReportNaming={['Dog Ear radar']='%R',['Land_Rover_101_FC']='Land Rover 101 FC',['Predator TrojanSpirit']='Predator TS',['SKP-11']='SKP-11 ATC MCP',['ZIL-131 KUNG']='ZiL-131 KUNG',['Challenger2']='Challenger II',['Leclerc']='AMX-56 Leclerc',['Leopard1A3']='Leopard 1A3',['Leopard-2']='Leopard 2A5',['M-1 Abrams']='M1A2 Abrams',['M-60']='M60A3 Patton',['Merkava_Mk4']='Merkava Mk.IV',['ZTZ96B']='ZTZ-96B',['M-2 Bradley']='M2A2 Bradley',['Marder']='Marder 1A3',['ZBD04A']='ZBD-04A',['M1045 HMMWV TOW']='M1045 HMMWV TOW',['M1128 Stryker MGS']='M1128 Stryker MGS',['M1134 Stryker ATGM']='M1134 Stryker ATGM',['SAU 2-C9']='%R Nona-S',['SAU Akatsia']='%R Akatsia',['SAU Gvozdika']='%R Gvozdika',['SAU Msta']='%R Msta-S',['M-109']='M109 Paladin',['SpGH_Dana']='SpGH Dana',['Boman']='MT-LBu Boman',['AAV7']='AAV-7',['BTR_D']='BTR-D',['Cobra']='Cobra BMT-2',['M1043 HMMWV Armament']='M1043 HMMWV Mg',['M1126 Stryker ICV']='M1126 Stryker ICV',['MTLB']='MT-LB',['TPZ']='TPz Fuchs',['55G6 EWR']='%R EWR',['1L13 EWR']='%R EWR',['Roland Radar']='Roland EWR',['Scud_B']='%R LN',['Silkworm_SR']='%R SR',['hy_launcher']='%R LN',['Grad-URAL']='%R Grad',['Uragan_BM-27']='%R Uragan',['Smerch']='%R Smerch',['MLRS']='M270 MLRS LN',['MLRS FDDM']='M270 MLRS FDDM',['Hawk cwar']='Hawk AN/MPQ-55 CWAR',['Hawk ln']='Hawk M192 LN',['Hawk pcp']='Hawk PCP',['Hawk sr']='Hawk AN/MPQ-50 SR',['Hawk tr']='Hawk AN/MPQ-46 TR',['HQ-7_LN_SP']='HQ-7 SP LN',['HQ-7_STR_SP']='HQ-7 SP STR',['Patriot AMG']='Patriot AN/MRC-137 AMG',['Patriot cp']='Patriot ICC',['Patriot ECS']='Patriot AN/MSQ-104 ECS',['Patriot EPP']='Patriot EPP-III',['Patriot ln']='Patriot M901 LN',['Patriot str']='Patriot AN/MPQ-53 STR',['rapier_fsa_blindfire_radar']='Rapier FSA Blindfire TR',['rapier_fsa_launcher']='Rapier FSA LN',['rapier_fsa_optical_tracker_unit']='Rapier FSA OT',['S_75M_Volhov']='%R LN',['SNR_75V']='%R TR',['5p73 s-125 ln']='%R LN',['p-19 s-125 sr']='%R SR',['snr s-125 tr']='%R TR',['Kub 1S91 str']='%R STR',['Kub 2P25 ln']='%R LN',['Osa 9A33 ln']='%R',['Strela-1 9P31']='%R',['S-300PS 40B6M tr']='%R TR',['S-300PS 40B6MD sr']='%R SR',['S-300PS 54K6 cp']='%R CP',['S-300PS 5P85C ln']='%R M/LN',['S-300PS 5P85D ln']='%R S/LN',['S-300PS 64H6E sr']='%R SR',['SA-11 Buk CC 9S470M1']='%R CC',['SA-11 Buk LN 9A310M1']='%R LN',['SA-11 Buk SR 9S18M1']='%R SR',['Strela-10M3']='%R',['Tor 9A331']='%R',['Igla manpad INS']='Insurgent %R MANPAD',['SA-18 Igla comm']='%R Comm',['SA-18 Igla manpad']='%R MANPAD',['2S6 Tunguska']='%R',['SA-18 Igla-S comm']='%R Comm',['SA-18 Igla-S manpad']='%R MANPAD',['Stinger comm']='Stinger Comm',['Stinger comm dsr']='Israeli Stinger Comm',['Soldier stinger']='Stinger MANPAD',['Gepard']='FlakPz Gepard 1A2',['Vulcan']='M163 Vulcan',['Ural-375 ZU-23']='ZU-23/Ural-375',['Ural-375 ZU-23 Insurgent']='Insurgent ZU-23/Ural-375',['ZU-23 Emplacement Closed']='ZU-23 (Closed)',['ZU-23 Closed Insurgent']='Insurgent ZU-23 (Closed)',['ZU-23 Emplacement']='ZU-23',['ZU-23 Insurgent']='Insurgent ZU-23',['TACAN_beacon']='TACAN Beacon (TTS3030)',['2B11 mortar']='2B11 Mortar',['Soldier M4 GRG']='Georgian Soldier M4',['Infantry AK Ins']='Insurgent AK',['Paratrooper AKS-74']='Paratrooper AKS-74',['Paratrooper RPG-16']='Paratrooper RPG-16',['Ural-4320 APA-5D']='APA-5D/Ural-4320',['ZiL-131 APA-80']='APA-80/ZiL-131',['HEMTT TFFT']='M1142 HEMTT TFFT',['Hummer']='M1025 HMMWV',['KAMAZ Truck']='KamAZ-43101',['KrAZ6322']='KrAZ-6322',['Land_Rover_109_S3']='Land Rover 109 S3',['M 818']='M818',['Tigr_233036']='GAZ-233036 Tigr',['Bunker']='Pillbox bunker',['Sandbox']='Hillside bunker',['house1arm']='Military barracks',['house2arm']='Watch tower',['houseA_arm']='Military house',['outpost']='Outpost',['outpost_road']='Road outpost',['warning_board_a']='Warning board',['IKARUS Bus']='IKARUS-280',['LAZ Bus']='LAZ-695',['Trolley bus']='ZIU-9',['VAZ Car']='VAZ-2109',['ZIL-4331']='ZiL-4331'},Nicknaming={['Hummer']='Humvee',['M1043 HMMWV Armament']='Humvee',['M1045 HMMWV TOW']='Humvee'}},Train={Transport={Locomotive={UnionPacificES44AH='ES44AH',RedStarCHME3T='Locomotive'},Wagon={BoxCar='Boxcartrinity',FlatCar='Coach a platform',GondolaCar='Coach cargo open',StockCar='Coach cargo',TankCarBlackLg='Tankcartrinity',TankCarBlueSh='Coach a tank blue',TankCarYellowSh='Coach a tank yellow',WellCar='Wellcarnsc'}},Civilian={Locomotive={ElectricVL80='Electric locomotive'},Wagon={PassengerCar='Coach a passenger'}},All={},ReportNaming={['ES44AH']='ES44AH locomotive',['Locomotive']='CHME3T locomotive',['Boxcartrinity']='Box car',['Coach a platform']='Flat car',['Coach cargo open']='Gondola car',['Coach cargo']='Stock car',['Tankcartrinity']='Large tank car',['Coach a tank blue']='Tank car',['Coach a tank yellow']='Tank car',['Wellcarnsc']='Well car',['Electric locomotive']='VL80 locomotive',['Coach a passenger']='Passenger car'}},Ship={Carrier={Kuznetsov_AdmiralKuznetsov='KUZNECOW',Nimitz_CVN74JohnCStennis='Stennis',Nimitz_CVN70CarlVinson='VINSON'},HeliCarrier={Tarawa_LHA1Tarawa='LHA_Tarawa'},BattleCruiser={Kirov_PyotrVelikiy='PIOTR'},Cruiser={Slava_Moskva='MOSCOW',Ticonderoga='TICONDEROG'},Destroyer={Neustrashimy_Neustrashimy='NEUSTRASH',OliverHazardPerry='PERRY',Type052B='052B',Type052C='052C'},Frigate={KrivakII_Rezky='REZKY',GrishaV='ALBATROS',Type054A='054A'},Corvette={TarantulIII='MOLNIYA'},Submarine={Kilo='KILO',Tango='SOM',},Gunboat={Speedboat='speedboat'},Transport={BulkCargo_Yakushev='Dry-cargo ship-1',DryCargo_Ivanov='Dry-cargo ship-2',Tanker_Elnya160='ELNYA'},Civilian={Yacht_Zvezdny='ZWEZDNY'},All={},NATOReporting={['KUZNECOW']='Kuznetsov:',['PIOTR']='Kirov:',['MOSCOW']='Slava:',['NEUSTRASH']='Neustrashimy:',['REZKY']='Krivak II:',['ALBATROS']='Grisha V:',['MOLNIYA']='Tarantul III:',['KILO']='Kilo:',['SOM']='Tango:'},WTOReporting={['KUZNECOW']='Orel:(1143.5)',['PIOTR']='Orlan:(1144.2)',['MOSCOW']='Atlant:(1164)',['NEUSTRASH']='Yastreb:(1154.0)',['REZKY']='Burevestnik M:(1135M)',['ALBATROS']='Albatros:(1124.4)',['MOLNIYA']='Molniya:(1241.1MP)',['KILO']='Paltus:(877)',['SOM']='Som:(641B)'},ReportNaming={['KUZNECOW']='%R-class carrier',['Stennis']='Nimitz-class (late) carrier',['VINSON']='Nimitz-class (early) carrier',['LHA_Tarawa']='Tarawa-class assault ship',['PIOTR']='%R-class battlecruiser',['MOSCOW']='%R-class cruiser',['TICONDEROG']='Ticonderoga-class cruiser',['NEUSTRASH']='%R-class destroyer',['PERRY']='Oliver Hazard Perry-class destroyer',['052B']='Type 052B destroyer',['052C']='Type 052C destroyer',['REZKY']='%R-class frigate',['ALBATROS']='%R-class frigate',['054A']='Type 054A frigate',['MOLNIYA']='%R-class corvette',['KILO']='%R-class submarine',['SOM']='%R-class submarine',['speedboat']='Speedboat',['Dry-cargo ship-1']='Bulk carrier ship',['Dry-cargo ship-2']='Container ship',['ELNYA']='Tanker ship',['ZWEZDNY']='Civilian yacht'}},Static={Airbase={AirshowCrowd='Fortifications:Crowd1:Airshow_Crowd',AirshowCone='Fortifications:Comp_cone:Airshow_Cone',DugInFuelTank='Fortifications:toplivo-bak:Fuel tank',HangarA='Fortifications:angar_a:Hangar A',HangarB='Fortifications:angar_b:Hangar B',HangarShelter='Fortifications:ukrytie:Shelter',StorageShelter='Fortifications:ukrytie_b:Shelter B',RepairWorkshop='Fortifications:tech:Repair workshop',Windsock='Fortifications:H-Windsock_RW:Windsock'},Barrier={RoadBarrier='Cargos:f_bar_cargo:f_bar_cargo',Tetrapod='Cargos:tetrapod_cargo:tetrapod_cargo',LogBarrierLg='Cargos:trunks_long_cargo:trunks_long_cargo',LogBarrierSh='Cargos:trunks_small_cargo:trunks_small_cargo'},Cargo={AmmoBox='Cargos:ammo_box_cargo:ammo_cargo',Barrels='Cargos:barrels_cargo:barrels_cargo',Container='Cargos:bw_container_cargo:container_cargo',FuelTank='Cargos:fueltank_cargo:fueltank_cargo',ISOContainerLg='Cargos:iso_container_cargo:iso_container',ISOContainerSm='Cargos:iso_container_small_cargo:iso_container_small',M117Bombs='Cargos:m117_cargo:m117_cargo',OilTank='Cargos:oiltank_cargo:oiltank_cargo',UH1HCargo='Cargos:ab-212_cargo:uh1h_cargo'},Effect={BigSmoke='Effects::big_smoke',BigSmokePresets={SmallSmokeAndFire=1,MediumSmokeAndFire=2,LargeSmokeAndFire=3,HugeSmokeAndFire=4,SmallSmoke=5,MediumSmoke=6,LargeSmoke=7,HugeSmoke=8},DustSmoke='Effects::dust_smoke',DustSmokePresets={test1=1,test2=2,test3=3},SmokingLine='Effects::smoking_line',SmokingLinePresets={test1=1,test2=2,test3=3},SmokyMarker='Effects::smoky_marker',SmokyMarkerPresets={test1=1,test2=2,test3=3}},Factory={ChemicalTank='Fortifications:him_bak_a:Chemical tank A',TechCombine='Fortifications:kombinat:Tech combine',TechHangar='Fortifications:ceh_ang_a:Tech hangar A',Workshop='Fortifications:tec_a:Workshop A'},FARP={AmmoStorage='Fortifications:SetkaKP:FARP Ammo Dump Coating',CommandPost='Fortifications:kp_ug:FARP CP Blindage',FuelDepot='Fortifications:GSM Rus:FARP Fuel Depot',Tent='Fortifications:PalatkaB:FARP Tent',HeliportLg='Heliports:FARPS:FARP',HeliportSg='Heliports:FARP:SINGLE_HELIPAD',HeliportCallsigns={London=1,Dallas=2,Paris=3,Moscow=4,Berlin=5,Rome=6,Madrid=7,Warsaw=8,Dublin=9,Perth=10}},Fort={Barracks1='Fortifications::house1arm',Barracks2='Fortifications:kazarma2:Barracks 2',HillsideBunker='Fortifications::Sandbox',PillboxBunker='Fortifications::Bunker',CommandCenter='Fortifications:ComCenter:.Command Center',Generators='Fortifications:GeneratorF:GeneratorF',House='Fortifications::houseA_arm',Landmine='Fortifications:landmine:Landmine',Latrine='Fortifications:WC:WC',Outpost='Fortifications::outpost',RoadOutpost='Fortifications::outpost_road',StaffBuilding='Fortifications:aviashtab:Military staff',WatchTower='Fortifications::house2arm'},Marker={RedFlag='Fortifications:H-flag_R:Red_Flag',WhiteFlag='Fortifications:H-Flag_W:White_Flag',BlackTire='Fortifications:H-tyre_B:Black_Tyre',WhiteTire='Fortifications:H-tyre_W:White_Tyre',BlackTireRedFlag='Fortifications:H-tyre_B_RF:Black_Tyre_RF',BlackTireWhiteFlag='Fortifications:H-tyre_B_WF:Black_Tyre_WF'},OilField={OilDerrick='Fortifications:neftevyshka:Oil derrick',OilPlatform='Fortifications:plavbaza:Oil platform',OilPumpStation='Fortifications:nasos:Pump station',OilPipesLg='Cargos:pipes_big_cargo:pipes_big_cargo',OilPipesSm='Cargos:pipes_small_cargo:pipes_small_cargo'},Railway={RailwayCrossingA='Fortifications:pereezd_big:Railway crossing A',RailwayCrossingB='Fortifications:pereezd_small:Railway crossing B',RailwayStation='Fortifications:r_vok_sd:Railway station'},SeaShelf={GasPlatform='Heliports:gas_platform:Gas platform',OilRigPlatform='Heliports:oil_platform:Oil rig'},Tower={CommsTower='Fortifications:tele_bash_m:Comms tower M',TVTower='Fortifications:tele_bash:TV tower'},Warehouse={AmmunitionDepot='Warehouses:SkladC:.Ammunition depot',Tank1='Warehouses:bak:Tank',Tank2='Warehouses:airbase_tbilisi_tank_01:Tank 2',Tank3='Warehouses:airbase_tbilisi_tank_02:Tank 3',Warehouse='Warehouses:sklad:Warehouse'},Civilian={BoilerHouse='Fortifications:kotelnaya_a:Boiler-house A',Cafe='Fortifications:stolovaya:Cafe',ContainerBrown='Fortifications:konteiner_brown:Container brown',ContainerRed1='Fortifications:konteiner_red1:Container red 1',ContainerRed2='Fortifications:konteiner_red2:Container red 2',ContainerRed3='Fortifications:konteiner_red3:Container red 3',ContainerWhite='Fortifications:konteiner_white:Container white',ElectricPowerBox='Fortifications:tr_budka:Electric power box',FarmA='Fortifications:ferma_a:Farm A',FarmB='Fortifications:ferma_b:Farm B',GarageA='Fortifications:garage_a:Garage A',GarageB='Fortifications:garage_b:Garage B',GarageSmA='Fortifications:garagh-small-a:Garage small A',GarageSmB='Fortifications:garagh-small-b:Garage small B',Restaurant='Fortifications:restoran1:Restaurant 1',Shop='Fortifications:magazin:Shop',HouseSmA='Fortifications:domik1a:Small house 1A',HouseSmAEnclosed='Fortifications:domik1a-all:Small house 1A area',HouseSmB='Fortifications:domik1b:Small house 1B',HouseSmBEnclosed='Fortifications:domik1b-all:Small house 1B area',HouseSmC='Fortifications:dom2c:Small house 2C',HouseSmCEnclosed='Fortifications:dom2c-all:Small house 1C area',WarehouseSm1='Fortifications:s1:Small werehouse 1',WarehouseSm2='Fortifications:s2:Small werehouse 2',WarehouseSm3='Fortifications:s3:Small werehouse 3',WarehouseSm4='Fortifications:s4:Small werehouse 4',SubsidiarySt1='Fortifications:hozdomik1:Subsidiary structure 1',SubsidiarySt2='Fortifications:hozdomik2:Subsidiary structure 2',SubsidiarySt3='Fortifications:hozdomik3:Subsidiary structure 3',SubsidiaryStA='Fortifications:saray-a:Subsidiary structure A',SubsidiaryStB='Fortifications:saray-b:Subsidiary structure B',SubsidiaryStC='Fortifications:saray-c:Subsidiary structure C',SubsidiaryStD='Fortifications:saray-d:Subsidiary structure D',SubsidiaryStE='Fortifications:saray-e:Subsidiary structure E',SubsidiaryStF='Fortifications:saray-f:Subsidiary structure F',SubsidiaryStG='Fortifications:saray-g:Subsidiary structure G',Supermarket='Fortifications:uniwersam_a:Supermarket A',WaterTower='Fortifications:wodokachka_a:Water tower A'},All={},Plane={},Helicopter={},Ground={},Ship={},Train={},ReportNaming={}},All={}}function fdmm.unitTypes.processEntries()local r={'All','PlayerControllable','CarrierBorne','HeavyWheeled','NATOReporting','WTOReporting','ReportNaming','ProperNaming','Nicknaming'}local a={'_'}local t={'Presets','Callsigns','Liveries'}local l={['house1arm']='Fortifications',['houseA_arm']='Fortifications',['Sandbox']='Fortifications',['Bunker']='Fortifications',['outpost']='Fortifications',['outpost_road']='Fortifications',['house2arm']='Fortifications',['TACAN_beacon']='Fortifications'}local function o(s)local function o(n,e)for n,i in pairs(n)do
if not(string.hasAnyPrefix(n,a)or
table.contains(r,n)or
string.hasAnySuffix(n,t))then
if type(i)=='table'then
o(i,e)elseif type(i)=='string'then
local n=n
local o,t,r=fdmm.utils.splitTriplet(i)r=r or i
if not e[n]then
e[n]=i
if string.isNotEmpty(r)then
if not e._rev then e._rev={}end
if not e._rev[r]then
e._rev[r]=n
elseif e._rev[r]~=n then
env.error("Group all list reverse discrepancy for unitType='"..r.."', groupAllList._rev[unitType]='"..e._rev[r].."' ~= fdmmUnitType='"..n.."'.")end
end
if string.isNotEmpty(t)then
if not e._revShape then e._revShape={}end
if not e._revShape[t]then
e._revShape[t]=n
elseif e._revShape[t]~=n then
env.error("Group all list shape reverse discrepancy for shapeName='"..t.."', groupAllList._revShape[shapeName]='"..e._revShape[t].."' ~= fdmmUnitType='"..n.."'.")end
end
elseif e[n]~=i then
env.error("Group all list discrepancy for fdmmUnitType='"..n.."', groupAllList[fdmmUnitType]='"..e[n].."' ~= value='"..i.."'.")end
end
end
end
end
o(s,s.All)end
local function t(e,i,r)for n,e in pairs(e)do
if not string.hasAnyPrefix(n,a)then
i[n]=(l[e]or r)..'::'..e
end
end
end
local function l(e,i)for e,r in pairs(e)do
if not string.hasAnyPrefix(e,a)then
local t,t,n=fdmm.utils.splitTriplet(r)n=n or r
if not i[e]then
i[e]=n
elseif i[e]~=n then
env.error("Master all list discrepancy for fdmmUnitType='"..e.."', masterAllList[fdmmUnitType]='"..i[e].."' ~= unitType='"..n.."'.")end
end
end
end
local function n(e)if not e.NATOReporting then e.NATOReporting={}end
if not e.WTOReporting then e.WTOReporting={}end
if not e.ReportNaming then e.ReportNaming={}end
if not e.ProperNaming then e.ProperNaming={}end
if not e.Nicknaming then e.Nicknaming={}end
end
local function s(r,i)local function n(e,i)for e,n in pairs(e)do
if not string.hasAnyPrefix(e,a)then
if not i[e]then
i[e]=n
elseif i[e]~=n then
env.error("Static report naming discrepancy for unitType='"..e.."', staticReportNaming[unitType]='"..i[e].."' ~= reportNaming='"..n.."'.")end
end
end
end
n(r.NATOReporting,i.NATOReporting)n(r.WTOReporting,i.WTOReporting)n(r.ReportNaming,i.ReportNaming)n(r.ProperNaming,i.ProperNaming)n(r.Nicknaming,i.Nicknaming)end
local function e(n,t)for r,i in pairs(n.All)do
if not string.hasAnyPrefix(r,a)then
local o,o,e=fdmm.utils.splitTriplet(i)e=e or i
if not n.ReportNaming[e]then
if not t then
n.ReportNaming[e]=e
else
n.ReportNaming[e]=r
end
end
end
end
end
o(fdmm.consts.UnitType.Plane)o(fdmm.consts.UnitType.Helicopter)o(fdmm.consts.UnitType.Ground)o(fdmm.consts.UnitType.Ship)o(fdmm.consts.UnitType.Train)t(fdmm.consts.UnitType.Plane.All,fdmm.consts.UnitType.Static.Plane,'Planes')t(fdmm.consts.UnitType.Helicopter.All,fdmm.consts.UnitType.Static.Helicopter,'Helicopters')t(fdmm.consts.UnitType.Ground.All,fdmm.consts.UnitType.Static.Ground,'Unarmed')t(fdmm.consts.UnitType.Train.All,fdmm.consts.UnitType.Static.Train,'Unarmed')t(fdmm.consts.UnitType.Ship.All,fdmm.consts.UnitType.Static.Ship,'Ships')o(fdmm.consts.UnitType.Static)table.concatWith(fdmm.consts.UnitType.All,fdmm.consts.UnitType.Plane.All)table.concatWith(fdmm.consts.UnitType.All,fdmm.consts.UnitType.Helicopter.All)table.concatWith(fdmm.consts.UnitType.All,fdmm.consts.UnitType.Ground.All)table.concatWith(fdmm.consts.UnitType.All,fdmm.consts.UnitType.Train.All)table.concatWith(fdmm.consts.UnitType.All,fdmm.consts.UnitType.Ship.All)l(fdmm.consts.UnitType.Static.All,fdmm.consts.UnitType.All)fdmm.consts.UnitType.All._rev={}table.concatWith(fdmm.consts.UnitType.All._rev,fdmm.consts.UnitType.Plane.All._rev)table.concatWith(fdmm.consts.UnitType.All._rev,fdmm.consts.UnitType.Helicopter.All._rev)table.concatWith(fdmm.consts.UnitType.All._rev,fdmm.consts.UnitType.Ground.All._rev)table.concatWith(fdmm.consts.UnitType.All._rev,fdmm.consts.UnitType.Train.All._rev)table.concatWith(fdmm.consts.UnitType.All._rev,fdmm.consts.UnitType.Ship.All._rev)table.concatWith(fdmm.consts.UnitType.All._rev,fdmm.consts.UnitType.Static.All._rev)fdmm.consts.UnitType.Plane.CarrierBorne._rev=fdmm.utils.reversedDict(fdmm.consts.UnitType.Plane.CarrierBorne)fdmm.consts.UnitType.Plane.PlayerControllable._rev=fdmm.utils.reversedDict(fdmm.consts.UnitType.Plane.PlayerControllable)fdmm.consts.UnitType.Helicopter.CarrierBorne._rev=fdmm.utils.reversedDict(fdmm.consts.UnitType.Helicopter.CarrierBorne)fdmm.consts.UnitType.Helicopter.PlayerControllable._rev=fdmm.utils.reversedDict(fdmm.consts.UnitType.Helicopter.PlayerControllable)fdmm.consts.UnitType.Ground.Amphibious._rev=fdmm.utils.reversedDict(fdmm.consts.UnitType.Ground.Amphibious)fdmm.consts.UnitType.Ground.HeavyWheeled._rev=fdmm.utils.reversedDict(fdmm.consts.UnitType.Ground.HeavyWheeled)n(fdmm.consts.UnitType.Plane)n(fdmm.consts.UnitType.Helicopter)n(fdmm.consts.UnitType.Ground)n(fdmm.consts.UnitType.Ship)n(fdmm.consts.UnitType.Train)n(fdmm.consts.UnitType.Static)e(fdmm.consts.UnitType.Plane,false)e(fdmm.consts.UnitType.Helicopter,false)e(fdmm.consts.UnitType.Ground,false)e(fdmm.consts.UnitType.Ship,false)e(fdmm.consts.UnitType.Train,false)s(fdmm.consts.UnitType.Plane,fdmm.consts.UnitType.Static)s(fdmm.consts.UnitType.Helicopter,fdmm.consts.UnitType.Static)s(fdmm.consts.UnitType.Ground,fdmm.consts.UnitType.Static)s(fdmm.consts.UnitType.Ship,fdmm.consts.UnitType.Static)s(fdmm.consts.UnitType.Train,fdmm.consts.UnitType.Static)e(fdmm.consts.UnitType.Static,true)end
function fdmm.unitTypes.crossRefEntries()end
function fdmm.unitTypes.anyAvailableToFaction(e,e)end
function fdmm.unitTypes.isAvailabeToFaction(e,e)end
function fdmm.unitTypes.anyListedUnder(e,e)end
function fdmm.unitTypes.isListedUnder(e,e)end
function fdmm.unitTypes.sortedListByCombatRating(e)end
function fdmm.unitTypes.getUnitTypeGroup(e)if fdmm.consts.UnitType.Plane.All._rev[e]then
return fdmm.consts.UnitType.Plane
elseif fdmm.consts.UnitType.Helicopter.All._rev[e]then
return fdmm.consts.UnitType.Helicopter
elseif fdmm.consts.UnitType.Ground.All._rev[e]then
return fdmm.consts.UnitType.Ground
elseif fdmm.consts.UnitType.Train.All._rev[e]then
return fdmm.consts.UnitType.Train
elseif fdmm.consts.UnitType.Ship.All._rev[e]then
return fdmm.consts.UnitType.Ship
elseif fdmm.consts.UnitType.Static.All._rev[e]then
return fdmm.consts.UnitType.Static
end
return nil
end
function fdmm.unitTypes.getNATOUnitReportName(e,n)local i=n or fdmm.unitTypes.getUnitTypeGroup(e)local n=nil
if i.NATOReporting then
n=i.NATOReporting[e]end
local e=i.ReportNaming[e]or n
local i,r=fdmm.utils.splitDoublet(n)i=i or n
if string.isNotEmpty(e)and string.isNotEmpty(i)and string.contains(e,'%R')then
e=e:gsub('%%R',i)end
if string.isNotEmpty(r)and not string.contains(e,r)then
e=e..' '..r
end
return e
end
function fdmm.unitTypes.getWTOUnitReportName(e,n)local i=n or fdmm.unitTypes.getUnitTypeGroup(e)local n=nil
if i.WTOReporting then
n=i.WTOReporting[e]end
local e=i.ReportNaming[e]or n
local r,i=fdmm.utils.splitDoublet(n)r=r or n
if string.isNotEmpty(e)and string.contains(e,'%R')then
e=e:gsub('%%R',r)end
if string.isNotEmpty(i)and not string.contains(e,i)then
e=e..' '..i
end
return e
end
function fdmm.unitTypes.dumpUnitReportNames()local function t(n)for e,i in pairs(table.sortedKeysList(n.All))do
if not string.hasPrefix(i,'_')then
local r=n.All[i]local t,t,e=fdmm.utils.splitTriplet(r)e=e or r
env.info("  ['"..i.."'] = '"..e.."':")env.info('    NATO: '..fdmm.unitTypes.getNATOUnitReportName(e,n))env.info('    WTO : '..fdmm.unitTypes.getWTOUnitReportName(e,n))end
end
end
t(fdmm.consts.UnitType.Static)end
end
env.info("---FDMM_UnitTypes End---");end)__DISTILLER:define("Additions/FDMM_MISTAdditions",function(e)env.info('---FDMM_MISTAdditions Start---')assert(mist,'MIST not initialized.')do
mist.DBs.Category={Vehicle='vehicle',Ship='ship',Plane='plane',Helicopter='helicopter',Building='building',Unknown='unknown'}function mist.utils.get2DDistSqrd(e,n)if e.z~=nil then e=mist.utils.makeVec2(e)end
if n.z~=nil then n=mist.utils.makeVec2(n)end
return mist.vec.magSqrd({x=e.x-n.x,y=e.y-n.y})end
function mist.utils.get3DDistSqrd(e,n)if e.z==nil then e=mist.utils.makeVec3(e)end
if n.z==nil then n=mist.utils.makeVec3(n)end
return mist.vec.magSqrd({x=e.x-n.x,y=e.y-n.y,z=e.z-n.z})end
mist.vec.magSqrd=function(e)return(e.x*e.x)+(e.y*e.y)+((e.z or 0)*(e.z or 0))end
end
env.info('---FDMM_MISTAdditions End---')end)__DISTILLER:define("Additions/FDMM_MOOSEAdditions",function(e)env.info('---FDMM_MOOSEAdditions Start---')assert(routines,'MOOSE not initialized.')do
function routines.utils.get2DDistSqrd(e,n)if e.z~=nil then e=routines.utils.makeVec2(e)end
if n.z~=nil then n=routines.utils.makeVec2(n)end
return routines.vec.magSqrd({x=e.x-n.x,y=e.y-n.y})end
function routines.utils.get3DDistSqrd(e,n)if e.z==nil then e=routines.utils.makeVec3(e)end
if n.z==nil then n=routines.utils.makeVec3(n)end
return routines.vec.magSqrd({x=e.x-n.x,y=e.y-n.y,z=e.z-n.z})end
routines.vec.magSqrd=function(e)return(e.x*e.x)+(e.y*e.y)+((e.z or 0)*(e.z or 0))end
function ZONE_POLYGON:NewFromPoints(n,e)local e=BASE:Inherit(self,ZONE_POLYGON_BASE:New(n,e))e:F({n,nil,e._.Polygon})_EVENTDISPATCHER:CreateEventNewZone(e)return e
end
end
env.info('---FDMM_MOOSEAdditions End---')end)__DISTILLER:define("Cargo/FDMM_ResourceUnit",function(e)env.info('---FDMM_ResourceUnit Start---')fdmm.resourceUnit={}do
FDMMResourceUnit={}FDMMResourceUnit.__index=FDMMResourceUnit
setmetatable(FDMMResourceUnit,{__call=function(e,...)return e.new(...)end,})function FDMMResourceUnit.new(a,o,t,r,n,i)local e=setmetatable({},FDMMResourceUnit)e.fuelRP=a
e.armsRP=o
e.unitRP=t
e.maxFuelRP=r
e.maxArmsRP=n
e.maxUnitRP=i
return e
end
function FDMMResourceUnit:canTransferTo(e,e,e,e)end
function FDMMResourceUnit:transferTo(e,e,e,e,e,e)end
end
do
end
env.info('---FDMM_ResourceUnit End---')end)__DISTILLER:define("Cargo/FDMM_CargoRoute",function(e)env.info('---FDMM_CargoRoute Start---')fdmm.cargoRoute={}do
FDMMCargoRoute={}FDMMCargoRoute.__index=FDMMCargoRoute
setmetatable(FDMMCargoRoute,{__call=function(e,...)return e.new(...)end,})function FDMMCargoRoute.new(n,i)local e=setmetatable({},FDMMCargoRoute)e.territoryName=n
e.routeType=i
e.spawnLocs={}e.facilityLocs={}e.dirLinks={}return e
end
function FDMMCargoRoute:addSpawnLocation(e,n,i)table.insert(self.spawnLocs,{spawnFaction=e,spawnPoint=n,egressPoints=i or{}})end
function FDMMCargoRoute:addFacilityLocation(i,n,e)table.insert(self.facilityLocs,{facilityName=i,facilityPoint=n,ingressPoints=e or{}})end
function FDMMCargoRoute:addDirectionalLink(n,i,e)table.insert(self.dirLinks,{directionName=n,navigationPoint=i,ingressPoints=e or{}})end
function FDMMCargoRoute:getOutboundRouteFromStart(e)end
function FDMMCargoRoute:getInboundRouteToFacility(e)end
function FDMMCargoRoute:getOutboundRouteFromFacility(e)end
function FDMMCargoRoute:getClosestDirectionalLinkageToOutsidePoint(e)end
end
do
function fdmm.cargoRoute.createCargoRoutes()fdmm.cargoRoutes={}for e,n in pairs(fdmm.territories.all)do
fdmm.cargoRoutes[e]={[fdmm.enums.CargoRouteType.Land]=FDMMCargoRoute.new(e,fdmm.enums.CargoRouteType.Land),[fdmm.enums.CargoRouteType.Train]=FDMMCargoRoute.new(e,fdmm.enums.CargoRouteType.Train),[fdmm.enums.CargoRouteType.Air]=FDMMCargoRoute.new(e,fdmm.enums.CargoRouteType.Air),[fdmm.enums.CargoRouteType.Sea]=FDMMCargoRoute.new(e,fdmm.enums.CargoRouteType.Sea)}end
local d={[fdmm.consts.CargoRouteGNPrefix.Land]=fdmm.config.gpCache[fdmm.consts.CargoRouteGNPrefix.Land]or{},[fdmm.consts.CargoRouteGNPrefix.Train]=fdmm.config.gpCache[fdmm.consts.CargoRouteGNPrefix.Train]or{},[fdmm.consts.CargoRouteGNPrefix.Air]=fdmm.config.gpCache[fdmm.consts.CargoRouteGNPrefix.Air]or{},[fdmm.consts.CargoRouteGNPrefix.Sea]=fdmm.config.gpCache[fdmm.consts.CargoRouteGNPrefix.Sea]or{}}function _processGroup(o,e,a)local n=fdmm.utils.removeNumericSuffix(fdmm.utils.removeGroupingPrefix(o))local i=fdmm.territories.all[n]if i~=nil then
local m=fdmm.cargoRoutes[n][a]local u=mist.getGroupRoute(o,false)local d=fdmm.utils.getFaction(string.notEmptyElse(e.units[1].unitName,e.country))local l=a:upperFirst()local c=table.concatedWith(fdmm.consts.CargoRouteGNPrefix,fdmm.consts.CargoRouteWPRoutePrefix[l])local e=nil
local n={Spawn='spawn',Linkage='linkage',Facility='facility',TBD='_'}local i,t,s=nil,nil,{}function _updateScanner(r,l)if e==n.TBD and r~=nil and r~=n.TBD then
e=r
elseif e~=nil and e~=n.TBD and r==n.TBD then
r=e
end
if e~=r or i~=l then
if e then
if e==n.Spawn then
if string.isNotEmpty(d)and t and s then
m:addSpawnLocation(d,t,s)else
env.error('Cargo '..a.." routing group '"..o.."' failed to parse spawn route '"..(i or'<nil>').."'.")end
elseif e==n.Linkage then
if string.isNotEmpty(i)and t and s then
m:addDirectionalLink(i,t,s)else
env.error('Cargo '..a.." routing group '"..o.."' failed to parse linkage route '"..(i or'<nil>').."'.")end
elseif e==n.Facility then
if string.isNotEmpty(i)and t and s then
m:addFacilityLocation(i,t,s)else
env.error('Cargo '..a.." routing group '"..o.."' failed to parse facility route '"..(i or'<nil>').."'.")end
elseif e~=n.TBD then
env.error('Cargo '..a.." routing group '"..o.."' encountered unrecognized scan mode '"..(r or'<nil>').."'.")end
i,t,s=nil,nil,{}end
e=r
i=l
end
end
for m,e in ipairs(u)do
if string.isNotEmpty(e.name)and(e.name..'_')~=fdmm.consts.CargoRouteGNPrefix[l]then
local d,r,i=fdmm.utils.getGroupingComponentsWithSNC(e.name,c,fdmm.consts.CargoRouteWPRouteSuffix)if d==fdmm.consts.CargoRouteGNPrefix[l]then
if i==fdmm.consts.CargoRouteWPRouteSuffix.Egress or
i==fdmm.consts.CargoRouteWPRouteSuffix.Ingress then
_updateScanner(n.TBD,r)table.insert(s,fdmm.utils.rposFromRPoint(e))elseif i==fdmm.consts.CargoRouteWPRouteSuffix.Spawn then
_updateScanner(n.Spawn,r)t=fdmm.utils.rposFromRPoint(e)elseif i==fdmm.consts.CargoRouteWPRouteSuffix.Linkage then
_updateScanner(n.Linkage,r)t=fdmm.utils.rposFromRPoint(e)elseif i==fdmm.consts.CargoRouteWPRouteSuffix.Facility then
_updateScanner(n.Facility,r)t=fdmm.utils.rposFromRPoint(e)elseif not(string.isEmpty(r)and string.isEmpty(i))then
env.error('Cargo '..a.." routing group '"..o.."' unknown WP '"..(e.name or'<nil>').."' at WP index "..m..'.')end
elseif d==fdmm.consts.CargoRouteWPRoutePrefix[l].Spawn then
if string.isEmpty(i)then
_updateScanner(n.Spawn,r)t=fdmm.utils.rposFromRPoint(e)elseif i==fdmm.consts.CargoRouteWPRouteSuffix.Egress then
_updateScanner(n.Spawn,r)table.insert(s,fdmm.utils.rposFromRPoint(e))elseif not(string.isEmpty(r)and string.isEmpty(i))then
env.error('Cargo '..a.." routing group '"..o.."' unknown spawn WP '"..(e.name or'<nil>').."' at WP index "..m..'.')end
elseif d==fdmm.consts.CargoRouteWPRoutePrefix[l].Linkage then
if string.isEmpty(i)then
_updateScanner(n.Linkage,r)t=fdmm.utils.rposFromRPoint(e)elseif i==fdmm.consts.CargoRouteWPRouteSuffix.Ingress then
_updateScanner(n.Linkage,r)table.insert(s,fdmm.utils.rposFromRPoint(e))elseif not(string.isEmpty(r)and string.isEmpty(i))then
env.error('Cargo '..a.." routing group '"..o.."' unknown linkage WP '"..(e.name or'<nil>').."' at WP index "..m..'.')end
elseif d==fdmm.consts.CargoRouteWPRoutePrefix[l].Facility then
if string.isEmpty(i)then
_updateScanner(n.Facility,r)t=fdmm.utils.rposFromRPoint(e)elseif i==fdmm.consts.CargoRouteWPRouteSuffix.Ingress then
_updateScanner(n.Facility,r)table.insert(s,fdmm.utils.rposFromRPoint(e))elseif not(string.isEmpty(r)and string.isEmpty(i))then
env.error('Cargo '..a.." routing group '"..o.."' unknown facility WP '"..(e.name or'<nil>').."' at WP index "..m..'.')end
else
env.error('Cargo '..a.." routing group '"..o.."' unknown routing WP '"..(e.name or'<nil>').."' at WP index "..m..'.')end
end
end
_updateScanner(nil,nil)else
env.error('Cargo '..a.." routing group '"..o.."' failed to find territory with same name.")end
end
for n,e in pairs(d[fdmm.consts.CargoRouteGNPrefix.Land])do
_processGroup(n,e,fdmm.enums.CargoRouteType.Land)end
for e,n in pairs(d[fdmm.consts.CargoRouteGNPrefix.Train])do
_processGroup(e,n,fdmm.enums.CargoRouteType.Train)end
for e,n in pairs(d[fdmm.consts.CargoRouteGNPrefix.Air])do
_processGroup(e,n,fdmm.enums.CargoRouteType.Air)end
for e,n in pairs(d[fdmm.consts.CargoRouteGNPrefix.Sea])do
_processGroup(e,n,fdmm.enums.CargoRouteType.Sea)end
end
end
env.info('---FDMM_CargoRoute End---')end)__DISTILLER:define("Territory/FDMM_Territory",function(e)env.info('---FDMM_Territory Start---')fdmm.territory={}do
FDMMTerritory={}FDMMTerritory.__index=FDMMTerritory
setmetatable(FDMMTerritory,{__call=function(e,...)return e.newFromGroup(...)end,})function FDMMTerritory.newFromGroup(n,i)local e=setmetatable({},FDMMTerritory)e.name=fdmm.utils.removeGroupingPrefix(n)if i.category==mist.DBs.Category.Ship then
e.type=fdmm.enums.TerritoryType.Sea
else
e.type=fdmm.enums.TerritoryType.Land
end
e.polygonPoints={}local r=mist.getGroupPoints(n)for i,n in ipairs(r)do
if i>1 and i<#r then
table.insert(e.polygonPoints,n)elseif i==1 then
e.centerPoint=n
else
e.capturePoint=n
end
end
local n=mist.utils.get2DDist(e.polygonPoints[1],e.polygonPoints[#e.polygonPoints])if n<=25*25 then
table.remove(e.polygonPoints,#e.polygonPoints)end
e.polygonZone=ZONE_POLYGON:NewFromPoints(e.name,e.polygonPoints)e.linkedTerritories={}e.linkedTerritoryDistances={}e.facilities={}return e
end
function FDMMTerritory:addTerritoryLink(e)if self.name~=e.name then
self.linkedTerritories[e.name]=e
e.linkedTerritories[self.name]=self
local n=mist.utils.get2DDist(self.centerPoint,e.centerPoint)self.linkedTerritoryDistances[e.name]=n
e.linkedTerritoryDistances[self.name]=n
else
env.error("Cannot link territory '"..self.name.."' with itself.")end
end
function FDMMTerritory:addFacility(e)self.facilities[e.name]=e
end
function FDMMTerritory:buildFacilities()for n,e in pairs(self.facilities)do
e:buildFacility()end
end
function FDMMTerritory:smokeBoundaries(t)t=t or SMOKECOLOR.Blue
local a=10000./25.
local r=nil
for e,o in ipairs(self.polygonPoints)do
if e>1 then
local e=mist.utils.makeVec3(o)local e=mist.vec.sub(e,r)local i=mist.vec.mag(e)local o=mist.vec.scalarMult(e,1./i)local e=1
local n=i/e
while n>a do
e=e+1
n=i/e
end
while e>=0 do
local n=mist.vec.scalarMult(o,e*n)local n=mist.vec.add(r,n);COORDINATE:NewFromVec2(mist.utils.makeVec2(n)):Smoke(t)e=e-1
end
end
r=mist.utils.makeVec3(o)end
end
end
do
function fdmm.territory.createTerritories()fdmm.territories={[fdmm.enums.TerritoryType.Land]={},[fdmm.enums.TerritoryType.Sea]={},[fdmm.enums.TerritoryType.All]={}}local n={[fdmm.consts.TerritoryGNPrefix.Define]=fdmm.config.gpCache[fdmm.consts.TerritoryGNPrefix.Define]or{},[fdmm.consts.TerritoryGNPrefix.Linkage]=fdmm.config.gpCache[fdmm.consts.TerritoryGNPrefix.Linkage]or{}}for e,n in pairs(n[fdmm.consts.TerritoryGNPrefix.Define])do
local e=FDMMTerritory.newFromGroup(e,n)fdmm.territories[e.type][e.name]=e
fdmm.territories.all[e.name]=e
end
for e,n in pairs(n[fdmm.consts.TerritoryGNPrefix.Linkage])do
local r=fdmm.utils.removeGroupingPrefix(e)local n=fdmm.territories.all[r]if n~=nil then
for r,i in ipairs(mist.getGroupRoute(e,false))do
if string.isEmpty(i.name)then
local i=fdmm.territory.closestTerritoryToPoint(fdmm.utils.rposFromRPoint(i),n.type)if i~=nil then
n:addTerritoryLink(i)else
env.error("Territory linkage group '"..e.."' failed to find a closest territory at WP index "..r..'.')end
end
end
else
env.error("Territory linkage group '"..e.."' failed to find territory named '"..r.."'.")end
end
end
function fdmm.territory.createFacilities()fdmm.facilities={[fdmm.enums.FacilityType.Airbase]={},[fdmm.enums.FacilityType.ArmsPlant]={},[fdmm.enums.FacilityType.CommandCenter]={},[fdmm.enums.FacilityType.FARP]={},[fdmm.enums.FacilityType.OilField]={},[fdmm.enums.FacilityType.Port]={},[fdmm.enums.FacilityType.UnitFactory]={},[fdmm.enums.FacilityType.All]={}}local n={[fdmm.consts.TerritoryGNPrefix.Facility]=fdmm.config.gpCache[fdmm.consts.TerritoryGNPrefix.Facility]or{}}local e=table.concatedWith(fdmm.consts.TerritoryGNPrefix,fdmm.consts.TerritoryWPFacilityPrefix)for o,n in pairs(n[fdmm.consts.TerritoryGNPrefix.Facility])do
local i=fdmm.utils.removeGroupingPrefix(o)local r=fdmm.territories.all[i]if r~=nil then
for a,n in ipairs(mist.getGroupRoute(o,false))do
if string.isNotEmpty(n.name)and(n.name..'_')~=fdmm.consts.TerritoryGNPrefix.Facility then
local t,e,s=fdmm.utils.getGroupingComponentsWithSNC(n.name,e,nil)if t==fdmm.consts.TerritoryWPFacilityPrefix.Airbase and string.isNotEmpty(e)then
local e=fdmm.facilities.all[e]or FDMMAirbase.new(e,fdmm.utils.rposFromRPoint(n),i)fdmm.facilities.airbase[e.name]=e
fdmm.facilities.all[e.name]=e
r:addFacility(e)elseif t==fdmm.consts.TerritoryWPFacilityPrefix.ArmsPlant and string.isNotEmpty(e)then
local e=fdmm.facilities.all[e]or FDMMArmsPlant.new(e,fdmm.utils.rposFromRPoint(n),i)fdmm.facilities.armsPlant[e.name]=e
fdmm.facilities.all[e.name]=e
r:addFacility(e)elseif t==fdmm.consts.TerritoryWPFacilityPrefix.CommandCenter and string.isNotEmpty(e)then
local e=fdmm.facilities.all[e]or FDMMCommandCenter.new(e,fdmm.utils.rposFromRPoint(n),i)fdmm.facilities.commandCenter[e.name]=e
fdmm.facilities.all[e.name]=e
r:addFacility(e)elseif t==fdmm.consts.TerritoryWPFacilityPrefix.FARP and string.isNotEmpty(e)then
local e=fdmm.facilities.all[e]or FDMMFARP.new(e,fdmm.utils.rposFromRPoint(n),i)fdmm.facilities.farp[e.name]=e
fdmm.facilities.all[e.name]=e
r:addFacility(e)elseif t==fdmm.consts.TerritoryWPFacilityPrefix.OilField and string.isNotEmpty(e)then
local e=fdmm.facilities.all[e]or FDMMOilField.new(e,fdmm.utils.rposFromRPoint(n),i)fdmm.facilities.oilField[e.name]=e
fdmm.facilities.all[e.name]=e
r:addFacility(e)elseif t==fdmm.consts.TerritoryWPFacilityPrefix.Port and string.isNotEmpty(e)then
local e=fdmm.facilities.all[e]or FDMMPort.new(e,fdmm.utils.rposFromRPoint(n),i)fdmm.facilities.port[e.name]=e
fdmm.facilities.all[e.name]=e
r:addFacility(e)elseif t==fdmm.consts.TerritoryWPFacilityPrefix.UnitFactory and string.isNotEmpty(e)then
local e=fdmm.facilities.all[e]or FDMMUnitFactory.new(e,fdmm.utils.rposFromRPoint(n),i)fdmm.facilities.unitFactory[e.name]=e
fdmm.facilities.all[e.name]=e
r:addFacility(e)elseif not(string.isEmpty(e)and string.isEmpty(s))then
env.error("Territory group '"..o.."' unknown facility WP '"..(n.name or'<nil>').."' at WP index "..a..'.')end
end
end
else
env.error("Territory facility group '"..o.."' failed to find territory named '"..i.."'.")end
end
end
function fdmm.territory.buildFacilities()for n,e in pairs(fdmm.territories.all)do
e:buildFacilities()end
end
function fdmm.territory.closestTerritoryToPoint(e,i)local r=mist.utils.makeVec2(e)local e=nil
local n=0
local i=i or fdmm.enums.TerritoryType.All
local i=fdmm.territories[i]for t,i in pairs(i)do
local r=mist.utils.get2DDistSqrd(r,i.centerPoint)if e==nil or r<n then
e=i
n=r
end
end
return e
end
function fdmm.territory.dumpTerritories()function _envInfoTerritory(n,e)env.info("    '"..n.."':")env.info('      '..'centerPoint: '..fdmm.utils.pos2ToLoggableString(e.centerPoint))env.info('      '..'capturePoint: '..fdmm.utils.pos2ToLoggableString(e.capturePoint))for e,n in pairs(e.linkedTerritories)do
env.info('      '.."Linked /w: '"..e.."'.")end
end
env.info('--FDMM Territories Dump--')env.info('  Sea Territories:')for n,e in pairs(fdmm.territories.sea)do
_envInfoTerritory(n,e)end
env.info('  Land Territories:')for n,e in pairs(fdmm.territories.land)do
_envInfoTerritory(n,e)end
end
end
env.info('---FDMM_Territory End---')end)__DISTILLER:define("Territory/FDMM_Facility",function(e)env.info('---FDMM_Facility Start---')fdmm.facility={}do
FDMMFacility={}FDMMFacility.__index=FDMMFacility
setmetatable(FDMMFacility,{__call=function(e,...)return e.new(...)end})function FDMMFacility.new(r,n,i)local e=setmetatable({},FDMMFacility)e.name=r
e.centerPoint=n
e.territoryName=i
return e
end
function FDMMFacility:buildFacility()end
function FDMMFacility:getFacilityType()return nil
end
end
do
end
env.info('---FDMM_Facility End---')end)__DISTILLER:define("Territory/FDMM_Airbase",function(e)env.info('---FDMM_Airbase Start---')e('Territory/FDMM_Facility')fdmm.airbase={}do
FDMMAirbase={}FDMMAirbase.__index=FDMMAirbase
setmetatable(FDMMAirbase,{__index=FDMMFacility,__call=function(e,...)return e.new(...)end})function FDMMAirbase.new(i,n,e)local e=setmetatable(FDMMFacility.new(i,n,e),FDMMAirbase)return e
end
function FDMMAirbase:buildFacility()end
function FDMMAirbase:getFacilityType()return fdmm.enums.FacilityType.Airbase
end
end
do
end
env.info('---FDMM_Airbase End---')end)__DISTILLER:define("Territory/FDMM_ArmsPlant",function(e)env.info('---FDMM_ArmsPlant Start---')e('Territory/FDMM_Facility')fdmm.armsPlant={}do
FDMMArmsPlant={}FDMMArmsPlant.__index=FDMMArmsPlant
setmetatable(FDMMArmsPlant,{__index=FDMMFacility,__call=function(e,...)return e.new(...)end})function FDMMArmsPlant.new(e,n,i)local e=setmetatable(FDMMFacility.new(e,n,i),FDMMArmsPlant)return e
end
function FDMMArmsPlant:buildFacility()end
function FDMMArmsPlant:getFacilityType()return fdmm.enums.FacilityType.ArmsPlant
end
end
do
end
env.info('---FDMM_ArmsPlant End---')end)__DISTILLER:define("Territory/FDMM_CommandCenter",function(e)env.info('---FDMM_CommandCenter Start---')e('Territory/FDMM_Facility')fdmm.commandCenter={}do
FDMMCommandCenter={}FDMMCommandCenter.__index=FDMMCommandCenter
setmetatable(FDMMCommandCenter,{__index=FDMMFacility,__call=function(e,...)return e.new(...)end})function FDMMCommandCenter.new(e,n,i)local e=setmetatable(FDMMFacility.new(e,n,i),FDMMCommandCenter)return e
end
function FDMMCommandCenter:buildFacility()end
function FDMMCommandCenter:getFacilityType()return fdmm.enums.FacilityType.CommandCenter
end
end
do
end
env.info('---FDMM_CommandCenter End---')end)__DISTILLER:define("Territory/FDMM_FARP",function(e)env.info('---FDMM_FARP Start---')e('Territory/FDMM_Facility')fdmm.farp={}do
FDMMFARP={}FDMMFARP.__index=FDMMFARP
setmetatable(FDMMFARP,{__index=FDMMFacility,__call=function(e,...)return e.new(...)end})function FDMMFARP.new(e,i,n)local e=setmetatable(FDMMFacility.new(e,i,n),FDMMFARP)return e
end
function FDMMFARP:buildFacility()end
function FDMMFARP:getFacilityType()return fdmm.enums.FacilityType.FARP
end
end
do
end
env.info('---FDMM_FARP End---')end)__DISTILLER:define("Territory/FDMM_OilField",function(e)env.info('---FDMM_OilField Start---')e('Territory/FDMM_Facility')fdmm.oilField={}do
FDMMOilField={}FDMMOilField.__index=FDMMOilField
setmetatable(FDMMOilField,{__index=FDMMFacility,__call=function(e,...)return e.new(...)end})function FDMMOilField.new(i,e,n)local e=setmetatable(FDMMFacility.new(i,e,n),FDMMOilField)return e
end
function FDMMOilField:buildFacility()end
function FDMMOilField:getFacilityType()return fdmm.enums.FacilityType.OilField
end
end
do
end
env.info('---FDMM_OilField End---')end)__DISTILLER:define("Territory/FDMM_Port",function(e)env.info('---FDMM_Port Start---')e('Territory/FDMM_Facility')fdmm.port={}do
FDMMPort={}FDMMPort.__index=FDMMPort
setmetatable(FDMMPort,{__index=FDMMFacility,__call=function(e,...)return e.new(...)end})function FDMMPort.new(i,n,e)local e=setmetatable(FDMMFacility.new(i,n,e),FDMMPort)return e
end
function FDMMPort:buildFacility()end
function FDMMPort:getFacilityType()return fdmm.enums.FacilityType.Port
end
end
do
end
env.info('---FDMM_Port End---')end)__DISTILLER:define("Territory/FDMM_UnitFactory",function(e)env.info('---FDMM_UnitFactory Start---')e('Territory/FDMM_Facility')fdmm.unitFactory={}do
FDMMUnitFactory={}FDMMUnitFactory.__index=FDMMUnitFactory
setmetatable(FDMMUnitFactory,{__index=FDMMFacility,__call=function(e,...)return e.new(...)end})function FDMMUnitFactory.new(n,i,e)local e=setmetatable(FDMMFacility.new(n,i,e),FDMMUnitFactory)return e
end
function FDMMUnitFactory:buildFacility()end
function FDMMUnitFactory:getFacilityType()return fdmm.enums.FacilityType.UnitFactory
end
end
do
end
env.info('---FDMM_UnitFactory End---')end)__DISTILLER:define("FDMM_MissionStart.lua_distilled",function(e)env.info("---FDMM_MissionStart Start---")env.setErrorMessageBoxEnabled(false)fdmm={}fdmm_path=fdmm_path or"/Scripts/FDMM/"fdmm.fullPath=lfs.normpath(lfs.writedir()..fdmm_path)fdmm.MapKind={Both='Both',Setup='Setup',Runable='Runable'}fdmm.mapKind=fdmm.MapKind.Both
e('FDMM_Config')e('FDMM_Utils')e('FDMM_UnitTypes')e('Additions/FDMM_LuaAdditions')e('Additions/FDMM_MISTAdditions')e('Additions/FDMM_MOOSEAdditions')e('Cargo/FDMM_ResourceUnit')e('Cargo/FDMM_CargoRoute')e('Territory/FDMM_Territory')e('Territory/FDMM_Airbase')e('Territory/FDMM_ArmsPlant')e('Territory/FDMM_CommandCenter')e('Territory/FDMM_FARP')e('Territory/FDMM_OilField')e('Territory/FDMM_Port')e('Territory/FDMM_UnitFactory')do
trigger.action.outText("FDMM Starting...",10)fdmm.unitTypes.processEntries()if fdmm_loadDB and db then
fdmm.unitTypes.crossRefEntries()end
fdmm.config.createGPCache()fdmm.territory.createTerritories()fdmm.territory.createFacilities()fdmm.cargoRoute.createCargoRoutes()fdmm.territory.buildFacilities()fdmm.unitTypes.dumpUnitReportNames()trigger.action.outText("FDMM Started",10)end
env.info("---FDMM_MissionStart End---")end)__DISTILLER:exec("FDMM_MissionStart.lua_distilled")