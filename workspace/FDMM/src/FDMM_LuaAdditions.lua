---
-- FDMM Lua Additions Module.
-- @module FDMM_LuaAdditions
env.info('---FDMM_LuaAdditions Start---')

do --FDMM_LuaAdditions

  function string.contains(str, otherStr)
    return string.find(str, otherStr) ~= nil
  end

  function string.hasPrefix(str, prefix)
    return string.sub(str, 1, #prefix) == prefix
  end

  function string.hasSuffix(str, suffix)
    return sring.sub(str, -#suffix) == suffix
  end

  function string.isEmpty(str)
    return str == nil or not #str
  end

  function string.isNotEmpty(str)
    return str ~= nil and #str
  end

  function string.notEmptyElse(str, elseStr)
    if str ~= nil and #str then return str end
    return elseStr
  end

  function string.upperFirst(str)
    return str:sub(1,1):upper() .. str:sub(2)
  end

  function table.contains(tbl, value)
    for k,v in pairs(tbl) do
      if v == value then
        return true
      end
    end
    return false
  end

end --FDMM_LuaAdditions

env.info('---FDMM_LuaAdditions End---')
