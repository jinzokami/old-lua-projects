--------------------------------------------------
--[[
notes: 
add menus (main menu, level select, options maybe)
add enemies, hazards, and items
add placeholder sprites and tilesets
add slopes

BasicEnemy jumps whenever it touches a wall
]]
--------------------------------------------------

require("Helpers")
Game = require("Game")
require("levels")

spawnx = 0
spawny = 0
tilesize = 16

function love.load()
	Game.new()
end

function love.update(dt)
	Game.update(dt)
end

function love.draw()
	Game.draw()
end

function love.keypressed(key)
	Game.keypressed(key)
end