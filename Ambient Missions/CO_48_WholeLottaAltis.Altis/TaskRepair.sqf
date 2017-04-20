

private ["_str","_nul","_nearest","_player","_mar","_car","_marker","_Tid","_Lna","_header","_type","_n"];
_player = if (isNil"_this" || {isNull _this}) then {server_object} else {_this};
_str = (([_player] CALL NEARESTVILLAGE) + "Task"); 
[_str,1] SPAWN SAOKVILSET;
_mar = format ["VilTaskM%1",NUMM];
NUMM=NUMM+1;

waitUntil {sleep 3; {(_player getvariable "LastVeh") != _x} count ((getposATL _player) nearEntities [["C_SUV_01_F","C_Van_01_box_F","C_Van_01_transport_F","C_Hatchback_01_sport_F","C_Hatchback_01_F","C_Offroad_01_F","C_Quadbike_01_F"], 200]) > 0};
_car = (((getposATL _player) nearEntities [["C_SUV_01_F","C_Van_01_box_F","C_Van_01_transport_F","C_Hatchback_01_sport_F","C_Hatchback_01_F","C_Offroad_01_F","C_Quadbike_01_F"],200]) - [(_player getvariable "LastVeh")]) call RETURNRANDOM;

//_marker = [_mar,getposATL _car, "c_unknown", [0.8,0.8], "ColorPink", "Fix this car, using mechanic"] CALL FUNKTIO_CREATEMARKER;
_Tid = format ["TaskCIV%1",NUMM];
NUMM=NUMM+1;
_Lna = _car CALL NEARESTLOCATIONNAME;
_header = format ["Repair Car in %1",_Lna];
[
WEST, // Task owner(s)
_Tid, // Task ID (used when setting task state, destination or description later)
["One of the villagers have trouble with his car. Check and try fix it with an engineer<br/><br/><img image='rela.jpg' width='347' height='233'/>", _header, _header], // Task description
(getposATL _car), // Task destination
true // true to set task as current upon creation
] call BIS_fnc_taskCreate;

_car setvariable ["TaskCar",1];
_type = typeOf _car;
_car setHit [getText(configFile >> "cfgVehicles" >> _type >> "HitPoints" >> "HitLFWheel" >> "name"), 1];
_car setHit [getText(configFile >> "cfgVehicles" >> _type >> "HitPoints" >> "HitEngine" >> "name"), 1];
//TASK SUCCESSFULL
waitUntil {sleep 6; isNull _car || !alive _car || canMove _car};
//deleteMarker _marker;
if (!alive _car) then {_car setvariable ["TaskCar",nil];};
if (canMove _car) then {
_car setvariable ["TaskCar",nil];
_str = (([_player] CALL NEARESTVILLAGE) + "Task"); 
_str CALL SAOKVILDATREM;
_rewardT = if (!isNil{_player getvariable "RewardSelected"}) then {_player getvariable "RewardSelected"} else {"Money"};
_n = [_rewardT,(getmarkerpos ([_player] CALL NEARESTVILLAGE)),50,_player] SPAWN CTreward;
//_n = [side _player,50] SPAWN PrestigeUpdate;
//[[50, "Civilians helped",side _player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
_nul = [_Tid,"SUCCEEDED"] call BIS_fnc_taskSetState;
[(getposATL _car),side _player] SPAWN ADDR;
//FRIENDLIER VILLAGE
_nearest = [_player] CALL NEARESTVILLAGE; 
_str = (_nearest + "A"); 
_str CALL SAOKIMPREL;
};
sleep 15;
_n = [_Tid] CALL BIS_fnc_deleteTask;