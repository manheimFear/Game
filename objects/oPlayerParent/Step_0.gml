if (keyboard_check_pressed(ord("E"))) {
    var _door = instance_place(x, y, oDoor);
    if (_door != noone && _door.teleportTimer == 0) {
        var _cam_obj = instance_find(oCamera, 0);
        if (_cam_obj != noone) {
            _cam_obj.targetCamWidth  = 640;
            _cam_obj.targetCamHeight = 360;
        }
        canMove = false;
        _door.teleportTimer = 60;
    }
}
if (keyboard_check_pressed(ord("N")) && global.hasNotebook) {
    var nb = instance_find(oNotebook, 0);
    if (nb != noone && !nb.visible) {
        nb.visible        = true;
        nb.animState      = "opening";
        nb.animSprite     = sNotebookOpenAnim; // твой спрайт анимации открытия
        nb.animTimer      = 0;
		nb.animFrame      = 0;
        nb.pendingPage    = 0; // после анимации покажем главное меню
        global.menuOpen   = true;
    }
}