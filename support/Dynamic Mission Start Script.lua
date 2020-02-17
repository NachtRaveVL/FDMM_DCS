do
    local __nativeRequire = require
    local __loadedModules = {}

    local splitFilename = function(strFilename)
      if lfs.attributes(strFilename,"mode") == "directory" then
        local strPath = strFilename:gsub("[\\/]$","")
        return strPath.."\\","",""
      end
      return (strFilename.."."):match("^(.-)([^\\/]-)%.([^\\/%.]-)%.?$")
    end

    require = function(moduleName)
      local fdmmFile = lfs.writedir()..fdmm_path.."workspace/FDMM/src/"..moduleName..".lua"
      local path, name, ext = splitFilename(moduleName)

      if package.loaded[moduleName] or package.loaded[name] then
      	return package.loaded[moduleName] or package.loaded[name]
      elseif __loadedModules[name] == nil then
        if lfs.attributes(fdmmFile) then
        	__loadedModules[name] = dofile(fdmmFile) or true
        elseif __nativeRequire then
          __loadedModules[name] = __nativeRequire(moduleName) or true
        end
      end
      return __loadedModules[name]
    end

    require("FDMM_MissionStart")

    require = __nativeRequire
end
