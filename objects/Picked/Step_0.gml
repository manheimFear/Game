if (!variable_global_exists("pickedItems")) {
    global.pickedItems = {};
}
if (instance_place(x, y, oPlayerParent)) {
    if (keyboard_check_pressed(ord("E"))) {
        array_push(global.inventory, itemData);
        variable_struct_set(global.pickedItems, itemUniqueId, true);
        instance_destroy();
    }
}