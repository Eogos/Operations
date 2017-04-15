_l = (([WEST] CALL AllPf)call RETURNRANDOM);
_st = [getposATL _l, 3500,"(1 - houses) * (1 - sea)"] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
while {{_x distance _start < 1000} count ([WEST] CALL AllPf) > 0} do {
sleep 2;
_l = (([WEST] CALL AllPf)call RETURNRANDOM);
_st = [getposATL _l, 3500,"(1 - houses) * (1 - sea)"] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
};
[[BaseR, localize "STR_Sp2s1r9"],"SAOKMULTIGCHAT",nil,false] spawn BIS_fnc_MP;
sleep 10;
[[leader player, localize "STR_Sp2s1r10"],"SAOKMULTISCHAT",nil,false] spawn BIS_fnc_MP;
[
WEST, // Task owner(s)
"taskAA", // Task ID (used when setting task state, destination or description later)
["Iranian AA-vehicle have been spotted with light guard, could be good time to take it out", "Find and Destroy AA-vehicle", "Find and Destroy AA-vehicle"], // Task description
_start, // Task destination
"CREATED" // true to set task as current upon creation
] call BIS_fnc_taskCreate;
waitUntil {sleep 6; {vehicle _x distance _start < 800} count ([WEST] CALL AllPf) > 0};
_unitrate = [4,5];
_random = round(random (_unitrate select 1));
while {_random <  (_unitrate select 0)} do {_random = round(random (_unitrate select 1));};
_classes = [];
_cl = [ENEMYC1,ENEMYC2,ENEMYC3] call RETURNRANDOM;
while {_random > 0} do {_classes set [count _classes,_cl call RETURNRANDOM];_random = _random - 1;};
_group = [_start, EAST, _classes,[],[],[0.4,0.8]] call SpawnGroupCustom;

Pgroups set [count Pgroups,_group];
[_group, _start, 100] call bis_fnc_taskPatrol;

_tg1 = [_start, 0, "O_APC_Tracked_02_AA_F", EAST] call SPAWNVEHICLE;
DONTDELGROUPS = DONTDELGROUPS + [(_tg1 select 2)];
waitUntil {sleep 6; isNull (_tg1 select 0) || {!alive (_tg1 select 0)} || {{alive _x} count crew (_tg1 select 0) == 0}};
_n = [side player,200] SPAWN PrestigeUpdate;
_nul = ["taskAA","SUCCEEDED"] call BIS_fnc_taskSetState;
[_start,side player] SPAWN ADDR;
[[200, "Enemy AA-vehicle Destroyed",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
[[leader player, localize "STR_Sp2s1r11"],"SAOKMULTISCHAT",nil,false] spawn BIS_fnc_MP;
sleep 7;
[[BaseR, localize "STR_Sp2s1r12"],"SAOKMULTIGCHAT",nil,false] spawn BIS_fnc_MP;
CARS = CARS + [(_tg1 select 0)];
DONTDELGROUPS = DONTDELGROUPS - [(_tg1 select 2)];


