local Camera = {}
Camera.__index = Camera

Camera.x = 0
Camera.y = 0
Camera.scale = 1

function Camera.set()
	love.graphics.push()
	love.graphics.translate(Camera.x, Camera.y)
	love.graphics.scale(Camera.scale)
end

function Camera.unset()
	love.graphics.pop()
end

function Camera.move(nx, ny)
	Camera.x = nx
	Camera.y = ny
end

function Camera.setScale(ns)
	Camera.scale = ns
end

return Camera