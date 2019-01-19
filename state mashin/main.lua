function love.load()

end

function love.update(dt)

end

function love.draw()

end

states = {
	normal = 0,
	moving = 1,
}

Player = {}
Player.__index = Player

function Player.new(x, y)
	local self = setmetatable({}, Player)

	self.position = Vector2.new(x, y)
	self.state = states.normal

	return self
end

function Player:update(dt)
	if self.state == states.normal then 
end

function Player:draw()

end

--i built a little empire out of some crazy garbage
--called the blood of the exploited working class