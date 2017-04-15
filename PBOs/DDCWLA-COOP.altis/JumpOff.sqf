//////////////////////////////////////////////////////////////////
// Function file for Armed Assault
// Created by: TODO: Author Name
//////////////////////////////////////////////////////////////////
private ["_unit","_veh","_Vpos"];
_unit = _this select 0;
if (isnil"_unit" || {isNull _unit}) then {};
_veh = _this select 1;
removeBackpack _unit;
_unit addbackpack "B_Parachute";
//_unit disableCollisionWith _veh; 
sleep (random 5);

_Vpos = getposATL _veh;
//sleep 2;
_unit setpos [_Vpos select 0,_Vpos select 1,(_Vpos select 2)-12];
unassignvehicle _unit;
[_unit] ordergetin false;

sleep (1.5+(random 0.5));
_unit action ["OpenParachute",_unit];

/*
[_unit, _veh] SPAWN {
private ["_unit","_veh"];
_unit = _this select 0;
_veh = _this select 1;
waitUntil {sleep 1; isNull _unit || {!alive _unit} || {vehicle _unit != _unit} || {getposATL _unit select 2 < 1}};
if (getposATL _unit select 2 > 1) then {
//vehicle _unit disableCollisionWith _veh; 
};
};
*/



