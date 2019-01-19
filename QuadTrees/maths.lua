function clamp(value, minValue, maxValue) -- forces a value to stay between two numbers
	local newValue = value

	if newValue > maxValue then
		newValue = maxValue
	end

	if newValue < minValue then
		newValue = minValue
	end

	return newValue
end

function magnitude(x, y) -- finds the magnitude of a vector, or the distance from origin to a point
	return math.sqrt(x*x + y*y)
end

function normalize(x, y) -- returns a normal vector, AKA direction vector
	local mag = magnitude(x,y)
	if mag == 0 then
		return 0, 0
	end
	return x/mag, y/mag
end

function sign(number) -- return the sign of the number 1 if positive or zero -1 if negative
	if number == o then
		return 1
	end
	return number/math.abs(number)
end

function round(number)
	local dec = number - math.floor(number) -- get the decimal place
	if sign(number) > 0 then
		if dec < .5 then
			return math.floor(number)
		else
			return math.ceil(number)
		end
	else
		if dec > .5 then
			return math.floor(number)
		else
			return math.ceil(number)
		end
	end
end