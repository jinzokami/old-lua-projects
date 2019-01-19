require("maths")
require("helpers")

QT = require("QuadTree")

Player = require("Player")
Block = require("Block")

Room = require("TestRoom")

function love.load()
	love.window.setMode(240*3, 160*3)
	love.graphics.setDefaultFilter("linear", "nearest")

	quad = QT.new(0, 0, 0, 800, 600)
	objects = {}

	table.insert(objects, Player.new(0, 0))
	table.insert(objects, Block.new(32, 32))

	r = Room.new()
end

function love.update(dt)
	
	for i, v in ipairs(objects) do
		v:update(dt)
	end

	--broad phase collision detection
	quad:clear()
	for i = 1, #objects, 1 do
		quad:insert(objects[i])
	end

	-- narrow phase collision detection
	returnObjects = {}
	for i = 1, #objects, 1 do
		returnObjects = {}
		quad:retrieve(returnObjects, objects[i])

		for j = 1, #returnObjects, 1 do
			if colliding(objects[i].x, objects[i].y, objects[i].width, objects[i].height, returnObjects[j].x, returnObjects[j].y, returnObjects[j].width, returnObjects[j].height) and (objects[i].id ~= returnObjects[j].id) then
				objects[i]:onCollide(returnObjects[j])
			end
		end
	end
end

function love.draw()
	love.graphics.scale(3)
	r:draw()
	for i, v in ipairs(objects) do
		v:draw()
	end
end