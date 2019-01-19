local Sprite = {}
Sprite.__index = Sprite

function Sprite:new(image, fw, fh, iw, ih)
	local self = setmetatable({}, Sprite)

	self.image_width = iw
	self.image_height = ih

	self.frame_width = fw
	self.frame_height = fh

	self.image = image

	self.quads = {}
	for i = 1, , 1 do

	end

	return self
end

function Sprite:update(dt)

end

function Sprite:draw(x, y)

end

function Sprite:scale(x, y)

end

function Sprite:rotate(r)

end

return Sprite