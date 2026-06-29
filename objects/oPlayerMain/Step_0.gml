// Движение
event_inherited();

// Блокировка при диалоге ИЛИ меню
if (global.Dialogue || global.menuOpen) {
    sprite_index = PlayerMainIdle;
    gravSpeed = 0;
    exit;
}

var _left  = keyboard_check(ord("A"));
var _right = keyboard_check(ord("D"));
moveX = (_right - _left) * moveSpeed;

if (moveX != 0) {
    sprite_index = PlayerMainWalk;
    image_xscale = sign(moveX);
} else {
    sprite_index = PlayerMainIdle;
}

// --- Аварийный выход, если игрок уже застрял внутри платформы ---
if (place_meeting(x, y, oPlatformParent)) {
    var _unstuckDir = 0;
    var _unstuckDist = 999;
    // ищем ближайшее свободное направление по горизонтали
    for (var _i = 1; _i <= 16; _i++) {
        if (!place_meeting(x - _i, y, oPlatformParent)) { _unstuckDir = -_i; _unstuckDist = _i; break; }
        if (!place_meeting(x + _i, y, oPlatformParent)) { _unstuckDir = _i;  _unstuckDist = _i; break; }
    }
    if (_unstuckDir != 0) {
        x += _unstuckDir;
    }
}

// Горизонтальное движение — пошагово
if (moveX != 0) {
    var _sign = sign(moveX);
    var _steps = abs(moveX);
    repeat (_steps) {
        if (!place_meeting(x + _sign, y, oPlatformParent)) {
            x += _sign;
        } else {
            moveX = 0;
            break;
        }
    }
}

// Гравитация (без прыжка — просто падение под спавн на пол)
if (moveY < 10) moveY += gravSpeed;

// Вертикальное движение — пошагово
if (moveY != 0) {
    var _signY = sign(moveY);
    var _stepsY = abs(moveY);
    repeat (_stepsY) {
        if (!place_meeting(x, y + _signY, oPlatformParent)) {
            y += _signY;
        } else {
            moveY = 0;
            break;
        }
    }
}

if (global.loadPlayerX != -1) {
    x = global.loadPlayerX;
    y = global.loadPlayerY;
    global.loadPlayerX = -1;
    global.loadPlayerY = -1;
}