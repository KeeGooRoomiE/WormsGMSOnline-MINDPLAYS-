image_xscale=-1

vspeed+=0.7;if vspeed >= 8 vspeed=8

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
speed_e-=0.2
if speed_e <= 1
speed_e=0
image_index+=0.2
sprite_index=s_worm_bm
vsp=point_distance(x,0,xprevious,0)
image_angle-=(vsp*speed_e)
}
else
image_angle=0

