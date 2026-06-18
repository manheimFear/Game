moveX = 0;
moveY = 0;
moveSpeed = 2;
gravSpeed = 0.5;
canMove = true;
// camWidth, camHeight, targetCamWidth, targetCamHeight — УБРАНЫ,
// теперь живут только в oCamera

if (global.loadPlayerX != -1) {
    x = global.loadPlayerX;
    y = global.loadPlayerY;
    global.loadPlayerX = -1;
    global.loadPlayerY = -1;
}