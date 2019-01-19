require("maths")

KeyDef = {
	['left'] = 'left',
	['right'] = 'right',
	['up'] = 'up',
	['down'] = 'down',
	['item1'] = 'z',
	['item2'] = 'x',
	['start'] = 'space',
	['select'] = 'c',
}

Player = require("Player")
QT = require("QuadTree")
Mover = require("Mover")
TimerManager = require("TimerManager")
Timer = require("Timer")


function love.load()
	quad = QT.new(0, 0, 0, 800, 600)
	objects = {}

	-- spawnTimer = Timer.new(1, 2)
	-- spawnTimer.endAction = function()
	-- 	table.insert(objects, Mover.new())
	-- end

	lines = {}

	lastFPS = 0
end

function love.update(dt)
	-- spawnTimer:update(dt)

	-- currentFPS = love.timer.getFPS()
	-- if currentFPS < lastFPS then
	-- 	print(string.format("FPS Drop at: %s objects.\n\tnew FPS: %s", #objects, currentFPS))
	-- end
	-- lastFPS = currentFPS

	for i, v in ipairs(objects) do
		v:update(dt)
	end

	--broad phase collision detection
	quad:clear()
	for i = 1, #objects, 1 do
		quad:insert(objects[i])
	end

	lines = {}
	returnObjects = {}
	collisionsChecked = 0
	for i = 1, #objects, 1 do
		returnObjects = {}
		quad:retrieve(returnObjects, objects[i])

		for j = 1, #returnObjects, 1 do
			-- table.insert(lines, objects[i].x)
			-- table.insert(lines, objects[i].y)
			-- table.insert(lines, returnObjects[j].x)
			-- table.insert(lines, returnObjects[j].y)

			-- collisionsChecked = collisionsChecked + 1

			-- narrow phase collision detection
			if colliding(objects[i], returnObjects[j]) and (objects[i].id ~= returnObjects[j].id) then
				objects[i]:onCollide(returnObjects[j])
			end
		end
	end
end

function love.draw()
	for i, v in ipairs(objects) do
		v:draw()
	end
	quad:draw()

	--love.graphics.print(#objects, 0, 20)

	--love.graphics.setColor(0,0,255,255)
	-- for i = 1, #lines, 4 do
	-- 	love.graphics.line(lines[i],lines[i+1],lines[i+2],lines[i+3])
	--end
	

	-- love.graphics.setColor(255,255,255,255)
	-- love.graphics.print(collisionsChecked, 0, 10)

	-- if love.timer.getFPS() > 50 then
	-- 	love.graphics.setColor(255,255,255,255)
	-- elseif love.timer.getFPS() > 30 then
	-- 	love.graphics.setColor(255,255,0,255)
	-- else
	-- 	love.graphics.setColor(255,0,0,255)
	-- end

	-- love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 0, 0)
end

function love.mousepressed(mx, my, button, istouch)
	
end

function love.keypressed(key, scancode, isRepeat)

end

function colliding(objA, objB)
	if (objA.top > objB.bottom) or (objA.bottom < objB.top) or (objA.left > objB.right) or (objA.right < objB.left) then
		return false
	end

	return true
end

currentID = 0
function getNewID()
	currentID = currentID + 1
	return currentID
end