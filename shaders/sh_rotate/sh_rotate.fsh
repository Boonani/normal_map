#extension GL_OES_standard_derivatives : require
varying vec2 v_vTexcoord;
varying vec4 v_vColour;



void main()
{
    vec4 normColor = texture2D(gm_BaseTexture, v_vTexcoord);
    vec3 normal = normColor.rgb;
    normal.b = 1.0;
    normal = normalize(normal.rgb-.5);
//    vec3 normal = normalize(normColor.rgb-.5);

	//dx, dy tells us if sprite has been rotated. image_angle
    vec2 dx = dFdx(v_vTexcoord);
    vec2 dy = dFdy(v_vTexcoord);
    
	//checks if sprite has been flipped -xscale/-yscale
    dx.y *= (-1.0 + (2.0 * v_vColour.g));
    dy.x *= (-1.0 + (2.0 * v_vColour.g));
    
    dx.y *= (-1.0 + (2.0 * v_vColour.r));
    dy.x *= (-1.0 + (2.0 * v_vColour.r));
    
    vec4 rot = vec4(dx,dy);

    normal.xy *= mat2(normalize(rot.xz),normalize(rot.yw));
    
    gl_FragColor = vec4((normal.r *0.5+0.5), normal.g *0.5+0.5, normColor.b,  normColor.a * v_vColour.a);
}