function distance(x1, y1, x2, y2)
    return math.sqrt((x1-x2)^2 + (y1-y2)^2)
end

function distance_sqr(x1, y1, x2, y2)
    return (x1-x2)^2 + (y1-y2)^2
end

function lerp(t, a, b)
    return (1-t)*a + t*b
end