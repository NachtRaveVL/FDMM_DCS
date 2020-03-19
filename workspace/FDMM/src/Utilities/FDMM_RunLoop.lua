---
-- FDMM Run Loop Module.
-- @module FDMM_RunLoop
env.info("---FDMM_RunLoop Start---")

--- FDMM RunLoop module.
fdmm.runLoop = {}

do -- FDMMRunLoop

  --- Run loop class that manages a basic thread and tasks associated with such.
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
    self.runStartTime = 0
    self.shouldExit = false
    self.functionList = {}
    return self
  end

  function FDMMRunLoop:startAsCallback(timeInterval)
    assert(timeInterval, "Nonnull parameter: timeInterval")
    assert(not self.isStarted, "Cannot start run loop more than once.")
    self.isStarted = true
    self.timeInterval = timeInterval
    timer.scheduleFunction(self.resume, self, timer.getTime() + self.timeInterval)
  end

  function FDMMRunLoop:startAsCoroutine(timeInterval)
    assert(timeInterval, "Nonnull parameter: timeInterval")
    assert(not self.isStarted, "Cannot start run loop more than once.")
    self.isStarted = true
    self.timeInterval = timeInterval
    self.coroutine = coroutine.create(function()
      repeat
        self:_main()
      until self.shouldExit
    end)
    timer.scheduleFunction(self.resume, self, timer.getTime() + self.timeInterval)
  end

  function FDMMRunLoop:stopAsync()
    self.shouldExit = true
  end

  function FDMMRunLoop:resume()
    assert(self.isStarted, "Cannot resume a run loop that hasn't been started.")
    assert(not self.isRunning, "Cannot resume a run loop that's already active.")
    if not self.shouldExit then
      if self.coroutine then
        coroutine.resume(self.coroutine)
      else
        self:_main()
      end
    end
    return nil
  end
 
  function FDMMRunLoop:yield()
    assert(self.isStarted, "Cannot yield a run loop that hasn't been started.")
    assert(self.isRunning, "Cannot yield a run loop that's not active.")
    if not self.shouldExit then
      fdmm.runLoop.mainLoop:runIfActiveElseEnqueueAsync(function()
        timer.scheduleFunction(self.resume, self, timer.getTime() + self.timeInterval)
      end)
      self.isRunning = false
      if self.coroutine then
        coroutine.yield()
      end
    else
      self.isRunning = false
    end
  end

  function FDMMRunLoop:_main()
    self.isRunning = true
    self.runStartTime = timer.getTime()

    local status,retVal = pcall(self.main, self)
    if not status then
      env.error("FDMM: Runloop \'" .. self.name .. "\' experienced an execution failure in main.")
      env.error("FDMM:   Error: " .. tostring(retVal))
    end

    self:_runQueuedFuncs()
    self:yield()
  end

  function FDMMRunLoop:main()
    -- Derived classes may override this method and fill in their own main loop.
  end

  function FDMMRunLoop:isMainLoop()
    return self == fdmm.runLoop.mainLoop
  end

  function FDMMRunLoop:isActiveLoop()
    return self.isRunning and coroutine.running() == self.coroutine
  end

  function FDMMRunLoop:timeSpentActive()
    if self:isActiveLoop() then
      return timer.getTime() - self.runStartTime
    end
    return 0
  end

  function FDMMRunLoop:enqueueAsync(func, params)
    table.insert(self.functionList, { func, params })
  end

  function FDMMRunLoop:runIfActiveElseEnqueueAsync(func, params)
    if self:isActiveLoop() then
      func(params and table.unpack(params))
    else
      self:enqueueAsync(func, params)
    end
  end

  function FDMMRunLoop:runIfActiveElseEnqueueSync(func, params)
    if self:isActiveLoop() then
      func(params and table.unpack(params))
    else
      local waiting = true
      self:enqueueAsync(function()
        local status,retVal = pcall(func, params and table.unpack(params)) 
        waiting = false
        return status,retVal
      end, nil)
      while waiting do
        local activeLoop = fdmm.runLoop.getActiveLoop()
        if activeLoop and activeLoop ~= self then
          activeLoop:yield()
        elseif not activeLoop then
          local activeCoroutine = coroutine.running()
          if activeCoroutine and activeCoroutine ~= self.coroutine then
            self:enqueueAsync(coroutine.resume, {activeCoroutine})
            coroutine.yield()
          end
        end
      end
    end
  end

  function FDMMRunLoop:_runQueuedFuncs()
    while table.getn(self.functionList) > 0 do
      local entry = table.remove(self.functionList, 1)
      local status,retVal = pcall(entry[1], entry[2] and table.unpack(entry[2]))
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
