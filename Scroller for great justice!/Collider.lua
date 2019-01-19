local Collider = {}
Collider.__index = Collider

setmetatable(Collider, {__call = function(x, y) return Collider:new(x, y) end})

function Collider:new(x, y)
	local self = setmetatable({}, Collider)

	self._x = x
	self._y = y

	self._type = ""

	return self
end

function Collider:getX()
	return self._x
end

function Collider:setX(nx)
	self._x = nx
end

function Collider:getY()
	return self._y
end

function Collider:setY(ny)
	self._y = ny
end

function Collider:getType()
	return self._type
end

return Collider