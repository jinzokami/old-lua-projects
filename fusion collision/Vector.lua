vector = {}

function vector.magnitude(x, y)
	return math.sqrt(x*x + y*y)
end

function vector.normalized(x, y)
	local normx = x / vector.magnitude(x, y)
	local normy = y / vector.magnitude(x, y)
	return normx, normy
end

function vector.dotproduct(x1, y1, x2, y2)
	return x1*x2 + y1*y2
end

function vector.perpendicular(x, y)
	return -y, x
end