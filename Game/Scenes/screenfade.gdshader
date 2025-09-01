shader_type canvas_item;
uniform vec2 injectPoint;
uniform float progress;
uniform float sizeX;
uniform float sizeY;

void vertex() {
}

void fragment() {
	
	COLOR = vec4(1.0);
	float x = SCREEN_PIXEL_SIZE.x / distance(vec2(injectPoint.x, UV.y), UV);
	float y = SCREEN_PIXEL_SIZE.y / distance(vec2(UV.x, injectPoint.y), UV);
	COLOR.a = (x+y) * 1.0;
	
	//float radius = pow(progress,2)*0.5 * sign(sign(progress)+1.0);
	// COLOR.b = 100.0;
	//COLOR.a = 1.0 - pow((pow( (UV.x * sizeX - injectPoint.x)/sizeX ,2.0) * pow(sizeX/sizeY,1.6) + pow((UV.y * sizeY - injectPoint.y)/sizeY ,2.0) * pow(sizeY/sizeX,1.6))/radius,5);
	// Called for every pixel the material is visible on.
}
