if (global.cameraAtTarget && !animStarted) {
    visible = true;
    image_index = 0;
    image_speed = 1;
    animStarted = true;
}

if (animStarted && image_index >= image_number - 1) {
    image_index = image_number - 1; // последний реальный кадр спрайта
    image_speed = 0;
}
if (image_index == 22)
{


var _dlg = instance_find(oDialogue, 0);
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
