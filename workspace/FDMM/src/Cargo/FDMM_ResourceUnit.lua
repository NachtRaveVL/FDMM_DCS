---
-- FDMM Resource Unit Module.
-- @module FDMM_ResourceUnit
env.info("---FDMM_ResourceUnit Start---")

--- FDMM ResourceUnit module.
fdmm.resourceUnit = {}

do --FDMMResourceUnit

  --- Resource unit class that stores a set of resource points that can be converted into DCS fuel, equipment, and craft.
  -- @type FDMMResourceUnit
  FDMMResourceUnit = {}
  FDMMResourceUnit.__index = FDMMResourceUnit
  setmetatable(FDMMResourceUnit, {
    __call = function (cls, ...)
      return cls.new(...)
    end,
  })

  --- Resource unit constructor.
  -- @param #number fuelRP Initial fuel resource points.
  -- @param #number armsRP Initial arms resource points.
  -- @param #number unitRP Initial unit resource points.
  -- @param #number maxFuelRP Maximum fuel resource points.
  -- @param #number maxArmsRP Maximum arms resource points.
  -- @param #number maxUnitRP Maximum unit resource points.
  -- @return #FDMMResourceUnit New instance of #FDMMResourceUnit.
  function FDMMResourceUnit.new(fuelRP, armsRP, unitRP, maxFuelRP, maxArmsRP, maxUnitRP)
    local self = setmetatable({}, FDMMResourceUnit)

    self.fuelRP = fuelRP
    self.armsRP = armsRP
    self.unitRP = unitRP
    self.maxFuelRP = maxFuelRP
    self.maxArmsRP = maxArmsRP
    self.maxUnitRP = maxUnitRP

    return self
  end

  --- Determines if specified amount of RP can be transfered to another resource unit.
  -- @param #FDMMResourceUnit otherResUnit Other resource unit object.
  -- @param #Enums.RPType rpType Resource point type (fuel, arms, etc.).
  -- @param #number amount Resource point amount. Percentages should use [0.0-1.0].
  -- @param #Enums.RPAmountType rpAmountType Resource point amount type (tons, percent, etc.).
  -- @return #bool,#number Tuple: boolean indicating if amount can be transfered or not, and number indicating how long
  --                       such an operation will take (in seconds).
  function FDMMResourceUnit:canTransferTo(otherResUnit, rpType, amount, rpAmountType)
    -- TODO: me.
  end

  --- Creates an RP transfer from this resource unit to another.
  -- @param #FDMMResourceUnit otherResUnit Other resource unit object.
  -- @param #Enums.RPType rpType Resource point type (fuel, arms, etc.).
  -- @param #number amount Resource point amount. Percentages should use [0.0-1.0].
  -- @param #Enums.RPAmountType rpAmountType Resource point amount type (tons, percent, etc.).
  -- @param #boolean isImmediate True if resources are immediate transfered, otherwise false if transfer is timed.
  -- @param completionFunc Completion function to be called once transfer completes (with signature void(errorCode)).
  function FDMMResourceUnit:transferTo(otherResUnit, rpType, amount, rpAmountType, isImmediate, completionFunc)
    -- TODO: me.
  end

end --FDMMResourceUnit

do -- FDMM_ResourceUnit
  -- TODO: me.
end -- FDMM_ResourceUnit

env.info("---FDMM_ResourceUnit End---")
