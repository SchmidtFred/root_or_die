starting_roots = 2;
starting_distance_apart = 30;
alive_roots = [];
dead_roots = [];
roots_at_base_ct = 0;
current_root = 0;
current_root_index = 0;
ipt = {};
camera = view_camera[0];
zoom_out = false;
length_tracker = 0;
root_spawn_timer_base = 15;
root_spawn_timer = root_spawn_timer_base * room_speed;
game_over = false;
display_set_gui_size(window_get_width(), window_get_height());

//function to create another root at base, placed here for initialization
function create_root_at_base() {
	var left_right = choose(-1, 1);
	var new_root = instance_create_layer(x + (starting_distance_apart * roots_at_base_ct * left_right), y, layer, SnakeHead);
	array_push(alive_roots, new_root);
	new_root.player_controller = self;
	roots_at_base_ct++;
}

//Create starting roots
var i = 0;
repeat(starting_roots) {
	create_root_at_base();
	i++;
}

current_root = alive_roots[current_root_index];

current_root.toggle_active();



function create_root() {
	//determine where root will go
	var chance = irandom(100);
	if (chance > 70) {
		create_root_at_base();
	} else {
		//not going to base determine which root gets one
		var working = true;
		var found_corner = false;
		var i = 0;
		var length = array_length(alive_roots);
		while (working)
		{
			//we will go in order of oldest root to youngest
			var _root = alive_roots[i];
			var root_calc = _root.select_corner();
			
			found_corner = root_calc.corner_found;
			
			if (found_corner) {
				var new_root = instance_create_layer(root_calc.x, root_calc.y, layer, SnakeHead);
				array_push(alive_roots, new_root);
				new_root.player_controller = self;
				var _shuffled_array = array_shuffle(root_calc.available_angles);
				var newDir = array_first(_shuffled_array);
				new_root.set_dir(newDir);
				new_root.reset_image_angle();
				working = false;
			} else {
				if (i < length - 1)
				{
					i++;
				} else {
					working = false;
				}
			}
		}
		
		if (!found_corner) {
			create_root_at_base();
		}
	}
}

//function to move current root to dead roots and then deactivate it
//index will not change because we just pop the current one out
function kill_current_root(_root_index) {
	//show_message(_root_index);
	//show_message(alive_roots);
	var index = array_get_index(alive_roots, _root_index);
	var remove_root = alive_roots[index];
	array_push(dead_roots, remove_root);
	//remove_root.toggle_active();
	remove_root.kill_root();
	array_delete(alive_roots, index, 1);
	
	if ( remove_root == current_root && array_length(alive_roots) > 0 ) {
		current_root.toggle_active();
		if (current_root_index >= array_length(alive_roots)) {
			current_root_index = 0;
		}
		current_root = alive_roots[current_root_index];
		current_root.toggle_active();
	}
	if ( array_length(alive_roots) <= 0 ) {
		zoom_out = true;
		game_over = true;
		camera_set_view_size(camera, BIG_CAM_W, BIG_CAM_H);
	}

}