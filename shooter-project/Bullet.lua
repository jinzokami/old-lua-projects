local Entity = require("Entity")
local Bullet = {}
setmetatable(Bullet, {__index = Entity})

function Bullet:new(x, y, dirx, diry)
    local self = setmetatable({}, Bullet)
    Bullet.__index = Bullet

    self.x = x
    self.y = y

    self.speed = 320
    self.xspeed = nil
    self.yspeed = nil

    self.rot = nil

    self.alive = true

    self.image = love.graphics.newImage("shot1.png")

    --self.bounces = 0
    --self.max_bounces = 3

    self.w = 16
	self.h = 16
	
	self.id = nil
	self.name = "bullet"
    self.parent = nil
    
    self.alive = true
    self.awake = true

    return self
end

function Bullet:update(dt)
    self.x = self.x + self.xspeed * dt
    self.y = self.y + self.yspeed * dt
end

function Bullet:draw()
    love.graphics.push()
    
    love.graphics.translate(self.x, self.y)
    love.graphics.rotate(self.rot)
    love.graphics.translate(-self.x, -self.y)
    
    love.graphics.draw(self.image, self.x - self.w/2, self.y - self.h/2)
    
    love.graphics.pop()
end

return Bullet