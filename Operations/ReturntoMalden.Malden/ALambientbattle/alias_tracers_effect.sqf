// by ALIAS
// nul = [tracers_object_name,_color] execVM "ALambientbattle\alias_tracers_effect.sqf";

_tracer_object_name = _this select 0;
_color_tracer		= _this select 1;
_life_time_tras_lum = _this select 2;

if ((!hasInterface) or ((player distance _tracer_object_name)<300) or (player distance _tracer_object_name>2500)) exitWith {};

private ["_xx","_yy","_zz","_dir","_obj_tras","_poc_mic","_nr_tracer","_li_tracer","_life_time_tras_lum"];

if ((player distance _tracer_object_name)>300) then {

// hint "boi";

_ro = 1;_ve = 1;_bl = 1;

if (_color_tracer=="red") then {_ro = 1;_ve = 0;_bl = 0;};
if (_color_tracer=="green") then {_ro = 0;_ve = 1;_bl = 0;};
if (_color_tracer=="yellow") then {_ro = 1;_ve = 1;_bl = 0;};
if (_color_tracer=="white") then {_ro = 1;_ve = 1;_bl = 1;};

_dir=0;
_range_trace= 2;

//while {(al_tracer) and ((player distance _tracer_object_name)>100) and (!isNull _tracer_object_name)} do {

	// creez lumina atasata
	_li_tracer = "#lightpoint" createVehicleLocal (getPos _tracer_object_name);
	_li_tracer setLightAmbient[_ro, _ve, _bl];
	_li_tracer setLightColor[_ro, _ve, _bl];
	_li_tracer lightAttachObject [_tracer_object_name, [0,0,0]];
	_li_tracer setLightDayLight true;	
	_li_tracer setLightUseFlare true;
	_li_tracer setLightFlareSize 3;
	_li_tracer setLightFlareMaxDistance 2000;	
	_li_tracer setLightIntensity 5000;
	_li_tracer setLightAttenuation [/*start*/ _range_trace, /*constant*/0, /*linear*/ 100, /*quadratic*/ 0, /*hardlimitstart*/_range_trace,_range_trace];  

	
	[_li_tracer,_life_time_tras_lum] spawn {
		_lum_tras = _this select 0;
		_life_time_tras_del = _this select 1;
		sleep _life_time_tras_del;
		deleteVehicle _lum_tras;
	};
	
};