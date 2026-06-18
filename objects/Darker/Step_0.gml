// Проверяем игрока
with (oPlayer) {
    if (place_meeting(x, y, BedTouch)) {
        if (keyboard_check_pressed(ord("E"))) { // Лучше check_pressed, чтобы срабатывало от одного нажатия
            other.is_darkening = true; // Слово other передает команду обратно черному объекту!
        }
    }
}

// Плавное затемнение
if (is_darkening) 
{
    image_alpha += fade_speed;
    if (image_alpha >= 1) image_alpha = 1.1;
}

// Запуск таймера (ИСПРАВЛЕНО)
if (image_alpha == 1.1)
{
    // Проверяем, равен ли alarm -1 (это значит, что он сейчас выключен)
    if (!darkening_second)
	{
	if (alarm[0] == -1) {
        alarm[0] = 1 * game_get_speed(gamespeed_fps); // Запускаем ОДИН раз
    }
	}
	else
	{
			if (alarm[1] == -1) {
        alarm[1] = 15 * game_get_speed(gamespeed_fps); // Запускаем ОДИН раз

}

}
}
	
if (faded)
{
	if (is_faded)
{
	    image_alpha -= fading;
}
}