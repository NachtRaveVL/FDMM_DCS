---
-- FDMMTEST Utils Tests Module.
-- @module FDMMTEST_UtilsTests
env.info("---FDMMTEST_UtilsTests Start---")

require('../tests/FDMMTEST_UnitTest')

do --FDMMTESTUtilsTests

  --- Utils unit tests.
  -- @type FDMMTESTUtilsTests
  -- @extends FDMMTESTUnitTest
  FDMMTESTUtilsTests = {}
  FDMMTESTUtilsTests.__index = FDMMTESTUtilsTests
  setmetatable(FDMMTESTUtilsTests, {
    __index = FDMMTESTUnitTest,
    __call = function (cls, ...)
      return cls.new(...)
    end
  })

  --- Utils unit tests constructor.
  -- @return #FDMMTESTUtilsTests New instance of #FDMMTESTUtilsTests.
  function FDMMTESTUtilsTests.new()
    local self = setmetatable(FDMMTESTUnitTest.new('UtilsTests'), FDMMTESTUtilsTests)
    return self
  end

  --- Sets up utils unit test.
  function FDMMTESTUtilsTests:setUp()
  end

  --- Tears down utils unit test.
  function FDMMTESTUtilsTests:tearDown()
  end

  --- Tests something.
  function FDMMTESTUtilsTests:testSomething()
  end

end --FDMMTESTUtilsTests

env.info("---FDMMTEST_UtilsTests End---")
