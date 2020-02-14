do
    local __nativeRequire = require
    local __loadedModules = {}

    require = function(module)
      if package.loaded[module] ~= nil then
      	return package.loaded[module]
      elseif __loadedModules[module] == nil then
      	__loadedModules[module] = dofile(lfs.writedir()..fdmm_path.."workspace/FDMM/src/"..module..".lua") or true
      end
      return __loadedModules[module]
    end

    require('FDMM_MissionStart')

    require = __nativeRequire
end
