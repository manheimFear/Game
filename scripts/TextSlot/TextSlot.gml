/// scr_get_slot_meta(slot) — только чтение для отображения в меню
function scr_get_slot_meta(slot) {
    var _path = working_directory + "save_slot_" + string(slot) + ".json";
    if (!file_exists(_path)) return noone;
    var _f   = file_text_open_read(_path);
    var _str = "";
    while (!file_text_eof(_f)) _str += file_text_readln(_f);
    file_text_close(_f);
    return json_parse(_str);
}