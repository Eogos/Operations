private ["_d","_st","_start","_start2","_player","_cur","_walls","_mar","_marker","_nul","_ran","_group","_animal","_ordercode"];
CurTaskS = CurTaskS + ["TaskFindRes.sqf"];
_player = if (isNil"_this" || {typename _this != "OBJECT"}) then {server_object} else {_this};
_cur = (SaOkmissionNamespace getvariable "Progress");
SaOkmissionNamespace setvariable ["Progress",(_cur + ["MetResContact"]),true];
_d = 2000;
_st = [vehicle _player, _d,"(1 - sea)* (1 + meadow)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
while {{vehicle _x distance _start < 500} count ([] CALL AllPf) > 0 || {surfaceIsWater _start}} do {
_d = _d + 200;
_RP = ([] CALL AllPf) call RETURNRANDOM;
_st = [vehicle _RP, _d,"(1 - sea)* (1 + meadow)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
sleep 1;
};
_walls = _start CALL POWcell;
_mar = format ["TaskM%1",NUMM];
NUMM=NUMM+1;
//_marker = [_mar,_start, "hd_objective", [0.5,0.5], "ColorPink", "Meet Resistance Contact"] CALL FUNKTIO_CREATEMARKER;
_nul = ["task2","SUCCEEDED"] call BIS_fnc_taskSetState;
[
WEST, // Task owner(s)
"taskRR", // Task ID (used when setting task state, destination or description later)
["Release civilian who is held in nearby CSAT outpost. He might help us to arrange meeting with local resistance", "Rescue POW", "Rescue POW"], // Task description
_start, // Task destination
true // true to set task as current upon creation
] call BIS_fnc_taskCreate;

_st = [_start, 50,"(1 - sea) * (1 + meadow)",1] CALL FUNKTIO_POS;
_start2 = (_st select 0) select 0;
_d = 50;
while {_start2 distance _start < 30} do {
_d = _d + 10;
_st = [_start, _d,"(1 - sea) * (1 + meadow)",1] CALL FUNKTIO_POS;
_start2 = (_st select 0) select 0;
sleep 1;
};
_nul = [_start2,"",25] SPAWN CreateRoadBlock;

waitUntil {sleep 4; {vehicle _x distance _start < 250} count ([WEST] CALL AllPf) > 0};
_ran = CIVS1 call RETURNRANDOM;
_group = creategroup civilian;
_animal = _group createUnit [_ran, _start, [], 0, "form"];
_animal setvariable ["CivNo",1];
_animal setbehaviour "CARELESS";
_animal allowfleeing 0;
_animal allowdamage false;
_animal disableAI "MOVE";
_animal setdir (random 360);
_animal setpos _start;
DONTDELGROUPS = DONTDELGROUPS + [_group];
waitUntil {sleep 4; {vehicle _x distance _animal < 40} count ([WEST] CALL AllPf)> 0};
//hint "You will need to look at the resistance contact, when talking to him";
_animal dotarget _player;
_animal dowatch _player;
waitUntil {sleep 4; {vehicle _x distance _animal < 15} count ([WEST] CALL AllPf) > 0};
[[getposATL _animal,"Contact Man #1: I guess you have some reason to save me?"],"SAOKMULTITTEXT",nil,false] spawn BIS_fnc_MP;
sleep 5;
[[getposATL _animal,"LT. JACKSON: Yes, we need to meet local resistance to join our forces"],"SAOKMULTITTEXT",nil,false] spawn BIS_fnc_MP;
[[4],"MusicT",nil,false] spawn BIS_fnc_MP;
//deleteMarker _marker;
_nul = ["taskRR","SUCCEEDED"] call BIS_fnc_taskSetState;
DONTDELGROUPS = DONTDELGROUPS - [_group];
sleep 5;
_nul = [] execVM "Cutscenes\MeetResContact.sqf";
CurTaskS = CurTaskS - ["TaskFindRes.sqf"];
sleep 5;
deletevehicle _animal;
{deletevehicle _x;} foreach _walls;