local Block = {}
Block.__index = Block

function Block.new(x, y)
	local self = setmetatable({}, Block)

	self.x = x
	self.y = y
	self.height = 16
	self.width = 16

	return self
end

function Block:update(dt)

end

function Block:draw()
	love.graphics.setColor(255, 0, 0, 255)
	love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function Block:onCollide() end

function Block:getType()
	return "block"
end

return Block