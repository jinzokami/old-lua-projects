function love.conf(t)
    t.window.width = 1920                -- The window width (number)
    t.window.height = 1080               -- The window height (number)
    t.window.borderless = true         -- Remove all border visuals from the window (boolean)
    t.window.fullscreen = true         -- Enable fullscreen (boolean)
    t.window.msaa = 4                   -- The number of samples to use with multi-sampled antialiasing (number)
    t.window.x = 0                    -- The x-coordinate of the window's position in the specified display (number)
    t.window.y = 0                    -- The y-coordinate of the window's position in the specified display (number)
 
    t.modules.physics = false            -- Enable the physics module (boolean)
    t.modules.video = false              -- Enable the video module (boolean)
end