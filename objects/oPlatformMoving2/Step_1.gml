if (global.gamePaused) exit;
prevX = x;
prevY = y;

var _targetX = endX, _targetY = endY;
if (goingToStart) {
    _targetX = startX;
    _targetY = startY;
}
moveX = sign(_targetX - x) * min(currentSpeed, abs(_targetX - x));
moveY = sign(_targetY - y) * min(currentSpeed, abs(_targetY - y));