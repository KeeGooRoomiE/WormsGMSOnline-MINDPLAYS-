/// @description Pierce angle down

if (curAngle < 180)
{
	curAngle += angleStep;
}
else
{
	curAngle = 180;
}

show_debug_message("worm curAngle: "+string(curAngle));