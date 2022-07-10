size=1+random(4)
direction=global.veter
alarm[0]=200
image_speed=0.2+random(0.4)

dddd=0;

if size >= 4
{
image_xscale=size/1.5
image_yscale=size/1.5
}
else
{
image_xscale=size/2
image_yscale=size/2
}

speed=size*2-2


if size >= 1 and size <= 2
depth=100
if size >= 2 and size <= 4
depth=98
if size >= 4 and size <= 5
depth=-3



