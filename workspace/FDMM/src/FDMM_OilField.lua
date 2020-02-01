---
-- FDMM Oil Field Module.
-- @module FDMM_OilField
env.info('---FDMM_OilField Start---')

require('FDMM_Facility')

--- FDMM oil field module.
fdmm.oilField = {}

do --FDMMOilField

  --- Oil field class that manages an oil extraction and refinery facility in a territory, which acts as an RPType.Fuel manufacturer.
  -- @type FDMMOilField
  FDMMOilField = {}
  FDMMOilField.__index = FDMMOilField
  setmetatable(FDMMOilField, {
    __index = FDMMFacility,
    __call = function (cls, ...)
      return cls.new(...)
    end
  })

  --- Oil field constructor.
  -- @param #string name Oil field name.
  -- @param DCS#Vec2 centerPoint Center point of oil field.
  -- @param #string territoryName Territory name this oil field belongs to.
  -- @return #FDMMOilField New instance of #FDMMOilField.
  function FDMMOilField.new(name, centerPoint, territoryName)
    local self = setmetatable(FDMMFacility.new(name, centerPoint, territoryName), FDMMOilField)
    -- TODO: me.
    return self
  end

  --- Builds oil field from initial placement of map elements nearby according to setup parameters.
  function FDMMOilField:buildFacility()
    -- TODO: me.
  end

end --FDMMOilField

do -- FDMM_OilField
  -- TODO: me.
end -- FDMM_OilField

env.info('---FDMM_OilField End---')
