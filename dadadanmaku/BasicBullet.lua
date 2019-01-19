local BasicBullet = {}
BasicBullet.__index = BasicBullet

function BasicBullet.new(x, y, angle)
	local self = setmetatable({}, BasicBullet)
	
	self.position = {
		x = x,
		y = y,
	}
	self.radius = 4
	
	self.angle = math.rad(angle)

	self.speed = 5

	self.id = getNewID()

	self.alive = true

	return self
end

function BasicBullet:update(dt)
	self.position.x = self.position.x + math.cos(self.angle)*self.speed
	self.position.y = self.position.y + math.sin(self.angle)*self.speed

	if (self.position.x > love.graphics.getWidth()+self.radius) or 
		(self.position.x < -self.radius) or 
		(self.position.y > love.graphics.getHeight()+self.radius) or 
		(self.position.y < -self.radius) then
		self.alive = false
	end
end

function BasicBullet:draw()
	love.graphics.push()

	love.graphics.translate(self.position.x, self.position.y)
	love.graphics.rotate(self.angle)
	love.graphics.translate(-self.position.x, -self.position.y)

	love.graphics.setColor(255,255,255,255)
	love.graphics.circle("line", self.position.x, self.position.y, self.radius)
	love.graphics.pop()
end

function BasicBullet:getID()
	return self.id
end

function BasicBullet:isAlive()
	return self.alive
end

return BasicBullet