instance_create(x,y,veiw_shake)
kk=instance_create(x,y,poov_gfx)
kk.image_xscale=1
kk.image_yscale=1
ex=instance_create(x+lengthdir_x(speed,direction),y+lengthdir_y(speed,direction),explore_o)
ex.sila=3
ex.distante=360
power_b=30

instance_destroy()

