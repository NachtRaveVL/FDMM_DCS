---
-- FDMM Port Module.
-- @module FDMM_Port
env.info('---FDMM_Port Start---')

require('Territory/FDMM_Facility')

--- FDMM port module.
fdmm.port = {}

do --FDMMPort

  --- Port class that manages a unit manufacturing factory facility in a territory, which acts as an RPType.Unit manufacturer.
  -- @type FDMMPort
  -- @extends FDMMFacility
  FDMMPort = {}
  FDMMPort.__index = FDMMPort
  setmetatable(FDMMPort, {
    __index = FDMMFacility,
    __call = function (cls, ...)
      return cls.new(...)
    end
  })

  --- Port constructor.
  -- @param #string name Port name.
  -- @param DCS#Vec2 centerPoint Center point of port.
  -- @param #string territoryName Territory name this port belongs to.
  -- @return #FDMMPort New instance of #FDMMPort.
  function FDMMPort.new(name, centerPoint, territoryName)
    local self = setmetatable(FDMMFacility.new(name, centerPoint, territoryName), FDMMPort)
    -- TODO: me.
    return self
  end

  --- Builds port from initial placement of map elements nearby according to setup parameters.
  function FDMMPort:buildFacility()
    -- TODO: me.
  end

  --- Gets facility type of port.
  -- @return #Enums.FacilityType Port facility type.
  function FDMMPort:getFacilityType()
    return fdmm.enums.FacilityType.Port
  end

end --FDMMPort

do -- FDMM_Port
  -- TODO: me.
end -- FDMM_Port

env.info('---FDMM_Port End---')
