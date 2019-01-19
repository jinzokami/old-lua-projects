void = -1
empty = 0
filled = 1

--[[
	generates maps like so:
		start with a one cell grid
		add a room of random size to the cell, growing as necessary
		pick a random edge spot (one bordering nothing or the void value)
		generate a path away from the room and generate another room where it ends (or something special if no room left)
		pick a random empty spot on the map, set that to the start
		pick a random-ish empty spot a certain distance away, set that to the exit

		populate with enemies
]]

function generateMap()
	local map = {{void}}--the map starts as one single cell set to void

	map = addRooms(map, 2, 5, 5, 16, 16)
	--map = addRoom(map, 1, 1, 10, 10)

	return map
end

--TODO: make the addRoom function leave non void tiles alone
function addRoom(map, x, y, width, height)
	local newMap = copyMap(map)

	--resize the board if necessary
	if x + width > #newMap[1] then
		newMap = growRight(newMap, x + width - #newMap[1]-1)
	end

	if y + height > #newMap then
		newMap = growDown(newMap, y + height - #newMap-1)
	end

	if x < 1 then
		newMap = growLeft(newMap, math.abs(x)+1)
		x = 1
	end

	if y < 1 then
		newMap = growUp(newMap, math.abs(y)+1)
		y = 1
	end

	--clear out an area for the room
	for i = 1, height, 1 do
		for j = 1, width, 1 do
			newMap[y+i-1][x+j-1] = empty
		end
	end

	--add walls to the room
	--TODO: check the x and y value to make sure they're not both offlimits for all walls
	--north wall
	local walls = {}
	for i = 1, width, 1 do
		newMap[y][x+i-1] = filled
		if (i ~= 1) and (i ~= width) then
			table.insert(walls, {x+i-1 , y})
		end
	end
	--south wall
	for i = 1, width, 1 do
		newMap[y+height-1][x+i-1] = filled
		if (i ~= 1) and (i ~= width) then
			table.insert(walls, {x+i-1 , y+height-1})
		end
	end
	--east wall
	for i = 1, height, 1 do
		newMap[y+i-1][x+width-1] = filled
		if (i ~= 1) and (i ~= height) then
			table.insert(walls, {x+width-1 , y+i-1})
		end
	end
	--west wall
	for i = 1, height, 1 do
		newMap[y+i-1][x] = filled
		if (i ~= 1) and (i ~= height) then
			table.insert(walls, {x , y+i-1})
		end
	end

	--the room addition is complete

	local walkerseed = math.floor(math.random()*(#walls-1)+2)

	return newMap, walls[walkerseed][1], walls[walkerseed][2]
end

function addRooms(map, numberOfRooms, minroomwidth, minroomheight, maxroomwidth, maxroomheight)
	local newMap = copyMap(map)

	local width = math.ceil(math.random() * (maxroomwidth - minroomwidth) + minroomwidth)
	local height = math.ceil(math.random() * (maxroomheight - minroomheight) + minroomheight)

	local currentx = 1
	local currenty = 1

	--generate the seed room
	newMap, currentx, currenty = addRoom(newMap, currentx, currenty, width, height)

	--walk the dinosaur
	local steps = math.ceil(math.random()*14)+1--change the hardcoded value later
	local direction = 1--0 = nowhere. N,E,S,W = 1,2,3,4
	local N,E,S,W = 1,2,3,4

	if newMap[currenty+1] then
		if newMap[currenty+1][currentx] == empty then
			direction = N
		end
	end
	if newMap[currenty][currentx-1] then
		if newMap[currenty][currentx-1] == empty then
			direction = E
		end
	end

	if newMap[currenty-1] then
		if newMap[currenty-1][currentx] == empty then
			direction = S
		end
	end
	
	if newMap[currenty][currentx+1] then
		if newMap[currenty][currentx+1] == empty then
			direction = W
		end
	end
	local initialdirection = direction

	newMap, currentx, currenty = branch(newMap, currentx, currenty, steps, direction)

	steps = math.ceil(math.random()*14)+1

	if (direction == N) or (direction == S) then
		if math.random() >= .5 then
			direction = W
		else
			direction = E
		end
	elseif (direction == E) or (direction == W) then
		if math.random() >= .5 then
			direction = N
		else
			direction = S
		end
	end

	newMap, currentx, currenty = branch(newMap, currentx, currenty, steps, direction)

	direction = initialdirection
	steps = math.ceil(math.random()*14)+1
	newMap, currentx, currenty = branch(newMap, currentx, currenty, steps, direction)

	return newMap
end

function branch(map, x, y, steps, direction)
	local newMap = copyMap(map)

	local currentx = x
	local currenty = y

	newMap[currenty][currentx] = empty

	local N,E,S,W = 1,2,3,4

	--resize the map
	if direction == N then
		if currenty-steps < 2 then
			newMap = growUp(newMap, math.abs(currenty-steps)+2)
			currenty = currenty + math.abs(currenty-steps)+2
		end
	end

	if direction == S then
		if currenty+steps > #newMap-1 then
			newMap = growDown(newMap, currenty+steps - #newMap+1)
		end
	end

	if direction == E then
		if currentx+steps > #newMap[1]-1 then
			newMap = growRight(newMap, currentx+steps - #newMap[1]+1)
		end
	end

	if direction == W then
		if currentx-steps < 2 then
			newMap = growLeft(newMap, math.abs(currentx-steps)+2)
			currentx = currentx + math.abs(currentx-steps)+2
		end
	end

	--carve the path
	for i = 1, steps, 1 do
		if direction == N then
			currentx = currentx
			currenty = currenty-1
			newMap[currenty][currentx] = empty
			newMap[currenty][currentx+1] = filled
			newMap[currenty][currentx-1] = filled
		end

		if direction == S then
			currentx = currentx
			currenty = currenty+1
			newMap[currenty][currentx] = empty
			newMap[currenty][currentx+1] = filled
			newMap[currenty][currentx-1] = filled
		end

		if direction == E then
			currentx = currentx+1
			currenty = currenty
			newMap[currenty][currentx] = empty
			newMap[currenty+1][currentx] = filled
			newMap[currenty-1][currentx] = filled
		end

		if direction == W then
			currentx = currentx-1
			currenty = currenty
			newMap[currenty][currentx] = empty
			newMap[currenty+1][currentx] = filled
			newMap[currenty-1][currentx] = filled
		end
	end

	--filling out corners
	if newMap[currenty+1] then
		if newMap[currenty+1][currentx] == void then
			newMap[currenty+1][currentx] = filled
		end
		if newMap[currenty+1][currentx-1] == void then
			newMap[currenty+1][currentx-1] = filled
		end
		if newMap[currenty+1][currentx+1] == void then
			newMap[currenty+1][currentx+1] = filled
		end
	end

	if newMap[currenty-1] then
		if newMap[currenty-1][currentx] == void then
			newMap[currenty-1][currentx] = filled
		end
		if newMap[currenty-1][currentx-1] == void then
			newMap[currenty-1][currentx-1] = filled
		end
		if newMap[currenty-1][currentx+1] == void then
			newMap[currenty-1][currentx+1] = filled
		end
	end
	
	if newMap[currenty][currentx-1] then
		if newMap[currenty][currentx-1] == void then
			newMap[currenty][currentx-1] = filled
		end
	end

	if newMap[currenty][currentx+1] then
		if newMap[currenty][currentx+1] == void then
			newMap[currenty][currentx+1] = filled
		end
	end

	return newMap, currentx, currenty
end

function growLeft(map, ldt)
	local newMap = copyMap(map)
	--growing left means to add void to all the rows at the front

	for i = 1, ldt, 1 do
		for row = 1, #newMap, 1 do
			table.insert(newMap[row], 1, void)
		end
	end

	return newMap
end

function growRight(map, rdt)
	local newMap = copyMap(map)
	--growing right means to add void to all the rows at the end

	for i = 1, rdt, 1 do
		for row = 1, #newMap, 1 do
			table.insert(newMap[row], void)
		end
	end

	return newMap
end

function growUp(map, udt)
	local newMap = copyMap(map)
	--growing up means to add a new row and fill it with void at the top

	--create an empty table(this will become our new row)
	--find the highest width by cycling through all the rows and finding which one has the most elements
	--add as many void to the new row as the highest width
	--add the new row to the map at the top

	for i = 1, udt, 1 do
		local newRow = {}
		local highwidth = -1
		for row = 1, #newMap, 1 do
			if #newMap[row] > highwidth then
				highwidth = #newMap[row]
			end
		end
		for i = 1, highwidth, 1 do
			table.insert(newRow, void)
		end
		table.insert(newMap, 1, newRow)
	end

	return newMap
end

function growDown(map, ddt)
	local newMap = copyMap(map)
	--growing up means to add a new row and fill it with void at the bottom

	--create an empty table(this will become our new row)
	--find the highest width by cycling through all the rows and finding which one has the most elements
	--add as many void to the new row as the highest width
	--add the new row to the map at the bottom

	for i = 1, ddt, 1 do
		local newRow = {}
		local highwidth = -1
		for row = 1, #newMap, 1 do
			if #newMap[row] > highwidth then
				highwidth = #newMap[row]
			end
		end
		for i = 1, highwidth, 1 do
			table.insert(newRow, void)
		end
		table.insert(newMap, newRow)
	end

	return newMap
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
end -- returns [the copied map]

--[[
walker random path generator

start at the edge (wall) of a room
make the wall empty
start walking in the opposite direction of an adjacent empty

keep walking that way for a random number of steps
	along the way place walls to your left and right with each step
	if you step onto a wall, make it empty
	if you step onto an empty, stop
		do not generate a room, you are inside one

when stopped, run an rng to generate a room
	if chance fails turn all void tiles in the 3x3 area around you into filled
	turn left or right randomly

walk, keep walking that way for a random number of steps
	along the way place walls to your left and right with each step
	if you step onto a wall, make it empty
	if you step onto an empty, stop
		do not generate a room, you are inside one

stop, run rng again, this time more merciful
	if chance fails turn all void tiles in the 3x3 area around you into filled
	turn to original direction(to avoid crossing back into the room)

walk a random number steps
	along the way place walls to your left and right with each step
	if you step onto a wall, make it empty
	if you step onto an empty, stop
		do not generate a room, you are inside one

generate room at destination

this way we only generate corridors that are short and simple
we can run extra checks to ensure each wall has only one corridor
]]