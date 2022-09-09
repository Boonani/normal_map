attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 v_vPosition;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
    v_vPosition = (gm_Matrices[MATRIX_WORLD] * object_space_pos).xy;
}//######################_==_YOYO_SHADER_MARKER_==_######################@~
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
	
	
	
	
	gl_FragColor =  vec4(_diffuse * light.a, light.a);//   vec4(normal_depth,normal_depth , normal_depth , 1.0); // 
	
}