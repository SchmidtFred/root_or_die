image_speed = 0;
array_of_options = ["bone", "gem", "rock", "route66", "hl3", "skeleton", "cow", "chicken", "icecream"];
me = "rock";
sound = undefined;
choice = irandom(100);


if (choice < 12) {
    me = "gem";
} else if (choice < 19) {
    me = "skeleton";
} else if (choice < 29) {
    me = "bone";
} else if (choice < 34) {
    me = "cow";    
} else if (choice < 64) { 
    me = "rock";
} else if (choice < 84) {
    me = "nothing";
} else if (choice < 87) {
    me = "route66";
} else if (choice < 92) {
    me = "chicken"    
} else if (choice < 97) {
    me = "icecream";
} else if (choice > 96) {
    me = "hl3";
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
	case "route66":
		sprite_index = sp_route66;
		image_index = irandom(image_number - 1);
		break;
	case "hl3":
		sprite_index = sp_hl3;
		image_index = irandom(image_number - 1);
		sound = Sound.disc;
		break;
	case "skeleton":
		sprite_index = sp_Skeleton;
		image_index = irandom(image_number - 1);
		sound = Sound.skeleton;
		break;
	case "cow":
		sprite_index = sp_Cow;
		image_index = irandom(image_number - 1);
		sound = Sound.cow;
		break;
	case "chicken":
		sprite_index = sp_Chicken;
		image_index = irandom(image_number - 1);
		sound = Sound.chicken;
		break;
	case "icecream":
		sprite_index = sp_IceCream;
		image_index = irandom(image_number - 1);
		sound = Sound.ice_cream;
		break;
	case "nothing":
		instance_destroy();
		break;
}
collision_callback = function(){
	if (irandom(100) > 60) {
		return;
	}
	Audio.play_dialogue(sound);
}

if (me != "cow") {
	image_angle = irandom(360);
}