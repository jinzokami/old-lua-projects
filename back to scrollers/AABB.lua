AABB = class('AABB')

function AABB:initialize(x, y, width, height)
	self.position = Vector2(x,y)
	self.velocity = Vector2(0,0)

	self.width = width
	self.height = height
	self.friction = 1
	self.speedLimit = nil
end

function AABB:update(dt)
	if self.speedLimit then
		if self.velocity:getMagnitude() > self.speedLimit then
			local dir = self.velocity:getNormalized()
			self.velocity = dir*self.speedLimit
		end
	end

	self.velocity = self.velocity*self.friction
	self.position = self.position + self.velocity*dt
end

function AABB:addImpulse(x, y)
	self.velocity.x = self.velocity.x + x
	self.velocity.y = self.velocity.y + y
end

function AABB:collisionHandler(collider) end -- define this later
