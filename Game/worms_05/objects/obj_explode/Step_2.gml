
if (image_xscale <= end_scale)
{
	image_xscale += 0.1;
	image_yscale = image_xscale;
}
else
{
	instance_destroy();
}
