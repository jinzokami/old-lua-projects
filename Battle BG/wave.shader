uniform float timer;

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords)
{
    float a = 0.05;
    float b = 10.0;
    vec4 texturecolor = vec4(1.0, 1.0, 1.0, 1.0);
    texture_coords.x = texture_coords.x + a * sin((timer + texture_coords.y) * b);
    texturecolor = Texel(texture, texture_coords);
    return texturecolor;
}

vec4 position( mat4 transform_projection, vec4 vertex_position )
{
    return transform_projection * vertex_position;
}