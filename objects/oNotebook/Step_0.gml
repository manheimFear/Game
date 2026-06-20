if (!visible) exit;

// Step event, в блоке анимации:
if (animState == "opening" || animState == "page_transition") {
    animTimer++;
    if (animTimer >= animFrameDelay) {
        animTimer = 0;
        animFrame++;
        if (animFrame >= sprite_get_number(animSprite)) {
            currentPage = pendingPage;
            animState   = "none";
        }
    }
    exit;
}

// ГЛАВНОЕ ИСПРАВЛЕНИЕ: GUI-координаты мыши вместо мировых
var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);

// ── ГЛАВНОЕ МЕНЮ ──
if (currentPage == 0) {
    if (keyboard_check_pressed(ord("W")) || keyboard_check_pressed(vk_up))
        selectedButton = (selectedButton - 1 + numButtons) mod numButtons;
    if (keyboard_check_pressed(ord("S")) || keyboard_check_pressed(vk_down))
        selectedButton = (selectedButton + 1) mod numButtons;

    for (var i = 0; i < numButtons; i++) {
        var b = btnAreas[i];
        if (_mx >= b.x1 && _mx <= b.x2 && _my >= b.y1 && _my <= b.y2)
            selectedButton = i;
    }

    if (mouse_check_button_pressed(mb_left) || keyboard_check_pressed(vk_return)) {
        var doAction = keyboard_check_pressed(vk_return);
        if (!doAction) {
            var b = btnAreas[selectedButton];
            doAction = (_mx >= b.x1 && _mx <= b.x2 && _my >= b.y1 && _my <= b.y2);
        }
        if (doAction) {
            switch (selectedButton) {
           case 0:
    visible           = false;
    global.menuOpen   = false;
    global.gamePaused = false;
    instance_activate_all();
    break;
             case 1:
    currentPage   = 3;
    confirmAction = -1;
    // Перечитать слоты при каждом открытии страницы:
    for (var _si = 0; _si < 3; _si++)
        saveSlotsData[_si] = scr_get_slot_meta(_si);
    break;
            case 2:
    animState   = "page_transition";
    animSprite  = sNotebookFlipAnim; // анимация переключения страницы
    animTimer   = 0;
	animFrame      = 0;
    pendingPage = 2;
    selectedItem = -1; showDetail = false; itemPage = 0;
    break;
                case 3: currentPage = 1; break;
                case 4: game_end(); break;
            }
        }
    }

    if (keyboard_check_pressed(vk_escape)) {
visible          = false;
global.menuOpen  = false;
instance_activate_all();
global.gamePaused = false;

    }
}

// ── НАСТРОЙКИ ──
else if (currentPage == 1) {

   if (mouse_check_button_pressed(mb_left)) {

    // Ползунок
    var dotX = volX1 + volume * (volX2 - volX1);
    if (abs(_mx - dotX) <= volDotR + 8 && abs(_my - volY) <= volDotR + 8)
        isDragging = true;

    // ── Диалог подтверждения (если активен — только он ──────────
   

    // ── Стикер: ОТКРЫТЬ -или- выбрать разрешение (не оба!) ──────
    else if (!showSticker) {
        // Стикер закрыт → проверяем кнопку открытия
        var _b = resBtnOpen;
        if (_mx >= _b.x && _mx <= _b.x + _b.w && _my >= _b.y && _my <= _b.y + _b.h)
            showSticker = true;
    }
    else {
        // Стикер открыт → проверяем кнопки разрешений
        for (var i = 0; i < 3; i++) {
            var _b = resBtnItems[i];
            if (_mx >= _b.x && _mx <= _b.x + _b.w && _my >= _b.y && _my <= _b.y + _b.h) {
                resIndex = _b.resIdx;
                showSticker = false;
                window_set_size(resWidths[resIndex], resHeights[resIndex]);
                surface_resize(application_surface, resWidths[resIndex], resHeights[resIndex]);
                display_set_gui_size(1280, 720);
                break;
            }
        }
    }

    // Кнопка «Назад» (работает в любом состоянии)
    if (_mx >= backX1 && _mx <= backX2 && _my >= backY1 && _my <= backY2) {
        currentPage  = 0;
        showSticker = false;
    }
}

    if (mouse_check_button(mb_left) && isDragging) {
        volume = clamp((_mx - volX1) / (volX2 - volX1), 0, 1);
        audio_master_gain(volume);
    }
    if (mouse_check_button_released(mb_left)) isDragging = false;

    if (keyboard_check_pressed(vk_escape)) {
        if (showSticker) showSticker = false;
        else             currentPage = 0;
    }
}

// ── ВЕЩИ ──
else if (currentPage == 2) {
    var startIdx = itemPage * 8;
    var maxPage  = max(0, (array_length(global.inventory) - 1) div 8);
    var _itemOnRight = (showDetail && selectedItem >= 0 && (selectedItem mod 8) >= 4);

    if (keyboard_check_pressed(ord("A")) || keyboard_check_pressed(vk_left))
        if (itemPage > 0) { itemPage--; selectedItem = -1; showDetail = false; }
    if (keyboard_check_pressed(ord("D")) || keyboard_check_pressed(vk_right))
        if (itemPage < maxPage) { itemPage++; selectedItem = -1; showDetail = false; }

    if (keyboard_check_pressed(ord("W")) || keyboard_check_pressed(vk_up))
        if (selectedItem > 0) { selectedItem--; showDetail = true; itemPage = selectedItem div 8; }
    if (keyboard_check_pressed(ord("S")) || keyboard_check_pressed(vk_down))
        if (selectedItem < array_length(global.inventory) - 1) {
            selectedItem++; showDetail = true; itemPage = selectedItem div 8;
        }

    if (mouse_check_button_pressed(mb_left)) {
        for (var i = 0; i < 8; i++) {
            if (!_itemOnRight && showDetail && i >= 4) continue;
            if (_itemOnRight  && showDetail && i <  4) continue;
            var idx = startIdx + i;
            if (idx < array_length(global.inventory)) {
                if (_mx >= slotX[i] && _mx <= slotX[i] + slotSize &&
                    _my >= slotY[i] && _my <= slotY[i] + slotSize) {
                    selectedItem = idx;
                    showDetail = true;
                }
            }
        }
    }

    if (keyboard_check_pressed(vk_escape)) {
        if (showDetail) { showDetail = false; selectedItem = -1; }
        else currentPage = 0;
    }
}
//Save Page
else if (currentPage == 3) {

    if (mouse_check_button_pressed(mb_left)) {

        // ── Диалог подтверждения БЛОКИРУЕТ ВСЁ ──────────────
        // Этот блок идёт ПЕРВЫМ и при срабатывании не даёт
        // выполниться ничему ниже через else if
        if (confirmAction >= 0) {
            var _yes = confirmYesBtnArea;
            var _no  = confirmNoBtnArea;
            if (_mx >= _yes.x && _mx <= _yes.x + _yes.w &&
                _my >= _yes.y && _my <= _yes.y + _yes.h) {
                scr_save_game(confirmAction);
                saveSlotsData[confirmAction] = scr_get_slot_meta(confirmAction);
                confirmAction = -1;
            }
            else if (_mx >= _no.x && _mx <= _no.x + _no.w &&
                     _my >= _no.y && _my <= _no.y + _no.h) {
                confirmAction = -1;
            }
            // Клик в любом другом месте — ничего не делаем
            // Все else if ниже НЕ выполняются пока confirmAction >= 0
        }

        // ── Табличка «?» ─────────────────────────────────────
        else if (showAutoHelp) {
            // Открыта табличка — любой клик закрывает её,
            // больше ничего не срабатывает
            showAutoHelp = false;
        }

        // ── Обычная логика (только если нет диалога и таблички) ──
        else {

            // Кнопка «?»
            var _hb = autoHelpBtnArea;
            if (_mx >= _hb.x && _mx <= _hb.x + _hb.w &&
                _my >= _hb.y && _my <= _hb.y + _hb.h) {
                showAutoHelp = true;
            }

            // Слоты сохранений
            else {
                var _clickedSlot = false;
                for (var i = 0; i < 3; i++) {
                    var _sa    = saveSlotAreas[i];
                    var _ba    = saveBtnAreas[i];
                    var _sd    = saveSlotsData[i];
                    var _empty = (_sd == noone);

                    var _onSlot = (_mx >= _sa.x && _mx <= _sa.x + _sa.w &&
                                   _my >= _sa.y && _my <= _sa.y + _sa.h);
                    var _onBtn  = (_mx >= _ba.x && _mx <= _ba.x + _ba.w &&
                                   _my >= _ba.y && _my <= _ba.y + _ba.h);

                    if (_onSlot) {
                        _clickedSlot = true;
                        if (_onBtn) {
                            if (_empty) {
                                scr_save_game(i);
                                saveSlotsData[i] = scr_get_slot_meta(i);
                            } else {
                                confirmAction = i;
                            }
                        } else if (!_empty) {
                            scr_load_game(i); 
visible          = false;
global.menuOpen  = false;
instance_activate_all();
global.gamePaused = false;

                        }
                        break;
                    }
                }

                if (!_clickedSlot) {
                    var _aa = autoSlotArea;
                    if (autoSlotData != noone &&
                        _mx >= _aa.x && _mx <= _aa.x + _aa.w &&
                        _my >= _aa.y && _my <= _aa.y + _aa.h) {
                        scr_load_game(3);
visible          = false;
global.menuOpen  = false;
instance_activate_all();
global.gamePaused = false;

                    }

                    // Назад
                    if (_mx >= backX1 && _mx <= backX2 &&
                        _my >= backY1 && _my <= backY2) {
                        currentPage   = 0;
                        confirmAction = -1;
                        showAutoHelp  = false;
                    }
                }
            }
        }
    }

    // ESC тоже уважает приоритет
    if (keyboard_check_pressed(vk_escape)) {
        if (confirmAction >= 0)  confirmAction = -1;
        else if (showAutoHelp)   showAutoHelp  = false;
        else                     currentPage   = 0;
    }
}




