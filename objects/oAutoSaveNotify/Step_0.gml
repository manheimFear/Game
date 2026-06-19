// Step event oAutoSaveNotify:
if (timer > 0) {
    timer--;
    if (timer > 30) {
        alpha = min(1, alpha + 0.1); // появление
    } else if (timer < 30) {
        alpha = max(0, alpha - 0.05); // затухание
    }
    if (timer <= 0) visible = false;
}