---
-- FDMM Command Center Module.
-- @module FDMM_CommandCenter
env.info("---FDMM_CommandCenter Start---")

require('Territory/FDMM_Facility')

--- FDMM command center module.
fdmm.commandCenter = {}

do -- FDMMCommandCenter

  --- Command center class that manages an command center facility in a territory, which acts as faction command post.
  -- @type FDMMCommandCenter
  -- @extends FDMMFacility
  FDMMCommandCenter = {}
  FDMMCommandCenter.__index = FDMMCommandCenter
  setmetatable(FDMMCommandCenter, {
    __index = FDMMFacility,
    __call = function (cls, ...)
      return cls.new(...)
    end
  })

  --- Command center constructor.
  -- @param #string name Command center name.
  -- @param DCS#Vec2 centerPoint Center point of command center.
  -- @param #string territoryName Territory name this command center belongs to.
  -- @return #FDMMCommandCenter New instance of #FDMMCommandCenter.
  function FDMMCommandCenter.new(name, centerPoint, territoryName)
    local self = setmetatable(FDMMFacility.new(name, centerPoint, territoryName), FDMMCommandCenter)
    -- TODO: me.
    return self
  end

  function FDMMCommandCenter:serialize(encoder)
    -- TODO: me.
  end

  function FDMMCommandCenter:deserialize(decoder)
    -- TOD: me.
  end

  --- Builds command center from initial placement of map elements nearby according to setup parameters.
  function FDMMCommandCenter:buildFacility()
    -- TODO: me.
  end

  --- Gets facility type of command center.
  -- @return #Enums.FacilityType Command center facility type.
  function FDMMCommandCenter:getFacilityType()
    return fdmm.enums.FacilityType.CommandCenter
  end

end -- /FDMMCommandCenter

env.info("---FDMM_CommandCenter End---")
