/// @description 

draw_self();

if obj_Terrain_DEMO.mode == "play"
{
if keyboard_check(vk_space)
	{
	var _pc = (pwr / 10) * 100;
	draw_healthbar(x - 20, y - 50, x + 20, y - 45, _pc, c_black, c_yellow, c_red, 0, false, false);
	}
}

// Draw the terrain normal being used to orient the instance if debugging is enabled
if terrain_get_debug() >= t_debug_basic
{
var _n = terrain_normal(x, y + offset);
var _dx = x + lengthdir_x(offset, image_angle - 90);
var _dy = y + lengthdir_y(offset, image_angle - 90);
draw_sprite_ext(spr_Terrain_Pixel, 0, _dx, _dy, offset, 1, _n, c_white, 1);
}