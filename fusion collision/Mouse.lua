local Mouse = {}
Mouse.__index = Mouse

setmetatable(Mouse, {__call = function (cls, ...) return cls:new(...) end})

function Mouse:new()
	local self = setmetatable({}, Mouse)

	love.mouse.setVisible(false)

	self._x = love.mouse.getX()
	self._y = love.mouse.getY()
	self._cursor = love.graphics.newImage("res/cursor.png")

	self._buttons = {}
	self._buttons["l"] = false
	self._buttons["r"] = false

	self._dragging = false

	self._colliding = true
	self._type = "box"

	return self
end

function Mouse:update(dt)
	self._x = love.mouse.getX()
	self._y = love.mouse.getY()

	self._colliding = not self._dragging
end

function Mouse:draw()
	love.graphics.setColor(255,255,255,255)
	love.graphics.draw(self._cursor, self._x, self._y)
end

--getters and setters
function Mouse:click(button)
	self._buttons[button] = true
end

function Mouse:release(button)
	self._buttons[button] = false
end

function Mouse:isLeftClicked()
	return self._buttons["l"]
end

function Mouse:isRightClicked()
	return self._buttons["r"]
end

function Mouse:isDragging()
	return self._dragging
end

function Mouse:setDragging(nd)
	self._dragging = nd
end

function Mouse:getX()
	return self._x
end

function Mouse:setX(nx)
	self._x = nx
end

function Mouse:getY()
	return self._y
end

function Mouse:setY(ny)
	self._y = ny
end

function Mouse:getColliding()
	return self._colliding
end

function Mouse:getType()
	return self._type
end

function Mouse:getWidth()
	return 1
end

function Mouse:getHeight()
	return 1
end

return Mouse