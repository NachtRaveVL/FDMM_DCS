---
-- FDMM Test Script Module.
-- @module FDMM_TestScript
env.info("---FDMMTEST_TestScript Start---");

--- FDMM test script module.
fdmmtest = {}

do --FDMMTEST_TestScript

  function fdmmtest.runTests()
    fdmm.utils.setUserFlag(fdmm.consts.UserFlag.TestFlag)

    -- TODO: Testing entries.

    fdmm.utils.clearUserFlag(fdmm.consts.UserFlag.TestFlag)
  end

end --FDMMTEST_TestScript

fdmmtest.runTests()

env.info("---FDMMTEST_TestScript End---");
