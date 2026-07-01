if (!visible) exit;

// ── Если показываются варианты ответа ────────────────────────
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
        dialogueIndex  = _choice.nextIndex;

        if (dialogueIndex >= array_length(currentDialogueList)) {
            visible         = false;
            currentNPC      = noone;
            global.Dialogue = false;
        } else {
            var _d      = currentDialogueList[dialogueIndex];
            charName    = _d.name;
            charSprite  = _d.sprite;

            // Парсим текст с паузами
            var _parsed = scr_prepare_text(_d.text);
            charText    = _parsed.cleanText;
            rawText     = _d.text;
            pausePoints = _parsed.pauses;
            pauseActive = false;
            pauseTimer  = 0;
            textIndex   = 1;
            displayText = string_copy(charText, 1, 1);

            // Проверяем waitForAnim
            waitingForAnim = variable_struct_exists(_d, "waitForAnim") && _d.waitForAnim;
            if (waitingForAnim) {
                global.dialogueWantsAnim = true;
            }

            if (variable_struct_exists(_d, "choices") && array_length(_d.choices) > 0) {
                choices        = _d.choices;
                showingChoices = true;
                selectedChoice = 0;
            }
        }
    }
    exit;
}

// ── Пауза внутри реплики ─────────────────────────────────────
if (pauseActive) {
    pauseTimer--;
    if (pauseTimer <= 0) pauseActive = false;
    exit;
}

// ── Появление текста по буквам ───────────────────────────────
textTimer++;
if (textTimer >= textSpeed) {
    textTimer = 0;
    if (textIndex < string_length(charText)) {
        textIndex++;
        displayText = string_copy(charText, 1, textIndex);

        // Проверяем точки паузы
        for (var _pi = 0; _pi < array_length(pausePoints); _pi++) {
            var _pp = pausePoints[_pi];
            if (_pp.pos == textIndex && !variable_struct_exists(_pp, "used")) {
                variable_struct_set(_pp, "used", true);
                pauseActive = true;
                pauseTimer  = _pp.frames;
                break;
            }
        }
    }
}

// ── Когда текст допечатан и есть choices — включаем выбор ────
var _currentDialogueData = (currentDialogueList != undefined && dialogueIndex < array_length(currentDialogueList))
    ? currentDialogueList[dialogueIndex] : undefined;

var _hasChoicesWaiting = (_currentDialogueData != undefined)
    && variable_struct_exists(_currentDialogueData, "choices")
    && array_length(_currentDialogueData.choices) > 0;

if (_hasChoicesWaiting && textIndex >= string_length(charText)) {
    choices        = _currentDialogueData.choices;
    showingChoices = true;
    selectedChoice = 0;
    exit;
}

// ── Снятие блокировки когда внешняя анимация закончила ───────
if (waitingForAnim && global.cameraAtTarget) {
    waitingForAnim = false;
}

// ── Пропуск анимации текста или переход к следующей фразе ────
if (mouse_check_button_pressed(mb_left) || keyboard_check_pressed(vk_space)) {
    if (textIndex < string_length(charText)) {
        // Допечатать сразу весь текст
        textIndex   = string_length(charText);
        displayText = charText;
    } else if (!waitingForAnim) {
        // Переход к следующей реплике
        dialogueIndex++;

        if (dialogueIndex >= array_length(currentDialogueList)) {
            visible         = false;
            currentNPC      = noone;
            global.Dialogue = false;
        } else {
            var _d      = currentDialogueList[dialogueIndex];
            charName    = _d.name;
            charSprite  = _d.sprite;

            // Парсим текст с паузами
            var _parsed = scr_prepare_text(_d.text);
            charText    = _parsed.cleanText;
            rawText     = _d.text;
            pausePoints = _parsed.pauses;
            pauseActive = false;
            pauseTimer  = 0;
            textIndex   = 1;
            displayText = string_copy(charText, 1, 1);

            // Проверяем waitForAnim у новой реплики
            waitingForAnim = variable_struct_exists(_d, "waitForAnim") && _d.waitForAnim;
            if (waitingForAnim) {
                global.dialogueWantsAnim = true;
            }
        }
    }
    // Если waitingForAnim == true — клик/пробел игнорируется
}

global.Dialogue = visible;