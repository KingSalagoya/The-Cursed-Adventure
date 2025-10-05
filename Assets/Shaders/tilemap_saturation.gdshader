shader_type canvas_item;

uniform float desaturation_amount : hint_range(0.0, 1.0) = 1.0;
uniform float mix_amount: hint_range(0.0, 1.0) = 0.0;
uniform vec4 mix_color: source_color;

void fragment() {
    vec4 color = texture(TEXTURE, UV);
    
    // Convert to grayscale using luminance formula
    float gray = dot(color.rgb, vec3(0.299, 0.587, 0.114));
    
    // Mix original color with grayscale based on desaturation amount
    vec3 desaturated = mix(color.rgb, vec3(gray), desaturation_amount);
    
    COLOR = mix(vec4(desaturated, color.a), mix_color, mix_amount);
}