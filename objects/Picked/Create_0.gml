if (variable_struct_exists(global.pickedItems, itemUniqueId) 
&& variable_struct_get(global.pickedItems, itemUniqueId) == true) {
    instance_destroy();
    exit;
}

// Данные предмета для добавления в инвентарь — задаются в детях через переопределение
itemData = {
    name:             "",
    sprite:           sprite_index,
    shortDesc:        "",
    desc:             "",
    detailSprite:     noone,
    nameDetailSprite: noone,
    descSprite:       noone,
};