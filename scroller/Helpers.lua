function changeLevels(nl)
	blocks = {}
	enemies = {}
	makeMap(nl)
	p = Player.new(spawnx, spawny)
	current_level = nl
end

function checkAllCollisions(a, tb)--a is an object, tb is a table of objects
	for i, v in ipairs(tb) do
		if checkCollision(a, tb[i]) then
			a:onCollide(tb[i])
			v:onCollide(a)
			return true, v 
		end
	end
	return false
end

function checkCollision(a, b)
	return BoundingBox.checkCollision(a, b)
end

function checkPointCollision(x, y, a)
	return BoundingBox.checkPointCollision(x, y, a)
end

function checkCollisionAt(x, y, tb)
	for i, v in ipairs(tb) do
		if checkPointCollision(x, y, tb[i]) then
			return true
		end
	end
	return false
end

function makeMap(file)
	for y = 1, #file.map, 1 do
		for x = 1, #file.map[1], 1 do
			if file.map[y][x] == 1 then
				table.insert(blocks, Block.new((x-1)*16, (y-1)*16))
			elseif file.map[y][x] == 3 then
				table.insert(enemies, BasicEnemy.new(((x-1)*16)+1, ((y-1)*16)))
			elseif file.map[y][x] == 2 then
				table.insert(blocks, Exit.new((x-1)*16, (y-1)*16))
			elseif file.map[y][x] == -1 then
				spawnx = ((x-1)*16)+1
				spawny = ((y-1)*16)-1
			end
		end
	end

	current_level = (LEVEL_1)
end