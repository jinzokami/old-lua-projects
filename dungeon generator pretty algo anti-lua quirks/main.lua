require("generator")

tile = 4

function love.load()
	love.filesystem.setIdentity("Karma")
	math.randomseed(os.time())
	math.random();math.random();math.random()

	map = generateNewMap(125, 125, .5)--a larger percentage of cells populated is recommended for larger maps

	stepRate = 0
end

function love.update()
	for i = 1, stepRate, 1 do
		map = tallyMapStepByStep(map)
	end
end

function love.draw()
	drawMap(map)
	love.graphics.setColor(0,0,0,255)
	love.graphics.print(stepRate)
end

function love.keypressed(key)
	if key == 'z' then
		map = generateNewMap(#map[1], #map, .5)
	end

	if key == 'x' then
		takeScreenshot()
	end

	if key == 'a' then
		seedMap(map)
	end

	if key == 'left' then
		stepRate = stepRate - 10
	end

	if key == 'right' then
		stepRate = stepRate + 10
	end

	if key == ' ' then
		if not compareMaps(map, tallyMapStepByStep(copyMap(map))) then
			map = tallyMapStepByStep(map)
		else
			print("no need, you're good.")
		end
	end
end

function takeScreenshot()
	local screenshot = love.graphics.newScreenshot()
	screenshot:encode(os.time()..'.png', 'png')
end