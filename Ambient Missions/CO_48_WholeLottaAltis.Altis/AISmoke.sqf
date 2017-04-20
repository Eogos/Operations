

private ["_unit", "_group"];


_unit = _this select 0;
waituntil {sleep 4; isNil"_unit" || {behaviour _unit == "COMBAT"} || {!(alive _unit)}};
if (!isNil"_unit" && alive _unit) then {

if (!(daytime < 3.5 || {daytime > 21})) then {
_unit addmagazine "SmokeShell";
sleep 1;
_unit forceWeaponFire ["SmokeShellMuzzle","SmokeShellMuzzle"];
} else {
_unit addmagazine "Chemlight_red";
sleep 1;
_unit forceWeaponFire ["ChemlightRedMuzzle","ChemlightRedMuzzle"];
};

_group = (units (group _unit) - [_unit]);
if ((count _group)> 1) then {
_unit = _group call RETURNRANDOM;
_unit addmagazine "SmokeShell";
sleep 1;
_unit forceWeaponFire ["SmokeShellMuzzle","SmokeShellMuzzle"];
};
_group = units group _unit - [_unit, leader _unit];
if ((count _group)> 1) then {
_unit = _group call RETURNRANDOM;
_unit addmagazine "SmokeShell";
sleep 1;
_unit forceWeaponFire ["SmokeShellMuzzle","SmokeShellMuzzle"];
_group = (units group _unit) - [_unit];
if ((count _group)> 1) then {
_unit = _group call RETURNRANDOM;
_unit suppressFor (6+(random 10)); 
};
};


};