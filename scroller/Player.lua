local Player = {}
Player.__index = Player

function Player.new(x, y)
	local self = setmetatable({}, Player)
	
	self.x = x
	self.y = y
	self.height = 14
	self.width = 14
	self.speedx = 100
	self.speedy = 0
	self.moving = 0
	self.gravity = 1000
	self.grounded = false
	self.jumpspeed = -280
	
	return self
end

function Player:update(dt)
	if love.keyboard.isDown('left') then
		self.moving = -1
	end

	if love.keyboard.isDown('right') then
		self.moving = 1
	end

	if not love.keyboard.isDown('left') and not love.keyboard.isDown('right') then
		self.moving = 0
	end

	if love.keyboard.isDown('left') and love.keyboard.isDown('right') then
		self.moving = 0
	end

	local oldx = self.x
	local dx = dt*self.moving*self.speedx
	self.x = self.x + dx

	local collided, collided_block = checkAllCollisions(self, blocks)
	
	if collided then
		--self.x = oldx
		while checkCollision(self, collided_block) do
			self.x = self.x-1*self.moving
		end
	end

	local oldy = self.y
	self.speedy = self.speedy + self.gravity*dt
	local dy = dt*self.speedy
	self.y = self.y + dy

	if checkAllCollisions(self, blocks) then
		self.y = oldy
		if self.speedy > 0 then
			self.grounded = true
		end
		self.speedy = 0
	else
		self.grounded = false
	end

	if self.grounded then
		if love.keyboard.isDown(' ') then
			self.speedy = self.jumpspeed
			self.grounded = false
		end
	end
end

function Player:draw()
	love.graphics.setColor(0, 0, 255, 255)
	love.graphics.rectangle("fill", math.floor(self.x), math.floor(self.y), self.height, self.height)
end

function Player:onCollide(collider) end

function Player:relocate(nx, ny)
	self.x = nx
	self.y = ny
end

function Player:getX()
	return self.x
end

function Player:getY()
	return self.y
end

function Player:getType()
	return 'player'
end

return Player