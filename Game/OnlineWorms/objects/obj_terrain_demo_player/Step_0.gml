/// @description

if obj_Terrain_DEMO.mode == "play"
{
// Check if player is outside the bottom room bounds
if y < room_height vspeed += 0.25;
if y > room_height - sprite_yoffset
	{
	y = room_height - sprite_yoffset;
	vspeed = 0;
	}
// Check for collision with the terrain
var _my = terrain_collision(x , y - offset);
var _ma = terrain_collision(x , y + offset);
var _mv = terrain_collision(x - offset, y);
var _mo = terrain_collision(x + offset, y);
// Check collisons above and below
if _my
	{
	if vspeed < 0
		{
		vspeed = 0;
		}
	for(var i = 0; i < offset; ++i)
	    {
		if terrain_collision(x, y - offset)
			{
			++y;
			}
		else 
			{
			break;
			}
		}
	}
if(_ma)
	{
	vspeed = 0;
	for(var i = 0; i < offset; ++i;)
		{
		if terrain_collision(x, y + offset - 1)
			{
			--y;
			}
		else 
			{
			break;
			}
		}
	}
// Check for moving left or right
if (keyboard_check(vk_left) && !_mv && bbox_left > 0)
	{
	x -= 2;
	image_speed = 1;
	image_xscale = -1;
	if !snd_move
		{
		//audio_play_sound(snd_Terrain_DEMO_Move, 0, true);
		snd_move = true;
		}
	}
if (keyboard_check(vk_right) && !_mo && bbox_right < room_width)
	{
	x += 2;
	image_speed = 1;
	image_xscale = 1;
	if !snd_move
		{
		//audio_play_sound(snd_Terrain_DEMO_Move, 0, true);
		snd_move = true;
		}
	}
// Stop animation if no movement
if (!keyboard_check(vk_left) && !keyboard_check(vk_right))
	{
	image_speed = 0
	//audio_stop_sound(snd_Terrain_DEMO_Move);
	snd_move = false;
	}
// Check for jumping
if (keyboard_check(vk_up) && (_ma || y = room_height - sprite_yoffset))
	{
	vspeed = -8;
	//audio_play_sound(snd_Terrain_DEMO_Jump, 0, false);
	}
// Check for throwing bomb
if obj_Terrain_DEMO.over[0] == false
	{
	if keyboard_check(vk_space)
		{
		pwr = clamp(pwr + 0.1, 2, 10);
		/*if !snd_play
			{
			snd_play = true;
			snd = //audio_play_sound(snd_Terrain_DEMO_Power, 0, true);
			}
		else
			{
			audio_sound_pitch(snd, 0.75 + (pwr / 10));
			}*/
		}
	if keyboard_check_released(vk_space)
		{
		if image_xscale == 1
			{
			var _x = x + lengthdir_x(offset + 18, image_angle + 40);
			var _y = y + lengthdir_y(offset + 18, image_angle + 40);
			var _dir = image_angle + 25;
			}
		else
			{
			var _x = x - lengthdir_x(offset + 18, image_angle - 40);
			var _y = y - lengthdir_y(offset + 18, image_angle - 40);
			_dir = image_angle + 180 - 25;
			}
		instance_create_layer(_x, _y, layer, obj_Terrain_DEMO_ShootEffect);
		var _o = instance_create_layer(_x, _y, layer, obj_Terrain_DEMO_Bomb);
		_o.direction = _dir;
		_o.speed = pwr;
		pwr = 2;
		//audio_stop_sound(snd_Terrain_DEMO_Power);
		//snd = //audio_play_sound(snd_Terrain_DEMO_Shoot, 0, false);
		//audio_sound_pitch(snd, 0.9 + random(0.2));
		snd_play = false;
		}
	}
else
	{
	//audio_stop_sound(snd_Terrain_DEMO_Power);
	pwr = 2;
	}
// Get the terrain normal and adjust player angle as required
var _n = terrain_normal(x, y + offset);
if _n == -1
	{
	var _dif = angle_difference(0, image_angle);
	}
else
	{
	var _dif = angle_difference(_n - 90, image_angle);
	}
image_angle += median(-2.5, _dif, 2.5);
}
