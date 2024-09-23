shader_type canvas_item;

uniform sampler2D text;

void fragment() {
	vec2 new_UV = vec2(2.0*UV.x-1.0,2.0*UV.y-1.0);
	float r = sqrt(pow(new_UV.x,2.0) + pow(new_UV.y,2.0));
	float theta = (new_UV.y >= 0.0) ? acos(new_UV.x/r) : -acos(new_UV.x/r) ;
	theta = theta/PI/2.0+0.5;
	vec2 radial_uv = vec2(mod(1.5*PI*theta,3.0*PI/8.0),-4.0*r+3.0);
	vec4 text_texture = texture(text,radial_uv); //,vec2(theta,3.0*r+0.0));
	COLOR = text_texture;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}