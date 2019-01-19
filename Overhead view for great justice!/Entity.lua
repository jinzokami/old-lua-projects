local Entity = {}
Entity.__index = Entity

setmetatable(Entity, {__call = function(x, y, image) return Entity:new(x, y, image) end})

function Entity:new(x, y, image)
	local self = setmetatable({}, Entity)

	self._x = x
	self._y = y

	self._image = image

	return self
end

function Entity:update(dt)

end

function Entity:draw()
	love.graphics.setColor(255,255,255,255)
	love.graphics.draw(self._image, self._x, self._y)
end

return Entity