if (instance_place(x,y, oPlayer))
{
	if (keyboard_check_pressed(ord("E")))
	{
		instance_destroy(WALL);
		instance_destroy(inst_55475806);
		image_index = 1;
	}
}