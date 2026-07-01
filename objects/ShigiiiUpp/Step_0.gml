if (global.cameraAtTarget && !animStarted) {
    visible = true;
    image_index = 0;
    image_speed = 1;
    animStarted = true;
}
if (global.dialogueWantsAnim) {
    global.dialogueWantsAnim = false;
if (!left_anim_finished)
{
	animation = true;
    left_anim += left_anim_speed;

    if (left_anim >= sprite_get_number(spr_left) - 1)
    {
        left_anim = sprite_get_number(spr_left) - 1;
        left_anim_finished = true;
		animation = false;
    }
}
    dialogueTriggered = false;
}
if (animStarted && image_index >= image_number - 1) {
    image_index = image_number - 1;
    image_speed = 0;
}

if (animStarted && image_index >= image_number - 1 && !dialogueTriggered) {
    
	timer +=1;
	if (timer > 1380)
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
                showingChoices      = false;
                choices             = [];
			}
			dialogueTriggered = true;
            }
        }
    }
}