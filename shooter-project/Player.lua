local Entity = require("Entity")
local Player = {}
setmetatable(Player, {__index = Entity})

function Player:new(x, y)
    local self = setmetatable({}, Player)
    Player.__index = Player
    
    self.x = x
    self.y = y

    self.xvel = 0
    self.yvel = 0

    self.shot_dir_x = 1
    self.shot_dir_y = 0

    self.walk_speed = 3200
    self.friction = 0.95
    --self.dash_speed = 10

    --self.dash_timer = 0
    --self.dash_time = 0

    self.shot_timer = 0
    self.shot_time = 0.25

    self.alive = true

    self.w = 32
    self.h = 32

    self.image = love.graphics.newImage("guy1.png")
    self.pointer_image = love.graphics.newImage("pointer.png")

    self.anchorx = 0.5
    self.anchory = 0.5

	self.rot = 0
	
	self.id = nil
	self.name = "player"
    self.parent = nil
    
    self.alive = true
    self.awake = true

    return self
end

function Player:update(dt)
    local w_dir_x = 0
    local w_dir_y = 0
    
    if love.keyboard.isDown("a") or love.keyboard.isDown("left") then 
        w_dir_x = -1
    end
    
    if love.keyboard.isDown("d") or love.keyboard.isDown("right") then 
        w_dir_x = 1
    end
    
    if love.keyboard.isDown("w") or love.keyboard.isDown("up") then 
        w_dir_y = -1
    end
    
    if love.keyboard.isDown("s") or love.keyboard.isDown("down") then 
        w_dir_y = 1
    end
    local mx, my = self.parent:get_mouse_world_coords()
    local w_shot_dir_x = mx - self.x
    local w_shot_dir_y = my - self.y
    local m_shot_dir = math.sqrt(w_shot_dir_x*w_shot_dir_x + w_shot_dir_y*w_shot_dir_y)

    self.shot_dir_x = w_shot_dir_x/m_shot_dir
    self.shot_dir_y = w_shot_dir_y/m_shot_dir

    self.rot = math.atan2(self.shot_dir_y, self.shot_dir_x)

    self.shot_timer = self.shot_timer - dt

    if love.mouse.isDown(1) and self.shot_timer <= 0 then
		local bull = self.parent:spawn("bullet", self.x, self.y)
		bull.xspeed = bull.speed * self.shot_dir_x
		bull.yspeed = bull.speed * self.shot_dir_y
		bull.rot = math.atan2(self.shot_dir_y, self.shot_dir_x)
        self.shot_timer = self.shot_time
    end

    local dir_x = 0
    local dir_y = 0

    if (w_dir_x == 0) and (w_dir_y == 0) then
    else
        local m_dir = math.sqrt(w_dir_x*w_dir_x + w_dir_y*w_dir_y)
        dir_x = w_dir_x/m_dir
        dir_y = w_dir_y/m_dir
    end

    self.xvel = self.xvel + self.walk_speed * dir_x * dt
    self.yvel = self.yvel + self.walk_speed * dir_y * dt

    self.xvel = self.xvel * self.friction
    self.yvel = self.yvel * self.friction

    self.x = self.x + self.xvel * dt
    self.y = self.y + self.yvel * dt
end

function Player:draw()
    love.graphics.push()

    love.graphics.translate(self.x, self.y)
    love.graphics.rotate(self.rot)
    love.graphics.translate(-self.x, -self.y)

	love.graphics.draw(self.image, self.x - self.w*self.anchorx, self.y - self.h*self.anchory)
	
    love.graphics.pop()

    love.graphics.push()
    
    love.graphics.translate(self.x + self.shot_dir_x*16, self.y + self.shot_dir_y*16)
    love.graphics.rotate(self.rot)
    love.graphics.translate(-(self.x + self.shot_dir_x*16), -(self.y + self.shot_dir_y*16))
    
	love.graphics.draw(self.pointer_image, self.x + self.shot_dir_x*16, self.y + self.shot_dir_y*16)
	
    love.graphics.pop()
end

function Player:guidraw()
    love.graphics.print("x: "..self.x.." | y: "..self.y)
end

return Player