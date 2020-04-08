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
  -- @param #number timeInterval Time interval between calls (in seconds). Defaults to 0.05.
  -- @param #number timeSlice Allotted time slice (in seconds). Defaults to 60fps ie 17ms.
  -- @return #FDMMRunLoop New instance of #FDMMRunLoop.
  function FDMMRunLoop.new(name, timeInterval, timeSlice)
    assert(name, "Nonnull parameter: name")
    local self = setmetatable({}, FDMMRunLoop)
    self.name = name
    self.timeInterval = timeInterval or 0.050
    self.timeSlice = timeSlice or 0.017
    self.isStarted = false
    self.isRunning = false
    self.runStartTime = 0
    self.neededMoreTime = false
    self.shouldExit = false
    self.functionList = {}
    return self
  end

  function FDMMRunLoop:startAsCallback(dontResume)
    assert(not self.isStarted, "Cannot start run loop more than once.")
    self.isStarted = true
    table.insert(fdmm.runLoop._runLoopList, self)
    if dontResume ~= true then
      self:resume()
    end
  end

  function FDMMRunLoop:startAsCoroutine(dontResume)
    assert(not self.isStarted, "Cannot start run loop more than once.")
    self.isStarted = true
    table.insert(fdmm.runLoop._runLoopList, self)
    self.coroutine = coroutine.create(function()
      repeat
        self:_main()
      until self.shouldExit
      self:stop()
    end)
    if dontResume ~= true then
      self:resume()
    end
  end

  function FDMMRunLoop:stop(remFromLoopList)
    self.shouldExit = true
    if remFromLoopList ~= false then
      table.findAndRemove(fdmm.runLoop._runLoopList, self)
    end
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
  end

  function FDMMRunLoop:yield()
    assert(self.isStarted, "Cannot yield a run loop that hasn't been started.")
    assert(self.isRunning, "Cannot yield a run loop that's not active.")
    if not self.shouldExit then
      fdmm.runLoop.mainLoop:runIfActiveElseEnqueueAsync(function()
        if not self.shouldExit then -- additional check, safety
          local timeToCall = math.max(self.timeSlice, self.runStartTime + self.timeInterval - fdmm.utils.getTime())
          if self.neededMoreTime then
            timeToCall = math.min(timeToCall, self.timeSlice)
            self.neededMoreTime = false
          end
          timer.scheduleFunction(self.resume, self, timer.getTime() + timeToCall)
        end
      end)
      if fdmm.runLoop._activeRunLoop == self then
        fdmm.runLoop._activeRunLoop = nil
      end
      self.isRunning = false
      if self.coroutine then
        coroutine.yield()
      end
    else
      if fdmm.runLoop._activeRunLoop == self then
        fdmm.runLoop._activeRunLoop = nil
      end
      self.isRunning = false
    end
  end

  function FDMMRunLoop:_main()
    fdmm.runLoop._activeRunLoop = self
    self.isRunning = true
    self.runStartTime = fdmm.utils.getTime()

    local status,retVal = pcall(self.main, self)
    if not status then
      env.error("FDMM: Runloop \'" .. self.name .. "\' experienced an execution failure in main.")
      env.error("FDMM:   Error: " .. tostring(retVal))
      env.error("FDMM:   Traceback: " .. tostring(debug and debug.traceback()))
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
    return (self.isRunning or self:isMainLoop()) and coroutine.running() == self.coroutine
  end

  function FDMMRunLoop:getTimeSliceElapsed()
    if self:isActiveLoop() then
      return fdmm.utils.getTime() - self.runStartTime
    end
    return 0
  end

  function FDMMRunLoop:getTimeSliceLeft()
    if self:isActiveLoop() then
      return self.runStartTime + self.timeSlice - fdmm.utils.getTime()
    end
    return 0 
  end

  --- Returns if run loop has exhaused its timeslice or not.
  -- @return True if run loop has exhausted its timeslice, otherwise false.
  function FDMMRunLoop:isTimeSliceOver()
    if self:isActiveLoop() then
      return self.runStartTime + self.timeSlice - fdmm.utils.getTime() <= 0
    end
    return true
  end

  --- Marks run loop as having timed out due to timeslice exhaustion.
  -- Will make the next scheduling of this run loop as more immediate rather than spread further apart.
  function FDMMRunLoop:markAsTimedOut()
    self.neededMoreTime = true
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
        return retVal
      end)
      while waiting do -- TODO: I really need to test this. -NR
        local activeLoop = fdmm.runLoop.getActiveLoop()
        if activeLoop and activeLoop ~= self then
          activeLoop:yield()
        elseif not activeLoop then
          local activeCoroutine = coroutine.running()
          if activeCoroutine and activeCoroutine ~= self.coroutine then
            self:enqueueAsync(coroutine.resume, { activeCoroutine })
            coroutine.yield()
          end
        end
      end
    end
  end

  function FDMMRunLoop:_runQueuedFuncs()
    while self.functionList[1] ~= nil do
      if self:isTimeSliceOver() then
        self:markAsTimedOut()
        return
      end
      local entry = table.remove(self.functionList, 1)
      local status,retVal = pcall(entry[1], entry[2] and table.unpack(entry[2]))
      if not status then
        env.error("FDMM: Runloop \'" .. self.name .. "\' experienced an execution failure in a queued function.")
        env.error("FDMM:   Error: " .. tostring(retVal))
        env.error("FDMM:   Traceback: " .. tostring(debug and debug.traceback()))
      end
    end
  end

end -- /FDMMRunLoop

do -- FDMM_RunLoop

  fdmm.runLoop._runLoopList = {}
  fdmm.runLoop._activeRunLoop = nil

  function fdmm.runLoop.getActiveLoop()
    if fdmm.runLoop._activeRunLoop then return _activeRunLoop end
    for _,runLoop in ipairs(fdmm.runLoop._runLoopList) do
      if runLoop:isActiveLoop() then
        return runLoop
      end
    end
    return nil
  end

  function fdmm.runLoop.startBaseRunLoops()
    fdmm.runLoop.mainLoop = FDMMRunLoop.new("MainLoop", 0.05)
    fdmm.runLoop.highPriorityLoop = FDMMRunLoop.new("HighPriorityLoop", 1)
    fdmm.runLoop.medPriorityLoop = FDMMRunLoop.new("MedPriorityLoop", 5)
    fdmm.runLoop.lowPriorityLoop = FDMMRunLoop.new("LowPriorityLoop", 30)

    fdmm.runLoop.mainLoop:startAsCallback()
    fdmm.runLoop.lowPriorityLoop:startAsCoroutine()
    fdmm.runLoop.medPriorityLoop:startAsCoroutine()
    fdmm.runLoop.highPriorityLoop:startAsCoroutine()
  end

  function fdmm.runLoop.stopBaseRunLoops()
    fdmm.runLoop.highPriorityLoop:stop()
    fdmm.runLoop.medPriorityLoop:stop()
    fdmm.runLoop.lowPriorityLoop:stop()
    fdmm.runLoop.mainLoop:stop()
  end

  function fdmm.runLoop.stopExtRunLoops()
    local baseRunLoops = { fdmm.runLoop.mainLoop, fdmm.runLoop.lowPriorityLoop, fdmm.runLoop.medPriorityLoop,
                           fdmm.runLoop.highPriorityLoop }
    for idx = table.getn(fdmm.runLoop._runLoopList),1,-1 do
      local runLoop = fdmm.runLoop._runLoopList[idx]
      if not table.contains(baseRunLoops, runLoop) then
        runLoop:stop(false)
        table.remove(fdmm.runLoop._runLoopList, idx)
      end
    end
  end

end -- /FDMM_RunLoop

env.info("---FDMM_RunLoop End---")
