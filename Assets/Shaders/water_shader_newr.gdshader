shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture;
uniform vec4 water_color : source_color;
uniform sampler2D wave_noise : repeat_enable;
uniform float wave_speed : hint_range(0.0, 2.0) = 0.2;
uniform float wave_strength : hint_range(0.0, 0.2) = 0.02;
uniform float wave_scale : hint_range(0.1, 10.0) = 3.0;

void fragment() {
    // Sample moving wave noise (scale UV so pattern isn't microscopic)
    vec2 noise_uv = UV * wave_scale + vec2(TIME * wave_speed, TIME * wave_speed * 0.5);
    vec2 water_wave = (texture(wave_noise, noise_uv).rg - 0.5) * wave_strength;

    // Reflection: flip vertically based on SCREEN_UV but keep wave offset
    vec2 uv = vec2(SCREEN_UV.x, 1.0 - SCREEN_UV.y) + water_wave;

    // Sample screen texture
    vec4 color = texture(screen_texture, uv);

    // Blend factor based on "depth" (distance from water surface)
    float mix_value = 1.0 - UV.y;

    // Adjust blend based on brightness of reflected area
    float avg_color = (color.r + color.g + color.b) / 3.0;
    avg_color = pow(avg_color, 1.4);
    mix_value += avg_color;

    // Clamp and apply water color tint
    mix_value = clamp(mix_value, 0.0, 0.7);
    COLOR = mix(water_color, color, mix_value);
}
