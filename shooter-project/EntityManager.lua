require("math")

local EntityManager = {}
EntityManager.__index = EntityManager

function EntityManager:new()
	local self = setmetatable({}, EntityManager)

	self.entities = {}
	self.registry = {}
	self.to_clean = {}

	self.current_id = 0

	self.has_camera = false
	self.camera_id = -1

	return self
end

--the first thing to run at the start of a loop
function EntityManager:preupdate(dt)
	for k, v in pairs(self.entities) do
		v:preupdate(dt)
	end
end

function EntityManager:update(dt)
	for k, v in pairs(self.entities) do
		v:update(dt)
	end
end

function EntityManager:fixed_update(tdt)
	for k, v in pairs(self.entities) do
		v:fixed_update(tdt)
	end
end

--collision detection
function EntityManager:collision() 

end

--last thing to run before rendering begins
function EntityManager:postupdate(dt)
	for k, v in pairs(self.entities) do
		v:postupdate(dt)
	end
end

--for me, this is for setting camera stuff
function EntityManager:predraw()
	for k, v in pairs(self.entities) do
		v:predraw()
	end
end

function EntityManager:draw()
	for k, v in pairs(self.entities) do
		v:draw()
	end
end

--this is for unsetting camera stuff
function EntityManager:postdraw()
	for k, v in pairs(self.entities) do
		v:postdraw()
	end
end

--this is for drawing the gui
function EntityManager:guidraw()
	for k, v in pairs(self.entities) do
		v:guidraw()
	end
end

function EntityManager:register(name, entity)
	self.registry[name] = entity
end

function EntityManager:spawn(name, x, y)
	self.current_id = self.current_id + 1
	local id = self.current_id

	local en = self.registry[name]:new(x, y)
	en.parent = self
	en.id = id
	
	self.entities[id] = en

	if name == "camera" then
		--clean the previous camera
		if self.has_camera then self:kill(self.camera_id) end
		self.has_camera = true
		self.camera_id = id
	end
	return en
end

function EntityManager:kill(id)
	self.entities[id]:kill()
	self.entities[id].alive = false
	tbale.insert(self.to_clean, id)
end

function EntityManager:get(id)
	return self.entities[id]
end

function EntityManager:get_all(name)
	local all_by_name = {}
	for k, v in pairs(self.entities) do
		if v.name == name then
			table.insert(all_by_name, v)
		end
	end

	return all_by_name
end

function EntityManager:get_closest(name, caller)
	local all_by_name = self:get_all(name)
	local min_dist = math.huge
	local min_ent = nil

	for i = 1, #all_by_name, 1 do
		if (distance(caller.x, caller.y, all_by_name[i].x, all_by_name[i].y)) < min_dist then
			min_ent = all_by_name[i]
		end
	end

	return min_ent
end

function EntityManager:cleanup()
	for i, v in ipairs(self.to_clean) do
		v = nil
	end
end

function EntityManager:get_mouse_screen_coords() 
	return love.mouse.getX(), love.mouse.getY()
end

function EntityManager:get_mouse_world_coords() 
	if not self.has_camera then return self:get_mouse_screen_coords() end

	local cam = self.entities[self.camera_id]
	local nsx = ((love.mouse.getX() / love.graphics.getWidth())*2 - 1)
	local nsy = ((love.mouse.getY() / love.graphics.getHeight())*2 - 1)
	local wmx = cam.x + nsx * love.graphics.getWidth()/2--(love.graphics.getWidth()/2) + cam.x + love.mouse.getX()
	local wmy = cam.y + nsy * love.graphics.getHeight()/2--(love.graphics.getHeight()/2) + cam.y + love.mouse.getY()
	
	return wmx, wmy
end

return EntityManager