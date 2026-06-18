var _player = instance_place(x, y + 32, oPlayerMain);
if (_player == noone) _player = instance_place(x, y - 32, oPlayerMain);

var _dlg = instance_find(oDialogue, 0);

if (_player != noone && keyboard_check_pressed(ord("E"))) {
    if (_dlg != noone && !_dlg.visible) {
        // Начинаем диалог только если он закрыт
        dialogueIndex = 0;
        var _d = dialogues[dialogueIndex];
        with (_dlg) {
            visible = true;
            charName = _d.name;
            charText = _d.text;
            charSprite = _d.sprite;
            textIndex = 1;
            displayText = string_copy(_d.text, 1, 1);
            currentNPC = other.id;
        }
    }
}