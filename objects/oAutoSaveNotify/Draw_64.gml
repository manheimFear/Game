// Draw GUI event oAutoSaveNotify:
if (!visible) exit;
draw_set_alpha(alpha);
draw_sprite_ext(sAutoSaveIcon, 0, display_get_gui_width() - 80, 40, 1, 1, 0, c_white, 1);
// Или просто текст:
draw_set_font(fMyFont);
draw_set_colour(c_white);
draw_text(display_get_gui_width() - 220, 30, "Автосохранение...");
draw_set_alpha(1);