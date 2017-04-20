
private ["_l","_st","_start","_random","_ordercode","_veh2","_unitrate","_classes","_cl","_group","_type","_veh","_nul"];
_l = (([] CALL AllPf) call RETURNRANDOM);
_st = [getposATL _l, 3500,"(1 - trees) *(1 - houses) * (1 - sea)"] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
while {{_x distance _start < 1000} count ([] CALL AllPf) > 0} do {
sleep 2;
_l = (([] CALL AllPf) call RETURNRANDOM);
_st = [getposATL _l, 3500,"(1 - houses) * (1 - sea)"] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
};
[[BaseR, localize "STR_Sp2s1r5"],"SAOKMULTIGCHAT",nil,false] spawn BIS_fnc_MP;
sleep 10;
[[leader player, localize "STR_Sp2s1r6"],"SAOKMULTISCHAT",nil,false] spawn BIS_fnc_MP;
[
WEST, // Task owner(s)
"taskHV", // Task ID (used when setting task state, destination or description later)
["Iranian vehicle have been spotted camoflaged. Find it and destroy the vehicle", "Find and destroy hidden persian vehicle", "Find and destroy hidden persian vehicle"], // Task description
_start, // Task destination
"CREATED" // true to set task as current upon creation
] call BIS_fnc_taskCreate;
_veh2 = createVehicle ["CamoNet_OPFOR_big_F", _start, [], 0, "NONE"];
_veh2 allowdamage false;
waitUntil {sleep 6; {vehicle _x distance _start < 800} count ([] CALL AllPf) > 0};
_unitrate = [6,8];
_random = round(random (_unitrate select 1));
while {_random <  (_unitrate select 0)} do {_random = round(random (_unitrate select 1));};
_classes = [];
_cl = [ENEMYC1,ENEMYC2,ENEMYC3] call RETURNRANDOM;
while {_random > 0} do {_classes set [count _classes,_cl call RETURNRANDOM];_random = _random - 1;};
_group = [_start, EAST, _classes,[],[],[0.4,0.8]] call SpawnGroupCustom;
//player setpos _start;
Pgroups set [count Pgroups,_group];
[_group, _start, 100] call bis_fnc_taskPatrol;

_type = ["O_MBT_02_cannon_F"] call RETURNRANDOM;
_veh = createVehicle [_type, _start, [], 0, "NONE"];
_veh setdir (random 360);
_veh setvariable ["AmCrate",1];
_veh lock true;
waitUntil {sleep 6; isNull _veh || {!alive _veh}};
_n = [side player,200] SPAWN PrestigeUpdate;
[[200, "Enemy Task Destroyed",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
_nul = ["taskHV","SUCCEEDED"] call BIS_fnc_taskSetState;
[_start,side player] SPAWN ADDR;
[[leader player, localize "STR_Sp2s1r7"],"SAOKMULTISCHAT",nil,false] spawn BIS_fnc_MP;
sleep 7;
[[BaseR, localize "STR_Sp2s1r8"],"SAOKMULTIGCHAT",nil,false] spawn BIS_fnc_MP;
CARS = CARS + [_veh];
_veh setvariable ["AmCrate",nil];
waitUntil {sleep 10; {_x distance _start < 1000} count ([] CALL AllPf) == 0};
deletevehicle _veh2;
