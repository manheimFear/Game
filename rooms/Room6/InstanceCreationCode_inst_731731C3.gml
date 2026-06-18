// Узнаем ширину и высоту экрана (комнаты)
var screen_w = room_width;
var screen_h = room_height;

// Делим размер экрана на исходный размер спрайта объекта
image_xscale = screen_w / sprite_get_width(sprite_index);
image_yscale = screen_h / sprite_get_height(sprite_index);
