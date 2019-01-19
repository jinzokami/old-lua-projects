SCALE = 3
WIDTH = 160*SCALE
HEIGHT = 144*SCALE

--the game
GameMain = require("GameMain")

function love.load()
	-- setup
	love.filesystem.setIdentity("Karmic Dudes")
	love.window.setMode(WIDTH, HEIGHT, {fullscreen = false, vsync = true, borderless = true})

	mouse = love.mouse
	mouse.cursor = love.graphics.newImage("assets/cursor.png")
	mouse.setVisible(false)

	--game initialization
	GameMain:start()
end

function love.update(dt)
	GameMain:update(dt)
end

function love.draw()
	GameMain:draw()
	GameMain:drawGUI()

	--draw mouse
	love.graphics.setColor(255,255,255,255)
	love.graphics.draw(mouse.cursor, mouse.getX(), mouse.getY())
end

function love.keypressed(key, scancode, isRepeat)
	GameMain:keypressed(key)
end

function pushEvent(event)
	table.insert(events, event)
end