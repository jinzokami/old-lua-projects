local Box = {}
Box.__index = Box

setmetatable(Box, {__call = function (cls, ...) return cls:new(...) end})

function Box:new(x, y, w, h) --(x position, y position, width, height)
	local self = setmetatable({}, Box)

	self._x = x
	self._y = y
	self._w = w
	self._h = h

	self._oldx = 0
	self._oldy = 0

	self._type = "box"

	table.insert(entities, self)
	return self
end

function Box:update(dt)
	if mouse:isLeftClicked() and (not self._clicked) and (mouse:getColliding()) then 
		if isOverlapping(self, mouse) and (not mouse:isDragging()) then
			self._clicked = true
			mouse:setDragging(true)
			self._oldx = self._x
			self._oldy = self._y
		end 
	end

	if self._clicked then
		if mouse:isLeftClicked() then
			self._x = mouse:getX() - self._w/2
			self._y = mouse:getY() - self._h/2
		else
			self._clicked = false
			mouse:setDragging(false)
		end
	end
end

function Box:draw()
	if self._w == self._h then
		love.graphics.setColor(255, 255, 100, 100)
	else
		love.graphics.setColor(255, 255, 255, 100)
	end
	
	love.graphics.rectangle("fill", self._x, self._y, self._w, self._h)
end

--getters and setters
function Box:getX()
	return self._x
end

function Box:setX(nx)
	self._x = nx
end

function Box:getY()
	return self._y
end

function Box:setY(ny)
	self._y = ny
end

function Box:getWidth()
	return self._w
end

function Box:getHeight()
	return self._h
end

function Box:getType()
	return self._type
end

return Box