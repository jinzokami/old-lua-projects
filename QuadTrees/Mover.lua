local Mover = {}
Mover.__index = Mover

function Mover.new()
	local self = setmetatable({}, Mover)
	self.x = 400
	self.y = 300

	self.width = 16
	self.height = 16

	self.top = self.y-self.height/2
	self.bottom = self.y+self.height/2
	self.left = self.x-self.width/2
	self.right = self.x+self.width/2

	self.xdir = clamp(love.math.random(), 0.5, 1)
	self.ydir = clamp(love.math.random(), 0.5, 1)

	self.collided = false

	self.id = getNewID() -- the ID of the object, used for managing objects
	return self
end

function Mover:update(dt)
	self.collided = false

	self.x = self.x + self.xdir
	self.y = self.y + self.ydir

	self.top = self.y-self.height/2
	self.bottom = self.y+self.height/2
	self.left = self.x-self.width/2
	self.right = self.x+self.width/2

	self.points = {
		self.left, self.top,
		self.right, self.top,
		self.right, self.bottom,
		self.left, self.bottom
	}
	
	if self.right > 800 then
		self.xdir = -self.xdir
		self.x = self.x + self.xdir
	end
	if self.left < 0 then
		self.xdir = -self.xdir
		self.x = self.x + self.xdir
	end
	
	if self.bottom > 600 then
		self.ydir = -self.ydir
		self.y = self.y + self.ydir
	end
	if self.top < 0 then
		self.ydir = -self.ydir
		self.y = self.y + self.ydir
	end
end

function Mover:draw()
	love.graphics.setColor(255,255,255,255)
	if self.collided then
		love.graphics.setColor(255,0,0,255)
	end
	love.graphics.polygon("line", self.points)
end

function Mover:onCollide(collidedObj)
	self.collided = true

	if self.left < collidedObj.left then
		self.xdir = math.abs(self.xdir) * -1
		collidedObj.xdir = math.abs(collidedObj.xdir)
	end

	if self.right > collidedObj.right then
		self.xdir = math.abs(self.xdir)
		collidedObj.xdir = math.abs(collidedObj.xdir) * -1
	end

	if self.top < collidedObj.top then
		self.ydir = math.abs(self.ydir) * -1
		collidedObj.ydir = math.abs(collidedObj.ydir)
	end

	if self.bottom > collidedObj.bottom then
		self.ydir = math.abs(self.ydir)
		collidedObj.ydir = math.abs(collidedObj.ydir) * -1
	end
end

return Mover