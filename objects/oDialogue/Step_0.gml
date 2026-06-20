if (!visible) exit;

// ── Если показываются варианты ответа ──────────────────────
if (showingChoices) {
    if (keyboard_check_pressed(ord("W")) || keyboard_check_pressed(vk_up))
        selectedChoice = (selectedChoice - 1 + array_length(choices)) mod array_length(choices);
    if (keyboard_check_pressed(ord("S")) || keyboard_check_pressed(vk_down))
        selectedChoice = (selectedChoice + 1) mod array_length(choices);

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

        if (_choice.flagToSet != "") {
            variable_struct_set(global.flags, _choice.flagToSet, _choice.flagValue);
        }

        showingChoices = false;
        dialogueIndex   = _choice.nextIndex;

        if (dialogueIndex >= array_length(currentDialogueList)) {
            visible    = false;
            currentNPC = noone;
            global.Dialogue = false;
        } else {
            var _d = currentDialogueList[dialogueIndex];
            charName    = _d.name;
            charText    = _d.text;
            charSprite  = _d.sprite;
            textIndex   = 1;
            displayText = string_copy(_d.text, 1, 1);

            if (variable_struct_exists(_d, "choices") && array_length(_d.choices) > 0) {
                choices        = _d.choices;
                showingChoices = true;
                selectedChoice = 0;
            }
        }
    }
    exit; // блокируем обычный текстовый код пока идёт выбор
}

// ── Появление текста по буквам ───────────────────────────────
textTimer++;
if (textTimer >= textSpeed) {
    textTimer = 0;
    if (textIndex < string_length(charText)) {
        textIndex++;
        displayText = string_copy(charText, 1, textIndex);
    }
}

// ── Когда текст полностью напечатан и есть choices — включаем выбор ──
var _currentDialogueData = (currentDialogueList != undefined && dialogueIndex < array_length(currentDialogueList))
    ? currentDialogueList[dialogueIndex] : undefined;

var _hasChoicesWaiting = (_currentDialogueData != undefined)
    && variable_struct_exists(_currentDialogueData, "choices")
    && array_length(_currentDialogueData.choices) > 0;

if (_hasChoicesWaiting && textIndex >= string_length(charText)) {
    // Текст допечатан, у реплики есть варианты — включаем выбор, не ждём клика
    choices        = _currentDialogueData.choices;
    showingChoices = true;
    selectedChoice = 0;
    exit;
}

// ── Пропуск анимации текста или переход к следующей фразе ───
if (mouse_check_button_pressed(mb_left) || keyboard_check_pressed(vk_space)) {
    if (textIndex < string_length(charText)) {
        textIndex = string_length(charText);
        displayText = charText;
    } else {
        dialogueIndex++;

        if (dialogueIndex >= array_length(currentDialogueList)) {
            visible    = false;
            currentNPC = noone;
            global.Dialogue = false;
        } else {
            var _d = currentDialogueList[dialogueIndex];
            charName    = _d.name;
            charText    = _d.text;
            charSprite  = _d.sprite;
            textIndex   = 1;
            displayText = string_copy(_d.text, 1, 1);
        }
    }
}

global.Dialogue = visible;