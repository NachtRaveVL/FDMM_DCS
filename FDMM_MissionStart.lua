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
fdmm.enums.Faction={Red='Red',Blue='Blue',Neutral='Neutral',USA='USA',Russia='Russia',Georgia='Georgia',Turkey='Turkey',Ukraine='Ukraine',Unused='Unused'}fdmm.enums.RPType={Fuel='fuel',Arms='arms',Unit='unit'}fdmm.enums.RPAmountType={Tons='tons',Percent='percent'}fdmm.enums.ErrorCodes={Success=0,Failure=1,Cancelled=2,InvalidParam=3,ShouldNotBeReached=4}fdmm.consts.UserFlags={DebugFlag='99999'}end
do
fdmm.enums.TerritoryType={Land='land',Sea='sea',All='all'}fdmm.consts.TerritoryPrefix={Define='TDEF_',Link='TLNK_',FARP='TFRP_',Port='TPRT_'}end
do
fdmm.enums.CargoRouteType={Land='land',Train='train',Air='air',Sea='sea',All='all'}fdmm.consts.CargoRoutePrefix={Land='CVRT_',Train='CTRT_',Air='CART_',Sea='CSRT_'}fdmm.consts.CargoRouteWPPrefix={Land={Spawn='CVSP_',Warehouse='CVWH_',Linkage='CVLK_'},Train={Spawn='CTSP_',Warehouse='CTWH_',Linkage='CTLK_'},Air={Spawn='CASP_',Warehouse='CAWH_',Linkage='CALK_'},Sea={Spawn='CSSP_',Warehouse='CSWH_',Linkage='CSLK_'}}fdmm.consts.CargoRouteWPSuffix={Egress='_EP',Ingress='_IP',Spawn='_SP',Warehouse='_WH',Linkage='_LK'}end
do
end
do
function fdmm.config.createGPCache()fdmm.config.gpCache={}local r={'FARP_','PORT_','AIRB_'}for n,i in pairs(mist.DBs.groupsByName)do
local t,e=fdmm.utils.removeGroupingPrefix(n)if e~=nil then
if not fdmm.config.gpCache[e]then
fdmm.config.gpCache[e]={}end
if table.contains(r,e)then
local r=string.find(t,'_')if r~=nil then
local r=t:sub(1,r-1)if not fdmm.config.gpCache[e][r]then
fdmm.config.gpCache[e][r]={}end
fdmm.config.gpCache[e][r][n]=i
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
function table.contains(e,n)for i,e in pairs(e)do
if e==n then
return true
end
end
return false
end
end
env.info('---FDMM_LuaAdditions End---')end)__DISTILLER:define("FDMM_MISTAdditions",function(e)env.info('---FDMM_MISTAdditions Start---')assert(mist,'MIST not initialized.')do
mist.DBs.Category={Vehicle='vehicle',Ship='ship',Plane='plane',Helicopter='helicopter',Building='building',Unknown='unknown'}function mist.utils.get2DDistSqrd(n,e)if n.z~=nil then n=mist.utils.makeVec2(n)end
if e.z~=nil then e=mist.utils.makeVec2(e)end
return mist.vec.magSqrd({x=n.x-e.x,y=n.y-e.y})end
function mist.utils.get3DDistSqrd(e,n)if e.z==nil then e=mist.utils.makeVec3(e)end
if n.z==nil then n=mist.utils.makeVec3(n)end
return mist.vec.magSqrd({x=e.x-n.x,y=e.y-n.y,z=e.z-n.z})end
mist.vec.magSqrd=function(e)return(e.x*e.x)+(e.y*e.y)+((e.z or 0)*(e.z or 0))end
end
env.info('---FDMM_MISTAdditions End---')end)__DISTILLER:define("FDMM_MOOSEAdditions",function(e)env.info('---FDMM_MOOSEAdditions Start---')assert(routines,'MOOSE not initialized.')do
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
env.info("---FDMM_Utils End---");end)__DISTILLER:define("FDMM_Territory",function(e)env.info('---FDMM_Territory Start---')fdmm.territory={}do
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
e.polygonZone=ZONE_POLYGON:NewFromPoints(e.name,e.polygonPoints)e.linkedTerritories={}e.linkedTerritoryDistances={}e.bases={}e.farps={}e.ports={}e.resources={}return e
end
function FDMMTerritory:addTerritoryLink(e)if self.name~=e.name then
self.linkedTerritories[e.name]=e
e.linkedTerritories[self.name]=self
local n=mist.utils.get2DDist(self.centerPoint,e.centerPoint)self.linkedTerritoryDistances[e.name]=n
e.linkedTerritoryDistances[self.name]=n
else
env.error("Cannot link territory '"..self.name.."' with itself.")end
end
function FDMMTerritory:addBase(e)assert(e.territoryName==self.name,'')end
function FDMMTerritory:addFARP(e)assert(e.__index==FDMMFARP,'Invalid FARP object')self.farps[e.name]=e
end
function FDMMTerritory:addPort(e)assert(e.territoryName==self.name,'Cannot add port belonging to different territory.')self.ports[e.name]=e
end
function FDMMTerritory:buildFacilities()for n,e in pairs(self.farps)do
e:buildFARP()end
for n,e in pairs(self.ports)do
e:buildPort()end
end
function FDMMTerritory:smokeBoundaries(n)n=n or SMOKECOLOR.Blue
local s=10000./25.
local r=nil
for e,o in ipairs(self.polygonPoints)do
if e>1 then
local e=mist.utils.makeVec3(o)local e=mist.vec.sub(e,r)local i=mist.vec.mag(e)local o=mist.vec.scalarMult(e,1./i)local e=1
local t=i/e
while t>s do
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
function fdmm.territory.createTerritories()fdmm.territories={[fdmm.enums.TerritoryType.Land]={},[fdmm.enums.TerritoryType.Sea]={},[fdmm.enums.TerritoryType.All]={}}local n={[fdmm.consts.TerritoryPrefix.Define]=fdmm.config.gpCache[fdmm.consts.TerritoryPrefix.Define]or{},[fdmm.consts.TerritoryPrefix.Link]=fdmm.config.gpCache[fdmm.consts.TerritoryPrefix.Link]or{},[fdmm.consts.TerritoryPrefix.FARP]=fdmm.config.gpCache[fdmm.consts.TerritoryPrefix.FARP]or{},[fdmm.consts.TerritoryPrefix.Port]=fdmm.config.gpCache[fdmm.consts.TerritoryPrefix.Port]or{}}for e,n in pairs(n[fdmm.consts.TerritoryPrefix.Define])do
local e=FDMMTerritory.newFromGroup(e,n)fdmm.territories[e.type][e.name]=e
fdmm.territories.all[e.name]=e
end
for e,n in pairs(n[fdmm.consts.TerritoryPrefix.Link])do
local n=fdmm.utils.removeGroupingPrefix(e)local n=fdmm.territories.all[n]if n~=nil then
for i,r in ipairs(mist.getGroupPoints(e))do
if i>1 then
local r=fdmm.territory.closestTerritoryToPoint(r,n.type)if r~=nil then
n:addTerritoryLink(r)else
env.error("Territory linkage group '"..e.."' failed to find a closest territory at WP index "..i..'.')end
end
end
else
env.error("Territory linkage group '"..e.."' failed to find territory with same name.")end
end
for e,n in pairs(n[fdmm.consts.TerritoryPrefix.FARP])do
local i=fdmm.utils.removeGroupingPrefix(e)local r=fdmm.territories.all[i]if r~=nil then
local e=mist.getGroupRoute(e,false)for n,e in ipairs(e)do
if string.isNotEmpty(e.name)then
local t,n,t=fdmm.utils.getGroupingComponentsWithSNC(e.name,fdmm.consts.TerritoryPrefix,nil)if string.isNotEmpty(n)then
local e=FDMMFARP.new(n,fdmm.utils.rposFromRPoint(e),i)r:addFARP(e)end
end
end
else
env.error("Territory FARP group '"..e.."' failed to find territory with same name.")end
end
for n,e in pairs(n[fdmm.consts.TerritoryPrefix.Port])do
local i=fdmm.utils.removeGroupingPrefix(n)local r=fdmm.territories.all[i]if r~=nil then
local e=mist.getGroupRoute(n,false)for n,e in ipairs(e)do
if string.isNotEmpty(e.name)then
local t,n,t=fdmm.utils.getGroupingComponentsWithSNC(e.name,fdmm.consts.TerritoryPrefix,nil)if string.isNotEmpty(n)then
local e=FDMMPort.new(n,fdmm.utils.rposFromRPoint(e),i)r:addPort(e)end
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
env.info('--FDMM Territories Dump--')env.info('  Sea Territories:')for e,n in pairs(fdmm.territories.sea)do
_envInfoTerritory(e,n)end
env.info('  Land Territories:')for n,e in pairs(fdmm.territories.land)do
_envInfoTerritory(n,e)end
end
end
env.info('---FDMM_Territory End---')end)__DISTILLER:define("FDMM_Port",function(e)env.info('---FDMM_Port Start---')fdmm.port={}do
FDMMPort={}FDMMPort.__index=FDMMPort
setmetatable(FDMMPort,{__call=function(e,...)return e.new(...)end,})function FDMMPort.new(r,i,n)local e=setmetatable({},FDMMPort)e.name=r
e.centerPoint=i
e.territoryName=n
return e
end
function FDMMPort:buildPort()end
end
do
end
env.info('---FDMM_Port End---')end)__DISTILLER:define("FDMM_FARP",function(e)env.info('---FDMM_FARP Start---')fdmm.farp={}do
FDMMFARP={}FDMMFARP.__index=FDMMFARP
setmetatable(FDMMFARP,{__call=function(e,...)return e.new(...)end,})function FDMMFARP.new(n,i,r)local e=setmetatable({},FDMMFARP)e.name=n
e.centerPoint=i
e.territoryName=r
return e
end
function FDMMFARP:buildFARP()end
end
do
end
env.info('---FDMM_FARP End---')end)__DISTILLER:define("FDMM_OilRefinery",function(e)env.info('---FDMM_OilRefinery Start---')fdmm.oilRefinery={}do
FDMMOilRefinery={}FDMMOilRefinery.__index=FDMMOilRefinery
setmetatable(FDMMOilRefinery,{__call=function(e,...)return e.new(...)end,})function FDMMOilRefinery.new(i,r,n)local e=setmetatable({},FDMMOilRefinery)e.name=i
e.centerPoint=r
e.territoryName=n
return e
end
function FDMMOilRefinery:buildOilRefinery()end
end
do
end
env.info('---FDMM_OilRefinery End---')end)__DISTILLER:define("FDMM_ArmsPlant",function(e)env.info('---FDMM_ArmsPlant Start---')fdmm.armsPlant={}do
FDMMArmsPlant={}FDMMArmsPlant.__index=FDMMArmsPlant
setmetatable(FDMMArmsPlant,{__call=function(e,...)return e.new(...)end,})function FDMMArmsPlant.new(r,i,n)local e=setmetatable({},FDMMArmsPlant)e.name=r
e.centerPoint=i
e.territoryName=n
return e
end
function FDMMArmsPlant:buildArmsPlant()end
end
do
end
env.info('---FDMM_ArmsPlant End---')end)__DISTILLER:define("FDMM_CargoRoute",function(e)env.info('---FDMM_CargoRoute Start---')fdmm.cargoRoute={}do
FDMMCargoRoute={}FDMMCargoRoute.__index=FDMMCargoRoute
setmetatable(FDMMCargoRoute,{__call=function(e,...)return e.new(...)end,})function FDMMCargoRoute.new(n,i)local e=setmetatable({},FDMMCargoRoute)e.territoryName=n
e.routeType=i
e.startLocations={}e.warehouseLocations={}e.directionalLinks={}return e
end
function FDMMCargoRoute:addStartLocation(i,n,e)table.insert(self.startLocations,{spawnFaction=i,spawnPoint=n,egressPoints=e or{}})end
function FDMMCargoRoute:addWarehouseLocation(e,i,n)table.insert(self.warehouseLocations,{warehouseName=e,warehousePoint=i,ingressPoints=n or{}})end
function FDMMCargoRoute:addDirectionalLink(i,n,e)table.insert(self.directionalLinks,{directionName=i,navigationPoint=n,ingressPoints=e or{}})end
function FDMMCargoRoute:getOutboundRouteFromStart(e)end
function FDMMCargoRoute:getInboundRouteToWarehouse(e)end
function FDMMCargoRoute:getOutboundRouteFromWarehouse(e)end
function FDMMCargoRoute:getClosestDirectionalLinkageToOutsidePoint(e)end
end
do
function fdmm.cargoRoute.createCargoRoutes()fdmm.cargoRoutes={}for e,n in pairs(fdmm.territories.all)do
fdmm.cargoRoutes[e]={[fdmm.enums.CargoRouteType.Land]=FDMMCargoRoute.new(e,fdmm.enums.CargoRouteType.Land),[fdmm.enums.CargoRouteType.Train]=FDMMCargoRoute.new(e,fdmm.enums.CargoRouteType.Train),[fdmm.enums.CargoRouteType.Air]=FDMMCargoRoute.new(e,fdmm.enums.CargoRouteType.Air),[fdmm.enums.CargoRouteType.Sea]=FDMMCargoRoute.new(e,fdmm.enums.CargoRouteType.Sea)}end
local u={[fdmm.consts.CargoRoutePrefix.Land]=fdmm.config.gpCache[fdmm.consts.CargoRoutePrefix.Land]or{},[fdmm.consts.CargoRoutePrefix.Train]=fdmm.config.gpCache[fdmm.consts.CargoRoutePrefix.Train]or{},[fdmm.consts.CargoRoutePrefix.Air]=fdmm.config.gpCache[fdmm.consts.CargoRoutePrefix.Air]or{},[fdmm.consts.CargoRoutePrefix.Sea]=fdmm.config.gpCache[fdmm.consts.CargoRoutePrefix.Sea]or{}}function _processGroup(o,n,s)local e=fdmm.utils.removeNumericSuffix(fdmm.utils.removeGroupingPrefix(o))local i=fdmm.territories.all[e]if i~=nil then
local d=fdmm.cargoRoutes[e][s]local u=mist.getGroupRoute(o,false)local m=fdmm.utils.getFaction(string.notEmptyElse(n.units[1].unitName,n.country))local f=s:upperFirst()local n=nil
local e={Spawn='spawn',Warehouse='warehouse',Linkage='linkage',TBD='_'}local i,t,a=nil,nil,{}function _updateScanner(r,f)if n==e.TBD and r~=nil and r~=e.TBD then
n=r
elseif n~=nil and n~=e.TBD and r==e.TBD then
r=n
end
if n~=r or i~=f then
if n then
if n==e.Spawn then
if string.isNotEmpty(m)and t and a then
d:addStartLocation(m,t,a)else
env.error('Cargo '..s.." routing group '"..o.."' failed to parse spawn route '"..(i or'<nil>').."'.")end
elseif n==e.Warehouse then
if string.isNotEmpty(i)and t and a then
d:addWarehouseLocation(i,t,a)else
env.error('Cargo '..s.." routing group '"..o.."' failed to parse warehouse route '"..(i or'<nil>').."'.")end
elseif n==e.Linkage then
if string.isNotEmpty(i)and t and a then
d:addDirectionalLink(i,t,a)else
env.error('Cargo '..s.." routing group '"..o.."' failed to parse linkage route '"..(i or'<nil>').."'.")end
elseif n~=e.TBD then
env.error('Cargo '..s.." routing group '"..o.."' encountered unrecognized scan mode '"..(r or'<nil>').."'.")end
i,t,a=nil,nil,{}end
n=r
i=f
end
end
for d,n in ipairs(u)do
if string.isNotEmpty(n.name)then
local m,r,i=fdmm.utils.getGroupingComponentsWithSNC(n.name,fdmm.consts.CargoRoutePrefix,fdmm.consts.CargoRouteWPSuffix)if m==fdmm.consts.CargoRoutePrefix[f]then
if i==fdmm.consts.CargoRouteWPSuffix.Egress or
i==fdmm.consts.CargoRouteWPSuffix.Ingress then
_updateScanner(e.TBD,r)table.insert(a,fdmm.utils.rposFromRPoint(n))elseif i==fdmm.consts.CargoRouteWPSuffix.Spawn then
_updateScanner(e.Spawn,r)t=fdmm.utils.rposFromRPoint(n)elseif i==fdmm.consts.CargoRouteWPSuffix.Warehouse then
_updateScanner(e.Warehouse,r)t=fdmm.utils.rposFromRPoint(n)elseif i==fdmm.consts.CargoRouteWPSuffix.Linkage then
_updateScanner(e.Linkage,r)t=fdmm.utils.rposFromRPoint(n)elseif not(string.isEmpty(r)and string.isEmpty(i))then
env.error('Cargo '..s.." routing group '"..o.."' unknown WP '"..(n.name or'<nil>').."' at WP index "..d..'.')end
elseif m==fdmm.consts.CargoRouteWPPrefix[f].Spawn then
if string.isEmpty(i)then
_updateScanner(e.Spawn,r)t=fdmm.utils.rposFromRPoint(n)elseif i==fdmm.consts.CargoRouteWPSuffix.EgressPoint then
_updateScanner(e.Spawn,r)table.insert(a,fdmm.utils.rposFromRPoint(n))elseif not(string.isEmpty(r)and string.isEmpty(i))then
env.error('Cargo '..s.." routing group '"..o.."' unknown spawn WP '"..(n.name or'<nil>').."' at WP index "..d..'.')end
elseif m==fdmm.consts.CargoRouteWPPrefix[f].Warehouse then
if string.isEmpty(i)then
_updateScanner(e.Warehouse,r)t=fdmm.utils.rposFromRPoint(n)elseif i==fdmm.consts.CargoRouteWPSuffix.IngressPoint then
_updateScanner(e.Warehouse,r)table.insert(a,fdmm.utils.rposFromRPoint(n))elseif not(string.isEmpty(r)and string.isEmpty(i))then
env.error('Cargo '..s.." routing group '"..o.."' unknown warehouse WP '"..(n.name or'<nil>').."' at WP index "..d..'.')end
elseif m==fdmm.consts.CargoRouteWPPrefix[f].Linkage then
if string.isEmpty(i)then
_updateScanner(e.Linkage,r)t=fdmm.utils.rposFromRPoint(n)elseif i==fdmm.consts.CargoRouteWPSuffix.IngressPoint then
_updateScanner(e.Linkage,r)table.insert(a,fdmm.utils.rposFromRPoint(n))elseif not(string.isEmpty(r)and string.isEmpty(i))then
env.error('Cargo '..s.." routing group '"..o.."' unknown linkage WP '"..(n.name or'<nil>').."' at WP index "..d..'.')end
else
env.error('Cargo '..s.." routing group '"..o.."' unknown routing WP '"..(n.name or'<nil>').."' at WP index "..d..'.')end
end
end
_updateScanner(nil,nil)else
env.error('Cargo '..s.." routing group '"..o.."' failed to find territory with same name.")end
end
for e,n in pairs(u[fdmm.consts.CargoRoutePrefix.Land])do
_processGroup(e,n,fdmm.enums.CargoRouteType.Land)end
for n,e in pairs(u[fdmm.consts.CargoRoutePrefix.Train])do
_processGroup(n,e,fdmm.enums.CargoRouteType.Train)end
for e,n in pairs(u[fdmm.consts.CargoRoutePrefix.Air])do
_processGroup(e,n,fdmm.enums.CargoRouteType.Air)end
for e,n in pairs(u[fdmm.consts.CargoRoutePrefix.Sea])do
_processGroup(e,n,fdmm.enums.CargoRouteType.Sea)end
end
end
env.info('---FDMM_CargoRoute End---')end)__DISTILLER:define("FDMM_MissionStart.lua_distilled",function(e)env.info('---FDMM_MissionStart Start---')env.setErrorMessageBoxEnabled(false)fdmm={}e('FDMM_Config')e('FDMM_LuaAdditions')e('FDMM_MISTAdditions')e('FDMM_MOOSEAdditions')e('FDMM_Utils')e('FDMM_Territory')e('FDMM_Port')e('FDMM_FARP')e('FDMM_OilRefinery')e('FDMM_ArmsPlant')e('FDMM_CargoRoute')do
fdmm.config.createGPCache()fdmm.territory.createTerritories()fdmm.cargoRoute.createCargoRoutes()fdmm.territory.buildFacilities()trigger.action.outText('FDMM Started',10)end
env.info('---FDMM_MissionStart End---')end)__DISTILLER:exec("FDMM_MissionStart.lua_distilled")