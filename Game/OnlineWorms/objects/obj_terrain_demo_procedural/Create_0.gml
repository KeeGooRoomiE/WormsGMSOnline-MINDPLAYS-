/// @description Create Destructible Terrain
show_debug_overlay(true);
randomise();

// CREATE PROCEDURAL TERRAIN
if room == rm_Terrain_Procedural_H // HORIZONTAL TERRAIN - for games like worms
{
// First create the terrain brushes that will generate the procedural terrain
// ALl we are doing is creating the terrain brushes at random Y positions
// along the X axis of the room. This will mean that there are some spaces
// and an irregular surface
for (var i = 0; i <= room_width; i += 32;)
	{
	repeat(irandom(3))
		{
		with (instance_create_layer(i - 16 + random(32), 270 + random(270), "Instances", obj_Terrain_Brush_Circle))
			{
			image_xscale = 1 + random(1);
			image_yscale = image_xscale;
			}
		}
	}
}
else if room == rm_Terrain_Procedural_V // VERTICAL TERRAIN - for games like terraria
{
// First we use the terrain brushes to create a horizontal "top" level
// This is just a single line of terrain that follows the "base" level
var _base_y = 270;
for (var i = 0; i <= room_width; i += 128;)
	{
	with (instance_create_layer(i - 16 + random(32), _base_y + choose(-32, 0, 32), "Instances", obj_Terrain_Brush_Rect))
		{
		image_xscale = 1 + random(2);
		image_yscale = 1;
		}
	}
// Now we fill in the rest of the terrain so it's a solid block from the 
// base level to the bottom of the room
with (instance_create_layer((room_width / 2), _base_y + ((room_height - _base_y) / 2), "Instances", obj_Terrain_Brush_Rect))
	{
	image_xscale = (room_width / sprite_get_width(sprite_index));
	image_yscale = ((room_height - _base_y) / sprite_get_height(sprite_index));
	}
// Finally, we need to punch some holes in the terrain to make caves.
// However we need to do this AFTER we have generated the terrain, so
// See further down in the code of this event for an example...
}

var _yy = 270;
while (instance_position(64, _yy, obj_Terrain_Creator))
{
_yy -= 16;
}

instance_create_layer(64, _yy - 32, "Instances", obj_Terrain_DEMO_Player);

// Create the destructible terrain controller
terrain_init(layer, 0, 0, room_width, room_height + 32, 32, spr_Terrain_DEMO_Block4, 0);

if room == rm_Terrain_Procedural_V // VERTICAL TERRAIN - Here we punch holes in the terrain
{
var _base_y = 270;
var _base_y_add = (room_height - _base_y) / 7
repeat(5)
	{
	var _xx = 128 + random(room_width - 256);
	var _yy = _base_y + 128 + (random((room_height - _base_y) - 256));
	_base_y += _base_y_add;
	var _yy = _base_y;
	repeat(5)
		{
		var _xadd = choose(-64, -32, 32, 64);
		var _yadd = choose(-64, -32, 32, 64);
		_xx += _xadd;
		_yy += _yadd;
		terrain_remove_circle(_xx, _yy, 64 + choose(0, 32, 48, 64));
		}
	}
}

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




