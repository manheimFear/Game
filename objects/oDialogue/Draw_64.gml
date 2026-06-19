if (!visible) exit;

var _guiW = display_get_gui_width();
var _guiH = display_get_gui_height();

// Спрайт персонажа за окном
if (DialogueSprite != -1) {
    draw_sprite_stretched(DialogueSprite, 0, 0, 0, _guiW, _guiH);
}

// Окно диалога
draw_sprite_stretched(DialogueWindow, 0, 0, 0, _guiW, _guiH);

// Имя
draw_set_font(global.fMyFont);
if (nameSprite != -1) {
    draw_sprite(nameSprite, 0, 30, 560);
} else {
    draw_set_colour(c_black);
    draw_text(30, 590, charName);
}

// Текст
draw_set_colour(c_black);
var _textX = 300;
var _textY = 600;
var _maxWidth = 900;
var _lineHeight = 30;
var _words = string_split(displayText, " ");
var _line = "";
var _currentY = _textY;

for (var w = 0; w < array_length(_words); w++) {
    var _testLine = _line == "" ? _words[w] : _line + " " + _words[w];
    if (string_width(_testLine) > _maxWidth) {
        var _offsetX = 0;
        for (var i = 1; i <= string_length(_line); i++) {
            var _char = string_copy(_line, i, 1);
            draw_text(_textX + _offsetX, _currentY, _char);
            _offsetX += string_width(_char);
        }
        _currentY += _lineHeight;
        _line = _words[w];
    } else {
        _line = _testLine;
    }
}

// Последняя строка
var _offsetX = 0;
for (var i = 1; i <= string_length(_line); i++) {
    var _char = string_copy(_line, i, 1);
    draw_text(_textX + _offsetX, _currentY, _char);
    _offsetX += string_width(_char);
}

if (showingChoices) {
    choiceAreas = []; // пересоздаём каждый кадр для актуальных координат
    var _startY = 400; // подбери под свой UI
    var _boxHeight = 50;
    var _boxSpacing = 60;
    
    for (var i = 0; i < array_length(choices); i++) {
        var _y = _startY + i * _boxSpacing;
        var _spr = (i == selectedChoice) ? choiceBoxSelectedSprite : choiceBoxSprite;
        
        draw_sprite_stretched(_spr, 0, 200, _y, 600, _boxHeight);
        
        draw_set_font(fMyFont);
        draw_set_colour((i == selectedChoice) ? c_yellow : c_white);
        draw_text(220, _y + 15, choices[i].text);
        
        // Сохраняем зону для проверки мыши в Step
        array_push(choiceAreas, {x: 200, y: _y, w: 600, h: _boxHeight});
    }
}