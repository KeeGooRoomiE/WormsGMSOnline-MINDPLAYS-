///	This script contains the different "Setter" functions that can
///	be used to set certain bits of data in the destructible
///	terrain engine.
///
/// The functions in this script are:
///
///		terrain_set_layer(layer_id)
///		terrain_set_texture(sprite)
///		terrain_set_view(view_num)
///		terrain_set_smooth(enable)
///		terrain_set_debug(lvl)
///		


/// @function						terrain_set_layer(layer_id);
///	@param	{int/str}	layer_id	The layer name or ID to set

///	@description		This function can be used to set a new layer for the destructible terrain 
///						controller instance. You can supply the layer name or the layer ID.
///						The function will return true if the layer was changed successfully or
///						false if there has been any error.

function terrain_set_layer(layer_id)
{
if is_string(layer_id)
	{
	layer_id = layer_get_id(layer_id);
	}

with (obj_Terrain_Controller)
	{
	if layer_exists(layer_id)
		{
		layer = layer_id;
		return true;
		}
	else
		{
		terrain_log("terrain_set_layer() - ERROR! Layer ID invalid, no changes have been made");
		return false;
		}
	}
terrain_log("terrain_set_layer() - ERROR! No terrain controller instance detected");
return false;
}


/// @function						terrain_set_texture(sprite)
///	@param	{index}		sprite		The new sprite to use as a texture

///	@description		This function can be used to change the texture used for the destuctible terrain.
///						You supply a sprite index and terrain will be textured using it. If there is an
///						an error the function will return false, otherwise it will return true.
///						IMPORTANT! The texture sprite MUST have "Seperate Texture Page" ticked in the 
///						sprite editor.

function terrain_set_texture(sprite)
{
with (obj_Terrain_Controller)
	{
	if sprite_exists(sprite)
		{
		terrain_tex = sprite;
		terrain_tex_scale = terrain_scale / sprite_get_width(terrain_tex);
		terrain_tex_id = sprite_get_texture(terrain_tex, 0);
		terrain_tex_w = 1 / terrain_scale;
		terrain_tex_h = 1 / terrain_scale;
		return true;
		}
	else
		{
		terrain_log("terrain_set_texture() - ERROR! Invalid sprite index given, cannot assign texture");
		}
	}
terrain_log("terrain_set_texture() - ERROR! No terrain controller instance detected");
return false;
}


/// @function						terrain_set_view(view_num)
///	@param	{int}		view_num	The viewport to use for the terrain to be culled to, use -1 for no view

///	@description		This function can be used to set the view port (and camera) that will be used 
///						for culling drawing of the destructible terrain. Anything outside of the camera 
///						view assigned to the given view port will be culled (ie: not drawn). Use a value
///						of -1 to disable this feature.

function terrain_set_view(view_num)
{
with (obj_Terrain_Controller)
	{
	if view_num >= -1 && view_num < 8
		{
		terrain_view = view_num;
		return true;
		}
	else
		{
		terrain_log("terrain_set_view() - ERROR! Invalid view index given, no change has been made");
		return false;
		}
	}
terrain_log("terrain_set_view() - ERROR! No terrain controller instance detected");
return false;
}


/// @function						terrain_set_smooth(enable)
///	@param	{bool}		enable		Enable or disable terrain smoothing.

///	@description		This function can be used to set the "smoothing" on the destructible
///						terrain. This is set to ON by default, but the asset will NOT change 
///						any graphics options unless this function is explicitly called. This is 
///						to prevent the asset over-riding exisiting game options and settings 
///						related to AA and vsync. When enabled, the asset will be best used with
///						high-res art, but if you are doing pixel art games and want crisp 
///						pixels, then disabling this will disable all smoothing and interpolation.
///						IMPORTANT! This will affect the visuals of the whole game, so you must 
///						EXPLICITLY call this function if you require it.

function terrain_set_smooth(enable)
{
with (obj_Terrain_Controller)
	{
	if enable == true
		{
		gpu_set_tex_filter(true);
		display_reset(display_aa, false);
		terrain_smooth = true;
		}
	else
		{
		gpu_set_tex_filter(false);
		display_reset(0, false);
		terrain_smooth = false;
		}
	return true;
	}
terrain_log("terrain_set_smooth() - ERROR! No terrain controller instance detected");
return false;
}


/// @function					terrain_set_debug(lvl);
///	@param	{const}		lvl		The debug level to use, one of the following constants:
///
///									t_debug_none	No debugging
///									t_debug_basic	Low level debugging - Shows FPS and terrain wireframe
///									t_debug_medium	Medium debugging - Same as above and also shows the density map
///									t_debug_adv		Advanced debugging - Same as above, but also shows collision normals for terrain

///	@description		This function can be used to set the debug level for the game, with each level 
///						displaying more information about the destructible terrain being created/destroyed
///						Note that each level adds to the complexity of the calculations being done and as
///						such will have a significant impact on performance. Also note that when debugging
///						is enabled, the wireframe terrain drawing may NOT reflect the actual terrain, and
///						may appear "glitched"... this is normal, and if you switch off debugging you can see
///						that the terrain is actually being drawn/created/destroyed correctly.

function terrain_set_debug(lvl)
{
with (obj_Terrain_Controller)
	{
	terrain_debug = lvl;
	if terrain_debug > t_debug_none
		{
		alarm[0] = room_speed / 2;
		}
	return true;
	}
terrain_log("terrain_set_debug() - ERROR! No terrain controller instance detected");
return false;
}
