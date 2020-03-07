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
  function FDMMTESTYearRangeTests:testAdjacencyQueries()
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

  --- Tests adding years to year range.
  function FDMMTESTYearRangeTests:testAddToYearRange()
    local yearRange = FDMMYearRange()
    yearRange.ranges = {{2001,2002},{2004,2005},{2007,2008},{2010,2011}}

    assert(yearRange:containsYear(2000) == false, 'Incorrect contains.')
    assert(yearRange:containsYear(2001) == true, 'Incorrect contains.')
    assert(yearRange:containsYear(2002) == true, 'Incorrect contains.')
    assert(yearRange:containsYear(2003) == false, 'Incorrect contains.')
    assert(yearRange:containsYear(2004) == true, 'Incorrect contains.')
    assert(yearRange:containsYear(2005) == true, 'Incorrect contains.')
    assert(yearRange:containsYear(2006) == false, 'Incorrect contains.')
    assert(yearRange:containsYear(2007) == true, 'Incorrect contains.')
    assert(yearRange:containsYear(2008) == true, 'Incorrect contains.')
    assert(yearRange:containsYear(2009) == false, 'Incorrect contains.')
    assert(yearRange:containsYear(2010) == true, 'Incorrect contains.')
    assert(yearRange:containsYear(2011) == true, 'Incorrect contains.')
    assert(yearRange:containsYear(2012) == false, 'Incorrect contains.')

    yearRange:addYearRange(2003, 2009)
    assert(table.getn(yearRange.ranges) == 1, 'Incorrect ranges count.')
    assert(yearRange:containsYearRange(2001, 2011) == true, 'Incorrect contains.')
    assert(yearRange:startYear() == 2001, 'Incorrect start year.')
    assert(yearRange:endYear() == 2011, 'Incorrect end year.')

    yearRange:addYearRange(2000, 2012)
    assert(table.getn(yearRange.ranges) == 1, 'Incorrect ranges count.')
    assert(yearRange:containsYearRange(2001, 2011) == true, 'Incorrect contains.')
    assert(yearRange:startYear() == 2000, 'Incorrect start year.')
    assert(yearRange:endYear() == 2012, 'Incorrect end year.')

    yearRange:addYearRange(2002, 2007)
    assert(table.getn(yearRange.ranges) == 1, 'Incorrect ranges count.')
    assert(yearRange:containsYearRange(2002, 2007) == true, 'Incorrect contains.')
    assert(yearRange:startYear() == 2000, 'Incorrect start year.')
    assert(yearRange:endYear() == 2012, 'Incorrect end year.')

    yearRange:addYearRange(1995, 2005)
    assert(table.getn(yearRange.ranges) == 1, 'Incorrect ranges count.')
    assert(yearRange:containsYearRange(1996, 2012) == true, 'Incorrect contains.')
    assert(yearRange:startYear() == 1995, 'Incorrect start year.')
    assert(yearRange:endYear() == 2012, 'Incorrect end year.')

    yearRange:addYearRange(2005, 2015)
    assert(table.getn(yearRange.ranges) == 1, 'Incorrect ranges count.')
    assert(yearRange:containsYearRange(1995, 2014) == true, 'Incorrect contains.')
    assert(yearRange:startYear() == 1995, 'Incorrect start year.')
    assert(yearRange:endYear() == 2015, 'Incorrect end year.')

    yearRange:addYearRange(1985, 1990)
    assert(table.getn(yearRange.ranges) == 2, 'Incorrect ranges count.')
    assert(yearRange:containsYearRange(1985, 2015) == false, 'Incorrect contains.')
    assert(yearRange:startYear() == 1985, 'Incorrect start year.')
    assert(yearRange:endYear() == 2015, 'Incorrect end year.')

    yearRange:addYearRange(2020, 2025)
    assert(table.getn(yearRange.ranges) == 3, 'Incorrect ranges count.')
    assert(yearRange:containsYearRange(1985, 2025) == false, 'Incorrect contains.')
    assert(yearRange:startYear() == 1985, 'Incorrect start year.')
    assert(yearRange:endYear() == 2025, 'Incorrect end year.')

    yearRange:addYearRange(1986, 2024)
    assert(table.getn(yearRange.ranges) == 1, 'Incorrect ranges count.')
    assert(yearRange:containsYearRange(1985, 2025) == true, 'Incorrect contains.')
    assert(yearRange:startYear() == 1985, 'Incorrect start year.')
    assert(yearRange:endYear() == 2025, 'Incorrect end year.')

    yearRange.ranges = {{2001,2002},{2004,2005},{2007,2008},{2010,2011}}
    yearRange:addYearRange(2003, 2010)
    assert(table.getn(yearRange.ranges) == 1, 'Incorrect ranges count.')
    assert(yearRange:containsYearRange(2001, 2011) == true, 'Incorrect contains.')
    assert(yearRange:startYear() == 2001, 'Incorrect start year.')
    assert(yearRange:endYear() == 2011, 'Incorrect end year.')

    yearRange.ranges = {{2001,2002},{2004,2005},{2007,2008},{2010,2011}}
    yearRange:addYearRange(2003, 2012)
    assert(table.getn(yearRange.ranges) == 1, 'Incorrect ranges count.')
    assert(yearRange:containsYearRange(2001, 2011) == true, 'Incorrect contains.')
    assert(yearRange:startYear() == 2001, 'Incorrect start year.')
    assert(yearRange:endYear() == 2012, 'Incorrect end year.')

    yearRange.ranges = {{2001,2002},{2004,2005},{2007,2008},{2010,2011}}
    yearRange:addYearRange(2003, 2010)
    assert(table.getn(yearRange.ranges) == 1, 'Incorrect ranges count.')
    assert(yearRange:containsYearRange(2001, 2011) == true, 'Incorrect contains.')
    assert(yearRange:startYear() == 2001, 'Incorrect start year.')
    assert(yearRange:endYear() == 2011, 'Incorrect end year.')

    yearRange.ranges = {{2001,2002},{2004,2005},{2007,2008},{2010,2011}}
    yearRange:addYearRange(2000, 2009)
    assert(table.getn(yearRange.ranges) == 1, 'Incorrect ranges count.')
    assert(yearRange:containsYearRange(2000, 2011) == true, 'Incorrect contains.')
    assert(yearRange:startYear() == 2000, 'Incorrect start year.')
    assert(yearRange:endYear() == 2011, 'Incorrect end year.')
  end

  --- Tests removing years from year range.
  function FDMMTESTYearRangeTests:testRemoveFromYearRange()
    local yearRange = FDMMYearRange()
    yearRange.ranges = {{2000,2010}}

    yearRange:removeYearRange(1990, 2001)
    assert(table.getn(yearRange.ranges) == 1, 'Incorrect ranges count.')
    assert(yearRange:containsYearRange(2000, 2010) == false, 'Incorrect contains.')
    assert(yearRange:containsYearRange(2002, 2010) == true, 'Incorrect contains.')
    assert(yearRange:startYear() == 2002, 'Incorrect start year.')
    assert(yearRange:endYear() == 2010, 'Incorrect end year.')

    yearRange:removeYearRange(2009, 2020)
    assert(table.getn(yearRange.ranges) == 1, 'Incorrect ranges count.')
    assert(yearRange:containsYearRange(2000, 2010) == false, 'Incorrect contains.')
    assert(yearRange:containsYearRange(2002, 2008) == true, 'Incorrect contains.')
    assert(yearRange:startYear() == 2002, 'Incorrect start year.')
    assert(yearRange:endYear() == 2008, 'Incorrect end year.')

    yearRange:removeYearRange(2005, 2006)
    assert(table.getn(yearRange.ranges) == 2, 'Incorrect ranges count.')
    assert(yearRange:containsYear(2004) == true, 'Incorrect contains.')
    assert(yearRange:containsYear(2005) == false, 'Incorrect contains.')
    assert(yearRange:containsYear(2006) == false, 'Incorrect contains.')
    assert(yearRange:containsYear(2007) == true, 'Incorrect contains.')
    assert(yearRange:startYear() == 2002, 'Incorrect start year.')
    assert(yearRange:endYear() == 2008, 'Incorrect end year.')

    yearRange.ranges = {{2001,2002},{2004,2005},{2007,2008},{2010,2011}}
    yearRange:removeYearRange(2003, 2009)
    assert(table.getn(yearRange.ranges) == 2, 'Incorrect ranges count.')
    assert(yearRange:containsYear(2002) == true, 'Incorrect contains.')
    assert(yearRange:containsYear(2003) == false, 'Incorrect contains.')
    assert(yearRange:containsYear(2009) == false, 'Incorrect contains.')
    assert(yearRange:containsYear(2010) == true, 'Incorrect contains.')
    assert(yearRange:startYear() == 2001, 'Incorrect start year.')
    assert(yearRange:endYear() == 2011, 'Incorrect end year.')

    yearRange.ranges = {{2001,2002},{2004,2005},{2007,2008},{2010,2011}}
    yearRange:removeYearRange(2005, 2009)
    assert(table.getn(yearRange.ranges) == 3, 'Incorrect ranges count.')
    assert(yearRange:containsYear(2004) == true, 'Incorrect contains.')
    assert(yearRange:containsYear(2005) == false, 'Incorrect contains.')
    assert(yearRange:startYear() == 2001, 'Incorrect start year.')
    assert(yearRange:endYear() == 2011, 'Incorrect end year.')

    yearRange.ranges = {{2001,2002},{2004,2005},{2007,2008},{2010,2011}}
    yearRange:removeYearRange(2003, 2007)
    assert(table.getn(yearRange.ranges) == 3, 'Incorrect ranges count.')
    assert(yearRange:containsYear(2007) == false, 'Incorrect contains.')
    assert(yearRange:containsYear(2008) == true, 'Incorrect contains.')
    assert(yearRange:startYear() == 2001, 'Incorrect start year.')
    assert(yearRange:endYear() == 2011, 'Incorrect end year.')
  end

end --FDMMTESTYearRangeTests

env.info("---FDMMTEST_YearRangeTests End---")
