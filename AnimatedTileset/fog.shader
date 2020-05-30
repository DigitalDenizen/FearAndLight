shader_type canvas_item;

uniform vec3 color = vec3(0.3, 0.26, 0.367); 
uniform int OCTAVES = 1;

//colour is RGB divided by 256

float rand(vec2 coord) {
	return fract(sin(dot(coord, vec2(100,10))*1000.0)*1000.0);
}
//vec2(x,y) controls the fog pattern 
	
float noise(vec2 coord){
	vec2 i = floor(coord);
	vec2 f = fract(coord);
	
	float a = rand(i); 
	float b = rand(i + vec2(1.0,0.0)); 
	float c = rand(i + vec2(0.0,1.0)); 
	float d = rand(i + vec2(1.0,1.0)); 
	
	return mix(a, b, f.x) + (c - a) * f.y * (1.0 - f.x) + (d - b) * f.x * f.y;
}

float fbm(vec2 coord) {
	float value = 0.0;
	float scale = 0.15;
//scale can be used to toggle transparency
	
	for(int i = 0; i < OCTAVES; i++){
		value += noise(coord) * scale;
		coord *= 2.0;
		scale *= .5;	
	}	
	return value;
}

void fragment() {
	vec2 coord = UV * 15.0;
//UV * x, value of x looks to control fog density

	vec2 motion = vec2(fbm(coord + vec2(TIME * -.8)));
	
	float final = fbm(coord + motion);
	
	COLOR = vec4(color, final);
	}