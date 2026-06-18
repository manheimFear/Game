if (global.menuOpen) {
    exit;
}
if (isSleeping) exit;
if (!canMove)
{
    sprite_index = sPlayer_Idle;
}
else
if (isDashing) {
    if (dashDirY != 0) {
        sprite_index = sPlayer_DashVer;
    } else {
        sprite_index = sPlayer_DashGor;
        image_xscale = dashDirX;
    }
}
else if (Climbs) {
    sprite_index = sPlayer_Climb;
    if (touch_wall_left) {
        image_xscale = -1;
    } else {
        image_xscale = 1;
    }
}
else if (moveY < 0) {
    if (inputX != 0) {
        image_xscale = sign(inputX);
        sprite_index = sPlayer_JumpSide;
    } else {
        sprite_index = sPlayer_Jump;
    }
}
else if (moveY > 0 && !place_meeting(x, y + 1, oPlatformParent)) {
    if (inputX != 0) {
        image_xscale = sign(inputX);
        sprite_index = sPlayer_FallSide;
    } else {
        sprite_index = sPlayer_Fall;
    }
}
else if (inputX != 0) {
    image_xscale = sign(inputX);
    sprite_index = sPlayer_Walk;
}
else {
    sprite_index = sPlayer_Idle;
}