function love.load()
	entities = {}


end

function love.update(dt)

end

function love.draw()

end

function organizeEntities(entity)
	if sort = "id" then
		for i, v in ipairs(entities) do
			v:setId(i)
		end
end

function addEntity(entity)
	table.insert(entities, entity)
	entity:setId(entities)
end