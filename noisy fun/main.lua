function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")
	love.filesystem.setIdentity("Noisy Karma")

	animation = createNoiseAnimation(64,64,32,0.1)
end

function love.update(dt)
	animation:update(dt)
end

function love.draw()
	love.graphics.scale(3)
	animation:draw()
end

function createNoiseAnimation(width, height, frames, delay)
	local noiseAnimation = createEmptyAnimation(delay)

	for i = 1, frames, 1 do
		noiseAnimation:addFrame(convertNoiseGridToImage(generateNoiseGrid(width, height, 2*frames, 5)))
	end

	return noiseAnimation
end

function createEmptyAnimation(delay)
	local animation = {} -- the animation
	animation.frames = {} -- all the frames of the animation
	animation.currentFrame = 1 -- current frame of the animation
	animation.delay = delay -- animation speed
	animation.timer = 0 -- the frame timer

	animation.update = function(self, dt) -- updates the animation
		self.timer = self.timer + dt -- timer counts up
		while self.timer >= self.delay do -- while instead of if to make sure this doesn't balloon to unmanageable levels
			self.timer = self.timer - self.delay -- reduce the timer by one update
			self.currentFrame = self.currentFrame + 1 -- move to next frame
			if self.currentFrame > #self.frames then -- make sure frame does not exceed maximum frames
				self.currentFrame = 1 -- if it does then reset to zero
			end
		end
	end

	animation.draw = function(self, x, y) -- draws the animation
		love.graphics.setColor(255,255,255,255)
		love.graphics.draw(self.frames[self.currentFrame], x, y)
	end

	animation.addFrame = function(self, frame) -- adds a new frame to the animation
		table.insert(self.frames, frame)
	end

	return animation
end

function convertNoiseGridToImage(noiseGrid)
	local width = #noiseGrid[1]
	local height = #noiseGrid

	local tempCanvas = love.graphics.newCanvas(width, height) -- the canvas that the image will be drawn to before creation

	for y = 1, height, 1 do
		for x = 1, width, 1 do
			tempCanvas:renderTo(function() 
				love.graphics.setColor(255*noiseGrid[y][x], 255*noiseGrid[y][x], 255*noiseGrid[y][x], 255)
				love.graphics.points(x, y) -- puts a point of variable brightness on the canvas at the specified location (draws a point on the canvas)
			end)
		end
	end

	local finalImage = love.graphics.newImage(tempCanvas:newImageData()) -- turns the canvas into imageData and writes it to the drive as a bonus
	return finalImage
end

function generateNoiseGrid(width, height, depth, octave)
	local noise = {}
	for i = 1, 128, 1 do
		noise[i] = {}
		for j = 1, 128, 1 do
			noise[i][j] = love.math.noise(i/math.pow(2, octave), j/math.pow(2, octave), depth/8)
		end
	end
	return noise
end