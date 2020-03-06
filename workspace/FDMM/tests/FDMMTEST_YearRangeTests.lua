---
-- FDMMTEST Year Range Tests Module.
-- @module FDMMTEST_YearRangeTests
env.info("---FDMMTEST_YearRangeTests Start---")

require('../tests/FDMMTEST_UnitTest')

do --FDMMTESTYearRangeTests

  --- Utils unit tests.
  -- @type FDMMTESTYearRangeTests
  -- @extends FDMMTESTUnitTest
  FDMMTESTYearRangeTests = {}
  FDMMTESTYearRangeTests.__index = FDMMTESTYearRangeTests
  setmetatable(FDMMTESTYearRangeTests, {
    __index = FDMMTESTUnitTest,
    __call = function (cls, ...)
      return cls.new(...)
    end
  })

  --- Utils unit tests constructor.
  -- @return #FDMMTESTYearRangeTests New instance of #FDMMTESTYearRangeTests.
  function FDMMTESTYearRangeTests.new()
    local self = setmetatable(FDMMTESTUnitTest.new('YearRangeTests'), FDMMTESTYearRangeTests)
    return self
  end

  --- Sets up utils unit test.
  function FDMMTESTYearRangeTests:setUp()
  end

  --- Tears down utils unit test.
  function FDMMTESTYearRangeTests:tearDown()
  end

  --- Tests adjacency queries.
  function FDMMTESTYearRangeTests:testAdjacencyQuries()
    local yearRange = FDMMYearRange()
    yearRange.ranges = {{2001,2002},{2004,2005},{2007,2008},{2010,2011}}

    assert(yearRange:_indexOfRangeAdjToOrCont(2000) == 1, "Incorrect index")
    assert(yearRange:_indexOfRangeAdjToOrCont(2001) == 1, "Incorrect index")
    assert(yearRange:_indexOfRangeAdjToOrCont(2002) == 1, "Incorrect index")
    assert(yearRange:_indexOfRangeAdjToOrCont(2003) == 2, "Incorrect index")
    assert(yearRange:_indexOfRangeAdjToOrCont(2004) == 2, "Incorrect index")
    assert(yearRange:_indexOfRangeAdjToOrCont(2005) == 2, "Incorrect index")
    assert(yearRange:_indexOfRangeAdjToOrCont(2006) == 3, "Incorrect index")
    assert(yearRange:_indexOfRangeAdjToOrCont(2007) == 3, "Incorrect index")
    assert(yearRange:_indexOfRangeAdjToOrCont(2008) == 3, "Incorrect index")
    assert(yearRange:_indexOfRangeAdjToOrCont(2009) == 4, "Incorrect index")
    assert(yearRange:_indexOfRangeAdjToOrCont(2010) == 4, "Incorrect index")
    assert(yearRange:_indexOfRangeAdjToOrCont(2011) == 4, "Incorrect index")
    assert(yearRange:_indexOfRangeAdjToOrCont(2012) == 4, "Incorrect index")
  end

  --- Tests adding to year range collapses.
  function FDMMTESTYearRangeTests:testAddToYearRangeCollapses()
    local yearRange = FDMMYearRange()
    yearRange.ranges = {{2001,2002},{2004,2005},{2007,2008},{2010,2011}}

    yearRange:addYearRange(2003, 2009)
    assert(#yearRange.ranges == 1, 'Incorrect ranges count.')
    assert(yearRange:startYear() == 2001, 'Incorrect start year.')
    assert(yearRange:endYear() == 2011, 'Incorrect end year.')

    yearRange:addYearRange(2000, 2012)
    assert(#yearRange.ranges == 1, 'Incorrect ranges count.')
    assert(yearRange:startYear() == 2000, 'Incorrect start year.')
    assert(yearRange:endYear() == 2012, 'Incorrect end year.')

    yearRange:addYearRange(2002, 2007)
    assert(#yearRange.ranges == 1, 'Incorrect ranges count.')
    assert(yearRange:startYear() == 2000, 'Incorrect start year.')
    assert(yearRange:endYear() == 2012, 'Incorrect end year.')

    yearRange:addYearRange(1995, 2005)
    assert(#yearRange.ranges == 1, 'Incorrect ranges count.')
    assert(yearRange:startYear() == 1995, 'Incorrect start year.')
    assert(yearRange:endYear() == 2012, 'Incorrect end year.')

    yearRange:addYearRange(2005, 2015)
    assert(#yearRange.ranges == 1, 'Incorrect ranges count.')
    assert(yearRange:startYear() == 1995, 'Incorrect start year.')
    assert(yearRange:endYear() == 2015, 'Incorrect end year.')

    yearRange:addYearRange(1985, 1990)
    assert(#yearRange.ranges == 2, 'Incorrect ranges count.')
    assert(yearRange:startYear() == 1985, 'Incorrect start year.')
    assert(yearRange:endYear() == 2015, 'Incorrect end year.')

    yearRange:addYearRange(2020, 2025)
    assert(#yearRange.ranges == 3, 'Incorrect ranges count.')
    assert(yearRange:startYear() == 1985, 'Incorrect start year.')
    assert(yearRange:endYear() == 2025, 'Incorrect end year.')

    yearRange:addYearRange(1986, 2024)
    assert(#yearRange.ranges == 1, 'Incorrect ranges count.')
    assert(yearRange:startYear() == 1985, 'Incorrect start year.')
    assert(yearRange:endYear() == 2025, 'Incorrect end year.')

    yearRange.ranges = {{2001,2002},{2004,2005},{2007,2008},{2010,2011}}
    yearRange:addYearRange(2003, 2010)
    assert(#yearRange.ranges == 1, 'Incorrect ranges count.')
    assert(yearRange:startYear() == 2001, 'Incorrect start year.')
    assert(yearRange:endYear() == 2011, 'Incorrect end year.')

    yearRange.ranges = {{2001,2002},{2004,2005},{2007,2008},{2010,2011}}
    yearRange:addYearRange(2003, 2012)
    assert(#yearRange.ranges == 1, 'Incorrect ranges count.')
    assert(yearRange:startYear() == 2001, 'Incorrect start year.')
    assert(yearRange:endYear() == 2012, 'Incorrect end year.')

    yearRange.ranges = {{2001,2002},{2004,2005},{2007,2008},{2010,2011}}
    yearRange:addYearRange(2003, 2010)
    assert(#yearRange.ranges == 1, 'Incorrect ranges count.')
    assert(yearRange:startYear() == 2001, 'Incorrect start year.')
    assert(yearRange:endYear() == 2011, 'Incorrect end year.')

    yearRange.ranges = {{2001,2002},{2004,2005},{2007,2008},{2010,2011}}
    yearRange:addYearRange(2000, 2009)
    assert(#yearRange.ranges == 1, 'Incorrect ranges count.')
    assert(yearRange:startYear() == 2000, 'Incorrect start year.')
    assert(yearRange:endYear() == 2011, 'Incorrect end year.')
  end

end --FDMMTESTYearRangeTests

env.info("---FDMMTEST_YearRangeTests End---")
