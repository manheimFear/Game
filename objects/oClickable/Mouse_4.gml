var _cam = instance_find(oCamera, 0);
if (_cam != noone) {
    _cam.savedCamX = _cam.camX; // сохраняем текущую позицию
    _cam.savedCamY = _cam.camY;
    _cam.targetCamWidth = 400;
    _cam.targetCamHeight = 225;
    _cam.targetX = x;
    _cam.targetY = y;
}