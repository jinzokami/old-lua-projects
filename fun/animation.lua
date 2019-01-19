local Animation = {}
Animation.__index = Animation

function Animation:new(image, framewidth, frameheight, delay)
	local self = setmetatable({}, Animation)

	self.image = image
	self.delay = delay
	self.frames = {}

	for i = 1, math.floor(image:getWidth()/framewidth), 1 do
		for j = 1, math.floor(image:getHeight()/frameheight), 1 do
			local quad = love.graphics.newQuad((i-1)*framewidth, (j-1)*frameheight, framewidth, frameheight, image:getWidth(), image:getHeight())
			table.insert(self.frames, quad)
		end
	end

	self.timer = delay
	self.currentframe = 1
	self.running = false

	return self
end

function Animation:update(dt)
	if self.running then

		self.timer = self.timer - dt
		if self.timer <= 0 then
			self.timer = self.delay
			self.currentframe = self.currentframe + 1
			if self.currentframe > #self.frames then
				self.currentframe = 1
			end
		end

	end

end

function Animation:draw(x, y)
	love.graphics.draw(self.image, self.frames[self.currentframe], x, y)
end

function Animation:play()
	self.running = true
end

function Animation:pause()
	self.running = false
end

function Animation:stop()
	self.running = false
	self.currentframe = 1
end

function Animation:rewind()
	self.currentframe = 1
end

return Animation