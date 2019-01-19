local Button = {}
Button.__index = Button

function Button.new(x, y, w, h) -- constructor requires no arguments
	local self = setmetatable({}, Button)

	self.x = (x or 0) -- the position of the button
	self.y = (y or 0)
	self.width = (w or -1) -- then size of the button
	self.height = (h or -1)

	self.style = "" -- the visual style of the button, nothing specific yet

	self.selected = false -- whether or not the button has been moused over or if using keyboard, whether it is the current selection

	self.text = "" -- the text displayed by the button

	self.action = function(self) end -- the action performed by the button, does nothing by default

	return self
end

function Button:update()
	if self.width == -1 then -- if no width is specified
		self.width = (self.text:len()*6.25)+1 -- use an auto generated value
	end

	if self.height == -1 then -- if height is not specified
		self.height = 16 -- button is assumed to be default height
	end

	self.left = self.x
	self.right = self.x + self.width
	self.top = self.y
	self.bottom = self.y + self.height

	if love.mouse.isDown(1) then -- first, check if the mouse is down
		self.selected = false
		if (love.mouse.getX() > self.left) and (love.mouse.getX() < self.right) then -- make sure x is in order
			if (love.mouse.getY() > self.top) and (love.mouse.getY() < self.bottom) then -- make sure y is in order
				self.selected = true
				self:action()
			end
		end
	else
		self.selected = false
		if (love.mouse.getX() > self.left) and (love.mouse.getX() < self.right) then -- make sure x is in order
			if (love.mouse.getY() > self.top) and (love.mouse.getY() < self.bottom) then -- make sure y is in order
				self.selected = true
			end
		end
	end
end

function Button:draw()
	if self.selected then
		love.graphics.setColor(255,0,0,255)
	else
		love.graphics.setColor(0,0,255,255)
	end

	love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
	love.graphics.setColor(255,255,255,255)
	love.graphics.print(self.text, self.x+2, self.y)
end

return Button