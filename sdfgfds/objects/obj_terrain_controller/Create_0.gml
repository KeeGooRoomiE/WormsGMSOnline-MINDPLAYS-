/// @description Init Instance Vars

// This event simply initialises certain variables, but the bulk of the initialisation
// is done from the function "terrain_init()", which creates this object. You should
// NEVER create this object in any way other than calling that function, otherwise you 
// will get errors and the game will crash.

// Initialise controller instance vars
terrain_scale = 0;
terrain_x = 0;
terrain_y = 0;
terrain_width = 0;
terrain_height = 0;
terrain_tris = 0;
terrain_tex = 0;
terrain_tex_scale = 0;
terrain_tex_id = -1;
terrain_tex_w = 0;
terrain_tex_h = 0;
terrain_view = 0;
terrain_debug = t_debug_none;
terrain_debug_list = ds_list_create();
ds_list_add(terrain_debug_list, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

// Create the vertex format and vertex buffer
vertex_format_begin();
vertex_format_add_position();
vertex_format_add_colour();
vertex_format_add_texcoord();
terrain_tex_format = vertex_format_end();
terrain_tex_buff = vertex_create_buffer();
