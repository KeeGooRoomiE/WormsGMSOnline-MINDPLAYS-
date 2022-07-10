/// @description Pierce angle up

if (curAngle > 0)
{
	curAngle -= angleStep;
}
else
{
	curAngle = 0;
}

show_debug_message("worm curAngle: "+string(curAngle));