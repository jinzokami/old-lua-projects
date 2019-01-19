local CircleSpreadGun = {}
CircleSpreadGun.__index = CircleSpreadGun

function CircleSpreadGun.new(x, y, bullets_per_shot, timer)
	local self = setmetatable({}, CircleSpreadGun)

	self.position = {
		x = x,
		y = y,
	}
	self.bullets_per_shot = bullets_per_shot

	self.active = true
	self.reset_timer = timer -- in frames
	self.timer = timer

	self.id = getNewID()

	self.alive = true

	return self
end

function CircleSpreadGun:update(dt)
	
	if self.timer < 0 then
		self.timer = self.reset_timer
		self:shoot()
	end

	if self.active then
		self.timer = self.timer - 1
	end
end

function CircleSpreadGun:draw()
end

function CircleSpreadGun:shoot()
	for i = 1, self.bullets_per_shot, 1 do
		local theta = 360/self.bullets_per_shot
		addEntity(BasicBullet.new(self.position.x, self.position.y, (theta*(i-1)) + 90))
	end
end

function CircleSpreadGun:start()
	self.active = true
end

function CircleSpreadGun:stop()
	self.active = false
	self.timer = self.reset_timer
end

function CircleSpreadGun:getID()
	return self.id
end

function CircleSpreadGun:isAlive()
	return self.alive
end

return CircleSpreadGun