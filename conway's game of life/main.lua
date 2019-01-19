require("generator")

tile = 4

function love.load()
	love.filesystem.setIdentity("Karma")
	math.randomseed(os.time())
	math.random();math.random();math.random()

	map = generateNewMap(100, 100, .5)--the width, height, and percentage of the map to be populated
	--some nice patterns just because
	uni = {
	{0,0,0,0,0,0,0,0,0,0,0,0,0,},
	{0,0,0,0,0,0,0,0,0,0,0,0,0,},
	{0,0,1,1,0,1,1,1,1,1,1,0,0,},
	{0,0,1,1,0,1,1,1,1,1,1,0,0,},
	{0,0,1,1,0,0,0,0,0,0,0,0,0,},
	{0,0,1,1,0,0,0,0,0,1,1,0,0,},
	{0,0,1,1,0,0,0,0,0,1,1,0,0,},
	{0,0,1,1,0,0,0,0,0,1,1,0,0,},
	{0,0,0,0,0,0,0,0,0,1,1,0,0,},
	{0,0,1,1,1,1,1,1,0,1,1,0,0,},
	{0,0,1,1,1,1,1,1,0,1,1,0,0,},
	{0,0,0,0,0,0,0,0,0,0,0,0,0,},
	{0,0,0,0,0,0,0,0,0,0,0,0,0,}}

	dubbug = {
	{0,0,0,1,1,1,0,0,0,1,1,1,0,0,0},
	{0,0,1,0,1,0,1,0,1,0,1,0,1,0,0},
	{0,1,1,1,0,1,1,0,1,1,0,1,1,1,0},
	{0,1,0,0,1,0,1,0,1,0,1,0,0,1,0},
	{0,0,0,0,1,1,0,0,0,1,1,0,0,0,0},
	{0,0,0,1,1,0,0,0,0,0,1,1,0,0,0},
	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}}

	--map = dubbug

	stepRate = 5
	delay = 0
end

function love.update()
	delay = delay + stepRate
	while delay > 10 do
		map = cleanMap(map)
		delay = delay - 10
	end
end

function love.draw()
	drawMap(map)
end

function love.keypressed(key)
	if key == 'z' then
		map = cleanMap(map)
	end

	if key == 'x' then
		takeScreenshot()
	end

	if key == 'a' then
		seedMap(map)
	end

	if key == 'left' then
		stepRate = stepRate - 1
	end

	if key == 'right' then
		stepRate = stepRate + 1
	end

	if key == 'space' then
		map = tallyMapStepByStep(map)
	end
end

function takeScreenshot()
	local screenshot = love.graphics.newScreenshot()
	screenshot:encode(os.time()..'.png', 'png')
end

function tallyMapStepByStep(map)--choose a random point and every step every grid cell touching a two turns into a two
	local anyTwos = false
	local newmap = map

	map = seedMap(map)

	for y = 1, #map, 1 do
		for x = 1, #map[1], 1 do

			if map[y][x] == 1 then
				if map[y-1] then
					if map[y-1][x] == 2 then
						newmap[y][x] = 2
					end
				end

				if map[y+1] then
					if map[y+1][x] == 2 then
						newmap[y][x] = 2
					end
				end

				if map[y][x-1] then
					if map[y][x-1] == 2 then
						newmap[y][x] = 2
					end
				end

				if map[y][x+1] then
					if map[y][x+1] == 2 then
						newmap[y][x] = 2
					end
				end

			end

		end
	end

	
	print("step complete.")
	return newmap
end

function seedMap(map)
	for i = 1, #map, 1 do
		for j = 1, #map[i], 1 do
			if map[i][j] == 2 then
				return map
			end
		end
	end

	local tx = math.ceil(math.random()*#map[1])
	local ty = math.ceil(math.random()*#map)
	while map[ty][tx] ~= 1 do
		tx = math.ceil(math.random()*#map[1])
		ty = math.ceil(math.random()*#map)
	end
	map[ty][tx] = 2
	print(tx..", "..ty.." has been seeded.")
	return map
end