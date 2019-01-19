local Player = {}
Player.__index = Player

function Player.new(x, y)
	local self = setmetatable({}, Player)

	self.position = Vector2.new(x, y)
	self.velocity = Vector2.new(0, 0)

	return self
end

function Player:update(dt)
	if love.keyboard.isDown('left')  then self.velocity = self.velocity + Vector2.new(-500,    0) end
	if love.keyboard.isDown('right') then self.velocity = self.velocity + Vector2.new( 500,    0) end
	if love.keyboard.isDown('up')    then self.velocity = self.velocity + Vector2.new(   0, -500) end
	if love.keyboard.isDown('down')  then self.velocity = self.velocity + Vector2.new(   0,  500) end

	self.velocity = self.velocity * 0.5
	
	local speed = self.velocity:getMagnitude()
	local direction = self.velocity:getNormalized()

	if speed > 500 then
		speed = 500
	end

	self.velocity = direction * speed

	self.position = self.position + (self.velocity * dt)
end

function Player:draw()
	love.graphics.setColor(255,255,255,255)
	love.graphics.print(self.velocity:toString())
	love.graphics.circle("fill", self.position.x, self.position.y, 16)
	love.graphics.setColor(255,0,0,255)
	love.graphics.line(self.position.x, self.position.y, self.position.x + self.velocity.x/60, self.position.y + self.velocity.y/60)
end

return Player