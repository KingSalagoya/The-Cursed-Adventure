shader_type canvas_item;

uniform float radius: hint_range(0.0, 2000.0) = 256.0;
uniform float blur_width: hint_range(0.0, 500.0) = 32.0;
uniform vec2 player_center;

global uniform float SCREEN_WIDTH;
global uniform float SCREEN_HEIGHT;

void fragment() {
    float x = UV.x * SCREEN_WIDTH;
    float y = UV.y * SCREEN_HEIGHT;

    float dist = distance(vec2(x, y), player_center);

    // Smooth transition from opaque to transparent
    float alpha = smoothstep(radius, radius + blur_width, dist);

    COLOR.a = alpha;
}