surface = -1;
rocks = Particle.add("rocks")
		.set_color(#312027)
		.set_life(30, 60)
		.set_sprite(sp_cutout, 0, 0, true)
		.set_gravity(.05, 270)
		.set_direction(45, 135, 0)
		.set_speed(.5, 0)
		.set_size(.2, .66, -.01)
		.set_orientation(0, 360, 0, true)

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
	
	if ( irandom_range(0, 100) > 33 ) return;
	var len = 8;
	repeat(irandom(2)){
		var dir = random(360);
		Particle.spawn(rocks, _x + (dcos(dir)*len), _y-(dsin(dir)*len), 1); 
	}
}

