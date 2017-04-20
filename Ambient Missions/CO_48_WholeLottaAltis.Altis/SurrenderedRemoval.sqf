
private ["_unit", "_pos", "_t"];
//////////////////////////////////////////////////////////////////
// Function file for Armed Assault
// Created by: TODO: Author Name
//////////////////////////////////////////////////////////////////

_unit = _this select 0;
_pos = position _unit;
sleep 40 + (random 20);
_t=0;
while {!(isNUll _unit) && ({(vehicle _x) distance _unit < 220} count ([WEST] CALL AllPf) > 0 && (_t < 13))} do {sleep 25; _t=_t+1;};
while {!(isNUll _unit) && {(vehicle _x) distance _unit < 120} count ([WEST] CALL AllPf) > 0} do {sleep 25;};
while {!(isNUll _unit) && {(vehicle _x) distance _unit < 100} count ([WEST] CALL AllPf) > 0} do {sleep 25;};
if (isNull _unit) then {} else {deletevehicle _unit;};



