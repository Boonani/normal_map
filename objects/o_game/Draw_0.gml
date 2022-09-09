/// @desc
if live_call() return live_result;
	
	
var angle_claire = 0;
	
draw_sprite_ext(s_claire_cards_normal_4,0,320,64,4,4,angle_claire,c_white,1  );
	
	
	
	
light_x = mouse_x;
light_y = mouse_y;
	
	
	
	
if !surface_exists(global.norm_surface) { 
														
	global.norm_surface = surface_create(1920,1280);	
														
}else{
	
	
	//set angle
	surface_set_target(global.norm_surface);
	draw_clear_alpha(c_black,0);
	camera_apply(view_camera[0]);
	shader_set(sh_rotate);
	
	draw_sprite_ext(s_claire_cards_normal_4,1,320,64,4,4,angle_claire,c_white,1  );
	
	surface_reset_target();    
	shader_reset();
	
	
   // layer_script_begin(_normal_layer, normal_layer_begin);
   // layer_script_end(_normal_layer, normal_layer_end);
	
	
	sprite_set_live(s_specular_white,1)
	
	if !surface_exists(global.specular_surface) {
		global.specular_surface = surface_create(1920,1280);
	}else{
		//specular
		surface_set_target(global.specular_surface);
		draw_clear_alpha(c_black,0);
		//DISABLE SPECULAR MAP
		draw_sprite_ext(s_specular_white,1,0,0,1,1,0,c_white,1);
		surface_reset_target();
		
		if !surface_exists( global.norm_surface ) { 
	
			global.norm_surface = surface_create(1920,1080);
	
		}else{
	
		shader_set(sh_normal);
		//gpu_set_blendmode_ext(bm_dest_color,bm_subtract)
		//gpu_set_blendmode(bm_normal)
		gpu_set_blendmode(bm_normal)
		//gpu_set_blendmode_ext(bm_dest_color,bm_subtract)
		shader_set_uniform_f_array(o_game.light_uniform, [light_x, light_y, z]);
		shader_set_uniform_f_array(o_game.view_xy, [_cam_x, _cam_y]);
		
		texture_set_stage(o_game.u_specular,surface_get_texture(global.specular_surface));
		texture_set_stage(o_game.unorm,surface_get_texture(global.norm_surface));
		
		//gpu_set_colorwriteenable(1,1,1,0);
		var light_scale = 4;
		var light_color = c_fuchsia;
		var light_alpha = 1;
		
		draw_sprite_ext(s_light_hard,0,light_x,light_y,light_scale,light_scale,angle_claire,light_color,light_alpha);
		//gpu_set_colorwriteenable(1,1,1,1);
		gpu_set_blendmode(bm_normal)
		shader_reset();
		}
	}
}
//bezier_draw();