private ["_posPl","_pos","_art","_artT","_ammo","_exp","_vv","_side"];

_posPl = _this select 0;
_side = _this select 1;
_art = ["o_art","o_mortar"];
if (_side == WEST) then {_art = ["n_art","n_mortar","b_art","b_mortar"];};
if ({getmarkertype _x in _art && {getmarkerpos _x distance _posPl < 4000}} count VEHZONES == 0) exitWith {};
_artT = "";
{if (getmarkertype _x in _art && {getmarkerpos _x distance _posPl < 4000}) exitWith {_artT = getmarkertype _x;};} foreach VEHZONES;
_ammo = "Sh_155mm_AMOS";
if (_artT in ["o_mortar","n_mortar","b_mortar"]) then {_ammo = "Sh_82mm_AMOS";};
_vv = [8,10,12,6] call RETURNRANDOM;
sleep (15+(random 15));
while {_vv > 0} do {
_pos = [(_posPl select 0) + 150 - (random 300),(_posPl select 1) + 150 - (random 300), 30];
_exp = createVehicle [_ammo , _pos, [], 0, "NONE"];  
_exp setpos _pos;
_exp setVelocity [1, 20, 1];
_vv = _vv - 1;
sleep (1 + random 4);
};


