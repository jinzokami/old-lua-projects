
function isOverlapping(a, b)--decides which case this is
	if (a:getType() == "box") and (b:getType() == "box") then
		return isOverlappingBVB(a, b)
	end
	if (a:getType() == "circle") and (b:getType() == "box") then
		return isOverlappingCVB(a, b)
	end
	if (a:getType() == "box") and (b:getType() == "circle") then
		return isOverlappingBVC(a, b)
	end
	if (a:getType() == "circle") and (b:getType() == "circle") then
		return isOverlappingCVC(a, b)
	end
end

function isOverlappingCVC(a, b)--circle on circle
	if distance(a:getX(), a:getY(), b:getX(), b:getY()) < a:getRadius() + b:getRadius() then
		pushMessage("Successful Circle on Circle Collision")
		return true
	else
		return false
	end
end

function isOverlappingCVB(a, b)--circle on box --this code ripped from internet: https://forums.tigsource.com/index.php?topic=26092.0
	--copy the circle center to a new point (this changes so there needs to be a copy)

	local pt = {}
	pt.x = a:getX()
	pt.y = a:getY()

	--point on box closest to circle 
	--(snaps the point to the box, pretty much, 
	--if the circle center is inside the box there isn't snapping, 
	--but this is fine since it will detect a collision as a result)

	if(pt.x > b:getX() + b:getWidth()) then 
		pt.x = b:getX() + b:getWidth()
	end
	
	if(pt.x < b:getX()) then
		pt.x = b:getX() 
	end
	
	if(pt.y > b:getY() + b:getHeight()) then
		pt.y = b:getY() + b:getHeight()
	end
	
	if(pt.y < b:getY()) then
		pt.y = b:getY() 
	end


	--distance check, just use distance^2 for actual implementation

	if(distance(pt.x, pt.y, a:getX(), a:getY()) < a:getRadius()) then
		pushMessage("Successful Circle on Box(box) Collision")
		return true 
	else
		return false
	end
end

function isOverlappingBVB(a, b)--box on box
	if a:getX() > b:getX()+b:getWidth() or
		b:getX() > a:getX()+a:getWidth() or
		a:getY() > b:getY()+b:getHeight() or
		b:getY() > a:getY()+a:getHeight() then
		return false
	else
		pushMessage("Successful Box on Box Collision")
		return true
	end
end

function isOverlappingBVC(a, b)--box on circle --this code ripped from internet: https://forums.tigsource.com/index.php?topic=26092.0
	--copy the circle center to a new point (this changes so there needs to be a copy)

	local pt = {}
	pt.x = b:getX()
	pt.y = b:getY()

	--point on box closest to circle 
	--(snaps the point to the box, pretty much, 
	--if the circle center is inside the box there isn't snapping, 
	--but this is fine since it will detect a collision as a result)

	if(pt.x > a:getX() + a:getWidth()) then 
		pt.x = a:getX() + a:getWidth()
	end
	
	if(pt.x < a:getX()) then
		pt.x = a:getX() 
	end
	
	if(pt.y > a:getY() + a:getHeight()) then
		pt.y = a:getY() + a:getHeight()
	end
	
	if(pt.y < a:getY()) then
		pt.y = a:getY() 
	end


	--distance check, just use distance^2 for actual implementation

	if(distance(pt.x, pt.y, b:getX(), b:getY()) < b:getRadius()) then
		pushMessage("Successful Box on Circle Collision")
		return true 
	else
		return false
	end
end