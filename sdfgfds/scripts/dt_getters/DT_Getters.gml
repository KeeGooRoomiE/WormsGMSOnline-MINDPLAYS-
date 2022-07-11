///	This script contains the different "Getter" functions that can
///	be used to get different bits of information about the destructible
///	terrain engine.
///
/// The functions in this script are:
///
///		terrain_get_layer();
///		terrain_get_texture();
///		terrain_get_view();
///		terrain_get_smooth();
///		terrain_get_debug();
///		terrain_get_scale();
///		terrain_get_x();
///		terrain_get_y();
///		terrain_get_width();
///		terrain_get_height();
///		


/// @function			terrain_get_layer();

///	@description		This function can be used to get the layer ID of the layer that the 
///						destructible terrain instance is on.
///						Will return "undefined" if there is an error.

function terrain_get_layer()
{
with (obj_Terrain_Controller)
	{
	return layer_get_id(layer);
	}
terrain_log("terrain_get_layer() - ERROR! No terrain controller instance detected, returning undefined");
return undefined;
}


/// @function			terrain_get_texture();

///	@description		This function will return the index of the sprite currently being used
///						as the texture for the destructible terrain. If there is an error, then 
///						-1 will be returned.

function terrain_get_texture()
{
with (obj_Terrain_Controller)
	{
	return terrain_tex;
	}
terrain_log("terrain_get_texture() - ERROR! No terrain controller instance detected, returning -1");
return -1;
}


/// @function			terrain_get_view();

///	@description		This function will return the index of the view being used to cull the drawing of
///						the destructible terrain, or -1 if no view is assigned. If there is an error 
///						then the function will return "undefined".
function terrain_get_view()
{
with (obj_Terrain_Controller)
	{
	return terrain_view;
	}
terrain_log("terrain_get_view() - ERROR! No terrain controller instance detected, returning undefined");
return undefined;
}


/// @function			terrain_get_smooth();

///	@description		This function will return whether terrain smoothing is enabled or disabled.
///						If it returns true, then linear interpolation and GPU filtering are 
///						enabled and if it is set to false then they are disabled.

function terrain_get_smooth()
{
with (obj_Terrain_Controller)
	{
	return terrain_smooth;
	}
terrain_log("terrain_get_smooth() - ERROR! No terrain controller instance detected, returning undefined");
return false;
}


/// @function			terrain_get_debug();

///	@description		This function can be used to get the current debug level for the terrain
///						generator object. The rturn value will be one of the following constants:
///
///							t_debug_none	No debugging
///							t_debug_basic	Low level debugging - Shows FPS and terrain wireframe
///							t_debug_medium	Medium debugging - Same as above and also shows the density map
///							t_debug_adv		Advanced debugging - Same as above, but also shows collision normals for terrain
///
///						The function will return -1 if there is an error.

function terrain_get_debug()
{
with (obj_Terrain_Controller)
	{
	return terrain_debug;
	}
terrain_log("terrain_get_debug() - ERROR! No terrain controller instance detected, returning -1");
return -1;
}


/// @function			terrain_get_scale();

///	@description		This function can be used to get the block scale value for the terrain generator.
///						Note that this value CANNOT be set after the destructible terrain has been 
///						initialised, which is why there is no equivalent "set" function.
///						Will return "undefined" if there is an error.

function terrain_get_scale()
{
with (obj_Terrain_Controller)
	{
	return terrain_scale;
	}
terrain_log("terrain_get_scale() - ERROR! No terrain controller instance detected, returning undefined");
return undefined;
}


/// @function			terrain_get_x();

///	@description		This function can be used to get the X position for the start of the terrain
///						generator IN CELLS (this is the position from which destructible terrain
///						will be enabled - to get the actual room position multiply by the "scale" value
///						which you can get using the "terrain_get_scale()" function). Note that this value 
///						CANNOT be set after the destructible terrain has been initialised, which is why 
///						there is no equivalent "set" function.
///						Will return "undefined" if there is an error.

function terrain_get_x()
{
with (obj_Terrain_Controller)
	{
	return terrain_x;
	}
terrain_log("terrain_get_x() - ERROR! No terrain controller instance detected, returning undefined");
return undefined;
}


/// @function			terrain_get_y();

///	@description		This function can be used to get the Y position for the start of the terrain
///						generator IN CELLS (this is the position from which destructible terrain
///						will be enabled - to get the actual room position multiply by the "scale" value
///						which you can get using the "terrain_get_scale()" function). Note that this value 
///						CANNOT be set after the destructible terrain has been initialised, which is why 
///						there is no equivalent "set" function.
///						Will return "undefined" if there is an error.

function terrain_get_y()
{
with (obj_Terrain_Controller)
	{
	return terrain_y;
	}
terrain_log("terrain_get_y() - ERROR! No terrain controller instance detected, returning undefined");
return undefined;
}


/// @function			terrain_get_width();

///	@description		This function can be used to get the width of the area used by the terrain
///						generator IN CELLS (to get the actual width in pixels multiply by the "scale" value
///						which you can get using the "terrain_get_scale()" function). Note that this value 
///						CANNOT be set after the destructible terrain has been initialised, which is why 
///						there is no equivalent "set" function.
///						Will return "undefined" if there is an error.

function terrain_get_width()
{
with (obj_Terrain_Controller)
	{
	return terrain_width;
	}
terrain_log("terrain_get_width() - ERROR! No terrain controller instance detected, returning undefined");
return undefined;
}


/// @function			terrain_get_height();

///	@description		This function can be used to get the height of the area used by the terrain
///						generator IN CELLS (to get the actual height in pixels multiply by the "scale" value
///						which you can get using the "terrain_get_scale()" function). Note that this value 
///						CANNOT be set after the destructible terrain has been initialised, which is why 
///						there is no equivalent "set" function.
///						Will return "undefined" if there is an error.

function terrain_get_height()
{
with (obj_Terrain_Controller)
	{
	return terrain_height;
	}
terrain_log("terrain_get_height() - ERROR! No terrain controller instance detected, returning undefined");
return undefined;
}
