private ["_start","_type","_pickup","_droppoint","_timeT","_chop1","_t","_nul"];
_n = ("ChopperT S") SPAWN DiagForCPS;
_start = _this select 0;
_type = _this select 1;
_pickup = _this select 2;
_droppoint = _this select 3;
_timeT = _this select 4;
_chop1 = [_start,310,_type,WEST] call SPAWNVEHICLE;
{_x setcaptive true; _x allowdamage false;} foreach ([(_chop1 select 0)] + (units (_chop1 select 2)));
(_chop1 select 2) move _pickup;
(_chop1 select 2) setBehaviour "Careless";
(_chop1 select 0) allowdamage false;
{_x setcaptive true; _x allowdamage false;} foreach units (_chop1 select 2);
waituntil {sleep 3; {!isnull _x && alive _x} count units (_chop1 select 2) == 0 || {unitready leader (_chop1 select 2)}};
(_chop1 select 0) land "GET IN";
_t = 0;
while {{alive _x && {!(_x in (_chop1 select 0))}} count ([] CALL AllPf) > 0 && {_t < 500}} do {sleep 3;_t = _t + 3;};
if (_t < 500) then {
(_chop1 select 0) land "NONE";
(_chop1 select 2) move _droppoint;
while {{!isnull _x && alive _x} count units (_chop1 select 2) > 0 && {!unitready leader (_chop1 select 2)}} do {sleep 3;};
(_chop1 select 0) land "GET IN";
waituntil {sleep 3;({(alive _x) && (_x in (_chop1 select 0))} count ([] CALL AllPf)) == 0};
_nul = [(_chop1 select 2), _timeT,1] SPAWN FSlowChopperSupport;
} else {
(_chop1 select 0) land "NONE";
_nul = [(_chop1 select 2), _timeT,1] SPAWN FSlowChopperSupport;
};
_n = ("ChopperT E") SPAWN DiagForCPS;