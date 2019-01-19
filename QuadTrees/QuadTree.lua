--[[
adapted from: http://gamedevelopment.tutsplus.com/tutorials/quick-tip-use-quadtrees-to-detect-likely-collisions-in-2d-space--gamedev-374
]]

local QuadTree = {}
QuadTree.__index = QuadTree

QuadTree.MAX_OBJECTS = 4 -- defines how many objects one can hold before a split
QuadTree.MAX_LEVELS = 5 -- defines how many levels deep a tree can be

function QuadTree.new(lev, x, y, width, height)
	local self = setmetatable({}, QuadTree)

	self.level = lev

	self.objects = {}

	--bounds - a rectangle
	self.x = x
	self.y = y
	self.width = width
	self.height = height

	self.nodes = {} --max 4 elements

	return self
end

--clears QuadTree by recursively clearing all objects from all nodes
function QuadTree:clear()
	self.objects = {}

	for i = 1, #self.nodes, 1 do
		if self.nodes[i] then
			self.nodes[i]:clear()
		end
		self.nodes[i] = nil
	end
end

-- divides the tree into fourths
function QuadTree:split()
	local subwidth = math.floor(self.width / 2)
	local subheight = math.floor(self.height / 2)
	local x = self.x
	local y = self.y

	self.nodes[1] = QuadTree.new(self.level+1, x + subwidth, y, subwidth, subheight)
	self.nodes[2] = QuadTree.new(self.level+1, x, y, subwidth, subheight)
	self.nodes[3] = QuadTree.new(self.level+1, x, y + subheight, subwidth, subheight)
	self.nodes[4] = QuadTree.new(self.level+1, x + subwidth, y + subheight, subwidth, subheight)
end

-- determines which node an object belongs to -1 means it doesn't fit into one and is in the parent node
function QuadTree:getIndex(object)
	local index = -1
	local verticalMidpoint = self.x + self.width/2
	local horizontalMidpoint = self.y + self.height/2

	--object can completely fit in the top quadrants
	local topQuadrant = ((object.y < horizontalMidpoint) and (object.y + object.height < horizontalMidpoint))
	-- object can completely fit in the bottom quadrants
	local bottomQuadrant = (object.y > horizontalMidpoint)

	--object can completely fit in the left quadrants
	if ((object.x < verticalMidpoint) and (object.x + object.width < verticalMidpoint)) then
		if topQuadrant then
			index = 2
		elseif bottomQuadrant then
			index = 3
		end
	--object can completely fit in the right quadrants
	elseif object.x > verticalMidpoint then
		if topQuadrant then
			index = 1
		elseif bottomQuadrant then
			index = 4
		end
	end

	return index
end

function QuadTree:insert(object)
	if self.nodes[1] then
		local index = self:getIndex(object)

		if index ~= -1 then
			self.nodes[index]:insert(object)
			return
		end
	end

	table.insert(self.objects, object)

	if (#self.objects > QuadTree.MAX_OBJECTS) and (self.level < QuadTree.MAX_LEVELS) then
		if not self.nodes[1] then
			self:split()
		end

		local i = 1
		while i <= #self.objects do
			local index = self:getIndex(self.objects[i])
			if index ~= -1 then
				self.nodes[index]:insert(table.remove(self.objects, i)) -- table.remove also return the value that was removed
			else
				i = i + 1
			end
		end
	end
end

function QuadTree:retrieve(returnObjects, object)
	local index = self:getIndex(object)
	if (index ~= -1) and self.nodes[1] then
		self.nodes[index]:retrieve(returnObjects, object)
	end

	for i = 1, #self.objects, 1 do
		table.insert(returnObjects, self.objects[i]) -- add all the elements of the node to this table
		-- no comparable function in lua
	end

	return returnObjects
end

--debug
function QuadTree:draw()
	--draws itself and recursively calls the draw functions of all child nodes
	if self.nodes[1] then
		self.nodes[1]:draw()
		self.nodes[2]:draw()
		self.nodes[3]:draw()
		self.nodes[4]:draw()
	end

	love.graphics.setColor(255,255,255,255)
	
	if self.level == 0 then
		love.graphics.setColor(0,0,255,255)
	elseif self.level == 1 then
		love.graphics.setColor(0,255,255,255)
	elseif self.level == 2 then
		love.graphics.setColor(0,255,0,255)
	elseif self.level == 3 then
		love.graphics.setColor(255,255,0,255)
	elseif self.level == 4 then
		love.graphics.setColor(255,0,0,255)
	elseif self.level == 5 then
		love.graphics.setColor(255,0,255,255)
	end
	love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
end

return QuadTree