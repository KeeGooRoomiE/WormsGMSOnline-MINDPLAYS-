function anti_zastryan_step(argument0, argument1) {
	// anti_zastryan_step(speed,direction)
	var spe, dir;

	spe = argument0;
	dir = argument1;

	if spe != 0 {
	 loops1 = ceil(abs(spe)/max_dist);
	 repeat (loops1) {
	  xold = x;
	  yold = y;
	  new_spe = min(spe,max_dist);
	  spe -= new_spe;
	  for (i2 = 0; i2 < loops2; i2 += 1) {
	   dir_offset = i2*dir_inc;
	   new_spe2 = new_spe;
	//   new_spe2 *= 1 - (dir_offset/90);
	   dir1 = dir + dir_offset;
	   xtar1 = x + lengthdir_x(new_spe2,dir1);
	   ytar1 = y + lengthdir_y(new_spe2,dir1);
	   if i2 > 0 {
	    dir2 = direction - dir_offset;
	    xtar2 = x + lengthdir_x(new_spe2,dir2);
	    ytar2 = y + lengthdir_y(new_spe2,dir2);
	   }
	   if !place_meeting(xtar1,ytar1,bass) {
	    x = xtar1;
	    y = ytar1;
	    break;
	   }
	   else if i2 > 0 {
	    if !place_meeting(xtar2,ytar2,bass) {
	     x = xtar2;
	     y = ytar2;
	     break;
	    }
	   }
	  }
	 }
	}



}
