continue = 1
quit = 2

total_choices = 2

choice = continue

local PauseMenu = {}
PauseMenu.__index = PauseMenu

function PauseMenu.update()
	if choice > total_choices then
		choice = total_choices
	end
	if choice < 1 then
		choice = 1
	end
end

function PauseMenu.draw()
	if choice == continue then
		love.graphics.setColor(255, 0, 0, 255)
	else 
		love.graphics.setColor(255,255,255,255)
	end
	love.graphics.print("continue", 16, 16)

	if choice == quit then
		love.graphics.setColor(255, 0, 0, 255)
	else 
		love.graphics.setColor(255,255,255,255)
	end
	love.graphics.print("quit", 16, 32)

	--[[if choice == *replace with new choice* then
		love.graphics.setColor(255, 0, 0, 255)
	else 
		love.graphics.setColor(255,255,255,255)
	end
	love.graphics.print(*replace with new choice text*, 16, 16)]]
end

function PauseMenu.keypressed(key) 
	if key == 'return' then
		if choice == quit then
			love.event.push('quit')
		elseif choice == continue then
			paused = not paused
		end
	end

	if key == 'left' then
		choice = choice - 1
	elseif key == 'right' then
		choice = choice + 1
	end

	if key == 'up' then
		choice = choice - 1
	elseif key == 'down' then
		choice = choice + 1
	end
end

return PauseMenu