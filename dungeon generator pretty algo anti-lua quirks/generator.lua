function generateNewMap(width, height, percentage)
	local newMap = makeEmptyMap(width, height)
	newMap = populateMap(newMap, math.ceil(width*height*percentage))
	newMap = cleanMapCompletely(newMap)
	
	print("the map is successfully initialized")

	return newMap
end

function makeEmptyMap(width, height)
	local map = {}
	for i = 1, height, 1 do
		map[i] = {}
		for j = 1, width, 1 do
			map[i][j] = 0
		end
	end
	return map
end

function cleanMapCompletely(map)
	local attempts = 0
	while not compareMaps(map, cleanMap(map)) do
		attempts = attempts + 1
		map = cleanMap(map)
		print("the maps are not yet equal. attempt #"..attempts)
		if attempts > 50 then
			print("too many attempts, i'm sure it's fine. breaking.")
			break
		end
	end

	return map
end

function populateMap(map, pop)
	for i = 1 , pop, 1 do
		local ty = math.ceil(math.random()*#map)
		local tx = math.ceil(math.random()*#map[1])
		while map[ty][tx] == 1 do
			tx = math.ceil(math.random()*#map[1])
			ty = math.ceil(math.random()*#map)
		end
		map[ty][tx] = 1
	end

	return map
end

function drawMap(map)
	for y = 1, #map, 1 do
		for x = 1, #map[y], 1 do
			if map[y][x] == 0 then 
				love.graphics.setColor(255, 255, 255, 255)
				love.graphics.rectangle("fill", (x-1)*tile, (y-1)*tile, tile, tile)
			elseif map[y][x] == 1 then 
				love.graphics.setColor(100, 100, 100, 255)
				love.graphics.rectangle("fill", (x-1)*tile, (y-1)*tile, tile, tile)
			elseif map[y][x] == 2 then 
				love.graphics.setColor(200, 0, 0, 255)
				love.graphics.rectangle("fill", (x-1)*tile, (y-1)*tile, tile, tile)
			end

			love.graphics.setColor(0,0,0,255)
			--love.graphics.print(map[y][x], (x-1)*tile, (y-1)*tile)
			--love.graphics.print(distances[y][x], (x-1)*tile, (y-1)*tile)
		end
	end
end

function cleanMap(map) --cleans the map one step
	local live = 0
	local newmap = {}
	for i = 1, #map, 1 do
		newmap[i] = {}
		for j = 1, #map[1], 1 do
			newmap[i][j] = 0
		end
	end

	for y = 1, #map, 1 do
		for x = 1, #map[1], 1 do
			if map[y][x] == 1 then
				live = live + 1
			end

			if map[y-1] then
				if map[y-1][x] == 1 then
					live = live + 1
				end

				if map[y-1][x-1] then
					if map[y-1][x-1] == 1 then
						live = live + 1
					end
				end
				
				if map[y-1][x+1] then
					if map[y-1][x+1] == 1 then
						live = live + 1
					end
				end
			end

			if map[y+1] then
				if map[y+1][x] == 1 then
					live = live + 1
				end

				if map[y+1][x+1] then
					if map[y+1][x+1] == 1 then
						live = live + 1
					end
				end
				
				if map[y+1][x-1] then
					if map[y+1][x-1] == 1 then
						live = live + 1
					end
				end
			end

			if map[y][x+1] then
				if map[y][x+1] == 1 then
					live = live + 1
				end
			end

			if map[y][x-1] then
				if map[y][x-1] == 1 then
					live = live + 1
				end
			end

			if live >= 5 then
				newmap[y][x] = 1
			end
			if live < 4 then
				newmap[y][x] = 0
			end

			live = 0
		end
	end

	return newmap
end

function copyMap(A)
	--lua tables are by reference, so:
		--A = B does not mean copy variable B to A
		--it means point A to whatever B points to

	local B = {}

	for i = 1, #A, 1 do
		B[i] = {}
		for j = 1, #A[i], 1 do
			B[i][j] = A[i][j]
		end
	end

	return B
end

function compareMaps(A, B)
	if #A ~= #B then
		return false
	end

	for i = 1, #A, 1 do
		if #A[i] ~= #B[i] then
			return false
		end
	end

	for i = 1, #A, 1 do
		for j = 1, #A[1], 1 do
			if A[i][j] ~= B[i][j] then
				print("A and B are not equal at: "..j..", "..i.."("..A[i][j].." and "..B[i][j]..")")
				return false
			end
		end
	end

	return true
end

function tallyMapStepByStep(map)--choose a random point and every step every grid cell touching a two turns into a two
	local anyTwos = false

	map = seedMap(map)
	local newmap = copyMap(map)

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