if (!variable_global_exists("visitedRooms")) exit;
if (global.inMinigame) exit; // не сохраняем внутри мини-игры

var _roomName = room_get_name(room);
if (!ds_map_exists(global.visitedRooms, _roomName)) {
    ds_map_add(global.visitedRooms, _roomName, true);
    scr_save_game(3);
    if (instance_exists(oNotebook))
        oNotebook.autoSlotData = scr_get_slot_meta(3);
}