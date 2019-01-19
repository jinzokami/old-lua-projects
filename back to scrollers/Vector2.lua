Vector2 = class('Vector2')

function Vector2.sub(a, b)
	if type(a) == "number" then
		return false
	end
	if type(b) == "number" then
		return false
	end
	return Vector2(a.x-b.x, a.y-b.y)
end

function Vector2.add(a, b)
	if type(a) == "number" then
		return false
	end
	if type(b) == "number" then
		return false
	end
	return Vector2(a.x + b.x, a.y + b.y)
end

function Vector2.multiply (a, b)
	if (a == 0) or ( b == 0 ) then
		return Vector2(0, 0)
	end

	if type(a) == "number" then
		scalar = a
	else 
		vector = Vector2(a.x, a.y)
	end

	if type(b) == "number" then
		scalar = b
	else
		vector = Vector2(b.x, b.y)
	end

	if not scalar then
		return false
	end

	if not vector then
		return false
	end

	return Vector2(scalar*vector.x, scalar*vector.y)
end

function Vector2.divide(a, b)
	if type(a) == "number" then
		scalar = a
		scalarfirst = true
	else 
		vector = Vector2(a.x, a.y)
		scalarfirst = false
	end

	if type(b) == "number" then
		scalar = b
	else
		vector = Vector2(b.x, b.y)
	end

	if not scalar then
		return false
	end

	if not vector then
		return false
	end

	if scalar == 0 then
		return false
	end

	if scalarfirst then
		return Vector2(scalar/vector.x, scalar/vector.y)
	else
		return Vector2(vector.x/scalar, vector.y/scalar)
	end
end

Vector2.__mul = Vector2.multiply
Vector2.__add = Vector2.add
Vector2.__sub = Vector2.sub
Vector2.__div = Vector2.divide

function Vector2:initialize(x, y)
	self.x = x
	self.y = y
end

function Vector2:getMagnitude()
	return math.sqrt(self.x*self.x + self.y*self.y)
end

function Vector2:getNormalized()
	if self:getMagnitude() == 0 then
		return Vector2.new(0, 0)
	end
	
	return Vector2(self.x/self:getMagnitude(), self.y/self:getMagnitude())
end

function Vector2:getPerpendicular()
	return Vector2(-self.y, -self.x)
end

function Vector2:translate( ... ) -- takes an x and y or aa vector
	if type(arg[1]) == "number" then
		self.x = self.x + arg[1]
		self.y = self.y + arg[2]
	else
		self.x = self.x + arg[1].x
		self.y = self.y + arg[1].y
	end
end

function Vector2:toString()
	return "x: "..self.x.." y: "..self.y
end