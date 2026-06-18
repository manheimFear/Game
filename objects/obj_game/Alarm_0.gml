global.autoSaveTimer++;
if (global.autoSaveTimer >= 10 && !global.inMinigame) {
    scr_save_game(3);
    if (instance_exists(oNotebook))
        oNotebook.autoSlotData = scr_get_slot_meta(3);
    global.autoSaveTimer = 0;
}
alarm[0] = room_speed * 60;