local TestRoom = {}
TestRoom.__index = TestRoom

function TestRoom.new()
	local self = setmetatable({}, TestRoom)

	self.map = {
	{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
	{1,0,0,0,0,0,1,0,0,0,0,0,0,0,1},
	{1,0,0,0,0,0,1,0,0,0,0,0,0,0,1},
	{1,0,0,0,0,0,1,0,0,0,0,0,0,0,1},
	{1,0,0,0,0,0,1,0,0,0,0,0,0,0,1},
	{1,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
	{1,0,0,0,0,0,1,0,0,0,0,0,0,0,1},
	{1,0,0,0,0,0,1,0,0,0,0,0,0,0,1},
	{1,0,0,0,0,0,1,0,0,0,0,0,0,0,1},
	{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}}

	self.bg = createGridBackground(self.map)

	return self
end

function TestRoom:enter()
	--initializes collision data
end

function TestRoom:update(dt)
	--if the room needs to keep track of things, do it here
end

function TestRoom:draw()
	love.graphics.draw(self.bg, 0, 0)
end

function TestRoom:exit()
	-- body
end

return TestRoom