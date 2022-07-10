if global.panels=0
{
cap[0]-=view_obj.change_x/2
if cap[0] >= 640
cap[0]-=640
if cap[0] <= -640
cap[0]+=640
}
draw_background_ext(back2,__view_get( e__VW.XView, 0 )+cap[0],room_height-200,1,1,0,c_white,1)
draw_background_ext(back2,__view_get( e__VW.XView, 0 )+640+cap[0],room_height-200,1,1,0,c_white,1)
draw_background_ext(back2,__view_get( e__VW.XView, 0 )-640+cap[0],room_height-200,1,1,0,c_white,1)

