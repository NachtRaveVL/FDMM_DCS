---
-- FDMM Utils Module.
-- @module FDMM_Utils
env.info("---FDMM_Utils Start---");

--- FDMM utilities module.
fdmm.utils = {}

do --FDMM_Utils

  --- Converts position to loggable string (two dimensional).
  -- @param DCS#Vec point Position.
  -- @return Loggable string of rounded position.
  function fdmm.utils.pos2ToLoggableString(point)
    if point.z ~= nil then point = mist.utils.makeVec2(point) end
    return '~{' .. mist.utils.round(point.x, -2) .. ',' .. mist.utils.round(point.y, -2) .. '}'
  end

  --- Converts position to loggable string (three dimensional).
  -- @param DCS#Vec point Position.
  -- @return Loggable string of rounded position.
  function fdmm.utils.pos3ToLoggableString(point)
    if point.z == nil then point = mist.utils.makeVec3(point) end
    return '~{' .. mist.utils.round(point.x, -2) .. ',' .. mist.utils.round(point.z, -2) ..
           ',a:' .. mist.utils.round(point.y, -1) .. '}'
  end

  --- Gets the FDMM grouping prefix of a string name (e.g. 'ABC_Test' -> 'ABC_').
  -- @param #string name Name string.
  -- @return Grouping prefix (/w '_') from string name, otherwise nil.
  function fdmm.utils.getGroupingPrefix(name)
    local uPos = string.find(name, '_')
    if uPos ~= nil then -- grouping prefixes always have '_'
      local prefix = name:sub(1, uPos)
      if prefix == prefix:upper() then -- grouping prefixes are always uppercase
        return prefix
      end
    end
    return nil
  end

  --- Removes the FDMM grouping prefix from a string name.
  -- @param #string name Name string.
  -- @return String name with grouping prefix removed, otherwise original string name.
  function fdmm.utils.removeGroupingPrefix(name)
    local prefix = fdmm.utils.getGroupingPrefix(name)
    if prefix ~= nil then
      return name:sub(#prefix + 1)
    end
    return name
  end

  --- Gets the FDMM numeric suffix of a string name (e.g. 'ABC_Test #001' -> ' #001').
  -- @param #string name Name string.
  -- @return Numeric suffix (/w ' #') from string name, otherwise nil.
  function fdmm.utils.getNumericSuffix(name)
    local _,nPos = name:reverse():find('# ')
    if nPos ~= nil then -- numeric suffixes always have ' #'
      local suffix = name:sub(-nPos)
      if suffix == suffix:match(' #[%d]+') then -- numeric suffixes are always numeric
        return suffix
      end
    end
    return nil
  end

  --- Removes the FDMM numeric suffix from a string name.
  -- @param #string name Name string.
  -- @return String name with numeric suffix removed, otherwise original string name.
  function fdmm.utils.removeNumericSuffix(name)
    local suffix = fdmm.utils.getNumericSuffix(name)
    if suffix ~= nil then
      return name:sub(1, -#suffix - 1)
    end
    return name
  end

  --- Gets the FDMM grouping suffix of a string name (e.g. 'ABC_Test_Me' -> '_Me').
  -- @param #string name Name string.
  -- @return Grouping suffix (/w '_') from string name, otherwise nil.
  function fdmm.utils.getGroupingSuffix(name)
    local uPos = name:reverse():find('_')
    if uPos ~= nil then -- grouping suffixes always have '_'
      return name:sub(-uPos) -- grouping suffixes can be lowercase
    end
    return nil
  end

  --- Removes the FDMM grouping suffix from a string name.
  -- @param #string name Name string.
  -- @return String name with grouping suffix removed, otherwise original string name.
  function fdmm.utils.removeGroupingSuffix(name)
    local suffix = fdmm.utils.getGroupingSuffix(name)
    if suffix ~= nil then
      return name:sub(1, -#suffix - 1)
    end
    return name
  end

  --- Determines if the user flag is set true in mission user flags.
  -- @param flag Flag.
  -- @return True if non-0, non-false, and non-no element is set, otherwise false.
  function fdmm.utils.isUserFlagSet(flag)
    local flag = trigger.misc.getUserFlag(flag)
    return (type(flag) == 'number' and flag ~= 0) or
           (type(flag) == 'boolean' and flag ~= false) or
           (type(flag) == 'string' and flag:lower() ~= 'false' and flag ~= '0' and flag:lower() ~= 'no')
  end

  --- Determines if the debug flag is set true in mission user flags.
  -- @return True if debug flag set, otherwise false.
  function fdmm.utils.isDebugFlagSet()
    return fdmm.utils.isUserFlagSet(fdmm.consts.UserFlags.DebugFlag)
  end

end --FDMM_Utils

env.info("---FDMM_Utils End---");
