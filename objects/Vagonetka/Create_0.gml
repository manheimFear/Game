depth = 1
draw = false;
g = 0;


event_inherited(); // выполнит Create родителя — установит itemData с дефолтами
itemUniqueId = "letter_room6_01"; // твой уникальный ID
// Переопределяем данные предмета
itemData.name             = "Загадочный листок";
itemData.sprite           = sKeyItem;
itemData.shortDesc        = "Что-то написано...";
itemData.desc             = "";
itemData.detailSprite     = Sticker;
itemData.nameDetailSprite = noone;
itemData.descSprite       = noone;

// ── Проверка "уже подобран" — теперь здесь, в самом конце ребёнка ──
if (!variable_global_exists("pickedItems")) {
    global.pickedItems = {};
}
if (variable_struct_exists(global.pickedItems, itemUniqueId) 
    && variable_struct_get(global.pickedItems, itemUniqueId) == true) {
    instance_destroy();
}