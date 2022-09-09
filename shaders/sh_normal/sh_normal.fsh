varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 v_vPosition;

//uniform sampler2D depth;//specular map
uniform sampler2D norm;//normal map
uniform sampler2D specular;

uniform vec3 light_pos;//x,y,range
uniform vec2 view_xy;//x,y,range


void main()
{
    vec2 normal_uv = vec2( (v_vPosition.x - view_xy.x) / 1920.0, (v_vPosition.y - view_xy.y) / 1080.0);
    vec4 normal_map =texture2D(norm, normal_uv); //  vec4(0.5, 0.5, 1.0, 1.0);// 
    
    float occl = 1.0;
    if (normal_map.b < 0.5)
    {
        occl = normal_map.b * 2.0;
        normal_map.b = 0.5;
    }
    
    vec3 normal = normalize(normal_map.rgb*-2.0+1.0);
    normal.r *= -1.0; //flipping the red channel.

    vec4 light = texture2D( gm_BaseTexture, v_vTexcoord);
    
    //normal mapping
    vec3 lightDir = normalize(vec3(light_pos.x, light_pos.y, 0.0) - vec3(v_vPosition.x, v_vPosition.y, 0.0)); 
    lightDir.z = light_pos.z;
    float d = max(dot(normal, lightDir), 0.0);
    vec3 _diffuse = d * v_vColour.rgb * light.r * v_vColour.a * occl;
	
	vec4 specular_map = texture2D(specular, normal_uv);
	
	_diffuse += specular_map.rgb;
	

	vec4 color = vec4( vec3(_diffuse * light.a),   1.);
	
	float color_compare = color.r +color.g +color.b ; // iif this adds to less than 0 then get out
	
	color.a *= 1.0 - step(color_compare, 0.0 );
	
	color.rgb = v_vColour.rgb;
	color.a *= light.a;
	
	gl_FragColor = color;//   vec4(normal_depth,normal_depth , normal_depth , 1.0); //
}