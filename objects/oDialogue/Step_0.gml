if (!visible) exit;

// Появление букв по одной
textTimer++;
if (textTimer >= textSpeed) {
    textTimer = 0;
    if (textIndex < string_length(charText)) {
        textIndex++;
        displayText = string_copy(charText, 1, textIndex);
    }
}

// Пропуск анимации или следующая фраза
if (mouse_check_button_pressed(mb_left) || keyboard_check_pressed(vk_space)) {
    if (textIndex < string_length(charText)) {
        // Показываем весь текст сразу
        textIndex = string_length(charText);
        displayText = charText;
    } else {
        // Переходим к следующей фразе
        if (currentNPC != noone && instance_exists(currentNPC)) {
            currentNPC.dialogueIndex++;
            if (currentNPC.dialogueIndex >= array_length(currentNPC.dialogues)) {
                visible = false;
                currentNPC.dialogueIndex = 0;
                currentNPC = noone;
            } else {
                var _d = currentNPC.dialogues[currentNPC.dialogueIndex];
                charName = _d.name;
                charText = _d.text;
                charSprite = _d.sprite;
                textIndex = 1;
                displayText = string_copy(charText, 1, 1);
            }
        } else {
            visible = false;
        }
    }
}
if (visible = false)
{
	global.Dialogue = false;
}
else
if (visible)
{
	global.Dialogue = true;
}