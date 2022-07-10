if sprite_index=s_worm
{


if global.gun_select=0 
{
b=instance_create(x+lengthdir_x(20,angle),y+lengthdir_y(20,angle),bomba_1_o)
b.speed=sila/7
b.direction=angle
sila=0
}


if global.gun_select=2 
{
b=instance_create(x,y-2,greenade_o)
b.speed=sila/7
b.direction=angle
sila=0
}

if global.gun_select=3 
{
b=instance_create(x,y-2,petrol_o)
b.speed=sila/7
b.direction=angle
sila=0
}


global.veter=270+40-random(80)
}

