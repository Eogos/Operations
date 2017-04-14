//////////////////////////////////////////////////////////////////
// Function file for Armed Assault
// Created by: TODO: Author Name
//////////////////////////////////////////////////////////////////
private ["_g","_side","_LZ","_start","_dir","_chopclass","_y","_xx","_nul"];
_g = _this select 0;
if (isNil"_g") exitWith {};
_side = _this select 1;
if (isNil"_side") exitWith {};
_LZ = _this select 2;
if (isNil"_LZ") exitWith {};
_start = getmarkerpos "WestChopStart";
_chopclass = "I_Heli_Transport_02_F";
switch (_side) do {
case WEST: {
_start = getmarkerpos "WestChopStart";
_chopclass = ["B_Heli_Transport_01_F","I_Heli_Transport_02_F","B_Heli_Light_01_F"] call RETURNRANDOM;};
case EAST: {
_start = getmarkerpos "EastChopStart";
_chopclass = ["O_Heli_Light_02_unarmed_F","O_Heli_Light_02_unarmed_F"] call RETURNRANDOM;};
};
_xx = random 150;
_y = 150 - _xx;
if (random 1 < 0.5) then {_xx =_xx *(-1);};
if (random 1 < 0.5) then {_y =_y *(-1);};
_start = [(_start select 0)+_xx,(_start select 1)+_y,0];
_dir = [_start, _LZ] call BIS_fnc_dirTo;
CantCommand = CantCommand + [_g];
_nul = [_start, _LZ, _side, _dir,_chopclass,80, _g] SPAWN ChopperTransportPara;


