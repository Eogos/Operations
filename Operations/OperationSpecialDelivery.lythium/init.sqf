
/*
* For dedicated use the lines bellow in init.sqf to make video not to be played if the mission already started
if (isServer) then {
	video_play = true;
	publicvariable "video_play";

	[] spawn {
		sleep 60; // how many seconds after mission started the intro will not be played for JIP
		video_play = false;
		publicvariable "video_play";
	};
};

Then use a check to decide if the script will be run or not

if (video_play)then {
playsound "intro_music";

cut_scene_1= [] execVM "AL_movie\cut_scene_1.sqf";
waitUntil {scriptdone cut_scene_1};
sleep 1;

cut_scene_2 = [] execVM "AL_movie\cut_scene_screen_effect.sqf";
waitUntil {scriptdone cut_scene_2};
sleep 1;

null = [] execVM "AL_movie\cut_scene_transition.sqf";
};
*/


// background music
playsound "intro_music";

// you can have as many cutscenes as you want, just create multiple sqf files and run them when you need (via trigger or script or radio or action menu) as you can see below
cut_scene_1= [] execVM "AL_movie\cut_scene_1.sqf";
waitUntil {scriptdone cut_scene_1};
sleep 1;

null = [] execVM "AL_movie\cut_scene_transition.sqf";