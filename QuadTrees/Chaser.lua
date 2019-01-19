local Chaser = {}
Chaser.__index = Chaser

function Chaser.new(x, y)
	local self = setmetatable({}, Chaser)

	--the bounding box of the object
	self.x = x
	self.y = y

	self.width = 0
	self.height = 0

	--the anchor points for rotation and what not
	--clamped between 0 and 1 (percentages)
	self.anchorx = 0
	self.anchory = 0

	--shortcuts for the sides
	self.top = self.y-self.height*anchory
	self.bottom = self.y+self.height*(1-anchory)
	self.left = self.x-self.width*anchorx
	self.right = self.x+self.width*(1-anchorx)

	self.id = nil -- the ID of the object, used for managing objects

	return self
end

function Chaser:update(dt)
	self.top = self.y-self.height/2
	self.bottom = self.y+self.height/2
	self.left = self.x-self.width/2
	self.right = self.x+self.width/2	

end

function Chaser:draw()
	
end

function Chaser:onCollide()

end

return Chaser