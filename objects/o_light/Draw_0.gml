/// @desc
if live_call() return live_result;
image_alpha = 1;
image_blend = make_color_rgb(0,255,255);
image_xscale = 5;
image_yscale = image_xscale;
x = mouse_x;
y = mouse_y;
_cam_x = 0;
_cam_y = 0;
z = -1;

sprite_set_live(s_specular_white,1)
if !surface_exists(global.specular_surface) {
	
	global.specular_surface = surface_create(1920,1280);
}else{

	surface_set_target(global.specular_surface);
	draw_clear_alpha(c_black,0);
	//DISABLE SPECULAR MAP
	//draw_sprite_ext(s_specular_white,1,0,0,1,1,0,c_white,1);
	surface_reset_target();



	if !surface_exists( global.norm_surface ) { 
	
		global.norm_surface = surface_create(1920,1080);
	
	}else{
	shader_set(sh_normal);
	//gpu_set_blendmode_ext(bm_dest_color,bm_subtract)
	gpu_set_blendmode(bm_normal)
	shader_set_uniform_f_array(o_game.light_uniform, [x, y, z]);
	shader_set_uniform_f_array(o_game.view_xy, [_cam_x, _cam_y]);

	texture_set_stage(o_game.u_specular,surface_get_texture(global.specular_surface));
	texture_set_stage(o_game.unorm,surface_get_texture(global.norm_surface));
	//gpu_set_colorwriteenable(1,1,1,0);
	draw_self();
	//gpu_set_colorwriteenable(1,1,1,1);
	gpu_set_blendmode(bm_normal)
	shader_reset();

	}

}