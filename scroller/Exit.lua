local Exit = {}
Exit.__index = Exit

function Exit.new(x, y)
	local self = setmetatable({}, Exit)

	self.x = x
	self.y = y
	self.height = 16
	self.width = 16

	return self
end

function Exit:update(dt)

end

function Exit:draw()
	love.graphics.setColor(0, 255, 0, 255)
	love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function Exit:onCollide(collider)
	if collider:getType() == 'player' then
		current_level.onComplete()
	end
end

function Exit:getType()
	return "exit"
end

return Exit