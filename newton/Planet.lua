GravitySource = require("GravitySource")

local Planet = {}
Planet.__index = Planet

function Planet:new(x, y, radius)
	local self = setmetatable({}, Planet)
		self.x = x
		self.y = y
		self.radius = radius
		self.type = "planet"
	return self
end

function Planet:update(dt)
	self.gravitySource.x = self.x
	self.gravitySource.y = self.y
end

function Planet:draw()
	--draw circle marking location
	love.graphics.setColor(255, 0, 0, 255)
	love.graphics.circle("line", self.x, self.y, self.radius, 20)
end

function Planet:onCreate()
	self.gravitySource = addEntity(GravitySource:new(self, self.x, self.y, 50))
end

return Planet