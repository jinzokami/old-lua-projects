local Entity = require("Entity")
local Block = {}
setmetatable(Block, {__index = Entity})

function Block:new(x, y)
    local self = setmetatable({}, Block)
    Block.__index = Block

    self.x = x
    self.y = y
    self.w = 32
    self.h = 32
    self.image = love.graphics.newImage("red_block.png")

    self.alive = true
    self.awake = true
    self.name = "block"
    self.parent = nil
    self.id = nil

    return self
end

function Block:draw()
    love.graphics.draw(self.image, self.x - self.w/2, self.y - self.h/2)
end

return Block