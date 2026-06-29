if (instance_place(x, y, oPlayerParent)) {
    if (keyboard_check_pressed(ord("E"))) {
        var _cam_obj = instance_find(oCamera, 0);
        var _p = instance_find(oPlayerParent, 0);
		       _cam_obj.cutsceneMode    = true;
if (_cam_obj.cutsceneMode    == true){
        if (_p != noone) _p.canMove = false; // блокировать игрока
}

_cam_obj.cutsceneOffsetX = 600;  // ← подбери, на сколько px сдвинуть камеру по X
_cam_obj.cutsceneOffsetY = 0;    // ← подбери, на сколько px сдвинуть камеру по Y
_cam_obj.cutsceneSpeed   = 0.05;

        global.hasNotebook = true;
        variable_struct_set(global.pickedItems, itemUniqueId, true);
        instance_destroy();
    }
}



