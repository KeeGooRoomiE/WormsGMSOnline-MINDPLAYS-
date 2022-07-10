if global.panels=0
{

//get display dimensions
display_w=display_get_width();
display_h=display_get_height();

//calculate motion
change_x=(display_mouse_get_x()-display_w/2)/2;
change_y=(display_mouse_get_y()-display_h/2)/2;
if (change_y<.001) {change_y=round(change_y)}

//set mouse back
display_mouse_set(display_w/2,display_h/2);

shake = 10;

x+=shake/10
y+=shake/10

x+=change_x
y+=change_y

x+=-player_o.xxp+player_o.x
y+=-player_o.yxp+player_o.y


if x <= 320 or x >= room_width-320 or y <= 240 or y >= room_height-240
{
x=xprevious
y=yprevious
change_x-=change_x
change_y-=change_y
}
}

