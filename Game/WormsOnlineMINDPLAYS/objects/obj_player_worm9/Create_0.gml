///@description Init

#region -- Gravity set

//gravity=0.5;
//gravity_direction=global.wind;

#endregion

#region -- Rotate values

isLeftSide = false;

minAngle = 90;
curAngle = 0;
angleStep = 6;
maxAngle = 180;

#endregion

isFirstContact = true;
isFallingFree = false;
isAimRocket = false;
isFallFly = false;

shotForce = 0;
shf = 0;

//instance_create_depth(x,y,depth,obj_start_expl);

#region -- Stop animations

image_speed = 0;
image_index = 0;

#endregion

