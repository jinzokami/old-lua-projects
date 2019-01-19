--[[
cricles that collide
they have friction
they spawn onclick
drag to set velocity and direction
circles fly opposite drag
]]

function love.load()
	circles = {}
end

function love.update(dt)
	for i, v in ipairs(circles) do
		v:update(dt)
	end
end

function love.draw()
	if spawning then love.graphics.line(c.x, c.y, love.mouse.getX(), love.mouse.getY()) end

	for i, v in ipairs(circles) do
		v:draw()
	end
end

function spawnCircle(x, y, angle, velocity)
	table.insert(circles, Circle.new(x, y, angle, velocity))
end

function love.mousepressed(x, y, button)
	spawning = true
	
	c = {}
	c.x = x
	c.y = y
end

function love.mousereleased(x, y, button)
	spawning = false
	spawnCircle(c.x, c.y, math.atan2(c.y - y, c.x - x), 100)
end

function distance(a, b)
	return math.sqrt(math.pow(a.x - b.x, 2) + math.pow(a.y - b.y, 2))
end

function handleCollisions()
	for obj1 = 1, #circles, 1 do
		for obj2 = 1, #circles do
			if not (obj1 == obj2) then
				if distance(obj1, obj2) < 16 then
					obj1:setDirection(1)--set the direction to the proper ricochet
					obj2:setDirection(1)--set the direction to the proper ricochet
				end
			end
		end
	end
end



Circle = {}
Circle.__index = Circle

function Circle.new(x, y, angle, velocity)
	local self = setmetatable({}, Circle)

	self.x = x
	self.y = y
	self.angle = angle
	self.velocity = velocity

	return self
end

function Circle:update(dt)
	deltax = math.cos(self.angle)*dt*self.velocity
	deltay = math.sin(self.angle)*dt*self.velocity

	self.x = self.x + deltax
	self.y = self.y + deltay
end

function Circle:draw()
	love.graphics.circle("fill", self.x, self.y, 16, 20)
end

function Circle:setDirection(na)
	self.angle = na
end