if (instance_place(x, y, oPlayerParent)) {
    if (keyboard_check_pressed(ord("E"))) {
		    global.hasNotebook = true;
        variable_struct_set(global.pickedItems, itemUniqueId, true);
        instance_destroy();
    }
}