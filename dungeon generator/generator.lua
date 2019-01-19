--creates a new map
function generateNewMap(width, height, percentage)
	local newMap = makeEmptyMap(width, height)

	newMap = populateMap(newMap, math.ceil(width*height*percentage))
	newMap = cleanMapCompletely(newMap)
	newMap = tallyCompletely(newMap, 2)

	return newMap
end -- returns [the shiny new "ready for gameplay" map]

--used to setup the cellular automata that decides the initial level layout
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
end -- returns [the populated map]

--cleans up the cellular automata
function cleanMapCompletely(map)
	local attempts = 0
	while not compareMaps(map, cleanMap(map)) do
		attempts = attempts + 1
		map = cleanMap(map)
		if attempts > 10 then
			break
		end
	end

	return map
end -- returns [the cleaned map]

function cleanMap(map)
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
end -- returns [the partially cleaned map]

--checks if the map is contiguous(all parts can be accessed)
function tallyCompletely(map, number)
	while not compareMaps(map, tallyMapStepByStep(map, 2)) do
		map = tallyMapStepByStep(map, 2)
	end

	if checkFor(map, 1) then
		print("the map is not contiguous. create corridors.")
	end
	return map, checkFor(map, 1)
end -- returns [the tallied map], [whether the map is completely tallied]

function tallyMapStepByStep(map, number)
	if not checkFor(map, number) then
		map = seedMap(map, number)
	end

	local newmap = copyMap(map)

	for y = 1, #map, 1 do
		for x = 1, #map[1], 1 do

			if map[y][x] == 1 then
				if map[y-1] then
					if map[y-1][x] == number then
						newmap[y][x] = number
					end
				end

				if map[y+1] then
					if map[y+1][x] == number then
						newmap[y][x] = number
					end
				end

				if map[y][x-1] then
					if map[y][x-1] == number then
						newmap[y][x] = number
					end
				end

				if map[y][x+1] then
					if map[y][x+1] == number then
						newmap[y][x] = number
					end
				end

			end

		end
	end
	return newmap
end -- returns [the tallied map]

function seedMap(map, number)
	local newmap = copyMap(map)

	local anyOnes = false
	for i = 1, #newmap, 1 do
		for j = 1, #newmap[i], 1 do
			if newmap[i][j] == 1 then
				anyOnes = true
			end
		end
	end

	if not anyOnes then
		return newmap
	end

	if checkFor(newmap, number) then
		return newmap
	end

	local tx = math.ceil(math.random()*#newmap[1])
	local ty = math.ceil(math.random()*#newmap)
	while newmap[ty][tx] ~= 1 do
		tx = math.ceil(math.random()*#newmap[1])
		ty = math.ceil(math.random()*#newmap)
	end
	newmap[ty][tx] = number
	return newmap
end -- returns [the seeded map]

----------HELPERS----------

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
				return false
			end
		end
	end

	return true
end -- returns [whether the maps are equal]

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
end -- returns [the copied map]

function checkFor(A, number)
	for i = 1, #A, 1 do
		for j = 1, #A[1], 1 do
			if A[i][j] == number then
				return true
			end
		end
	end
	return false
end -- returns [whether the map contains the selected value]

----------END HELPERS----------

----------DEBUG----------

function drawMap(map)
	love.graphics.setColor(255, 255, 255, 255)
	for y = 1, #map, 1 do
		for x = 1, #map[y], 1 do
			love.graphics.draw(tileset, tiles[map[y][x]], x*tile, y*tile)
		end
	end
end -- returns 	NOTHING! ABSOLUTELY NOTHING!

function makeEmptyMap(width, height)
	local map = {}
	for i = 1, height, 1 do
		map[i] = {}
		for j = 1, width, 1 do
			map[i][j] = 0
		end
	end
	return map
end -- returns [a boring, empty, unplayable map]

----------END DEBUG----------

----------UNFINISHED----------

-- the following will be used during the connecting the map part of generation
function connectTwoGrids(map, startingx, startingy, targetx, targety)
	while startingx ~= targetx do
		startingx = startingx - ((startingx-targetx)/math.abs(startingx-targetx))
		if map[startingy][startingx] == 0 then
			map[startingy][startingx] = 1
		end
	end

	while startingy ~= targety do
		startingy = startingy - ((startingy-targety)/math.abs(startingy-targety))
		if map[startingy][startingx] == 0 then
			map[startingy][startingx] = 1
		end
	end
	return map
end -- returns [the map with specified coords connected]

----------END UNFINISHED----------