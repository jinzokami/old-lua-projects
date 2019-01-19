local Timer = {}
Timer.__index = Timer

function Timer.new(startTimer, repeatTimer)
	local self = setmetatable({}, Timer)

	self.timer = startTimer
	self.repeatTimer = repeatTimer

	if self.repeatTimer then
		self.isRepeat = true
	else
		self.isRepeat = false
	end

	self.endAction = function() end

	self.id = nil

	self.isCounting = true

	return self
end

function Timer:update(dt)
	if self.isCounting then
		self.timer = self.timer - dt
	end
	if self.timer <= 0 then
		self.endAction()
		if self.isRepeat then
			self.timer = self.repeatTimer
		else
			TimerManager.deregisterTimer(self.id)
		end
	end
end

function Timer:draw(x, y)
	love.graphics.print(string.format("%.4f seconds left", self.timer), x, y)
end

function Timer:pause()
	self.isCounting = false
end

function Timer:start()
	self.isCounting = true
end

function Timer:stop()
	self.isCounting = false
	TimerManager.deregisterTimer(self.id)
end

return Timer