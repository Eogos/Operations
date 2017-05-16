

private ["_wp","_st2","_start2","_Lpos","_normal2","_home","_str","_nul","_ordercode","_nearest","_player","_mar","_h","_mP","_marker","_Tid","_Lna","_header","_ran","_group","_civ","_startC","_ra","_chop","_obj","_aika","_n"];
_player = if (isNil"_this" || {isNull _this}) then {server_object} else {_this};
_str = (([_player] CALL NEARESTVILLAGE) + "Task"); 
[_str,1] SPAWN SAOKVILSET;
_mar = format ["VilTaskM%1",NUMM];
NUMM=NUMM+1;
_home = getmarkerpos ([_player] CALL NEARESTVILLAGE);
_h = ([_player] CALL NEARESTVILLAGE);
_mP = [(_home select 0),(_home select 1)+5,0];
//_marker = [_mar,_mP, "c_unknown", [0.8,0.8], "ColorPink", "Defend the village until chopper have picked the villager away"] CALL FUNKTIO_CREATEMARKER;
_Tid = format ["TaskCIV%1",NUMM];
NUMM=NUMM+1;
_Lna = _mP CALL NEARESTLOCATIONNAME;
_header = format ["Escort CIV to Chopper in %1",_Lna];
[
WEST, // Task owner(s)
_Tid, // Task ID (used when setting task state, destination or description later)
["Local civilian is in trouble and will need to be protected until chopper comes to pick him up to safety<br/><br/><img image='rela.jpg' width='347' height='233'/>", _header, _header], // Task description
_home, // Task destination
true // true to set task as current upon creation
] call BIS_fnc_taskCreate;
//hint "Hint: Use construction truck near the village";
_ran = FRIENDC4 call RETURNRANDOM;
_group = creategroup WEST;
_civ = _group createUnit [_ran, _home, [], 0, "form"];
_civ setvariable ["CivNo",1];
_civ allowfleeing 0; _civ setbehaviour "CARELESS"; _civ disableAI "MOVE";
removeallweapons _civ;
_civ setvariable ["DAPPED",true];
DONTDELGROUPS = DONTDELGROUPS + [_group];
//ENEMY ATTACKS
{while {(count (waypoints _x)) > 0} do {
deleteWaypoint ((waypoints _x) select 0);
};  
_wp = _x addWaypoint [[(getposATL _civ select 0) + 50 - (random 100),(getposATL _civ select 1) + 50 - (random 100),0], 0];
} foreach  Pgroups + VehicleGroups;
sleep 240;
//CHOPPER PART
//Chopper
_startC = [(getmarkerpos "WestChopStart") select 0, (getmarkerpos "WestChopStart") select 1, 50];
_ra = "B_Heli_Transport_01_F";
_chop = [_startC, 180, _ra, WEST] call SPAWNVEHICLE;
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
DONTDELGROUPS = DONTDELGROUPS - [_group];
deletevehicle _obj;
_nul = [(_chop select 2), (getmarkerpos "WestChopStart"), 7] SPAWN FMoveAndDelete; 
_civ SPAWN {waitUntil {sleep 10; {_this distance vehicle _x < 700} count ([] CALL AllPf) == 0}; deletevehicle _this;};
//TASK SUCCESSFULL
waitUntil {sleep 6; !alive _civ || {_civ distance _home > 150}};
_str = (_h + "Task"); 
_str CALL SAOKVILDATREM;
//deleteMarker _marker;
if (alive _civ) then {
//_n = [side _player,150] SPAWN PrestigeUpdate;
[_tarP,side _player] SPAWN ADDR;
_rewardT = if (!isNil{_player getvariable "RewardSelected"}) then {_player getvariable "RewardSelected"} else {"Money"};
_n = [_rewardT,(getmarkerpos ([_player] CALL NEARESTVILLAGE)),150,_player] SPAWN CTreward;
//[[150, "Civilians helped",side _player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
_nul = [_Tid,"SUCCEEDED"] call BIS_fnc_taskSetState;
sleep 4;
[[4],"MusicT",nil,false] spawn BIS_fnc_MP;
//FRIENDLIER VILLAGE
_str = (_nearest + "A"); 
_str CALL SAOKIMPREL;
/////////////////////////////////////
} else {
_nul = [_Tid,"FAILED"] call BIS_fnc_taskSetState;
//FAILED TASK
["ScoreRemoved",["Civilian died",40]] call bis_fnc_showNotification;
};
sleep 15;
_n = [_Tid] CALL BIS_fnc_deleteTask;