local Player = {}
Player.__index = Player

--[[
functions:
variables:
]]

setmetatable(Player, {__call = function(x, y) return Player:new(x, y) end})

Player.JUMP_SPEED = -100
Player.GRAVITY = 100
Player.FRICTION = .75
Player.ACCELERATION = 50

Player.MAX_SPEED = 500
Player.MIN_SPEED = 10

function Player:new(x, y)
	local self = setmetatable({}, Player)

	self._x = x
	self._y = y

	self._image = love.graphics.newImage("res/golem.png")

	self._hitbox = Box(self._x, self._y, self._image:getWidth(), self._image:getHeight())

	--physics variables
	self._xvel = 0
	self._yvel = 0

	self._dir = 0

	self._id = setID()

	return addEntity(self, self._id)
end

function Player:update(dt)
	if love.keyboard.isDown("left") and love.keyboard.isDown("right") then
		self._dir = 0
	elseif love.keyboard.isDown("left") then
		self._dir = -1
	elseif love.keyboard.isDown("right") then
		self._dir = 1
	else
		self._dir = 0
	end

	self._hitbox = Box(self._x - (self._image:getWidth()/2), self._y - (self._image:getHeight()/2), self._image:getWidth(), self._image:getHeight())
	--decide how far the player moves (get delta x and y)
	self._xvel = self._xvel + Player.ACCELERATION*self._dir
	self._xvel = self._xvel * Player.FRICTION
	--add speed cap and cutoff

	self._yvel = self._yvel + Player.GRAVITY
	--add speed cap and cutoff
	
	--check if new position overlaps anything
end

function Player:draw()
	love.graphics.setColor(255,255,255,255)
	love.graphics.draw(self._image, self._x - (self._image:getWidth()/2), self._y - (self._image:getHeight()/2))
end

function Player:jump()
	self._yvel = Player.JUMP_SPEED
end

function Player:getID()
	return self._id
end

return Player