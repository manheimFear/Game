if (global.gamePaused) exit;
x += moveX;
y += moveY;

if (goingToStart && point_distance(x, y, startX, startY) < currentSpeed) {
    goingToStart = false;
    currentSpeed = 0;
    alarm[0] = waitTime;
}
else if (!goingToStart && point_distance(x, y, endX, endY) < currentSpeed) {
    goingToStart = true;
    currentSpeed = 0;
    alarm[0] = waitTime;
}

var _deltaX = x - prevX;
var _deltaY = y - prevY;

var _player = instance_find(oPlayer, 0);
if (_player == noone) exit;

var _overlapX = (_player.bbox_right > bbox_left + 1) && (_player.bbox_left < bbox_right - 1);
var _overlapY = (_player.bbox_bottom > bbox_top) && (_player.bbox_top < bbox_bottom);

var _tolerance = abs(_deltaY) + 4;

var _onTop = _overlapX
          && (_player.bbox_bottom >= bbox_top - 2)
          && (_player.bbox_bottom <= bbox_top + _tolerance)
          && (_player.moveY >= 0);

var _inside = _overlapX && _overlapY && !_onTop;

if (_onTop) {
    _player.x += _deltaX;
    _player.y += _deltaY; // просто едем вместе, без принудительного прижатия
    _player.moveY = 0;
    _player.onMovingPlatform = true;
}
else if (_inside) {
    var _depthLeft   = _player.bbox_right - bbox_left;
    var _depthRight  = bbox_right - _player.bbox_left;
    var _depthTop    = _player.bbox_bottom - bbox_top;
    var _depthBottom = bbox_bottom - _player.bbox_top;

    var _minDepthX = min(_depthLeft, _depthRight);
    var _minDepthY = min(_depthTop, _depthBottom);

    if (_minDepthX < _minDepthY) {
        if (_depthLeft < _depthRight) {
            _player.x -= _depthLeft;
        } else {
            _player.x += _depthRight;
        }
        _player.moveX = 0;
    } else {
        var _platformCenterY = bbox_top + (bbox_bottom - bbox_top) / 2;
        if (_player.y < _platformCenterY) {
            _player.y -= _depthTop;
            _player.moveY = 0;
            _player.onMovingPlatform = true;
        } else {
            _player.y += _depthBottom;
            _player.moveY = 0;
        }
    }
}
var _ox = (_player.bbox_right > bbox_left) && (_player.bbox_left < bbox_right);
var _oy = (_player.bbox_bottom > bbox_top) && (_player.bbox_top < bbox_bottom);

if (_ox && _oy && !_onTop) {
    _player.stuckTimer++;
    if (_player.stuckTimer > 5) {
        if (_player.x <= x) {
            _player.x = bbox_left - (_player.bbox_right - _player.x);
        } else {
            _player.x = bbox_right + (_player.x - _player.bbox_left);
        }
        _player.stuckTimer = 0;
        _player.moveX = 0;
    }
} else {
    _player.stuckTimer = 0;
}