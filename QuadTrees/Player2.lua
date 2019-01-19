local Player = {}
Player.__index = Player

function Player.new(x, y)
	local self = setmetatable({}, Player)

	self.x = x
	self.y = y

	self.width = 16
	self.height = 16

	self.top = self.y-self.height/2
	self.bottom = self.y+self.height/2
	self.left = self.x-self.width/2
	self.right = self.x+self.width/2

	--player specific
	self.speed = 1 -- px/sec

	self.xdir = 0
	self.ydir = 0

	self.id = getNewID()

	return self
end

function Player:update(dt)
	self:getInputs()

	self.top = self.y-self.height/2
	self.bottom = self.y+self.height/2
	self.left = self.x-self.width/2
	self.right = self.x+self.width/2

	local xdir = self.keyRight - self.keyLeft
	local ydir = self.keyDown  - self.keyUp

	self.xdir, self.ydir = normalize(self.xdir, self.ydir)

	local velox = self.xdir * self.speed * dt
	local veloy = self.ydir * self.speed * dt

	self.x = self.x + velox
	self.y = self.y + veloy
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

return Player