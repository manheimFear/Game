global.autoSaveTimer++;
if (global.autoSaveTimer >= 10 && !global.inMinigame) {
 scr_save_game(3);
var _notify = instance_find(oAutoSaveNotify, 0);
if (_notify != noone) {
    _notify.visible = true;
    _notify.timer = 90; // 1.5 секунды при 60 fps
    _notify.alpha = 0;
}
    if (instance_exists(oNotebook))
        oNotebook.autoSlotData = scr_get_slot_meta(3);
    global.autoSaveTimer = 0;
}
alarm[0] = room_speed * 60;