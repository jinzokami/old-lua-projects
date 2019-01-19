local GameObject = {}
GameObject.__index = GameObject

function GameObject:new()
	local self = setmetatable({}, GameObject)

	self.position = Vector2:new(0,0) -- defaults to zero because we are not instantiating this

	return self
end

function GameObject:update(dt) end -- does nothing because we are not instantiating this
function GameObject:draw() end -- does nothing, but that might change depending on how i draw sprites.

function GameObject:moveTo(destination, rate) -- returns the movement vector args: destination vector, amount to move
	local arrived = false
	local posDelta = self.position - destination
	--we now have a vector that tells us how far we have to go and in what direction
	
	local finalDelta = posDelta:getNormalized()
	
	finalDelta = finalDelta * rate

	if finalDelta.x > posDelta.x then
		finalDelta.x = posDelta.x
	end

	if finalDelta.y > posDelta.y then
		finalDelta.y = posDelta.y
	end

	if (finalDelta.x == posDelta.x) and (finalDelta.y == posDelta.y) then
		arrived = true
	end

	return finalDelta.x, finalDelta.y, arrived -- returns the dx and dy and whether it has arrived at destination.
end

return GameObject