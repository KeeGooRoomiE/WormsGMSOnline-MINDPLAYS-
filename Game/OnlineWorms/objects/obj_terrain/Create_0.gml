/// @description Insert description here
// You can write your code in this editor

back_terrain = instance_create_layer(x,y,"BKG",obj_back_terrain);
back_terrain.sprite_index=sprite_index;

w = sprite_get_width(sprite_index);
h = sprite_get_height(sprite_index);
xo = sprite_get_xoffset(sprite_index);
yo = sprite_get_yoffset(sprite_index);
sprite_index = sprite_duplicate(sprite_index);

terrain_surface = 0;
//alarm[0]=1;
terrain_surface = surface_create(w,h);
