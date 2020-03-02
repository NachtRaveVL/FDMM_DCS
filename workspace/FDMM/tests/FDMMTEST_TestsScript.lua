---
-- FDMM Test Script Module.
-- @module FDMM_TestScript
env.info("---FDMMTEST_TestScript Start---");

--- FDMM test script module.
fdmmtest = {}
fdmmtest.fullPath = fdmm.fullTestsPath

require('../tests/FDMMTEST_UnitTest')
require('../tests/FDMMTEST_UtilsTests')

do --FDMMTEST_TestScript

  function fdmmtest.runUnitTest(unitTest)
    assert(unitTest and type(unitTest) == 'table' and unitTest.name and unitTest.runUnitTests, 'Invalid parameter: unitTest')
    env.info("FDMMTEST:   Running unit test \'" .. unitTest.name .. "\'...")

    local status,retVal = pcall(unitTest.runUnitTests, unitTest)

    if status and retVal and type(retVal) == 'table' then
      fdmmtest.testPasses = fdmmtest.testPasses + retVal.passes
      fdmmtest.testFailures = fdmmtest.testFailures + retVal.failures
      local total = retVal.passes + retVal.failures
      env.info("FDMMTEST:   Ran " .. total .. " unit test(s) from \'" .. unitTest.name .. "\' with " ..
                                  retVal.passes .. " pass(es), " .. retVal.failures .. " failure(s).")
    else
      fdmmtest.testFailures = fdmmtest.testFailures + 1
      env.error("FDMMTEST:   Failure executing unit test \'" .. unitTest.name .. "\'.")
      env.error("FDMMTEST:   Error: " .. retVal)
    end
  end

  function fdmmtest.runTests()
    fdmmtest.testPasses = 0
    fdmmtest.testFailures = 0
    fdmm.utils.setUserFlag(fdmm.consts.UserFlag.TestFlag)
    env.info("FDMMTEST: Running test(s)...")

    -- Add test files here:
    pcall(fdmmtest.runUnitTest, FDMMTESTUtilsTests.new())

    local total = fdmmtest.testPasses + fdmmtest.testFailures
    local resultString = "FDMMTEST: Finished running " .. total .. " test(s) with " ..
                                                       fdmmtest.testPasses .. " pass(es), " ..
                                                       fdmmtest.testFailures .. " failure(s)." 
    if fdmmtest.testFailures == 0 then
      env.info(resultString)
    else
      env.error(resultString)
      trigger.action.outText(resultString, 10)
    end

    fdmm.utils.clearUserFlag(fdmm.consts.UserFlag.TestFlag)
  end

end --FDMMTEST_TestScript

fdmmtest.runTests()

env.info("---FDMMTEST_TestScript End---");
