local Circle = {}
Circle.__index = Circle

setmetatable(Circle, {__call = function (cls, ...) return cls:new(...) end})

function Circle:new(x, y, r)
	local self = setmetatable({}, Circle)

	self._x = x
	self._y = y
	self._r = r

	self._oldx = 0
	self._oldy = 0

	self._type = "circle"

	table.insert(entities, self)
	return self
end

function Circle:update(dt)
	if mouse:isLeftClicked() and (not self._clicked) and (mouse:getColliding())then 
		if isOverlapping(self, mouse) and (not mouse:isDragging()) then
			self._clicked = true
			mouse:setDragging(true)
			self._oldx = self._x
			self._oldy = self._y
		end 
	end

	if self._clicked then
		if mouse:isLeftClicked() then
			self._x = mouse:getX()
			self._y = mouse:getY()
		else
			self._clicked = false
			mouse:setDragging(false)
		end
	end
end

function Circle:draw()
	love.graphics.setColor(255,255,255,50)
	love.graphics.circle("fill", self._x, self._y, self._r, 20)
end

--getters and setters
function Circle:getX()
	return self._x
end

function Circle:setX(nx)
	self._x = nx
end

function Circle:getY()
	return self._y
end

function Circle:setY(ny)
	self._y = ny
end

function Circle:getRadius()
	return self._r
end

function Circle:getType()
	return self._type
end

return Circle