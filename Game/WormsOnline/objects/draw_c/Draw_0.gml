
draw_rectangle_color(__view_get( e__VW.XView, 0 ),0,__view_get( e__VW.XView, 0 )+640,room_height,color_g1,color_g1,color_g2,color_g2,0)

draw_text(__view_get( e__VW.XView, 0 )+10,__view_get( e__VW.YView, 0 )+40,string_hash_to_newline(string(player_o.targetDistance)))

