require("map")

function love.load()
	math.randomseed(os.time())
	tilesize = 8
	map = generateMap()


	excavatorx = 2
	excavatory = 2

	crashTestTimer = .25
	generate = 0
	timerRunning = false
end

function love.update(dt)
	if timerRunning then crashTestTimer = crashTestTimer - dt end

	if crashTestTimer < 0 then
		crashTestTimer = crashTestTimer + .25
		generate = generate + 1
	end

	for i = 1, generate, 1 do
		map = generateMap()
	end
end

function love.draw()
	love.graphics.push()
	love.graphics.translate(128,128)

	for y = 1, #map, 1 do
		for x = 1, #map[y], 1 do
			if map[y][x] == -1 then
				love.graphics.setColor(255, 0, 255, 255)
				love.graphics.rectangle("fill", (x-1)*tilesize, (y-1)*tilesize, tilesize, tilesize)
			elseif map[y][x] == 0 then
				love.graphics.setColor(255, 255, 0, 255)
				love.graphics.rectangle("fill", (x-1)*tilesize, (y-1)*tilesize, tilesize, tilesize)
			elseif map[y][x] == 1 then
				love.graphics.setColor(255, 0, 0, 255)
				love.graphics.rectangle("fill", (x-1)*tilesize, (y-1)*tilesize, tilesize, tilesize)
			end
		end
	end

	love.graphics.setColor(0,0,255,100)
	love.graphics.rectangle("fill", (excavatorx-1)*tilesize, (excavatory-1)*tilesize, tilesize, tilesize)

	love.graphics.pop()

	love.graphics.setColor(255,255,255,255)
	love.graphics.print("width: "..#map[1].." | height: "..#map.." | total area: "..#map*#map[1], 0, love.graphics.getHeight()-16)
end

function love.keypressed(key)
	if key == 'r' then
		map = generateMap(map)
	end

	if key == 'left' then
		excavatorx = excavatorx - 1
	end

	if key == 'right' then
		excavatorx = excavatorx + 1
	end

	if key == 'up' then
		excavatory = excavatory - 1
	end

	if key == 'down' then
		excavatory = excavatory + 1
	end

	if key == ' ' then
		if excavatory > #map then
			map = growDown(map, excavatory - #map)
		end
		if excavatorx > #map[1] then
			map = growRight(map, excavatorx - #map[1])
		end

		if excavatory < 1 then
			map = growUp(map, math.abs(excavatory)+1)
			excavatory = excavatory + math.abs(excavatory)+1
		end
		if excavatorx < 1 then
			map = growLeft(map, math.abs(excavatorx)+1)
			excavatorx = excavatorx + math.abs(excavatorx)+1
		end

		map[excavatory][excavatorx] = empty
	end

	if key == 'lshift' then
		if excavatory > #map then
			map = growDown(map, excavatory - #map)
		end
		if excavatorx > #map[1] then
			map = growRight(map, excavatorx - #map[1])
		end

		if excavatory < 1 then
			map = growUp(map, math.abs(excavatory)+1)
			excavatory = excavatory + math.abs(excavatory)+1
		end
		if excavatorx < 1 then
			map = growLeft(map, math.abs(excavatorx)+1)
			excavatorx = excavatorx + math.abs(excavatorx)+1
		end

		map[excavatory][excavatorx] = filled
	end

	if key == 'z' then
		map = addRoom(map, excavatorx-2, excavatory, 10, 10)
	end
end