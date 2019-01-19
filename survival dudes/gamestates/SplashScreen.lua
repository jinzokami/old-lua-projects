local SplashScreen = {}

SplashScreen.beenStarted = false

function SplashScreen:start()
	SplashScreen.timer = 5
	SplashScreen.beenStarted = true
end

function SplashScreen:update(dt)
	SplashScreen.timer = SplashScreen.timer - dt
	if SplashScreen.timer <= 0 then
		GameMain:changeStates(GameStatesEnum.IN_GAME)
	end

	if mouse.isDown(1,2,3) then
		GameMain:changeStates(GameStatesEnum.IN_GAME)
	end
end

function SplashScreen:draw()
	love.graphics.print("This is the splash screen. Something almost meaningless will appear here at some point.")
end

function SplashScreen:drawGUI()

end

function SplashScreen:exit() -- when the state ends and will not be started again(or if it is, then it starts like it never started before)
	SplashScreen.beenStarted = false
	GameMain:changeStates(GameStatesEnum.IN_GAME)
end

function SplashScreen:keypressed(key)
	GameMain:changeStates(GameStatesEnum.IN_GAME)
end

function SplashScreen:hasBeenStarted()
	return SplashScreen.beenStarted
end

return SplashScreen