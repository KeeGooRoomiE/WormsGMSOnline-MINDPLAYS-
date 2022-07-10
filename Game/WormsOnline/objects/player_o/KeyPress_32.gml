if sprite_index=s_worm
{


spa=1

if global.gun_select=1 
{if !instance_exists(hk_line)
{hk=instance_create(x,y,hk_line);hk.direction=angle;vspeed-=2}
if instance_exists(hk_line) and grapp = true 
{

global.hook_hit=0;grapp = 0;speed_e=spee_e;dir_e=di_e-180;
with (hk_line)
instance_destroy()
}
}

if global.gun_select=0 or global.gun_select=2 or global.gun_select=3 
sila=15
}

