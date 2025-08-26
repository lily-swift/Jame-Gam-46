shader_type canvas_item;

uniform vec4 color : source_color = vec4(0,0,0,0);

void fragment() {
	COLOR = texture(TEXTURE, UV);
	COLOR = vec4(color.r * COLOR.r, color.g * COLOR.g, color.b * COLOR.b, COLOR.a);
}