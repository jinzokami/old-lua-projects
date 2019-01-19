BasicBullet = require("BasicBullet")
FireWorkBullet = require("FireWorkBullet")
CircleSpreadGun = require("CircleSpreadGun")

function love.load()
	global_entities = {}
	player = Player.new(100, 600)
	addEntity(player)
end

function love.update(dt)
	--
	for i, v in ipairs(global_entities) do
		if v:isAlive() then
			v:update(dt)
		end
	end

	--collision detection

	--entity cleanup
	for i, v in ipairs(global_entities) do
		if not v:isAlive() then
			table.remove(global_entities, i)
		end
	end
end

function love.draw()
	for i, v in ipairs(global_entities) do
		v:draw()
	end
end

function love.keypressed(key, scancode, isRepeat)
	if key == 'escape' then
		love.event.push("quit")
	end	
end

function addEntity(entity) -- add a new entity to the game and sets their id
	table.insert(global_entities, entity)
end

function getEntity(id)
	for i = 1, #global_entities, 1 do
		if global_entities[i]:getID() == id then
			return global_entities[i]
		end
	end
	return false
end

global_current_id = 0
function getNewID()
	global_current_id = global_current_id + 1
	return global_current_id
end

Player = {}
Player.__index = Player

function Player.new(x, y)
	local self = setmetatable({}, Player)

	self.position = {
		x = x,
		y = y
	}

	self.gun_level = 1


	self.sprite = love.graphics.newImage("Plane Frame 1.png")

	self.alive = true
	self.bullet_delay = 0 -- in frames
	self.bullet_delay_reset = 15

	self.speed = 2

	return self
end

function Player:update(dt)
	local xspeed = 0
	local yspeed = 0
	if love.keyboard.isDown('left') then
		xspeed = xspeed - self.speed
	end

	if love.keyboard.isDown('right') then
		xspeed = xspeed + self.speed
	end

	if love.keyboard.isDown('up') then
		yspeed = yspeed - self.speed
	end

	if love.keyboard.isDown('down') then
		yspeed = yspeed + self.speed
	end

	if self.bullet_delay <= 0 then
		if love.keyboard.isDown('space') then
			addEntity(BasicBullet.new(self.position.x, self.position.y - 16, -90))
			self.bullet_delay = self.bullet_delay_reset
		end
	end

	self.position.x = self.position.x + xspeed
	self.position.y = self.position.y + yspeed

	self.bullet_delay = self.bullet_delay - 1
end

function Player:draw()
	love.graphics.draw(self.sprite, self.position.x - self.sprite:getWidth()/2, self.position.y - self.sprite:getHeight()/2)
end

function Player:isAlive()
	return self.alive
end