

private ["_tarV","_bl","_str","_nearest","_nul","_player","_curV","_size","_mar","_tarVn","_crate1","_marker","_Tid","_Lna","_header","_tarP","_n"];
_player = if (isNil"_this" || {isNull _this}) then {server_object} else {_this};
_bl = [];
_curV = ([_player] CALL NEARESTVILLAGE);
_tarV = "";
_bl = _bl + [_curV];
_size = [0,1,1,2,3] call RETURNRANDOM;
for "_i" from 0 to _size do {
_tarV = ([getposATL _player,_bl] CALL NEARESTVILLAGE);
_bl = _bl + [_tarV];
};
_str = (_curV + "Task"); 
[_str,1] SPAWN SAOKVILSET;
_mar = format ["VilTaskM%1",NUMM];
NUMM=NUMM+1;

_tarVn = (getmarkerpos _tarV) CALL NEARESTLOCATIONNAME;
_crate1 = createVehicle ["C_supplyCrate_F", [(getposATL _player select 0)+10-(random 20),(getposATL _player select 1)+10-(random 20),0], [], 0, "NONE"];
_crate1 setdir (random 360);


//_marker = [_mar,getposATL _crate1, "c_unknown", [0.8,0.8], "ColorPink", ("Deliver this crate to "+_tarVn)] CALL FUNKTIO_CREATEMARKER;
_Tid = format ["TaskCIV%1",NUMM];
NUMM=NUMM+1;
_Lna = (getmarkerpos _curV) CALL NEARESTLOCATIONNAME;
_header = format ["Deliver crate in %1 to %2",_Lna,_tarVn];
[
WEST, // Task owner(s)
_Tid, // Task ID (used when setting task state, destination or description later)
["Deliver the crate to the pointed village by using a small truck. Press shift+9 when near the crate with the truck nearby<br/><br/><img image='rela.jpg' width='347' height='233'/>", _header, _header], // Task description
(getposATL _crate1), // Task destination
true // true to set task as current upon creation
] call BIS_fnc_taskCreate;
waitUntil {sleep 3; isNull _crate1 || {!alive _crate1} || {!isNil{_crate1 getvariable "AUTOSSA"}}};
[_Tid,(getmarkerpos _tarV)] call BIS_fnc_taskSetDestination;
//TASK SUCCESSFULL
_tarP = getmarkerpos _tarV;
waitUntil {sleep 6; isNull _crate1 || {!alive _crate1} || {(_tarP distance _crate1 < 200 && {isNil{_crate1 getvariable "AUTOSSA"}})}};
//deleteMarker _marker;

if ((_tarP distance _crate1 < 200 && {isNil{_crate1 getvariable "AUTOSSA"}})) then {
_str = (_curV + "Task"); 
_str CALL SAOKVILDATREM;
//_n = [side _player,150] SPAWN PrestigeUpdate;
[_tarP,side _player] SPAWN ADDR;

_rewardT = if (!isNil{_player getvariable "RewardSelected"}) then {_player getvariable "RewardSelected"} else {"Money"};
_n = [_rewardT,(getmarkerpos _curV),150,_player] SPAWN CTreward;
//[[150, "Civilians helped",side _player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP; _n = ["Pier",getposATL player,150,player] SPAWN CTreward;
_nul = [_Tid,"SUCCEEDED"] call BIS_fnc_taskSetState;
{
//FRIENDLIER VILLAGE
(_x + "A") CALL SAOKIMPREL;
} foreach [_curV,_tarV];
};
sleep 15;
_n = [_Tid] CALL BIS_fnc_deleteTask;
sleep 300;
if !(isNull _crate1) then {deletevehicle _crate1;};