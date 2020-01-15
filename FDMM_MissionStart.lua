if __DISTILLER==nil then
__DISTILLER=nil
__DISTILLER={FACTORIES={},__nativeRequire=require,require=function(e)assert(type(e)=="string","require invalid id:"..tostring(e))if package.loaded[e]then
return package.loaded[e]end
if __DISTILLER.FACTORIES[e]then
local r=__DISTILLER.FACTORIES[e]package.loaded[e]=r(__DISTILLER.require)or true
return package.loaded[e]end
return __DISTILLER.__nativeRequire(e)end,define=function(i,e,r)assert(type(e)=="string","invalid id:"..tostring(e))assert(type(r)=="function","invalid factory:"..tostring(r))if package.loaded[e]==nil and i.FACTORIES[e]==nil then
i.FACTORIES[e]=r
else
print("[__DISTILLER::define] module "..tostring(e).." is already defined")end
end,exec=function(e,r)local e=e.FACTORIES[r]assert(e,"missing factory method for id "..tostring(r))e(__DISTILLER.require)end}end
__DISTILLER:define("FDMM_Config",function(e)env.info("---FDMM_Config Start---");fdmm.enums={}fdmm.consts={}do
fdmm.enums.TerritoryType={Land='land',Sea='sea'}fdmm.consts.UserFlags={DebugFlag='99999'}fdmm.consts.TerritoryPrefix={Define='TDEF_',Link='TLNK_',FARP='TFRP_'}end
env.info("---FDMM_Config End---");end)__DISTILLER:define("FDMM_MISTAdditions",function(e)env.info('---FDMM_MISTAdditions Start---')assert(mist,'MIST not initialized.')do
mist.DBs.Category={Vehicle='vehicle',Ship='ship',Plane='plane',Helicopter='helicopter',Building='building',Unknown='unknown'}function mist.utils.get2DDistSqrd(r,e)r=mist.utils.makeVec3(r)e=mist.utils.makeVec3(e)return mist.vec.magSqrd({x=r.x-e.x,y=0,z=r.z-e.z})end
function mist.utils.get3DDistSqrd(e,r)return mist.vec.magSqrd({x=e.x-r.x,y=e.y-r.y,z=e.z-r.z})end
function mist.vec.magSqrd(e)return(e.x^2+e.y^2+e.z^2)end
end
env.info('---FDMM_MISTAdditions End---')end)__DISTILLER:define("FDMM_MooseAdditions",function(e)env.info('---FDMM_MooseAdditions Start---')assert(routines,'Moose not initialized.')do
function routines.utils.get2DDistSqrd(e,r)e=routines.utils.makeVec3(e)r=routines.utils.makeVec3(r)return routines.vec.magSqrd({x=e.x-r.x,y=0,z=e.z-r.z})end
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
setmetatable(FDMMTerritory,{__call=function(e,...)return e.new(...)end,})function FDMMTerritory.new(r,i)local e=setmetatable({},FDMMTerritory)e.groupName=r
e.groupData=i or mist.DBs.groupsByName[r]e.name=e.groupName:sub(#fdmm.consts.TerritoryPrefix.Define+1)if e.groupData.category==mist.DBs.Category.Ship then
e.type=fdmm.enums.TerritoryType.Sea
else
e.type=fdmm.enums.TerritoryType.Land
end
e.polygonPoints={}local n=mist.getGroupPoints(r)for i,r in ipairs(n)do
if i>1 and i<#n then
table.insert(e.polygonPoints,r)elseif i==1 then
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
function FDMMTerritory:addFARPPoints(e)for e,r in ipairs(e)do
if e>1 then
table.insert(self.farpPoints,r)end
end
end
end
do
fdmm.territory.landTerritories={}fdmm.territory.seaTerritories={}fdmm.territory.allTerritories={}function fdmm.territory.clearTerritories()fdmm.territory.landTerritories={}fdmm.territory.seaTerritories={}fdmm.territory.allTerritories={}end
function fdmm.territory.createTerritories()fdmm.territory.clearTerritories()local i={}local t={}local n={}for e,r in pairs(mist.DBs.groupsByName)do
if e:find('_')~=nil then
if e:find(fdmm.consts.TerritoryPrefix.Define)==1 then
i[e]=r
elseif e:find(fdmm.consts.TerritoryPrefix.Link)==1 then
t[e]=r
elseif e:find(fdmm.consts.TerritoryPrefix.FARP)==1 then
n[e]=r
end
end
end
for e,r in pairs(i)do
local e=FDMMTerritory(e,r)if e.type==fdmm.enums.TerritoryType.Sea then
fdmm.territory.seaTerritories[e.name]=e
else
fdmm.territory.landTerritories[e.name]=e
end
fdmm.territory.allTerritories[e.name]=e
end
for e,r in pairs(t)do
local r=e:sub(#fdmm.consts.TerritoryPrefix.Link+1)local r=fdmm.territory.allTerritories[r]if r~=nil then
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
for e,r in pairs(n)do
local r=e:sub(#fdmm.consts.TerritoryPrefix.FARP+1)local r=fdmm.territory.allTerritories[r]if r~=nil then
r:addFARPPoints(mist.getGroupPoints(e))else
env.error("Territory FARP for group '"..e.."' failed to find territory with same name.")end
end
end
function fdmm.territory.closestTerritoryToPoint(e,i)local t=mist.utils.makeVec2(e)local r=nil
local n=0
local e=nil
if(i==fdmm.enums.TerritoryType.Land)then
e=fdmm.territory.landTerritories
elseif(i==fdmm.enums.TerritoryType.Sea)then
e=fdmm.territory.seaTerritories
else
e=fdmm.territory.allTerritories
end
for i,e in pairs(e)do
local i=mist.utils.get2DDistSqrd(t,e.centerPoint)if r==nil or i<n then
r=e
n=i
end
end
return r
end
function fdmm.territory.dumpTerritories()function _envInfoTerritory(r,e)env.info("    '"..r.."':")env.info('      '..'centerPoint: '..fdmm.utils.pos2ToLoggableString(e.centerPoint))env.info('      '..'capturePoint: '..fdmm.utils.pos2ToLoggableString(e.capturePoint))for e,r in pairs(e.linkedTerritories)do
env.info('      '.."Linked /w: '"..e.."'.")end
end
env.info('--FDMM Territories Dump--')env.info('  Sea Territories:')for r,e in pairs(fdmm.territory.seaTerritories)do
_envInfoTerritory(r,e)end
env.info('  Land Territories:')for e,r in pairs(fdmm.territory.landTerritories)do
_envInfoTerritory(e,r)end
end
end
env.info('---FDMM_Territory End---')end)__DISTILLER:define("FDMM_Port",function(e)env.info('---FDMM_Port Start---')fdmm.port={}do
end
env.info('---FDMM_Port End---')end)__DISTILLER:define("FDMM_MissionStart.lua_distilled",function(e)env.info('---FDMM_MissionStart Start---')env.setErrorMessageBoxEnabled(false)fdmm={}e('FDMM_Config')e('FDMM_MISTAdditions')e('FDMM_MooseAdditions')e('FDMM_Utils')e('FDMM_Territory')e('FDMM_Port')do
fdmm.territory.createTerritories()trigger.action.outText('FDMM Started',10)end
env.info('---FDMM_MissionStart End---')end)__DISTILLER:exec("FDMM_MissionStart.lua_distilled")