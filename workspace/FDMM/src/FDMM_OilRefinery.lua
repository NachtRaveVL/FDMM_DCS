---
-- FDMM Oil Refinery Module.
-- @module FDMM_OilRefinery
env.info('---FDMM_OilRefinery Start---')

--- FDMM oil refinery module.
fdmm.oilRefinery = {}

do --FDMMOilRefinery

  --- Oil refinery class that manages oil refineries in a territory, which acts as a fuel manufacturing resource.
  -- @type FDMMOilRefinery
  FDMMOilRefinery = {}
  FDMMOilRefinery.__index = FDMMOilRefinery
  setmetatable(FDMMOilRefinery, {
    __call = function (cls, ...)
      return cls.new(...)
    end,
  })

  --- Oil refinery constructor.
  -- @param #string name Oil refinery name (typically containing name of nearby city).
  -- @param DCS#Vec2 centerPoint Center point of this facility.
  -- @param #string territoryName Territory name this facility belongs to.
  -- @return #FDMMOilRefinery New instance of FDMMOilRefinery.
  function FDMMOilRefinery.new(name, centerPoint, territoryName)
    local self = setmetatable({}, FDMMOilRefinery)

    self.name = name
    self.centerPoint = centerPoint
    self.territoryName = territoryName

    return self
  end

  --- Builds oil refinery from map coordinates, using any objects in vicinity of centerPoint.
  function FDMMOilRefinery:buildOilRefinery()
    -- TODO: me.
  end

end --FDMMOilRefinery

do -- FDMM_OilRefinery
  -- TODO: me.
end -- FDMM_OilRefinery

env.info('---FDMM_OilRefinery End---')
