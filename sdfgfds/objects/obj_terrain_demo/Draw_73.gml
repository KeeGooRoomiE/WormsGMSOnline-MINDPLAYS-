/// @description Draw Cursor Tool

if mode == "edit"
{
switch (brush)
	{
	case "rect":
		var _mx1 = mouse_x - (rect_width / 2);
		var _my1 = mouse_y - (rect_height / 2);
		var _mx2 = mouse_x + (rect_width / 2);
		var _my2 = mouse_y + (rect_height / 2);
		draw_rectangle(_mx1, _my1, _mx2, _my2, true);
		break;
	case "circle":
		draw_circle(mouse_x, mouse_y, circle_radius, true);
		break;
	}
}

if instance_exists(obj_Terrain_DEMO_Pieces)
	{
	gpu_set_blendenable(false)
	gpu_set_colorwriteenable(false,false,false,true);
	draw_set_alpha(0);
	draw_rectangle(0, 0, room_width, room_height, false);
	draw_set_alpha(1);
	with (obj_Terrain_DEMO_Pieces)
		{
		draw_sprite(sprite_index, image_index, x, y);
		}
	gpu_set_blendenable(true);
	gpu_set_colorwriteenable(true,true,true,true);
	gpu_set_blendmode_ext(bm_dest_alpha,bm_inv_dest_alpha);
	gpu_set_alphatestenable(true);
	with (obj_Terrain_DEMO_Pieces)
		{
		draw_sprite_tiled(tile_sprite, 0, x, y);
		}
	gpu_set_alphatestenable(false);
	gpu_set_blendmode(bm_normal);
	}

