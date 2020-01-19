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
  -- @param #FDMMTerritory territory Territory object.
  -- @return New instance of FDMMFARP.
  function FDMMFARP.new(name, territory)
    local self = setmetatable({}, FDMMFARP)
    self.name = name
    self.territory = territory
  end

end --FDMMFARP

do -- FDMM_FARP

  --- Creates FARPs from mission group placements.
  -- Layout:
  --   GNPrefixes: FARP_
  function fdmm.farp.createFARPs()
  end

end -- FDMM_FARP

env.info('---FDMM_FARP End---')
