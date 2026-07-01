/// scr_prepare_text(rawText)
/// Парсит текст с маркерами паузы {N} где N — секунды
/// Возвращает структуру {cleanText, pauses}
/// pauses = [{pos: N, frames: F, used: false}, ...]
function scr_prepare_text(_raw) {
    var _clean  = "";
    var _pauses = [];
    var _i      = 1;
    while (_i <= string_length(_raw)) {
        var _c = string_copy(_raw, _i, 1);
        if (_c == "{") {
            var _end = string_pos_ext("}", _raw, _i);
            if (_end > _i) {
                var _seconds = real(string_copy(_raw, _i + 1, _end - _i - 1));
                var _frames  = round(_seconds * game_get_speed(gamespeed_fps));
                array_push(_pauses, {pos: string_length(_clean), frames: _frames, used: false});
                _i = _end + 1;
                continue;
            }
        }
        _clean += _c;
        _i++;
    }
    return {cleanText: _clean, pauses: _pauses};
}