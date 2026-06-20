itemUniqueId = "notebook"; // уникальный ID для этого конкретного инстанса

event_inherited(); // вызывает Create родителя — там сработает проверка pickedItems

// Переопределяем данные предмета (после event_inherited, чтобы itemData уже существовал)
itemData.name             = "Загадочный листок";
itemData.sprite           = sKeyItem;
itemData.shortDesc        = "Ключ от чего-то...";
itemData.desc             = "";
itemData.detailSprite     = Sticker;
itemData.nameDetailSprite = noone;
itemData.descSprite       = noone;