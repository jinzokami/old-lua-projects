require("mathf")

local Entity = require("Entity")
local Camera = {}
setmetatable(Camera, {__index = Entity})

function Camera:new(x, y)
    local self = setmetatable({}, Camera)
    Camera.__index = Camera

    self.x = x
    self.y = y

    self.rot = 0
    --self.scale

    self.ox = 0
    self.oy = 0
    self.orot = 0

    self.target = -1--id of the cameras target

    self.parent = nil
    self.id = nil
    self.name = "camera"

    self.alive = true
    self.awake = true

    self.rumble_factor = 0--number from 1 to zero
    self.follow_factor = 0.1
    self.rumble_strength = 5

    return self
end

function Camera:postupdate(dt)
    local targ = self.parent:get(self.target)
    
    self.x = lerp(self.follow_factor, self.x, targ.x)
    self.y = lerp(self.follow_factor, self.y, targ.y)
end

function Camera:predraw()
    self.ox = math.random(-self.rumble_strength, self.rumble_strength)*self.rumble_factor
    self.oy = math.random(-self.rumble_strength, self.rumble_strength)*self.rumble_factor
    self.orot = math.rad(math.random(-self.rumble_strength, self.rumble_strength)*self.rumble_factor)
    
    love.graphics.push()

    love.graphics.translate(self.ox, self.oy)
    love.graphics.translate((love.graphics.getWidth()/2)-self.x, (love.graphics.getHeight()/2)-self.y)
    
    love.graphics.translate(self.x, self.y)
    love.graphics.rotate(self.orot)
    love.graphics.rotate(self.rot)
    love.graphics.translate(-self.x, -self.y)
end

function Camera:postdraw()
    love.graphics.pop()
end

return Camera