---
-- FDMM Lua Additions Module.
-- @module FDMM_LuaAdditions
env.info('---FDMM_LuaAdditions Start---')

do --FDMM_LuaAdditions

  --- Determines if string contains other string.
  -- @param #string str String.
  -- @param #string otherStr Other string (non-pattern).
  -- @return #boolean True if otherStr is found in str, otherwise false.
  function string.contains(str, otherStr)
    return string.find(str, otherStr, 0, true) ~= nil
  end

  --- Determines if string has specified prefix.
  -- @param #string str String.
  -- @param #string prefix Prefix.
  -- @return #boolean True if str has prefix as its prefix, otherwise false.
  function string.hasPrefix(str, prefix)
    return string.sub(str, 1, #prefix) == prefix
  end

  --- Determines if string has any of the specified prefixes.
  -- @param #string str String.
  -- @param <#string> prefixList Prefix list.
  -- @return #boolean True if str has any prefix from prefixList, otherwise false.
  function string.hasAnyPrefix(str, prefixList)
    for _, prefix in pairs(prefixList) do
      if string.hasPrefix(str, prefix) then
        return true
      end
    end
    return false
  end

  --- Determines if string has specified suffix.
  -- @param #string str String.
  -- @param #string suffix Suffix.
  -- @return #boolean True if str has suffix as its suffix, otherwise false.
  function string.hasSuffix(str, suffix)
    return string.sub(str, -#suffix) == suffix
  end

  --- Determines if string has any of the specified suffixes.
  -- @param #string str String.
  -- @param <#string> suffixList Suffix list.
  -- @return #boolean True if str has any suffix from suffixList, otherwise false.
  function string.hasAnySuffix(str, suffixList)
    for _, suffix in pairs(suffixList) do
      if string.hasSuffix(str, suffix) then
        return true
      end
    end
    return false
  end

  --- Determines if string is nil or empty.
  -- @param #string str String.
  -- @return #boolean True if str is nil or empty string, otherwise false.
  function string.isEmpty(str)
    return str == nil or #str == 0
  end

  --- Determines if string is not nil nor empty.
  -- @param #string str String.
  -- @return #boolean True if str is neither nil nor empty, otherwise false.
  function string.isNotEmpty(str)
    return str ~= nil and #str > 0
  end

  --- Returns string value if not nil nor empty, otherwise else string. Useful for defaulting values.
  -- @param #string str String.
  -- @param #string elseStr Else string to return if str is nil or empty.
  -- @return #string Returns str if not nil nor empty, otherwise returns elseStr.
  function string.notEmptyElse(str, elseStr)
    if str ~= nil and #str > 0 then
      return str
    end
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
  -- @return #boolean True if value is found in table, otherwise false.
  function table.contains(tbl, value)
    for _,v in pairs(tbl) do
      if v == value then
        return true
      end
    end
    return false
  end

  --- Table concatination.
  -- Concatenates two tables into a new single table.
  -- @note Second table will overwrite keys in first.
  -- @param #table tbl1 First table.
  -- @param #table tbl2 Second table.
  -- @return #table First and second table merged.
  function table.concatedWith(tbl1, tbl2)
    local retVal = nil
    if tbl1 or tbl2 then
      retVal = {}
      if tbl1 then
        for k,v in pairs(tbl1) do
          retVal[k] = v
        end
      end
      if tbl2 then
        for k,v in pairs(tbl2) do
          retVal[k] = v
        end
      end
    end
    return retVal
  end

  --- Table concatination.
  -- Concatenates second table into first table.
  -- @note Second table will overwrite keys in first.
  -- @param #table tbl1 First table.
  -- @param #table tbl2 Second table.
  function table.concatWith(tbl1, tbl2)
    if tbl2 then
      for k,v in pairs(tbl2) do
        tbl1[k] = v
      end
    end
  end

  --- Table concatination (sequences).
  -- Concatenates two sequences into a new single sequence.
  -- @param #table seq1 First sequence.
  -- @param #table seq2 Second sequence.
  -- @return #table First and second sequences merged.
  function table.concatedWithi(seq1, seq2)
    local retVal = nil
    if seq1 or seq2 then
      retVal = {}
      if seq1 then
        for _,v in ipairs(seq1) do
          table.insert(retVal, v)
        end
      end
      if seq2 then
        for _,v in ipairs(seq2) do
          table.insert(retVal, v)
        end
      end
    end
    return retVal
  end

  --- Table concatination (sequences).
  -- Concatenates second sequence into first sequence.
  -- @param #table tbl1 First sequence.
  -- @param #table tbl2 Second sequence.
  function table.concatWithi(tbl1, tbl2)
    if tbl2 then
      for _,v in ipairs(tbl2) do
        table.insert(tbl1, v)
      end
    end
  end

  --- Table keys list.
  -- Produces sequence of keys from provided table.
  -- @param #table tbl Table.
  -- @return <#string> Keys sequence.
  function table.keysList(tbl)
    local retVal = {}
    for k,_ in pairs(tbl) do
      table.insert(retVal, k)
    end
    return retVal
  end

  --- Table sorted keys list.
  -- Produces sorted sequence of keys from provided table.
  -- @param #table tbl Table.
  -- @return <#string> Sorted keys sequence.
  function table.sortedKeysList(tbl)
    local retVal = table.keysList(tbl)
    table.sort(retVal)
    return retVal
  end

end --FDMM_LuaAdditions

env.info('---FDMM_LuaAdditions End---')
