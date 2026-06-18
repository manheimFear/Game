/// @description

event_inherited();

// Блокировка при открытом меню блокнота
if (global.menuOpen) {
    exit;
}

if (!canMove) exit;

// Horizontal movement
if (y > room_height + 100) {
    global.Death = true;
}
if (x < -5 || x > room_width + 5)
{
global.Death = true;
}
if (global.loadPlayerX != -1) {
    x = global.loadPlayerX;
    y = global.loadPlayerY;
    global.loadPlayerX = -1;
    global.loadPlayerY = -1;
}

if (global.Death == true) {
    global.deathCount++;

    if (global.activeCheckpoint != noone) {
        var _cp = global.activeCheckpoint;

        if (!_cp.isEternal) {
            _cp.deathsAtThisCheckpoint++;

            if (_cp.deathsAtThisCheckpoint >= 3) {
                _cp.activated = false;
                _cp.wasReset = true;
                _cp.deathsAtThisCheckpoint = 0;
                _cp.sprite_index = checkpoint;

                global.activeCheckpoint = global.previousCheckpoint;
            }
        }
    }

    if (global.activeCheckpoint != noone) {
        x = global.activeCheckpoint.x;
        y = global.activeCheckpoint.y;
    } else {
        x = oSpawn.x;
        y = oSpawn.y;
    }
	

    global.Death = false;
    moveX = 0;
    moveY = 0;
}

// Рывок
if (inputDash && dashCooldown <= 0 && !isDashing) {
    isDashing = true;
    dashTimer = dashDuration;
    dashCooldown = dashCooldownMax;

    if (Climbs) {
        dashDirX = 0;
        dashDirY = -1;
    } else {
        dashDirY = 0;
        if (inputX != 0) {
            dashDirX = sign(inputX);
        } else {
            dashDirX = image_xscale;
        }
    }
}

if (dashCooldown > 0) dashCooldown--;

if (isDashing) {
    dashTimer--;
    moveX = dashDirX * dashSpeed;
    moveY = dashDirY * dashSpeed;
    if (dashTimer <= 0) {
        isDashing = false;
        moveX = dashDirX * SpeedBarrier;
        moveY = dashDirY * 2;
    }
}

if (!isDashing) {
    if (!isSleeping) {
        moveX += inputX * moveSpeed;
    }
}

if (isDashing) {
    // во время рывка не трогаем moveX
} else if (wallJumpTimer > 0) {
    wallJumpTimer--;
    moveX *= 0.85;
} else {
    moveX = clamp(moveX, -SpeedBarrier, SpeedBarrier);
}

if (inputX == 0) {
    if (moveX > 0) {
        moveX = max(0, moveX - hFrictionGround);
    } else if (moveX < 0) {
        moveX = min(0, moveX + hFrictionGround);
    }
}

var _onGround = place_meeting(x, y + 1, oPlatform);

// Jump
if (inputJump && (_onGround || onMovingPlatform) && !isSleeping) {
    moveY = -jumpSpeed;
}
onMovingPlatform = false;

var _finalMoveX = moveX;
var _finalMoveY = moveY;

// Коллизии X
if (place_meeting(x + _finalMoveX, y, oPlatform)) {
    while (!place_meeting(x + sign(_finalMoveX), y, oPlatform)) {
        x += sign(_finalMoveX);
    }
    _finalMoveX = 0;
    moveX = 0;
}

// Коллизии Y
if (place_meeting(x, y + _finalMoveY, oPlatform)) {
    while (!place_meeting(x, y + sign(_finalMoveY), oPlatform)) {
        y += sign(_finalMoveY);
    }
    _finalMoveY = 0;
    moveY = 0;
}

x += _finalMoveX;
y += _finalMoveY;


if (moveY < 10) {
    moveY += gravSpeed;
}

var wall_inst_left  = instance_place(x - 1, y, oPlatform);
var wall_inst_right = instance_place(x + 1, y, oPlatform);
touch_wall_left  = (wall_inst_left  != noone) && (wall_inst_left.bbox_right  <= bbox_left + 2);
touch_wall_right = (wall_inst_right != noone) && (wall_inst_right.bbox_left >= bbox_right - 2);

if (!_onGround) {
    if ((touch_wall_left || touch_wall_right) && moveY > 0) {
        moveY = 1;
        Climbs = true;
        climbBuffer = 3;
        Climbing();
    } else {
        if (climbBuffer > 0) {
            climbBuffer--;
            Climbs = true;
        } else {
            Climbs = false;
            lefttrue = false;
            righttrue = false;
        }
    }
} else {
    Climbs = false;
    climbBuffer = 0;
}
lefttrue = false;
righttrue = false;

if (place_meeting(x, y, BedTouch)) {
    if (keyboard_check_pressed(ord("E")) && !isSleeping) {
        isSleeping = true;
        sprite_index = sPlayer_Sleep;
        image_index = 0;
        image_speed = 1;
    }
}

// Остановка на последнем кадре
if (isSleeping) {
    if (image_index >= sprite_get_number(sPlayer_Sleep) - 1) {
        image_speed = 0;
        image_index = sprite_get_number(sPlayer_Sleep) - 1;
    }
}

// ── Открытие меню (единственная копия) ──────────────────────
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
if (place_meeting(x, y, BedTouch)) {
    show_debug_message("Touching bed");

    if (keyboard_check_pressed(ord("E"))) {
        show_debug_message("E pressed");
    }
}