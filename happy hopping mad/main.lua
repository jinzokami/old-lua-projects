function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")
	love.graphics.setBackgroundColor(50, 50, 150, 255)
	love.window.setFullscreen(true)

	froggySprite = love.graphics.newImage("froggy.png")
	froggyBumpFX = love.sound.newSoundData("bump.mp3")

	froggies = {}

	timerEvent = {ticks = 1/16, timer = 1, update = function (self, dt) self.timer = self.timer - dt; if self.timer < 0 then self.timer = self.ticks; for i = 1, 1, 1 do table.insert(froggies, Froggy.new(love.graphics.getWidth()/2, love.graphics.getHeight()/2, math.random()*5, math.random()*4+1, math.random()*10-5, math.random()*10-5)); end end end}

	
end

function love.update(dt)
	for i, v in ipairs(froggies) do
		v:update(dt)
	end

	timerEvent:update(dt)

end

function love.draw()
	for i, v in ipairs(froggies) do
		v:draw()
	end
	love.graphics.print(love.timer.getFPS().."\n"..#froggies)
end

function love.keypressed(key)
	if key == 'escape' then love.event.push("quit") end
end

Froggy = {}
Froggy.__index = Froggy

function Froggy.new(x, y, size, timer, xvel, yvel)
	local self = setmetatable({}, Froggy)

	self.x = x
	self.y = y
	self.size = math.ceil((size or 1))
	self.xvel = (xvel or 0)
	self.yvel = (yvel or 0)

	self.timer = timer
	self.jumpTimer = timer

	self.fx = love.audio.newSource(froggyBumpFX)

	return self
end

function Froggy:update(dt)
	self.x = self.x + self.xvel
	if self.x+(self.size*16) > love.graphics.getWidth() then
		self.x = love.graphics.getWidth()-(self.size*16)
		self.xvel = -self.xvel
	end
	if self.x < 0 then
		self.x = 0
		self.xvel = -self.xvel
	end

	self.yvel = self.yvel + 1
	self.y = self.y + self.yvel
	if self.y+(self.size*16) > love.graphics.getHeight() then
		self.y = love.graphics.getHeight()-(self.size*16)
		self.yvel = 0
	end
	if self.y < 0 then
		self.y = 0
		self.yvel = 0
		--self.fx:play()
	end

	if self.jumpTimer < 0 then
		self.jumpTimer = self.timer
		self.yvel = -50
	end

	if self.y+(self.size*16) == love.graphics.getHeight() then
		if self.yvel == 0 then
			self.jumpTimer = self.jumpTimer - dt
			self.xvel = self.xvel - (self.xvel/math.abs(self.xvel))
		end
	end
end

function Froggy:draw()
	love.graphics.setColor(255,255,255,255)
	love.graphics.draw(froggySprite, self.x, self.y, 0, self.size)
end