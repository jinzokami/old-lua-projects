local TimerManager = {}
TimerManager.__index = TimerManager

TimerManager.currentTimerID = 0
TimerManager.timers = {}
function TimerManager.getNewTimerID() -- assigns an ID to the timer (or whatever calls this, but for reasons of portability  it's timers specific)
	currentTimerID = currentTimerID + 1
	return currentTimerID
end

function TimerManager.registerNewTimer(timer) -- adds a timer to the list of timers, do this when you're ready to start counting down
	timer.id = TimerManager.getNewTimerID()
	table.insert(Timer.timers, timer)
end

function TimerManager.deregisterTimer(id)
	for i = 1, #TimerManager.timers, 1 do
		if TimerManager.timers[i].id == id then
			table.remove(TimerManager.timers[i])
		end
	end
end

return TimerManager