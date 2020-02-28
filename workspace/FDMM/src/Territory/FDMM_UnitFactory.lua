---
-- FDMM Unit Factory Module.
-- @module FDMM_UnitFactory
env.info("---FDMM_UnitFactory Start---")

require('Territory/FDMM_Facility')

--- FDMM unit factory module.
fdmm.unitFactory = {}

do --FDMMUnitFactory

  --- Unit factory class that manages a unit manufacturing factory facility in a territory, which acts as an RPType.Unit manufacturer.
  -- @type FDMMUnitFactory
  -- @extends FDMMFacility
  FDMMUnitFactory = {}
  FDMMUnitFactory.__index = FDMMUnitFactory
  setmetatable(FDMMUnitFactory, {
    __index = FDMMFacility,
    __call = function (cls, ...)
      return cls.new(...)
    end
  })

  --- Unit factory constructor.
  -- @param #string name Unit factory name.
  -- @param DCS#Vec2 centerPoint Center point of unit factory.
  -- @param #string territoryName Territory name this unit factory belongs to.
  -- @return #FDMMUnitFactory New instance of #FDMMUnitFactory.
  function FDMMUnitFactory.new(name, centerPoint, territoryName)
    local self = setmetatable(FDMMFacility.new(name, centerPoint, territoryName), FDMMUnitFactory)
    -- TODO: me.
    return self
  end

  --- Builds unit factory from initial placement of map elements nearby according to setup parameters.
  function FDMMUnitFactory:buildFacility()
    -- TODO: me.
  end

  --- Gets facility type of unit factory.
  -- @return #Enums.FacilityType Unit factory facility type.
  function FDMMUnitFactory:getFacilityType()
    return fdmm.enums.FacilityType.UnitFactory
  end

end --FDMMUnitFactory

do -- FDMM_UnitFactory
  -- TODO: me.
end -- FDMM_UnitFactory

env.info("---FDMM_UnitFactory End---")
