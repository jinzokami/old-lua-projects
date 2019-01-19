Box = require("Box")
Circle = require("Circle")

--assets
images = {}
images.player = love.graphics.newImage("res/Golem.png")

local Game = {}
Game.__index = Game

--[[
functions:
new(): creates a new instance of Game
	returns new instance
update(number dt): updates the instance of Game handles game logic
	returns nothing
draw(): blits images on to the screen
	returns nothing
keypressed(string key): executes whenever a key is pressed, sends a string indicating which key was pressed
	returns nothing
keyreleased(string key): executes whenever a key is released, sends a string indicating which key was released
	returns nothing
mousepressed(number x, number y, string button): executes every click (be it middle, left or right) sends the x and y coordinates and a string indicating the button pressed
	returns nothing
mousereleased(number x, number y, string button): executes every time a mouse button is released, sends the x and y coordinates and a string indicating the button released
	returns nothing
addEntity(Entity ne): adds a new instance of an entity
	returns nothing

]]

setmetatable(Game, {__call = function() return Game:new() end})

function Game:new()
	local self = setmetatable({}, Game)

	self._entities = {}

	return self
end

function Game:update(dt)
	for i, v in ipairs(self._entities) do
		v:update(dt)
	end
end

function Game:draw()
	for i, v in ipairs(self._entities) do
		v:draw()
	end
end

function Game:keypressed(key)
	for i, v in ipairs(self._entities) do
		v:keypressed(key)
	end
end

function Game:keyreleased(key)
	for i, v in ipairs(self._entities) do
		v:keyreleased(key)
	end
end

function Game:mousepressed(x, y, button)
	for i, v in ipairs(self._entities) do
		v:mousepressed(x, y, button)
	end
end

function Game:mousereleased(x, y, button)
	for i, v in ipairs(self._entities) do
		v:mousepressed(x, y, button)
	end
end

function Game:addEntity(ne)
	table.insert(self._entities, ne)
	return ne
end

return Game