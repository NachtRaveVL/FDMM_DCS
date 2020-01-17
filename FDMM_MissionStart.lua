if __DISTILLER==nil then
__DISTILLER=nil
__DISTILLER={FACTORIES={},__nativeRequire=require,require=function(e)assert(type(e)=="string","require invalid id:"..tostring(e))if package.loaded[e]then
return package.loaded[e]end
if __DISTILLER.FACTORIES[e]then
local r=__DISTILLER.FACTORIES[e]package.loaded[e]=r(__DISTILLER.require)or true
return package.loaded[e]end
return __DISTILLER.__nativeRequire(e)end,define=function(n,e,r)assert(type(e)=="string","invalid id:"..tostring(e))assert(type(r)=="function","invalid factory:"..tostring(r))if package.loaded[e]==nil and n.FACTORIES[e]==nil then
n.FACTORIES[e]=r
else
print("[__DISTILLER::define] module "..tostring(e).." is already defined")end
end,exec=function(e,r)local e=e.FACTORIES[r]assert(e,"missing factory method for id "..tostring(r))e(__DISTILLER.require)end}end
__DISTILLER:define("FDMM_Config",function(e)env.info("---FDMM_Config Start---");fdmm.enums={}fdmm.consts={}do
fdmm.consts.UserFlags={DebugFlag='99999'}fdmm.enums.TerritoryType={Land='land',Sea='sea',All='all'}fdmm.consts.TerritoryPrefix={Define='TDEF_',Link='TLNK_',FARP='TFRP_'}fdmm.enums.CargoRouteType={Land='land',Train='train',Air='air',Sea='sea',All='all'}fdmm.consts.CargoRoutePrefix={Land='CVIN_',Train='CTIN_',Air='CAIN_',Sea='CSIN_'}end
env.info("---FDMM_Config End---");end)__DISTILLER:define("FDMM_MISTAdditions",function(e)env.info('---FDMM_MISTAdditions Start---')assert(mist,'MIST not initialized.')do
mist.DBs.Category={Vehicle='vehicle',Ship='ship',Plane='plane',Helicopter='helicopter',Building='building',Unknown='unknown'}function mist.utils.get2DDistSqrd(e,r)e=mist.utils.makeVec3(e)r=mist.utils.makeVec3(r)return mist.vec.magSqrd({x=e.x-r.x,y=0,z=e.z-r.z})end
function mist.utils.get3DDistSqrd(r,e)return mist.vec.magSqrd({x=r.x-e.x,y=r.y-e.y,z=r.z-e.z})end
function mist.vec.magSqrd(e)return(e.x^2+e.y^2+e.z^2)end
end
env.info('---FDMM_MISTAdditions End---')end)__DISTILLER:define("FDMM_MooseAdditions",function(e)env.info('---FDMM_MooseAdditions Start---')assert(routines,'Moose not initialized.')do
function routines.utils.get2DDistSqrd(r,e)r=routines.utils.makeVec3(r)e=routines.utils.makeVec3(e)return routines.vec.magSqrd({x=r.x-e.x,y=0,z=r.z-e.z})end
function routines.utils.get3DDistSqrd(r,e)return routines.vec.magSqrd({x=r.x-e.x,y=r.y-e.y,z=r.z-e.z})end
routines.vec.magSqrd=function(e)return(e.x^2+e.y^2+e.z^2)end
end
env.info('---FDMM_MooseAdditions End---')end)__DISTILLER:define("FDMM_Utils",function(e)env.info("---FDMM_Utils Start---");do
fdmm.utils={}function fdmm.utils.pos2ToLoggableString(e)return'~{'..mist.utils.round(e.x,-2)..','..mist.utils.round(e.y,-2)..'}'end
function fdmm.utils.pos3ToLoggableString(e)return'~{'..mist.utils.round(e.x,-2)..','..mist.utils.round(e.z,-2)..',a:'..mist.utils.round(e.y,-1)..'}'end
function fdmm.utils.isUserFlagSet(e)local e=trigger.misc.getUserFlag(e)return(type(e)=='number'and e~=0)or(type(e)=='boolean'and e~=false)or(type(e)=='string'and e~='false'and e~='0'and e~='no')end
function fdmm.utils.isDebugFlagSet()return fdmm.utils.isUserFlagSet(fdmm.consts.UserFlags.DebugFlag)end
end
env.info("---FDMM_Utils End---");end)__DISTILLER:define("FDMM_Territory",function(e)env.info('---FDMM_Territory Start---')fdmm.territory={}do
FDMMTerritory={}FDMMTerritory.__index=FDMMTerritory
setmetatable(FDMMTerritory,{__call=function(e,...)return e.new(...)end,})function FDMMTerritory.new(r,n)local e=setmetatable({},FDMMTerritory)e.groupName=r
e.groupData=n or mist.DBs.groupsByName[r]e.name=e.groupName:sub(#fdmm.consts.TerritoryPrefix.Define+1)if e.groupData.category==mist.DBs.Category.Ship then
e.type=fdmm.enums.TerritoryType.Sea
else
e.type=fdmm.enums.TerritoryType.Land
end
e.polygonPoints={}local i=mist.getGroupPoints(r)for n,r in ipairs(i)do
if n>1 and n<#i then
table.insert(e.polygonPoints,r)elseif n==1 then
e.centerPoint=r
else
e.capturePoint=r
end
end
e.linkedTerritories={}e.linkedTerritoryDistances={}e.farpPoints={}return e
end
function FDMMTerritory:addTerritoryLink(e)if self.name~=e.name then
self.linkedTerritories[e.name]=e
e.linkedTerritories[self.name]=self
local r=mist.utils.get2DDist(self.centerPoint,e.centerPoint)self.linkedTerritoryDistances[e.name]=r
e.linkedTerritoryDistances[self.name]=r
else
env.error("Cannot link territory '"..self.name.."' with itself.")end
end
function FDMMTerritory:addFARPPoints(e)for r,e in ipairs(e)do
if r>1 then
table.insert(self.farpPoints,e)end
end
end
function FDMMTerritory:smokeBoundaries(o)local s=10000./25.
local n=nil
for e,t in ipairs(self.polygonPoints)do
if e>1 then
local e=mist.utils.makeVec3(t)local e=mist.vec.sub(e,n)local r=mist.vec.mag(e)local t=mist.vec.scalarMult(e,1./r)local e=1
local i=r/e
while i>s do
e=e+1
i=r/e
end
while e>=0 do
local r=mist.vec.scalarMult(t,e*i)local r=mist.vec.add(n,r);COORDINATE:NewFromVec2(mist.utils.makeVec2(r)):Smoke(o)e=e-1
end
end
n=mist.utils.makeVec3(t)end
end
end
do
function fdmm.territory.createTerritories()fdmm.territories={[fdmm.enums.TerritoryType.Land]={},[fdmm.enums.TerritoryType.Sea]={},[fdmm.enums.TerritoryType.All]={}}local r={[fdmm.consts.TerritoryPrefix.Define]={},[fdmm.consts.TerritoryPrefix.Link]={},[fdmm.consts.TerritoryPrefix.FARP]={}}for e,n in pairs(mist.DBs.groupsByName)do
if e:find('_')~=nil then
if e:find(fdmm.consts.TerritoryPrefix.Define)==1 then
r[fdmm.consts.TerritoryPrefix.Define][e]=n
elseif e:find(fdmm.consts.TerritoryPrefix.Link)==1 then
r[fdmm.consts.TerritoryPrefix.Link][e]=n
elseif e:find(fdmm.consts.TerritoryPrefix.FARP)==1 then
r[fdmm.consts.TerritoryPrefix.FARP][e]=n
end
end
end
for r,e in pairs(r[fdmm.consts.TerritoryPrefix.Define])do
local e=FDMMTerritory(r,e)fdmm.territories[e.type][e.name]=e
fdmm.territories.all[e.name]=e
end
for e,r in pairs(r[fdmm.consts.TerritoryPrefix.Link])do
local r=e:sub(#fdmm.consts.TerritoryPrefix.Link+1)local r=fdmm.territories.all[r]if r~=nil then
for i,n in ipairs(mist.getGroupPoints(e))do
if i>1 then
local n=fdmm.territory.closestTerritoryToPoint(n,r.type)if n~=nil then
r:addTerritoryLink(n)else
env.error("Territory link for group '"..e.."' failed to find a closest territory at index "..i..'.')end
end
end
else
env.error("Territory link for group '"..e.."' failed to find territory with same name.")end
end
for e,r in pairs(r[fdmm.consts.TerritoryPrefix.FARP])do
local r=e:sub(#fdmm.consts.TerritoryPrefix.FARP+1)local r=fdmm.territories.all[r]if r~=nil then
r:addFARPPoints(mist.getGroupPoints(e))else
env.error("Territory FARP for group '"..e.."' failed to find territory with same name.")end
end
end
function fdmm.territory.closestTerritoryToPoint(e,r)local t=mist.utils.makeVec2(e)local e=nil
local i=0
local r=r or fdmm.enums.TerritoryType.All
local r=fdmm.territories[r]for r,n in pairs(r)do
local r=mist.utils.get2DDistSqrd(t,n.centerPoint)if e==nil or r<i then
e=n
i=r
end
end
return e
end
function fdmm.territory.dumpTerritories()function _envInfoTerritory(r,e)env.info("    '"..r.."':")env.info('      '..'centerPoint: '..fdmm.utils.pos2ToLoggableString(e.centerPoint))env.info('      '..'capturePoint: '..fdmm.utils.pos2ToLoggableString(e.capturePoint))for e,r in pairs(e.linkedTerritories)do
env.info('      '.."Linked /w: '"..e.."'.")end
end
env.info('--FDMM Territories Dump--')env.info('  Sea Territories:')for e,r in pairs(fdmm.territories.sea)do
_envInfoTerritory(e,r)end
env.info('  Land Territories:')for e,r in pairs(fdmm.territories.land)do
_envInfoTerritory(e,r)end
end
end
env.info('---FDMM_Territory End---')end)__DISTILLER:define("FDMM_Port",function(e)env.info('---FDMM_Port Start---')fdmm.port={}do
end
env.info('---FDMM_Port End---')end)__DISTILLER:define("FDMM_CargoRoute",function(e)env.info('---FDMM_CargoRoute Start---')fdmm.cargoRoute={}do
FDMMCargoRoute={}FDMMCargoRoute.__index=FDMMCargoRoute
setmetatable(FDMMCargoRoute,{__call=function(e,...)return e.new(...)end,})function FDMMCargoRoute.new(r)local e=setmetatable({},FDMMCargoRoute)e.territory=r
end
function FDMMCargoRoute:addSpawnPoint(e,e,e)end
function FDMMCargoRoute:addDirectionalLink(e,e)end
function FDMMCargoRoute:addWarehouseDest(e,e,e)end
end
do
function fdmm.cargoRoute.createCargoRoutes()fdmm.cargoRoutes={}for e,r in pairs(fdmm.territories.all)do
fdmm.cargoRoutes[e]={[fdmm.enums.CargoRouteType.Land]={},[fdmm.enums.CargoRouteType.Train]={},[fdmm.enums.CargoRouteType.Air]={},[fdmm.enums.CargoRouteType.Sea]={},[fdmm.enums.CargoRouteType.All]={}}end
local r={[fdmm.consts.CargoRoutePrefix.Land]={},[fdmm.consts.CargoRoutePrefix.Train]={},[fdmm.consts.CargoRoutePrefix.Air]={},[fdmm.consts.CargoRoutePrefix.Sea]={}}for e,n in pairs(mist.DBs.groupsByName)do
if e:find('_')~=nil then
if e:find(fdmm.consts.CargoRoutePrefix.Land)==1 then
r[fdmm.consts.CargoRoutePrefix.Land][e]=n
elseif e:find(fdmm.consts.CargoRoutePrefix.Train)==1 then
r[fdmm.consts.CargoRoutePrefix.Train][e]=n
elseif e:find(fdmm.consts.CargoRoutePrefix.Air)==1 then
r[fdmm.consts.CargoRoutePrefix.Air][e]=n
elseif e:find(fdmm.consts.CargoRoutePrefix.Sea)==1 then
r[fdmm.consts.CargoRoutePrefix.Sea][e]=n
end
end
end
for e,e in pairs(r[fdmm.consts.CargoRoutePrefix.Land])do
end
for e,e in pairs(r[fdmm.consts.CargoRoutePrefix.Train])do
end
for e,e in pairs(r[fdmm.consts.CargoRoutePrefix.Air])do
end
for e,e in pairs(r[fdmm.consts.CargoRoutePrefix.Sea])do
end
end
end
env.info('---FDMM_CargoRoute End---')end)__DISTILLER:define("FDMM_MissionStart.lua_distilled",function(e)env.info('---FDMM_MissionStart Start---')env.setErrorMessageBoxEnabled(false)fdmm={}e('FDMM_Config')e('FDMM_MISTAdditions')e('FDMM_MooseAdditions')e('FDMM_Utils')e('FDMM_Territory')e('FDMM_Port')e('FDMM_CargoRoute')do
fdmm.territory.createTerritories()fdmm.cargoRoute.createCargoRoutes()trigger.action.outText('FDMM Started',10)end
env.info('---FDMM_MissionStart End---')end)__DISTILLER:exec("FDMM_MissionStart.lua_distilled")