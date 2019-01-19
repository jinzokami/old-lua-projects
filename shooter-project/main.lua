--TODO list:
--entity management (spawning, destroying, ids, parenting)
--
--collision
--AABB/SAT
--
--physics
--Euler Int
--
--loop
--fix your timestep
--
--Camera
--smooth follower
--
--enemy
--basic follower enemy
--basic shooter enemy
--
--player
--dashing
--shots bounce
--shots die
--different gun types
--shotgun
--machine gun
--handgun
--rifle
--
--Levels
--dungeon generator
--tilesets
--
--ui
--menus
--
--sound/music
--sound manager (multiple streams)
--music manager (single stream w/ state machine)
--volume management sound, music, master

EntityManager = require("EntityManager")
Player = require("Player")
Bullet = require("Bullet")
Camera = require("Camera")
Block = require("Block")

tick_rate = 100
tick_delta = 1/tick_rate
acc = 0

function love.load()
	em = EntityManager:new()
	
	--entity registry
	em:register("player", Player)
	em:register("bullet", Bullet)
	em:register("camera", Camera)
	em:register("block", Block)

	local p = em:spawn("player", 300, 300)
	local cam = em:spawn("camera", 0, 0)
	cam.target = p.id

	em:spawn("block", 0, 0)
	em:spawn("block", 32, 0)
	em:spawn("block", 0, 32)
end

function love.update(dt)
	em:cleanup()
	em:preupdate(dt)
	em:update(dt)

	acc = acc + dt
	while acc > tick_delta do
		acc = acc - tick_delta
		em:fixed_update(tick_delta)
	end

	em:collision()

	em:postupdate(dt)
end

function love.draw()
	em:predraw()
	em:draw()
	em:postdraw()

	em:guidraw()
end