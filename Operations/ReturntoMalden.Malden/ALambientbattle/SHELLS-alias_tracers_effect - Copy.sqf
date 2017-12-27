// by ALIAS
// nul = [tracers_object_name,_color] execVM "ALambientbattle\alias_tracers_effect.sqf";

if (!hasInterface) exitWith {};

private ["_xx","_yy","_zz","_dir","_obj_tras","_poc_mic","_nr_tracer"];

_tracer_object_name = _this select 0;
_color_tracer		= _this select 1;

if ((player distance _tracer_object_name)>100) then {

// hint "boi";

if (_color_tracer=="red") then {_color_tracer = "Sh_120mm_APFSDS_Tracer_Red"};
if (_color_tracer=="green") then {_color_tracer = "Sh_120mm_APFSDS_Tracer_Green"};
if (_color_tracer=="yellow") then {_color_tracer = "Sh_120mm_APFSDS_Tracer_Yellow"};
if (_color_tracer=="white") then {_color_tracer = "Sh_105mm_APFSDS"};

/*
"Sh_105mm_APFSDS_T_Red"
"Sh_105mm_APFSDS_T_Green"
"Sh_105mm_APFSDS"
"Sh_105mm_APFSDS_T_Yellow"

Sh_120mm_APFSDS_Tracer_Red
Sh_120mm_APFSDS_Tracer_Green
Sh_120mm_APFSDS_Tracer_Yellow

*/

_dir=0;

//while {(al_tracer) and ((player distance _tracer_object_name)>100) and (!isNull _tracer_object_name)} do {
while {al_tracer} do {

/*
	_dir	= [random 180*-1,random 180*1] call BIS_fnc_selectRandom;
	_xx 	= 90+_dir;
	_dir	= [random 180*1,random 180*-1] call BIS_fnc_selectRandom;
	_yy 	= 90+_dir;
*/
	_xx = [30,-30] call BIS_fnc_selectRandom;
	_yy = [30,-30] call BIS_fnc_selectRandom;
	_zz = 50+floor (random 100);
	_nr_tracer = 1+ floor (random 10);
	
	while {_nr_tracer>0} do {
	_tracer_shell = _color_tracer createVehicle getpos _tracer_object_name; _tracer_shell setVelocity [_xx,_yy,_zz];
	//_tracer_shell setVectorDirandUp [[_yy-90,_xx-90,1],[0.1,0.1,1]];
	_nr_tracer = _nr_tracer-1;
	sleep 0.1;
	[_tracer_shell] spawn {
		_obj_trac = _this select 0;
		sleep 5+ random 3;
		deleteVehicle _obj_trac;};
	};

	sleep random 1;
	
	//	sunet
	if (!al_tracers_sunet_play) then {
		_tracer_object_name say3d "ground_air";	
		al_tracers_sunet_play = true;
		publicVariable "al_tracers_sunet_play";
	};
};

};