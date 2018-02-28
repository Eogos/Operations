if (isServer) then {
	video_play = true;
	publicvariable "video_play";
	[] spawn {
		sleep 60; // how many seconds after mission started the intro will not be played for JIP
		video_play = false;
		publicvariable "video_play";
	};
};
if (video_play)then {
// background music
playsound "intro_music";

cut_scene_1= [] execVM "AL_movie\cut_scene_1.sqf";
waitUntil {scriptdone cut_scene_1};
sleep 1;

cut_scene_2 = [] execVM "AL_movie\cut_scene_screen_effect.sqf";
waitUntil {scriptdone cut_scene_2};
sleep 1;

null = [] execVM "AL_movie\cut_scene_transition.sqf";
};