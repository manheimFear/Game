if (teleportTimer > 0) {
    teleportTimer--;
    if (teleportTimer == 0) {
        room_goto(asset_get_index(targetRoom));
        // Сброс камеры на обычный размер после перехода:
        var _cam_obj = instance_find(oCamera, 0);
        if (_cam_obj != noone) {
            _cam_obj.targetCamWidth  = 1280;
            _cam_obj.targetCamHeight = 720;
        }
    }
}