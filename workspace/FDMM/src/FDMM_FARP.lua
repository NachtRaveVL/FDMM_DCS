---
-- FDMM FARP Module.
-- @module FDMM_FARP
env.info('---FDMM_FARP Start---')

--- FDMM FARP module.
fdmm.farp = {}

do --FDMMFARP

  --- FARP class that manages forward bases in a territory, being able to spawn and manage them, etc.
  -- @type FDMMFARP
  FDMMFARP = {}
  FDMMFARP.__index = FDMMFARP
  setmetatable(FDMMFARP, {
    __call = function (cls, ...)
      return cls.new(...)
    end,
  })

  --- FARP constructor.
  -- @param #string name FARP name (typically a relative direction from territory's centerPoint).
  -- @param DCS#Vec2 centerPoint Center point of FARP.
  -- @param #string territoryName Territory name this FARP belongs to.
  -- @return #FDMMFARP New instance of FDMMFARP.
  function FDMMFARP.new(name, centerPoint, territoryName)
    local self = setmetatable({}, FDMMFARP)

    self.name = name
    self.centerPoint = centerPoint
    self.territoryName = territoryName

    return self
  end

  --- Builds FARP from map coordinates, using any FARP objects in vicinity of centerPoint.
  function FDMMFARP:buildFARP()
    -- TODO: me.
  end

end --FDMMFARP

do -- FDMM_FARP
  -- TODO: me.
end -- FDMM_FARP

env.info('---FDMM_FARP End---')
