local Entity = {}
Entity.__index = Entity

function Entity:new(x, y) 
    self.x = x
    self.y = y

    self.alive = true
    self.awake = true

    self.name = "entity"
    self.id = nil
    self.parent = nil
end

function Entity:wake() end

function Entity:preupdate(dt) end
function Entity:update(dt) end
function Entity:fixed_update(tdt) end
function Entity:postupdate(dt) end

function Entity:predraw() end
function Entity:draw() end
function Entity:postdraw() end

function Entity:guidraw() end

function Entity:sleep() end

function Entity:kill() end

function Entity:on_collision(coll) end

return Entity