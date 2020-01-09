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
__DISTILLER:define("FDMM_Config",function(e)env.info("---FDMM_Config Start---");do
end
env.info("---FDMM_Config End---");end)__DISTILLER:define("FDMM_PortOps",function(e)env.info("---FDMM_PortOps Start---");do
end
env.info("---FDMM_PortOps End---");end)__DISTILLER:define("FDMM_MissionStart.lua_distilled",function(e)env.setErrorMessageBoxEnabled(false);env.info("---FDMM_MissionStart Start---");e('FDMM_Config');e('FDMM_PortOps');do
trigger.action.outText("FDMM Started",10)end
env.info("---FDMM_MissionStart End---");end)__DISTILLER:exec("FDMM_MissionStart.lua_distilled")