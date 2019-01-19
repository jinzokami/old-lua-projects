local Player = {}
Player.__index = Player

function Player.new(x, y)
	local self = setmetatable({}, Player)

	self.x = x
	self.y = y

	return self
end

function Player:update(dt)
	
end

function Player:draw()
	love.graphics.setColor(255,255,255,255)
	love.graphics.rectangle(self.x, self.y, 16, 16)
end

return Player