image_speed = 0;
array_of_options = ["bone", "gem", "rock"];
me = "rock";
sound = undefined;
choice = irandom(100);


if (choice < 20) {
	me = "gem";
} else if (choice < 50) {
	me = "bone";
} else if (choice < 70) {
	me = "nothing";
}

switch (me) {
	case "bone": 
		sprite_index = sp_Bone;
		image_index = irandom(image_number - 1);
		sound = Sound.bones;
		break;
	case "gem":
		sprite_index = sp_Gem;
		image_index = irandom(image_number - 1);
		sound = Sound.gems;
		break;
	case "rock":
		sprite_index = sp_Rock;
		image_index = irandom(image_number - 1);
		sound = Sound.rocks;
		break;
	case "nothing":
		instance_destroy();
		break;
}
collision_callback = function(){
	Audio.play_dialogue(sound);	
	collision_callback = null_function;
}
image_angle = irandom(360);