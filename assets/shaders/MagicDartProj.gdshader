shader_type spatial;

uniform sampler2D gradient;
uniform float size = 1.0 ;
uniform float power = 2.0 ;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec3 normalview = NORMAL-VIEW;
	vec3 color = texture(gradient,vec2(pow(clamp(1.0 - size*(sqrt(pow(normalview.x,2) + pow(normalview.y,2))),0.1,1.0),power))).rgb;
	ALBEDO = vec3(0.0);
	ROUGHNESS = 1.0;
	METALLIC = 1.0;
	EMISSION = color*5.0;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
