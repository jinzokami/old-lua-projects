class = require("middleclass.middleclass").class

love.graphics.setDefaultFilter("nearest", "nearest")

require("Animation")
require("Player")
require("AABB")
require("Vector2")

tilesize = 16

function love.load()
	currentEntityID = -1
	currentColliderID = -1
	
	player = Player(64, 64)
end

function love.update(dt)
	player:update(dt)
end

function love.draw()
	player:draw()
end

function love.mousepressed(x, y, button)
	
end

function getNewEntityID()
	currentEntityID = currentEntityID + 1
	return currentEntityID
end