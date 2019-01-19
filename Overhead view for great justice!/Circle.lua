Collider = require("Collider")

local Circle = {}
Circle.__index = Circle

setmetatable(Circle, {__call = function(x, y, r) return Circle:new(x, y, r) end})

function Circle:new(x, y, r)
	local self = Collider(x, y)
	setmetatable(self, Circle)

	self._r = r
	self._type = "circle"

	return self
end

function Circle:getRadius()
	return self._r
end

return Circle