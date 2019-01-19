Collider = require("Collider")

local Box = {}
Box.__index = Box

setmetatable(Box, {__call = function(x, y, w, h) return Box:new(x, y, w, h) end})

function Box:new(x, y, w, h)
	local self = Collider(x, y)
	setmetatable(self, Box)

	self._w = w
	self._h = h

	self._type = "box"

	return self
end

function Box:getWidth()
	return self._w
end

function Box:getHeight()
	return self._h
end

return Box