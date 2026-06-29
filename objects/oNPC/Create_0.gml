depth = -8;
dialogueIndex = 0;
dialogues = [
    {name: "Лиса", text: "Ты согласен помочь?", sprite: NPC, condition: "!agreedToHelp",
     choices: [
         {text: "Да, конечно", flagToSet: "agreedToHelp", flagValue: true, nextIndex: 2},
         {text: "Нет, не сейчас", flagToSet: "agreedToHelp", flagValue: false, nextIndex: 4}
     ],
	name: "Лиса", text: "Спасибо!", sprite: NPC, condition: "agreedToHelp" },
];
global.Dialogue = false;
showingChoices = false;