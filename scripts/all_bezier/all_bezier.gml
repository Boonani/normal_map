// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function bezier_init(){

	lx = ds_list_create()
	ly = ds_list_create()
	path = path_bezier
	for (var i = 0; i < path_get_number(path); i += 1) {
	ds_list_add(lx, path_get_point_x(path, i))
	ds_list_add(ly, path_get_point_y(path, i))
	}


}

function bezier_draw(){
	
	if live_call() return live_result;

	var _x, _y, _xp, _yp;
	_x = 0
	_y = 0
	var path = path_bezier;
	for (var i = 0; i <= 1; i = min(i + 1 / 50, 1)) {
	_xp = _x
	_yp = _y
	_x = bezier(i, lx)
	_y = bezier(i, ly)
	if (i == 0) continue
	draw_line_width(_xp, _yp, _x, _y, 3)
	if (i == 1) break
	}
	draw_set_color(c_blue)
	draw_path(path, 0, 0, true)
}


function bezier(_get_pos, _list){ 

// bezier(position, points:ds_list)
var  _pos, _length, _index, p, c, n;

_length = ds_list_size(_list)
_pos = max(0, min(1, _get_pos)) * _length;
_index = min(floor(_pos), _length - 1);
_pos -= _index // _pos is now (0..1)
// previous\current\next value:
p = ds_list_find_value(_list, max(_index - 1, 0))
c = ds_list_find_value(_list, _index)
n = ds_list_find_value(_list, min(_length - 1, _index + 1))
// actual calculations (yes, you need to know the formula for these):
return .5 * (((p - 2 * c + n) * _pos + 2 * (c - p)) * _pos + p + c)
	
}
