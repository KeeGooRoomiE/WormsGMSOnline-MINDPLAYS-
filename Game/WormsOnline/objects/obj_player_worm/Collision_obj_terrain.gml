/// @description Insert description here
// You can write your code in this editor
//var d = point_direction(x,y,other.x,other.y);

//var cx = x + lengthdir_x(1,d);
//var cy = y + lengthdir_y(1,d);

if other.solid
{
    var pdir;
    pdir = point_direction(other.x, other.y, x, y);
    move_outside_solid(pdir, 1);
}