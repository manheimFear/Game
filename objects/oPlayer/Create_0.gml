/// @description
inputX = 0;
inputJump = 0;
moveX = 0;
moveY = 0;
moveSpeed = 2;
jumpSpeed = 13;
gravSpeed = 0.5;
Acceleration = 0.5;
SpeedBarrier = 6;
hFrictionGround = 0.5;
lefttrue = false;
righttrue = false;
wallJumpHSpeed = 20;
wallJumpVSpeed = 15;
wallJumpTimer = 0;
onMovingPlatform = false;
stuckTimer = 0;
Climbs = false;
climbBuffer = 0;
global.Death = false;
global.activeCheckpoint = noone;
dashSpeed = 20;
dashDuration = 10;
dashTimer = 0;
dashCooldown = 0;
dashCooldownMax = 30;
isDashing = false;
dashDirY = 0;
global.previousCheckpoint = noone;
global.deathCount = 0;


depth = -2;

// camWidth/camHeight/targetCamWidth/targetCamHeight — УБРАНЫ,
// камера теперь полностью в oCamera

canMove = true;
isSleeping = false;