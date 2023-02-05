var total_alive = array_length(alive_roots);
var total_dead = array_length(dead_roots);

if (!game_over) {
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_text_transformed(10, 10, "Roots: " + string(total_alive), 1, 1, 0);
} else {
	var width = display_get_gui_width();
	var height = display_get_gui_height();
	draw_set_halign(fa_middle);
	draw_text_transformed((width * 0.5), (height * 0.5) - 50, "Total Roots: " + string(total_alive + total_dead), 1, 1, 0);
	draw_text_transformed((width * 0.5), (height * 0.5), "Total Length of Roots: " + string(game_score) + " Barkometers", 1, 1, 0);
	draw_text_transformed((width * 0.5), (height * 0.5) + 50, "Try Again? Press Enter", 1, 1, 0);
	draw_set_halign(fa_left);
}