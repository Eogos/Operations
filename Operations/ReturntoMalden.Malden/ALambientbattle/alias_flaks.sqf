// by ALIAS
// nul = [aaa_object_name] execVM "ALambientbattle\alias_flaks.sqf";

if (!isServer) exitWith {};

_main_air_object = _this select 0;

// make variable below false if you want to stop the loop and remove AAA effect
al_aaa = true;
publicVariable "al_aaa";

while {al_aaa} do {
	//[[[_main_air_object],"ALambientbattle\alias_flaks_effect.sqf"],"BIS_fnc_execVM",true,false] spawn BIS_fnc_MP;
	[[_main_air_object],"ALambientbattle\alias_flaks_effect.sqf"] remoteExec ["BIS_fnc_execVM"];
	sleep 0.2;
};