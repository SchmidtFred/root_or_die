if ( text != "" ){
	var align = [draw_get_halign(), draw_get_valign()];
	draw_set_halign(fa_center);
	draw_set_valign(fa_center);
	draw_text_ext(GUI_W * .5, GUI_H * .5, text, 16, 128);	
	
	draw_set_halign(fa_right);
	draw_set_valign(fa_bottom);
	draw_set_alpha(abs(dcos(current_time/10)));
	draw_text_transformed(GUI_W - 5, GUI_H - 5, prompt, .5, .5, 0);
	
	draw_set_alpha(1);
	draw_set_halign(align[0]);
	draw_set_valign(align[1]);
}