if (instance_place(x, y, oPlayer)) {
    if (keyboard_check_pressed(ord("E"))) {
			g += 1;
		draw = true;
		image_index = 1;
        }
        
}
else
draw = false;
event_inherited();