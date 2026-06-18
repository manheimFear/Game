/// @description
touch_wall_left  = place_meeting(x - 1, y, oPlatform) && !place_meeting(x, y + 1, oPlatform);
touch_wall_right = place_meeting(x + 1, y, oPlatform) && !place_meeting(x, y + 1, oPlatform);

if (inputJump) {
    show_debug_message("JUMP: touchL=" + string(touch_wall_left) + " touchR=" + string(touch_wall_right) + " onGround=" + string(place_meeting(x, y+1, oPlatformParent)));
}

var left  = keyboard_check(ord("A"));
var right = keyboard_check(ord("D"));

if (lefttrue)  left  = 0;
if (righttrue) right = 0;

inputX    = right - left;
inputJump = keyboard_check_pressed(vk_space);
inputDash = keyboard_check_pressed(vk_shift);

// Wall Jump
if (inputJump && !place_meeting(x, y + 1, oPlatformParent)) {
    if (touch_wall_right) {
        moveY = -wallJumpVSpeed;
        moveX = -wallJumpHSpeed;
        wallJumpTimer = 12;
    }
    else if (touch_wall_left) {
        moveY = -wallJumpVSpeed;
        moveX = wallJumpHSpeed;
        wallJumpTimer = 12;
    }
}