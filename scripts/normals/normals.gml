function normal_layer_begin()
{

    if (event_number == 0) //0 is the event_number for the draw step, but ev_draw returns 8? donno what that is about?
    {
	   
		if !surface_exists( global.norm_surface ) { 
	
			global.norm_surface = surface_create(1920,1080);
		}
		
		surface_set_target(global.norm_surface);
        camera_apply(view_camera[0]);
        shader_set(sh_rotate);
    }

}


function normal_layer_end()
{
    if (event_number == 0) //0 is the event_number for the draw step, but ev_draw returns 8? donno what that is about?
    {
        surface_reset_target();    
        shader_reset();
    }
}

function create_normal_layer(_layer)
{
    var _lay_id = layer_get_id(_layer);

    var _depth = layer_get_depth(_lay_id);
    
    var _normal_layer = layer_create(_depth - 10, _layer + "_norm");
    
    var _asset_array = layer_get_all_elements(_lay_id);
    
    var _num = array_length(_asset_array);
    
    var _layer_sprite, _sprite, _angle, _xx, _yy, _xscale, _yscale;
    
    for (var _i = _num -1; _i >= 0; _i--)
    {
        _sprite = layer_sprite_get_sprite(_asset_array[_i]);
        _angle = layer_sprite_get_angle(_asset_array[_i]);
        _xx = layer_sprite_get_x(_asset_array[_i]);
        _yy = layer_sprite_get_y(_asset_array[_i]);
        _xscale = layer_sprite_get_xscale(_asset_array[_i]);
        _yscale = layer_sprite_get_yscale(_asset_array[_i]);
        
        _layer_sprite = layer_sprite_create(_normal_layer, _xx, _yy, _sprite);
        layer_sprite_angle(_layer_sprite, _angle);
        layer_sprite_xscale(_layer_sprite, _xscale);
        layer_sprite_yscale(_layer_sprite, _yscale);
        layer_sprite_blend(_layer_sprite, make_colour_rgb(255 * sign(_xscale), 255 * sign(_yscale), 255));
        layer_sprite_index(_layer_sprite, 1);
    }
    
if !surface_exists(global.norm_surface) { 
	
	global.norm_surface = surface_create(1920,1280);

}else{

    layer_script_begin(_normal_layer, normal_layer_begin);
    layer_script_end(_normal_layer, normal_layer_end);
}
    return _normal_layer;
}
