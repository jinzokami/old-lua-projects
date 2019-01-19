local Rectangle = {}
Rectangle.__index = Rectangle

function Rectangle:new(x, y, w, h)
	local self = setmetatable({}, Rectangle)
	
	self.x = x
	self.y = y
	self.w = w
	self.h = h

	self.colliding = false

	self.sides = {}

	self.sides[1].x = self.x
	self.sides[1].y = self.y

	self.sides[2].x = self.x
	self.sides[2].y = self.y

	self.sides[3].x = self.x
	self.sides[3].y = self.y

	self.sides[4].x = self.x
	self.sides[4].y = self.y

	return self
end

function Rectangle:draw()
	if self.colliding then
		love.graphics.setColor(255,0,0,255)
	else
		love.graphics.setColor(0,255,0,255)
	end
	love.graphics.lines(self.sides)
end

return Rectangle