shader_type canvas_item;
uniform vec2 injectPoint;
uniform bool enabled;
uniform float progress;
uniform float sizeX;
uniform float sizeY;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float radius = pow(progress,2)*2.2;
	// COLOR.b = 100.0;
	COLOR.a = (sign(pow( (UV.x * sizeX - injectPoint.x)/sizeX ,2.0) + pow((UV.y * sizeY - injectPoint.y)/sizeY ,2.0) -  radius) + 1.0)*50.0;
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
