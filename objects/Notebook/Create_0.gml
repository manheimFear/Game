

event_inherited(); // вызывает Create родителя — там сработает проверка pickedItems
itemUniqueId = "notebook"; // уникальный ID для этого конкретного инстанса
// Переопределяем данные именно для предмета-блокнота:
itemData.name             = "Блокнот";
itemData.sprite           = sprite_index; // или конкретный спрайт блокнота-предмета
itemData.shortDesc        = "Записная книжка";
itemData.desc             = "";
itemData.detailSprite     = noone;
itemData.nameDetailSprite = noone;
itemData.descSprite       = noone;

// Проверка "уже подобран"
if (!variable_global_exists("pickedItems")) {
    global.pickedItems = {};
}
if (variable_struct_exists(global.pickedItems, itemUniqueId) 
    && variable_struct_get(global.pickedItems, itemUniqueId) == true) {
    instance_destroy();
}