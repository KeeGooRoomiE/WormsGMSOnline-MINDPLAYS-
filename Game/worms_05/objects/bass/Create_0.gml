cr=instance_create(x,y,obj_pm_terrain)
cr.sprite_index=sprite_index
w = sprite_get_width(sprite_index)
h = sprite_get_height(sprite_index)
xo = sprite_get_xoffset(sprite_index)
yo = sprite_get_yoffset(sprite_index)
sprite_index = sprite_duplicate(sprite_index)
alarm[0]=1

