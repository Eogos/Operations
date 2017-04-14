private ["_time","_wp1","_tg1wp1","_posPl","_class","_random","_unitrate","_tg1","_tank","_mecOrNot","_header","_Lna","_Tid","_marS","_size","_start2","_st2","_timer","_locationA","_marrr","_uCar","_VarVEH","_ALLunits","_VEHs","_INFgroups","_VEHgroups","_classes","_group","_l","_nul","_n","_ran","_ordercode","_mar5","_ker"];
//INIT
_VEHgroups = [];
_INFgroups = [];
_VEHs = [];
_ALLunits = [];
_VarVEH = (ARMEDVEHICLES select 1)+(ARMEDTANKS select 1);
_uCar =[ENEMYC1,ENEMYC2,ENEMYC3] call RETURNRANDOM;
_marrr = (_this select 0);
_locationA = getmarkerpos (_this select 0);
_timer = time + (180 + (random 500));
_st2 = [_locationA, 1200,"(1 - forest) * (1 - sea) * (1 - houses)",1] CALL FUNKTIO_POS;
_start2 = (_st2 select 0) select 0;
_size = 1200;
while {{_start2 distance _x < 500} count VarBlackListE > 0 || {{_start2 distance _x < 500} count VarBlackListF > 0} || {{_x distance _start2 < 900} count ([] CALL AllPf) > 0} || {_start2 distance _locationA < 900}} do {
sleep 1;
_st2 = [_locationA, _size,"(1 - forest) * (1 - sea) * (1 - houses)",1] CALL FUNKTIO_POS;
_start2 = (_st2 select 0) select 0;
_size = _size + 100;
};
_marS = format ["LINEmar%1",NUMM];
NUMM=NUMM+1;
//_mar5 = [_marS,_locationA,"Select",[0.9,0.9],"ColorBlack","Assist to Defend"] CALL FUNKTIO_CREATEMARKER;
//hint "Look for map, where the help is needed. You can fast travel to the AO via 0-0-2";
_Tid = format ["TaskBat%1",NUMM];
_TidE = format ["TaskBatE%1",NUMM];
NUMM=NUMM+1;
_Lna = _locationA CALL NEARESTLOCATIONNAME;
_header = format ["Defend camp against counterattack near %1",_Lna];
[
WEST, // Task owner(s)
_Tid, // Task ID (used when setting task state, destination or description later)
["Enemy is trying to take back the camp. Should we hold it or step back?", _header, _header], // Task description
_locationA, // Task destination
"CREATED" // true to set task as current upon creation
] call BIS_fnc_taskCreate;
_header = format ["Take part in counterattack near %1",_Lna];
[
EAST, // Task owner(s)
_TidE, // Task ID (used when setting task state, destination or description later)
["We are commiting counter-attack on camp that we just lost. Care to join?", _header, _header], // Task description
_locationA, // Task destination
"CREATED" // true to set task as current upon creation
] call BIS_fnc_taskCreate;
_ran = ["STR_Sp8t1r1","STR_Sp8t1r1a","STR_Sp8t1r1b","STR_Sp8t1r1c"] call BIS_fnc_selectRandom;
[[BaseR, localize _ran],"SAOKMULTIGCHAT",nil,false] spawn BIS_fnc_MP;
sleep 20;

//CLOSE
_mecOrNot = [0,1] call RETURNRANDOM;
_size = [0,0,0,0,0,1,1,1] call RETURNRANDOM;
for "_i" from 0 to _size do {
_tank = _VarVEH call BIS_fnc_selectRandom;	
_tg1 = [[(_start2 select 0)-30+(random 60),(_start2 select 1)-30+(random 60),0], 0, _tank, EAST] call BIS_fnc_spawnVehicle;
_VEHgroups = _VEHgroups + [(_tg1 select 2)];
_VEHs = _VEHs + [(_tg1 select 0)];
(_tg1 select 0) forcespeed 3;
_unitrate = [4,5];
_random = round(random (_unitrate select 1));
while {_random < (_unitrate select 0)} do {_random = round(random (_unitrate select 1));};
_classes = [];
while {_random > 0} do {_classes set [count _classes,_uCar call RETURNRANDOM];_random = _random - 1;};
_group = [[(_start2 select 0)+40,(_start2 select 1)+30,0], EAST, _classes,[],[],[0.4,0.7]] call SpawnGroupCustom;
_INFgroups = _INFgroups + [_group];
if (_mecOrNot == 1 && {_tank in ["O_APC_Wheeled_02_rcws_F","O_APC_Tracked_02_cannon_F"]}) then {
{_x moveincargo (_tg1 select 0);}foreach units _group;
_group SPAWN {waitUntil {sleep 3; {alive _x} count units _this == 0|| {behaviour leader _this == "COMBAT"}}; if !({alive _x} count units _this == 0) then {{unassignvehicle _x;} foreach units _this;(units _this) ordergetin false;};};
};
};
{_ALLunits = _ALLunits + (units _x);} foreach _VEHgroups + _INFgroups;

//AIR SUPPORT
if (random 1 < 0.3 && {_size < 1}) then {
_class = ["O_Heli_Attack_02_F","O_Heli_Attack_02_black_F","O_Heli_Light_02_F","O_UAV_02_F","O_UAV_02_F"]; 
_class = _class call RETURNRANDOM;	
_l = getposATL vehicle (([] CALL AllPf)call RETURNRANDOM);
_tg1 = [[(_l select 0)+2500,(_l select 1)+2500,50], 0, _class, EAST] call SPAWNVEHICLE;
_posPl = [(_l select 0) + 100 -(random 200), (_l select 1)+ 100 -(random 200), 0];
_tg1wp1= (_tg1 select 2) addWaypoint [_locationA, 0]; 
[(_tg1 select 2), 1] setWaypointBehaviour "AWARE";
[(_tg1 select 2), 1] setWaypointType "GUARD";
_nul = [(_tg1 select 2), [1541.39,5059.05,0],200] SPAWN FUNKTIO_MAD;
};
//BEGIN ATTACK
{
_tg1wp1= _x addWaypoint [_locationA, 0]; 
[_x, 1] setWaypointBehaviour "COMBAT";
} foreach _VEHgroups;
{
_wp1 = _x addWaypoint [_locationA, 0];
[_x, 1] setWaypointCombatMode "RED";
[_x, 1] setWaypointType "GUARD";
} foreach _INFgroups;


_time = time + 600;
_ran = ["STR_Sp8t1r4","STR_Sp8t1r4a","STR_Sp8t1r4b"] call BIS_fnc_selectRandom;
[[BaseR, localize _ran],"SAOKMULTIGCHAT",nil,false] spawn BIS_fnc_MP;
_ker = (count _ALLunits)*0.2;
waitUntil {sleep 9; {alive _x && {!(fleeing _x)}} count _ALLunits < _ker || {_time < time}  ||  {getmarkercolor _marrr ==  "ColorRed"}};
if (getmarkercolor _marrr ==  "ColorRed") then {
//END2
{
VehicleGroups set [count VehicleGroups,_x];
} foreach _VEHgroups;
{
CARS set [count CARS,_x];
_x setvariable ["EndS",1];
} foreach _VEHs;
{
Pgroups set [count Pgroups,_x];
} foreach _INFgroups;
_n = [getMarkerPos _marrr,"EAST"] CALL GuardPostSide;
[getMarkerPos _marrr,EAST] SPAWN ADDR;
_nul = [_Tid,"FAILED"] call BIS_fnc_taskSetState;
_nul = [_TidE,"SUCCEEDED"] call BIS_fnc_taskSetState;
_marrr setmarkercolor "ColorRed";

_ran = ["STR_Sp8t1r3","STR_Sp8t1r3a","STR_Sp8t1r3b"] call BIS_fnc_selectRandom;
[["Enemy attack succeeded. You lost camp",WEST],"HINTSAOK",nil,false] spawn BIS_fnc_MP;
[[BaseR, localize _ran],"SAOKMULTIGCHAT",nil,false] spawn BIS_fnc_MP;

//deletemarker _mar5;
} else {
//END C
{
VehicleGroups set [count VehicleGroups,_x];
} foreach _VEHgroups;
{
CARS set [count CARS,_x];
_x setvariable ["EndS",1];
} foreach _VEHs;
{
Pgroups set [count Pgroups,_x];
} foreach _INFgroups;
[getMarkerPos _marrr,WEST] SPAWN ADDR;
_nul = [_Tid,"SUCCEEDED"] call BIS_fnc_taskSetState;
_nul = [_TidE,"FAILED"] call BIS_fnc_taskSetState;
//_nul = [] SPAWN {VarPG = VarPG - 1;sleep 900;VarPG = VarPG + 1;};
_ran = ["STR_Sp8t1r2","STR_Sp8t1r2a","STR_Sp8t1r2b"] call BIS_fnc_selectRandom;
[["Enemy attack didnt succeed",WEST],"HINTSAOK",nil,false] spawn BIS_fnc_MP;
[[BaseR, localize _ran],"SAOKMULTIGCHAT",nil,false] spawn BIS_fnc_MP;
//deletemarker _mar5;
};



sleep 60;
_n = [_Tid] CALL BIS_fnc_deleteTask;
_n = [_TidE] CALL BIS_fnc_deleteTask;