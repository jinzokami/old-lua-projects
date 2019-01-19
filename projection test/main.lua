Rectangle = require("Rectangle")

function love.load()
	shape1 = Rectangle:new(100, 100, 32, 64)
	shape2 = Rectangle:new(200, 200, 64, 32)
end

function love.update()

end

function love.draw()

end

--[[
SAT - the basic steps

for ALL sides in a polygon:
	find the perpendicular vector
	project all points of the first shape 
		onto the perpendicular vector
		(keep track of the highest and lowest values)
	do it again for the second
	check if any values overlap
	if no, move on to the next side
		if no more sides return false
	if yes, return true
]]

function isColliding(a, b)

end