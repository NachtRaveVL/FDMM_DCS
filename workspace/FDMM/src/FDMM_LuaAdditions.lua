---
-- FDMM Lua Additions Module.
-- @module FDMM_LuaAdditions
env.info('---FDMM_LuaAdditions Start---')

do --FDMM_LuaAdditions

  --- Determines if string contains other string.
  -- @param #string str String.
  -- @param #string otherStr Other string.
  -- @return #boolean True if otherStr is found in str, otherwise false.
  function string.contains(str, otherStr)
    return string.find(str, otherStr) ~= nil
  end

  --- Determines if string has specified prefix.
  -- @param #string str String.
  -- @param #string prefix Prefix.
  -- @return #boolean True if str has prefix as its prefix, otherwise false.
  function string.hasPrefix(str, prefix)
    return string.sub(str, 1, #prefix) == prefix
  end

  --- Determines if string has specified suffix.
  -- @param #string str String.
  -- @param #string suffix Suffix.
  -- @return #boolean True if str has suffix as its suffix, otherwise false.
  function string.hasSuffix(str, suffix)
    return sring.sub(str, -#suffix) == suffix
  end

  --- Determines if string is nil or empty.
  -- @param #string str String.
  -- @return #boolean True if str is nil or empty string, otherwise false.
  function string.isEmpty(str)
    return str == nil or not #str
  end

  --- Determines if string is not nil nor empty.
  -- @param #string str String.
  -- @return #boolean True if str is neither nil nor empty, otherwise false.
  function string.isNotEmpty(str)
    return str ~= nil and #str
  end

  --- Returns string value if not nil nor empty, otherwise else string. Useful for defaulting values.
  -- @param #string str String.
  -- @param #string elseStr Else string to return if str is nil or empty.
  -- @return #string Returns str if not nil nor empty, otherwise returns elseStr.
  function string.notEmptyElse(str, elseStr)
    if str ~= nil and #str then return str end
    return elseStr
  end

  --- Returns string with first letter uppercased. Typically used for const/enum field resolution due to naming conventions.
  -- @param #string str String.
  -- @return #string Returns string with uppercased first letter.
  function string.upperFirst(str)
    return str:sub(1, 1):upper() .. str:sub(2)
  end

  --- Table contains value (O(n) time).
  -- @param #table tbl Table.
  -- @param #object value Value (type must implement __eq metamethod).
  -- @return True if value is found in table, otherwise false.
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
