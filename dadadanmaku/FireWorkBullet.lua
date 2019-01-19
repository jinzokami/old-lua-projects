local FireWorkBullet = {}
FireWorkBullet.__index = FireWorkBullet

function FireWorkBullet.new(x, y, angle, delay)
	local self = setmetatable({}, FireWorkBullet)

	self.position = {
		x = x,
		y = y,
	}
	self.angle = math.rad(angle)
	self.delay = delay -- in frames

	self.radius = 8

	self.speed = 50

	self.alive = true

	self.id = getNewID()

	self.bullets_per_shot = 30

	return self
end

function FireWorkBullet:update(dt)
	if self.delay < 0 then
		self:fire()
		self.alive = false
	end

	self.position.x = self.position.x + math.cos(self.angle) * self.speed
	self.position.y = self.position.y + math.sin(self.angle) * self.speed

	self.delay = self.delay - 1
end

function FireWorkBullet:draw()
	love.graphics.push()

	love.graphics.translate(self.position.x, self.position.y)
	love.graphics.rotate(self.angle)
	love.graphics.translate(-self.position.x, -self.position.y)

	love.graphics.setColor(255,0,0,255)
	love.graphics.circle("line", self.position.x, self.position.y, self.radius)

	love.graphics.pop()
end

function FireWorkBullet:fire()
	for i = 1, self.bullets_per_shot, 1 do
		local theta = 360/self.bullets_per_shot
		addEntity(BasicBullet.new(self.position.x, self.position.y, (theta*(i-1)) + 90))
	end
end

function FireWorkBullet:isAlive()
	return self.alive
end

return FireWorkBullet