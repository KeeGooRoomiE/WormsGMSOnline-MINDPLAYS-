ssz=string_length(name)*3.5
draw_sprite_ext(spr_runl,0,x,y-28,ssz,1,0,c_white,1)
draw_sprite_ext(spr_run,0,x-ssz-1,y-28,1,1,0,c_white,1)
draw_sprite_ext(spr_run,1,x+ssz+1,y-28,1,1,0,c_white,1)
draw_set_halign(fa_center)
draw_set_color(draw_c.c_tcolor)
draw_set_font(fnt_o)
draw_text(x,y-28,string_hash_to_newline(string(name)))


// �������
spee_e=point_distance(x,y,xprevious,yprevious)
di_e=point_direction(x,y,xprevious,yprevious)
if made=1
{
andraw[1]=angle
andraw[1]-=110

andraw[0]=140-andraw[1]
}
else
{
if angle >= 284 and angle <= 364 
andraw[0]=angle-290
else
andraw[0]=angle+70
}
// ������ �����
if sprite_index=s_worm
{
if made=1
{
if global.gun_select=0
draw_sprite_ext(s_bazuka1,andraw[0]/(140/32),x,y,-1,1,0,c_white,1)
if global.gun_select=1 and global.hook_hit = 0
draw_sprite_ext(s_ninj_rope,andraw[0]/(140/32),x,y,-1,1,0,c_white,1)
if global.gun_select=1 and global.hook_hit = 1
draw_sprite_ext(s_rope_ok,0,x,y,-1,1,hk_line.image_angle,c_white,1)

if global.gun_select=2
draw_sprite_ext(s_greenade,andraw[0]/(140/32),x,y,-1,1,0,c_white,1)
if global.gun_select=3
draw_sprite_ext(s_petrol,andraw[0]/(140/32),x,y,-1,1,0,c_white,1)
}
else
{
if global.gun_select=0
draw_sprite_ext(s_bazuka1,andraw[0]/(140/32),x,y,1,1,0,c_white,1)
if global.gun_select=1 and global.hook_hit = 0
draw_sprite_ext(s_ninj_rope,andraw[0]/(140/32),x,y,1,1,0,c_white,1)
if global.gun_select=1 and global.hook_hit = 1
draw_sprite_ext(s_rope_ok,0,x,y,1,1,hk_line.image_angle,c_white,1)

if global.gun_select=2
draw_sprite_ext(s_greenade,andraw[0]/(140/32),x,y,1,1,0,c_white,1)
if global.gun_select=3
draw_sprite_ext(s_petrol,andraw[0]/(140/32),x,y,1,1,0,c_white,1)
}
}
else
draw_sprite_my()



// ������
if global.hook_hit = 0
draw_sprite_ext(pr_sp,0,x+lengthdir_x(50,angle),y+lengthdir_y(50,angle),1,1,0,c_white,0.9)
//������ hud ����
anims=0
dds=0
if spa=1
{
repeat (sila/10-1)
{
dds+=5
draw_sprite_ext(blob_s,anims,x+lengthdir_x(15+dds,angle),y+lengthdir_y(15+dds,angle),1,1,1,c_white,0.9)
anims+=1
}
}


