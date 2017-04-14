private ["_Tid2","_nul","_cPos","_desTD","_Lna","_headerD","_t","_desT","_header","_n","_random","_Tid","_desc","_time","_uCar","_unitrate","_classes","_group","_dead","_camps"];
_desT = [];
_desTD = [];
_camps = [];
_header = "";
_headerD = "";

{if (getmarkercolor _x == "ColorBlue") then {_camps set [count _camps, _x];};} foreach AMBbattles;
if (count _camps == 0) then {
{_cPos = getmarkerpos _x;if (getmarkercolor _x == "ColorBlue" && {{getmarkercolor _x == "ColorRed" && {getmarkerpos _x distance _cPos < 3000}} count VEHZONESA > 0}) then {_camps set [count _camps,_x];};} foreach AmbientZonesN;
};
if (count _camps > 0 && {random 1 < 0.7}) then {
_desTD = getmarkerpos (_camps call RETURNRANDOM);
_Lna = _desTD CALL NEARESTLOCATIONNAME;
_headerD = format ["Transport units to camp near %1",_Lna];
} else {
if ({getmarkercolor _x == "ColorBlue"} count AmbientZonesN > 0 && {random 1 < 0.3}) then {
_t = [];
{if (getmarkercolor _x == "ColorBlue") then {_t set [count _t, _x];};} foreach AmbientZonesN;
_desTD = getmarkerpos (_t call RETURNRANDOM);
_Lna = _desTD CALL NEARESTLOCATIONNAME;
_headerD = format ["Transport units to camp near %1",_Lna];
} else {
if (random 1 < 0.8 && {{getmarkercolor (_x getvariable "Gmark") == "ColorGreen"} count GuardPosts == 0}) then {
_t = [];
{if (getmarkercolor (_x getvariable "Gmark") == "ColorGreen") then {_t set [count _t, _x];};} foreach GuardPosts;
_desTD = getposATL (_t call RETURNRANDOM);
_Lna = _desTD CALL NEARESTLOCATIONNAME;
_headerD = format ["Transport units to guardpost near %1",_Lna];
} else {
_t = [];
if (count _t > 0) then {
_t = _t call RETURNRANDOM;
} else {
_t = AmbientCivN call RETURNRANDOM;
};
_desTD = getmarkerpos _t;
_Lna = _desTD CALL NEARESTLOCATIONNAME;
_headerD = format ["Transport units to %1",_Lna];
};
};
};
sleep 0.1;
_camps = [];
{_cPos = getmarkerpos _x;if (getmarkercolor _x == "ColorBlue" && {getmarkerpos _x distance _desTD > 2000}) then {_camps set [count _camps,_x];};} foreach AmbientZonesN;
if (count _camps > 0 && {random 1 < 0.5}) then {
_desT = getmarkerpos (_camps call RETURNRANDOM);
_Lna = _desT CALL NEARESTLOCATIONNAME;
_header = format ["Pick up units from camp near %1",_Lna];
} else {
if (random 1 < 0.3) then {
_t = [];
{if (getmarkerpos _x distance _desTD < 6000) then {_t set [count _t, _x];};} foreach AmbientCivN;
if (count _t > 0) then {
_t = _t call RETURNRANDOM;
} else {
_t = AmbientCivN call RETURNRANDOM;
};
_desT = getmarkerpos _t;
_Lna = _desT CALL NEARESTLOCATIONNAME;
_header = format ["Pick up units from %1",_Lna];
} else {
if (random 1 < 0.5 || {{getmarkercolor (_x getvariable "Gmark") == "ColorGreen"} count GuardPosts == 0}) then {
_desT = getmarkerpos (PierMarkers call RETURNRANDOM);
_Lna = _desT CALL NEARESTLOCATIONNAME;
_dat = (worldname CALL SAOKMAPDATA); 
_isWater = (_dat select 6);
_header = format ["Pick up units from pier near %1",_Lna];
if !(_isWater) then {_header = format ["Pick up units from passage near %1",_Lna];};
} else {
_t = [];
{if (getmarkercolor (_x getvariable "Gmark") == "ColorGreen") then {_t set [count _t, _x];};} foreach GuardPosts;
_desT = getposATL (_t call RETURNRANDOM);
_Lna = _desT CALL NEARESTLOCATIONNAME;
_header = format ["Pick up units from guardpost near %1",_Lna];
};
};
};
sleep 0.1;
if (_desTD distance _desT < 1500) exitWith {[] SPAWN TASK_AirTask1;};


_Tid = format ["TaskAir%1",NUMM];
NUMM=NUMM+1;
_desc = "One of our infantry teams need quick transport to AO, pick up them from this location and wait for more instructions. Make sure your chopper have room for 5 units.";
[
WEST, // Task owner(s)
_Tid, // Task ID (used when setting task state, destination or description later)
[_desc, _header, _header], // Task description
_desT, // Task destination
"CREATED"] call SAOKCRTASK;
NUMM=NUMM+1;
//icon = "\A3\ui_f\data\map\markers\military\pickup_CA.paa";
_time = time + 600;
_marS = format ["Aiirmar%1",NUMM];
NUMM=NUMM+1;
_mar5 = [_marS,_desT,"mil_pickup",[0.9,0.9],"ColorBlue","Pick Up Infantry"] CALL FUNKTIO_CREATEMARKER;
waitUntil {sleep 3; {vehicle _x distance _desT < 400} count ([] CALL AllPf) > 0 || {_time < time}};
if (_time < time) exitWith {deletemarker _marS;_nul = [_Tid,"FAILED"] call SAOKCOTASK;sleep 30; _n = [_Tid] CALL BIS_fnc_deleteTask;};
//SPAWN
_uCar = [FRIENDC1,FRIENDC2,FRIENDC3] call RETURNRANDOM;
_unitrate = [4,5];
_random = round(random (_unitrate select 1));
while {_random < (_unitrate select 0)} do {_random = round(random (_unitrate select 1));};
_classes = [];
while {_random > 0} do {_classes set [count _classes,_uCar call RETURNRANDOM];_random = _random - 1;};
_st2 = [_desT, 120,"(1 - sea)",""] CALL FUNKTIO_POS;
_start2 = (_st2 select 0) select 0;
_group = [_start2, WEST, _classes,[],[],[0.4,0.7]] call SpawnGroupCustom;
CantCommand set [count CantCommand,_group];
_dead = {
private ["_bol"];
_bol = false;
if (isNull _this || {{!isNull _x && {alive _x}} count units _this == 0}) then {_bol = true;};
_bol
};
_group SPAWN SAOKAISMOKEBLUE;
waitUntil {sleep 3; ({vehicle _x distance _desT < 300 && {(vehicle _x) != _x} &&  {getposATL (vehicle _x) select 2 < 1}} count ([] CALL AllPf) > 0) || {_group call _dead}};
if (_group call _dead) exitWith {deletemarker _marS;_nul = [_Tid,"FAILED"] call SAOKCOTASK;sleep 30; _n = [_Tid] CALL BIS_fnc_deleteTask;};
//GET IN
_pl = ([] CALL AllPf) call RETURNRANDOM;
{if (vehicle _x distance _desT < 300 && {(vehicle _x) != _x} &&  {getposATL (vehicle _x) select 2 < 1}) exitWith {_pl = _x};} foreach ([] CALL AllPf);
{_x assignascargo (vehicle _pl);[_x] ordergetin true;} foreach units _group;
_vP = (vehicle _pl);
waitUntil {sleep 1; !alive _vP || {{alive _x && {!(_x in vehicle _pl)}} count units _group == 0}};
if (!alive _vP) exitWith {deletemarker _marS;_nul = [_Tid,"FAILED"] call SAOKCOTASK;sleep 30; _n = [_Tid] CALL BIS_fnc_deleteTask;};
//ARE IN
deletemarker _marS;
_nul = [_Tid,"SUCCEEDED"] call SAOKCOTASK;
_Tid SPAWN {
private ["_n"];
sleep 30; _n = [_this] CALL BIS_fnc_deleteTask;
};
_Tid2 = format ["TaskAir%1",NUMM];
NUMM=NUMM+1;
_desc = "Now head to this location and drop the infantry safely there.";
[
WEST, // Task owner(s)
_Tid2, // Task ID (used when setting task state, destination or description later)
[_desc, _headerD, _headerD], // Task description
_desTD, // Task destination
"CREATED" ] call SAOKCRTASK;
NUMM=NUMM+1;

//icon = "\A3\ui_f\data\map\markers\military\join_CA.paa";
//AT DESTINATION - EXIT
_marS = format ["Aiirmar%1",NUMM];
NUMM=NUMM+1;
_mar5 = [_marS,_desTD,"mil_join",[0.9,0.9],"ColorBlue","Drop Infantry Here"] CALL FUNKTIO_CREATEMARKER;
waitUntil {sleep 3; (vehicle _pl distance _desTD < 300 && {getposATL (vehicle _pl) select 2 < 1})  || {_group call _dead} || {!alive _vP}};
if (_group call _dead || {!alive _vP}) exitWith {deletemarker _marS;_nul = [_Tid2,"FAILED"] call SAOKCOTASK;sleep 30; _n = [_Tid2] CALL BIS_fnc_deleteTask;};
deletemarker _marS;
_nul = [_Tid2,"SUCCEEDED"] call SAOKCOTASK;
_n = [WEST,550] SPAWN PrestigeUpdate;
[[550, "Transport Reward"],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
{unassignvehicle _x;[_x] ordergetin false;} foreach units _group;
waitUntil {sleep 1; {alive _x && {(_x in vehicle _pl)}} count units _group == 0};
_group move _desTD;
CAMPUNITS = CAMPUNITS + (units _group);
CantCommand = CantCommand - [_group];
//_nul = ["taskBT","FAILED"] call SAOKCOTASK;

