
private ["_str","_nul","_nearest","_player","_mar","_home","_mP","_marker","_Tid","_ran","_group","_civ","_n"];
_player = if (isNil"_this" || {isNull _this}) then {server_object} else {_this};
_nearest = ([_player] CALL NEARESTVILLAGE);
_str = (_nearest + "Task"); 
[_str,1] SPAWN SAOKVILSET;
_mar = format ["VilTaskM%1",NUMM];
NUMM=NUMM+1;
_home = getmarkerpos ([_player] CALL NEARESTVILLAGE);
_mP = getmarkerpos (["ColorRed"] CALL NEARESTCAMP);
_mP = [(_mP select 0),(_mP select 1)+5,0];
//_marker = [_mar,_mP, "c_unknown", [0.8,0.8], "ColorPink", "Find and free civilian held in this camp"] CALL FUNKTIO_CREATEMARKER;

_Tid = format ["TaskCIV%1",NUMM];
NUMM=NUMM+1;
[
WEST, // Task owner(s)
_Tid, // Task ID (used when setting task state, destination or description later)
["Rescue civilian POW that is held in this hostile camp<br/><br/><img image='rela.jpg' width='347' height='233'/>", "Release POW", "Release POW"], // Task description
_mP, // Task destination
true // true to set task as current upon creation
] call BIS_fnc_taskCreate;

//hint "Hint: Use construction truck near the village";
_ran = CIVS1 call RETURNRANDOM;
_group = creategroup civilian;
_civ = _group createUnit [_ran, _mP, [], 0, "form"];
_civ setvariable ["CivNo",1];
DONTDELGROUPS = DONTDELGROUPS + [_group];
_civ allowfleeing 0; _civ setbehaviour "CARELESS"; _civ disableAI "MOVE";
waitUntil {sleep 6; !alive _civ || {{_civ distance _x < 20} count ([WEST] CALL AllPf) > 0}};
_civ enableAI "MOVE";
_civ setspeedmode "FULL";
_civ setbehaviour "AWARE";
_civ domove _home;
_civ SPAWN {waitUntil {sleep 10; _this distance vehicle player > 700}; deletevehicle _this;};
//TASK SUCCESSFULL
waitUntil {sleep 6; !alive _civ || {_civ distance _mP > 50}};
DONTDELGROUPS = DONTDELGROUPS - [_group];
//_str = (([_player] CALL NEARESTVILLAGE) + "Task"); 
_str CALL SAOKVILDATREM;
//deleteMarker _marker;
if (alive _civ) then {
//_n = [side _player,150] SPAWN PrestigeUpdate;
[_mP,side _player] SPAWN ADDR;
_rewardT = if (!isNil{_player getvariable "RewardSelected"}) then {_player getvariable "RewardSelected"} else {"Money"};
_n = [_rewardT,(getmarkerpos ([_player] CALL NEARESTVILLAGE)),150,_player] SPAWN CTreward;
//[[150, "Civilians helped",side _player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;

_nul = [_Tid,"SUCCEEDED"] call BIS_fnc_taskSetState;
_nul = [4] SPAWN MusicT;
//FRIENDLIER VILLAGE
//_nearest = [] CALL NEARESTVILLAGE; 
_str = (_nearest + "A"); 
_str CALL SAOKIMPREL;
/////////////////////////////////////
} else {
_nul = [_Tid,"FAILED"] call BIS_fnc_taskSetState;
//FAILED TASK
["ScoreRemoved",["Civilian POW died",40]] call bis_fnc_showNotification;
};
sleep 15;
_n = [_Tid] CALL BIS_fnc_deleteTask;