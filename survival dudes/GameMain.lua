local GameMain = {}

Button = require("GUI.Button")

--required maths
Vector2 = require("maths.Vector2")

--required game objects
GameObject = require("objects.GameObject")
Player = require("objects.Player")

function GameMain:start()
	GameStatesEnum = { -- the numbers must match the index they appear in
		SPLASH_SCREEN = 1,
		MAIN_MENU = 2,
		IN_GAME = 3,
		PAUSE_MENU = 4,
		GAME_OVER = 5
	}

	--gamestates
	GameStates = { -- the index must match the number that represents it
		require("gamestates.SplashScreen"),
		require("gamestates.MainMenu"),
		require("gamestates.InGame"),
		require("gamestates.PauseMenu"),
		require("gamestates.GameOver")
	}

	GameMain:changeStates(GameStatesEnum.SPLASH_SCREEN)
end

function GameMain:update(dt)
	GameStates[state]:update(dt)
end

function GameMain:draw()
	GameStates[state]:draw()
end

function GameMain:drawGUI()
	GameStates[state]:drawGUI()
end

function GameMain:keypressed(key)
	GameStates[state]:keypressed(key)
end

function GameMain:changeStates(newState)
	state = newState
	if not GameStates[state]:hasBeenStarted() then
		GameStates[state]:start()
	end
end

return GameMain