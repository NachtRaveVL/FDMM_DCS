---
-- FDMM Facility Module.
-- @module FDMM_Facility
env.info("---FDMM_Facility Start---")

--- FDMM facility module.
fdmm.facility = {}

do --FDMMFacility

  --- Facility base class that manages a facility in a territory.
  -- @type FDMMFacility
  FDMMFacility = {}
  FDMMFacility.__index = FDMMFacility
  setmetatable(FDMMFacility, {
    __call = function (cls, ...)
      return cls.new(...)
    end
  })

  --- Facility constructor.
  -- @param #string name Facility name.
  -- @param DCS#Vec2 centerPoint Center point of facility.
  -- @param #string territoryName Territory name this facility belongs to.
  -- @return #FDMMFacility New instance of #FDMMFacility.
  function FDMMFacility.new(name, centerPoint, territoryName)
    local self = setmetatable({}, FDMMFacility)

    self.name = name
    self.centerPoint = centerPoint
    self.territoryName = territoryName

    return self
  end

  --- Builds facility from initial placement of map elements nearby according to setup parameters.
  function FDMMFacility:buildFacility()
    -- meant to be overridden by derived classes
  end

  --- Gets facility type of facility.
  -- @return #Enums.FacilityType Facility type.
  function FDMMFacility:getFacilityType()
    -- meant to be overridden by derived classes
    return nil
  end

end --FDMMFacility

do -- FDMM_Facility
  -- TODO: me.
end -- FDMM_Facility

env.info("---FDMM_Facility End---")
