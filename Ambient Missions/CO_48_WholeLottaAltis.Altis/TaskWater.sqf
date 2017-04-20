
private ["_str","_player","_mar","_mP","_marker","_ordercode","_Tid","_Lna","_header","_nul","_nearest","_n"];
_player = if (isNil"_this" || {isNull _this}) then {server_object} else {_this};
_str = (([_player] CALL NEARESTVILLAGE) + "Task"); 
[_str,1] SPAWN SAOKVILSET;
_mar = format ["VilTaskM%1",NUMM];
NUMM=NUMM+1;

_mP = getmarkerpos ([_player] CALL NEARESTVILLAGE);
_mP = [(_mP select 0),(_mP select 1)+5,0];
//_marker = [_mar,_mP, "c_unknown", [0.8,0.8], "ColorPink", "Bring barrel of water to the village"] CALL FUNKTIO_CREATEMARKER;



_Tid = format ["TaskCIV%1",NUMM];
NUMM=NUMM+1;
_Lna = _mp CALL NEARESTLOCATIONNAME;
_header = format ["Bring Water to %1",_Lna];
[
WEST, // Task owner(s)
_Tid, // Task ID (used when setting task state, destination or description later)
["This village is running low with water. Purchase waterbarrel in any friendly camp and bring it to the village using small truck (shift+9 to load and unload)<br/><br/><img image='rela.jpg' width='347' height='233'/>", _header, _header], // Task description
_mP, // Task destination
true // true to set task as current upon creation
] call BIS_fnc_taskCreate;


//TASK SUCCESSFULL
waitUntil {sleep 6; {isNil{_x getvariable "AUTOSSA"}} count (nearestObjects [_mP, ["Land_BarrelWater_F"], 50]) > 0};
_str = (([_player] CALL NEARESTVILLAGE) + "Task"); 
{if (isNil{_x getvariable "AUTOSSA"}) then {_x SPAWN {sleep 3; deletevehicle _this;};};} foreach (nearestObjects [_mP, ["Land_BarrelWater_F"], 50]);
_str CALL SAOKVILDATREM;
//deleteMarker _marker;
//_n = [side _player,150] SPAWN PrestigeUpdate;
//[[150, "Civilians helped",side _player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
_rewardT = if (!isNil{_player getvariable "RewardSelected"}) then {_player getvariable "RewardSelected"} else {"Money"};
_n = [_rewardT,(getmarkerpos ([_player] CALL NEARESTVILLAGE)),150,_player] SPAWN CTreward;
_nul = [_Tid,"SUCCEEDED"] call BIS_fnc_taskSetState;
[_mP,side _player] SPAWN ADDR;
//FRIENDLIER VILLAGE
_nearest = [_player] CALL NEARESTVILLAGE; 
_str = (_nearest + "A"); 
_str CALL SAOKIMPREL;
sleep 15;
_n = [_Tid] CALL BIS_fnc_deleteTask;