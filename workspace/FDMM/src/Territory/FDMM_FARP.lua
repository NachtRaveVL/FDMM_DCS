---
-- FDMM FARP Module.
-- @module FDMM_FARP
env.info("---FDMM_FARP Start---")

require('Territory/FDMM_Facility')

--- FDMM FARP module.
fdmm.farp = {}

do -- FDMMFARP

  --- FARP class that manages a forward base facility in a territory, which acts as a territory command post, respawn area, and supply point for an army advancing into an enemy held territory.
  -- @type FDMMFARP
  -- @extends FDMMFacility
  FDMMFARP = {}
  FDMMFARP.__index = FDMMFARP
  setmetatable(FDMMFARP, {
    __index = FDMMFacility,
    __call = function (cls, ...)
      return cls.new(...)
    end
  })

  --- FARP constructor.
  -- @param #string name FARP name.
  -- @param DCS#Vec2 centerPoint Center point of arms plant.
  -- @param #string territoryName Territory name this arms plant belongs to.
  -- @return #FDMMFARP New instance of #FDMMFARP.
  function FDMMFARP.new(name, centerPoint, territoryName)
    local self = setmetatable(FDMMFacility.new(name, centerPoint, territoryName), FDMMFARP)
    -- TODO: me.
    return self
  end

  function FDMMFARP:serialize(encoder)
    -- TODO: me.
  end

  function FDMMFARP:deserialize(decoder)
    -- TOD: me.
  end

  --- Builds FARP from initial placement of map elements nearby according to setup parameters.
  function FDMMFARP:buildFacility()
    -- TODO: me.
  end

  --- Gets facility type of FARP.
  -- @return #Enums.FacilityType FARP facility type.
  function FDMMFARP:getFacilityType()
    return fdmm.enums.FacilityType.FARP
  end

end -- /FDMMFARP

env.info("---FDMM_FARP End---")
