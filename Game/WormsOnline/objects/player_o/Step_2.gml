var nangle,kp,jp, vsp;

xxp=xprevious
yxp=yprevious
//������ ��������
if image_index >= 25
image_index-=25
// ����� ��������
sprite_index=s_worm
if vspeed <= -0.1{image_index+=0.2;sprite_index=s_worm_jp}
//������ ������� � ������ �������
if made=1
image_xscale=-1
else
image_xscale=1


// ��� ��� ��� ������� ninja rope
if global.hook_hit = 1 and grapp = false
grapp_in()
if !grapp {vspeed+=0.7;if vspeed >= 8 vspeed=8}
else
grap_upd()

madep=made
// ����������
if speed_e=0 and !grapp
{
if vspeed <= 1 or vspeed >= -1
{
if keyboard_check(vk_left) and hspeed=0 {move_contact_solid(90,5); move_contact_solid(180,2); move_contact_solid(270,5); made=1;image_index+=0.5;sprite_index=s_walk_worm}
if keyboard_check(vk_right) {move_contact_solid(90,5); move_contact_solid(0,2); move_contact_solid(270,5); made=2;image_index+=0.5;sprite_index=s_walk_worm}
}
if keyboard_check(vk_enter) if !place_free(x,y+5) and jump=0 {vspeed=-8;sprite_index=s_worm_jp;jump=1;alarm[0]=40
if made=1
hspeed=-2
else
hspeed=2
}
if keyboard_check(vk_backspace) if !place_free(x,y+5) and jump=0 {vspeed=-9;sprite_index=s_worm_jp;jump=1;alarm[0]=30}
}
//������
if global.hook_hit = 0
{
if keyboard_check(vk_up){if made=1 angle-=5 else angle+=5}
if keyboard_check(vk_down){if made=1 angle+=5 else angle-=5}
}

if made=1
{
if angle <= 110 and angle >= 0
angle=110
if angle >= 250 and angle >= 0
angle=250

if madep=2
angle+=180
}
else
{
if angle >= 65 and angle <= 180
angle=65
if angle <= 290 and angle >= 180
angle=290
if madep=1
angle-=180
}
if angle >= 360
angle-=360
if angle <= 0
angle+=360
//�������
if keyboard_check(ord("R"))
game_restart()


// ������ �������� �������� (���������)
if global.explo_r[0]=1
{
boo=global.explo_r[1]
pdi=point_direction(boo.x,boo.y,x,y)
pds=point_distance(x,y,boo.x,boo.y)
sil=boo.sila
mds=boo.distante
mxu=(mds*sil)/100

if pds <= mds
{
udar=(pds*sil)/100
dir_e=pdi
speed_e=-mxu+udar
speed_e=speed_e*(-1)
}

}

if !speed_e=0
{
anti_zastryan_step(speed_e,dir_e)   //� �� ��� �� �� ��� �����
speed_e-=0.3
if speed_e <= 1
speed_e=0
image_index+=0.2
sprite_index=s_worm_bm
vsp=point_distance(x,0,xprevious,0)
image_angle-=(vsp*speed_e)
dtpp=1
object_set_mask(id,mask_s2)
}
else
{
object_set_mask(id,mask_s)
if dtpp=1
{
dtpp=0
vspeed-=5
}
image_angle=0
}


