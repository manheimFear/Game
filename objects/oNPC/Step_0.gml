var _player = instance_place(x, y + 32, oPlayerMain);
if (_player == noone) _player = instance_place(x, y - 32, oPlayerMain);

var _dlg = instance_find(oDialogue, 0);

if (_player != noone && keyboard_check_pressed(ord("E"))) {
    if (_dlg != noone && !_dlg.visible) {
        // Собираем только доступные реплики
        var _validDialogues = [];
        for (var i = 0; i < array_length(dialogues); i++) {
            if (scr_check_condition(dialogues[i].condition)) {
                array_push(_validDialogues, dialogues[i]);
            }
        }
        
        dialogueIndex = 0;
        var _d = _validDialogues[dialogueIndex];
        with (_dlg) {
            visible = true;
            charName = _d.name;
            charText = _d.text;
            charSprite = _d.sprite;
            textIndex = 1;
            displayText = string_copy(_d.text, 1, 1);
            currentNPC = other.id;
            currentDialogueList = _validDialogues; // сохраняем отфильтрованный список
        }
    }
}

if (showingChoices) {
    if (keyboard_check_pressed(ord("W")) || keyboard_check_pressed(vk_up))
        selectedChoice = (selectedChoice - 1 + array_length(choices)) mod array_length(choices);
    if (keyboard_check_pressed(ord("S")) || keyboard_check_pressed(vk_down))
        selectedChoice = (selectedChoice + 1) mod array_length(choices);

    // Наведение мышью (если есть choiceAreas с координатами)
    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);
    for (var i = 0; i < array_length(choiceAreas); i++) {
        var _a = choiceAreas[i];
        if (_mx >= _a.x && _mx <= _a.x + _a.w && _my >= _a.y && _my <= _a.y + _a.h) {
            selectedChoice = i;
        }
    }

    if (keyboard_check_pressed(vk_enter) || mouse_check_button_pressed(mb_left)) {
        var _choice = choices[selectedChoice];
        
        // Применяем флаг, если указан
        if (_choice.flagToSet != "") {
            variable_struct_set(global.flags, _choice.flagToSet, _choice.flagValue);
        }
        
        showingChoices = false;
        // Переход к следующей реплике по nextIndex
        dialogueIndex = _choice.nextIndex;
        var _d = currentNPC.dialogues[dialogueIndex]; // или currentDialogueList
        charName = _d.name;
        charText = _d.text;
        textIndex = 1;
        displayText = string_copy(_d.text, 1, 1);
        
        if (variable_struct_exists(_d, "choices") && array_length(_d.choices) > 0) {
            choices = _d.choices;
            showingChoices = true; // следующая реплика тоже с выбором
        }
    }
}