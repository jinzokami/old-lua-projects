local GravitySource = {}
GravitySource.__index = GravitySource

function GravitySource:new(parent, x, y, strength)
	local self = setmetatable({}, GravitySource)

	self.x = x
	self.y = y
	self.strength = strength
	self.type = "source"
	self.parent = parent

	return self
end

function GravitySource:update(dt)
	
end

function GravitySource:draw()
	love.graphics.setColor(0,255,0,255)
	love.graphics.point(self.x, self.y)
end

function GravitySource:onCreate()

end

return GravitySource