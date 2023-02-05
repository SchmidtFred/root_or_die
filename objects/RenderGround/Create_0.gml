surface = -1;

validate = function(){
	if ( !surface_exists(surface) ) {
		surface = surface_create(room_width, room_height);
		draw_clear(0);
		surface_set_target(surface);
		draw_sprite_tiled(sp_ground, 1, 16, 16);
		surface_reset_target();
	}
}
do_cutout = function(_x, _y){
	validate();
	surface_set_target(surface);
	gpu_set_blendmode(bm_subtract);
	draw_sprite_ext(sp_cutout, irandom(sprite_get_number(sp_cutout)), _x, _y, 1, 1, random(360), c_white, 1);
	gpu_set_blendmode(bm_normal);
	surface_reset_target();
}