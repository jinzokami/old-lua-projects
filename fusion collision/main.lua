Mouse = require("Mouse")
Box = require("Box")
Circle = require("Circle")

require("collision")

function love.load()
	entities = {}
	mouse = Mouse()
	debugmessagequeue = {}

	pushMessage("test, not as complex mega's box, but it works")
	pushMessage("mesages displayed newest to oldest")
	pushMessage("test 1")
	pushMessage("test 2")
end

function love.update(dt)
	mouse:update(dt)
	for i, v in ipairs(entities) do
		v:update(dt)
	end
end

function love.draw()
	for i, v in ipairs(entities) do
		v:draw()
	end
	mouse:draw()

	for i = 1, #debugmessagequeue, 1 do
		love.graphics.setColor(255,255,255,255)
		love.graphics.print(debugmessagequeue[i], 0, (i-1) * 10)
	end
end

function love.mousepressed(x, y, button)
	mouse:click(button)
end

function love.mousereleased(x, y, button)
	mouse:release(button)
	if button == "r" then
		table.insert(entities, Box(x, y, math.floor(math.random()*128), math.floor(math.random()*128)))
	end
	if button == "m" then
		table.insert(entities, Circle(x, y, math.floor(math.random()*128)))
	end
end

function pushMessage(message)
	table.insert(debugmessagequeue, 1, message)
end

function distance(x1, y1, x2, y2)
	return math.sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2))
end