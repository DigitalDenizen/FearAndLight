shader_type canvas_item;

uniform vec4 transparent : hint_color;
uniform vec4 inner : hint_color;
uniform vec4 outer : hint_color;
//thresholds create shapes for fire based on brightness of color
uniform float inner_threshold = .4;
uniform float outer_threshold = .15;
//soft edge makes transition between colors smoother
uniform float soft_edge = 0.04;


//center is used to set the center of the flame: vec2(x,y) 
uniform vec2 center = vec2(0.5, 0.8);

//use octaves value to control noise texture detail 
uniform int OCTAVES = 4;

//rand funtion gives us a random number for each pixel in the image

float rand(vec2 coord) {
	return fract(sin(dot(coord, vec2(12.9898,78.233)))*43758.5453123);
}

//noise funtion generates the texture for the image
//vec2(x,y) controls the fog pattern 
	
float noise(vec2 coord){
	vec2 i = floor(coord);
	vec2 f = fract(coord);
	
	float a = rand(i); 
	float b = rand(i + vec2(1.0,0.0)); 
	float c = rand(i + vec2(0.0,1.0)); 
	float d = rand(i + vec2(1.0,1.0)); 
	
	vec2 cubic = f * f * (3.0 - 2.0 * f);
	
	return mix(a, b, f.x) + (c - a) * f.y * (1.0 - f.x) + (d - b) * f.x * f.y;
}

//fbm stands for fractal brownian motion, this generates noise, and also controls size
float fbm(vec2 coord) {
	float value = 0.0;
	float scale = 0.5;
//scale can be used to toggle transparency and speed
	
	for(int i = 0; i < OCTAVES; i++){
		value += noise(coord) * scale;
		coord *= 2.0;
		scale *= .4;	
	}	
	return value;
}

float overlay(float base, float top) {
	if (base < 0.5)	{
			return 2.0 * base * top;}
		else 
			{return 1.0 - 2.0 * (1.0 - base) * (1.0 - top);
			} 
	}
// creates the 'egg' shape for fire	
float egg_shape(vec2 coord, float radius) { 
	vec2 diff = abs(coord - center);
	
	//if statement stretches out portion of semi-circle that is above the center, else statement brings the bottom portion up, in order to create egg shape
	if (coord.y < center.y){
		diff.y /= 2.0;			
	} else {
		diff.y *= 2.0;
	}
	float dist = sqrt(diff.x * diff.x + diff.y * diff.y) / radius;
	//value formula creates semi-circle
	float value = sqrt(1.0 - dist * dist);
	return clamp(value, 0.0, 1.0);
	
}

void fragment() {
	vec2  coord = UV * 8.0;
	vec2 fbmcoord = coord / 6.0;
	
	//creates two concentric eggs
	float egg_s = egg_shape(UV, 0.4);
	egg_s += egg_shape(UV, 0.2) / 2.0;
	
	
	//"+ vec2(TIME * a, TIME * b)" -- this section controls the movement direction of the noise value. Variable "a" for x axis, and "b" for y axis
	float noise1 = noise(coord + vec2(TIME * .25, TIME * 4.0));
	float noise2 = noise(coord + vec2(TIME * .5, TIME * 7.0));
	float combined_noise = (noise1 + noise2) / 2.0;
	
	float fbm_noise = fbm(fbmcoord + vec2(0.0, TIME * 3.0));
	fbm_noise = overlay(fbm_noise, UV.y);
	
	//combines noise, fbm noise, and egg shape
	float everything_combined = combined_noise * fbm_noise * egg_s;
	
	if (everything_combined < outer_threshold){
		COLOR = transparent;
	//soft_edge smoothens transition between colors
	} else if (everything_combined < outer_threshold + soft_edge){
		COLOR = mix(transparent, outer, (everything_combined - outer_threshold) / soft_edge);
	} else if (everything_combined < inner_threshold){
		COLOR = outer;
	} else if (everything_combined < inner_threshold + soft_edge){
		COLOR = mix(outer, inner, (everything_combined - inner_threshold) / soft_edge);
	} else {
		COLOR = inner;
	}
	

	
}