local BoundingBox = {}
BoundingBox.__index = BoundingBox

function BoundingBox.checkCollision(a, b)
	if a ~= b then
		if b.x > a.x + a.width or a.x > b.x + b.width
		or b.y > a.y + a.height or a.y > b.y + b.height then
			return false
		else
			return true
		end
	end
end

function BoundingBox.checkPointCollision(x, y, a)
	if x > a.x + a.width or a.x > x
	or y > a.y + a.height or a.y > y then
		return false
	else
		return true
	end
end

return BoundingBox