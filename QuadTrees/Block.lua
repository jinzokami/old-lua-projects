local Block = {}
Block.__index = Block

function Block.new(x, y)
	local self = setmetatable({}, Block)

	self.x = x
	self.y = y
	self.width = 16
	self.height = 16

	self.top    = self.y - self.height / 2
	self.bottom = self.y + self.height / 2
	self.left   = self.x - self.width  / 2
	self.right  = self.x + self.width  / 2

	self.id = getNewID()
	self.type = "obstacle"

	return self
end
function Block:update(dt) end
function Block:draw()
	love.graphics.setColor(255,255,255,255)
	love.graphics.rectangle("fill", math.floor(self.x), math.floor(self.y), self.width, self.height)
end

function Block:onCollide() end

return Block