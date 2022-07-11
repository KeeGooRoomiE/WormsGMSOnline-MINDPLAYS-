/// @description Draw Debug Info

if terrain_debug >= t_debug_basic
{
var _c = draw_get_color();
draw_set_color(c_yellow);
var _h = draw_get_halign();
draw_set_halign(fa_right);
var _fps = 0;
for (var i = 0; i < 10; ++i;)
	{
	_fps += terrain_debug_list[| i];
	}
draw_text(display_get_gui_width() - 8, 24, "fps: " + string(floor(_fps / 10)));
draw_text(display_get_gui_width() - 8, 54, "triangles: " + string(terrain_tris));
draw_set_color(_c)
draw_set_halign(_h);
}
    
