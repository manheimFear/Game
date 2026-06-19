/// scr_check_condition(condition)
function scr_check_condition(_cond) {
    if (_cond == "") return true; // нет условия — всегда показывать
    
    var _negate = false;
    var _flagName = _cond;
    if (string_char_at(_cond, 1) == "!") {
        _negate = true;
        _flagName = string_copy(_cond, 2, string_length(_cond) - 1);
    }
    
    var _value = variable_struct_exists(global.flags, _flagName) 
               ? variable_struct_get(global.flags, _flagName) 
               : false;
    
    return _negate ? !_value : _value;
}