function love.load()
	--this is where you initialize everything
	--load images
	--sounds
	--animations
	--anything that needs to be called more than once
	boop = love.audio.newSource("beep.wav")

	paddleOne = {}
	paddleOne.position = {x = 20, y = 20}
	paddleOne.speed = 5
	paddleOne.score = 0
	
	paddleTwo = {}
	paddleTwo.position = {x = love.graphics.getWidth() - 40, y = 20}
	--paddleTwo.direction = 1
	paddleTwo.speed = 5
	paddleTwo.score = 0

	ball = {}
	ball.position = {x = love.graphics.getWidth()/2, y = love.graphics.getHeight()/2}
	ball.direction = {x = 1, y = 1}
	ball.speed = 4

	
end

function love.update(dt)
	--this runs once every 17 milliseconds (60 times a second)
	--game logic is run here

	--controls
	if love.keyboard.isDown("up") then
		paddleOne.position.y = paddleOne.position.y - paddleOne.speed
	end

	if love.keyboard.isDown("down") then
		paddleOne.position.y = paddleOne.position.y + paddleOne.speed
	end

	--paddleTwo AI

	if paddleTwo.position.y < ball.position.y then
		paddleTwo.position.y = paddleTwo.position.y + paddleTwo.speed
	end

	if paddleTwo.position.y+60 > ball.position.y then
		paddleTwo.position.y = paddleTwo.position.y - paddleTwo.speed
	end

	--ball AI
	ball.position.x = ball.position.x + ball.direction.x*ball.speed
	ball.position.y = ball.position.y + ball.direction.y*ball.speed

	--simple collision detection

	if (ball.position.x < paddleOne.position.x+20) and (ball.position.x > paddleOne.position.x) then
		if (ball.position.y < paddleOne.position.y+60) and (ball.position.y+20 > paddleOne.position.y) then
			ball.direction.x = 1
			boop:play()
		end
	end

	if (ball.position.x+20 > paddleTwo.position.x) and (ball.position.x+20 < paddleTwo.position.x+20) then
		if (ball.position.y < paddleTwo.position.y+60) and (ball.position.y+20 > paddleTwo.position.y) then
			ball.direction.x = -1
			boop:play()
		end
	end

	--out of bounds prevention and point scoring
	if paddleOne.position.y+60 > love.graphics.getHeight() then
		paddleOne.position.y = love.graphics.getHeight() - 60
	end

	if paddleOne.position.y < 40 then
		paddleOne.position.y = 40
	end

	if paddleTwo.position.y+60 > love.graphics.getHeight() then
		paddleTwo.position.y = love.graphics.getHeight() - 60
	end

	if paddleTwo.position.y < 40 then
		paddleTwo.position.y = 40
	end

	if ball.position.y+20 > love.graphics.getHeight() then
		ball.position.y = love.graphics.getHeight() - 20
		ball.direction.y = -ball.direction.y
		boop:play()
	end

	if ball.position.y < 40 then
		ball.position.y = 40
		ball.direction.y = -ball.direction.y
		boop:play()
	end

	if ball.position.x > love.graphics.getWidth() then
		paddleOne.score = paddleOne.score + 1
		ball.position = {x = love.graphics.getWidth()/2, y = love.graphics.getHeight()/2}
		boop:play()
	end

	if ball.position.x < -20 then
		paddleTwo.score = paddleTwo.score + 1
		ball.position = {x = love.graphics.getWidth()/2, y = love.graphics.getHeight()/2}
		boop:play()
	end
end

function love.draw()
	--this is where you display images
	--text

	love.graphics.line(0, 40, love.graphics.getWidth(), 40)
	love.graphics.line(love.graphics.getWidth()/2, 40, love.graphics.getWidth()/2, love.graphics.getHeight())
	love.graphics.circle("line", love.graphics.getWidth()/2, love.graphics.getHeight()/2, 140)
	love.graphics.circle("line", 0, love.graphics.getHeight()/2, 140)
	love.graphics.circle("line", love.graphics.getWidth(), love.graphics.getHeight()/2, 140)

	love.graphics.rectangle("fill", paddleOne.position.x, paddleOne.position.y, 20, 60)
	love.graphics.rectangle("fill", paddleTwo.position.x, paddleTwo.position.y, 20, 60)
	love.graphics.rectangle("fill", ball.position.x, ball.position.y, 20, 20)

	love.graphics.print(paddleOne.score, love.graphics.getWidth()/4, 20)
	love.graphics.print(paddleTwo.score, (love.graphics.getWidth()/4)*3, 20)
end

