// Начало катсцены — камера движется к точке (targetX, targetY):
var _cam_obj = instance_find(oCamera, 0);
_cam_obj.cutsceneMode    = true;
_cam_obj.cutsceneTargetX = 800; // мировая X-координата точки фокуса
_cam_obj.cutsceneTargetY = 400; // мировая Y-координата точки фокуса
_cam_obj.cutsceneSpeed   = 0.05;

var _p = instance_find(oPlayerParent, 0);
if (_p != noone) _p.canMove = false; // заблокировать игрока

// Возврат камеры к игроку:
_cam_obj.cutsceneMode = false;
if (_p != noone) _p.canMove = true;