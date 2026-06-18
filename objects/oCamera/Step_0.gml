// ── Получаем ссылку на активного игрока ──────────────────
var _player = instance_find(oPlayerParent, 0);
var _cam    = view_camera[0];

// ── Зум (lerp к целевому размеру) ────────────────────────
camWidth  = lerp(camWidth,  targetCamWidth,  0.05);
camHeight = lerp(camHeight, targetCamHeight, 0.05);
camera_set_view_size(_cam, camWidth, camHeight);

// ── Следование за игроком с ограничением по границам ─────
if (_player != noone && !returning) {

    var _targetX = _player.x - camWidth  / 2;
    var _targetY = _player.y - camHeight / 2;

    _targetX = clamp(_targetX, 0, max(0, room_width  - camWidth));
    _targetY = clamp(_targetY, 0, max(0, room_height - camHeight));

    camX = _targetX;
    camY = _targetY;
}

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

// ── Применяем позицию ─────────────────────────────────────
camera_set_view_pos(_cam, camX, camY);
var player = instance_find(oPlayerParent, 0);
