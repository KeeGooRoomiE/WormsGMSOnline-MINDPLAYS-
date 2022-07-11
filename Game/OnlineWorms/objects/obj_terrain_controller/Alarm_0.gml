/// @description Debug FPS Average

if terrain_debug >= t_debug_basic
{
alarm[0] = room_speed / 2;
ds_list_delete(terrain_debug_list, 0);
ds_list_insert(terrain_debug_list, 9, fps_real);
}
