/// @description Demo Controls

// Check for changing between editing and playing
var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);
if point_in_rectangle(_mx, _my, 150 - 95, 50 - 24, 150 + 95,  50 + 24)
{
over[0] = true;
if mouse_check_button_pressed(mb_left) && pressed[0] == false
	{
	alarm[0] = room_speed / 3;
	audio_play_sound(snd_Terrain_DEMO_Switch, 0, false);
	if mode == "play"
		{
		mode = "edit";
		audio_stop_sound(snd_Terrain_DEMO_Move);
		audio_stop_sound(snd_Terrain_DEMO_Power);
		}
	else mode = "play";
	pressed[0] = true;
	}
}
else over[0] = false;

// PLAY Mode
if mode == "play"
{
// Set view to player object
if view_enabled
	{
	if instance_exists(obj_Terrain_DEMO_Player)
		{
		var _mx = obj_Terrain_DEMO_Player.x;
		var _my = obj_Terrain_DEMO_Player.y;
		var _vw = camera_get_view_width(view_camera[0]);
		var _vh = camera_get_view_height(view_camera[0]);
		var _vx = _mx - (_vw / 2);
		var _vy = _my - (_vh / 2);
		camera_set_view_pos(view_camera[0], clamp(_vx, 0, room_width - _vw), clamp(_vy, 0, room_height - _vh));
		}
	}
}
// EDIT Mode
else if mode == "edit" && alarm[0] < 0
{
// Check View Button
if point_in_rectangle(_mx, _my, 150 - 95, 100 - 24, 150 + 95,  100 + 24)
	{
	if mouse_check_button_pressed(mb_left) && pressed[1] == false
		{
		alarm[0] = room_speed / 3;
		audio_play_sound(snd_Terrain_DEMO_Switch, 0, false);
		if view_enabled
			{
			view_enabled = false;
			terrain_set_view(-1);
			}
		else
			{
			view_enabled = true;
			terrain_set_view(0);
			}
		pressed[1] = true;
		}
	}
// Check Terrain Texture Button
if point_in_rectangle(_mx, _my, 150 - 95, 150 - 24, 150 + 95,  150 + 24)
	{
	if mouse_check_button_pressed(mb_left) && pressed[2] == false
		{
		alarm[0] = room_speed / 3;
		audio_play_sound(snd_Terrain_DEMO_Switch, 0, false);
		switch (terrain_get_texture())
			{
			case spr_Terrain_DEMO_Block1:
				terrain_set_texture(spr_Terrain_DEMO_Block2);
				break;
			case spr_Terrain_DEMO_Block2:
				terrain_set_texture(spr_Terrain_DEMO_Block3);
				break;
			case spr_Terrain_DEMO_Block3:
				terrain_set_texture(spr_Terrain_DEMO_Block4);
				break;
			case spr_Terrain_DEMO_Block4:
				terrain_set_texture(spr_Terrain_DEMO_Block1);
				break;
			}
		pressed[2] = true;
		}
	}
// Check Debug Level
if point_in_rectangle(_mx, _my, 150 - 95, 200 - 24, 150 + 95,  200 + 24)
	{
	if mouse_check_button_pressed(mb_left) && pressed[3] == false
		{
		alarm[0] = room_speed / 3;
		audio_play_sound(snd_Terrain_DEMO_Switch, 0, false);
		switch(terrain_get_debug())
			{
			case t_debug_adv: terrain_set_debug(t_debug_none); break;
			case t_debug_none: terrain_set_debug(t_debug_basic); break;
			case t_debug_basic: terrain_set_debug(t_debug_medium); break;
			case t_debug_medium: terrain_set_debug(t_debug_adv); break;
			}
		pressed[3] = true;
		}
	}
// Check Brush Change Button
if point_in_rectangle(_mx, _my, 150 - 95, 250 - 24, 150 + 95,  250 + 24)
	{
	if mouse_check_button_pressed(mb_left) && pressed[3] == false
		{
		alarm[0] = room_speed / 3;
		audio_play_sound(snd_Terrain_DEMO_Switch, 0, false);
		if brush == "rect"
			{
			brush = "circle";
			}
		else brush = "rect";
		pressed[4] = true;
		}
	}
// Change brush height
if point_in_circle(_mx, _my, 120, 300, 24)
	{
	if mouse_check_button(mb_left) && pressed[5] == false && brush == "rect"
		{
		if rect_height > t_size
			{
			alarm[0] = room_speed / 5;
			audio_play_sound(snd_Terrain_DEMO_Switch, 0, false);
			rect_height -= 8;
			pressed[5] = true;
			}
		else alarm[0] = 1;
		}
	}
if point_in_circle(_mx, _my, 120, 400, 24)
	{
	if mouse_check_button(mb_left) && pressed[8] == false && brush == "rect"
		{
		if rect_height < t_size * 5
			{
			alarm[0] = room_speed / 5;
			audio_play_sound(snd_Terrain_DEMO_Switch, 0, false);
			rect_height += 8;
			pressed[8] = true;
			}
		else alarm[0] = 1;
		}
	}
// Change brush width
if point_in_circle(_mx, _my, 60, 350, 24)
	{
	if mouse_check_button(mb_left) && pressed[6] == false
		{
		if brush == "rect"
			{
			if rect_width > t_size
				{
				rect_width -= 8;
				pressed[6] = true;
				alarm[0] = room_speed / 5;
				audio_play_sound(snd_Terrain_DEMO_Switch, 0, false);
				}
			else alarm[0] = 1;
			}
		else
			{
			if circle_radius > t_size
				{
				circle_radius -= 2;
				pressed[6] = true;
				alarm[0] = room_speed / 5;
				audio_play_sound(snd_Terrain_DEMO_Switch, 0, false);
				}
			else alarm[0] = 1;
			}
		}
	}
if point_in_circle(_mx, _my, 180, 350, 24)
	{
	if mouse_check_button(mb_left) && pressed[7] == false
		{
		if brush == "rect"
			{
			if rect_width < t_size * 5
				{
				rect_width += 8;
				pressed[7] = true;
				alarm[0] = room_speed / 5;
				audio_play_sound(snd_Terrain_DEMO_Switch, 0, false);
				}
			else alarm[0] = 1;
			}
		else
			{
			if circle_radius < t_size * 5
				{
				circle_radius += 2;
				pressed[7] = true;
				alarm[0] = room_speed / 5;
				audio_play_sound(snd_Terrain_DEMO_Switch, 0, false);
				}
			else alarm[0] = 1;
			}
		}
	}
if os_browser == browser_not_a_browser
	{
	// Check Save Button
	if point_in_rectangle(_mx, _my, 150 - 95, 450 - 24, 150 + 95,  450 + 24)
		{
		if mouse_check_button_pressed(mb_left) && pressed[9] == false
			{
			alarm[0] = room_speed / 3;
			audio_play_sound(snd_Terrain_DEMO_Switch, 0, false);
			terrain_save();
			pressed[9] = true;
			}
		}
	// Check Load Button
	if point_in_rectangle(_mx, _my, 150 - 95, 500 - 24, 150 + 95,  500 + 24)
		{
		if mouse_check_button_pressed(mb_left) && pressed[9] == false
			{
			alarm[0] =1;
			if file_exists("d_terrain.dat")
				{
				alarm[0] = room_speed / 3;
				audio_play_sound(snd_Terrain_DEMO_Switch, 0, false);
				terrain_load(layer_get_id(layer));
				t_size = terrain_get_scale();
				rect_width = t_size * 3;
				rect_height = t_size * 2;
				circle_radius = t_size;
				pressed[9] = true;
				}
			}
		}
	}
// KEYBOARD / MOUSE SHORTCUTS WHEN EDITING
// Cheange brush type
if mouse_check_button_pressed(mb_middle)
	{
	if brush == "rect"
		{
		brush = "circle";
		}
	else brush = "rect";
	}
// Paint terrain with brush LMB
if mouse_check_button(mb_left) && alarm[0] < 0
	{
	switch(brush)
		{
		case "rect":
			terrain_create_rectangle(mouse_x, mouse_y, rect_width / 2, rect_height / 2);
			break;
		case "circle":
			terrain_create_circle(mouse_x, mouse_y, circle_radius);
			break;
		}
	}
// Delete terrain with brush RMB
if mouse_check_button(mb_right)
	{
	switch(brush)
		{
		case "rect":
			terrain_remove_rectangle(mouse_x, mouse_y, rect_width / 2, rect_height / 2);
			break;
		case "circle":
			terrain_remove_circle(mouse_x, mouse_y, circle_radius);
			break;
		}
	}
// Reset Player Position
if keyboard_check_pressed(vk_enter)
	{
	with(obj_Terrain_DEMO_Player) 
		{
		instance_destroy();
		instance_create_layer(mouse_x, mouse_y, layer, obj_Terrain_DEMO_Player);
		}
	}
// Move view
if view_enabled
	{
	var _mx = mouse_x;
	var _my = mouse_y;
	var _vx = camera_get_view_x(view_camera[0]);
	var _vy = camera_get_view_y(view_camera[0]);
	var _vw = camera_get_view_width(view_camera[0]);
	var _vh = camera_get_view_height(view_camera[0]);
	if (_mx < _vx + 64 || keyboard_check(vk_left))
		{
		_vx -= 10;
		}
	if (_mx > (_vx + _vw - 64) || keyboard_check(vk_right))
		{
		_vx += 10;
		}
	if (_my < _vy + 64 || keyboard_check(vk_up))
		{
		_vy -= 10;
		}
	if (_my > (_vy + _vh - 64) || keyboard_check(vk_down))
		{
		_vy += 10;
		}
	camera_set_view_pos(view_camera[0], clamp(_vx, 0, room_width - _vw), clamp(_vy, 0, room_height - _vh));
	}
// Set debug mode
if keyboard_check_pressed(ord("1")) terrain_set_debug(t_debug_none);
if keyboard_check_pressed(ord("2")) terrain_set_debug(t_debug_basic);
if keyboard_check_pressed(ord("3")) terrain_set_debug(t_debug_medium);
if keyboard_check_pressed(ord("4")) terrain_set_debug(t_debug_adv);
// Change brush size
if keyboard_check(ord("Q")) 
	{
	if brush == "rect"
		{
		if rect_width > t_size
			{
			rect_width -= 8;
			}
		}
	else
		{
		if circle_radius < t_size * 5
			{
			circle_radius += 2;
			}
		}
	}
if keyboard_check(ord("W")) 
	{
	if brush == "rect"
		{
		if rect_width < t_size * 5
			{
			rect_width += 8;
			}
		}
	else
		{
		if circle_radius > t_size
			{
			circle_radius -= 2;
			}
		}
	}
if keyboard_check(ord("A")) 
	{
	if rect_height > t_size
		{
		rect_height -= 1;
		}
	}
if keyboard_check(ord("S")) 
	{
	if rect_height < t_size * 5
		{
		rect_height += 1;
		}
	}
// Save terrain
if os_browser == browser_not_a_browser
	{
	if keyboard_check_pressed(vk_f5)
		{
		terrain_save();
		}
	// Load Terrain
	if keyboard_check_pressed(vk_f9)
		{
		terrain_load(layer_get_id(layer));
		t_size = terrain_get_scale();
		rect_width = t_size * 3;
		rect_height = t_size * 2;
		circle_radius = t_size;
		}
	}
// Change terrain texture
if keyboard_check_pressed(vk_f1)
	{
	switch (terrain_get_texture())
		{
		case spr_Terrain_DEMO_Block1:
			terrain_set_texture(spr_Terrain_DEMO_Block2);
			break;
		case spr_Terrain_DEMO_Block2:
			terrain_set_texture(spr_Terrain_DEMO_Block3);
			break;
		case spr_Terrain_DEMO_Block3:
			terrain_set_texture(spr_Terrain_DEMO_Block4);
			break;
		case spr_Terrain_DEMO_Block4:
			terrain_set_texture(spr_Terrain_DEMO_Block1);
			break;
		}
	}
// Enable / Disable the view culling
if keyboard_check_pressed(vk_f2)
	{
	if terrain_get_view() == -1
		{
		view_enabled = true;
		terrain_set_view(0);
		}
	else
		{
		view_enabled = false;
		terrain_set_view(-1);
		}
	}
}

if keyboard_check_pressed(vk_f5)
{
switch(room)
	{
	case rm_Terrain_DEMO:
	case rm_Terrain_Procedural_H:
		room_goto_next();
		break;
	case rm_Terrain_Procedural_V:
		room_goto(rm_Terrain_DEMO);
		break;
	}
}