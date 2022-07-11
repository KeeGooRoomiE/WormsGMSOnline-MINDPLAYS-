/// @description Draw Buttons

draw_set_font(fnt_Terrain_DEMO);
draw_set_colour(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
switch (mode)
{
case "edit":
	// Edit button
	draw_sprite(spr_Terrain_DEMO_UI_Button_1, pressed[0], 120, 50);
	draw_text(120, 50, "Play");
	// Enable / Disable view button
	draw_sprite(spr_Terrain_DEMO_UI_Button_1, pressed[1], 120, 100);
	if view_enabled
		{
		draw_text(120, 100, "View Enabled");
		}
	else draw_text(120, 100, "View Disabled");
	// Change texture button
	draw_sprite(spr_Terrain_DEMO_UI_Button_1, pressed[2], 120, 150);
	draw_text(100, 150, "Texture = ");
	draw_sprite_ext(terrain_get_texture(), 0, 160, 150 - 16, 0.5, 0.5, 0, c_white, 1);
	// Change Debug level button
	draw_sprite(spr_Terrain_DEMO_UI_Button_1, pressed[3], 120, 200);
	switch(terrain_get_debug())
		{
		case t_debug_none: draw_text(120, 200, "Debug Off"); break;
		case t_debug_basic: draw_text(120, 200, "Debug Basic"); break;
		case t_debug_medium: draw_text(120, 200, "Debug Med."); break;
		case t_debug_adv: draw_text(120, 200, "Debug Full"); break;
		}
	// Change brush button
	draw_sprite(spr_Terrain_DEMO_UI_Button_1, pressed[4], 120, 250);
	draw_text(120, 250, "Brush = " + brush);
	// Change brush size buttons
	if brush == "rect"
		{
		draw_sprite(spr_Terrain_DEMO_UI_Button_2, 6 + pressed[5], 120, 300);
		draw_text_transformed(120, 350, string(rect_width) + "/" + string(rect_height), 0.75, 0.75, 0);
		}
	else
		{
		draw_sprite_ext(spr_Terrain_DEMO_UI_Button_2, 6 + pressed[5], 120, 300, 1, 1, 0, c_gray, 0.75);
		draw_text_transformed(120, 350, string(circle_radius), 0.75, 0.75, 0);
		}
	draw_sprite(spr_Terrain_DEMO_UI_Button_2, 2 + pressed[6], 60, 350);
	draw_sprite(spr_Terrain_DEMO_UI_Button_2, 4 + pressed[7], 180, 350);
	if brush == "rect"
		{
		draw_sprite(spr_Terrain_DEMO_UI_Button_2, 0 + pressed[8], 120, 400);
		}
	else draw_sprite_ext(spr_Terrain_DEMO_UI_Button_2, 0 + pressed[8], 120, 400, 1, 1, 0, c_gray, 0.75);
	if os_browser == browser_not_a_browser
		{
		// Save Button
		draw_sprite(spr_Terrain_DEMO_UI_Button_1, pressed[9], 120, 450);
		draw_text(120, 450, "Save");
		// Load Button
		if file_exists("d_terrain.dat")
			{
			draw_sprite(spr_Terrain_DEMO_UI_Button_1, pressed[10], 120, 500);
			draw_text(120, 500, "Load");
			}
		else
			{
			draw_sprite_ext(spr_Terrain_DEMO_UI_Button_1, pressed[10], 120, 500, 1, 1, 0, c_gray, 0.75);
			draw_text_colour(120, 500, "Load", c_gray, c_gray, c_gray, c_gray, 1);
			}
		}
	draw_set_halign(fa_right);
	draw_text_colour(display_get_gui_width() - 8, display_get_gui_height() - 20, "Press ENTER to spawn tank at mouse cursor", c_black, c_black, c_black, c_black, 1);
	break;
case "play":
	draw_sprite(spr_Terrain_DEMO_UI_Button_1, pressed[0], 120, 50);
	draw_text(120, 50, "Edit");
	draw_set_halign(fa_right);
	draw_text_colour(display_get_gui_width() - 8, display_get_gui_height() - 20, "Left/Right/Up Arrows to move, SPACE to shoot", c_black, c_black, c_black, c_black, 1);
	break;
}

	draw_text_colour(display_get_gui_width() - 8, display_get_gui_height() - 60, "Press F5 To Change Room", c_black, c_black, c_black, c_black, 1);