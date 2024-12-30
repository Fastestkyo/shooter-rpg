shader_type canvas_item;

uniform sampler2D cracks_texture;
uniform sampler2D vein_texture;
uniform vec4 color_1 : source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 color_2 : source_color = vec4(34.0,32.0,12.0,1.0);
uniform float tilting_factor : hint_range(1.0, 10.0 ) = 1.0;
uniform float move_speed:hint_range(0.1, 5.0) = 0.1;
uniform float subtraction_speed :hint_range(0.1, 5.0) = 0.1;

void fragment() {
	vec2 uv = UV * tilting_factor;
	uv.y += TIME * -move_speed;

	uv = fract(uv);

	float noise_value = texture(cracks_texture, uv).r;

	float subtraction_factor = sin(TIME * subtraction_speed);

	float dissolve_value = texture(vein_texture, uv).r;

	float final_value = noise_value - (dissolve_value * subtraction_factor);

	vec4 final_color = mix(color_1,color_2,final_value);

	COLOR = final_color;
}
