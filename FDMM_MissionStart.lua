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
end,exec=function(r,e)local r=r.FACTORIES[e]assert(r,"missing factory method for id "..tostring(e))r(__DISTILLER.require)end}end
__DISTILLER:define("FDMM_Config",function(e)env.info("---FDMM_Config Start---");fdmm.config={}do
fdmm.config.enums={}fdmm.config.enums.TerritoryType={Land=1,Sea=2}fdmm.config.consts={}fdmm.config.consts.TerritoryGroupPrefix='TERR_'fdmm.config.consts.TerritoryLinkPrefix='TLNK_'fdmm.config.consts.TerritoryFarpPrefix='TFRP_'end
env.info("---FDMM_Config End---");end)__DISTILLER:define("FDMM_MISTAdditions",function(e)env.info('---FDMM_MISTAdditions Start---')assert(mist,'MIST not initialized.')do
function mist.utils.get2DDistSqrd(r,e)r=mist.utils.makeVec3(r)e=mist.utils.makeVec3(e)return mist.vec.magSqrd({x=r.x-e.x,y=0,z=r.z-e.z})end
function mist.utils.get3DDistSqrd(e,r)return mist.vec.magSqrd({x=e.x-r.x,y=e.y-r.y,z=e.z-r.z})end
function mist.vec.magSqrd(e)return(e.x^2+e.y^2+e.z^2)end
end
env.info('---FDMM_MISTAdditions End---')end)__DISTILLER:define("FDMM_MooseAdditions",function(e)env.info('---FDMM_MooseAdditions Start---')assert(routines,'Moose not initialized.')do
function routines.utils.get2DDistSqrd(r,e)r=routines.utils.makeVec3(r)e=routines.utils.makeVec3(e)return routines.vec.magSqrd({x=r.x-e.x,y=0,z=r.z-e.z})end
function routines.utils.get3DDistSqrd(e,r)return routines.vec.magSqrd({x=e.x-r.x,y=e.y-r.y,z=e.z-r.z})end
routines.vec.magSqrd=function(e)return(e.x^2+e.y^2+e.z^2)end
end
env.info('---FDMM_MooseAdditions End---')end)__DISTILLER:define("FDMM_Territory",function(e)env.info('---FDMM_Territory Start---')fdmm.territory={}do
FDMMTerritory={}FDMMTerritory.__index=FDMMTerritory
setmetatable(FDMMTerritory,{__call=function(e,...)return e.new(...)end,})function FDMMTerritory.new(r,i)local e=setmetatable({},FDMMTerritory)e.groupName=r
e.groupData=i or mist.DBs.groupsByName[r]e.name=e.groupName:sub(#fdmm.config.consts.TerritoryGroupPrefix+1)if e.groupData.category=='ship'then
e.type=fdmm.config.enums.TerritoryType.Sea
else
e.type=fdmm.config.enums.TerritoryType.Land
end
e.polygonPoints={}local n=mist.getGroupPoints(r)for r,i in ipairs(n)do
if r>1 and r<#n then
table.insert(e.polygonPoints,i)elseif r==1 then
e.centerPoint=i
else
e.capturePoint=i
end
end
e.linkedTerritories={}return e
end
function FDMMTerritory:addTerritoryLink(e)if self.name~=e.name then
self.linkedTerritories[e.name]=e
e.linkedTerritories[self.name]=self
else
env.error("Cannot link territory '"..self.name.."' with itself.")end
end
end
do
fdmm.territory.landTerritories={}fdmm.territory.seaTerritories={}fdmm.territory.allTerritories={}function fdmm.territory.createTerritories()local n={}local i={}local t={}for e,r in pairs(mist.DBs.groupsByName)do
if e:find(fdmm.config.consts.TerritoryGroupPrefix)==1 then
n[e]=r
elseif e:find(fdmm.config.consts.TerritoryLinkPrefix)==1 then
i[e]=r
elseif e:find(fdmm.config.consts.TerritoryFarpPrefix)==1 then
t[e]=r
end
end
for e,r in pairs(n)do
local e=FDMMTerritory(e,r)if e.type==fdmm.config.enums.TerritoryType.Sea then
fdmm.territory.seaTerritories[e.name]=e
else
fdmm.territory.landTerritories[e.name]=e
end
fdmm.territory.allTerritories[e.name]=e
end
for e,r in pairs(i)do
local r=e:sub(#fdmm.config.consts.TerritoryLinkPrefix+1)local r=fdmm.territory.allTerritories[r]if r~=nil then
for i,n in ipairs(mist.getGroupPoints(e))do
if i>1 then
local n=fdmm.territory.closestTerritoryToPoint(n,r.type)if n~=nil then
r:addTerritoryLink(n)else
env.error("Territory group '"..e.."' failed to find a closest territory at index "..i..'.')end
end
end
else
env.error("Territory group '"..e.."' failed to find territory with same name.")end
end
end
function fdmm.territory.closestTerritoryToPoint(e,i)local t=mist.utils.makeVec2(e)local r=nil
local n=0
local e=nil
if(i==fdmm.config.enums.TerritoryType.Land)then
e=fdmm.territory.landTerritories
elseif(i==fdmm.config.enums.TerritoryType.Sea)then
e=fdmm.territory.seaTerritories
else
e=fdmm.territory.allTerritories
end
for e,i in pairs(e)do
local e=mist.utils.get2DDistSqrd(t,i.centerPoint)if r==nil or e<n then
r=i
n=e
end
end
return r
end
function fdmm.territory.dumpTerritories()env.info('--FDMM Territories Dump--')env.info('  Sea Territories:')for e,r in pairs(fdmm.territory.seaTerritories)do
env.info('    '..e..':')for e,r in pairs(r.linkedTerritories)do
env.info("      Linked /w: '"..e.."'.")end
end
env.info('  Land Territories:')for e,r in pairs(fdmm.territory.landTerritories)do
env.info('    '..e..':')for e,r in pairs(r.linkedTerritories)do
env.info("      Linked /w: '"..e.."'.")end
end
end
end
env.info('---FDMM_Territory End---')end)__DISTILLER:define("FDMM_Port",function(e)env.info('---FDMM_Port Start---')fdmm.port={}do
end
env.info('---FDMM_Port End---')end)__DISTILLER:define("FDMM_MissionStart.lua_distilled",function(e)env.info('---FDMM_MissionStart Start---')env.setErrorMessageBoxEnabled(false)fdmm={}e('FDMM_Config')e('FDMM_MISTAdditions')e('FDMM_MooseAdditions')e('FDMM_Territory')e('FDMM_Port')do
fdmm.territory.createTerritories()fdmm.territory.dumpTerritories()trigger.action.outText('FDMM Started',10)end
env.info('---FDMM_MissionStart End---')end)__DISTILLER:exec("FDMM_MissionStart.lua_distilled")