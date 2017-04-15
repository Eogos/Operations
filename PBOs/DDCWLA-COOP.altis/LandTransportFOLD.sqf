private ["_start","_LZ","_infwaypoint","_side","_dir","_chopclass","_unitclasses","_skill","_num","_startC","_chop","_groupLT","_wp1","_nul"];
//INIT
//Land vehicle spawn position and exit
_start = _this select 0;
//Position were infantry disempark
_LZ = _this select 1;
//Position were infantry head before guarding it
_infwaypoint = _this select 2;
//Chopper and infatry side
_side = _this select 3;
//vehicle direction when spawned
_dir = _this select 4;
//Land vehicle class
_chopclass = _this select 5;
//Array of unitclasses that form the infantry group. Size of the group is the amount of classes you enter
_unitclasses = _this select 6;
//Array skill range for infantry group e.g. [0.4,0.7]
_skill = _this select 7;
//Transport only one group (0) or how many more until destroyed (1->).   
_num = _this select 8;

_startC = [_start select 0, _start select 1, 0];
_chop = [_startC, _dir, _chopclass, _side] call SPAWNVEHICLE;
(_chop select 0) SPAWN {_this allowdamage false; sleep 10; _this allowdamage true;};
_groupLT = [_start, _side, _unitclasses,[],[],_skill] call SpawnGroupCustom;

{_x moveincargo (_chop select 0);} foreach units _groupLT;
(_chop select 2) move _LZ;
(_chop select 2) setbehaviour "SAFE";
_wp1= _groupLT addWaypoint [_infwaypoint, 0]; 
[_groupLT, 1] setWaypointType "GUARD";
_nul = [(_chop select 0), _LZ] SPAWN FvehicleStucked2;
[_chop,_groupLT,_LZ,_start] SPAWN {
private ["_chop","_groupLT","_LZ","_start"];
_chop = _this select 0;
_groupLT = _this select 1;
_LZ = _this select 2;
_start = _this select 3;
waitUntil {sleep 3; isNil"_chop" || {isNil"_groupLT"} || {!(alive (_chop select 0))} || {!(alive driver (_chop select 0))} || {({alive _x} count crew (_chop select 0)) < 1} || {((_chop select 0) distance _LZ <500)} ||  {behaviour leader (_chop select 2) == "COMBAT"}};
if (isNil"_chop" || {isNil"_groupLT"}) exitWith {};
if (!(alive (_chop select 0)) || {!(alive driver (_chop select 0))} || {({alive _x} count crew (_chop select 0)) < 1}) exitWith {if (isNil("CARS")) then {} else {CARS set [count CARS,(_chop select 0)];};{_nul = [_x] SPAWN {private ["_unit"];_unit = _this select 0;sleep 60;waituntil {sleep 10; {vehicle _x distance _unit < 700} count ([] CALL AllPf) == 0 || isNull _unit};deletevehicle _unit;};} foreach (units (_chop select 2));FriendlyInf set [count FriendlyInf,_groupLT];};
{_nul = [_x,(_chop select 0)] SPAWN FJumpOffCar;} foreach units _groupLT;
[_LZ,"hd_start","ColorBlue",0," DropPoint"] SPAWN SAOKCREATEMARKER;
FriendlyInf set [count FriendlyInf,_groupLT];
sleep 15;
(_chop select 2) move _start;(_chop select 0) forcespeed -1;
waitUntil{sleep 5; isNil"_chop" || {isNil"_groupLT"}|| {!(alive (_chop select 0))} || {!(alive driver (_chop select 0))} || {({alive _x} count crew (_chop select 0)) < 1} || {(_chop select 0) distance _start < 40}};
if (isNil"_chop" || {isNil"_groupLT"}) exitWith {};
if (!(alive (_chop select 0)) || {!(alive driver (_chop select 0))} || {({alive _x} count crew (_chop select 0)) < 1}) exitWith {if (isNil("CARS")) then {} else {CARS set [count CARS,(_chop select 0)];};{_nul = [_x] SPAWN {private ["_unit"];_unit = _this select 0;sleep 60;waituntil {sleep 10; {vehicle _x distance _unit < 700} count ([] CALL AllPf) == 0 || isNull _unit};deletevehicle _unit;};} foreach (units (_chop select 2));FriendlyInf set [count FriendlyInf,_groupLT];};
{deletevehicle _x;} foreach (units (_chop select 2)) + [(_chop select 0)];
};

_groupLT