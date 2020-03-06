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

  function FDMMYearRange:addYear(year)
    assert(type(year) == 'number', "Invalid parameter: year")
    return self:addYearRange(year, year)
  end

  function FDMMYearRange:addYearRange(startYear, endYear)
    assert(type(startYear) == 'number', "Invalid parameter: startYear")
    assert(type(endYear) == 'number', "Invalid parameter: endYear")

    local range = { startYear, endYear }
    local lenRanges = table.getn(self.ranges) 
    if lenRanges == 0 or (startYear < _startYear(self.ranges[1]) and endYear > _endYear(self.ranges[lenRanges])) then
      self.ranges = { range }
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
      if endYear < _startYear(endRange) then endIdx = endIdx - 1 end
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

  function FDMMYearRange:removeYear(year)
    assert(type(year) == 'number', "Invalid parameter: year")
    return self:removeYearRange(year, year)
  end

  function FDMMYearRange:removeYearRange(startYear, endYear)
    assert(type(startYear) == 'number', "Invalid parameter: startYear")
    assert(type(endYear) == 'number', "Invalid parameter: endYear")
  end

  function FDMMYearRange:containsYear(year)
    assert(type(year) == 'number', "Invalid parameter: year")
    return self:containsYearRange(year, year)
  end

  function FDMMYearRange:containsYearRange(startYear, endYear)
    assert(type(startYear) == 'number', "Invalid parameter: startYear")
    assert(type(endYear) == 'number', "Invalid parameter: endYear")
    if table.getn(self.ranges) == 0 then return false end
    local idx = self:_indexOfRangeAdjToOrCont(startYear)
    if idx ~= nil and _yearExistsIn(startYear, self.ranges[idx]) then
      return true
    end
    if endYear > startYear then
      idx = self:_indexOfRangeAdjToOrCont(endYear)
      if idx ~= nil and _yearExistsIn(endYear, self.ranges[idx]) then
        return true
      end
    end
    return false
  end

end --FDMMYearRange

env.info("---FDMM_YearRange End---")
