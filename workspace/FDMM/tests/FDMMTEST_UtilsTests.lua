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

  --- Tests prefix/suffix name stripping.
  function FDMMTESTUtilsTests:testNameStripping()
    local name, prefix, suffix

    name,prefix = fdmm.utils.removeGroupingPrefix('ABC_def')
    assert(name == 'def' and prefix == 'ABC_', 'Remove grouping prefix failed')

    name,prefix = fdmm.utils.removeGroupingPrefix('AbC_def')
    assert(name == 'AbC_def' and prefix == nil, 'Remove grouping prefix failed')

    name,suffix = fdmm.utils.removeNumericSuffix('ABC #001')
    assert(name == 'ABC' and suffix == ' #001', 'Remove numeric suffix failed')

    name,suffix = fdmm.utils.removeNumericSuffix('ABC#001')
    assert(name == 'ABC#001' and suffix == nil, 'Remove numeric suffix failed')

    name,suffix = fdmm.utils.removeGroupingSuffix('ABC_def')
    assert(name == 'ABC' and suffix == '_def', 'Remove grouping suffix failed')

    name,suffix = fdmm.utils.removeGroupingSuffix('ABC_dEf')
    assert(name == 'ABC' and suffix == '_dEf', 'Remove grouping suffix failed')

    prefix,name,suffix = fdmm.utils.getGroupingComponents('ABC_def_ghi #001')
    assert(prefix == 'ABC_' and name == 'def' and suffix == '_ghi', 'Get grouping components failed')

    local knownPrefixes = { 'ABC_' }
    local knownSuffixes = { '_def' }
    prefix,name,suffix = fdmm.utils.getGroupingComponentsWithSNC('ABC_def #001', knownPrefixes, knownSuffixes)
    assert(prefix == 'ABC_' and name == nil and suffix == '_def', 'Get grouping components with SNC failed')
  end

  --- Tests tuple splitting.
  function FDMMTESTUtilsTests:testSplitTuple()
    local ret1,ret2,ret3,ret4 = fdmm.utils.splitTuple('abc:def:ghi:jkl')
    assert(ret1 == 'abc' and ret2 == 'def' and ret3 == 'ghi' and ret4 == 'jkl', 'Quadlet split failed')

    ret1,ret2,ret3 = fdmm.utils.splitTuple('def:ghi:jkl')
    assert(ret1 == 'def' and ret2 == 'ghi' and ret3 == 'jkl', 'Triplet split failed')

    ret1,ret2 = fdmm.utils.splitTuple('ghi:jkl')
    assert(ret1 == 'ghi' and ret2 == 'jkl', 'Doublet split failed')

    ret1 = fdmm.utils.splitTuple('jkl')
    assert(ret1 == nil, 'Single split failed')
  end

end --FDMMTESTUtilsTests

env.info("---FDMMTEST_UtilsTests End---")
