shader_type canvas_item;

uniform float desaturation_amount : hint_range(0.0, 1.0) = 1.0;
uniform float mix_amount: hint_range(0.0, 1.0) = 0.0;
uniform vec4 mix_color: source_color;
uniform float blur_amount : hint_range(0.0, 5.0) = 0.0;


void fragment() {
	vec4 color = vec4(0.0);
	int samples = 9;
	float offset = blur_amount / float(samples);

	for (int x = -1; x <= 1; x++) {
		for (int y = -1; y <= 1; y++) {
			vec2 sample_uv = UV + vec2(float(x), float(y)) * offset;
			color += texture(TEXTURE, sample_uv);
		}
	}
	color /= float(samples);
	// Convert to grayscale using luminance formula
	float gray = dot(color.rgb, vec3(0.299, 0.587, 0.114));

	// Mix original color with grayscale based on desaturation amount
	vec3 desaturated = mix(color.rgb, vec3(gray), desaturation_amount);

	COLOR = mix(vec4(desaturated, color.a), mix_color, mix_amount);
}