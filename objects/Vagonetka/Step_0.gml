if (instance_place(x, y, oPlayer)) {
    if (keyboard_check_pressed(ord("E"))) {
        var nb = instance_find(oNotebook, 0);
        if (nb != noone) {
            array_push(global.inventory, {
                name:             "",
                sprite:           sKeyItem,
                shortDesc:        "Ключ от чего-то...",
                desc:             "",
                detailSprite:     Sticker, // ← нарисуй стикер и поставь сюда свой спрайт
                nameDetailSprite: noone, // ← спрайт с нарисованным названием (или noone)
                descSprite:       noone, // ← спрайт с нарисованным описанием (или noone)
            });
        }
        image_index = 1;
    }
}