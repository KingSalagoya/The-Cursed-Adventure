shader_type canvas_item;
render_mode unshaded;

uniform sampler2D screen_texture : hint_screen_texture, filter_nearest;
uniform float scanline_strength : hint_range(0.0, 1.0) = 0.5;
uniform float curvature_amount : hint_range(0.0, 0.1) = 0.035;
uniform float bloom_strength : hint_range(0.0, 1.0) = 0.20;
uniform float chromatic_offset : hint_range(0.0, 0.01) = 0.004;
uniform float noise_strength : hint_range(0.0, 0.2) = 0.03;
uniform float vignette_strength : hint_range(0.0, 1.0) = 0.25;

global uniform vec2 VIEWPORT_SIZE;

// Helper: convert uv to -1..1 range for curvature math
vec2 curved_uv(vec2 uv, float amount) {
    vec2 centered = uv * 2.0 - 1.0;
    float radius = length(centered);
    centered += centered * pow(radius, 2.0) * amount;
    return (centered * 0.5) + 0.5;
}

void fragment() {
    // Curvature
    vec2 base_uv = curved_uv(SCREEN_UV, curvature_amount);
    vec4 tex = texture(screen_texture, base_uv);

    // Scanlines
    float scanline = 0.5 + 0.5 * sin((SCREEN_UV.y * VIEWPORT_SIZE.y) * 3.1415);

    tex.rgb *= mix(1.0, scanline, scanline_strength);

    // Chromatic aberration (basic)
    vec2 dir = base_uv - vec2(0.5, 0.5);
    vec4 color;
    color.r = texture(screen_texture, base_uv + dir * chromatic_offset).r;
    color.g = texture(screen_texture, base_uv).g;
    color.b = texture(screen_texture, base_uv - dir * chromatic_offset).b;

    // Simple phosphor bloom/glow: blur around bright areas, pseudo-bloom
    float lumin = dot(color.rgb, vec3(0.333)); // crude brightness
    float bloom = bloom_strength * smoothstep(0.7, 1.0, lumin);
    color.rgb += bloom;

    // Subtle palette dithering (value noise, for illustration)
    float noise = fract(sin(dot(SCREEN_UV ,vec2(12.9898,78.233))) * 43758.5453 + TIME * 7.0);
    color.rgb += (noise - 0.5) * noise_strength;

    // Vignette
    float d = distance(SCREEN_UV, vec2(0.5));
    color.rgb *= 1.0 - vignette_strength * pow(d, 2.0);

    // Final output, clamp for LCDs
    COLOR = vec4(clamp(color.rgb, 0.0, 1.0), 1.0);
}