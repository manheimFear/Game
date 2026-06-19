dialogueIndex = 0;
dialogues = [
    {name: "Лиса", text: "Ты согласен помочь?", sprite: NPC, condition: "",
     choices: [
         {text: "Да, конечно", flagToSet: "agreedToHelp", flagValue: true, nextIndex: 2},
         {text: "Нет, не сейчас", flagToSet: "agreedToHelp", flagValue: false, nextIndex: 4}
     ]},
];
global.Dialogue = false;
showingChoices = false;