Animation = require("Animation")

local Boog = {}
Boog.__index = Boog

function Boog:new(x, y)
	local self = setmetatable({}, Boog)

	self.x = x
	self.y = y
	turnDir = (math.random()*2)-1
	self.turn = 180*turnDir

	self.image = playerImage
	self.animation = Animation:new(self.image, 32, 32, 1*math.random())
	self.animation:play()

	self.deathTimer = math.random()*5

	self.id = getNewID()

	return self
end

function Boog:update(dt)
	self.deathTimer = self.deathTimer-dt
	if self.deathTimer < 0 then removeEntity(self.id) end

	self.animation:update(dt)

	self.turn = self.turn - 10*dt

	local dx = math.cos(self.turn)*30
	local dy = math.sin(self.turn)*30

	self.x = self.x + dx*dt
	self.y = self.y + dy*dt
end

function Boog:draw()
	self.animation:draw(self.x, self.y)
end

return Boog