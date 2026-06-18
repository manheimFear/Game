if (teleportTimer > 0) {
    teleportTimer--;
    if (teleportTimer == 0) {
        room_goto(asset_get_index(Room));
    }
}