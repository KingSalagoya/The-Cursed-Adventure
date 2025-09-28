shader_type canvas_item;

uniform vec4 color;
uniform float amount;

void fragment() {
	COLOR.rgb = mix(COLOR.rgb, color.rgb, amount);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
