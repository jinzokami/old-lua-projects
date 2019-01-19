--[[
I'm back, bitches!
now i'm armed with the knowledge of my ancestors ready to rock your sidescroller into oblivion!
objective:
use the new collision detection algorithm you learned to create and subsequently vanquish your foes!
learn new techniques in the process and above all...
do it for great justice!
]]

--[[
Checklist:
	collision detection --done, i think
	collision handling
	objects and entities
		player and basic enemy
	maps
	animation
	sound(which i haven't really messed with)
	
]]

Game = require("Game")

function love.load()
	game = Game()
end

function love.update(dt)
	game:update(dt)
end

function love.draw()
	game:draw()
end

function love.keypressed(key)
	game:keypressed(key)
end

function love.keyreleased(key)
	game:keyreleased(key)
end

function love.mousepressed(x, y, button)
	game:mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
	game:mousereleased(x, y, button)
end

function addEntity(ne)
	game:addEntity(ne)
end