/// @description Create Destructible Terrain
show_debug_overlay(true);

// Create the destructible terrain controller
terrain_init(layer, 0, 0, room_width, room_height + 32, 32, spr_Terrain_DEMO_Block4, 0);

gpu_set_tex_filter(false);
display_reset(0, false);

// Control variables
brush = "rect";
t_size = terrain_get_scale();
rect_width = t_size * 3;
rect_height = t_size * 2;
circle_radius = t_size;
mode = "play";

// Control arrays for buttons
over[0] = false;
pressed[0] = false;
pressed[1] = false;
pressed[2] = false;
pressed[3] = false;
pressed[4] = false;
pressed[5] = false;
pressed[6] = false;
pressed[7] = false;
pressed[8] = false;
pressed[9] = false;
pressed[10] = false;




