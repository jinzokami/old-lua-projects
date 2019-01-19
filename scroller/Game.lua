require("levels")
Camera = require("Camera")
Player = require("Player")
BasicEnemy = require("BasicEnemy")
Block = require("Block")
Exit = require("Exit")
PauseMenu = require("PauseMenu")
BoundingBox = require("BoundingBox")

paused = false

local Game = {}
Game.__index = Game

function Game.new()
	blocks = {}
	enemies = {}
	makeMap(LEVEL_1)
	p = Player.new(spawnx, spawny)
end

function Game.update(dt)
	if not paused then
		p:update(dt)
		Camera.move(math.floor(-p:getX() + (love.graphics.getWidth()/2)), math.floor(-p:getY() + (love.graphics.getHeight()/2)))

		for i, v in ipairs(blocks) do
			v:update(dt)
		end

		for i, v in ipairs(enemies) do
			v:update(dt)
		end
	else
		PauseMenu.update()
	end
end

function Game.draw(x, y)
	if not paused then
		Camera.set()
		p:draw()

		for i, v in ipairs(blocks) do
			v:draw()
		end

		for i, v in ipairs(enemies) do
			v:draw()
		end

		Camera.unset()
	else
		PauseMenu.draw()
	end
end

function Game.keypressed(key) 
	if key == 'escape' then 
		paused = not paused
	else
		if paused then PauseMenu.keypressed(key) end
	end
end

return Game