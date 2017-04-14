

private ["_str","_nul","_ordercode","_nearest","_player","_mar","_mP","_marker","_Tid","_Lna","_header","_n"];
_player = if (isNil"_this" || {isNull _this}) then {server_object} else {_this};
_str = (([_player] CALL NEARESTVILLAGE) + "Task"); 
[_str,1] SPAWN SAOKVILSET;
_mar = format ["VilTaskM%1",NUMM];
NUMM=NUMM+1;
_mP = getmarkerpos ([_player] CALL NEARESTVILLAGE);
_mP = [(_mP select 0),(_mP select 1)+5,0];
//_marker = [_mar,_mP, "c_unknown", [0.8,0.8], "ColorPink", "Create guarpost in the village with at least one static weapon"] CALL FUNKTIO_CREATEMARKER;
_Tid = format ["TaskCIV%1",NUMM];
NUMM=NUMM+1;
_Lna = _mP CALL NEARESTLOCATIONNAME;
_header = format ["Create Guardpost in %1",_Lna];
_tP = (getmarkerpos ([_player] CALL NEARESTVILLAGE));
_tV = ([_player] CALL NEARESTVILLAGE);
[
WEST, // Task owner(s)
_Tid, // Task ID (used when setting task state, destination or description later)
["Villagers are worried of their safety and want you to establish a guardpost in their village<br/><br/><img image='rela.jpg' width='347' height='233'/>", _header, _header], // Task description
_tP, // Task destination
true // true to set task as current upon creation
] call BIS_fnc_taskCreate;

//TASK SUCCESSFULL

waitUntil {sleep 6; _tP distance (getposATL ([_tP] CALL RETURNGUARDPOST)) < 500 && count (([_tP] CALL RETURNGUARDPOST) getvariable "StaticW") > 0};

_str = (_tV + "Task"); 
_str CALL SAOKVILDATREM;
//deleteMarker _marker;
if (true) then {
//_n = [side _player,150] SPAWN PrestigeUpdate;
[_tP,side _player] SPAWN ADDR;
_rewardT = if (!isNil{_player getvariable "RewardSelected"}) then {_player getvariable "RewardSelected"} else {"Money"};
_n = [_rewardT,(getmarkerpos ([_player] CALL NEARESTVILLAGE)),150,_player] SPAWN CTreward;
//[[150, "Guardpost Created",side _player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
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

};
sleep 15;
_n = [_Tid] CALL BIS_fnc_deleteTask;