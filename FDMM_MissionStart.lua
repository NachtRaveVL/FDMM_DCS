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
fdmm.build=1
fdmm.enums={}fdmm.consts={}fdmm.config={}do
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
function fdmm.config.createGPCache()fdmm.config.gpCache={}local i={'AIRB_','ARMP_','CMDC_','FARP_','OILF_','PORT_','UNTF_'}for n,t in pairs(mist.DBs.groupsByName)do
local r,e=fdmm.utils.removeGroupingPrefix(n)if e~=nil then
if not fdmm.config.gpCache[e]then
fdmm.config.gpCache[e]={}end
if table.contains(i,e)then
local i=string.find(r,'_')if i~=nil then
local i=r:sub(1,i-1)if not fdmm.config.gpCache[e][i]then
fdmm.config.gpCache[e][i]={}end
fdmm.config.gpCache[e][i][n]=t
else
if not fdmm.config.gpCache[e]['_']then
fdmm.config.gpCache[e]['_']={}end
fdmm.config.gpCache[e]['_'][n]=t
end
else
fdmm.config.gpCache[e][n]=t
end
end
end
end
end
env.info("---FDMM_Config End---");end)__DISTILLER:define("FDMM_Utils",function(e)env.info("---FDMM_Utils Start---");fdmm.utils={}do
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
function fdmm.utils.removeNumericSuffix(n)local e=fdmm.utils.getNumericSuffix(n)if e~=nil then
return n:sub(1,-#e-1),e
end
return n,nil
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
local i,n
e=fdmm.utils.removeNumericSuffix(e)e,i=fdmm.utils.removeGroupingPrefix(e)e,n=fdmm.utils.removeGroupingSuffix(e)return i,e,n
end
return nil,nil,nil
end
function fdmm.utils.getGroupingComponentsWithSNC(e,r,t)local i,e,n=fdmm.utils.getGroupingComponents(e)if string.isEmpty(i)and table.contains(r or{},(e..'_'))then
i=(e..'_')e=nil
elseif string.isEmpty(n)and table.contains(t or{},('_'..e))then
n=('_'..e)e=nil
end
return i,e,n
end
function fdmm.utils.rposFromRPoint(e)return{x=e.x or e.point.x,y=e.y or e.point.y,routePoint=mist.utils.deepCopy(e)}end
function fdmm.utils.getFaction(e)if e then
e=fdmm.utils.removeNumericSuffix(e)for i,n in pairs(fdmm.enums.Faction)do
if n:lower()==e:lower()then
return i
end
end
end
return fdmm.enums.Faction.Unused
end
function fdmm.utils.isUserFlagSet(e)local e=trigger.misc.getUserFlag(e)return(type(e)=='number'and e~=0)or(type(e)=='boolean'and e~=false)or(type(e)=='string'and e:lower()~='false'and e~='0'and e:lower()~='off'and e:lower()~='no')end
function fdmm.utils.isDebugFlagSet()return fdmm.utils.isUserFlagSet(fdmm.consts.UserFlags.DebugFlag)end
end
env.info("---FDMM_Utils End---");end)__DISTILLER:define("Additions/FDMM_LuaAdditions",function(e)env.info('---FDMM_LuaAdditions Start---')do
function string.contains(e,n)return string.find(e,n)~=nil
end
function string.hasPrefix(n,e)return string.sub(n,1,#e)==e
end
function string.hasSuffix(n,e)return sring.sub(n,-#e)==e
end
function string.isEmpty(e)return e==nil or not#e
end
function string.isNotEmpty(e)return e~=nil and#e
end
function string.notEmptyElse(e,n)if e~=nil and#e then return e end
return n
end
function string.upperFirst(e)return e:sub(1,1):upper()..e:sub(2)end
function table.contains(e,n)for i,e in pairs(e)do
if e==n then
return true
end
end
return false
end
function table.concatedWith(i,n)local e=nil
if i or n then
e={}if i then
for i,n in pairs(i)do
e[i]=n
end
end
if n then
for n,i in pairs(n)do
e[n]=i
end
end
end
return e
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
end
env.info('---FDMM_LuaAdditions End---')end)__DISTILLER:define("Additions/FDMM_MISTAdditions",function(e)env.info('---FDMM_MISTAdditions Start---')assert(mist,'MIST not initialized.')do
mist.DBs.Category={Vehicle='vehicle',Ship='ship',Plane='plane',Helicopter='helicopter',Building='building',Unknown='unknown'}function mist.utils.get2DDistSqrd(n,e)if n.z~=nil then n=mist.utils.makeVec2(n)end
if e.z~=nil then e=mist.utils.makeVec2(e)end
return mist.vec.magSqrd({x=n.x-e.x,y=n.y-e.y})end
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
setmetatable(FDMMResourceUnit,{__call=function(e,...)return e.new(...)end,})function FDMMResourceUnit.new(o,a,r,n,i,t)local e=setmetatable({},FDMMResourceUnit)e.fuelRP=o
e.armsRP=a
e.unitRP=r
e.maxFuelRP=n
e.maxArmsRP=i
e.maxUnitRP=t
return e
end
function FDMMResourceUnit:canTransferTo(e,e,e,e)end
function FDMMResourceUnit:transferTo(e,e,e,e,e,e)end
end
do
end
env.info('---FDMM_ResourceUnit End---')end)__DISTILLER:define("Cargo/FDMM_CargoRoute",function(e)env.info('---FDMM_CargoRoute Start---')fdmm.cargoRoute={}do
FDMMCargoRoute={}FDMMCargoRoute.__index=FDMMCargoRoute
setmetatable(FDMMCargoRoute,{__call=function(e,...)return e.new(...)end,})function FDMMCargoRoute.new(i,n)local e=setmetatable({},FDMMCargoRoute)e.territoryName=i
e.routeType=n
e.spawnLocs={}e.facilityLocs={}e.dirLinks={}return e
end
function FDMMCargoRoute:addSpawnLocation(n,i,e)table.insert(self.spawnLocs,{spawnFaction=n,spawnPoint=i,egressPoints=e or{}})end
function FDMMCargoRoute:addFacilityLocation(e,n,i)table.insert(self.facilityLocs,{facilityName=e,facilityPoint=n,ingressPoints=i or{}})end
function FDMMCargoRoute:addDirectionalLink(e,i,n)table.insert(self.dirLinks,{directionName=e,navigationPoint=i,ingressPoints=n or{}})end
function FDMMCargoRoute:getOutboundRouteFromStart(e)end
function FDMMCargoRoute:getInboundRouteToFacility(e)end
function FDMMCargoRoute:getOutboundRouteFromFacility(e)end
function FDMMCargoRoute:getClosestDirectionalLinkageToOutsidePoint(e)end
end
do
function fdmm.cargoRoute.createCargoRoutes()fdmm.cargoRoutes={}for e,n in pairs(fdmm.territories.all)do
fdmm.cargoRoutes[e]={[fdmm.enums.CargoRouteType.Land]=FDMMCargoRoute.new(e,fdmm.enums.CargoRouteType.Land),[fdmm.enums.CargoRouteType.Train]=FDMMCargoRoute.new(e,fdmm.enums.CargoRouteType.Train),[fdmm.enums.CargoRouteType.Air]=FDMMCargoRoute.new(e,fdmm.enums.CargoRouteType.Air),[fdmm.enums.CargoRouteType.Sea]=FDMMCargoRoute.new(e,fdmm.enums.CargoRouteType.Sea)}end
local f={[fdmm.consts.CargoRouteGNPrefix.Land]=fdmm.config.gpCache[fdmm.consts.CargoRouteGNPrefix.Land]or{},[fdmm.consts.CargoRouteGNPrefix.Train]=fdmm.config.gpCache[fdmm.consts.CargoRouteGNPrefix.Train]or{},[fdmm.consts.CargoRouteGNPrefix.Air]=fdmm.config.gpCache[fdmm.consts.CargoRouteGNPrefix.Air]or{},[fdmm.consts.CargoRouteGNPrefix.Sea]=fdmm.config.gpCache[fdmm.consts.CargoRouteGNPrefix.Sea]or{}}function _processGroup(o,n,a)local e=fdmm.utils.removeNumericSuffix(fdmm.utils.removeGroupingPrefix(o))local i=fdmm.territories.all[e]if i~=nil then
local s=fdmm.cargoRoutes[e][a]local f=mist.getGroupRoute(o,false)local l=fdmm.utils.getFaction(string.notEmptyElse(n.units[1].unitName,n.country))local m=a:upperFirst()local u=table.concatedWith(fdmm.consts.CargoRouteGNPrefix,fdmm.consts.CargoRouteWPRoutePrefix[m])local e=nil
local n={Spawn='spawn',Linkage='linkage',Facility='facility',TBD='_'}local i,r,d=nil,nil,{}function _updateScanner(t,m)if e==n.TBD and t~=nil and t~=n.TBD then
e=t
elseif e~=nil and e~=n.TBD and t==n.TBD then
t=e
end
if e~=t or i~=m then
if e then
if e==n.Spawn then
if string.isNotEmpty(l)and r and d then
s:addSpawnLocation(l,r,d)else
env.error('Cargo '..a.." routing group '"..o.."' failed to parse spawn route '"..(i or'<nil>').."'.")end
elseif e==n.Linkage then
if string.isNotEmpty(i)and r and d then
s:addDirectionalLink(i,r,d)else
env.error('Cargo '..a.." routing group '"..o.."' failed to parse linkage route '"..(i or'<nil>').."'.")end
elseif e==n.Facility then
if string.isNotEmpty(i)and r and d then
s:addFacilityLocation(i,r,d)else
env.error('Cargo '..a.." routing group '"..o.."' failed to parse facility route '"..(i or'<nil>').."'.")end
elseif e~=n.TBD then
env.error('Cargo '..a.." routing group '"..o.."' encountered unrecognized scan mode '"..(t or'<nil>').."'.")end
i,r,d=nil,nil,{}end
e=t
i=m
end
end
for s,e in ipairs(f)do
if string.isNotEmpty(e.name)and(e.name..'_')~=fdmm.consts.CargoRouteGNPrefix[m]then
local l,t,i=fdmm.utils.getGroupingComponentsWithSNC(e.name,u,fdmm.consts.CargoRouteWPRouteSuffix)if l==fdmm.consts.CargoRouteGNPrefix[m]then
if i==fdmm.consts.CargoRouteWPRouteSuffix.Egress or
i==fdmm.consts.CargoRouteWPRouteSuffix.Ingress then
_updateScanner(n.TBD,t)table.insert(d,fdmm.utils.rposFromRPoint(e))elseif i==fdmm.consts.CargoRouteWPRouteSuffix.Spawn then
_updateScanner(n.Spawn,t)r=fdmm.utils.rposFromRPoint(e)elseif i==fdmm.consts.CargoRouteWPRouteSuffix.Linkage then
_updateScanner(n.Linkage,t)r=fdmm.utils.rposFromRPoint(e)elseif i==fdmm.consts.CargoRouteWPRouteSuffix.Facility then
_updateScanner(n.Facility,t)r=fdmm.utils.rposFromRPoint(e)elseif not(string.isEmpty(t)and string.isEmpty(i))then
env.error('Cargo '..a.." routing group '"..o.."' unknown WP '"..(e.name or'<nil>').."' at WP index "..s..'.')end
elseif l==fdmm.consts.CargoRouteWPRoutePrefix[m].Spawn then
if string.isEmpty(i)then
_updateScanner(n.Spawn,t)r=fdmm.utils.rposFromRPoint(e)elseif i==fdmm.consts.CargoRouteWPRouteSuffix.Egress then
_updateScanner(n.Spawn,t)table.insert(d,fdmm.utils.rposFromRPoint(e))elseif not(string.isEmpty(t)and string.isEmpty(i))then
env.error('Cargo '..a.." routing group '"..o.."' unknown spawn WP '"..(e.name or'<nil>').."' at WP index "..s..'.')end
elseif l==fdmm.consts.CargoRouteWPRoutePrefix[m].Linkage then
if string.isEmpty(i)then
_updateScanner(n.Linkage,t)r=fdmm.utils.rposFromRPoint(e)elseif i==fdmm.consts.CargoRouteWPRouteSuffix.Ingress then
_updateScanner(n.Linkage,t)table.insert(d,fdmm.utils.rposFromRPoint(e))elseif not(string.isEmpty(t)and string.isEmpty(i))then
env.error('Cargo '..a.." routing group '"..o.."' unknown linkage WP '"..(e.name or'<nil>').."' at WP index "..s..'.')end
elseif l==fdmm.consts.CargoRouteWPRoutePrefix[m].Facility then
if string.isEmpty(i)then
_updateScanner(n.Facility,t)r=fdmm.utils.rposFromRPoint(e)elseif i==fdmm.consts.CargoRouteWPRouteSuffix.Ingress then
_updateScanner(n.Facility,t)table.insert(d,fdmm.utils.rposFromRPoint(e))elseif not(string.isEmpty(t)and string.isEmpty(i))then
env.error('Cargo '..a.." routing group '"..o.."' unknown facility WP '"..(e.name or'<nil>').."' at WP index "..s..'.')end
else
env.error('Cargo '..a.." routing group '"..o.."' unknown routing WP '"..(e.name or'<nil>').."' at WP index "..s..'.')end
end
end
_updateScanner(nil,nil)else
env.error('Cargo '..a.." routing group '"..o.."' failed to find territory with same name.")end
end
for n,e in pairs(f[fdmm.consts.CargoRouteGNPrefix.Land])do
_processGroup(n,e,fdmm.enums.CargoRouteType.Land)end
for e,n in pairs(f[fdmm.consts.CargoRouteGNPrefix.Train])do
_processGroup(e,n,fdmm.enums.CargoRouteType.Train)end
for n,e in pairs(f[fdmm.consts.CargoRouteGNPrefix.Air])do
_processGroup(n,e,fdmm.enums.CargoRouteType.Air)end
for e,n in pairs(f[fdmm.consts.CargoRouteGNPrefix.Sea])do
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
e.polygonPoints={}local t=mist.getGroupPoints(n)for n,i in ipairs(t)do
if n>1 and n<#t then
table.insert(e.polygonPoints,i)elseif n==1 then
e.centerPoint=i
else
e.capturePoint=i
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
function FDMMTerritory:smokeBoundaries(n)n=n or SMOKECOLOR.Blue
local a=10000./25.
local r=nil
for e,o in ipairs(self.polygonPoints)do
if e>1 then
local e=mist.utils.makeVec3(o)local e=mist.vec.sub(e,r)local i=mist.vec.mag(e)local o=mist.vec.scalarMult(e,1./i)local e=1
local t=i/e
while t>a do
e=e+1
t=i/e
end
while e>=0 do
local i=mist.vec.scalarMult(o,e*t)local i=mist.vec.add(r,i);COORDINATE:NewFromVec2(mist.utils.makeVec2(i)):Smoke(n)e=e-1
end
end
r=mist.utils.makeVec3(o)end
end
end
do
function fdmm.territory.createTerritories()fdmm.territories={[fdmm.enums.TerritoryType.Land]={},[fdmm.enums.TerritoryType.Sea]={},[fdmm.enums.TerritoryType.All]={}}local n={[fdmm.consts.TerritoryGNPrefix.Define]=fdmm.config.gpCache[fdmm.consts.TerritoryGNPrefix.Define]or{},[fdmm.consts.TerritoryGNPrefix.Linkage]=fdmm.config.gpCache[fdmm.consts.TerritoryGNPrefix.Linkage]or{}}for n,e in pairs(n[fdmm.consts.TerritoryGNPrefix.Define])do
local e=FDMMTerritory.newFromGroup(n,e)fdmm.territories[e.type][e.name]=e
fdmm.territories.all[e.name]=e
end
for e,n in pairs(n[fdmm.consts.TerritoryGNPrefix.Linkage])do
local i=fdmm.utils.removeGroupingPrefix(e)local n=fdmm.territories.all[i]if n~=nil then
for t,i in ipairs(mist.getGroupRoute(e,false))do
if string.isEmpty(i.name)then
local i=fdmm.territory.closestTerritoryToPoint(fdmm.utils.rposFromRPoint(i),n.type)if i~=nil then
n:addTerritoryLink(i)else
env.error("Territory linkage group '"..e.."' failed to find a closest territory at WP index "..t..'.')end
end
end
else
env.error("Territory linkage group '"..e.."' failed to find territory named '"..i.."'.")end
end
end
function fdmm.territory.createFacilities()fdmm.facilities={[fdmm.enums.FacilityType.Airbase]={},[fdmm.enums.FacilityType.ArmsPlant]={},[fdmm.enums.FacilityType.CommandCenter]={},[fdmm.enums.FacilityType.FARP]={},[fdmm.enums.FacilityType.OilField]={},[fdmm.enums.FacilityType.Port]={},[fdmm.enums.FacilityType.UnitFactory]={},[fdmm.enums.FacilityType.All]={}}local n={[fdmm.consts.TerritoryGNPrefix.Facility]=fdmm.config.gpCache[fdmm.consts.TerritoryGNPrefix.Facility]or{}}local e=table.concatedWith(fdmm.consts.TerritoryGNPrefix,fdmm.consts.TerritoryWPFacilityPrefix)for o,n in pairs(n[fdmm.consts.TerritoryGNPrefix.Facility])do
local i=fdmm.utils.removeGroupingPrefix(o)local t=fdmm.territories.all[i]if t~=nil then
for d,n in ipairs(mist.getGroupRoute(o,false))do
if string.isNotEmpty(n.name)and(n.name..'_')~=fdmm.consts.TerritoryGNPrefix.Facility then
local r,e,a=fdmm.utils.getGroupingComponentsWithSNC(n.name,e,nil)if r==fdmm.consts.TerritoryWPFacilityPrefix.Airbase and string.isNotEmpty(e)then
local e=fdmm.facilities.all[e]or FDMMAirbase.new(e,fdmm.utils.rposFromRPoint(n),i)fdmm.facilities.airbase[e.name]=e
fdmm.facilities.all[e.name]=e
t:addFacility(e)elseif r==fdmm.consts.TerritoryWPFacilityPrefix.ArmsPlant and string.isNotEmpty(e)then
local e=fdmm.facilities.all[e]or FDMMArmsPlant.new(e,fdmm.utils.rposFromRPoint(n),i)fdmm.facilities.armsPlant[e.name]=e
fdmm.facilities.all[e.name]=e
t:addFacility(e)elseif r==fdmm.consts.TerritoryWPFacilityPrefix.CommandCenter and string.isNotEmpty(e)then
local e=fdmm.facilities.all[e]or FDMMCommandCenter.new(e,fdmm.utils.rposFromRPoint(n),i)fdmm.facilities.commandCenter[e.name]=e
fdmm.facilities.all[e.name]=e
t:addFacility(e)elseif r==fdmm.consts.TerritoryWPFacilityPrefix.FARP and string.isNotEmpty(e)then
local e=fdmm.facilities.all[e]or FDMMFARP.new(e,fdmm.utils.rposFromRPoint(n),i)fdmm.facilities.farp[e.name]=e
fdmm.facilities.all[e.name]=e
t:addFacility(e)elseif r==fdmm.consts.TerritoryWPFacilityPrefix.OilField and string.isNotEmpty(e)then
local e=fdmm.facilities.all[e]or FDMMOilField.new(e,fdmm.utils.rposFromRPoint(n),i)fdmm.facilities.oilField[e.name]=e
fdmm.facilities.all[e.name]=e
t:addFacility(e)elseif r==fdmm.consts.TerritoryWPFacilityPrefix.Port and string.isNotEmpty(e)then
local e=fdmm.facilities.all[e]or FDMMPort.new(e,fdmm.utils.rposFromRPoint(n),i)fdmm.facilities.port[e.name]=e
fdmm.facilities.all[e.name]=e
t:addFacility(e)elseif r==fdmm.consts.TerritoryWPFacilityPrefix.UnitFactory and string.isNotEmpty(e)then
local e=fdmm.facilities.all[e]or FDMMUnitFactory.new(e,fdmm.utils.rposFromRPoint(n),i)fdmm.facilities.unitFactory[e.name]=e
fdmm.facilities.all[e.name]=e
t:addFacility(e)elseif not(string.isEmpty(e)and string.isEmpty(a))then
env.error("Territory group '"..o.."' unknown facility WP '"..(n.name or'<nil>').."' at WP index "..d..'.')end
end
end
else
env.error("Territory facility group '"..o.."' failed to find territory named '"..i.."'.")end
end
end
function fdmm.territory.buildFacilities()for n,e in pairs(fdmm.territories.all)do
e:buildFacilities()end
end
function fdmm.territory.closestTerritoryToPoint(e,n)local i=mist.utils.makeVec2(e)local e=nil
local t=0
local n=n or fdmm.enums.TerritoryType.All
local n=fdmm.territories[n]for r,n in pairs(n)do
local i=mist.utils.get2DDistSqrd(i,n.centerPoint)if e==nil or i<t then
e=n
t=i
end
end
return e
end
function fdmm.territory.dumpTerritories()function _envInfoTerritory(n,e)env.info("    '"..n.."':")env.info('      '..'centerPoint: '..fdmm.utils.pos2ToLoggableString(e.centerPoint))env.info('      '..'capturePoint: '..fdmm.utils.pos2ToLoggableString(e.capturePoint))for e,n in pairs(e.linkedTerritories)do
env.info('      '.."Linked /w: '"..e.."'.")end
end
env.info('--FDMM Territories Dump--')env.info('  Sea Territories:')for n,e in pairs(fdmm.territories.sea)do
_envInfoTerritory(n,e)end
env.info('  Land Territories:')for e,n in pairs(fdmm.territories.land)do
_envInfoTerritory(e,n)end
end
end
env.info('---FDMM_Territory End---')end)__DISTILLER:define("Territory/FDMM_Facility",function(e)env.info('---FDMM_Facility Start---')fdmm.facility={}do
FDMMFacility={}FDMMFacility.__index=FDMMFacility
setmetatable(FDMMFacility,{__call=function(e,...)return e.new(...)end})function FDMMFacility.new(n,i,t)local e=setmetatable({},FDMMFacility)e.name=n
e.centerPoint=i
e.territoryName=t
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
setmetatable(FDMMAirbase,{__index=FDMMFacility,__call=function(e,...)return e.new(...)end})function FDMMAirbase.new(e,n,i)local e=setmetatable(FDMMFacility.new(e,n,i),FDMMAirbase)return e
end
function FDMMAirbase:buildFacility()end
function FDMMAirbase:getFacilityType()return fdmm.enums.FacilityType.Airbase
end
end
do
end
env.info('---FDMM_Airbase End---')end)__DISTILLER:define("Territory/FDMM_ArmsPlant",function(e)env.info('---FDMM_ArmsPlant Start---')e('Territory/FDMM_Facility')fdmm.armsPlant={}do
FDMMArmsPlant={}FDMMArmsPlant.__index=FDMMArmsPlant
setmetatable(FDMMArmsPlant,{__index=FDMMFacility,__call=function(e,...)return e.new(...)end})function FDMMArmsPlant.new(n,e,i)local e=setmetatable(FDMMFacility.new(n,e,i),FDMMArmsPlant)return e
end
function FDMMArmsPlant:buildFacility()end
function FDMMArmsPlant:getFacilityType()return fdmm.enums.FacilityType.ArmsPlant
end
end
do
end
env.info('---FDMM_ArmsPlant End---')end)__DISTILLER:define("Territory/FDMM_CommandCenter",function(e)env.info('---FDMM_CommandCenter Start---')e('Territory/FDMM_Facility')fdmm.commandCenter={}do
FDMMCommandCenter={}FDMMCommandCenter.__index=FDMMCommandCenter
setmetatable(FDMMCommandCenter,{__index=FDMMFacility,__call=function(e,...)return e.new(...)end})function FDMMCommandCenter.new(i,n,e)local e=setmetatable(FDMMFacility.new(i,n,e),FDMMCommandCenter)return e
end
function FDMMCommandCenter:buildFacility()end
function FDMMCommandCenter:getFacilityType()return fdmm.enums.FacilityType.CommandCenter
end
end
do
end
env.info('---FDMM_CommandCenter End---')end)__DISTILLER:define("Territory/FDMM_FARP",function(e)env.info('---FDMM_FARP Start---')e('Territory/FDMM_Facility')fdmm.farp={}do
FDMMFARP={}FDMMFARP.__index=FDMMFARP
setmetatable(FDMMFARP,{__index=FDMMFacility,__call=function(e,...)return e.new(...)end})function FDMMFARP.new(i,n,e)local e=setmetatable(FDMMFacility.new(i,n,e),FDMMFARP)return e
end
function FDMMFARP:buildFacility()end
function FDMMFARP:getFacilityType()return fdmm.enums.FacilityType.FARP
end
end
do
end
env.info('---FDMM_FARP End---')end)__DISTILLER:define("Territory/FDMM_OilField",function(e)env.info('---FDMM_OilField Start---')e('Territory/FDMM_Facility')fdmm.oilField={}do
FDMMOilField={}FDMMOilField.__index=FDMMOilField
setmetatable(FDMMOilField,{__index=FDMMFacility,__call=function(e,...)return e.new(...)end})function FDMMOilField.new(e,n,i)local e=setmetatable(FDMMFacility.new(e,n,i),FDMMOilField)return e
end
function FDMMOilField:buildFacility()end
function FDMMOilField:getFacilityType()return fdmm.enums.FacilityType.OilField
end
end
do
end
env.info('---FDMM_OilField End---')end)__DISTILLER:define("Territory/FDMM_Port",function(e)env.info('---FDMM_Port Start---')e('Territory/FDMM_Facility')fdmm.port={}do
FDMMPort={}FDMMPort.__index=FDMMPort
setmetatable(FDMMPort,{__index=FDMMFacility,__call=function(e,...)return e.new(...)end})function FDMMPort.new(n,i,e)local e=setmetatable(FDMMFacility.new(n,i,e),FDMMPort)return e
end
function FDMMPort:buildFacility()end
function FDMMPort:getFacilityType()return fdmm.enums.FacilityType.Port
end
end
do
end
env.info('---FDMM_Port End---')end)__DISTILLER:define("Territory/FDMM_UnitFactory",function(e)env.info('---FDMM_UnitFactory Start---')e('Territory/FDMM_Facility')fdmm.unitFactory={}do
FDMMUnitFactory={}FDMMUnitFactory.__index=FDMMUnitFactory
setmetatable(FDMMUnitFactory,{__index=FDMMFacility,__call=function(e,...)return e.new(...)end})function FDMMUnitFactory.new(e,n,i)local e=setmetatable(FDMMFacility.new(e,n,i),FDMMUnitFactory)return e
end
function FDMMUnitFactory:buildFacility()end
function FDMMUnitFactory:getFacilityType()return fdmm.enums.FacilityType.UnitFactory
end
end
do
end
env.info('---FDMM_UnitFactory End---')end)__DISTILLER:define("FDMM_MissionStart.lua_distilled",function(e)env.info('---FDMM_MissionStart Start---')env.setErrorMessageBoxEnabled(false)fdmm={}e('FDMM_Config')e('FDMM_Utils')e('Additions/FDMM_LuaAdditions')e('Additions/FDMM_MISTAdditions')e('Additions/FDMM_MOOSEAdditions')e('Cargo/FDMM_ResourceUnit')e('Cargo/FDMM_CargoRoute')e('Territory/FDMM_Territory')e('Territory/FDMM_Airbase')e('Territory/FDMM_ArmsPlant')e('Territory/FDMM_CommandCenter')e('Territory/FDMM_FARP')e('Territory/FDMM_OilField')e('Territory/FDMM_Port')e('Territory/FDMM_UnitFactory')do
fdmm.config.createGPCache()fdmm.territory.createTerritories()fdmm.territory.createFacilities()fdmm.cargoRoute.createCargoRoutes()fdmm.territory.buildFacilities()trigger.action.outText('FDMM Started',10)end
env.info('---FDMM_MissionStart End---')end)__DISTILLER:exec("FDMM_MissionStart.lua_distilled")