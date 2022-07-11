/// @description

vspeed += 0.1;

if terrain_collision(x, y)
	{
	var holesize = terrain_get_scale() * 1.5;
	terrain_remove_circle(x, y, holesize);
	var _o = instance_create_layer(x, y, "Instances_Effects", obj_Terrain_DEMO_Explosion);
	_o.image_xscale = holesize * 3 / sprite_get_width(_o.sprite_index);
	_o.image_yscale = holesize * 3 / sprite_get_height(_o.sprite_index);
	_o.image_angle = random(360);
	var _s = audio_play_sound(snd_Terrain_DEMO_Explode, 0, false);
	audio_sound_pitch(_s, 0.8 + random(0.4));
	
	for (var a = 0; a < 12; ++a;)
		{
		with (instance_create_layer(x, y, "Instances_Effects", obj_Terrain_DEMO_Pieces))
			{
			image_index = a;
			tile_sprite = terrain_get_texture();
			tile_index = 0;
			}
		}
	
	
	instance_destroy();
	}

image_angle = point_direction(xprev, yprev, x, y);

xprev = x;
yprev = y;

if x < 0 || x > room_width || y > room_height
{
instance_destroy();
}
