/// @description Segmenting of sprite
// You can write your code in this editor



if (!surface_exists(terrain_surface)) 
{
	exit;
}

surface_set_target(terrain_surface);
draw_clear_alpha(c_black,1);
draw_sprite(sprite_index,image_index,xo,yo);

with(other)
{
	draw_sprite_ext(spr_mask_explosion,0,x-other.x+other.xo,y-other.y+other.yo,image_xscale/expl_scale,image_yscale/expl_scale,0,c_white,1);
}

draw_point_color(0,h-1,c_black);
surface_reset_target();

sprite_delete(sprite_index);
sprite_index = sprite_create_from_surface(terrain_surface,0,0,w,h,1,0,xo,yo);
surface_free(terrain_surface);
