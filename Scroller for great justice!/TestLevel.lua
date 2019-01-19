local TestLevel = {}
TestLevel.__index = TestLevel

function TestLevel:load()
	local self = setmetatable({}, TestLevel)
	
	self._entities = {}

	self.map = {
	{1,1,1,1,1},
	{1,0,0,0,1},
	{1,0,2,0,1},
	{1,0,0,0,1},
	{1,1,1,1,1}}

	for y = 1, #self.map, 1 do
		for x = 1, #self.map, 1 do
			if self.map[y][x] == 1 then
				--spawn block entity
			end

			if self.map[y][x] == 2 then
				--spawn player entity
			end
		end
	end
	
	return self
end

function TestLevel:update(dt)
	for i, v in ipairs(self._entities) do
		v:update(dt)
	end
end

function TestLevel:draw()
	for i, v in ipairs(self._entities) do
		v:draw()
	end
end

return TestLevel