if (!visible) exit;

var gW = display_get_gui_width();
var gH = display_get_gui_height();

// ── ГЛАВНОЕ МЕНЮ ──
if (currentPage == 0) {
    var spr = [sMenuContinue, sMenuSave, sMenuItems, sMenuSettings, sMenuLeave];
    draw_sprite_stretched(spr[selectedButton], 0, 0, 0, gW, gH);
}

// ── НАСТРОЙКИ ──
else if (currentPage == 1) {

    // ── 1. Фон настроек ───────────────────────────────────────
    draw_sprite_stretched(sSettingsPage, 0, 0, 0, gW, gH);

    // ── 2. Полноэкранный оверлей разрешения ───────────────────
    // Спрайт 1280×720 рисуется с (0,0) и перекрывает базовый фон.
    // resIndex == 0 → нет оверлея; 1 → Window1536; 2 → Window1920.
    if (resIndex > 0 && sprite_exists(resOverlaySprites[resIndex])) {
        draw_sprite(resOverlaySprites[resIndex], 0, 0, 0);
        // draw_sprite рисует в натуральный размер с начала координат —
        // никакого растяжения, никакого смещения.
    }

    // ── 3. Ползунок громкости ─────────────────────────────────
    var dotX = volX1 + volume * (volX2 - volX1);

    // Серая фоновая полоса (кодом)


    // Красная полоса: рисуем ТОЛЬКО левую часть спрайта до dotX.
    // draw_sprite_part(sprite, frame, src_left, src_top, ширина, высота, x, y)
    //   src_left / src_top = откуда начинать внутри спрайта (всегда 0, 0)
    //   ширина = dotX  → берём ровно столько пикселей, сколько дошёл ползунок
    //   x, y   = 0, 0  → рисуем с левого верхнего угла экрана
    // Поскольку спрайт 1280×720 и GUI тоже 1280×720, координаты совпадают.
    if (sprite_exists(sVolRedLine)) {
        draw_sprite_part(sVolRedLine, 0, 0, 0, dotX, 720, 0, 0);
    } 

    // Точка ползунка (рисуется поверх полосы)
    if (sprite_exists(SoundDot) && sprite_get_width(SoundDot) > 4) {
        draw_sprite_ext(SoundDot, 0, dotX, volY, 1, 1, 0, c_white, 1);
    } else {
        draw_set_colour(c_white); draw_circle(dotX, volY, volDotR, false);
        draw_set_colour(c_red);   draw_circle(dotX, volY, volDotR - 3, false);
    }

    // ── 4. Кнопка открытия стикера (визуальная часть) ─────────
    // sDropdownClosed — спрайт самой кнопки/области выбора разрешения.
    // Рисуем ровно по размеру resBtnOpen (без текста поверх).

    // ТЕКСТ ТЕКУЩЕГО РАЗРЕШЕНИЯ БОЛЬШЕ НЕ РИСУЕТСЯ

    // ── 5. Жёлтый стикер разрешений ──────────────────────────
    // Рисуется поверх всего. Позиция: stickerX / stickerY (в Create).
    if (showSticker && sprite_exists(sStickerRes)) {
        draw_sprite(sStickerRes, 0, stickerX, stickerY);
    }

    // ── 6. Отладочные красные рамки ───────────────────────────
    // Показывают зоны нажатия. Убери (debugShowBoxes = false), когда
    // закончишь подбирать координаты.
    if (debugShowBoxes) {
        draw_set_alpha(0.4);
        draw_set_colour(c_red);

        // Кнопка открытия стикера
        var _b = resBtnOpen;
        draw_rectangle(_b.x, _b.y, _b.x + _b.w, _b.y + _b.h, false);

        // Три кнопки разрешений (видны всегда, чтобы проще настраивать)
        for (var i = 0; i < 3; i++) {
            var _bi = resBtnItems[i];
            draw_rectangle(_bi.x, _bi.y, _bi.x + _bi.w, _bi.y + _bi.h, false);
        }

        draw_set_alpha(1);
        draw_set_colour(c_white); // сбросить цвет
    }
}

// ── ВЕЩИ ──
else if (currentPage == 2) {
    var _itemOnRight = (showDetail && selectedItem >= 0 && (selectedItem mod 8) >= 4);

    // Фон
    if (showDetail) {
        if (_itemOnRight && sprite_exists(sItemDetailReversed))
            draw_sprite_stretched(sItemDetailReversed, 0, 0, 0, gW, gH);
        else
            draw_sprite_stretched(sItemDetail, 0, 0, 0, gW, gH);
    } else {
        draw_sprite_stretched(sItemsPage, 0, 0, 0, gW, gH);
    }

    // Позиция зоны детали
    var _dx = _itemOnRight ? detailXR : detailX;
    var _dy = _itemOnRight ? detailYR : detailY;
    var _dw = _itemOnRight ? detailWR : detailW;
    var _dh = _itemOnRight ? detailHR : detailH;

    var startIdx = itemPage * 8;

// ── Счётчик страниц ───────────────────────────────────────────
// Все настройки — в Create:
//   counterX / counterY — координаты
//   counterFont         — шрифт (global.fMyFont, fAnotherFont, …)
//   counterCol          — цвет   (c_black, c_white, make_colour_rgb(255,200,0), …)
if (array_length(global.inventory) > 8) {
    draw_set_font(counterFont);
    draw_set_colour(counterCol);
    var _maxP = (array_length(global.inventory) - 1) div 8;
    draw_text(counterX, counterY, string(itemPage + 1) + " / " + string(_maxP + 1));
}
    // Слоты
    for (var i = 0; i < 8; i++) {
        if (!_itemOnRight && showDetail && i >= 4) continue;
        if (_itemOnRight  && showDetail && i <  4) continue;

        var idx = startIdx + i;
        if (idx >= array_length(global.inventory)) continue;

        var item = global.inventory[idx];
        var sx = slotX[i];
        var sy = slotY[i];

        // Спрайт предмета
        if (sprite_exists(item.sprite)) {
            var sc = min((slotSize * 0.85) / sprite_get_width(item.sprite),
                         (slotSize * 0.85) / sprite_get_height(item.sprite));
            draw_sprite_ext(item.sprite, 0, sx + slotSize/2, sy + slotSize/2, sc, sc, 0, c_white, 1);
        }

        // Короткое описание
        draw_set_font(global.fMyFont);
        draw_set_colour(c_black);
        draw_text_ext(textX[i], sy + 5, item.shortDesc, 22, textW);

        // Рамка выделения: sItemSelect спрайт или запасной прямоугольник
        if (idx == selectedItem) {
            if (sprite_exists(sItemSelect)) {
                draw_sprite_stretched(sItemSelect, 0, sx - 5, sy - 5, slotSize + 10, slotSize + 10);
            } else {
                draw_set_colour(c_orange);
                draw_rectangle(sx - 3, sy - 3, sx + slotSize + 3, sy + slotSize + 3, true);
            }
        }
    }

    // Детальная информация
    if (showDetail && selectedItem >= 0 && selectedItem < array_length(global.inventory)) {
        var item = global.inventory[selectedItem];

        // Уникальный стикер для этого предмета (если задан) — рисуется поверх фона
var sprX = _itemOnRight ? -523 : 0;
draw_sprite(item.detailSprite, 0, sprX, 0);
        // Большой спрайт предмета
        if (sprite_exists(item.sprite))
            draw_sprite_ext(item.sprite, 0, _dx + _dw/2, _dy + 160, 1.8, 1.8, 0, c_white, 1);

        draw_set_font(global.fMyFont);
        draw_set_colour(c_black);

        // Название: спрайт или текст
        if (variable_struct_exists(item, "nameDetailSprite") &&
            item.nameDetailSprite != noone && sprite_exists(item.nameDetailSprite)) {
            draw_sprite(item.nameDetailSprite, 0, _dx + 20, _dy + 20);
        } else {
            draw_text(_dx + 20, _dy + 20, item.name);
        }

        // Описание: спрайт или текст
        if (variable_struct_exists(item, "descSprite") &&
            item.descSprite != noone && sprite_exists(item.descSprite)) {
            draw_sprite(item.descSprite, 0, _dx + 20, _dy + 300);
        } else {
            draw_text_ext(_dx + 20, _dy + 300, item.desc, 26, _dw - 40);
        }
    }
}
else if (currentPage == 3) {
    draw_sprite_stretched(sSavePage, 0, 0, 0, gW, gH);

    // ── Три слота ─────────────────────────────────────────
    for (var i = 0; i < 3; i++) {
        var _sa    = saveSlotAreas[i];
        var _ba    = saveBtnAreas[i];
        var _sd    = saveSlotsData[i];
        var _empty = (_sd == noone);

        if (_empty) {
            draw_sprite_stretched(sSlotEmpty, 0, _sa.x, _sa.y, _sa.w, _sa.h);
        } else {
            draw_sprite_stretched(sSlotFilled, 0, _sa.x, _sa.y, _sa.w, _sa.h);
            draw_set_font(global.fMyFont);
            draw_set_colour(c_black);
            draw_text(_sa.x + 35, _sa.y + 15, _sd.chapter);
            var _h = _sd.playtime div 3600;
            var _m = (_sd.playtime mod 3600) div 60;
            draw_text(_sa.x + 20, _sa.y + 385,
                string(_h) + ":" + string_format(_m, 2, 0));
        }

        if (_empty) {
            draw_sprite_stretched(sBtnSave,      0, _ba.x, _ba.y, _ba.w, _ba.h);
        } else {
            draw_sprite_stretched(sBtnOverwrite, 0, _ba.x, _ba.y, _ba.w, _ba.h);
        }
    }
    // ── Автосохранение (ПОСЛЕ цикла, рисуется один раз) ───
    var _aa = autoSlotArea;
    if (autoSlotData == noone) {
        draw_sprite_stretched(ZeroAuto, 0, _aa.x, _aa.y, _aa.w, _aa.h);
        draw_set_font(global.fMyFont);
        draw_set_colour(c_dkgray);
        draw_text(_aa.x + 20, _aa.y + 30, "Автосохранение отсутствует");
    } else {
        draw_sprite_stretched(AutoSave, 0, _aa.x, _aa.y, _aa.w, _aa.h);
        draw_set_font(global.fMyFont);
        draw_set_colour(c_black);
        draw_text(_aa.x + 20, _aa.y + 10, autoSlotData.chapter + " Гл.");
        var _h = autoSlotData.playtime div 3600;
        var _m = (autoSlotData.playtime mod 3600) div 60;
        draw_text(_aa.x + 20, _aa.y + 65,
            string(_h) + ":" + string_format(_m, 2, 0));
    }

    // Кнопка «?»
    var _hb = autoHelpBtnArea;
    draw_sprite_stretched(sBtnHelp, 0, _hb.x, _hb.y, _hb.w, _hb.h);

    // Диалог подтверждения (поверх всего)
    if (confirmAction >= 0) {
        draw_set_colour(c_black);
        draw_set_alpha(0.65);
        draw_rectangle(0, 0, gW, gH, false);
        draw_set_alpha(1);
        draw_sprite_stretched(sConfirmBg, 0, 423, 203, 513, 325);
        draw_set_font(global.fMyFont);
        draw_set_colour(c_black);
        draw_sprite_stretched(sBtnYes, 0,
            confirmYesBtnArea.x, confirmYesBtnArea.y,
            confirmYesBtnArea.w, confirmYesBtnArea.h);
        draw_sprite_stretched(sBtnNo, 0,
            confirmNoBtnArea.x, confirmNoBtnArea.y,
            confirmNoBtnArea.w, confirmNoBtnArea.h);
    }

    // Табличка-подсказка (самой последней — поверх диалога)
    if (showAutoHelp) {
        draw_sprite(sAutoHelpPopup, 0, autoHelpX, autoHelpY);
    }
}