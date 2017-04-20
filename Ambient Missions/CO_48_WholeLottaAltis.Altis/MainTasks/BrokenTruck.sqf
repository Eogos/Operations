
private ["_l","_st","_start","_nul","_ordercode","_type","_veh"];
_l = (([] CALL AllPf) call RETURNRANDOM);
_st = [getposATL _l, 2500,"(1 - trees) *(1 - houses) * (1 - sea)"] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
while {{_x distance _start < 1000} count ([] CALL AllPf) > 0} do {
sleep 2;
_l = (([] CALL AllPf) call RETURNRANDOM);
_st = [getposATL _l, 2500,"(1 - houses) * (1 - sea)"] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
};

[[BaseR, localize "STR_Sp2s1r1"],"SAOKMULTIGCHAT",nil,false] spawn BIS_fnc_MP;
sleep 10;
[["", localize "STR_Sp2s1r2"],"SAOKMULTISCHAT",nil,false] spawn BIS_fnc_MP;

[
WEST, // Task owner(s)
"taskBT", // Task ID (used when setting task state, destination or description later)
["Greek army support truck have broken down and need to be fixed and returned to friendly camp.", "Fix and Return Supply Truck", "Fix and Return Supply Truck"], // Task description
_start, // Task destination
"CREATED" // true to set task as current upon creation
] call BIS_fnc_taskCreate;
waitUntil {sleep 6; {vehicle _x distance _start < 800} count ([] CALL AllPf) > 0};
_type = ["I_Truck_02_box_F","I_Truck_02_medical_F","I_Truck_02_fuel_F","I_Truck_02_Ammo_F"] call RETURNRANDOM;
_veh = createVehicle [_type, _start, [], 0, "NONE"];
_veh setdir (random 360);
_veh setvariable ["AmCrate",1];
_veh setHit [getText(configFile >> "cfgVehicles" >> _type >> "HitPoints" >> "HitLFWheel" >> "name"), 1];
_veh setHit [getText(configFile >> "cfgVehicles" >> _type >> "HitPoints" >> "HitEngine" >> "name"), 1];
waitUntil {sleep 6; isNull _veh || {!alive _veh} || {canMove _veh}};
if !(isNull _veh || {!alive _veh}) then {

["taskBT",(getmarkerpos (["ColorBlue"] CALL NEARESTCAMP))] call BIS_fnc_taskSetDestination;
["taskBT"] call BIS_fnc_taskSetCurrent;

[[leader player, localize "STR_Sp2s1r3"],"SAOKMULTISCHAT",nil,false] spawn BIS_fnc_MP;
[["You can return the truck to any current friendly camp or capture an enemy camp and bring the truck there",WEST],"HINTSAOK",nil,false] spawn BIS_fnc_MP;

waitUntil {sleep 6; isNull _veh || {!alive _veh} || {_veh distance (getmarkerpos (["ColorBlue"] CALL NEARESTCAMP)) < 50}};
if !(isNull _veh || !alive _veh) then {
_n = [side player,200] SPAWN PrestigeUpdate;
_nul = ["taskBT","SUCCEEDED"] call BIS_fnc_taskSetState;
[_start,side player] SPAWN ADDR;
[[BaseR, localize "STR_Sp2s1r4"],"SAOKMULTIGCHAT",nil,false] spawn BIS_fnc_MP;
[[200, "Supply Truck Returned",WEST],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
} else {
_nul = ["taskBT","FAILED"] call BIS_fnc_taskSetState;
};

} else {
_nul = ["taskBT","FAILED"] call BIS_fnc_taskSetState;
};
CARS = CARS + [_veh];
_veh setvariable ["AmCrate",nil];
