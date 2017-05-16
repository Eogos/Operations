

private ["_marF","_str","_nul","_ordercode","_nearest","_player","_mar","_marker","_Tid","_Lna","_header","_n"];
_player = if (isNil"_this" || {isNull _this}) then {server_object} else {_this};
_str = (([_player] CALL NEARESTVILLAGE) + "Task"); 
[_str,1] SPAWN SAOKVILSET;
_mar = format ["VilTaskM%1",NUMM];
NUMM=NUMM+1;

_marF = getposATL _player;
{if (getmarkercolor _x == "ColorRed" && {(getmarkerpos _x) distance vehicle _player < 300}) exitwith {_marF = getmarkerpos _x;};} foreach FORTRESSESMM;


_marker = [_mar,_marF, "c_unknown", [0.8,0.8], "ColorPink", "Clear hostile building complex"] CALL FUNKTIO_CREATEMARKER;
_Tid = format ["TaskCIV%1",NUMM];
NUMM=NUMM+1;
_Lna = _marF CALL NEARESTLOCATIONNAME;
_header = format ["Clear Building in %1",_Lna];
[
WEST, // Task owner(s)
_Tid, // Task ID (used when setting task state, destination or description later)
["Persians are holding house in the village. Secure the village by searching the building and nearby backyards<br/><br/><img image='rela.jpg' width='347' height='233'/>", _header, _header], // Task description
_marF, // Task destination
true // true to set task as current upon creation
] call BIS_fnc_taskCreate;


//TASK SUCCESSFULL

waitUntil {sleep 6; {alive _x && {isNil{_x getvariable "SaOkSurrendered"}}} count (_marF  nearEntities [["SoldierEB"],80]) == 0};

_str = (([_player] CALL NEARESTVILLAGE) + "Task"); 
_str CALL SAOKVILDATREM;
deleteMarker _marker;
if ({_x distance _marF < 200} count ([WEST] CALL AllPf) > 0) then {
//_n = [side _player,150] SPAWN PrestigeUpdate;
[_marF,side _player] SPAWN ADDR;
_rewardT = if (!isNil{_player getvariable "RewardSelected"}) then {_player getvariable "RewardSelected"} else {"Money"};
_n = [_rewardT,(getmarkerpos ([_player] CALL NEARESTVILLAGE)),150,_player] SPAWN CTreward;
//[[150, "Civilians helped",side _player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
_nul = [_Tid,"SUCCEEDED"] call BIS_fnc_taskSetState;

sleep 4;
[[4],"MusicT",nil,false] spawn BIS_fnc_MP;
//FRIENDLIER VILLAGE
_nearest = [_player] CALL NEARESTVILLAGE; 
_str = (_nearest + "A"); 
_str CALL SAOKIMPREL;
/////////////////////////////////////
} else {
//FAILED TASK
//_nul = [_Tid,"FAILED"] call BIS_fnc_taskSetState;
};
sleep 15;
_n = [_Tid] CALL BIS_fnc_deleteTask;