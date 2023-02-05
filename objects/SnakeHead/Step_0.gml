if (active_head) {
	image_blend = c_green;
} else {
	image_blend = c_white;
}

//root body
if (!dead) {
	image_angle = direction;	
	
	//collision check
	var xx = lengthdir_x(sprite_width, direction);
	var yy = lengthdir_y(sprite_width, direction);
	if (collision_circle(x + xx, y + yy, 1, collision_parent, true, true)) {
		player_controller.kill_current_root();
		x += lengthdir_x(1, direction);
		y += lengthdir_y(1, direction);
	}
	current_body.image_angle = point_direction(current_body.x, current_body.y, x, y);
	current_body.image_xscale = point_distance(current_body.x, current_body.y, x, y);
	current_body.image_yscale = ROOT_WIDTH;
}




movement_timer++;