instance_destroy()
repeat (60)
{
SDAS=instance_create(x,y,fire_min_o)
SDAS.direction=90-45+random(90)
SDAS.speed=random(10)
}

