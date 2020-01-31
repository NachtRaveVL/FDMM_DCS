---
-- FDMM Arms Plant Module.
-- @module FDMM_ArmsPlant
env.info('---FDMM_ArmsPlant Start---')

--- FDMM arms plant module.
fdmm.armsPlant = {}

do --FDMMArmsPlant

  --- Arms plant class that manages manufacturing plants in a territory, which acts as an equipment manufacturing resource.
  -- @type FDMMArmsPlant
  FDMMArmsPlant = {}
  FDMMArmsPlant.__index = FDMMArmsPlant
  setmetatable(FDMMArmsPlant, {
    __call = function (cls, ...)
      return cls.new(...)
    end,
  })

  --- Arms plant constructor.
  -- @param #string name Arms plant name (typically containing name of nearby city).
  -- @param DCS#Vec2 centerPoint Center point of this facility.
  -- @param #string territoryName Territory name this facility belongs to.
  -- @return #FDMMArmsPlant New instance of FDMMArmsPlant.
  function FDMMArmsPlant.new(name, centerPoint, territoryName)
    local self = setmetatable({}, FDMMArmsPlant)

    self.name = name
    self.centerPoint = centerPoint
    self.territoryName = territoryName

    return self
  end

  --- Builds arms plant from map coordinates, using any objects in vicinity of centerPoint.
  function FDMMArmsPlant:buildArmsPlant()
    -- TODO: me.
  end

end --FDMMArmsPlant

do -- FDMM_ArmsPlant
  -- TODO: me.
end -- FDMM_ArmsPlant

env.info('---FDMM_ArmsPlant End---')
