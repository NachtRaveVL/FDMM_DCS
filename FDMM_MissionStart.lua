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
end,exec=function(n,e)local n=n.FACTORIES[e]assert(n,"missing factory method for id "..tostring(e))n(__DISTILLER.require)end}end
__DISTILLER:define("FDMM_Config",function(e)env.info("---FDMM_Config Start---");fdmm.enums={}fdmm.consts={}fdmm.config={}do
fdmm.consts.UserFlags={DebugFlag='99999'}fdmm.enums.TerritoryType={Land='land',Sea='sea',All='all'}fdmm.consts.TerritoryPrefix={Define='TDEF_',Link='TLNK_',FARP='TFRP_'}fdmm.enums.CargoRouteType={Land='land',Train='train',Air='air',Sea='sea',All='all'}fdmm.consts.CargoRoutePrefix={Land='CVIN_',Train='CTIN_',Air='CAIN_',Sea='CSIN_'}function fdmm.config.createGPCache()fdmm.config.gpCache={}for n,i in pairs(mist.DBs.groupsByName)do
local e=fdmm.utils.getGroupingPrefix(n)if e~=nil then
if not fdmm.config.gpCache[e]then
fdmm.config.gpCache[e]={}end
fdmm.config.gpCache[e][n]=i
end
end
end
end
env.info("---FDMM_Config End---");end)__DISTILLER:define("FDMM_MISTAdditions",function(e)env.info('---FDMM_MISTAdditions Start---')assert(mist,'MIST not initialized.')do
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
function fdmm.utils.getGroupingPrefix(e)local n=string.find(e,'_')if n~=nil then
local e=e:sub(1,n)if e==e:upper()then
return e
end
end
return nil
end
function fdmm.utils.removeGroupingPrefix(e)local n=fdmm.utils.getGroupingPrefix(e)if n~=nil then
return e:sub(#n+1)end
return e
end
function fdmm.utils.getNumericSuffix(n)local i,e=n:reverse():find('# ')if e~=nil then
local e=n:sub(-e)if e==e:match(' #[%d]+')then
return e
end
end
return nil
end
function fdmm.utils.removeNumericSuffix(e)local n=fdmm.utils.getNumericSuffix(e)if n~=nil then
return e:sub(1,-#n-1)end
return e
end
function fdmm.utils.getGroupingSuffix(e)local n=e:reverse():find('_')if n~=nil then
return e:sub(-n)end
return nil
end
function fdmm.utils.removeGroupingSuffix(e)local n=fdmm.utils.getGroupingSuffix(e)if n~=nil then
return e:sub(1,-#n-1)end
return e
end
function fdmm.utils.isUserFlagSet(e)local e=trigger.misc.getUserFlag(e)return(type(e)=='number'and e~=0)or(type(e)=='boolean'and e~=false)or(type(e)=='string'and e:lower()~='false'and e~='0'and e:lower()~='no')end
function fdmm.utils.isDebugFlagSet()return fdmm.utils.isUserFlagSet(fdmm.consts.UserFlags.DebugFlag)end
end
env.info("---FDMM_Utils End---");end)__DISTILLER:define("FDMM_Territory",function(e)env.info('---FDMM_Territory Start---')fdmm.territory={}do
FDMMTerritory={}FDMMTerritory.__index=FDMMTerritory
setmetatable(FDMMTerritory,{__call=function(e,...)return e.newFromGroup(...)end,})function FDMMTerritory.newFromGroup(n,i)local e=setmetatable({},FDMMTerritory)e.groupName=n
e.groupData=i or mist.DBs.groupsByName[n]e.name=fdmm.utils.removeGroupingPrefix(n)if e.groupData.category==mist.DBs.Category.Ship then
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
e.polygonZone=ZONE_POLYGON:NewFromPoints(e.name,e.polygonPoints)e.linkedTerritories={}e.linkedTerritoryDistances={}return e
end
function FDMMTerritory:addTerritoryLink(e)if self.name~=e.name then
self.linkedTerritories[e.name]=e
e.linkedTerritories[self.name]=self
local n=mist.utils.get2DDist(self.centerPoint,e.centerPoint)self.linkedTerritoryDistances[e.name]=n
e.linkedTerritoryDistances[self.name]=n
else
env.error("Cannot link territory '"..self.name.."' with itself.")end
end
function FDMMTerritory:addFARP(e)end
function FDMMTerritory:smokeBoundaries(i)i=i or SMOKECOLOR.Blue
local d=10000./25.
local n=nil
for e,o in ipairs(self.polygonPoints)do
if e>1 then
local e=mist.utils.makeVec3(o)local e=mist.vec.sub(e,n)local t=mist.vec.mag(e)local o=mist.vec.scalarMult(e,1./t)local e=1
local r=t/e
while r>d do
e=e+1
r=t/e
end
while e>=0 do
local r=mist.vec.scalarMult(o,e*r)local n=mist.vec.add(n,r);COORDINATE:NewFromVec2(mist.utils.makeVec2(n)):Smoke(i)e=e-1
end
end
n=mist.utils.makeVec3(o)end
end
end
do
function fdmm.territory.createTerritories()fdmm.territories={[fdmm.enums.TerritoryType.Land]={},[fdmm.enums.TerritoryType.Sea]={},[fdmm.enums.TerritoryType.All]={}}local n={[fdmm.consts.TerritoryPrefix.Define]=fdmm.config.gpCache[fdmm.consts.TerritoryPrefix.Define]or{},[fdmm.consts.TerritoryPrefix.Link]=fdmm.config.gpCache[fdmm.consts.TerritoryPrefix.Link]or{},[fdmm.consts.TerritoryPrefix.FARP]=fdmm.config.gpCache[fdmm.consts.TerritoryPrefix.FARP]or{}}for n,e in pairs(n[fdmm.consts.TerritoryPrefix.Define])do
local e=FDMMTerritory.newFromGroup(n,e)fdmm.territories[e.type][e.name]=e
fdmm.territories.all[e.name]=e
end
for e,n in pairs(n[fdmm.consts.TerritoryPrefix.Link])do
local n=fdmm.utils.removeGroupingPrefix(e)local n=fdmm.territories.all[n]if n~=nil then
for i,r in ipairs(mist.getGroupPoints(e))do
if i>1 then
local r=fdmm.territory.closestTerritoryToPoint(r,n.type)if r~=nil then
n:addTerritoryLink(r)else
env.error("Territory link for group '"..e.."' failed to find a closest territory at index "..i..'.')end
end
end
else
env.error("Territory link for group '"..e.."' failed to find territory with same name.")end
end
for e,n in pairs(n[fdmm.consts.TerritoryPrefix.FARP])do
local n=fdmm.utils.removeGroupingPrefix(e)local n=fdmm.territories.all[n]if n~=nil then
for e,e in ipairs(mist.getGroupPoints(e))do
end
else
env.error("Territory FARP for group '"..e.."' failed to find territory with same name.")end
end
end
function fdmm.territory.closestTerritoryToPoint(e,n)local r=mist.utils.makeVec2(e)local e=nil
local i=0
local n=n or fdmm.enums.TerritoryType.All
local n=fdmm.territories[n]for t,n in pairs(n)do
local r=mist.utils.get2DDistSqrd(r,n.centerPoint)if e==nil or r<i then
e=n
i=r
end
end
return e
end
function fdmm.territory.dumpTerritories()function _envInfoTerritory(n,e)env.info("    '"..n.."':")env.info('      '..'centerPoint: '..fdmm.utils.pos2ToLoggableString(e.centerPoint))env.info('      '..'capturePoint: '..fdmm.utils.pos2ToLoggableString(e.capturePoint))for e,n in pairs(e.linkedTerritories)do
env.info('      '.."Linked /w: '"..e.."'.")end
end
env.info('--FDMM Territories Dump--')env.info('  Sea Territories:')for e,n in pairs(fdmm.territories.sea)do
_envInfoTerritory(e,n)end
env.info('  Land Territories:')for e,n in pairs(fdmm.territories.land)do
_envInfoTerritory(e,n)end
end
end
env.info('---FDMM_Territory End---')end)__DISTILLER:define("FDMM_Port",function(e)env.info('---FDMM_Port Start---')fdmm.port={}do
end
env.info('---FDMM_Port End---')end)__DISTILLER:define("FDMM_FARP",function(e)env.info('---FDMM_FARP Start---')fdmm.farp={}do
FDMMFARP={}FDMMFARP.__index=FDMMFARP
setmetatable(FDMMFARP,{__call=function(e,...)return e.new(...)end,})function FDMMFARP.new(i,n)local e=setmetatable({},FDMMFARP)e.name=i
e.territory=n
end
end
do
function fdmm.farp.createFARPs()end
end
env.info('---FDMM_FARP End---')end)__DISTILLER:define("FDMM_CargoRoute",function(e)env.info('---FDMM_CargoRoute Start---')fdmm.cargoRoute={}do
FDMMCargoRoute={}FDMMCargoRoute.__index=FDMMCargoRoute
setmetatable(FDMMCargoRoute,{__call=function(e,...)return e.new(...)end,})function FDMMCargoRoute.new(e)local n=setmetatable({},FDMMCargoRoute)n.territory=e
end
function FDMMCargoRoute:addSpawnPoint(e,e,e)end
function FDMMCargoRoute:addDirectionalLink(e,e)end
function FDMMCargoRoute:addWarehouseDest(e,e,e)end
end
do
function fdmm.cargoRoute.createCargoRoutes()fdmm.cargoRoutes={}for e,n in pairs(fdmm.territories.all)do
fdmm.cargoRoutes[e]={[fdmm.enums.CargoRouteType.Land]={},[fdmm.enums.CargoRouteType.Train]={},[fdmm.enums.CargoRouteType.Air]={},[fdmm.enums.CargoRouteType.Sea]={},[fdmm.enums.CargoRouteType.All]={}}end
local e={[fdmm.consts.CargoRoutePrefix.Land]=fdmm.config.gpCache[fdmm.consts.CargoRoutePrefix.Land]or{},[fdmm.consts.CargoRoutePrefix.Train]=fdmm.config.gpCache[fdmm.consts.CargoRoutePrefix.Train]or{},[fdmm.consts.CargoRoutePrefix.Air]=fdmm.config.gpCache[fdmm.consts.CargoRoutePrefix.Air]or{},[fdmm.consts.CargoRoutePrefix.Sea]=fdmm.config.gpCache[fdmm.consts.CargoRoutePrefix.Sea]or{}}for e,e in pairs(e[fdmm.consts.CargoRoutePrefix.Land])do
end
for e,e in pairs(e[fdmm.consts.CargoRoutePrefix.Train])do
end
for e,e in pairs(e[fdmm.consts.CargoRoutePrefix.Air])do
end
for e,e in pairs(e[fdmm.consts.CargoRoutePrefix.Sea])do
end
end
end
env.info('---FDMM_CargoRoute End---')end)__DISTILLER:define("FDMM_MissionStart.lua_distilled",function(e)env.info('---FDMM_MissionStart Start---')env.setErrorMessageBoxEnabled(false)fdmm={}e('FDMM_Config')e('FDMM_MISTAdditions')e('FDMM_MOOSEAdditions')e('FDMM_Utils')e('FDMM_Territory')e('FDMM_Port')e('FDMM_FARP')e('FDMM_CargoRoute')do
fdmm.config.createGPCache()fdmm.territory.createTerritories()fdmm.cargoRoute.createCargoRoutes()fdmm.farp.createFARPs()trigger.action.outText('FDMM Started',10)end
env.info('---FDMM_MissionStart End---')end)__DISTILLER:exec("FDMM_MissionStart.lua_distilled")