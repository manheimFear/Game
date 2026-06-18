if (isEternal) exit;

if (!activated) {
    if (wasReset) {
        // Уже проходил цикл — сразу вечный
        isEternal = true;
        sprite_index = checkpointend;
        global.previousCheckpoint = global.activeCheckpoint;
        global.activeCheckpoint = id;
        global.deathCount = 0;
    } else {
        // Первое касание
        activated = true;
        deathsAtThisCheckpoint = 0;
        if (global.activeCheckpoint != noone && global.activeCheckpoint != id) {
            global.activeCheckpoint.isEternal = true;
            global.activeCheckpoint.sprite_index = checkpointend;
        }
        global.previousCheckpoint = global.activeCheckpoint;
        global.activeCheckpoint = id;
        global.deathCount = 0;
        sprite_index = checkpointfull;
    }
}

// Обновляем спрайт в зависимости от смертей
if (activated && !isEternal && global.activeCheckpoint == id) {
    if (deathsAtThisCheckpoint == 1) {
        sprite_index = checkpointunfull;
    } else if (deathsAtThisCheckpoint == 2) {
        sprite_index = checkpointdead;
    }
}