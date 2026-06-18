// Движение
event_inherited();

// Блокировка при диалоге ИЛИ меню
if (global.Dialogue || global.menuOpen) {
    sprite_index = PlayerMainIdle;
if (keyboard_check_pressed(ord("N")) && global.hasNotebook) {
    var nb = instance_find(oNotebook, 0);
    if (nb != noone && !nb.visible) {
        nb.visible         = true;
        nb.currentPage     = 0;
        nb.selectedButton  = 0;
        global.menuOpen    = true;
       global.gamePaused = true;
    }
}
}

if (!canMove) {
    sprite_index = PlayerMainIdle;
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

if (place_meeting(x + moveX, y, oPlatformParent)) {
    while (!place_meeting(x + sign(moveX), y, oPlatformParent)) x += sign(moveX);
    moveX = 0;
}
x += moveX;

if (moveY < 10) moveY += gravSpeed;

if (place_meeting(x, y + moveY, oPlatformParent)) {
    while (!place_meeting(x, y + sign(moveY), oPlatformParent)) y += sign(moveY);
    moveY = 0;
}
y += moveY;

if (keyboard_check_pressed(ord("N")) && global.hasNotebook) {
    var nb = instance_find(oNotebook, 0);
    if (nb != noone && !nb.visible) {
        nb.visible         = true;
        nb.currentPage     = 0;
        nb.selectedButton  = 0;
        global.menuOpen    = true;
       global.gamePaused = true;
    }
}


