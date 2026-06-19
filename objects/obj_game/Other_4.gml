if (!variable_global_exists("visitedRooms")) exit;
if (global.inMinigame) exit; // не сохраняем внутри мини-игры

var _roomName = room_get_name(room);
if (!ds_map_exists(global.visitedRooms, _roomName)) {
    ds_map_add(global.visitedRooms, _roomName, true);
    scr_save_game(3);
var _notify = instance_find(oAutoSaveNotify, 0);
if (_notify != noone) {
    _notify.visible = true;
    _notify.timer = 90; // 1.5 секунды при 60 fps
    _notify.alpha = 0;
}
    if (instance_exists(oNotebook))
        oNotebook.autoSlotData = scr_get_slot_meta(3);
}