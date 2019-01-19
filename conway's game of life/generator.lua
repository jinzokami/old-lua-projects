function generateNewMap(width, height, percentage)
	local newMap = {}
	for i = 1, height, 1 do
		newMap[i] = {}
		for j = 1, width, 1 do
			newMap[i][j] = 0
		end
	end

	newMap = populateMap(newMap, math.ceil(width*height*percentage))

	return newMap
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

function copyMap(A)
	local newMap = {}
	for i = 1, #A, 1 do
		newMap[i] = {}
		for j = 1, #A[i], 1 do
			newMap[i][j] = A[i][j]
		end
	end
	return newMap
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

			--love.graphics.setColor(0,0,0,255)
			--love.graphics.print(map[y][x], (x-1)*tile, (y-1)*tile)
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

			if (live < 3) and (map[y][x] == 1) then
				newmap[y][x] = 0
			end
			if (live > 4) and (map[y][x] == 1) then
				newmap[y][x] = 0
			end
			if ((live == 3) or (live == 4)) and (map[y][x] == 1) then
				newmap[y][x] = 1
			end
			if (live == 3) and (map[y][x] == 0) then
				newmap[y][x] = 1
			end

			live = 0
		end
	end

	return newmap
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
				print("A and B are not equal("..A[i][j].." and "..B[i][j]..")")
				return false
			end
		end
	end

	return true
end