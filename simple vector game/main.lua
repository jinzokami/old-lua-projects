Vector2 = require("Vector2")
Player = require("Player")

function love.load()
	player = Player.new(20, 20)	
end

function love.update(dt)
	player:update(dt)
end

function love.draw()
	player:draw()
end

function love.keypressed(key)
	
end
