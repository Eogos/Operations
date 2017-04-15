CROWCOUNT = [];
while {true} do {
{
if (count CROWCOUNT < 3 && {_x distance player < 100}) exitWith {
if (([] CALL FPSGOOD) && {vehicle _x == _x}) then {
	[_x] SPAWN {
		private ["_unit", "_pos", "_b", "_num", "_bis_crows"];
		_unit = (_this select 0);
		_pos = getposATL _unit;
		_num = 2 + floor(random 2);
		_b = {(getposATL _unit) distance _x < 20} count CROWCOUNT; 
		if (_b == 0) then {
		CROWCOUNT set [count CROWCOUNT,_pos];
		_bis_crows = [_unit,20,_num,20] CALL FUNKTIO_CROW;
		while {((vehicle player) distance _pos < 500) && {{isnull _x} count _bis_crows == 0}} do {sleep 5;};
		{if (!isnull _x) then {deletevehicle _x;};} foreach _bis_crows;
		{if (isNil"_x" || {typename _x != "ARRAY"} || {_x distance _pos < 10}) then {CROWCOUNT = [CROWCOUNT,_forEachIndex] call BIS_fnc_removeIndex;};} foreach CROWCOUNT;
		};
	};
};
};
} foreach AlldeadMen; 
sleep 5;
if (random 1 < 0.3) then {
{
if (((getposATL _x) select 2) < 2 && {_x distance vehicle player < 500} && {speed _x > 2}) exitWith {(getposATL _x) SPAWN BirdFunc1;};
} foreach Vehicles; 
};
sleep 5;
if (random 1 < 0.3) then {
{
if (vehicle _x == _x && {_x distance vehicle player < 500} && {speed _x > 1}) exitWith {(getposATL _x) SPAWN BirdFunc1;};
} foreach AllUnits; 
};
sleep 5;
};