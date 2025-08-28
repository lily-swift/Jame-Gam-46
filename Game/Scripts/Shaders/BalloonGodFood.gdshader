shader_type canvas_item;

uniform vec4 color : source_color = vec4(0,0,0,1);

void vertex() {
	COLOR = color;
}