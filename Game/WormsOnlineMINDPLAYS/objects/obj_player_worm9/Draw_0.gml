/// @description Insert description here
// You can write your code in this editor

draw_self();

var xx = x + lengthdir_x(12,direction);
var yy = y + lengthdir_y(12,direction);
draw_line(x,y,xx,yy);

#region -- Swap sprites
if (isFallingFree = true) {sprite_index = spr_worm_backflip;};
if (isAimRocket = true) {sprite_index = spr_worm_rocket_aim;};
if (isFallFly = true) {sprite_index = spr_worm_fly;};

#endregion
