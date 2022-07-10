instance_create(x,y,veiw_shake)
kk=instance_create(x,y,poov_gfx)
kk.image_xscale=2
kk.image_yscale=2
ex=instance_create(x+lengthdir_x(speed,direction),y+lengthdir_y(speed,direction),explore_o)
ex.sila=5.5
ex.distante=400
power_b=40


instance_destroy()

