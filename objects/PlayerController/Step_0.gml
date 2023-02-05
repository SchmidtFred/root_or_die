if ( paused ) exit;
ipt.x = keyboard_check(vk_right) - keyboard_check(vk_left);
ipt.y = keyboard_check(vk_down) - keyboard_check(vk_up);
ipt.cycle = keyboard_check_pressed(ord("D")) - keyboard_check_pressed(ord("A"));
ipt.zoom = keyboard_check_pressed(vk_tab);
ipt.enter = keyboard_check_pressed(vk_enter);

var dir = point_direction(0, 0, ipt.x, ipt.y);
var dis = point_distance(0, 0, ipt.x, ipt.y);

if (!game_over) {
	
	if (dis > 0.5 && ipt.cycle == 0) {
		with(current_root) {
			change_dir(dir);
		}
	}

	if (ipt.cycle != 0) {
		//deactivate current root
		with(current_root) {
			toggle_active();
		}
		//change current root
		current_root_index += ipt.cycle;
		//current_root_index = abs(current_root_index % array_length(alive_roots));
		var alen = array_length(alive_roots);
		if ( current_root_index < 0 ) current_root_index = alen-1;
		if ( current_root_index > alen - 1) current_root_index = 0;
		
		current_root = alive_roots[current_root_index];
		
		//activate new current root
		with(current_root) {
			toggle_active();
		}
	}

	if (ipt.zoom) {
		zoom_out = !zoom_out;
		if (zoom_out) {
			camera_set_view_size(camera, BIG_CAM_W, BIG_CAM_H);
		} else {
			camera_set_view_size(camera, ZOOM_CAMERA_W, ZOOM_CAMERA_H);
		}
	}


	length_tracker += array_length(alive_roots);
	
	if (length_tracker > root_spawn_timer) {
		create_root();
		root_spawn_timer += power(root_spawn_timer_base, array_length(alive_roots) - 1) * room_speed;
	}
	
} else {
	if (ipt.enter) {
		room_goto(RoomMenu);
	}
}


if (!zoom_out) {
	var ww = camera_get_view_width(camera)/2;
	var hh = camera_get_view_height(camera)/2;
	camera_set_view_pos(camera,
		clamp(current_root.x - ww, 0, room_width-hh),
		clamp(current_root.y - hh, 0, room_height-hh));
} else {
	camera_set_view_pos(camera, 0, 0);
}

//DEBUG CREATE ROOT
if (keyboard_check_pressed(vk_alt)) {
	create_root();
}
