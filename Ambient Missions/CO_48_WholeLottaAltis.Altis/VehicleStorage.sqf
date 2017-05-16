
//CHECK CarRemoval.sqf
SaOkVehicleData = [];
AddIdVeh = [];
//0 ID 1 CLASS 2 POS 3 DIR 4 FUEL 5 DAMAGE 6 MINETRUCK OR NOT
[] SPAWN {
waitUntil {sleep 1; !isNil"StartMission"};
_idV = (count SaOkVehicleData) + 1;
while {true} do {
sleep 2;
{if (isNil{_x getvariable "VehID"}) then {_x setvariable ["VehID",_idV]; _idV = _idV + 1;};AddIdVeh = AddIdVeh - [_x];} foreach AddIdVeh;

_vehs = [];
{
if (vehicle _x != _x && {!((vehicle _x) in _vehs)} && {!(typeOf (vehicle _x) in ["I_static_AT_F","I_static_AA_F","I_HMG_01_F","I_HMG_01_high_F","I_GMG_01_F","I_GMG_01_high_F","O_static_AT_F","O_static_AA_F","O_HMG_01_F","O_HMG_01_high_F","O_GMG_01_F","O_GMG_01_high_F"])}) then {
_vehs set [count _vehs, (vehicle _x)];
};
} foreach ([] CALL AllPf);
sleep 2;
{
_veh = ([] CALL AllPf)call RETURNRANDOM;
if (isNil{_veh getvariable "VehID"}) then {_veh setvariable ["VehID",_idV]; _idV = _idV + 1;};
if (!isNil{_veh getvariable "VehID"}) then {
if ({_x select 0 == (_veh getvariable "VehID")} count SaOkVehicleData > 0) then {
if((SaOkVehicleData select ((count SaOkVehicleData) - 1)) select 0 != _veh getvariable "VehID") then {
{
if (_x select 0 == _veh getvariable "VehID") exitWith {
_ar = + _x;
SaOkVehicleData = [SaOkVehicleData,_forEachIndex] call BIS_fnc_removeIndex;
SaOkVehicleData set [count SaOkVehicleData,_ar];
};
} foreach SaOkVehicleData;
};
};
};
} foreach _vehs;

};
};


[] SPAWN {
while {true} do {
sleep 3;
{
private ["_id","_car"];
_id = _x select 0;
if ({_x getvariable "VehID" == _id} count vehicles == 0 && {{_x distance (_x select 2) < 700} count ([] CALL AllPf) > 0}) then {
_car = createVehicle [_x select 1,_x select 2, [], 0, "form"];
_car setdir (_x select 3);
_car setfuel (_x select 4);
_car setdamage (_x select 5);
_car setvariable ["VehID",_id];
if ((_x select 6) == 1) then {_car setvariable ["MineTruck",1];};
CARS set [count CARS,_car];
};
} foreach SaOkVehicleData;
};

};


