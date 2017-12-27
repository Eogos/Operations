// by ALIAS
// nul = [tracers_object_name,color] execVM "ALambientbattle\alias_tracers.sqf";

if (!isServer) exitWith {};

_main_tracer_object = _this select 0;
_color = _this select 1;

// make variable below false if you want to stop the loop and remove tracer effect
al_tracer = true;
publicVariable "al_tracer";

al_tracers_sunet_play = false;
publicVariable "al_tracers_sunet_play";	

[] spawn {
while {al_tracer} do {
	sleep 36 + random 2;
	al_tracers_sunet_play = false;
	publicVariable "al_tracers_sunet_play";	
	};
};

while {al_tracer} do {
_nr_tras = 2 + floor (random 7);

	_xx 	= [60,-60] call BIS_fnc_selectRandom;
	_yy 	= [60,-60] call BIS_fnc_selectRandom;
	_zz		= 50+ (random 100);	

	while {_nr_tras>0} do {
		_nr_tras = _nr_tras-1;	
		private ["_trasor"];
		_trasor = createVehicle ["Land_Battery_F", (getPos _main_tracer_object), [],0, "CAN_COLLIDE"];

		_life_time_tras = 4 + floor (random 6);
		[[_trasor,_color,_life_time_tras],"ALambientbattle\alias_tracers_effect.sqf"] remoteExec ["BIS_fnc_execVM"];
//		[[_trasor,_color,_life_time_tras],"ALambientbattle\alias_tracers_effect.sqf"] remoteExec ["BIS_fnc_execVM",-2];
		
		_trasor setVelocity [_xx,_yy,_zz];
		[_trasor,_life_time_tras] spawn {
			_obj_tras = _this select 0;
			_life_time_tras_del = _this select 1;
			sleep _life_time_tras_del;
			deleteVehicle _obj_tras;
		};
		sleep 0.2 + (random 1);
	};

sleep 1 + (random 3);
	
	if (!al_tracers_sunet_play) then {
		[_main_tracer_object,"ground_air"] remoteExec ["say3d"];
		//[_main_tracer_object,"ground_air"] remoteExec ["say3d",-2];
		al_tracers_sunet_play = true;
		publicVariable "al_tracers_sunet_play";
	};
};