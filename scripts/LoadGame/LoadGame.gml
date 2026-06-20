function scr_load_game(slot) {
    var _path = working_directory + "save_slot_" + string(slot) + ".json";
    if (!file_exists(_path)) return false;

    var _f   = file_text_open_read(_path);
    var _str = "";
    while (!file_text_eof(_f)) _str += file_text_readln(_f);
    file_text_close(_f);

    var _d = json_parse(_str);

    global.currentChapter = _d.chapter;
    global.playtime       = _d.playtime;
    global.inventory      = _d.inventory;
    global.flags          = _d.flags;
    global.hasNotebook    = variable_struct_exists(_d, "hasNotebook") ? _d.hasNotebook : false;

    global.loadPlayerX = _d.playerX;
    global.loadPlayerY = _d.playerY;
	global.pickedItems = variable_struct_exists(_d, "pickedItems") ? _d.pickedItems : {};

room_goto(asset_get_index(_d.sceneName));
    return true;
}