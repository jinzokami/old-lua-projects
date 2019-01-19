--[[
moving left and right moves the player perpendicular to the direction of gravity
]]
local Player = {}
Player.__index = Player

function Player:new(x, y)
	local self = setmetatable({}, Player)

	self.x = x
	self.y = y
	self.width = 32
	self.height = 32
	self.angle = 0
	self.type = "player"

	self.refImage = nil
	self.image = nil

	return self
end

function Player:update(dt)
	--debug code:
	if love.keyboard.isDown('left') then
		self.x = self.x - 100 * dt
	end
	if love.keyboard.isDown('right') then
		self.x = self.x + 100 * dt
	end
	if love.keyboard.isDown('up') then
		self.y = self.y - 100 * dt
	end
	if love.keyboard.isDown('down') then
		self.y = self.y + 100 * dt
	end

	--END debug code

	--check all sources of gravity against current position
	--the closer the source the greater the pull
	--player turns to the greatest source
	local allSources, strongestSource = self:checkAllSources()
	self.angle = math.deg(math.atan2(self.x - strongestSource.x, -(self.y - strongestSource.y)))
	
	local downwardPush = strongestSource.strength*(100/math.min(100, distance(self.x, self.y, strongestSource.x, strongestSource.y)))
	
	local deltax = math.cos(self.angle)*downwardPush*dt
	local deltay = math.sin(self.angle)*downwardPush*dt

	--collision detection here, please

	self.x = self.x + deltax
	self.y = self.y + deltay
end

function Player:draw()
	love.graphics.setColor(0, 0, 255, 255)
	
	love.graphics.push()
	
	love.graphics.translate(self.x, self.y)--sets the origin of the image to the center of the bottom edge
	love.graphics.rotate(math.rad(self.angle))
	love.graphics.translate(-self.x, -self.y)--moves the origin back, from this point the image only retains the rotation
	
	love.graphics.rectangle("fill", self.x-(self.width/2), self.y-self.height, self.width, self.height)--draw whatever right now it's immediate drawing, eventually it will be an image or
	
	love.graphics.pop()

	love.graphics.setColor(255, 0, 0, 255)
	love.graphics.point(self.x, self.y)

	love.graphics.setColor(255,255,255,255)
	love.graphics.print("x: "..self.x, 0, 0)
	love.graphics.print("y: "..self.y, 0, 10)
end

function Player:onCreate()

end

function Player:checkAllSources()
	local sources = checkSources()

	function orderStrength(a, b)
		return a.strength*(100/distance(self.x, self.y, a.x, a.y)) < b.strength*(100/distance(self.x, self.y, b.x, b.y))
	end
	table.sort(sources, orderStrength)

	return sources, sources[#sources]
end

return Player