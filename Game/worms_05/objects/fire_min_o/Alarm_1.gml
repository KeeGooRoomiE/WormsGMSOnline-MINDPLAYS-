if mode=0
{
alarm[1]=15+random(20)
sprite_index=fire_min_s2
mode=1
exit
}

if mode=1
{
alarm[1]=10+random(40)
sprite_index=fire_min_s3
mode=2
exit
}

if mode=2
{
alarm[1]=70
sprite_index=fire_min_s4
mode=3
exit
}
if mode=3
instance_destroy()

