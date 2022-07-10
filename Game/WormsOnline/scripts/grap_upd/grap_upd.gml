function grap_upd() {
	vspeed=0
	halfWidth = sprite_width / 2;
	halfHeight = sprite_height / 2;
	targetDistance = distance_to_point(targetX - halfWidth, targetY - halfHeight);
	targetDirection = point_direction(x, y, targetX - halfWidth, targetY - halfHeight);
	rotationSpeed += sin(degtorad(targetDirection-90)) * rotationGravity / targetDistance;
	rotationSpeed = min(rotationSpeed, maxRotationSpeed);
	rotationSpeed = max(rotationSpeed, 0 - maxRotationSpeed);
	radSpeed = degtorad(rotationSpeed);
	relativeX = targetX - x - halfWidth;
	relativeY = targetY - y - halfHeight;
	x = targetX - relativeX * cos(radSpeed) + relativeY * sin(radSpeed) - halfWidth;
	y = targetY - relativeY * cos(radSpeed) - relativeX * sin(radSpeed) - halfHeight;


	if place_meeting(x,y,bass)
	{
	rotationSpeed/=2
	x = xprevious;y = yprevious

	for (i=0; i<90; i+=2)
	{
	xmot=x+lengthdir_x(4,targetDirection+i)
	ymot=y+lengthdir_y(4,targetDirection+i)
	if place_free(xmot,ymot){x = xmot;y = ymot;exit}
	xmot=x+lengthdir_x(4,targetDirection-i)
	ymot=y+lengthdir_y(4,targetDirection-i)
	if place_free(xmot, ymot){x = xmot;y = ymot;exit}
	}
	}

	if keyboard_check(vk_left)
	rotationSpeed += swingAmount;
	if keyboard_check(vk_right)
	rotationSpeed -= swingAmount;
	if keyboard_check(vk_up)
	{
	if targetDistance >= 5
	{
	x += 5*cos(degtorad(targetDirection));
	y -= 5*sin(degtorad(targetDirection));
	}
	}
	if keyboard_check(vk_down)
	{
	x -= 5*cos(degtorad(targetDirection));
	y += 5*sin(degtorad(targetDirection));
	}
	if !global.gun_select=1
	{
	with (hk_line)
	instance_destroy()
	}



}
