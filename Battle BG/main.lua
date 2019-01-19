function love.load()
    circles = {}

    for i = 1, 5, 1 do 
        local rx, ry = math.random() * love.graphics.getWidth(), math.random() * love.graphics.getHeight()
        local rr = 0
        local points = {
            {0, 0},
            {love.graphics.getWidth(), 0},
            {0, love.graphics.getHeight()},
            {love.graphics.getWidth(), love.graphics.getHeight()}
        }
        for i = 1, #points, 1 do
            rr = math.max(rr, distance(rx, ry, points[i][1], points[i][2]))
        end
        table.insert(circles, {rx, ry, rr})
    end
    colors = {
        {0, 0, 0},
        {255, 0, 0},
        {0, 255, 0},
        {0, 0, 255},
        {255, 255, 0},
        {255, 0, 255},
        {0, 255, 255},
        {255, 255, 255}
    }

    current_color = 1
    current_circle = 1
    current_alpha = 0

    -- bg1_i = love.graphics.newImage("BG1.png")
    -- shader = love.graphics.newShader("wave.shader")
    -- love.graphics.setShader(shader)
    -- shader:send("timer", 0)
    -- tim = 0
    -- update = true
end

function love.update(dt)
    if current_alpha > 1 then 
        current_alpha = current_alpha - 1
        
        current_circle = current_circle + 1 
        if current_circle > #circles then
            current_circle = 1
        end
        
        love.graphics.setBackgroundColor(colors[current_color][1], colors[current_color][2], colors[current_color][3])
        current_color = current_color + 1
        if current_color > #colors then
            current_color = 1
        end
    end
    current_alpha = current_alpha + (dt/3)

    if love.keyboard.isDown("escape") then love.event.push("quit") end
    
    -- if love.keyboard.isDown("space") then update = true end
    -- if update then
    -- tim = tim + 1/60
    -- shader:send("timer", tim)

    -- update = false
    -- end
end

function love.draw()
    love.graphics.setColor(colors[current_color][1], colors[current_color][2], colors[current_color][3], 255)
    love.graphics.circle("fill", circles[current_circle][1], circles[current_circle][2], lerp(current_alpha, 0, circles[current_circle][3]))

    -- love.graphics.scale(8)
    -- love.graphics.draw(bg1_i)
end

function distance(x1, y1, x2, y2)
    return math.sqrt((x1-x2)^2 + (y1-y2)^2)
end

function lerp(t, a, b)
    return (1-t)*a + t*b
end