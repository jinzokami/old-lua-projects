function colliding(x1, y1, w1, h1, x2, y2, w2, h2)
	if (y1 >= y2+h2) or (y1+h1 <= y2) or (x1 >= x2+w2) or (x1+w1 <= x2) then
		return false
	end

	return true
end

currentID = 0
function getNewID()
	currentID = currentID + 1
	return currentID
end

function createGridBackground(grid, tileset) -- the grid and the string that represents the tileset path
	local canvas = love.graphics.newCanvas(#grid[1]*16, #grid*16)
	canvas:renderTo(function() 
		for y = 1, #grid, 1 do
			for x = 1, #grid[y], 1 do
				if grid[y][x] == 1 then
					love.graphics.setColor(255,255,255,255)
				else
					love.graphics.setColor(0,0,0,255)
				end
				love.graphics.rectangle("fill", (x-1)*16, (y-1)*16, 16, 16)
			end
		end
	end)
	local imgData = canvas:newImageData()
	local bgImage = love.graphics.newImage(imgData)

	return bgImage

end