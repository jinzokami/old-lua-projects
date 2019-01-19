love.graphics.setDefaultFilter("nearest", "nearest")

Animation = require("animation")
Boog = require("Boog")
Background = require("Background")

playerImage = love.graphics.newImage("beeman meta.png")
backgroundImage = love.graphics.newImage("bg.png")

function love.load()
	ids = 0

	entities = {}
	addEntity(Background:new())
	for i = 1, 250, 1 do
		addEntity(Boog:new(math.random()*(love.graphics.getWidth()-32),math.random()*(love.graphics.getHeight()-32)))
	end
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
	table.insert(entities, entity)
end

function removeEntity(id)
	for i=1, #entities, 1 do
		if entities[i].id == id then
			table.remove(entities, i)
		end
	end
end

function getNewID()
	ids = ids + 1
	return ids
end

-----Helpers
function distance(a, b)
	return math.sqrt((math.pow(a.x - b.x, 2)) + (math.pow((a.y - b.y), 2)))
end
-----/helpers