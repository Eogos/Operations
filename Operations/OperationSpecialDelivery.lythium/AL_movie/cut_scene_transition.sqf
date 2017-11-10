// by ALIAS
// null = [] execVM "AL_movie\cut_scene_1.sqf";
// Tutorial: https://www.youtube.com/aliascartoons

//waitUntil {!isnil "video_done"};if (video_done) exitWith {};

if (!hasInterface) exitWith {};
cutText ["", "BLACK IN", 0];

/* ----- how to use camera script -----------------------------------------------------------------------

_camera_shot = [position_1_name, position_2_name, target_name, duration, zoom_level1, zoom_level_2, attached, x_rel_coord, y_rel_coord, z_rel_coord,screen_effect,transition_effect,transition_duration,sound_file_name] execVM "AL_movie\camera_work.sqf";

Where
_camera_shot	- string, is the name/number of the camera shot, you can have as many as you want see examples from down bellow
position_1_name - string, where camera is created, replace it with the name of the object you want camera to start from
position_2_name - string, the object where you want camera to move, if you don't want to move from initial position put the same name as for position_1_name
target_name   	- string, name of the object you want the camera to look at
duration 		- seconds, how long you want the camera to function on current shot
zoom_level_1 	- takes values from 0.01 to 2, FOV (field of view) value for initial position
zoom_level_2	- takes values from 0.01 to 2, FOV value for second position, if you don't to change you can give the same value as you did for zoom_level_1
attached		- boolean, if you want to attach camera to an moving object its value has to be true, otherwise must be false
					in this case position_1_name must have the same value as position_2_name
x_rel_coord		- meters, relative position to the attached object on x coordinate
y_rel_coord		- meters, relative position to the attached object on y coordinate
z_rel_coord		- meters, relative position to the attached object on z coordinate

screen_effect	- predefined values: "none", "nightvision", "thermal", "blackwhite", "grain", "blur", "wet","chromatic","invert"

transition_effect	- transition between shots, predefined values: "none", "black","white", "blur"

transition_duration	- seconds, the duration of transition between shots

sound_effect	- "NoSound" or sound file name you want to play during shots, be aware the file needs to exist under mission folder and must be defined in description.ext

last_shot		- boolean, true if is the last shot in your movie, false otherwise

====================== TEXT ========================================================================================
null = [_title_text,_title_duration,_title_pozition,_text_size,_text_color] execVM "AL_movie\txt_display.sqf";
title_text		- string, text you want to display on the screen
title_duration	- seconds, how long the text stays on screen
title_pozition	- predefined values: "top_right", "middle_right", "bottom_right", "center", "center_bottom", "center_top", "left_bottom", "left_middle", "left_top"
text_size		- number, text size
-----------------------------------------------------------------------------------------------------------*/

// - do not edit or delete the lines downbelow, this line must be before first camera shot
loopdone = false;
while {!loopdone} do {
//^^^^^^^^^^^^^^^^^^^^^^ DO NOT EDIT OR DELETE ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


// EXAMPLES------ insert your lines for camera shots starting from here -----------------------------------------

// --------------->> end of camera shots <<---------------------------------------------------------
};
cutText [" ", "BLACK IN", 3];
_camera = "camera" camCreate (getpos player);
_camera cameraeffect ["terminate", "back"];
camDestroy _camera;
"dynamicBlur" ppEffectEnable true;   
"dynamicBlur" ppEffectAdjust [100];   
"dynamicBlur" ppEffectCommit 0;     
"dynamicBlur" ppEffectAdjust [0.0];  
"dynamicBlur" ppEffectCommit 4;