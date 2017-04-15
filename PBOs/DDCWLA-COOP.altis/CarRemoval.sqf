//////////////////////////////////////////////////////////////////
// Function file for Armed Assault
// Created by: TODO: Author Name
//////////////////////////////////////////////////////////////////

private ["_car","_dead","_counted","_nul","_ran","_obj","_pos","_dir","_Mm","_newAr","_forEachIndex","_ok","_id","_price","_typeOf","_class","_type"];

_car = _this select 0;
if (count vehicles > 60 && {{(vehicle _x) distance _car < 400} count ([] CALL AllPf) == 0} && {isNil{_veh getvariable "VehID"}}) exitWith {CARS = CARS - [_car];deletevehicle _car;};
if (random 1 < 0.2 && {(typeOf _car) isKindOf "Car"} && {([] CALL FPSGOOD)} && {isOnRoad getposATL _car} && {isNil{_car getvariable "OnRoad"}} && {count Allunits < 100}) then {_nul = [_car] SPAWN FWreckOnRoad;};
CARS = CARS - [_car];
if (isnull _car) exitWith {};
sleep 60;
_dead = 0;
_counted = (count crew _car) - _dead;
while {{(vehicle _x) distance _car < 400} count ([] CALL AllPf) > 0 && {!isnull _car}} do {
	sleep 5;
	_dead = 0;
	{if (alive _x) then {} else {_dead = _dead + 1};} foreach crew _car;
	_counted = (count crew _car) - _dead;
	if (_counted > 0) exitWith {CARS set [count CARS,_car];};
	if (isnull _car) exitWith {};
};
if (_counted > 0) exitWith {};
if (isnull _car) exitWith {};
_counted = (count crew _car) - _dead;	
if (_counted > 0) then {CARS set [count CARS,_car];} else {
_class = "";
_type = typeof _car;


if (_class != "") then {
_pos = getposATL _car;
_dir = direction _car;
deletevehicle _car;
_obj = createVehicle [_class, _pos, [], 0, "NONE"]; 
_obj setdir (_dir + 180);
_obj setvectorup (surfaceNormal (getposATL _obj));
if (random 1 < 0.5) then {
_ran = 1 + (random 4);
};
if (_class == "T72Wreck") then {
_obj = createVehicle ["T72WreckTurret", [(_pos select 0)+(random 20)-(random 20),(_pos select 1)+(random 30)-(random 30), 0], [], 0, "NONE"]; 
_obj setdir (random 360);
_obj setvectorup (surfaceNormal (getposATL _obj));
};
} else {
if (!isNil{_car getvariable "VehID"}) then {
if (alive _car) then {
_ok = 0;
{
if (_car getvariable "VehID" == _x select 0) exitWith {
_Mm = 0;
if (!isNil{_car getvariable "MineTruck"}) then {_Mm = 1;};
_newAr = [_car getvariable "VehID",typeOf _car,getposATL _car, direction _car,fuel _car, damage _car, _Mm];
SaOkVehicleData set [_forEachIndex,_newAr];
_ok = 1;
};
} foreach SaOkVehicleData;
if (_ok == 0) then {
_Mm = 0;
if (!isNil{_car getvariable "MineTruck"}) then {_Mm = 1;};
_newAr = [_car getvariable "VehID",typeOf _car,getposATL _car, direction _car,fuel _car, damage _car, _Mm];
SaOkVehicleData = SaOkVehicleData + [_newAr];
};
if (count SaOkVehicleData > 50) then {
_id = (SaOkVehicleData select 0) select 0;
{
if (!isNil{_x getvariable "VehID"}) then {
if (_id == _x getvariable "VehID") exitWith {_x setvariable ["VehID",nil];};
};
} foreach vehicles; 
SaOkVehicleData = [SaOkVehicleData,0] call BIS_fnc_removeIndex;
};
} else {
{
if (_car getvariable "VehID" == _x select 0) exitWith {
SaOkVehicleData = [SaOkVehicleData,_forEachIndex] call BIS_fnc_removeIndex;
};
} foreach SaOkVehicleData;
};
};
if (!isNil{_car getvariable "REFUND"} && {alive _car} && {damage _car < 0.5}) then {
_typeOf = (_car getvariable "REFUND");
if (_typeOf in ["Mortar","Scorcher","Sandstorm"]) then {
_n = [(getposATL _car), "ColorBlue",[typeOf _car],"b_art"] CALL AddVehicleZone;
} else {
if ((typeOf _car) isKindOf "Truck_F") then {
_n = [(getposATL _car), "ColorBlue",[typeOf _car],"b_support"] CALL AddVehicleZone;
} else {
_n = [(getposATL _car), "ColorBlue",[typeOf _car]] CALL AddVehicleZone;
};
};
};
deletevehicle _car;
};
};

//["BMP2Wreck","BRDMWreck","hiluxWreck","datsun02Wreck","T72Wreck","T72WreckTurret","UralWreck","UAZWreck"]
