local Background = {}
Background.__index = Background

function Background:new()
	local self = setmetatable({}, Background)

	self.x = 0
	self.y = 0

	self.image = backgroundImage

	self.actualWidth = self.image:getWidth()
	self.actualHeight = self.image:getHeight()

	self.targetWidth = love.graphics.getWidth()
	self.targetHeight = love.graphics.getHeight()

	self.widthScale = self.targetWidth/self.actualWidth
	self.heightScale = self.targetHeight/self.actualHeight

	self.scrollSpeed = 100

	self.id = getNewID()

	return self
end

function Background:update(dt)
	self.y = self.y + self.scrollSpeed*dt
	self.y = self.y % self.targetHeight
end

function Background:draw()
	love.graphics.draw(self.image, self.x, self.y, 0, self.widthScale, self.heightScale)
	love.graphics.draw(self.image, self.x, self.y-self.targetHeight, 0, self.widthScale, self.heightScale)
end

return Background