depth = -4;
animStarted = false;
dialogueTriggered = false;
with (oDialogue)
{
	_dialogue_sprite = DialogueWindow2;
}
dialogueIndex = 0;
dialogues = [
    {name: "???", text: "Как же я устал от этого!{2}...что ты держишь? Это блокнот...", sprite: DialogueSprite, condition: ""},
    {name: "???", text: "Ах!", sprite: DialogueSprite, condition: "", waitForAnim: true}
];
global.Dialogue = false;
showingChoices = false;
timer = 0;
left_anim = 0;
left_anim_speed = 0.2;
left_anim_finished = false;
animation = false;