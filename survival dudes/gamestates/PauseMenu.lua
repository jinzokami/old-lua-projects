local PauseMenu = {}
--pause screen: this is where you go to change settings, quit, or keep playing
--have buttons, these buttons either open menus with other buttons or perform an action

PauseMenu.beenStarted = false

function PauseMenu:start()
	PauseMenu.beenStarted = true

	buttons = {} -- the buttons in the menu, click or keypress activate them
end

function PauseMenu:update(dt)
	seconds = totalPlayTimer % 60
	minutes = (totalPlayTimer/60) % 60
	hours = ((totalPlayTimer/60)/60)
end

function PauseMenu:draw()
	love.graphics.print("This is the pause menu! You've been playing for: ")

	love.graphics.print("H: "..hours, 0, 10)
	love.graphics.print("M: "..minutes, 0, 20)
	love.graphics.print("S: "..seconds, 0, 30)
end

function PauseMenu:drawGUI()

end

function PauseMenu:keypressed(key)
	if key == 'escape' then
		GameMain:changeStates(GameStatesEnum.IN_GAME)
	end
end

function PauseMenu:hasBeenStarted()
	return PauseMenu.beenStarted
end

return PauseMenu