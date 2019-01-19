require("generator")

tile = 4

--[[

we're going to have to preload alot of levels beforehand to make the game smoother(we're doing a roguelike so 20 levels is fine)

active list - list containing all edge grids that are adjacent to an active grid
	holds table that contain the following values {x, y}
inactive list - list containing all edge grids that are adjacent to an inactive grid
	holds table that contain the following values {x, y}
distances list - an intermediary list of distances and coordinates that hold the value that will eventually be passed to the smallest distances list
	holds tables that contain the following values {distance, activex, activey, inactivex, inactivey}
smallest distances list - the list containing all the shortest distances to an inactive grid from an active one
	holds tables that contain the following values {distance, activex, activey, inactivex, inactivey}

cycle through all active grids.
	if they are an edge piece (a wall shares a side with it) then
		add it to the "active list"

cycle through all inactive grids.
	if they are an edge piece (a wall shares a side with it) then
		add it to the "inactive list"

for each element in the active list:
	find and record the distances between it and each inactive grid
	sort them from least distance to greatest distance
	pick the smallest distance and add it to a master "smallest distance list"

sort the smallest distances list like before and pick the smallest (first) distance
	connect the two grids that distance belongs to
]]--

function love.load()
	love.filesystem.setIdentity("Karma")
	math.randomseed(os.time())
	math.random();math.random();math.random()

	tileset = love.graphics.newImage("tileset.png")
	tiles = {}
	for i = 0, 2, 1 do
		tiles[i] = love.graphics.newQuad(i*tile, 0, tile, tile, tileset:getWidth(), tileset:getHeight())
	end

	maps = {}
	for i = 1, 3, 1 do
		maps[i] = generateNewMap(128, 128, .5)
	end
	currentMap = 1
end

function love.update(dt)
end

function love.draw()
	drawMap(maps[currentMap])
	love.graphics.setColor(255,0,255,255)
	love.graphics.print(love.timer.getFPS())
end

function love.keypressed(key)
	if key == ' ' then end

	if key == 'z' then 
		currentMap = currentMap - 1
		if currentMap < 1 then
			currentMap = #maps
		end
	end
	if key == 'x' then 
		currentMap = currentMap + 1 
		if currentMap > #maps then
			currentMap = 1
		end
	end
	if key == 'c' then end
	if key == 'v' then end
	if key == 'b' then end
	if key == 'n' then end
	if key == 'm' then end

	if key == 'a' then end
	if key == 's' then end
	if key == 'd' then end
	if key == 'f' then end
	if key == 'g' then end
	if key == 'h' then end
	if key == 'j' then end
	if key == 'k' then end
	if key == 'l' then end

	if key == 'q' then end
	if key == 'w' then end
	if key == 'e' then end
	if key == 'r' then end
	if key == 't' then end
	if key == 'y' then end
	if key == 'u' then end
	if key == 'i' then end
	if key == 'o' then end
	if key == 'p' then end

	if key == '1' then end
	if key == '2' then end
	if key == '3' then end
	if key == '4' then end
	if key == '5' then end
	if key == '6' then end
	if key == '7' then end
	if key == '8' then end
	if key == '9' then end
	if key == '0' then end

	if key == 'left' then end
	if key == 'right' then end
	if key == 'up' then end
	if key == 'down' then end

	if key == 'return' then end

	if key == 'escape' then end
end

function love.keyreleased(key)
	if key == ' ' then end

	if key == 'z' then end
	if key == 'x' then end
	if key == 'c' then end
	if key == 'v' then end
	if key == 'b' then end
	if key == 'n' then end
	if key == 'm' then end

	if key == 'a' then end
	if key == 's' then end
	if key == 'd' then end
	if key == 'f' then end
	if key == 'g' then end
	if key == 'h' then end
	if key == 'j' then end
	if key == 'k' then end
	if key == 'l' then end

	if key == 'q' then end
	if key == 'w' then end
	if key == 'e' then end
	if key == 'r' then end
	if key == 't' then end
	if key == 'y' then end
	if key == 'u' then end
	if key == 'i' then end
	if key == 'o' then end
	if key == 'p' then end

	if key == '1' then end
	if key == '2' then end
	if key == '3' then end
	if key == '4' then end
	if key == '5' then end
	if key == '6' then end
	if key == '7' then end
	if key == '8' then end
	if key == '9' then end
	if key == '0' then end

	if key == 'left' then end
	if key == 'right' then end
	if key == 'up' then end
	if key == 'down' then end

	if key == 'return' then end
	
	if key == 'escape' then
		love.event.push('quit')
	end
end

function takeScreenshot()
	local screenshot = love.graphics.newScreenshot()
	screenshot:encode(os.time()..'screenie'..'.png', 'png')
end