Player = class("Player")

function Player:initialize(x, y)
	self.id = getNewEntityID()
	self.collider = AABB(x, y, 16, 16)
	
	self.collider.speedLimit = 100
	self.collider.friction = .9
end

function Player:update(dt)
	if love.keyboard.isDown("left")  then self.collider:addImpulse(-500,  0  ) end
	if love.keyboard.isDown("right") then self.collider:addImpulse( 500,  0  ) end
	if love.keyboard.isDown("up")    then self.collider:addImpulse(   0, -500) end
	if love.keyboard.isDown("down")  then self.collider:addImpulse(   0,  500) end

	self.collider:update(dt)

	local isColliding, collided = self.collider:isColliding()

	if isColliding then
		Player:handleCollision(collided)
	end
end

function Player:handleCollision(collider)
	
end

function Player:draw()
	--draw player stuff at the location of the collision box
	love.graphics.rectangle("line", self.collider.position.x, self.collider.position.y, self.collider.width, self.collider.height)
end
