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
fdmm.enums.Faction={Red='Red',Blue='Blue',Neutral='Neutral',USA='USA',Russia='Russia',Georgia='Georgia',Turkey='Turkey',Ukraine='Ukraine',Unused='Unused'}fdmm.consts.RouteSuffix={SpawnPoint='_SP',EgressPoint='_EP',IngressPoint='_IP'}fdmm.consts.UserFlags={DebugFlag='99999'}end
do
fdmm.enums.TerritoryType={Land='land',Sea='sea',All='all'}fdmm.consts.TerritoryPrefix={Define='TDEF_',Link='TLNK_',FARP='TFRP_',Port='TPRT_'}end
do
fdmm.enums.CargoRouteType={Land='land',Train='train',Air='air',Sea='sea',All='all'}fdmm.consts.CargoRoutePrefix={Land='CVRT_',Train='CTRT_',Air='CART_',Sea='CSRT_'}fdmm.consts.CargoRouteLocPrefix={Land={Warehouse='CVWH_',Linkage='CVLK_'},Train={Warehouse='CTWH_',Linkage='CTLK_'},Air={Warehouse='CAWH_',Linkage='CALK_'},Sea={Warehouse='CSWH_',Linkage='CSLK_'}}end
do
function fdmm.config.createGPCache()fdmm.config.gpCache={}local t={'FARP_','PORT_','AIRB_'}for n,i in pairs(mist.DBs.groupsByName)do
local r,e=fdmm.utils.removeGroupingPrefix(n)if e~=nil then
if not fdmm.config.gpCache[e]then
fdmm.config.gpCache[e]={}end
if table.contains(t,e)then
local t=string.find(r,'_')if t~=nil then
local t=r:sub(1,t-1)if not fdmm.config.gpCache[e][t]then
fdmm.config.gpCache[e][t]={}end
fdmm.config.gpCache[e][t][n]=i
else
if not fdmm.config.gpCache[e]['_']then
fdmm.config.gpCache[e]['_']={}end
fdmm.config.gpCache[e]['_'][n]=i
end
else
fdmm.config.gpCache[e][n]=i
end
end
end
end
end
env.info("---FDMM_Config End---");end)__DISTILLER:define("FDMM_LuaAdditions",function(e)env.info('---FDMM_LuaAdditions Start---')do
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
function table.contains(n,e)for i,n in pairs(n)do
if n==e then
return true
end
end
return false
end
end
env.info('---FDMM_LuaAdditions End---')end)__DISTILLER:define("FDMM_MISTAdditions",function(e)env.info('---FDMM_MISTAdditions Start---')assert(mist,'MIST not initialized.')do
mist.DBs.Category={Vehicle='vehicle',Ship='ship',Plane='plane',Helicopter='helicopter',Building='building',Unknown='unknown'}function mist.utils.get2DDistSqrd(e,n)if e.z~=nil then e=mist.utils.makeVec2(e)end
if n.z~=nil then n=mist.utils.makeVec2(n)end
return mist.vec.magSqrd({x=e.x-n.x,y=e.y-n.y})end
function mist.utils.get3DDistSqrd(e,n)if e.z==nil then e=mist.utils.makeVec3(e)end
if n.z==nil then n=mist.utils.makeVec3(n)end
return mist.vec.magSqrd({x=e.x-n.x,y=e.y-n.y,z=e.z-n.z})end
mist.vec.magSqrd=function(e)return(e.x*e.x)+(e.y*e.y)+((e.z or 0)*(e.z or 0))end
end
env.info('---FDMM_MISTAdditions End---')end)__DISTILLER:define("FDMM_MOOSEAdditions",function(e)env.info('---FDMM_MOOSEAdditions Start---')assert(routines,'MOOSE not initialized.')do
function routines.utils.get2DDistSqrd(e,n)if e.z~=nil then e=routines.utils.makeVec2(e)end
if n.z~=nil then n=routines.utils.makeVec2(n)end
return routines.vec.magSqrd({x=e.x-n.x,y=e.y-n.y})end
function routines.utils.get3DDistSqrd(n,e)if n.z==nil then n=routines.utils.makeVec3(n)end
if e.z==nil then e=routines.utils.makeVec3(e)end
return routines.vec.magSqrd({x=n.x-e.x,y=n.y-e.y,z=n.z-e.z})end
routines.vec.magSqrd=function(e)return(e.x*e.x)+(e.y*e.y)+((e.z or 0)*(e.z or 0))end
function ZONE_POLYGON:NewFromPoints(n,e)local e=BASE:Inherit(self,ZONE_POLYGON_BASE:New(n,e))e:F({n,nil,e._.Polygon})_EVENTDISPATCHER:CreateEventNewZone(e)return e
end
end
env.info('---FDMM_MOOSEAdditions End---')end)__DISTILLER:define("FDMM_Utils",function(e)env.info("---FDMM_Utils Start---");fdmm.utils={}do
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
function fdmm.utils.makePos2FromRP(e)return{x=e.x or e.point.x,y=e.y or e.point.y}end
function fdmm.utils.getFaction(e)if e then
e=fdmm.utils.removeNumericSuffix(e)for n,i in pairs(fdmm.enums.Faction)do
if i:lower()==e:lower()then
return n
end
end
end
return fdmm.enums.Faction.Unused
end
function fdmm.utils.isUserFlagSet(e)local e=trigger.misc.getUserFlag(e)return(type(e)=='number'and e~=0)or(type(e)=='boolean'and e~=false)or(type(e)=='string'and e:lower()~='false'and e~='0'and e:lower()~='off'and e:lower()~='no')end
function fdmm.utils.isDebugFlagSet()return fdmm.utils.isUserFlagSet(fdmm.consts.UserFlags.DebugFlag)end
end
env.info("---FDMM_Utils End---");end)__DISTILLER:define("FDMM_Territory",function(e)env.info('---FDMM_Territory Start---')fdmm.territory={}do
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
e.polygonZone=ZONE_POLYGON:NewFromPoints(e.name,e.polygonPoints)e.linkedTerritories={}e.linkedTerritoryDistances={}e.farps={}e.ports={}return e
end
function FDMMTerritory:addTerritoryLink(e)if self.name~=e.name then
self.linkedTerritories[e.name]=e
e.linkedTerritories[self.name]=self
local n=mist.utils.get2DDist(self.centerPoint,e.centerPoint)self.linkedTerritoryDistances[e.name]=n
e.linkedTerritoryDistances[self.name]=n
else
env.error("Cannot link territory '"..self.name.."' with itself.")end
end
function FDMMTerritory:addFARP(e)assert(e.territoryName==self.name,'Cannot add FARP belonging to different territory.')self.farps[e.name]=e
end
function FDMMTerritory:addPort(e)assert(e.territoryName==self.name,'Cannot add port belonging to different territory.')self.ports[e.name]=e
end
function FDMMTerritory:buildFacilities()for n,e in pairs(self.farps)do
e:buildFARP()end
for n,e in pairs(self.ports)do
e:buildPort()end
end
function FDMMTerritory:smokeBoundaries(t)t=t or SMOKECOLOR.Blue
local s=10000./25.
local r=nil
for e,o in ipairs(self.polygonPoints)do
if e>1 then
local e=mist.utils.makeVec3(o)local e=mist.vec.sub(e,r)local i=mist.vec.mag(e)local o=mist.vec.scalarMult(e,1./i)local e=1
local n=i/e
while n>s do
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
function fdmm.territory.createTerritories()fdmm.territories={[fdmm.enums.TerritoryType.Land]={},[fdmm.enums.TerritoryType.Sea]={},[fdmm.enums.TerritoryType.All]={}}local n={[fdmm.consts.TerritoryPrefix.Define]=fdmm.config.gpCache[fdmm.consts.TerritoryPrefix.Define]or{},[fdmm.consts.TerritoryPrefix.Link]=fdmm.config.gpCache[fdmm.consts.TerritoryPrefix.Link]or{},[fdmm.consts.TerritoryPrefix.FARP]=fdmm.config.gpCache[fdmm.consts.TerritoryPrefix.FARP]or{},[fdmm.consts.TerritoryPrefix.Port]=fdmm.config.gpCache[fdmm.consts.TerritoryPrefix.Port]or{}}for n,e in pairs(n[fdmm.consts.TerritoryPrefix.Define])do
local e=FDMMTerritory.newFromGroup(n,e)fdmm.territories[e.type][e.name]=e
fdmm.territories.all[e.name]=e
end
for e,n in pairs(n[fdmm.consts.TerritoryPrefix.Link])do
local n=fdmm.utils.removeGroupingPrefix(e)local n=fdmm.territories.all[n]if n~=nil then
for i,t in ipairs(mist.getGroupPoints(e))do
if i>1 then
local t=fdmm.territory.closestTerritoryToPoint(t,n.type)if t~=nil then
n:addTerritoryLink(t)else
env.error("Territory linkage group '"..e.."' failed to find a closest territory at WP index "..i..'.')end
end
end
else
env.error("Territory linkage group '"..e.."' failed to find territory with same name.")end
end
for n,e in pairs(n[fdmm.consts.TerritoryPrefix.FARP])do
local i=fdmm.utils.removeGroupingPrefix(n)local t=fdmm.territories.all[i]if t~=nil then
local e=mist.getGroupRoute(n,false)for n,e in ipairs(e)do
if string.isNotEmpty(e.name)then
local r,n,r=fdmm.utils.getGroupingComponentsWithSNC(e.name,fdmm.consts.TerritoryPrefix,nil)if string.isNotEmpty(n)then
local e=FDMMFARP.new(n,fdmm.utils.makePos2FromRP(e),i)t:addFARP(e)end
end
end
else
env.error("Territory FARP group '"..n.."' failed to find territory with same name.")end
end
for n,e in pairs(n[fdmm.consts.TerritoryPrefix.Port])do
local i=fdmm.utils.removeGroupingPrefix(n)local t=fdmm.territories.all[i]if t~=nil then
local e=mist.getGroupRoute(n,false)for n,e in ipairs(e)do
if string.isNotEmpty(e.name)then
local r,n,r=fdmm.utils.getGroupingComponentsWithSNC(e.name,fdmm.consts.TerritoryPrefix,nil)if string.isNotEmpty(n)then
local e=FDMMPort.new(n,fdmm.utils.makePos2FromRP(e),i)t:addPort(e)end
end
end
else
env.error("Territory port group '"..n.."' failed to find territory with same name.")end
end
end
function fdmm.territory.buildFacilities()for n,e in pairs(fdmm.territories.all)do
e:buildFacilities()end
end
function fdmm.territory.closestTerritoryToPoint(e,i)local r=mist.utils.makeVec2(e)local e=nil
local n=0
local i=i or fdmm.enums.TerritoryType.All
local i=fdmm.territories[i]for i,t in pairs(i)do
local i=mist.utils.get2DDistSqrd(r,t.centerPoint)if e==nil or i<n then
e=t
n=i
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
env.info('---FDMM_Territory End---')end)__DISTILLER:define("FDMM_Port",function(e)env.info('---FDMM_Port Start---')fdmm.port={}do
FDMMPort={}FDMMPort.__index=FDMMPort
setmetatable(FDMMPort,{__call=function(e,...)return e.new(...)end,})function FDMMPort.new(t,n,i)local e=setmetatable({},FDMMPort)e.name=t
e.centerPoint=n
e.territoryName=i
return e
end
function FDMMPort:buildPort()end
end
do
end
env.info('---FDMM_Port End---')end)__DISTILLER:define("FDMM_FARP",function(e)env.info('---FDMM_FARP Start---')fdmm.farp={}do
FDMMFARP={}FDMMFARP.__index=FDMMFARP
setmetatable(FDMMFARP,{__call=function(e,...)return e.new(...)end,})function FDMMFARP.new(t,i,n)local e=setmetatable({},FDMMFARP)e.name=t
e.centerPoint=i
e.territoryName=n
return e
end
function FDMMFARP:buildFARP()end
end
do
end
env.info('---FDMM_FARP End---')end)__DISTILLER:define("FDMM_CargoRoute",function(e)env.info('---FDMM_CargoRoute Start---')fdmm.cargoRoute={}do
FDMMCargoRoute={}FDMMCargoRoute.__index=FDMMCargoRoute
setmetatable(FDMMCargoRoute,{__call=function(e,...)return e.new(...)end,})function FDMMCargoRoute.new(n,i)local e=setmetatable({},FDMMCargoRoute)e.territoryName=n
e.routeType=i
e.startLocations={}e.warehouseLocations={}e.directionalLinks={}return e
end
function FDMMCargoRoute:addStartLocation(i,n,e)table.insert(self.startLocations,{spawnFaction=i,spawnPoint=n,egressPoints=e or{}})end
function FDMMCargoRoute:addWarehouseLocation(e,i,n)table.insert(self.warehouseLocations,{warehouseName=e,warehousePoint=i,ingressPoints=n or{}})end
function FDMMCargoRoute:addDirectionalLink(n,i,e)table.insert(self.directionalLinks,{directionName=n,navigationPoint=i,ingressPoints=e or{}})end
function FDMMCargoRoute:getOutboundRouteFromSpawn(e)end
function FDMMCargoRoute:getInboundRouteToWarehouse(e)end
function FDMMCargoRoute:getOutboundRouteFromWarehouse(e)end
function FDMMCargoRoute:getClosestDirectionalLinkageToOutsidePoint(e)end
end
do
function fdmm.cargoRoute.createCargoRoutes()fdmm.cargoRoutes={}for e,n in pairs(fdmm.territories.all)do
fdmm.cargoRoutes[e]={[fdmm.enums.CargoRouteType.Land]=FDMMCargoRoute.new(e,fdmm.enums.CargoRouteType.Land),[fdmm.enums.CargoRouteType.Train]=FDMMCargoRoute.new(e,fdmm.enums.CargoRouteType.Train),[fdmm.enums.CargoRouteType.Air]=FDMMCargoRoute.new(e,fdmm.enums.CargoRouteType.Air),[fdmm.enums.CargoRouteType.Sea]=FDMMCargoRoute.new(e,fdmm.enums.CargoRouteType.Sea)}end
local a={[fdmm.consts.CargoRoutePrefix.Land]=fdmm.config.gpCache[fdmm.consts.CargoRoutePrefix.Land]or{},[fdmm.consts.CargoRoutePrefix.Train]=fdmm.config.gpCache[fdmm.consts.CargoRoutePrefix.Train]or{},[fdmm.consts.CargoRoutePrefix.Air]=fdmm.config.gpCache[fdmm.consts.CargoRoutePrefix.Air]or{},[fdmm.consts.CargoRoutePrefix.Sea]=fdmm.config.gpCache[fdmm.consts.CargoRoutePrefix.Sea]or{}}function _processGroup(n,e,i)local t=fdmm.utils.removeNumericSuffix(fdmm.utils.removeGroupingPrefix(n))local r=fdmm.territories.all[t]if r~=nil then
local a=fdmm.cargoRoutes[t][i]local u=mist.getGroupRoute(n,false)local m=fdmm.utils.getFaction(string.notEmptyElse(e.units[1].unitName,e.country))local f=i:upperFirst()local s=nil
local o={Spawn='spawn',Warehouse='warehouse',Linkage='linkage'}local e,t,r=nil,nil,{}function _updateScanner(d,f)if s~=d or e~=f then
if s then
if s==o.Spawn then
if string.isNotEmpty(m)and t and r then
a:addStartLocation(m,t,r)else
env.error('Cargo '..i.." routing group '"..n.."' failed to parse spawn route '"..(e or'<nil>').."'.")end
elseif s==o.Warehouse then
if string.isNotEmpty(e)and t and r then
a:addWarehouseLocation(e,t,r)else
env.error('Cargo '..i.." routing group '"..n.."' failed to parse warehouse route '"..(e or'<nil>').."'.")end
elseif s==o.Linkage then
if string.isNotEmpty(e)and t and r then
a:addDirectionalLink(e,t,r)else
env.error('Cargo '..i.." routing group '"..n.."' failed to parse linkage route '"..(e or'<nil>').."'.")end
else
env.error('Cargo '..i.." routing group '"..n.."' encountered unrecognized scan mode '"..d.."'.")end
e,t,r=nil,nil,{}end
s=d
e=f
end
end
for a,e in ipairs(u)do
if string.isNotEmpty(e.name)then
local m,d,s=fdmm.utils.getGroupingComponentsWithSNC(e.name,fdmm.consts.CargoRoutePrefix,fdmm.consts.RouteSuffix)if m==fdmm.consts.CargoRoutePrefix[f]then
if s==fdmm.consts.RouteSuffix.SpawnPoint then
_updateScanner(o.Spawn,d)t=fdmm.utils.makePos2FromRP(e)elseif s==fdmm.consts.RouteSuffix.EgressPoint then
_updateScanner(o.Spawn,d)table.insert(r,fdmm.utils.makePos2FromRP(e))elseif not(string.isEmpty(d)and string.isEmpty(s))then
env.error('Cargo '..i.." routing group '"..n.."' unknown spawn WP '"..e.name.."' at WP index "..a..'.')end
elseif m==fdmm.consts.CargoRouteLocPrefix[f].Warehouse then
if string.isEmpty(s)then
_updateScanner(o.Warehouse,d)t=fdmm.utils.makePos2FromRP(e)elseif s==fdmm.consts.RouteSuffix.IngressPoint then
_updateScanner(o.Warehouse,d)table.insert(r,fdmm.utils.makePos2FromRP(e))elseif not(string.isEmpty(d)and string.isEmpty(s))then
env.error('Cargo '..i.." routing group '"..n.."' unknown warehouse WP '"..e.name.."' at WP index "..a..'.')end
elseif m==fdmm.consts.CargoRouteLocPrefix[f].Linkage then
if string.isEmpty(s)then
_updateScanner(o.Linkage,d)t=fdmm.utils.makePos2FromRP(e)elseif s==fdmm.consts.RouteSuffix.IngressPoint then
_updateScanner(o.Linkage,d)table.insert(r,fdmm.utils.makePos2FromRP(e))elseif not(string.isEmpty(d)and string.isEmpty(s))then
env.error('Cargo '..i.." routing group '"..n.."' unknown linkage WP '"..e.name.."' at WP index "..a..'.')end
else
env.error('Cargo '..i.." routing group '"..n.."' unknown routing WP '"..e.name.."' at WP index "..a..'.')end
end
end
_updateScanner(nil,nil)else
env.error('Cargo '..i.." routing group '"..n.."' failed to find territory with same name.")end
end
for n,e in pairs(a[fdmm.consts.CargoRoutePrefix.Land])do
_processGroup(n,e,fdmm.enums.CargoRouteType.Land)end
for n,e in pairs(a[fdmm.consts.CargoRoutePrefix.Train])do
_processGroup(n,e,fdmm.enums.CargoRouteType.Train)end
for n,e in pairs(a[fdmm.consts.CargoRoutePrefix.Air])do
_processGroup(n,e,fdmm.enums.CargoRouteType.Air)end
for e,n in pairs(a[fdmm.consts.CargoRoutePrefix.Sea])do
_processGroup(e,n,fdmm.enums.CargoRouteType.Sea)end
end
end
env.info('---FDMM_CargoRoute End---')end)__DISTILLER:define("FDMM_MissionStart.lua_distilled",function(e)env.info('---FDMM_MissionStart Start---')env.setErrorMessageBoxEnabled(false)fdmm={}e('FDMM_Config')e('FDMM_LuaAdditions')e('FDMM_MISTAdditions')e('FDMM_MOOSEAdditions')e('FDMM_Utils')e('FDMM_Territory')e('FDMM_Port')e('FDMM_FARP')e('FDMM_CargoRoute')do
fdmm.config.createGPCache()fdmm.territory.createTerritories()fdmm.cargoRoute.createCargoRoutes()fdmm.territory.buildFacilities()trigger.action.outText('FDMM Started',10)end
env.info('---FDMM_MissionStart End---')end)__DISTILLER:exec("FDMM_MissionStart.lua_distilled")