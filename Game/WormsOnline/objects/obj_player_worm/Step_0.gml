///@description Behaviour

//instance_create(x,y,smoke_buzu_o)

//image_angle = direction;

#region -- Rotate image

//scale rotation
image_xscale = 1 + (-2*isLeftSide);

//image_index = clamp((180-curAngle)/5,0,32);

image_index = curAngle / angleStep;

//prob... direction
direction = -90 + curAngle * image_xscale;

#endregion

//curAngle = 140;

if !place_meeting(x, y + 1, obj_terrain)
{
    move_contact_solid(global.wind, -1);
}