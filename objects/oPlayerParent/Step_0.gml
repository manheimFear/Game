// Дверь
if (mouse_check_button_pressed(mb_left)) {
    var _door = instance_place(x, y, oDoor);
    if (_door != noone) {
        var _cam_obj = instance_find(oCamera, 0);
        if (_cam_obj != noone) {
            _cam_obj.targetCamWidth  = 640;
            _cam_obj.targetCamHeight = 360;
        }
        canMove = false;
        _door.teleportTimer = 60;
    }
}