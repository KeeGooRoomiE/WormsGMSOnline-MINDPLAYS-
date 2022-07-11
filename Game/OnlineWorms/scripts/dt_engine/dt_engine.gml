/// This set of functions comprises the main Detsructible Terrain Engine.
/// The functions in this script are used to initialise the destructible
///	terrain, as well as create and remove areas of terrain at run time.
///	There is also a couple of collision functions - one specifically for 
///	getting collisions with the terrain, and another for getting the terrain
///	"normal" - and finally the main "draw" functions.
///
///	This script also contains a number of "internal" functions required by
///	the engine to work correctly. DO NOT EDIT THESE FUNCTIONS!!!!
///
///	The full list of user functions in this script is:
///
///		terrain_init(layer, x, y, width, height, scale, texture, view_port, [debug])
///		terrain_create_circle(_x, _y, radius)
///		terrain_create_rectangle(_x, _y, half_width, half_height)
///		terrain_remove_circle(_x, _y, radius)
///		terrain_remove_rectangle(_x, _y, half_width, half_height)
///		terrain_collision(_x, _y)
///		terrain_normal(_x, _y)
///		terrain_draw(
///
///	The full list of internal functions in this script is:
/// 
///		terrain_update_triangles(_x1, _y1, _x2, _y2)
///		terrain_create_triangles(_p1, _p2, _p3 ,_p4, i, j, _scale)
///		terrain_create_triangle(_x1, _y1, _x2, _y2, _x3, _y3, i, j, _scale)
///		terrain_interpolate(p1, p2)
///		terrain_cleanup(flag)
///


/// Initiliase terrain constants that are required by the engine

#macro t_debug_none 0
#macro t_debug_basic 1
#macro t_debug_medium 2
#macro t_debug_adv 3


/// @function						terrain_init(layer_id, _x, _y, width, height, scale, texture, viewport, [debug]);
///	@param	{int/str}	layer_id	The layer to place the destructible terrain on
///	@param	{int}		_x			The X position in the room to start the destructible terrain area from
///	@param	{int}		_y			The Y position in the room to start the destructible terrain area from
///	@param	{int}		width		The width of the area to permit destructible terrain
///	@param	{int}		height		The height of the area to permit destructible terrain
///	@param	{int}		scale		The scale of the terrain blocks in pixels
///	@param	{index}		texture		The texture to use for the terrain
///	@param	{index}		viewport	The view_port to use, or -1 if no view is enabled
///	@param	{bool}		debug		OPTIONAL! Set to true to enable debug mode and false to disable it (default is false)

///	@description		This function initialises the destructible terrain controller object,
///						defining an area within which destructible terrain can be created and
///						destroyed. The area is from the given x/y position to the x/y plus 
///						width/height, and the terrain will be created on the given layer. Note 
///						that if the layer ID given is not valid, then a layer will be created
///						with a depth of zero. You can then use the "terrain_get/set_layer()"
///						scripts to change this if required. When you create the terrain you are
///						required to also supply a scale value, the texture to use and a view 
///						port to target (this can be -1 for the full room). The scale value is 
///						the size of the "base" blocks that will make up the terrain and in general
///						you will want this to be the same size as the texture sprite used. Also
///						note that the texture sprite should be SQUARE, and that the smaller the 
///						scale/texture, the greater the processing required, so make sure to choose
///						appropriate values for the resolution of your game. IMPORTANT! The texture
///						sprite MUST have "Seperate Texture Page" ticked in the sprite editor.
///
///						IMPORTANT! GMS2 still places a maximum array size of 32000 entres on 2D
///						arrays, so if the scale value is small enough and the terrain area is large
///						enough you may get an error when running this function. Make sure that you 
///						choose an adequate scale value for the size of the room!

function terrain_init(layer_id, _x, _y, width, height, scale, texture, viewport)
{
terrain_log("terrain_init() - Initialising destructible terrain");

// Check layer
if is_string(layer_id)
	{
	layer_id = layer_get_id(layer_id);
	}

if !layer_exists(layer_id)
	{
	terrain_log("terrain_init() - ERROR! Given layer ID does not exist. Using created layer depth 0.");
	layer_id = layer_create(0, "Destructible_Terrain_Layer");
	}

var _terrain_id = instance_create_layer(0, 0, layer_id, obj_Terrain_Controller);
with (_terrain_id)
	{
	// Initialise controller instance vars
	terrain_scale = scale;
	terrain_x = _x div scale;
	terrain_y = _y div scale;
	terrain_width = width div scale;
	terrain_height = height div scale;
	terrain_tris = 0;
	terrain_tex = texture;
	terrain_tex_scale = terrain_scale / sprite_get_width(terrain_tex);
	terrain_tex_id = sprite_get_texture(terrain_tex, 0);
	terrain_tex_w = 1 / terrain_scale;
	terrain_tex_h = 1 / terrain_scale;
	terrain_view = viewport;
	terrain_smooth = true;
	terrain_debug = t_debug_none;

	// Check debug level
	if argument_count > 8
		{
		terrain_debug = argument[8];
		if terrain_debug > t_debug_none
			{
			alarm[0] = room_speed / 2;
			}
		}

	// Local control variables
	var k = 0;
	var _array;

	// Create the initial terrain array
	for(var i = terrain_x; i <= terrain_width; ++i;)
		{
		for(var j = terrain_y; j <= terrain_height; ++j;)
			{
		    terrain_array[i][j] = k++;
			}
		}

	// Create the terrain density array and vertex arrays
	for(i = terrain_x; i <= terrain_width; ++i;)
		{
		for(j = terrain_y; j <= terrain_height; ++j;)
			{
		    terrain_density[i][j] = 0;
		    terrain_polygons[i][j] = 0;
			_array = terrain_array[i][j];
		    for(k = 0; k < 3; ++k;)
				{
		        terrain_px1[_array][k] = 0;
		        terrain_py1[_array][k] = 0;
		        terrain_px2[_array][k] = 0;
		        terrain_py2[_array][k] = 0;
		        terrain_px3[_array][k] = 0;
		        terrain_py3[_array][k] = 0;
				}
			}
		}
	}

// Create the terrain from objects in the room
with (obj_Terrain_Creator)
	{
	switch (object_index)
		{
		case obj_Terrain_Brush_Circle:
			terrain_create_circle(x, y, sprite_width);
			break;
		case obj_Terrain_Brush_Rect:
			terrain_create_rectangle(x, y, sprite_width / 2, sprite_height / 2);
			break;
		}
	instance_destroy();
	}

return _terrain_id;
}



/// @function				terrain_create_circle(_x, _y, radius);
///	@param	{real}	_x		The X position to create the terrain at
///	@param	{real}	_y		The Y position to create the terrain at
///	@param	{real}	radius	The radius of the circle to use for creating the terrain

///	@decription		This function can be used to create circular areas of destructible terrain
///					anywhere within the bounds of the terrain area.
	
function terrain_create_circle(_x, _y, radius)
{
terrain_log("terrain_create_circle() - Adding destructible terrain");
with (obj_Terrain_Controller)
	{
	var _size = terrain_scale;
	var _ww = terrain_width;
	var _hh = terrain_height;
	var _xx = terrain_x;
	var _yy = terrain_y;
	var _ix = floor(_x / _size);
	var _iy = floor(_y / _size);
	var _hsize = floor(radius / _size) + 1;
	var _x1 = max(_xx, _ix - (_hsize + 1));
	var _y1 = max(_yy, _iy - (_hsize + 1));
	var _x2 = min(_ww, _ix + (_hsize + 1));
	var _y2 = min(_hh, _iy + (_hsize + 1));
	var _hpx = _x / _size;
	var _hpy = _y / _size;
	var _pdist, _amt;
	// Loop through the density array and update
	for(var i = _x1 ; i <= _x2; ++i;)
		{
		for(var j = _y1; j <= _y2; ++j;)
			{
		    _pdist = point_distance(i, j, _hpx, _hpy) / (_hsize * 0.9);
		    _amt = 1 - _pdist;
		    if (_amt > 0) _amt *= 2;
		    if terrain_density[i][j] < _amt
				{
				terrain_density[i][j] = clamp(_amt, 0, 1);
				}
			}
		}
	// Update the terrain itself...
	terrain_update_triangles(_x1, _y1, _x2, _y2);
	return true;
	}

terrain_log("terrain_create_circle() - ERROR! No terrain controller instance detected, returning false");
return false;
}


/// @function						terrain_create_rectangle(_x, _y, half_width, half_height);
///	@param	{real}	_x				The X position to create the terrain at
///	@param	{real}	_y				The Y position to create the terrain at
///	@param	{real}	half_width		The half width of the terrain to make
///	@param	{real}	half_height		The halfheight of the terrain to make

///	@decription		This function can be used to create rectangular areas of destructible terrain
///					anywhere within the bounds of the terrain area. The rectangle will be created
///					around the given point,and clamped to within the boundaries of the destructible
///					terrain controller.

function terrain_create_rectangle(_x, _y, half_width, half_height)
{
var _x1 = _x - half_width;
var _y1 = _y - half_height;
var _x2 = _x + half_width;
var _y2 = _y + half_height;

terrain_log("terrain_create_rectangle() - Adding destructible terrain");

with (obj_Terrain_Controller)
	{
	var _size = terrain_scale;
	var _tw = terrain_width;
	var _th = terrain_height;
	var _tx = terrain_x;
	var _ty = terrain_y;
	_x1 = clamp((_x1 + (_size / 2)) div _size, _tx, _tx + _tw);
	_y1 = clamp((_y1 + (_size / 2)) div _size, _ty, _ty + _th);
	_x2 = clamp((_x2 + (_size / 2)) div _size, _tx, _tx + _tw);
	_y2 = clamp((_y2 + (_size / 2)) div _size, _ty, _ty + _th);
	// Loop through the density array and update
	for(var i = _x1; i <= _x2; ++i;)
		{
		for(var j = _y1; j <= _y2; ++j;)
			{
			terrain_density[i][j] = 1;
			}
		}
	// Update the terrain itself...
	_x1 = clamp(_x1 - 1, _tx, _tx + _tw);
	_y1 = clamp(_y1 - 1, _ty, _ty + _th);
	_x2 = clamp(_x2 + 1, _tx, _tx + _tw);
	_y2 = clamp(_y2 + 1, _ty, _ty + _th);
	terrain_update_triangles(_x1, _y1, _x2, _y2);
	return true;
	}

terrain_log("terrain_create_rectangle() - ERROR! No terrain controller instance detected, returning false");
return false;
}


/// @function				terrain_remove_circle(_x, _y, radius);
///	@param	{real}	_x		The X position to remove the terrain at
///	@param	{real}	_y		The Y position to remove the terrain at
///	@param	{real}	radius	The radius of the circle to use for removing the terrain

///	@decription		This function can be used to remove circular areas of destructible terrain
///					anywhere within the bounds of the terrain area.

function terrain_remove_circle(_x, _y, radius)
{
terrain_log("terrain_remove_circle() - Removing destructible terrain");
with (obj_Terrain_Controller)
	{
	var _size = terrain_scale;
	var _ww = terrain_width;
	var _hh = terrain_height;
	var _xx = terrain_x;
	var _yy = terrain_y;
	var _ix = floor(_x / _size);
	var _iy = floor(_y / _size);
	var _hsize = floor(radius / _size) + 1;
	var _x1 = max(_xx, _ix - (_hsize + 1));
	var _y1 = max(_yy, _iy - (_hsize + 1));
	var _x2 = min(_ww, _ix + (_hsize + 1));
	var _y2 = min(_hh, _iy + (_hsize + 1));
	var _hpx = _x / _size;
	var _hpy = _y / _size;
	var pdist, amt;
	// Loop through the density array and update
	for(var i = _x1 ; i <= _x2; ++i;)
		{
		for(var j = _y1; j <= _y2; ++j;)
			{
		    pdist = point_distance(i, j, _hpx, _hpy) / (_hsize * 0.9);
		    amt = 1 - pdist;
		    if (amt > 0) amt *= 2;
		    if terrain_density[i][j] > 1 - amt
				{
				terrain_density[i][j] = clamp(1 - amt, 0, 1);
				}
			}
		}
	// Update the terrain itself...
	terrain_update_triangles(_x1, _y1, _x2, _y2);
	return true;
	}

terrain_log("terrain_remove_circle() - ERROR! No terrain controller instance detected, returning false");
return false;
}


/// @function						terrain_remove_rectangle(_x, _y, half_width, half_height);
///	@param	{real}	_x				The X position to create the terrain at
///	@param	{real}	_y				The Y position to create the terrain at
///	@param	{real}	half_width		The half width of the terrain to make
///	@param	{real}	half_height		The halfheight of the terrain to make

///	@decription		This function can be used to remove a rectangular area anywhere within the 
///					bounds of the destructible terrain area.
function terrain_remove_rectangle(_x, _y, half_width, half_height)
{
var _x1 = _x - half_width;
var _y1 = _y - half_height;
var _x2 = _x + half_width;
var _y2 = _y + half_height;

terrain_log("terrain_create_rectangle() - Adding destructible terrain");

with (obj_Terrain_Controller)
	{
	var _size = terrain_scale;
	var _tw = terrain_width;
	var _th = terrain_height;
	var _tx = terrain_x;
	var _ty = terrain_y;
	_x1 = clamp((_x1 + (_size / 2)) div _size, _tx, _tx + _tw);
	_y1 = clamp((_y1 + (_size / 2)) div _size, _ty, _ty + _th);
	_x2 = clamp((_x2 + (_size / 2)) div _size, _tx, _tx + _tw);
	_y2 = clamp((_y2 + (_size / 2)) div _size, _ty, _ty + _th);
	// Loop through the density array and update
	for(var i = _x1; i <= _x2; ++i;)
		{
		for(var j = _y1; j <= _y2; ++j;)
			{
			terrain_density[i][j] = 0;
			}
		}
	// Update the terrain itself...
	_x1 = clamp(_x1 - 1, _tx, _tx + _tw);
	_y1 = clamp(_y1 - 1, _ty, _ty + _th);
	_x2 = clamp(_x2 + 1, _tx, _tx + _tw);
	_y2 = clamp(_y2 + 1, _ty, _ty + _th);
	terrain_update_triangles(_x1, _y1, _x2, _y2);
	return true;
	}

terrain_log("terrain_remove_rectangle() - ERROR! No terrain controller instance detected, returning false");
return false;
}


///	@function				terrain_collision(_x, _y);
///	@param	{real}	_x		The X position to check for a collision
///	@param	{real}	_y		The Y position to check for a collision

///	@description	This function checks if at the point(x,y) the density value
///					is >= 0.5 by interpolating the surrounding densities. If it
///					is then a collision is returned.

function terrain_collision(_x, _y)
{
var _val = 0;

with (obj_Terrain_Controller)
	{
	var _px = floor(_x / terrain_scale) 
	var _py = floor(_y / terrain_scale) 
	if _px >= terrain_x
	&& _px < terrain_width
	&& _py >= terrain_y
	&& _py < terrain_height
		{
		var _p1 = terrain_density[_px][_py];
		var _p2 = terrain_density[_px + 1][_py];
		var _p3 = terrain_density[_px][_py + 1];
		var _p4 = terrain_density[_px + 1][_py + 1];
		_x = _x / terrain_scale - _px;
		_y = _y / terrain_scale - _py;
		var _vy = lerp(_p1, _p2, _x);
		var _va = lerp(_p3, _p4, _x);
		_val = lerp(_vy, _va, _y);
		}
	if _val >= 0.5
		{
		return true;
		}
	else return false;
	}

terrain_log("terrain_collision() - ERROR! No terrain controller instance detected, returning false");
return false;
}


/// @function			terrain_normal(_x, _y);
///	@param	{real}	_x	The X position to get the normal at
///	@param	{real}	_y	The Y position to get the normal at

/// @description	Get the nromal direction of the given position from the detructible
///					terrain controller. The function will return a direction from 0 to 359
///					if there is a normal value, otherwise it will return -1.

function terrain_normal(_x, _y)
{
with (obj_Terrain_Controller)
	{
	var _xcell = _x div terrain_scale;
	var _ycell = _y div terrain_scale;
	_xcell = clamp(_xcell, terrain_x, terrain_x + terrain_width -1);
	_ycell = clamp(_ycell, terrain_y, terrain_y + terrain_width -1);
	var _polygon = terrain_polygons[_xcell][_ycell];
	if _polygon > 0
		{
		var _array = terrain_array[_xcell][_ycell];
	    var _px1 = terrain_px1[_array][0];
	    var _py1 = terrain_py1[_array][0];
	    var _px2 = terrain_px2[_array][0];
	    var _py2 = terrain_py2[_array][0];
		var _pdir = point_direction(_px1, _py1, _px2, _py2) - 90;
		return _pdir;
		}
	else return -1;
	}

terrain_log("terrain_normal() - ERROR! No terrain controller instance detected, returning false");
return false;
}


/// @function			terrain_draw();

/// @description	Draw the destructible terrain to the screen. DO NOT EDIT!!!!

function terrain_draw()
{
// Assign local variables
var _tscale = terrain_scale;
var _tx = terrain_x;
var _ty = terrain_y;
var _ww = terrain_width;
var _hh = terrain_height;

// Check debugging level
if terrain_debug >= t_debug_medium
	{
	// Draw the density matrix if the debug level is high enough
	var _c, _d;
	var _hscale = _tscale / 2;
	for(var i = _tx; i < _ww; i+=1)
		{
		for(var j = _ty; j < _hh; j+=1)
			{
			_d = terrain_density[i,j] * 255;
			_c = make_color_rgb(_d, _d / 2, _d / 2);
			draw_sprite_stretched_ext(spr_Terrain_Pixel, 0, (i *_tscale) - _hscale, (j *_tscale) - _hscale, _tscale, _tscale, _c, 0.5);
			}
		}
	}

// Setup general draw values
var _current_colour = draw_get_colour();
var _current_alpha = draw_get_alpha();
draw_set_color(c_white);
draw_set_alpha(1);
gpu_set_texrepeat(true);

// Check to see if views are enabled
if terrain_view > -1
	{
	// Draw only the parts of the terrain that are inside the view
	var _vnum = terrain_view;
	var _vx1 = max(_tx, floor(camera_get_view_x(view_camera[_vnum]) / _tscale));
	var _vy1 = max(_ty, floor(camera_get_view_y(view_camera[_vnum]) / _tscale));
	var _vx2 = min(_ww, ceil((camera_get_view_x(view_camera[_vnum]) + camera_get_view_width(view_camera[_vnum])) / _tscale));
	var _vy2 = min(_hh, ceil((camera_get_view_y(view_camera[_vnum]) + camera_get_view_height(view_camera[_vnum])) / _tscale));
	}
else
	{
	// Draw all the terrain visible in the room
	var _vx1 = max(_tx, 0);
	var _vy1 = max(_ty, 0);
	var _vx2 = min(_ww, ceil(room_width / _tscale));
	var _vy2 = min(_hh, ceil(room_height / _tscale));
	}

// Setup draw vars
var i, j, k;
var _px1, _py1, _px2, _py2, _px3, _py3;
var _tx1, _ty1, _tx2, _ty2, _tx3, _ty3;
var _polygons, _array;

// Start drawing
vertex_begin(terrain_tex_buff, terrain_tex_format);

for(i = _vx1; i < _vx2; ++i;)
	{
	for(j = _vy1; j < _vy2; ++j;)
		{
	    _polygons = terrain_polygons[i][j];
	    if _polygons > 0
			{
	        // Draw the triangles.
	        for(k = 0; k < _polygons; ++k;)
				{
				_array = terrain_array[i][j];
	            _px1 = terrain_px1[_array][k];
	            _py1 = terrain_py1[_array][k];
	            _px2 = terrain_px2[_array][k];
	            _py2 = terrain_py2[_array][k];
	            _px3 = terrain_px3[_array][k];
	            _py3 = terrain_py3[_array][k];
				_tx1 = _px1 * terrain_tex_w;
				_tx2 = _px2 * terrain_tex_w;
				_tx3 = _px3 * terrain_tex_w;
				_ty1 = _py1 * terrain_tex_h;
				_ty2 = _py2 * terrain_tex_h;
				_ty3 = _py3 * terrain_tex_h;
				vertex_position(terrain_tex_buff, _px1, _py1);
				vertex_colour(terrain_tex_buff, c_white, 1);
				vertex_texcoord(terrain_tex_buff, _tx1, _ty1);
				vertex_position(terrain_tex_buff, _px2, _py2);
				vertex_colour(terrain_tex_buff, c_white, 1);
				vertex_texcoord(terrain_tex_buff, _tx2, _ty2);
				vertex_position(terrain_tex_buff, _px3, _py3);
				vertex_colour(terrain_tex_buff, c_white, 1);
				vertex_texcoord(terrain_tex_buff, _tx3, _ty3);
	            // CHeck debug level and draw terrain normals if level is high enough
	            if terrain_debug >= t_debug_adv && k == 0
					{
					var _pdir = point_direction(_px1,_py1,_px2,_py2)-90
		            var _nx = (_px1 + _px2) * 0.5;
		            var _ny = (_py1 + _py2) * 0.5;
					draw_sprite_ext(spr_Terrain_Pixel, 0, _nx, _ny, 0.5 * _tscale, 1, _pdir, c_white, 1);
					}
				}
		    }
		else
			{
			// No need to draw triangles when the full sprite texture can be drawn instead.
			if terrain_density[i][j] >= 0.5
			&& terrain_density[i + 1][j] >= 0.5
			&& terrain_density[i][j + 1] >= 0.5
			&& terrain_density[i + 1][j + 1] >= 0.5
				{
				draw_sprite_ext(terrain_tex, 0, i * _tscale, j * _tscale, terrain_tex_scale, terrain_tex_scale, 0, c_white, 1)
				}
			}
		}
	}
vertex_end(terrain_tex_buff);

// Submit the vertex buffer to draw the terrain to the screen
if terrain_debug >= t_debug_basic
	{
	vertex_submit(terrain_tex_buff, pr_linelist, terrain_tex_id); 
	}
else vertex_submit(terrain_tex_buff, pr_trianglelist, terrain_tex_id);

// Reset draw alpha/colour
draw_set_color(_current_colour);
draw_set_alpha(_current_alpha);
}



/// <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< INTERNAL - DO NOT EDIT! >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


/// @function				terrain_update_triangles(_x1, _y1, _x2, _y2);
///	@param	{int}	_x1		The left side of the rectangular area to update
///	@param	{int}	_y1		The top side of the rectangular area to update
///	@param	{int}	_x2		The right side of the rectangular area to update
///	@param	{int}	_y2		The bottom side of the rectangular area to update

/// @description	INTERNAL ONLY! DO NOT USE OR EDIT! This function is part of the destructible
///					terrain system and updates the polygons used to generate the terrain.
	
function terrain_update_triangles(_x1, _y1, _x2, _y2)
{
for(var i = _x1 ; i < _x2 ; ++i;)
	{
	for(var j = _y1; j < _y2; ++j;)
		{
		// Delete the old triangles
		terrain_tris -= terrain_polygons[i][j];
		terrain_polygons[i][j] = 0;
		// Make new ones
		var _p1 = terrain_density[i][j];
		var _p2 = terrain_density[i + 1][j];
		var _p3 = terrain_density[i][j + 1];
		var _p4 = terrain_density[i + 1][j + 1];
		terrain_create_triangles(_p1, _p2, _p3, _p4, i, j, terrain_scale);
		}
	}
}


/// @function				terrain_create_triangles(_p1, _p2, _p3 ,_p4, i, j, _scale);
/// @param	{real}	_p1		Left side
/// @param	{real}	_p1		Top side
/// @param	{real}	_p1		Right side
/// @param	{real}	_p1		Bottom side
/// @param	{ínt}	i		Terrain array first dimension
/// @param	{ínt}	j		Terrain array second dimension
/// @param	{ínt}	_scale	Terrain scale

/// @description	INTERNAL ONLY! DO NOY USE OR EDIT! This function is a version of the "marching
///					squares" algorithm and makes polygons based on the corner density values.

function terrain_create_triangles(_p1, _p2, _p3 ,_p4, i, j, _scale)
{
var _x1, _x2, _y1, _y2;

if (!_p1 && !_p2 && !_p3 && !_p4)
	{
	exit;
	}
else if (!_p1 && !_p2 && _p3 && !_p4)
	{
	_x1 = terrain_interpolate(_p3, _p4);
	_x2 = terrain_interpolate(_p1, _p3);
	terrain_create_triangle(_x1, 1, 0, _x2, 0, 1, i, j, _scale);
	}
else if (!_p1 && !_p2 && !_p3 && _p4)
	{
	_y1 = terrain_interpolate(_p2, _p4);
	_x2 = terrain_interpolate(_p3, _p4);
	terrain_create_triangle(1, _y1, _x2, 1, 1, 1, i, j, _scale);
	}
else if (!_p1 && !_p2 && _p3 && _p4)
	{
	_y1 = terrain_interpolate(_p2, _p4);
	_y2 = terrain_interpolate(_p1, _p3);
	terrain_create_triangle(1,_y1, 0, _y2, 1, 1, i, j, _scale);
	terrain_create_triangle(0,_y2, 0, 1, 1, 1, i, j, _scale);
	}
else if (!_p1 && _p2 && !_p3 && !_p4)
	{
	_x1 = terrain_interpolate(_p1, _p2);
	_y2 = terrain_interpolate(_p2, _p4);
	terrain_create_triangle(_x1, 0, 1, _y2, 1, 0, i, j, _scale);
	}
else if (!_p1 && _p2 && _p3 && !_p4)
	{
	_x1 = terrain_interpolate(_p1, _p2);
	_x2 = terrain_interpolate(_p3, _p4);
	_y1 = terrain_interpolate(_p1, _p3);
	_y2 = terrain_interpolate(_p2, _p4);
	terrain_create_triangle(_x1, 0, 1,_y2, 1, 0, i, j, _scale);
	terrain_create_triangle(_x2, 1, 0,_y1, 0, 1, i, j, _scale);
	}
else if (!_p1 && _p2 && !_p3 && _p4)
	{
	_x1 = terrain_interpolate(_p1, _p2);
	_x2 = terrain_interpolate(_p3, _p4);
	terrain_create_triangle(_x1, 0, _x2, 1, 1, 1, i, j, _scale);
	terrain_create_triangle(1, 1, 1, 0, _x1, 0, i, j, _scale);
	}
else if (!_p1 && _p2 && _p3 && _p4)
	{
	_x1 = terrain_interpolate(_p1, _p2);
	_y1 = terrain_interpolate(_p1, _p3);
	terrain_create_triangle(_x1, 0, 0, _y1, 1, 1, i, j, _scale);
	terrain_create_triangle(0, _y1, 0, 1, 1, 1, i, j, _scale);
	terrain_create_triangle(1, 0, _x1, 0, 1, 1, i, j, _scale);
	}
else if (_p1 && !_p2 && !_p3 && !_p4)
	{
	_x2 = terrain_interpolate(_p1, _p3);
	_y1 = terrain_interpolate(_p1, _p2);
	terrain_create_triangle(0, _x2, _y1, 0, 0, 0, i, j, _scale);
	}
else if (_p1 && !_p2 && _p3 && !_p4)
	{
	_x1 = terrain_interpolate(_p3, _p4);
	_x2 = terrain_interpolate(_p1, _p2);
	terrain_create_triangle(_x1, 1, _x2, 0, 0, 0, i, j, _scale);
	terrain_create_triangle(0, 0, 0, 1, _x1, 1, i, j, _scale);
	}
else if (_p1 && !_p2 && !_p3 && _p4)
	{
	_x1 = terrain_interpolate(_p1, _p3);
	_x2 = terrain_interpolate(_p2, _p4);
	_y1 = terrain_interpolate(_p1, _p2);
	_y2 = terrain_interpolate(_p3, _p4);
	terrain_create_triangle(0, _x1, _y1, 0, 0, 0, i, j, _scale);
	terrain_create_triangle(1, _x2, _y2, 1, 1, 1, i, j, _scale);
	}
else if (_p1 && !_p2 && _p3 && _p4)
	{
	_x1 = terrain_interpolate(_p1, _p2);
	_y1 = terrain_interpolate(_p2, _p4);
	terrain_create_triangle(1, _y1, _x1, 0, 0, 0, i, j, _scale);
	terrain_create_triangle(1, 1, 1,_y1, 0, 0, i, j, _scale);
	terrain_create_triangle(0, 0, 0, 1, 1, 1, i, j, _scale);
	}
else if (_p1 && _p2 && !_p3 && !_p4)
	{
	_y1 = terrain_interpolate(_p1, _p3);
	_y2 = terrain_interpolate(_p2, _p4);
	terrain_create_triangle(0, _y1, 1, _y2, 0, 0, i, j, _scale);
	terrain_create_triangle(0, 0, 1, _y2, 1, 0, i, j, _scale);
	}
else if (_p1 && _p2 && _p3 && !_p4)
	{
	_x1 = terrain_interpolate(_p3, _p4);
	_y1 = terrain_interpolate(_p2, _p4);
	terrain_create_triangle(_x1, 1, 1, _y1, 0, 0, i, j, _scale);
	terrain_create_triangle(1,_y1, 1, 0, 0, 0, i, j, _scale);
	terrain_create_triangle(0, 1, _x1, 1, 0, 0, i, j, _scale);
	}
else if (_p1 && _p2 && !_p3 && _p4)
	{
	_x1 = terrain_interpolate(_p3, _p4);
	_y1 = terrain_interpolate(_p1, _p3);
	terrain_create_triangle(0, _y1, _x1, 1, 0, 0, i, j, _scale);
	terrain_create_triangle(_x1, 1, 1, 1, 0, 0, i, j, _scale);
	terrain_create_triangle(0, 0, 1, 1, 1, 0, i, j, _scale);
	}
else if (_p1 && _p2 && _p3 && _p4)
	{
	exit;
	}
}


/// @function				create_triangle(_x1, _y1, _x2, _y2, _x3, _y3, i, j, _scale);
/// @param {real}	_x1		The X component of the first point in the polygon
/// @param {real}	_y1		The Y component of the first point in the polygon
/// @param {real}	_x2		The X component of the second point in the polygon
/// @param {real}	_y2		The Y component of the second point in the polygon
/// @param {real}	_x3		The X component of the third point in the polygon
/// @param {real}	_y3		The Y component of the third point in the polygon
/// @param {int}	i		The position in the terrain array first dimension
/// @param {int}	j		The position in the terrain array second dimension
/// @param {real}	_scale	The base scale of the destructible terrain

/// @description	INTERNAL ONLY! DO NOY USE OR EDIT! This function creates a polygon in the 
///					the given section of the terrain array
	
function terrain_create_triangle(_x1, _y1, _x2, _y2, _x3, _y3, i, j, _scale)
{
var _k = terrain_polygons[i][j];
terrain_px1[terrain_array[i][j]][_k] = (_x1 + i) * _scale;
terrain_py1[terrain_array[i][j]][_k] = (_y1 + j) * _scale;
terrain_px2[terrain_array[i][j]][_k] = (_x2 + i) * _scale;
terrain_py2[terrain_array[i][j]][_k] = (_y2 + j) * _scale;
terrain_px3[terrain_array[i][j]][_k] = (_x3 + i) * _scale;
terrain_py3[terrain_array[i][j]][_k] = (_y3 + j) * _scale;
terrain_polygons[i][j] += 1;
terrain_tris += 1;
}


/// @function				terrain_interpolate(p1, p2)
///	@param	{real}	p1		Point one in the interpolation
///	@param	{real}	p2		Point two in the interpolation

/// @description	INTERNAL ONLY! DO NOY USE OR EDIT! This function will return a value 
///					between 0 and 1 which corresponds to the value half way between point
///					one and point two.

function terrain_interpolate(p1, p2)
{
if p2 - p1 == 0
	{
	return 0.5;
	}
else
	{
	return (0.5 - p1) / (p2 - p1);
	}
}


///	@function				terrain_cleanup(flag);
/// @param	{bool}	flag	If this is set to true, then additional data will be cleaned up.

///	@description	DO NOT EDIT! INTERNAL ONLY! Clean up the different components of the 
///					destructible terrain system. The "flag" argument should always be true, 
///					except when called from the "terrain_load()" function. 

function terrain_cleanup(flag)
{
if flag == true
	{
	vertex_delete_buffer(terrain_tex_buff);
	vertex_format_delete(terrain_tex_format);
	ds_list_destroy(terrain_debug_list);
	}
terrain_density = -1;
terrain_polygons = -1;
terrain_tris = -1;
terrain_array = -1;
terrain_px1 = -1;
terrain_py1 = -1;
terrain_px2 = -1;
terrain_py2 = -1;
terrain_px3 = -1;
terrain_py3 = -1;
}
