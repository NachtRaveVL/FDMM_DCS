---
-- FDMM Arms Plant Module.
-- @module FDMM_ArmsPlant
env.info('---FDMM_ArmsPlant Start---')

require('Territory/FDMM_Facility')

--- FDMM arms plant module.
fdmm.armsPlant = {}

do --FDMMArmsPlant

  --- Arms plant class that manages an arms manufacturing plant facility in a territory, which acts as an RPType.Arms manufacturer.
  -- @type FDMMArmsPlant
  -- @extends FDMMFacility
  FDMMArmsPlant = {}
  FDMMArmsPlant.__index = FDMMArmsPlant
  setmetatable(FDMMArmsPlant, {
    __index = FDMMFacility,
    __call = function (cls, ...)
      return cls.new(...)
    end
  })

  --- Arms plant constructor.
  -- @param #string name Arms plant name.
  -- @param DCS#Vec2 centerPoint Center point of arms plant.
  -- @param #string territoryName Territory name this arms plant belongs to.
  -- @return #FDMMArmsPlant New instance of #FDMMArmsPlant.
  function FDMMArmsPlant.new(name, centerPoint, territoryName)
    local self = setmetatable(FDMMFacility.new(name, centerPoint, territoryName), FDMMArmsPlant)
    -- TODO: me.
    return self
  end

  --- Builds arms plant from initial placement of map elements nearby according to setup parameters.
  function FDMMArmsPlant:buildFacility()
    -- TODO: me.
  end

  --- Gets facility type of arms plant.
  -- @return #Enums.FacilityType Arms plant facility type.
  function FDMMArmsPlant:getFacilityType()
    return fdmm.enums.FacilityType.ArmsPlant
  end

end --FDMMArmsPlant

do -- FDMM_ArmsPlant
  -- TODO: me.
end -- FDMM_ArmsPlant

env.info('---FDMM_ArmsPlant End---')
