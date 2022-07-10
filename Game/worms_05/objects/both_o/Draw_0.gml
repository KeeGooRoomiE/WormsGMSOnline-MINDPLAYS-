ssz=string_length(name)*3.5
draw_sprite_ext(spr_runl,0,x,y-28,ssz,1,0,c_white,1)
draw_sprite_ext(spr_run,0,x-ssz-1,y-28,1,1,0,c_white,1)
draw_sprite_ext(spr_run,1,x+ssz+1,y-28,1,1,0,c_white,1)
draw_set_halign(fa_center)
draw_set_color(c_green)
draw_set_font(fnt_o)
draw_text(x,y-28,string_hash_to_newline(string(name)))

// �������
spee_e=point_distance(x,y,xprevious,yprevious)
di_e=point_direction(x,y,xprevious,yprevious)

// ������ �����
draw_sprite_my()

