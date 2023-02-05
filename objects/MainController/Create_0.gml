#macro Particle MainController.particle
particle = new ParticleClass();

window_set_size(1280, 720);
window_set_position(
	(display_get_width() * .5 ) - 640, 
	(display_get_height() * .5 ) - 360
);
display_set_gui_size(
	window_get_width(), 
	window_get_height()
);

randomize();
room_goto_next();

text = "";
prompt = "";
tutorial_complete = false;
tutorial = Coroutine(){
	
	Yield(30); Then
	
	PlayerController.toggle_pause();
	CoroutineID.timer = 60;
	
	text = "Hello!";
	Yield(CoroutineID.timer); Then
	
	text = "Welcome to Rootmancy!";
	Yield(CoroutineID.timer); Then
	
	text = "Control your roots using the arrow keys!";
	prompt = "Press any key";
	Await(tutorial_input); Then
	
	text = "You can switch between roots using [A] and [D] keys!";
	Await(tutorial_input); Then
	
	text = "Avoid the obstacles and grow your tree!";
	Await(tutorial_input); Then
	
	text = "Have fun!!";
	prompt ="";
	Yield(CoroutineID.timer); Then
	PlayerController.toggle_pause();
	text = "";
	
	End;
}
tutorial_input = Coroutine(){
	if ( keyboard_check_pressed(vk_anykey) ) Escape(undefined);
	Loop;
}