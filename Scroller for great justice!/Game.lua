Box = require("Box")
Circle = require("Circle")
Player = require("Player")

local Game = {}
Game.__index = Game

--[[
functions:
new(): creates a new instance of Game
	returns new instance of Game
update(number dt): updates the instance of Game handles game logic
	returns nothing
draw(): draws images to the screen
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
setID(): sets the id of a new entity to 1 + the last id also increases the last id by one
	returns number

variables:
_entities: will hold ALL of the entities in the game. ie. anything that needs to be drawn or updated
	type - table
_lastID: the last ID assigned to an entity
	type - number
]]

setmetatable(Game, {__call = function() return Game:new() end})

function Game:new()
	local self = setmetatable({}, Game)

	self._entities = {}
	self._lastID = 0
	self._currentState = require("TestLevel")
	self:loadAssets()

	return self
end

function Game:loadAssets()
	images = {}
	animations = {}
	sounds = {}
end

function Game:update(dt)
	self._currentState:update(dt)
end

function Game:draw()
	self._currentState:draw()
end

function Game:keypressed(key)
	self._currentState:keypressed(key)
end

function Game:keyreleased(key)
	self._currentState:keyreleased(key)
end

function Game:setID()
	self._lastID = self._lastID + 1
	return self._lastID
end

return Game