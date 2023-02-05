//root body
if (!dead) {
	//image_angle = direction;	
	image_angle += angle_difference(direction, image_angle) * .3;
	
	//collision check
	var xx = lengthdir_x(sprite_width, direction);
	var yy = lengthdir_y(sprite_width, direction);
	var col= collision_circle(x + xx, y + yy, 1, collision_parent, true, true)
	if ( col && col != current_body ) {
		player_controller.kill_current_root(id);
		x += lengthdir_x(1, direction);
		y += lengthdir_y(1, direction);
	}
	current_body.image_angle = point_direction(current_body.x, current_body.y, x, y);
	current_body.image_xscale = point_distance(current_body.x, current_body.y, x, y);
	current_body.image_yscale = ROOT_WIDTH;
	
	var _ahead = 12;
	RenderGround.do_cutout(x + (dcos(image_angle)*_ahead), y - (dsin(image_angle)*_ahead));
}




movement_timer++;