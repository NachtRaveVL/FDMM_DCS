---
-- FDMM Resource Unit Module.
-- @module FDMM_YearRange
env.info("---FDMM_YearRange Start---")

--- FDMM YearRange module.
fdmm.yearRange = {}

do --FDMMYearRange

  --- Year range class that stores a set of resource points that can be converted into DCS fuel, equipment, and craft.
  -- @type FDMMYearRange
  FDMMYearRange = {}
  FDMMYearRange.__index = FDMMYearRange
  setmetatable(FDMMYearRange, {
    __call = function (cls, ...)
      return cls.new(...)
    end,
  })

  --- Year range constructor.
  -- @return #FDMMYearRange New instance of #FDMMYearRange.
  function FDMMYearRange.new()
    local self = setmetatable({}, FDMMYearRange)
    self.ranges = {}
    return self
  end

  function FDMMYearRange:serialize(encoder)
    -- TODO: me.
  end

  function FDMMYearRange:deserialize(decoder)
    -- TOD: me.
  end

  local function _startYear(range)
    if type(range) ~= 'table' then return nil end
    assert(type(range[1]) == 'number', "Invalid parameter: range[1]")
    return range[1]
  end
  local function _endYear(range)
    if type(range) ~= 'table' then return nil end
    assert(type(range[2]) == 'number', "Invalid parameter: range[2]")
    return range[2]
  end
  local function _yearExistsIn(year, range)
    if type(range) ~= 'table' then return nil end
    assert(type(year) == 'number', "Invalid parameter: year")
    assert(type(range[1]) == 'number', "Invalid parameter: range[1]")
    assert(type(range[2]) == 'number', "Invalid parameter: range[2]")
    return year >= range[1] and year <= range[2]
  end
  local function _rangeContainsRange(range1, range2)
    if type(range1) ~= 'table' or type(range2) ~= 'table' then return nil end
    assert(type(range1[1]) == 'number', "Invalid parameter: range1[1]")
    assert(type(range1[2]) == 'number', "Invalid parameter: range1[2]")
    assert(type(range2[1]) == 'number', "Invalid parameter: range2[1]")
    assert(type(range2[2]) == 'number', "Invalid parameter: range2[2]")
    return range2[1] >= range1[1] and range2[2] <= range1[2]
  end

  function FDMMYearRange:_indexOfRangeAdjToOrCont(year) -- O(log n)
    assert(type(year) == 'number', "Invalid parameter: year")
    if table.getn(self.ranges) == 0 then return nil, nil end
    local min, max = 1, table.getn(self.ranges)
    while min < max do
      local mid = math.floor((min + max) / 2)
      local range = self.ranges[mid]
      if _startYear(range) > year then
        max = mid
      elseif _endYear(range) < year then
        min = mid + 1
      else
        return mid, range
      end
    end
    return min, self.ranges[min]
  end

  function FDMMYearRange:_collapseRangesFromTo(fromIdx, toIdx)
    local count = 0
    local lenRanges = table.getn(self.ranges)
    while toIdx >= fromIdx do
      if toIdx >= 1 and toIdx <= lenRanges then
        table.remove(self.ranges, toIdx)
        lenRanges = lenRanges - 1
        count = count + 1
      end
      toIdx = toIdx - 1
    end
    return count
  end

  function FDMMYearRange:_checkCombineNeighborsAt(idx)
    local lenRanges = table.getn(self.ranges)
    if idx >= 1 and idx <= lenRanges then
      if idx+1 <= lenRanges and _yearExistsIn(_startYear(self.ranges[idx+1]) - 1, self.ranges[idx]) then
        self.ranges[idx+1][1] = _startYear(self.ranges[idx])
        table.remove(self.ranges, idx)
      end
      if idx-1 >= 1 and _yearExistsIn(_endYear(self.ranges[idx-1]) + 1, self.ranges[idx]) then
        self.ranges[idx-1][2] = _endYear(self.ranges[idx])
        table.remove(self.ranges, idx)
      end
      self:_checkValidRangeAt(idx)
    end
  end

  function FDMMYearRange:_checkValidRangeAt(idx)
    local lenRanges = table.getn(self.ranges)
    if idx >= 1 and idx <= lenRanges then
      local range = self.ranges[idx]
      if _startYear(range) > _endYear(range) then
        table.remove(self.ranges, idx)
      end
    end
  end

  function FDMMYearRange:startYear()
    if table.getn(self.ranges) == 0 then return nil end
    return _startYear(self.ranges[1])
  end

  function FDMMYearRange:endYear()
    if table.getn(self.ranges) == 0 then return nil end
    return _endYear(self.ranges[table.getn(self.ranges)])
  end

  function FDMMYearRange:getYearList()
    local list = {}
    for _,range in ipairs(self.ranges or {}) do
      if _startYear(range) ~= _endYear(range) then
        table.insert(list, range)
      else
        table.insert(list, _startYear(range))
      end
    end
    return list
  end

  function FDMMYearRange:addYearsFromList(yearList)
    assert(type(yearList) == 'table', "Invalid parameter: yearList")
    for _,yearData in ipairs(yearList) do
      if type(yearData) == 'number' then
        self:addYear(yearData)
      elseif type(yearData) == 'table' and table.getn(yearData) == 2 then
        self:addYearRange(yearData[1], yearData[2])
      else
        assert(false, "Unknown yearData: " .. tostring(yearData))
      end
    end
  end

  function FDMMYearRange:addYear(year)
    assert(type(year) == 'number', "Invalid parameter: year")
    return self:addYearRange(year, year)
  end

  function FDMMYearRange:addYearRange(startYear, endYear)
    assert(type(startYear) == 'number', "Invalid parameter: startYear")
    assert(type(endYear) == 'number', "Invalid parameter: endYear")

    local range = { startYear, endYear } 
    local lenRanges = table.getn(self.ranges)
    if lenRanges == 0 or (startYear <= _startYear(self.ranges[1]) and endYear >= _endYear(self.ranges[lenRanges])) then
      self.ranges = { range }
      self:_checkValidRangeAt(1)
      return
    end

    local begIdx = self:_indexOfRangeAdjToOrCont(startYear)
    local begRange = begIdx and self.ranges[begIdx] or nil
    if begRange then
      if _rangeContainsRange(begRange, range) then
        return
      elseif endYear < _startYear(begRange) then
        table.insert(self.ranges, begIdx, range)
        self:_checkCombineNeighborsAt(begIdx)
        return
      end
    end

    local endIdx = self:_indexOfRangeAdjToOrCont(endYear)
    local endRange = endIdx and self.ranges[endIdx] or nil
    if endRange and startYear > _endYear(endRange) then
      table.insert(self.ranges, range)
      self:_checkCombineNeighborsAt(endIdx + 1)
      return
    end

    local startYearInBegRange = _yearExistsIn(startYear, begRange)
    local endYearInEndRange = _yearExistsIn(endYear, endRange)

    if startYearInBegRange and endYearInEndRange then
      range = { _startYear(begRange), _endYear(endRange) }
      self:_collapseRangesFromTo(begIdx, endIdx)
      table.insert(self.ranges, begIdx, range)
      self:_checkCombineNeighborsAt(begIdx)
      return
    elseif not startYearInBegRange and not endYearInEndRange then
      local endYearBefEndRange = endYear < _startYear(endRange)
      if endYearBefEndRange then endIdx = endIdx - 1 end
      self:_collapseRangesFromTo(begIdx, endIdx)
      table.insert(self.ranges, begIdx, range)
      self:_checkCombineNeighborsAt(begIdx)
      return
    else -- in one or the other
      if startYearInBegRange then
        self:_collapseRangesFromTo(begIdx + 1, endIdx)
        self.ranges[begIdx][2] = _endYear(range)
        self:_checkCombineNeighborsAt(begIdx)
      elseif endYearInEndRange then
        endIdx = endIdx - self:_collapseRangesFromTo(begIdx, endIdx - 1)
        self.ranges[endIdx][1] = _startYear(range)
        self:_checkCombineNeighborsAt(endIdx)
      end
      return
    end
  end

  function FDMMYearRange:removeYearsFromList(yearList)
    assert(type(yearList) == 'table', "Invalid parameter: yearList")
    for _,yearData in ipairs(yearList) do
      if type(yearData) == 'number' then
        self:removeYear(yearData)
      elseif type(yearData) == 'table' and table.getn(yearData) == 2 then
        self:removeYearRange(yearData[1], yearData[2])
      else
        assert(false, "Unknown yearData: " .. tostring(yearData))
      end
    end
  end

  function FDMMYearRange:removeYear(year)
    assert(type(year) == 'number', "Invalid parameter: year")
    return self:removeYearRange(year, year)
  end

  function FDMMYearRange:removeYearRange(startYear, endYear)
    assert(type(startYear) == 'number', "Invalid parameter: startYear")
    assert(type(endYear) == 'number', "Invalid parameter: endYear")

    local lenRanges = table.getn(self.ranges) 
    if lenRanges == 0 or (startYear <= _startYear(self.ranges[1]) and endYear >= _endYear(self.ranges[lenRanges])) then
      self.ranges = {}
      return
    end

    local range = { startYear, endYear }
    local begIdx = self:_indexOfRangeAdjToOrCont(startYear)
    local begRange = begIdx and self.ranges[begIdx] or nil
    local endIdx = self:_indexOfRangeAdjToOrCont(endYear)
    local endRange = endIdx and self.ranges[endIdx] or nil
    local startYearInBegRange = _yearExistsIn(startYear, begRange)
    local endYearInEndRange = _yearExistsIn(endYear, endRange)
    local startYearBefOrEncapsBegRange = startYear <= _startYear(begRange)
    local endYearBefEndRange = endYear < _startYear(endRange)
    local endYearAftOrEncapsEndRange = endYear >= _endYear(endRange)

    if startYearBefOrEncapsBegRange and (endYearBefEndRange or endYearAftOrEncapsEndRange) then
      if endYearBefEndRange then endIdx = endIdx - 1 end
      self:_collapseRangesFromTo(begIdx, endIdx)
      return
    elseif begIdx == endIdx and startYearInBegRange and endYearInEndRange then
      range = { endYear + 1, _endYear(begRange) }
      self.ranges[begIdx][2] = startYear - 1
      table.insert(self.ranges, begIdx + 1, range)
      self:_checkValidRangeAt(begIdx)
      self:_checkValidRangeAt(begIdx + 1)
      return
    else -- in one or the other
      local fromIdx, toIdx = begIdx, endIdx
      if not startYearBefOrEncapsBegRange then fromIdx = begIdx + 1 end
      if not endYearAftOrEncapsEndRange then toIdx = endIdx - 1 end
      endIdx = endIdx - self:_collapseRangesFromTo(fromIdx, toIdx)

      if not startYearBefOrEncapsBegRange and startYearInBegRange then
        self.ranges[begIdx][2] = startYear - 1
        self:_checkValidRangeAt(begIdx)
      elseif not endYearAftOrEncapsEndRange and endYearInEndRange then
        self.ranges[endIdx][1] = endYear + 1
        self:_checkValidRangeAt(endIdx)
      end
      return
    end
  end

  function FDMMYearRange:clear()
    self.ranges = {}
  end

  function FDMMYearRange:containsYear(year)
    assert(type(year) == 'number', "Invalid parameter: year")
    return self:containsYearRange(year, year)
  end

  function FDMMYearRange:containsYearRange(startYear, endYear)
    assert(type(startYear) == 'number', "Invalid parameter: startYear")
    assert(type(endYear) == 'number', "Invalid parameter: endYear")
    if table.getn(self.ranges) == 0 then return false end

    local range = { startYear, endYear }
    local begIdx = self:_indexOfRangeAdjToOrCont(startYear)
    local begRange = begIdx and self.ranges[begIdx] or nil
    if begRange and _rangeContainsRange(begRange, range) then
      return true
    end

    if not begRange or endYear > _endYear(begRange) then
      local endIdx = self:_indexOfRangeAdjToOrCont(endYear)
      local endRange = endIdx and self.ranges[endIdx] or nil
      if endRange and _rangeContainsRange(endRange, range) then
        return true
      end
    end
    return false
  end

end --FDMMYearRange

env.info("---FDMM_YearRange End---")
