//MISSION WRECK LOCATION
private ["_chopFunc","_ranP","_roads","_wreC","_c","_array","_offS","_cT","_l","_classes","_nul","_locat","_sides","_defender","_attacker","_Tid","_Tide","_Lna","_header","_desc","_obj","_waypoints","_Bp","_posB","_group","_offi1","_n"];


_chopFunc = {
//CHOPPER PART
//Chopper
private ["_ra","_st2","_start2","_Lpos","_normal2","_home","_civ","_side","_startC","_chop","_obj","_aika","_nul"];

[["Chopper is coming to pick up the officer",side _this],"HINTSAOK",nil,false] spawn BIS_fnc_MP;

_civ = _this;
_side = side _this;
_home = getposATL _this;
_startC = [(getmarkerpos "WestChopStart") select 0, (getmarkerpos "WestChopStart") select 1, 50];
_ra = "B_Heli_Transport_01_F";
if (_side==EAST) then {_ra = "O_Heli_Light_02_unarmed_F";};
_chop = [_startC, 180, _ra, _side] call SPAWNVEHICLE;
CantCommand set [count CantCommand,_chop select 2];
{_x allowdamage false;_x setcaptive true;} foreach (units (_chop select 2) + [(_chop select 0)]);
//CHOPPER TRANSPORT
(_chop select 2) move _home;
(_chop select 2) setbehaviour "CARELESS";
(_chop select 2) allowfleeing 0;
(_chop select 0) flyinheight 50;
waitUntil {sleep 1; (_chop select 0) distance _home < 700 || {!(alive _civ)}};
_st2 = [_home, 150,"(1 - forest) *(1 - trees) *(1 - houses) * (1 - sea)* (1 - hills)"] CALL FUNKTIO_POS;
_start2 = (_st2 select 0) select 0;
_Lpos = _start2 findEmptyPosition[1 ,100, _ra];
_normal2 = surfaceNormal _Lpos; 
while {str(_Lpos) == "[0,0,0]" || {(_normal2 select 2 < 0.95)}} do {
_st2 = [_home, 300,"(1 - forest) *(1 - trees) *(1 - houses) * (1 - sea)* (1 - hills)"] CALL FUNKTIO_POS;
_start2 = (_st2 select 0) select 0;
_Lpos = _start2 findEmptyPosition[ 1 , 300, _ra];
_normal2 = surfaceNormal _Lpos; 
};

_obj = createVehicle ["Land_HelipadEmpty_F",_Lpos, [], 0, "NONE"]; 
waitUntil {sleep 1; unitready leader (_chop select 2) || {!(alive _civ)}};
(_chop select 0) land "GET IN";
_aika = time + 60;
waitUntil {sleep 1; (getposATL (_chop select 0) select 2) < 6 || {_aika < time} || {!(alive _civ)}};
(_chop select 0) animateDoor ['door_R', 1]; 
(_chop select 0) animateDoor ['door_L', 1];
waitUntil {sleep 1; (getposATL (_chop select 0) select 2) < 1.5 || {_aika < time} || {!(alive _civ)}};
_civ enableAI "MOVE";
_civ setspeedmode "FULL";
_civ setbehaviour "AWARE";
_civ assignascargo (_chop select 0);
[_civ] ordergetin true;
_aika = time + 200; 
waitUntil {sleep 5; _civ in (_chop select 0) || {!(alive _civ)} || {_aika < time} || {isNull _civ}};
if (vehicle _civ == _civ) then {
[_civ] ordergetin false;
_st2 = [getposATL _civ, 1050,"(1 - forest) *(1 - trees) *(1 - houses) * (1 - sea)* (1 - hills)"] CALL FUNKTIO_POS;
_home = (_st2 select 0) select 0;
_civ domove _home;
};
deletevehicle _obj;
_nul = [(_chop select 2), (getmarkerpos "WestChopStart"), 7] SPAWN FMoveAndDelete; 
};

_ranP = [random 15000,random 15000,0];
_roads = (_ranP nearRoads 450);
while {count _roads == 0} do {
_ranP = [random 15000,random 15000,0];
_roads = (_ranP nearRoads 450);
};
_locat = getposATL (_roads select 0);
//TASK (random side)
_sides = [WEST,EAST];
_defender = _sides call RETURNRANDOM;
_attacker = (_sides - [_defender]) call RETURNRANDOM;
_Tid = format ["TaskOff%1",NUMM];
_Tide = format ["TaskOffE%1",NUMM];
NUMM=NUMM+1;
_Lna = _locat CALL NEARESTLOCATIONNAME;
_header = format ["Save Officer near %1",_Lna];
_desc =("One of our officers have been attacked damaging his car. We need to get him alive there as soon as possible before enemy searches the area. Look him from nearby houses and other hiding places.");
[
_defender, // Task owner(s)
_Tid, // Task ID (used when setting task state, destination or description later)
[_desc, _header, _header], // Task description
_locat, // Task destination
"CREATED" // true to set task as current upon creation
] call BIS_fnc_taskCreate;
_header = format ["Find and Kill Officer near %1",_Lna];
_desc =("Our strike against car carrying hostile officer have failed it seems. We need some team to investigate the area and finish the job. Search for nearby houses and other hiding places.");
[
_attacker, // Task owner(s)
_Tide, // Task ID (used when setting task state, destination or description later)
[_desc, _header, _header], // Task description
_locat, // Task destination
"CREATED" // true to set task as current upon creation
] call BIS_fnc_taskCreate;

_wreC = "Land_Wreck_Hunter_F";
if (_attacker == WEST) then {_wreC = "Land_Wreck_Offroad_F";};
_obj = createVehicle [_wreC,_locat, [], 0, "NONE"]; 
_obj setvectorup (surfaceNormal (getposATL _obj));
_obj setdir (random 360);
waitUntil {sleep 5; {_x distance _locat < 1000} count ([] CALL AllPf) > 0};
_waypoints = [];
_l = 60;
_offS = [(_locat select 0)+_l-(random _l)*2,(_locat select 1)+_l-(random _l)*2, 0];
_cT = nearestBuilding _offS;
while {count _waypoints == 0} do {
sleep 1;
_offS = [(_locat select 0)+_l-(random _l)*2,(_locat select 1)+_l-(random _l)*2, 0];
_cT = nearestBuilding _offS;
_c = 0;
_array = _cT buildingPos _c;
while {str(_array) != "[0,0,0]"} do {	
_waypoints set [count _waypoints,_c];
_c = _c + 1;
_array = _cT buildingPos _c;
};
_l = _l + 20;
};
_classes = ["O_officer_F"];
if (_defender == WEST) then {_classes = ["I_officer_F"];};
_Bp = _waypoints call RETURNRANDOM;
_posB = _cT buildingPos _Bp;
_group = [_posB, _defender, _classes,[],[],[0.4,0.8]] call SpawnGroupCustom;
_offi1 = leader _group;
_offi1 setpos _posB;
DONTDELGROUPS = DONTDELGROUPS + [_group];
_timer = time + 1200;
waitUntil {sleep 5; !alive _offi1 || {{_x distance _offi1 < 20} count ([_defender] CALL AllPf) > 0} || {_timer < time}};
if (_timer < time) exitWith {
_n = [_Tid] CALL BIS_fnc_deleteTask;
_n = [_TidE] CALL BIS_fnc_deleteTask;
DONTDELGROUPS = DONTDELGROUPS - [_group];
deletevehicle _obj;
};
if (alive _offi1) then {
_offi1 SPAWN _chopFunc;
};
_timer = time + 900;
waitUntil {sleep 5; !alive _offi1 || {vehicle _offi1 != _offi1} || {_offi1 distance _posB > 400}|| {_timer < time}};
if (_timer < time) exitWith {
_n = [_Tid] CALL BIS_fnc_deleteTask;
_n = [_TidE] CALL BIS_fnc_deleteTask;
DONTDELGROUPS = DONTDELGROUPS - [_group];
deletevehicle _obj;
};
if !(alive _offi1) then {
_nul = [_TidE,"SUCCEEDED"] call BIS_fnc_taskSetState;
[_posB,_attacker] SPAWN ADDR;
_nul = [_Tid,"FAILED"] call BIS_fnc_taskSetState;
_n = [_attacker,350] SPAWN PrestigeUpdate;
[[350, "Enemy Officer Killed",_attacker],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
} else {
_nul = [_Tid,"SUCCEEDED"] call BIS_fnc_taskSetState;
_nul = [_TidE,"FAILED"] call BIS_fnc_taskSetState;
[_posB,_defender] SPAWN ADDR;
_n = [_defender,350] SPAWN PrestigeUpdate;
[[350, "Officer Saved",_defender],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
};
DONTDELGROUPS = DONTDELGROUPS - [_group];
sleep 60;
_n = [_Tid] CALL BIS_fnc_deleteTask;
_n = [_TidE] CALL BIS_fnc_deleteTask;
if (!isNull _offi1) then {deletevehicle _offi1;};
deletevehicle _obj;