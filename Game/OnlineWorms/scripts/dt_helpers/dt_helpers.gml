/// This script contains some "helper" functions for the desctructible
///	terrain engine. The functions included here are not essential to the
///	correct functioning of the engine itself, but are provided as 
///	convenience functions.
///
///	The functions in this script are:
///
///		terrain_log(value)
///		terrain_save([filename])
///		terrain_load([layer, filename]
///		





/// @function					terrain_log(value);
///	@param	{real/str}	value	The value to log (a real or a string)

/// @description		This is a wrapper functio for show_debug_message().
function terrain_log(value)
{
if !is_string(value)
	{
	value = string(value);
	}
show_debug_message("::::::::::: DT Log: " + value);
}


/// @function					terrain_save([filename]);
/// @param	{str}	filename	OPTIONAL! The name of the file to save (without the extension type)

/// @description	This function will save out the terrain data to a file.
///					The file will be called "d_terrain.dat" if no optional
///					filename argument is given. These .dat files can then 
///					be loaded again by calling the function "terrain_load()".
///					Note that if you give the optional filename, it should NOT
///					include the extension as the function will append ".dat"
///					automatically onto the give name. Also note that this function
///					ONLY saves terrain data, and nothing else, so if you want
///					to save player data, or any other game data, you will need
///					to edt/adapt this function, or use your own specifically for
///					things other than terrain. If you want to edit the function
///					to save additional data, simply append the data onto the
///					DS list that is being saved out, but don't forget to
///					also append the same items onto the load list function too,
///					and DO NOT edit or change the terrain list items that 
///					already exist, otherwise you could get errors.

function terrain_save()
{
terrain_log("terrain_save() - Saving terrain to file");

// Create a temp DS list. This will hold all the arrays and other variables for saving
var _list = ds_list_create();

// Check to see if controller exists
if instance_exists(obj_Terrain_Controller)
	{
	// Get terrain data into the temp DS list
	with (obj_Terrain_Controller)
		{
		// Arrays to save
		_list[| 0] = terrain_array;
		_list[| 1] = terrain_density;
		_list[| 2] = terrain_polygons;
		_list[| 3] = terrain_px1;
		_list[| 4] = terrain_py1;
		_list[| 5] = terrain_px2;
		_list[| 6] = terrain_py2;
		_list[| 7] = terrain_px3;
		_list[| 8] = terrain_py3;
		// Variables to save
		_list[| 9] = terrain_scale;
		_list[| 10] = terrain_x;
		_list[| 11] = terrain_y;
		_list[| 12] = terrain_width;
		_list[| 13] = terrain_height;
		_list[| 14] = terrain_tris;
		_list[| 15] = sprite_get_name(terrain_tex);
		_list[| 16] = terrain_view;
		_list[| 17] = terrain_smooth;
		_list[| 18] = terrain_debug;
		}
	// Check valid filename
	var _fname = "d_terrain";
	if argument_count > 0
		{
		if is_string(argument[0])
			{
			_fname = argument[0];
			}
		else terrain_log("terrain_save() - ERROR! Save filename must be a string. Default name will be used");
		}
	// Write data to file
	var _s = ds_list_write(_list);
	var _f = file_text_open_write(_fname + ".dat");
	file_text_write_string(_f, _s);
	file_text_close(_f);
	// Clean up
	ds_list_destroy(_list);
	return true;
	}

terrain_log("terrain_save() - ERROR! No terrain controller instance present in the room");
return false;
}


/// @function					terrain_load([layer, filename]);
/// @param	{int}	layer		OPTIONAL! Layer ID to create a new instance of the destructible terrain controller on
/// @param	{str}	filename	OPTIONAL! The name of the file to load (without the extension type)

/// @description	This function will load in the terrain data from a file.
///					If no destructible terrain controller object is present
///					in the room, then one will be created, and you can optionally
///					supply a layer ID onto which it will be created. If no layer ID
///					is supplied, then the controller will be placed on a layer with
///					depth 0. You can also supply an optional filename to load from, 
///					but if none is supplied then the default "d_terrain.dat" will
///					be used. If you want to supply a filename but NOT a alayer, then 
///					simply pass -1 as the layer ID.
///					Note that passing a layer ID when the terrain contoler instance 
///					already exists will have no effect on the destructible terrain
///					(to change the layer assigned simply use the "layer" variable on
///					the controller object).
///
///					IMPORTANT! Loaded terrain will store the "snmooth" terrain option
///					but not set any visual options related to it. This is to prevent 
///					the asset over-riding any game options that you have previsouly set.
///					if you wish this option to be respected on load, then after load you 
///					should do something like this:
///
///						terrain_set_smooth(terrain_get_smooth());
///
///					See the terrain_set_smooth() function for more details.

function terrain_load()
{
terrain_log("terrain_load() - Loading terrain from file");

// Create temp DS list for loading the data
var _list = ds_list_create();

// Check for a layer ID and a valid filename
var _fname = "d_terrain";
var _layer = -1;
if argument_count > 0
	{
	if is_string(argument[0])
		{
		_layer = layer_get_id(argument[0]);	
		}
	else _layer = argument[0];
	if !layer_exists(_layer)
		{
		terrain_log("terrain_load() - ERROR! Given layer ID does not exist. Using created layer depth 0.");
		_layer = layer_create(0, "Destructible_Terrain_Layer");
		}
	if argument_count > 1
		{
		if is_string(argument[1])
			{
			_fname = argument[1];
			}
		else terrain_log("terrain_load() - ERROR! Load filename must be a string. Default name will be used");
		}
	}

// Check file exists
if file_exists(_fname + ".dat")
	{
	// Read data from file into the DS list
	var _f = file_text_open_read(_fname + ".dat");
	var _s = file_text_read_string(_f);
	file_text_close(_f);
	ds_list_read(_list, _s);
	// Check to see if the controller exists
	if instance_exists(obj_Terrain_Controller)
		{
		// Controller exists so load the file values
		with (obj_Terrain_Controller)
			{
			terrain_cleanup(false);
			terrain_array	= _list[| 0];
			terrain_density	= _list[| 1];
			terrain_polygons= _list[| 2];
			terrain_px1		= _list[| 3];
			terrain_py1		= _list[| 4];
			terrain_px2		= _list[| 5];
			terrain_py2		= _list[| 6];
			terrain_px3		= _list[| 7];
			terrain_py3		= _list[| 8];
			terrain_scale	= _list[| 9];
			terrain_x		= _list[| 10];
			terrain_y		= _list[| 11];
			terrain_width	= _list[| 12];
			terrain_height	= _list[| 13];
			terrain_tris	= _list[| 14];
			terrain_tex		= asset_get_index(_list[| 15]);
			terrain_view	= _list[| 16];
			terrain_smooth	= _list[| 17];
			terrain_debug	= _list[| 18];
			terrain_tex_scale= terrain_scale / sprite_get_width(terrain_tex);
			terrain_tex_id	 = sprite_get_texture(terrain_tex, 0);
			terrain_tex_w	 = 1 / terrain_scale;
			terrain_tex_h	 = 1 / terrain_scale;
			}
		}
	else
		{
		// Controller doesn't exist, so create it and set the values to the loaded data
		terrain_init(_layer, 0, 0, room_width, room_height, 16, spr_Terrain_Pixel, -1, true);
		with (obj_Terrain_Controller)
			{
			terrain_cleanup(false);
			terrain_array	= _list[| 0];
			terrain_density	= _list[| 1];
			terrain_polygons= _list[| 2];
			terrain_px1		= _list[| 3];
			terrain_py1		= _list[| 4];
			terrain_px2		= _list[| 5];
			terrain_py2		= _list[| 6];
			terrain_px3		= _list[| 7];
			terrain_py3		= _list[| 8];
			terrain_scale	= _list[| 9];
			terrain_x		= _list[| 10];
			terrain_y		= _list[| 11];
			terrain_width	= _list[| 12];
			terrain_height	= _list[| 13];
			terrain_tris	= _list[| 14];
			terrain_tex		= asset_get_index(_list[| 15]);
			terrain_view	= _list[| 16];
			terrain_debug	= _list[| 17];
			terrain_tex_scale= terrain_scale / sprite_get_width(terrain_tex);
			terrain_tex_id	 = sprite_get_texture(terrain_tex, 0);
			terrain_tex_w	 = 1 / terrain_scale;
			terrain_tex_h	 = 1 / terrain_scale;
			}
		}
	ds_list_destroy(_list);
	return obj_Terrain_Controller.id;
	}
else
	{
	return noone;
	terrain_log("terrain_load() - ERROR! No file found to load");
	}
}

