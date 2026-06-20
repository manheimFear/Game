var _player = instance_place(x, y + 32, oPlayerMain);
if (_player == noone) _player = instance_place(x, y - 32, oPlayerMain);

var _dlg = instance_find(oDialogue, 0);

if (_player != noone && keyboard_check_pressed(ord("E"))) {
    if (_dlg != noone && !_dlg.visible) {
        var _validDialogues = [];
        for (var i = 0; i < array_length(dialogues); i++) {
            if (scr_check_condition(dialogues[i].condition)) {
                array_push(_validDialogues, dialogues[i]);
            }
        }

      if (array_length(_validDialogues) > 0) {
    var _d = _validDialogues[0];
    with (_dlg) {
        visible             = true;
        charName            = _d.name;
        charText            = _d.text;
        charSprite          = _d.sprite;
        textIndex           = 1;
        displayText         = string_copy(_d.text, 1, 1);
        currentNPC          = other.id;
        currentDialogueList = _validDialogues;
        dialogueIndex       = 0;
        showingChoices      = false; // ← всегда false при старте, даже если choices есть
        choices             = [];    // очищаем
    }
}
    }
}