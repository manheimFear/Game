/// scr_save_game(slot)
function scr_save_game(slot) {
    // Защита: если глобалки не объявлены — не падаем
    var _inv   = variable_global_exists("inventory")      ? global.inventory      : [];
    var _flags = variable_global_exists("flags")          ? global.flags          : {};
    var _time  = variable_global_exists("playtime")       ? global.playtime       : 0;
    var _chap  = variable_global_exists("currentChapter") ? global.currentChapter : "—";

    // Позиция игрока (если объект существует)
    var _px = instance_exists(oPlayerParent) ? oPlayerParent.x : 0;
    var _py = instance_exists(oPlayerParent) ? oPlayerParent.y : 0;
    var _data = {
        exists:      true,
        chapter:     global.currentChapter,
        sceneName:   room_get_name(room),
        timestamp:   string(current_day) + "." + string(current_month) + " "
                   + string(current_hour) + ":" + string_format(current_minute, 2, 0),
        playtime:    global.playtime,
        playerX:     instance_exists(oPlayerParent) ? oPlayerParent.x : 0,
        playerY:     instance_exists(oPlayerParent) ? oPlayerParent.y : 0,
        inventory:   global.inventory,
        flags:       global.flags,
        hasNotebook: global.hasNotebook
    };
    var _f = file_text_open_write(working_directory + "save_slot_" + string(slot) + ".json");
    file_text_write_string(_f, json_stringify(_data));
    file_text_close(_f);
	
}
