---
-- FDMM Airbase Module.
-- @module FDMM_Airbase
env.info("---FDMM_Airbase Start---")

require('Territory/FDMM_Facility')

--- FDMM airbase module.
fdmm.airbase = {}

do -- FDMMAirbase

  --- Airbase class that manages an airbase facility in a territory, which acts as a territory airstrip, respawn area, and supply point.
  -- @type FDMMAirbase
  -- @extends FDMMFacility
  FDMMAirbase = {}
  FDMMAirbase.__index = FDMMAirbase
  setmetatable(FDMMAirbase, {
    __index = FDMMFacility,
    __call = function (cls, ...)
      return cls.new(...)
    end
  })

  --- Airbase constructor.
  -- @param #string name Airbase name.
  -- @param DCS#Vec2 centerPoint Center point of airbase.
  -- @param #string territoryName Territory name this airbase belongs to.
  -- @return #FDMMAirbase New instance of #FDMMAirbase.
  function FDMMAirbase.new(name, centerPoint, territoryName)
    local self = setmetatable(FDMMFacility.new(name, centerPoint, territoryName), FDMMAirbase)
    -- TODO: me.
    return self
  end

  function FDMMAirbase:serialize(encoder)
    -- TODO: me.
  end

  function FDMMAirbase:deserialize(decoder)
    -- TOD: me.
  end

  --- Builds airbase from initial placement of map elements nearby according to setup parameters.
  function FDMMAirbase:buildFacility()
    -- TODO: me.
  end

  --- Gets facility type of airbase.
  -- @return #Enums.FacilityType Airbase facility type.
  function FDMMAirbase:getFacilityType()
    return fdmm.enums.FacilityType.Airbase
  end

end -- /FDMMAirbase

env.info("---FDMM_Airbase End---")
