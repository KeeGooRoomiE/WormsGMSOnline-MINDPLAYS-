function anti_zastryan_init(argument0) {
	//argument0 - ��������, ������ 1000
	var spr_w, spr_h;

	precision = argument0;

	dir_inc = 360 / precision;
	spr_w = sprite_get_bbox_bottom(sprite_index)-sprite_get_bbox_top(sprite_index);
	spr_h = sprite_get_bbox_right(sprite_index)-sprite_get_bbox_left(sprite_index);
	max_dist = min(spr_w,spr_h);
	loops2 = floor((precision+3)/4);



}
