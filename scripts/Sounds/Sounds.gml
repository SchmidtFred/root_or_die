function AudioData() constructor {

	intro		= [ sndGameIntro];
	gems		= [ sndGem_1, sndGem_2, sndGem_3 ];
	bones		= [	sndBone1, sndBone2, sndBone3, sndBone4, sndBone5_skele1, sndBone5_skele2 ];
	rocks		= [	sndRock1, sndRock2, sndRock3, sndRock4, sndRock5 ];
	cow			= [	sndCow ];
	chicken		= [	sndChicken ];
	disc		= [	sndDisc ];
	ice_cream	= [	sndIceCream ];
	mid_idles	= [	sndMidIdle1, sndMidIdle2, sndMidIdle3, sndMidIdle4,
					sndMidIdle5, sndMidIdle6, sndMidIdle7, sndMidIdle8,
					sndMidIdle9, sndMidIdle10, sndMidIdle11, sndMidIdle12, 
					sndMidIdle13 ];

}
function AudioClass() constructor {
	
	dialogue = -1;
	play_dialogue = function(sound_data, vol=1, pitch=1){
		if ( !is_array(sound_data))			return dialogue;
		if ( audio_is_playing(dialogue) )	return dialogue;
		
		dialogue = audio_play_sound(
			sound_data[irandom_range(0, array_length(sound_data)-1)], 0, 0,
			vol, 0, pitch);
			
		return dialogue;
	}
	
}