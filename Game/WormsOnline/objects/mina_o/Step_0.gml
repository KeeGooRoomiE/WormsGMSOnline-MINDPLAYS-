if distance_to_object(worm_o) <= 15 and boom=0
{
alarm[0] = 50
boom=1
image_speed=0.2
}

if speed < 0.5
  exit
if to = 0
  image_angle += speed*3
else
  image_angle += (speed*3)*-1


