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
    self.isStarted = false
    self.isRunning = false
    self.shouldExit = false
    self.functionList = {}
    return self
  end

  function FDMMRunLoop:startAsCallback(timeInterval)
    assert(self.isStarted == false, "Cannot start runloop more than once")
    self.isStarted = true
    self.timeInterval = timeInterval
    timer.scheduleFunction(self._mainByInterval, self, timer.getTime() + self.timeInterval)
  end

  function FDMMRunLoop:startAsCoroutine(timeInterval)
    assert(self.isStarted == false, "Cannot start runloop more than once")
    self.isStarted = true
    self.timeInterval = timeInterval
    self.coroutine = coroutine.create(function()
      self._mainByCoroutine(self) -- never to return
    end)
    timer.scheduleFunction(coroutine.resume, self.coroutine, timer.getTime() + self.timeInterval)
  end

  function FDMMRunLoop:stopAsync()
    self.shouldExit = true
  end

  function FDMMRunLoop:_resumeLater()
    self.isRunning = false
    if self.shouldExit == false then
      if self.coroutine then
        timer.scheduleFunction(coroutine.resume, self.coroutine, timer.getTime() + self.timeInterval)
        coroutine.yield()
      else
        timer.scheduleFunction(self._mainByInterval, self, timer.getTime() + self.timeInterval)
      end
    end
  end

  function FDMMRunLoop:_mainByInterval()
    self.isRunning = true
    local status,retVal = pcall(self._main, self)
    if not status then
      env.error("FDMM: Runloop \'" .. self.name .. "\' experienced an execution failure in main.")
      env.error("FDMM:   Error: " .. tostring(retVal))
    end
    self:_resumeLater()
  end

  function FDMMRunLoop:_mainByCoroutine()
    repeat
      self.isRunning = true
      local status,retVal = pcall(self._main, self)
      if not status then
        env.error("FDMM: Runloop \'" .. self.name .. "\' experienced an execution failure in main.")
        env.error("FDMM:   Error: " .. tostring(retVal))
      end
      self:_resumeLater()
    until self.shouldExit
  end

  function FDMMRunLoop:_main()
    self:_runQueuedFuncs()
  end

  function FDMMRunLoop:isMainLoop()
    return self == fdmm.runLoop.mainLoop
  end

  function FDMMRunLoop:isActiveLoop()
    return self.isRunning and coroutine.running() == self.coroutine
  end

  function FDMMRunLoop:enqueueFuncAsync(func, params)
    table.insert(self.functionList, { func, params })
  end

  function FDMMRunLoop:enqueueFuncSync(func, params)
    if self:isActiveLoop() then
      func(table.unpack(params))
    else
      local waiting = true
      table.insert(self.functionList, {function()
        local status,retVal = pcall(func, table.unpack(params)) 
        waiting = false
        return status,retVal
      end, params})
      while waiting do
        local activeLoop = fdmm.runLoop.getActiveLoop()
        if activeLoop and activeLoop.coroutine then
          activeLoop:_resumeLater()
        else
          -- sleep(0.001) -- TODO: write this func. -NR
        end
      end
    end
  end

  function FDMMRunLoop:_runQueuedFuncs()
    while table.getn(self.functionList) > 0 do
      local entry = table.remove(self.functionList, 1)
      local status,retVal = pcall(entry[1], table.unpack(entry[2]))
      if not status then
        env.error("FDMM: Runloop \'" .. self.name .. "\' experienced an execution failure in a queued function.")
        env.error("FDMM:   Error: " .. tostring(retVal))
      end
    end
  end

end -- /FDMMRunLoop

do -- FDMM_RunLoop

  function fdmm.runLoop.startRunLoops()
    fdmm.runLoop.mainLoop = FDMMRunLoop.new("MainLoop")
    fdmm.runLoop.highPriorityLoop = FDMMRunLoop.new("HighPriorityLoop")
    fdmm.runLoop.medPriorityLoop = FDMMRunLoop.new("MedPriorityLoop")
    fdmm.runLoop.lowPriorityLoop = FDMMRunLoop.new("LowPriorityLoop")

    fdmm.runLoop.mainLoop:startAsCallback(0.05)
    fdmm.runLoop.highPriorityLoop:startAsCoroutine(1)
    fdmm.runLoop.medPriorityLoop:startAsCoroutine(10)
    fdmm.runLoop.lowPriorityLoop:startAsCoroutine(60)
  end

  function fdmm.runLoop.getActiveLoop()
    if fdmm.runLoop.mainLoop:isActiveLoop() then
      return fdmm.runLoop.mainLoop
    elseif fdmm.runLoop.highPriorityLoop:isActiveLoop() then
      return fdmm.runLoop.highPriorityLoop
    elseif fdmm.runLoop.medPriorityLoop:isActiveLoop() then
      return fdmm.runLoop.medPriorityLoop
    elseif fdmm.runLoop.lowPriorityLoop:isActiveLoop() then
      return fdmm.runLoop.lowPriorityLoop
    end
    return nil
  end

  function fdmm.runLoop.stopRunLoops()
    fdmm.runLoop.mainLoop:stopAsync()
    fdmm.runLoop.highPriorityLoop:stopAsync()
    fdmm.runLoop.medPriorityLoop:stopAsync()
    fdmm.runLoop.lowPriorityLoop:stopAsync()
  end

end -- /FDMM_RunLoop

env.info("---FDMM_RunLoop End---")
