---
-- FDMM Run Loop Module.
-- @module FDMM_RunLoop
env.info("---FDMM_RunLoop Start---")

--- FDMM RunLoop module.
fdmm.runLoop = {}

do -- FDMMRunLoop

  --- Run loop class that manages .
  -- @type FDMMRunLoop
  FDMMRunLoop = {}
  FDMMRunLoop.__index = FDMMRunLoop
  setmetatable(FDMMRunLoop, {
    __call = function (cls, ...)
      return cls.new(...)
    end,
  })

  --- Run loop constructor.
  -- @param #string name Name of run loop (for output).
  -- @return #FDMMRunLoop New instance of #FDMMRunLoop.
  function FDMMRunLoop.new(name)
    local self = setmetatable({}, FDMMRunLoop)
    self.name = name
    self._functionList = {}
    return self
  end

  function FDMMRunLoop:startAsCallback(timeInterval)
    -- TODO: me.
  end

  function FDMMRunLoop:startAsCoroutine(yieldSkip)
    -- TODO: me.
  end

  function FDMMRunLoop:enqueueFuncAsync(func)
    -- TODO: me.
  end

  function FDMMRunLoop:enqueueFuncSync(func)
    -- TODO: me.
  end

  function FDMMRunLoop:_runQueuedFuncs()
    -- TODO: me.
  end

end -- /FDMMRunLoop

do -- FDMM_RunLoop

  function fdmm.runLoop.startRunLoops()
    fdmm.runLoop.mainLoop = FDMMRunLoop.new("MainLoop")
    fdmm.runLoop.highPriorityLoop = FDMMRunLoop.new("HighPriorityLoop")
    fdmm.runLoop.medPriorityLoop = FDMMRunLoop.new("MedPriorityLoop")
    fdmm.runLoop.lowPriorityLoop = FDMMRunLoop.new("LowPriorityLoop")

    fdmm.runLoop.mainLoop:startAsCallback(0.25)
    fdmm.runLoop.highPriorityLoop:startAsCoroutine(1)
    fdmm.runLoop.medPriorityLoop:startAsCoroutine(10)
    fdmm.runLoop.lowPriorityLoop:startAsCoroutine(50)
  end

end -- /FDMM_RunLoop

env.info("---FDMM_RunLoop End---")
