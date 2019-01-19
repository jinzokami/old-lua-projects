Box = require("Box")

local Player = {}
Player.__index = Player

setmetatable(Player, {__call = function(x, y, image) return Player:new(x, y, image) end})

--Player.JUMP_SPEED = -100
--Player.GRAVITY = 100
Player.FRICTION = .75
Player.ACCELERATION = 50

Player.MAX_SPEED = 500
Player.MIN_SPEED = 10

function Player:new(x, y, image)
	local self = setmetatable({}, Player)

	self._x = x
	self._y = y

	self._image = image

	self._hitbox = Box(self._x, self._y, self._image:getWidth(), self._image:getHeight())

	--physics variables
	self._velocity = 0

	self._xdir = 0
	self._ydir = 0
	self._direction = 0
	self._moving = false

	return self
end

function Player:update(dt)
	--decide x direction (left or right)
	if love.keyboard.isDown("left") and love.keyboard.isDown("right") then
		self._xdir = 0
	elseif love.keyboard.isDown("left") then
		self._xdir = -1
	elseif love.keyboard.isDown("right") then
		self._xdir = 1
	else
		self._xdir = 0
	end

	--decide y direction (up or down)
	if love.keyboard.isDown("up") and love.keyboard.isDown("down") then
		self._ydir = 0
	elseif love.keyboard.isDown("up") then
		self._ydir = -1
	elseif love.keyboard.isDown("down") then
		self._ydir = 1
	else
		self._ydir = 0
	end

	--decide angle of movement
	if (self._xdir == 0) and (self._ydir == 0) then self._moving = false else self._moving = true end
	--warning:really long block of repetitive text. will fix if possible but this seems pretty straightforward.
	if (self._xdir == 1) and (self._ydir == 0) then self._direction = 0 end -- or 360. whatever, brah.
	if (self._xdir == 1) and (self._ydir == 1) then self._direction = 45 end
	if (self._xdir == 0) and (self._ydir == 1) then self._direction = 90 end
	if (self._xdir == -1) and (self._ydir == 1) then self._direction = 135 end
	if (self._xdir == -1) and (self._ydir == 0) then self._direction = 180 end
	if (self._xdir == -1) and (self._ydir == -1) then self._direction = 225 end
	if (self._xdir == 0) and (self._ydir == -1) then self._direction = 270 end
	if (self._xdir == 1) and (self._ydir == -1) then self._direction = 315 end

	--decide how far the player moves (get delta x and y)
	local deltax = math.cos(self._dir)*Player.ACCELERATION*dt
	local deltay = math.cos(self._dir)*Player.ACCELERATION*dt

	--check if new position overlaps anything
	self._hitbox = Box((self._x - (self._image:getWidth()/2))+deltax, (self._y - (self._image:getHeight()/2))+deltay, self._image:getWidth(), self._image:getHeight())
	if isCollidingAll(self._world, self._hitbox) then
		--collision handling
	end
end

function Player:draw()
	love.graphics.setColor(255,255,255,255)
	love.graphics.draw(self._image, self._x - (self._image:getWidth()/2), self._y - (self._image:getHeight()/2))
end

function Player:jump()
	self._yvel = Player.JUMP_SPEED
end

return Player