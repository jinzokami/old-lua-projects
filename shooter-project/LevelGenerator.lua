local Entity = require("Entity")

local LevelGenerator = {}
setmetatable(LevelGenerator, {__index = Entity})

function LevelGenerator:new(x, y)
    local self = setmetatable({}, LevelGenerator)
    LevelGenerator.__index = LevelGenerator

    self.x = 0
    self.y = 0

    self.steps = 1000 --steps for the drunkards walk
    self.width = 100 --cells across
    self.height = 100 --cells down
    self.stepx = 50
    self.stepy = 50

    self.alive = true
    self.awake = true
    self.name = "level generator"
    self.id = nil
    self.parent = nil
    
    return self
end

function LevelGenerator:preupdate(dt)

end