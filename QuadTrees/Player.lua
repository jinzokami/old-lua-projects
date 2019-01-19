local Player = {}
Player.__index = Player

Player.enum = {
	NORMAL_STATE = 1, -- standing, no buttons pressed. no directions or two opposing directions pressed
	WALKING_STATE = 2, -- walking, one or two non opposing directions pressed
	ATTACKING_STATE = 3, -- attacking, attack button pressed
	SWIMMING_STATE = 4,
	PUSHING_STATE = 5
}

function Player.new(x, y)
	local self = setmetatable({}, Player)

	self.x = x
	self.y = y

	self.width = 16
	self.height = 16

	--shortcuts for the sides
	self.top    = self.y - self.height / 2
	self.bottom = self.y + self.height / 2
	self.left   = self.x - self.width  / 2
	self.right  = self.x + self.width  / 2

	self.id = getNewID()
	self.type = "player"

	self.dir = "down" -- which way the player is facing (independent of movement direction)


	--player specific
	self.speed = 1 -- px/frame

	self.xdir = 0
	self.ydir = 0

	self.velox = 0
	self.veloy = 0
	
	return self
end

function Player:update(dt)
	self:getInputs()

	self.top    = self.y - self.height / 2
	self.bottom = self.y + self.height / 2
	self.left   = self.x - self.width  / 2
	self.right  = self.x + self.width  / 2

	self.xdir = self.keyRight - self.keyLeft
	self.ydir = self.keyDown  - self.keyUp

	self.velox = self.xdir * self.speed
	self.veloy = self.ydir * self.speed

	self.x = self.x + self.velox
	self.y = self.y + self.veloy
end

function Player:draw()
	love.graphics.setColor(255,255,255,255)
	love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function Player:getInputs() -- this only runs once a frame, so don't worry about cpu usage
	self.keyLeft  = 0
	self.keyRight = 0
	self.keyUp    = 0
	self.keyDown  = 0

	self.keyItem1 = 0
	self.keyItem2 = 0

	if love.keyboard.isDown('left') then
		self.keyLeft = 1
	end

	if love.keyboard.isDown('right') then
		self.keyRight = 1
	end

	if love.keyboard.isDown('up') then
		self.keyUp = 1
	end

	if love.keyboard.isDown('down') then
		self.keyDown = 1
	end

	if love.keyboard.isDown('z') then
		self.keyItem1 = 1
	end

	if love.keyboard.isDown('x') then
		self.keyItem2 = 1
	end
end

function Player:onCollide(collidedObj)
	if collidedObj.type == 'obstacle' then
		self.x = self.x - self.velox
		self.y = self.y - self.veloy

		while colliding(self.x + self.velox, self.y, self.width, self.height, collidedObj.x, collidedObj.y, collidedObj.width, collidedObj.height) do
			self.velox = self.velox - sign(self.velox)
		end

		self.x = self.x + self.velox

		while colliding(self.x, self.y + self.veloy, self.width, self.height, collidedObj.x, collidedObj.y, collidedObj.width, collidedObj.height) do
			self.veloy = self.veloy - sign(self.veloy)
		end

		self.y = self.y + self.veloy

	end
end

return Player