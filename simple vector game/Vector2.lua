local Vector2 = {}
Vector2.__index = Vector2

Vector2.__sub = function (a, b)
	if type(a) == "number" then
		return false
	end
	if type(b) == "number" then
		return false
	end
	return Vector2.new(a.x-b.x, a.y-b.y)
end

Vector2.__add = function (a, b)
	if type(a) == "number" then
		return false
	end
	if type(b) == "number" then
		return false
	end
	return Vector2.new(a.x + b.x, a.y + b.y)
end

Vector2.__mul = function (a, b)
	if (a == 0) or ( b == 0 ) then
		return Vector2.new(0, 0)
	end

	if type(a) == "number" then
		scalar = a
	else 
		vector = Vector2.new(a.x, a.y)
	end

	if type(b) == "number" then
		scalar = b
	else
		vector = Vector2.new(b.x, b.y)
	end

	if not scalar then
		print("multiplication not defined for vector-vector")
		return false
	end

	if not vector then
		print("how did you get here?")
		return false
	end

	return Vector2.new(scalar*vector.x, scalar*vector.y)
end

Vector2.__div = function (a, b)
	if type(a) == "number" then
		scalar = a
		scalarfirst = true
	else 
		vector = Vector2.new(a.x, a.y)
		scalarfirst = false
	end

	if type(b) == "number" then
		scalar = b
	else
		vector = Vector2.new(b.x, b.y)
	end

	if not scalar then
		print("division not defined for vector-vector")
		return false
	end

	if not vector then
		print("how did you get here?")
		return false
	end

	if scalar == 0 then
		print("Nice Job Breaking It, Hero. (division by zero)")
		return false
	end

	if scalarfirst then
		return Vector2.new(scalar/vector.x, scalar/vector.y)
	else
		return Vector2.new(vector.x/scalar, vector.y/scalar)
	end
end

function Vector2.new(x, y)
	local self = setmetatable({}, Vector2)

	self.x = x
	self.y = y

	return self
end

function Vector2:getMagnitude()
	return math.sqrt(self.x*self.x + self.y*self.y)
end

function Vector2:getNormalized()
	if self:getMagnitude() == 0 then
		return Vector2.new(0, 0)
	end
	
	return Vector2.new(self.x/self:getMagnitude(), self.y/self:getMagnitude())
end

function Vector2:getPerpendicular()
	return Vector2.new(-self.y, -self.x)
end

function Vector2:toString()
	return "x: "..self.x.." y: "..self.y
end

return Vector2