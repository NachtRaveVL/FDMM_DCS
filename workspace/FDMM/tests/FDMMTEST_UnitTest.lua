---
-- FDMMTEST Unit Test Module.
-- @module FDMMTEST_UnitTest
env.info("---FDMMTEST_UnitTest Start---")

do --FDMMTESTUnitTest

  --- Unit test class.
  -- @type FDMMTESTUnitTest
  -- @extends FDMMFacility
  FDMMTESTUnitTest = {}
  FDMMTESTUnitTest.__index = FDMMTESTUnitTest
  setmetatable(FDMMTESTUnitTest, {
    __call = function (cls, ...)
      return cls.new(...)
    end
  })

  --- Unit test constructor.
  -- @param #string name Unit test name.
  -- @return #FDMMTESTUnitTest New instance of #FDMMTESTUnitTest.
  function FDMMTESTUnitTest.new(name)
    local self = setmetatable({}, FDMMTESTUnitTest)

    self.name = name

    return self
  end

  --- Runs unit tests and returns passes and failures.
  -- @return #table Table with passes count and failures count.
  function FDMMTESTUnitTest:runUnitTests()
    local runPasses = 0
    local runFailures = 0

    for key,value in pairs(getmetatable(self)) do
      if key and type(key) == 'string' and string.hasPrefix(key, 'test') and value and type(value) == 'function' then
        env.info("FDMMTEST:   Running \'" .. key .. "\'...")

        self:setUp()

        local status,retVal = pcall(value, self)

        if status then
          runPasses = runPasses + 1
          env.info("FDMMTEST:   ... \'" .. key .. "\' passed!")
        else
          runFailures = runFailures + 1
          env.error("FDMMTEST:   ... \'".. key .. "\' failed!")
        end

        self:tearDown()
      end
    end

    return { passes = runPasses, failures = runFailures }
  end

  --- Sets up unit test.
  function FDMMTESTUnitTest:setUp()
    -- Meant to be overridden by derived classes.
  end

  --- Tears down unit test.
  function FDMMTESTUnitTest:tearDown()
    -- Meant to be overridden by derived classes.
  end

end --FDMMTESTUnitTest

env.info("---FDMMTEST_UnitTest End---")
