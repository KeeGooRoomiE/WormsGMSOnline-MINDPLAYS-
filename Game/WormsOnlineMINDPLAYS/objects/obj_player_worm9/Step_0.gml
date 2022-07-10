///@description Behaviour

//instance_create(x,y,smoke_buzu_o)

//image_angle = direction;

#region -- Rotate image

//scale rotation
image_xscale = 1 + (-2*isLeftSide);

//image_index = clamp((180-curAngle)/5,0,32);
if (isAimRocket)
{
	image_index = curAngle / angleStep;
	direction = -90 + curAngle * image_xscale;
}
//prob... direction


#endregion

//curAngle = 140;

if (!place_meeting(x, y + 1, obj_terrain) )
{
	isFallingFree = true;
	isAimRocket = false;
} 
else
{
	isFallingFree = false;
	isAimRocket = true;
	isFallFly = false;
}

#region -- Free falling

if (isFallingFree)
{
	move_contact_solid(270, 1);
	image_speed = 1;
}

#endregion

#region -- Fall fly

if (isFallFly)
{
	if (speed > 0)
	{
		speed -= 0.1;
	}
	else
	{
		speed = 0;
	}
	image_speed = 0;
	image_index = direction;
}
#endregion

#region -- Shot force


if (keyboard_check_released(vk_space) )
{
	var b = instance_create_depth( x + lengthdir_x(16,direction), y + lengthdir_y(16,direction),depth,obj_bomb);
	b.direction = direction;
	b.image_angle = b.direction;
	b.speed = 16;
}



#endregion

