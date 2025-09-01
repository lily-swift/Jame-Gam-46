shader_type canvas_item;
uniform vec2 injectPoint;
uniform float progress;
uniform float sizeX;
uniform float sizeY;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float radius = pow(progress,2)*0.5 * sign(sign(progress)+1.0);
	// COLOR.b = 100.0;
	COLOR.a = 1.0 - pow((pow( (UV.x * sizeX - injectPoint.x)/sizeX ,2.0) * pow(sizeX/sizeY,1.6) + pow((UV.y * sizeY - injectPoint.y)/sizeY ,2.0) * pow(sizeY/sizeX,1.6))/radius,5);
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
