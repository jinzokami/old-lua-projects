local BasicEnemy = {}
BasicEnemy.__index = BasicEnemy

--[[
TODO: add a small delay after a jump during which you cannot jump
]]

function BasicEnemy.new(x, y)
	local self = setmetatable({}, BasicEnemy)
	
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
	self.direction = 'left'
	self.jumpTimer = 2
	self.jumpdelay = 0.5
	
	return self
end

function BasicEnemy:update(dt)
	if self.direction == 'left' then
		self.moving = -1
	end

	if self.direction == 'right' then
		self.moving = 1
	end

	if (not (self.direction == 'left')) and (not (self.direction == 'right')) then
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

		--check if there is a block above the collided block
		--if not, jump without changing direction
		--otherwise change direction

		if checkCollisionAt((self.x+self.width*self.moving)+1, self.y-self.height, blocks) then
			if self.direction == 'left' then
				self.direction = 'right'
			else
				self.direction = 'left'
			end
		else
			self:jump()
			self.jumpdelay = 0.5
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

	self.jumpdelay = self.jumpdelay - dt
	if self.grounded then
		self.jumpTimer = self.jumpTimer - dt
		if self.jumpTimer < 0 then
			self:jump()
			self.jumpTimer = 1000
			self.jumpdelay = 0.5
		end
	end
end

function BasicEnemy:draw()
	love.graphics.setColor(255, 255, 0, 255)
	love.graphics.rectangle("fill", math.floor(self.x), math.floor(self.y), self.width, self.height)
end

function BasicEnemy:jump()
	if self.grounded then
		self.speedy = self.jumpspeed
		self.grounded = false
	end
end

function BasicEnemy:onCollide(collider) end

function BasicEnemy:relocate(nx, ny)
	self.x = nx
	self.y = ny
end

function BasicEnemy:getX()
	return self.x
end

function BasicEnemy:getY()
	return self.y
end

function BasicEnemy:getType()
	return "enemy"
end

return BasicEnemy