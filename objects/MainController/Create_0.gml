#macro Particle MainController.particle
#macro Sound MainController.sound_data
#macro Audio MainController.audio_controller

draw_set_font(ft_Root);

particle = new ParticleClass();
sound_data = new AudioData();
audio_controller = new AudioClass();

game_music = audio_play_sound(msc_main, 1, 1, 0);
menu_music = audio_play_sound(msc_menu, 1, 1, 1);

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
	
	text = "You can see the whole root system using the [Tab] key!";
	Await(tutorial_input); Then
	
	text = "Avoid the obstacles and grow your tree!";
	Await(tutorial_input); Then
	
	text = "More roots will spawn the longer your roots grow!";
	Await(tutorial_input); Then
	
	text = "For more of a challenge, press [Alt] to create new roots!";
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