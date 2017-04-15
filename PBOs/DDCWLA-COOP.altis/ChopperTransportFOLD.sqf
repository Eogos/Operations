private ["_start","_LZ","_infwaypoint","_side","_dir","_chopclass","_unitclasses","_skill","_startC","_chop","_groupCT","_h","_wp1"];
//INIT
//Chopper or Plane spawn position and exit
_start = _this select 0;
//Position were infantry cargo eject
_LZ = _this select 1;
//Position were infantry head before guarding it
_infwaypoint = _this select 2;
//Chopper and infatry side
_side = _this select 3;
//Chopper or Plane direction when spawned
_dir = _this select 4;
//Chopper or Plane class
_chopclass = _this select 5;
//Chopper or Plane height when spawned. For Chopper must be under 100m (50 is good), because of the current buggy AI flying
_h = _this select 6;
//Array of unitclasses that form the infantry group. Size of the group is the amount of classes you enter
_unitclasses = _this select 7;
//Array skill range for infantry group e.g. [0.4,0.7]
_skill = _this select 8;
//Transport only one group (0) or bring more cloned inf until shot down (1). DISABLED!!!!!!!!  
//_num = _this select 9;
//Language 0 is none
//_lang = _this select 10;

_startC = [_start select 0, _start select 1, _h];
_chop = [_startC, _dir, _chopclass, _side] call SPAWNVEHICLE;
CantCommand = CantCommand + [_chop select 2];
_groupCT = [_start, _side, _unitclasses,[],[],_skill] call SpawnGroupCustom;
DONTDELGROUPS = DONTDELGROUPS +  [_groupCT];
{_x moveincargo (_chop select 0);} foreach units _groupCT;
(_chop select 2) move _LZ;
(_chop select 2) setbehaviour "CARELESS";
(_chop select 2) allowfleeing 0;
_wp1= _groupCT addWaypoint [_infwaypoint, 0]; 
[_groupCT, 1] setWaypointType "GUARD";
(_chop select 0) flyinheight 80;

[_chop,_groupCT,_LZ,_start,_chopclass] SPAWN {
private ["_chop","_groupCT","_LZ","_start","_chopclass"];
_chop = _this select 0;
_groupCT = _this select 1;
_LZ = _this select 2;
_start = _this select 3;

[_start,"mil_arrow","ColorBlue",([_start, _LZ] call BIS_fnc_dirTo)] SPAWN SAOKCREATEMARKER;

_chopclass = _this select 4;
_random = [1,1,1,1,2,2,2,2,2,2] call RETURNRANDOM; 
switch (_random) do {
//PARADROP
case 1: {
[_LZ,"hd_start","ColorBlue",0," DropPoint"] SPAWN SAOKCREATEMARKER;
waitUntil {sleep 2; isNil"_chop" || {isNil"_groupCT"} || {(_chop select 0) distance _LZ < 350} || {!(alive (_chop select 0))} || {!(alive driver (_chop select 0))} || {(getposATL (_chop select 0) select 2) < 1} || {{alive _x} count crew (_chop select 0) == 0}};
//CHOP DOWN
if (isNil"_chop" || {isNil"_groupCT"}) exitWith {DONTDELGROUPS = DONTDELGROUPS -  [_groupCT];};
if !((_chop select 0) distance _LZ < 350) exitWith {if (isNil("CARS")) then {} else {CARS set [count CARS,(_chop select 0)];};{_nul = [_x] SPAWN {private ["_unit"];_unit = _this select 0;sleep 60;waituntil {sleep 10; {vehicle _x distance _unit < 700} count ([] CALL AllPf) == 0 || {isNull _unit}};deletevehicle _unit;};} foreach (units (_chop select 2));{if (vehicle _x == (_chop select 0)) then { unassignvehicle _x; _x action ["Eject",vehicle _x];};} foreach units _groupCT;DONTDELGROUPS = DONTDELGROUPS -  [_groupCT];CantCommand = CantCommand - [_chop select 2];if (isNil("CARS")) then {} else {CARS set [count CARS,(_chop select 0)];};FriendlyInf set [count FriendlyInf,_groupCT];};
//ELSE NEAR LZ -> JUMP
{_nul = [_x,(_chop select 0)] SPAWN FJumpOff;} foreach units _groupCT;
FriendlyInf set [count FriendlyInf,_groupCT];
sleep 5;
(_chop select 2) move _start;
waitUntil {sleep 3; isNil"_chop" || {isNil"_groupCT"} || {(_chop select 0) distance _start < 300} || {!(alive (_chop select 0))} || {!(alive driver (_chop select 0))} || {(getposATL (_chop select 0) select 2) < 1} || {{alive _x} count crew (_chop select 0) == 0}};
//CHOP DOWN
if (isNil"_chop" || isNil"_groupCT") exitWith {DONTDELGROUPS = DONTDELGROUPS -  [_groupCT];};
if !((_chop select 0) distance _start < 300) exitWith {if (isNil("CARS")) then {} else {CARS set [count CARS,(_chop select 0)];};{_nul = [_x] SPAWN {private ["_unit"];_unit = _this select 0;sleep 60;waituntil {sleep 10; {vehicle _x distance _unit < 700} count ([] CALL AllPf) == 0 || {isNull _unit}};deletevehicle _unit;};} foreach (units (_chop select 2));{if (vehicle _x == (_chop select 0)) then { unassignvehicle _x; _x action ["Eject",vehicle _x];};} foreach units _groupCT;DONTDELGROUPS = DONTDELGROUPS -  [_groupCT];CantCommand = CantCommand - [_chop select 2];if (isNil("CARS")) then {} else {CARS set [count CARS,(_chop select 0)];};FriendlyInf set [count FriendlyInf,_groupCT];};
//ELSE NEAR START -> DELETE
{deletevehicle _x;} foreach (units (_chop select 2)) + [(_chop select 0)];
DONTDELGROUPS = DONTDELGROUPS -  [_groupCT];
};
//LAND
case 2: {
[_LZ,"hd_start","ColorBlue",0," LZ"] SPAWN SAOKCREATEMARKER;
waitUntil {sleep 2; isNil"_chop" || {isNil"_groupCT"} || {(_chop select 0) distance _LZ < 700} || {!(alive (_chop select 0))} || {!(alive driver (_chop select 0))}  || {{alive _x} count crew (_chop select 0) == 0}};
if (isNil"_chop" || {isNil"_groupCT"}) exitWith {DONTDELGROUPS = DONTDELGROUPS -  [_groupCT];};
if !((_chop select 0) distance _LZ < 700) exitWith {if (isNil("CARS")) then {} else {CARS set [count CARS,(_chop select 0)];};{_nul = [_x] SPAWN {private ["_unit"];_unit = _this select 0;sleep 60;waituntil {sleep 10; {vehicle _x distance _unit < 700} count ([] CALL AllPf) == 0 || {isNull _unit}};deletevehicle _unit;};} foreach (units (_chop select 2));{if (vehicle _x == (_chop select 0)) then { unassignvehicle _x; _x action ["Eject",vehicle _x];};} foreach units _groupCT;DONTDELGROUPS = DONTDELGROUPS -  [_groupCT];CantCommand = CantCommand - [_chop select 2];if (isNil("CARS")) then {} else {CARS set [count CARS,(_chop select 0)];};FriendlyInf set [count FriendlyInf,_groupCT];};
//CREATE PAD
_st2 = [_LZ, 500,"(1 - forest) *(1 - trees) *(1 - houses) * (1 - sea)* (1 - hills)",""] CALL FUNKTIO_POS;
_start2 = (_st2 select 0) select 0;
_Lpos = _start2 findEmptyPosition[1 ,100, _chopclass];
_normal2 = surfaceNormal _Lpos; 
while {str(_Lpos) == "[0,0,0]"  || {(_normal2 select 2 < 0.95)}} do {
sleep 1;
_st2 = [_LZ, 600,"(1 - forest) *(1 - trees) *(1 - houses) * (1 - sea)* (1 - hills)",""] CALL FUNKTIO_POS;
_start2 = (_st2 select 0) select 0;
_Lpos = _start2 findEmptyPosition[ 1 , 300, _chopclass];
_normal2 = surfaceNormal _Lpos; 
};
_obj = createVehicle ["Land_HelipadEmpty_F",_Lpos, [], 0, "NONE"]; 
_obj setvectorup (surfaceNormal (getposATL _obj));
(_chop select 2) move (getposATL _obj);
waitUntil {sleep 1; isNil"_chop" || {isNil"_groupCT"} || {unitready leader (_chop select 2)}|| {!(alive (_chop select 0))} || {!(alive driver (_chop select 0))}  || {{alive _x} count crew (_chop select 0) == 0}};
if (isNil"_chop" || {isNil"_groupCT"}) exitWith {DONTDELGROUPS = DONTDELGROUPS -  [_groupCT];};
if !((_chop select 0) distance _LZ < 700) exitWith {if (isNil("CARS")) then {} else {CARS set [count CARS,(_chop select 0)];};{_nul = [_x] SPAWN {private ["_unit"];_unit = _this select 0;sleep 60;waituntil {sleep 10; {vehicle _x distance _unit < 700} count ([] CALL AllPf) == 0 || {isNull _unit}};deletevehicle _unit;};} foreach (units (_chop select 2));{if (vehicle _x == (_chop select 0)) then { unassignvehicle _x; _x action ["Eject",vehicle _x];};} foreach units _groupCT;DONTDELGROUPS = DONTDELGROUPS -  [_groupCT];CantCommand = CantCommand - [_chop select 2];if (isNil("CARS")) then {} else {CARS set [count CARS,(_chop select 0)];};FriendlyInf set [count FriendlyInf,_groupCT];};
//LAND
(_chop select 0) land "GET IN";
waitUntil {sleep 2; isNil"_chop" || {isNil"_groupCT"} || {(getposATL (_chop select 0) select 2) < 1}};
if (isNil"_chop" || {isNil"_groupCT"}) exitWith {DONTDELGROUPS = DONTDELGROUPS -  [_groupCT];};
//LANDED 
{
if (vehicle _x == (_chop select 0)) then { 
unassignvehicle _x; _x action ["Eject",vehicle _x];
};
} foreach units _groupCT;

deletevehicle _obj;

FriendlyInf set [count FriendlyInf,_groupCT];
if ( typeof (_chop select 0) in ["MH60S","UH1Y","UH60M_EP1"]) then {
_nul = [(_chop select 2),(60+(random 120)),1,_groupCT] SPAWN FSlowChopperSupportF;
} else {
_nul = [(_chop select 2),0,1,_groupCT] SPAWN FSlowChopperSupportF;
};

DONTDELGROUPS = DONTDELGROUPS -  [_groupCT];

};
};
};

_groupCT