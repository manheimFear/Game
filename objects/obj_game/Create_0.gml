// ── Глобальные переменные игры ────────────────────────────
global.inventory       = [];
global.playtime        = 0;
global.currentChapter  = "1";
global.loadPlayerX     = -1;
global.loadPlayerY     = -1;
global.visitedRooms    = ds_map_create();
global.autoSaveTimer   = 0;
global.menuOpen        = false;
global.Dialogue        = false;  // ← добавлено

global.flags = {
    talkedToSheriff:   false,
    foundKey:          false,
    chapter2Unlocked:  false,
    courtEvidenceUsed: ""
};

alarm[0] = room_speed * 60;
alarm[1] = room_speed;
global.inMinigame = false;
global.gamePaused = false;
global.hasNotebook = false;
global.pickedItems = {}; // ключ = уникальное имя предмета, значение = true