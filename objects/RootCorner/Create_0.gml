root1 = 0;
root2 = 0;
root1_dir = 0;
root2_dir = 0;

function root_spawn_check() {
	var return_data = {
		good_to_spawn: false,
		available_angles: []
	}
	var col_list = ds_list_create();
	var free_array = [0, 45, 90, 135, 180, 225, 270, 315];
	collision_circle_list(x,y,16,collision_parent,true, true, col_list, true);
	var _root = ds_list_find_index(col_list, root1);
	ds_list_delete(col_list, _root);
	_root = ds_list_find_index(col_list, root2);
	ds_list_delete(col_list, _root);
	
	var index = array_get_index(free_array, root1_dir);
	array_delete(free_array,index,1);
	index = array_get_index(free_array, root2_dir);
	array_delete(free_array,index,1);
	
	//nothing in the way but original roots just shoot us back
	if (ds_list_size(col_list) > 0) {
		//if there are other things, find out which directions they are in.
		var actual_free_array = [];
		var length = array_length(free_array);
		var i = 0;
		repeat(length) {
			//create an array of free directions
			var dir = free_array[i];
			var xx = lengthdir_x(16, dir);
			var yy = lengthdir_y(16, dir);
			
			var list= ds_list_create();
			var col = collision_line_list(x, y, x + xx, y + yy, collision_parent, true, true, list, true);
			if ( col > 0 ){
				var i = 0;
				var avaliable = true;
				repeat(ds_list_size(list)){
					if ( list[| i] != root1 &&
						 list[| i] != root2 ){
							 avaliable = false;
							 break;
						 }
					i++;
				}
				if ( avaliable ) array_push(actual_free_array, dir);
			}
			ds_list_destroy(list);
		}
		return_data.available_angles = actual_free_array;
		if (array_length(actual_free_array) > 0) {
			return_data.good_to_spawn = true;
		}
		ds_list_destroy(col_list);
		return return_data;
	} else {
		ds_list_destroy(col_list);
		return_data.good_to_spawn = true;
		return_data.available_angles = free_array;
		return return_data;
	}
}