private ["_pos","_type","_side","_car","_dir","_mode","_height","_groupSV","_crew"];
_pos = if (!isNil{(_this select 0)} && {typename (_this select 0) == "ARRAY"} && {(_this select 0) distance [0,0,0] > 100}) then {_this select 0} else {[10000,10000,0]};
_dir = _this select 1;
_type = _this select 2;
_side = _this select 3;
_mode = "NONE";
_height = if (count _pos > 2) then {_pos select 2} else {0};
if (_height > 0) then {_mode = "FLY";};

_car = createVehicle [_type,_pos, [], 0, _mode];
_car setdir _dir;
createVehicleCrew _car;
_crew = (crew _car);
{
if (side _x == EAST) then {
_x setSkill ["aimingaccuracy", 0.15 + (random 0.20)];
_x setSkill ["aimingShake", 0.15 + (random 0.2)];
_x setSkill ["aimingSpeed", 0.10 + (random 0.1)];
_x setSkill ["spotDistance", 0.20 + (random 0.3)];
_x setSkill ["spotTime", 0.25 + (random 0.35)];
_x setSkill ["endurance", 0.25 + (random 0.25)];
_x setSkill ["courage", 0.15 + (random 0.35)];
_x setSkill ["reloadSpeed", 0.15 + (random 0.15)];
_x setSkill ["commanding", 0.15 + (random 0.25)];
_x setSkill ["general", 0.15 + (random 0.15)];
} else {
_x setSkill ["aimingaccuracy", 0.30 + (random 0.3)];
_x setSkill ["aimingShake", 0.30 + (random 0.4)];
_x setSkill ["aimingSpeed", 0.20 + (random 0.4)];
_x setSkill ["spotDistance", 0.25 + (random 0.4)];
_x setSkill ["spotTime", 0.20 + (random 0.4)];
_x setSkill ["endurance", 0.35 + (random 0.35)];
_x setSkill ["courage", 0.35 + (random 0.35)];
_x setSkill ["reloadSpeed", 0.35 + (random 0.35)];
_x setSkill ["commanding", 0.15 + (random 0.35)];
_x setSkill ["general", 0.35 + (random 0.35)];
};
} foreach _crew;
_groupSV = group (_crew select 0);
if (isNil"_groupSV") exitWith {[_car, _crew]};
if (_height > 0) then {_car setVelocity [_height * (sin _dir),_height * (cos _dir), 0];};
[_car, _crew, _groupSV]