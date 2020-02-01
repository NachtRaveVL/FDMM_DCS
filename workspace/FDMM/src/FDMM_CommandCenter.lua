---
-- FDMM Command Center Module.
-- @module FDMM_CommandCenter
env.info('---FDMM_CommandCenter Start---')

require('FDMM_Facility')

--- FDMM command center module.
fdmm.commandCenter = {}

do --FDMMCommandCenter

  --- Command center class that manages an command center facility in a territory, which acts as faction command post.
  -- @type FDMMCommandCenter
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

  --- Builds command center from initial placement of map elements nearby according to setup parameters.
  function FDMMCommandCenter:buildFacility()
    -- TODO: me.
  end

end --FDMMCommandCenter

do -- FDMM_CommandCenter
  -- TODO: me.
end -- FDMM_CommandCenter

env.info('---FDMM_CommandCenter End---')