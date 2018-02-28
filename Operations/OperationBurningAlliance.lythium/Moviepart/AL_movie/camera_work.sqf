// by ALIAS
// _camera_shot = [position_1_name, position_2_name, target_name, duration, zoom_level1, zoom_level_2, attached, x_rel_coord, y_rel_coord, z_rel_coord,screen_effect,tranzition_effect,tranzition_duration] execVM "AL_movie\camera_work.sqf";

private ["_screen_sfx","_effect_screen","_tranz","_tranz_dur","_tanz_eff_1","_tanz_eff_2","_tranz_screen","_sound_file_name","_sleep_tranz"];

_campos1= _this select 0;
_campos2= _this select 1;
_targetcam = _this select 2;
_camera_duration = _this select 3;
_zoom_level1 = _this select 4;
_zoom_level2 = _this select 5;
_cam_attached = _this select 6;
_x_coord = _this select 7;
_y_coord = _this select 8;
_z_coord = _this select 9;
_screen_sfx =  _this select 10;
_tranz = _this select 11;
_tranz_dur = _this select 12;
_sound_file_name = _this select 13;
_last_shot = _this select 14;

// ----------------------

if (!loopdone) then {

switch (_screen_sfx) do {
	case "none": {
					_effect_screen = ppEffectCreate ["FilmGrain", 300]; _effect_screen ppEffectEnable true; _effect_screen ppEffectAdjust [0,0,0,0,0,false]; _effect_screen ppEffectCommit 0;camUseNVG false; false setCamUseTi 0;
				};
	case "nightvision": {camUseNVG true; false setCamUseTi 0; _effect_screen = ppEffectCreate ["FilmGrain", 300]; _effect_screen ppEffectEnable true; _effect_screen ppEffectAdjust [0,0,0,0,0,false]; _effect_screen ppEffectCommit 0;};
	case "thermal": 	{true setCamUseTi 0; camUseNVG false; _effect_screen = ppEffectCreate ["FilmGrain", 300]; _effect_screen ppEffectEnable true; _effect_screen ppEffectAdjust [0,0,0,0,0,false]; _effect_screen ppEffectCommit 0;};
	case "blur": {
					camUseNVG false; false setCamUseTi 0;
					_effect_screen = ppEffectCreate ["dynamicBlur", 450];
					_effect_screen ppEffectEnable true;   
					_effect_screen ppEffectAdjust [1];
					_effect_screen ppEffectCommit 0;     
				};
	case "grain": { 
					camUseNVG false; false setCamUseTi 0;
					_effect_screen = ppEffectCreate ["FilmGrain", 2000]; 
					_effect_screen ppEffectEnable true;
					_effect_screen ppEffectAdjust [0.1,0.1,2,0.3,0.3,false];
					_effect_screen ppEffectCommit 0;
				};
	case "blackwhite": { 
					camUseNVG false; false setCamUseTi 0;
					_effect_screen = ppEffectCreate ["ColorCorrections", 1550]; 			
					_effect_screen ppEffectEnable true;
					_effect_screen ppEffectAdjust [1, 1, 0, [1, 1, 1, 0], [1, 1, 1, 0], [0.75, 0.25, 0, 1.0]]; 
					_effect_screen ppEffectCommit 0;
				};	
	case "wet": { 
					camUseNVG false; false setCamUseTi 0;
					_effect_screen = ppEffectCreate ["WetDistortion", 300]; 			
					_effect_screen ppEffectEnable true;
					_effect_screen ppEffectAdjust [1, 1, 1, 10, 10, 77, 93, 10, 10, 0.02, 0.05,0.5, 0.3, 10.0, 6.0];
					_effect_screen ppEffectCommit 0;
				};	
	case "chromatic": { 
					camUseNVG false; false setCamUseTi 0;
					_effect_screen = ppEffectCreate ["ChromAberration", 200]; 			
					_effect_screen ppEffectEnable true;
					_effect_screen ppEffectAdjust [0.1, 0.1, true]; 
					_effect_screen ppEffectCommit 0;
				};
	case "invert": { 
					camUseNVG false; false setCamUseTi 0;
					_effect_screen = ppEffectCreate ["ColorInversion", 2500]; 			
					_effect_screen ppEffectEnable true;
					_effect_screen ppEffectAdjust [0.5, 0.5, 0.5]; 
					_effect_screen ppEffectCommit 0;
				};
};

switch (_tranz) do {
	case "none"		:{_tanz_eff_1="PLAIN";_tanz_eff_2="PLAIN";};
	case "black"	:{_tanz_eff_1="BLACK IN";_tanz_eff_2="BLACK OUT";};
	case "white"	:{_tanz_eff_1="WHITE IN";_tanz_eff_2="WHITE OUT";};
	case "blur"		:{_tanz_eff_1="PLAIN";_tanz_eff_2="PLAIN";};
};

if (_tranz_dur>0) then {_sleep_tranz =_tranz_dur/2;} else {_sleep_tranz=0;};

//if (_tranz==black) then {_tanz_eff_1="BLACK IN";_tanz_eff_2="BLACK OUT";hint str _tanz_eff_1};
	if (_cam_attached) then {
		
		cutText ["", _tanz_eff_1, _sleep_tranz];
	
		if (_tranz=="blur") then {
		_tranz_screen = ppEffectCreate ["dynamicBlur", 450];
		_tranz_screen ppEffectEnable true;   
		_tranz_screen ppEffectAdjust [0];
		_tranz_screen ppEffectCommit _sleep_tranz; 
		};
	
		_camera = "camera" camCreate (getpos _campos1);
				showCinemaBorder true;
		_camera attachTo [_campos2, [_x_coord,_y_coord,_z_coord]];		
		_camera cameraEffect ["internal", "BACK"];
		_camera camCommand "inertia off";
		_camera camPrepareTarget _targetcam;
		_camera camPrepareFOV _zoom_level2;
		_camera camCommitPrepared _camera_duration;
		
		if (_sound_file_name != "none") then {playSound _sound_file_name};
		
		sleep _camera_duration-_sleep_tranz;
		cutText ["", _tanz_eff_2, _sleep_tranz];
		
		if (_tranz=="blur") then {
		_tranz_screen = ppEffectCreate ["dynamicBlur", 450];
		_tranz_screen ppEffectEnable true;   
		_tranz_screen ppEffectAdjust [100];
		_tranz_screen ppEffectCommit _sleep_tranz; 
		};				
		sleep _sleep_tranz;

		if (_tranz=="blur") then {		
			_tranz_screen ppEffectEnable false;
			ppEffectDestroy _tranz_screen;
		};
		
		_effect_screen ppEffectEnable false;
		ppEffectDestroy _effect_screen;

		
	} else {
	
	cutText ["", _tanz_eff_1, _sleep_tranz];
	
	if (_tranz=="blur") then {
	_tranz_screen = ppEffectCreate ["dynamicBlur", 450];
	_tranz_screen ppEffectEnable true;   
	_tranz_screen ppEffectAdjust [0];
	_tranz_screen ppEffectCommit _sleep_tranz; 
	};		

	// initial/start position where camera is created
	_camera = "camera" camCreate (getpos _campos1);
			showCinemaBorder true;
	_camera cameraEffect ["internal", "BACK"];
	_camera camCommand "inertia on";
	_camera camPrepareTarget _targetcam;
	_camera camPrepareFOV _zoom_level1;
	_camera camCommitPrepared 0;
	
	if (_sound_file_name != "none") then {playSound _sound_file_name};

	// poz 2 - where camera is moving next - target2
	_camera camPreparePos (getpos _campos2);
	_camera camPrepareTarget _targetcam;
	_camera camPrepareFOV _zoom_level2;
	_camera camCommitPrepared _camera_duration;
	
	sleep _camera_duration-_sleep_tranz;
	cutText ["", _tanz_eff_2, _sleep_tranz];
	
	if (_tranz=="blur") then {
	_tranz_screen = ppEffectCreate ["dynamicBlur", 450];
	_tranz_screen ppEffectEnable true;   
	_tranz_screen ppEffectAdjust [100];
	_tranz_screen ppEffectCommit _sleep_tranz; 
	};	
	
	sleep _sleep_tranz;
	
	if (_tranz=="blur") then {		
		_tranz_screen ppEffectEnable false;
		ppEffectDestroy _tranz_screen;
	};
	
	_effect_screen ppEffectEnable false;
	ppEffectDestroy _effect_screen;	
	};
	if (_last_shot) then {loopdone = true};
};