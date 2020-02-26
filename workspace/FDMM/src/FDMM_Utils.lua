---
-- FDMM Utils Module.
-- @module FDMM_Utils
env.info("---FDMM_Utils Start---");

--- FDMM utilities module.
fdmm.utils = {}

do --FDMM_Utils

  --- Converts position to loggable string (two dimensional).
  -- @param DCS#Vec point Position.
  -- @return #string Loggable string of rounded position.
  function fdmm.utils.pos2ToLoggableString(point)
    if point.z ~= nil then point = mist.utils.makeVec2(point) end
    return '~{' .. mist.utils.round(point.x, -2) .. ',' .. mist.utils.round(point.y, -2) .. '}'
  end

  --- Converts position to loggable string (three dimensional).
  -- @param DCS#Vec point Position.
  -- @return #string Loggable string of rounded position.
  function fdmm.utils.pos3ToLoggableString(point)
    if point.z == nil then point = mist.utils.makeVec3(point) end
    return '~{' .. mist.utils.round(point.x, -2) .. ',' .. mist.utils.round(point.z, -2) ..
           ',a:' .. mist.utils.round(point.y, -1) .. '}'
  end

  --- Gets the FDMM grouping prefix of a string name (e.g. 'ABC_Test' -> 'ABC_').
  -- Note: Grouping prefix strings must be in all uppercase in order to be recognized as such.
  -- @param #string name Name string.
  -- @return #string Grouping prefix (/w '_') from string name, otherwise nil.
  function fdmm.utils.getGroupingPrefix(name)
    if name then
      local uPos = string.find(name, '_')
      if uPos ~= nil then -- grouping prefixes always have '_'
        local prefix = name:sub(1, uPos)
        if prefix == prefix:upper() then -- grouping prefixes are always uppercase
          return prefix
        end
      end
    end
    return nil
  end

  --- Removes the FDMM grouping prefix from a string name.
  -- Note: Grouping prefix strings must be in all uppercase in order to be recognized as such.
  -- @param #string name Name string.
  -- @return #string,#string Tuple: string name with grouping prefix removed, otherwise original string name, and grouping prefix if found, otherwise nil.
  function fdmm.utils.removeGroupingPrefix(name)
    local prefix = fdmm.utils.getGroupingPrefix(name)
    if prefix ~= nil then
      return name:sub(#prefix + 1), prefix
    end
    return name, nil
  end

  --- Gets the FDMM numeric suffix of a string name (e.g. 'ABC_Test #001' -> ' #001').
  -- @param #string name Name string.
  -- @return #string Numeric suffix (/w ' #') from string name, otherwise nil.
  function fdmm.utils.getNumericSuffix(name)
    if name then
      local _,nPos = name:reverse():find('# ')
      if nPos ~= nil then -- numeric suffixes always have ' #'
        local suffix = name:sub(-nPos)
        if suffix == suffix:match(' #[%d]+') then -- numeric suffixes are always numeric
          return suffix
        end
      end
    end
    return nil
  end

  --- Removes the FDMM numeric suffix from a string name.
  -- @param #string name Name string.
  -- @return #string,#string Tuple: string name with numeric suffix removed, otherwise original string name, and numeric suffix if found, otherwise nil.
  function fdmm.utils.removeNumericSuffix(name)
    local suffix = fdmm.utils.getNumericSuffix(name)
    if suffix ~= nil then
      return name:sub(1, -#suffix - 1), suffix
    end
    return name, nil
  end

  --- Gets the FDMM grouping suffix of a string name (e.g. 'ABC_Test_Me' -> '_Me').
  -- Note: Unlike grouping prefix strings, grouping suffix strings do not have to be in all uppercase in order to be recognized as such.
  -- @param #string name Name string.
  -- @return #string Grouping suffix (/w '_') from string name, otherwise nil.
  function fdmm.utils.getGroupingSuffix(name)
    if name then
      local uPos = name:reverse():find('_')
      if uPos ~= nil then -- grouping suffixes always have '_'
        return name:sub(-uPos)  -- grouping suffixes can be lowercase
      end
    end
    return nil
  end

  --- Removes the FDMM grouping suffix from a string name.
  -- Note: Unlike grouping prefix strings, grouping suffix strings do not have to be in all uppercase in order to be recognized as such.
  -- @param #string name Name string.
  -- @return #string,#string Tuple: string name with grouping suffix removed, otherwise original string name, and grouping suffix if found, otherwise nil.
  function fdmm.utils.removeGroupingSuffix(name)
    local suffix = fdmm.utils.getGroupingSuffix(name)
    if suffix ~= nil then
      return name:sub(1, -#suffix - 1), suffix
    end
    return name, nil
  end

  --- Separates out the FDMM grouping components from a string name (after removing numeric suffix).
  -- @param #string name Name string.
  -- @return #string,#string,#string Tuple: grouping prefix, stripped name, and grouping suffix.
  function fdmm.utils.getGroupingComponents(name)
    assert(name, 'Nonnull parameter: name')
    local prefix, suffix
    name = fdmm.utils.removeNumericSuffix(name)
    name, prefix = fdmm.utils.removeGroupingPrefix(name)
    name, suffix = fdmm.utils.removeGroupingSuffix(name)
    return prefix, name, suffix
  end

  --- Separates out the FDMM grouping components from a string name (after removing numeric suffix), while also handling short-naming conventions.
  -- @param #string name Name string.
  -- @param #table knownPrefixes Table (or list) of known prefixes to handle short-naming for.
  -- @param #table knownSuffixes Table (or list) of known suffixes to handle short-naming for.
  -- @return #string,#string,#string Tuple: grouping prefix, stripped name, and grouping suffix.
  function fdmm.utils.getGroupingComponentsWithSNC(name, knownPrefixes, knownSuffixes)
    local prefix, name, suffix = fdmm.utils.getGroupingComponents(name)

    -- Check if the name is really a prefix or suffix.
    if string.isEmpty(prefix) and table.contains(knownPrefixes or {}, (name .. '_')) then
      prefix = (name .. '_')
      name = nil
    elseif string.isEmpty(suffix) and table.contains(knownSuffixes or {}, ('_' .. name)) then
      suffix = ('_' .. name)
      name = nil
    end

    return prefix, name, suffix
  end

  --- Makes a 2D position vector from a group route point (with an internal deep copy of routePoint).
  -- @param DCS#RoutePoint routePoint Route point.
  -- @return DCS#Vec2 Position vector (with routePoint copy).
  function fdmm.utils.rposFromRPoint(routePoint)
    return { x = routePoint.x or routePoint.point.x, y = routePoint.y or routePoint.point.y, routePoint = mist.utils.deepCopy(routePoint) }
  end

  --- Gets the faction enum from a string name.
  -- @param #string name Name string.
  -- @return #Enums.Faction Faction enumeration, otherwise Faction.Unused if unable to determine.
  function fdmm.utils.getFaction(name)
    assert(name, 'Nonnull parameter: name')
    name = fdmm.utils.removeNumericSuffix(name)
    for enum, value in pairs(fdmm.enums.Faction) do
      if value:lower() == name:lower() then
        return enum
      end
    end
    return fdmm.enums.Faction.Unused
  end

  --- Builds reversed dictionary where keys/values are reversed.
  -- @note Values that map to different keys will map to a sequence of keys.
  -- @note Only string and number types for keys and values are permitted.
  -- @param #table tbl Table.
  -- @return #table New table with reversed key/value entries.
  function fdmm.utils.reversedDict(tbl)
    assert(tbl, 'Nonnull parameter: tbl')
    local rev = {}
    for k,v in pairs(tbl) do
      if (type(k) == 'string' or type(k) == 'number') and (type(v) == 'string' or type(v) == 'number') then
        if not rev[v] then
          rev[v] = k
        elseif rev[v] ~= k then
          if type(rev[v]) ~= 'table' then
            rev[v] = { rev[v] }
          end
          if not table.contains(rev[v], k) then
            table.insert(rev[v], k)
          end
        end
      end
    end
    return rev
  end

  --- Splits strings in tuple format, returning their individual elements.
  -- @param #string tupleString String with elements:in:tuple:form.
  -- @return #string,#string,#string,#string Tuple: Separated elements, otherwise nil,nil,nil,nil.
  function fdmm.utils.splitTuple(tupleString)
    if string.isNotEmpty(tupleString) then
      local colonCount = string.occurrences(tupleString, ':')
      if colonCount == 0 then
        return tupleString
      elseif colonCount == 1 then
        return fdmm.utils.splitDoublet(tupleString)
      elseif colonCount == 2 then
        return fdmm.utils.splitTriplet(tupleString)
      elseif colonCount == 3 then
        return fdmm.utils.splitQuadlet(tupleString)
      else
        assert(false, 'Not reachable')
      end
    end
    return nil, nil, nil, nil
  end

  --- Splits strings in doub:let format, returning two elements.
  -- @param #string doubletString String with one:two elements in doublet form.
  -- @return #string,#string Tuple: first and second elements, otherwise nil,nil.  
  function fdmm.utils.splitDoublet(doubletString)
    assert(doubletString, 'Nonnull parameter: doubletString')
    return doubletString:match("([^:]*):([^:]*)")
  end

  --- Splits strings in tri:p:let format, returning three elements.
  -- @param #string tripletString String with one:two:three elements in triplet form.
  -- @return #string,#string,#string Tuple: first, second, and third elements, otherwise nil,nil,nil.
  function fdmm.utils.splitTriplet(tripletString)
    assert(tripletString, 'Nonnull parameter: tripletString')
    return tripletString:match("([^:]*):([^:]*):([^:]*)")
  end

  --- Splits strings in qu:ad:le:t format, returning four elements.
  -- @param #string quadletString String with one:two:three:four elements in quadlet form.
  -- @return #string,#string,#string Tuple: first, second, third, and fourth elements, otherwise nil,nil,nil,nil.
  function fdmm.utils.splitQuadlet(quadletString)
    assert(quadletString, 'Nonnull parameter: quadletString')
    return quadletString:match("([^:]*):([^:]*):([^:]*):([^:]*)")
  end

  --- Determines if the user flag is set true in mission user flags.
  -- @param #string flag Flag.
  -- @return #boolean True if non-0, non-false, and non-no element is set, otherwise false.
  function fdmm.utils.isUserFlagSet(flag)
    local flag = trigger.misc.getUserFlag(flag)
    return (type(flag) == 'number' and flag ~= 0) or
           (type(flag) == 'boolean' and flag ~= false) or
           (type(flag) == 'string' and flag:lower() ~= 'false' and flag ~= '0'
                                   and flag:lower() ~= 'off' and flag:lower() ~= 'no')
  end

  --- Determines if the debug flag is set true in mission user flags.
  -- @return #boolean True if debug flag set, otherwise false.
  function fdmm.utils.isDebugFlagSet()
    return fdmm.utils.isUserFlagSet(fdmm.consts.UserFlag.DebugFlag)
  end

  --- Determines if current theatre map is a desert-based map or not (for heat effects).
  -- @return #boolean True if on desert-based map, otherwise false.
  function fdmm.utils.isDesertMap()
    return env.mission.theatre == DCSMAP.NTTR or env.mission.theatre == DCSMAP.PersianGulf
  end

  --- Determines if current theatre map is a rainy map or not (for mud effects).
  -- @return #boolean True if on rainy map, otherwise false.
  function fdmm.utils.isRainyMap()
    return env.mission.theatre == DCSMAP.Caucasus or env.mission.theatre == DCSMAP.Normandy 
  end

end --FDMM_Utils

env.info("---FDMM_Utils End---");
