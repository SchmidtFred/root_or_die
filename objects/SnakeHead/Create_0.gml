SPEED = SNAKE_SPEED;
direction = DOWN_DIRECTION;
image_angle = direction;

player_controller = 0;
active_head = false;
current_body = 0;
dead = false;
old_dir = 90;
movement_timer_trigger = 30;
movement_timer = movement_timer_trigger + 1;
my_corners = [];
my_bodies = [];

//create Starting root body
current_body = instance_create_layer(x, y, layer, RootBody);
current_body.image_angle = image_angle;
current_body.image_xscale = point_distance(current_body.x, current_body.y, x, y);
current_body.image_yscale = ROOT_WIDTH;
array_push(my_bodies, current_body);

function change_col(_newCol){
	image_blend = _newCol;
	var i = 0; repeat(array_length(my_bodies)) my_bodies[i++].image_blend = _newCol;
	var i = 0; repeat(array_length(my_corners)) my_corners[i++].image_blend = _newCol;
}
function change_dir(_newDir) {
	_newDir = round((_newDir/DIRECTION_ADD)) * DIRECTION_ADD;
	if (movement_timer > movement_timer_trigger && _newDir != (direction + 180) % 360) {
		//set_dir(_newDir);
		direction = _newDir;
	
		//create corner
		var newCorner = instance_create_layer(x,y,layer,RootCorner);
		newCorner.image_blend = image_blend;
		array_push(my_corners, newCorner);
		newCorner.root1 = current_body;
		newCorner.root1_dir = (old_dir + 180) % 360;
		newCorner.root2_dir = (_newDir + 180) % 360;
		
		//create new root body
		current_body = instance_create_layer(x, y, layer, RootBody);
		array_push(my_bodies, current_body);
		current_body.image_blend = image_blend;
		current_body.image_angle = image_angle;
		current_body.image_xscale = point_distance(current_body.x, current_body.y, x, y);
		current_body.image_yscale = ROOT_WIDTH;
		newCorner.root2 = current_body;
		//reset movement timer
		movement_timer = 0;
		old_dir = direction;
	}
}

function toggle_active() {
	active_head = !active_head;
	change_col(active_head ? c_lime : c_white);
}

function kill_root() {
	SPEED = 0;
	dead = true;
}

function handle_body() {
	current_body.image_angle = point_direction(current_body.x, current_body.y, x, y);
	current_body.image_xscale = point_distance(current_body.x, current_body.y, x, y);
	current_body.image_yscale = ROOT_WIDTH;
}


//select a corner that will be okay to spawn a root from and return x and y
function select_corner() {
	var return_data = {
		corner_found: false,
		x: 0,
		y: 0,
		available_angles: []
	}
	var i = array_length(my_corners) - 1;
	var working = true;
	
	//make sure we don't iterate on an empty array
	if (i < 0) {
		working = false;
	}
	
	while (working)
	{
		var corner = my_corners[i];
		var spawn_response = corner.root_spawn_check();
		return_data.corner_found = spawn_response.good_to_spawn;
		
		if (return_data.corner_found)
		{
			return_data.x = corner.x;
			return_data.y = corner.y;
			return_data.available_angles = spawn_response.available_angles;
			working = false;
		} else {
			if (i == 0)
			{
				working = false;
			} else
			{
				i--;
			}
		}
	}
	
	
	return return_data;
}

function set_dir(_newDir) {
	old_dir = direction;
	direction = _newDir;
}

function reset_image_angle() {
	image_angle = direction;
}