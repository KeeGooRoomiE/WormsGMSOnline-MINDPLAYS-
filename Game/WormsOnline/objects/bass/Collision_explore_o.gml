var s;
s = surface_create(w,h);
if!(surface_exists(s)) exit;
surface_set_target(s);
draw_clear_alpha(c_black,1);

draw_sprite(sprite_index,image_index,xo,yo);
with(other)
{
draw_sprite_ext(spr_ww2,0,x-other.x+other.xo,y-other.y+other.yo,image_xscale/8,image_yscale/8,0,c_white,1);;
}
draw_point_color(0,h-1,c_black);
surface_reset_target();
sprite_delete(sprite_index);
sprite_index = sprite_create_from_surface(s,0,0,w,h,1,0,xo,yo);
surface_free(s);

