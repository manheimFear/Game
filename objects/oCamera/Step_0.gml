// ── Следование за игроком с ограничением по границам ─────
var _player = instance_find(oPlayerParent, 0);
var _cam    = view_camera[0];
var _p = _player;

camWidth  = lerp(camWidth,  targetCamWidth,  0.05);
camHeight = lerp(camHeight, targetCamHeight, 0.05);
camera_set_view_size(_cam, camWidth, camHeight);

if (!cutsceneMode) {
    // Обычное следование за игроком
    if (_player != noone && !returning) {
        var _targetX = _player.x - camWidth  / 2;
        var _targetY = _player.y - camHeight / 2;
        _targetX = clamp(_targetX, 0, max(0, room_width  - camWidth));
        _targetY = clamp(_targetY, 0, max(0, room_height - camHeight));
        camX = _targetX;
        camY = _targetY;
    }
}  
if (cutsceneMode)
{
    // Базовая позиция — как при обычном следовании, плюс смещение
    var _baseX = clamp(_p.x - camWidth / 2, 0, max(0, room_width - camWidth));
    var _baseY = clamp(_p.y - camHeight / 2, 0, max(0, room_height - camHeight));
    
    var _cx = clamp(_baseX + cutsceneOffsetX, 0, max(0, room_width  - camWidth));
    var _cy = clamp(_baseY + cutsceneOffsetY, 0, max(0, room_height - camHeight));
    
    camX = lerp(camX, _cx, cutsceneSpeed);
    camY = lerp(camY, _cy, cutsceneSpeed);
   global.cameraAtTarget = (abs(camX - _cx) < 3 && abs(camY - _cy) < 3);
}
show_debug_message("clampMax=" + string(max(0, room_width - camWidth)) + " room_width=" + string(room_width));
show_debug_message("mode=" + string(cutsceneMode) + 
    " camX=" + string(camX) + 
    " targetX=" + string(cutsceneTargetX) + 
    " camWidth=" + string(camWidth) + 
    " returning=" + string(returning));
camera_set_view_pos(_cam, camX, camY);

// ── Возврат камеры (если returning == true) ───────────────
if (returning) {
    camX = lerp(camX, savedCamX, 0.08);
    camY = lerp(camY, savedCamY, 0.08);
    if (abs(camX - savedCamX) < 1 && abs(camY - savedCamY) < 1) {
        camX      = savedCamX;
        camY      = savedCamY;
        returning = false;
    }
}

