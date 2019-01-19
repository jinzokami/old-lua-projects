function love.load()
	love.filesystem.setIdentity("Karma Drive")
end

function love.draw()
	Crossed()
end

function love.keypressed(key, scancode, isRepeat)
	if key == 'space' then
		local screenie = love.graphics.newScreenshot()
		screenie:encode('png', 'Check Karma.png')
	end
end

function Crossed()
	love.graphics.setColor(1,1,1,1)
	love.graphics.circle("fill", 400, 300, 150)
	love.graphics.setColor(0,0,0,1)
	love.graphics.circle("fill", 400, 300, 100)

	love.graphics.push()

	love.graphics.translate(400, 300)
	love.graphics.rotate(math.rad(45))
	love.graphics.translate(-400, -300)

	love.graphics.setColor(0,0,0,1)
	love.graphics.rectangle("fill", 195, 270, 410, 60)
	love.graphics.setColor(1,1,1,1)
	love.graphics.rectangle("fill", 200, 275, 400, 50)

	love.graphics.pop()

	love.graphics.push()

	love.graphics.translate(400, 300)
	love.graphics.rotate(math.rad(45 + 90))
	love.graphics.translate(-400, -300)

	love.graphics.setColor(0,0,0,1)
	love.graphics.rectangle("fill", 195, 270, 410, 60)
	love.graphics.setColor(1,1,1,1)
	love.graphics.rectangle("fill", 200, 275, 400, 50)

	love.graphics.pop()

	love.graphics.push()

	love.graphics.translate(400, 300)
	love.graphics.rotate(math.rad(45 + 90))
	love.graphics.translate(-400, -300)

	love.graphics.setColor(0,0,0,1)
	love.graphics.rectangle("fill", 370, 270, 60, 60)
	love.graphics.setColor(1,1,1,1)
	love.graphics.rectangle("fill", 375, 275, 50, 50)

	love.graphics.pop()

	love.graphics.push()

	love.graphics.translate(400, 300)
	love.graphics.rotate(math.rad(45))
	love.graphics.translate(-400, -300)

	love.graphics.setColor(0,0,0,1)
	love.graphics.circle("fill", 600, 300, 70, 3)
	love.graphics.setColor(1,1,1,1)
	love.graphics.circle("fill", 600, 300, 60, 3)

	love.graphics.pop()

	love.graphics.push()

	love.graphics.translate(400, 300)
	love.graphics.rotate(math.rad(45+90))
	love.graphics.translate(-400, -300)

	love.graphics.setColor(0,0,0,1)
	love.graphics.circle("fill", 600, 300, 70, 3)
	love.graphics.setColor(1,1,1,1)
	love.graphics.circle("fill", 600, 300, 60, 3)

	love.graphics.pop()

	love.graphics.push()

	love.graphics.translate(400, 300)
	love.graphics.rotate(math.rad(45+180))
	love.graphics.translate(-400, -300)

	love.graphics.setColor(0,0,0,1)
	love.graphics.circle("fill", 600, 300, 70, 3)
	love.graphics.setColor(255,255,255,255)
	love.graphics.circle("fill", 600, 300, 60, 3)

	love.graphics.pop()

	love.graphics.push()

	love.graphics.translate(400, 300)
	love.graphics.rotate(math.rad(45+180+90))
	love.graphics.translate(-400, -300)

	love.graphics.setColor(0,0,0,1)
	love.graphics.circle("fill", 600, 300, 70, 3)
	love.graphics.setColor(1,1,1,1)
	love.graphics.circle("fill", 600, 300, 60, 3)

	love.graphics.pop()
end