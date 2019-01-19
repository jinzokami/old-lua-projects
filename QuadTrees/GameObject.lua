local GameObject = {}
GameObject.__index = GameObject

--shell of the gameobject, 
--every object in the game will be based on this
--whatever is included in here needs to be included in every game object

function GameObject.new()
	local self = setmetatable({}, GameObject)

	--the bounding box of the object
	self.x = 0
	self.y = 0

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

function GameObject:update(dt)
	self.top = self.y-self.height*anchory
	self.bottom = self.y+self.height*(1-anchory)
	self.left = self.x-self.width*anchorx
	self.right = self.x+self.width*(1-anchorx)	

end

function GameObject:draw()
	
end

function GameObject:onCollide()

end

return GameObject