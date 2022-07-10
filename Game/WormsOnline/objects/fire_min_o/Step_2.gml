gravity=0.4
x+=4-random(8)
y+=1-random(2)

if global.explo_r[0]=1
{
boo=global.explo_r[1]
pdi=point_direction(x,y,boo.x,boo.y)
pds=point_distance(x,y,boo.x,boo.y)
sil=boo.sila
mds=boo.distante
mxu=(mds*sil)/100

if pds <= mds
{
udar=(pds*sil)/100
direction=pdi
speed=-mxu+udar
}
}

