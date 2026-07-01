visible = false;
charName = "";
charText = "";
charSprite = DialogueSprite;
textIndex = 0;
textSpeed = 4;
textTimer = 0;
displayText = "";
currentNPC = noone;
nameSprite = -1;
choices = [];
showingChoices = false;
selectedChoice = 0;
choiceBoxSprite = sChoiceBoxNormal;
choiceBoxSelectedSprite = sChoiceBoxSelected;
choiceAreas = [];
currentDialogueList = [];
dialogueIndex = 0;
_dialogue_sprite = DialogueWindow;

// Паузы внутри реплики
pauseTimer  = 0;
pauseActive = false;
rawText     = "";
pausePoints = [];

// Блокировка перехода до конца анимации
waitingForAnim = false;

// Глобальный сигнал внешнему объекту запустить анимацию
global.dialogueWantsAnim = false;