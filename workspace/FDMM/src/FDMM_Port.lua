---
-- FDMM Port Module.
-- @module FDMM_Port
env.info('---FDMM_Port Start---')

--- FDMM port module.
fdmm.port = {}

do --FDMMPort

  --- Port class that manages ports in a territory, being able to manage ships, control docking/undocking, refits/repairs, etc.
  -- @type FDMMPort
  FDMMPort = {}
  FDMMPort.__index = FDMMPort
  setmetatable(FDMMPort, {
    __call = function (cls, ...)
      return cls.new(...)
    end,
  })

  --- Port constructor.
  -- @param #string name Port name (typically containing name of port city).
  -- @param DCS#Vec2 centerPoint Center point of Port.
  -- @param #string territoryName Territory name this Port belongs to.
  -- @return #FDMMPort New instance of FDMMPort.
  function FDMMPort.new(name, centerPoint, territoryName)
    local self = setmetatable({}, FDMMPort)

    self.name = name
    self.centerPoint = centerPoint
    self.territoryName = territoryName

    return self
  end

  --- Builds Port from map coordinates, using any objects in vicinity of centerPoint.
  function FDMMPort:buildPort()
    -- TODO: me.
  end

end --FDMMPort

do -- FDMM_Port
  -- TODO: me.
end -- FDMM_Port

env.info('---FDMM_Port End---')
