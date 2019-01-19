--[[
to-do:
collision
movement relative to orientation
moving sources of gravity
sources of gravity attracted by other sources
]]

Player = require("Player")
Planet = require("Planet")
GravitySource = require("GravitySource")

function love.load()
	entities = {}

	play = addEntity(Player:new(100, 100))
	planet = addEntity(Planet:new(200, 200, 50))
	planet2 = addEntity(Planet:new(400, 400, 100))
end

function love.update(dt)
	for i, v in ipairs(entities) do
		v:update(dt)
	end
end

function love.draw()
	for i, v in ipairs(entities) do
		v:draw()
	end
end

function addEntity(entity)
	ent2add = entity
	table.insert(entities, ent2add)
	ent2add:onCreate()

	return ent2add
end

function checkSources()
	local gravitySources = {}
	for i, v in ipairs(entities) do
		if v.type == "source" then
			table.insert(gravitySources, v)
		end
	end
	return gravitySources
end

function distance(x1, y1, x2, y2)
	return math.sqrt(((x1-x2)*(x1-x2))+((y1-y2)*(y1-y2)))
end