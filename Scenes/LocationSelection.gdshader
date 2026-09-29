shader_type canvas_item;

uniform float blur_amount : hint_range(0.0, 10.0) = 4.0;

void fragment() {
	vec2 texel_size = SCREEN_PIXEL_SIZE;
	vec4 sum = vec4(0.0);
	float total_weight = 0.0;

	for (int x = -4; x <= 4; x++) {
		for (int y = -4; y <= 4; y++) {
			vec2 offset = vec2(float(x), float(y)) * texel_size * blur_amount;
			float weight = 1.0;
			sum += texture(TEXTURE, UV + offset) * weight;
			total_weight += weight;
		}
	}

	COLOR = sum / total_weight;
}