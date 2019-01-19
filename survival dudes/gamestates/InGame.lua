local InGame = {}
--this is the actual game, everything up to this point is just fluff before it (menus, splashes, etc.)

InGame.beenStarted = false

function InGame:start()
	InGame.beenStarted = true
	totalPlayTimer = 0 -- useful for playtime display on menu screens, just like final fantasy!

	seconds = 0
	minutes = 0
	hours = 0

	-- game initialization
	entities = {} -- the game objects that need updating, most of the interactive stuff goes in here, along with AI
	colliders = {} -- collision boxes and such, this is where most of the maths-y stuff gets done
	tiles = {} -- tiles to be rendered, in a separate category than entities for efficiency's sake

	p = Player.new(32, 32)
end

function InGame:update(dt)
	totalPlayTimer = totalPlayTimer + dt
end

function InGame:draw()
	
end

function InGame:drawGUI()

end

function InGame:keypressed(key)
	if key == 'escape' then
		love.event.push("quit") -- normally would open the pause menu, but for now closes the game
	end
end

function InGame:hasBeenStarted()
	return InGame.beenStarted
end

function InGame:addEntitiy(ent)
	table.insert(entities, ent)
end

function InGame:addCollision(col)
	table.insert()
end

return InGame