private ["_p","_pU","_s"];
_p = [];
_pU = (playableUnits+switchableUnits);
_s = (_this select 0);
if (count _this > 1) then {
if ((_this select 0) == WEST) then {_s = EAST;} else {_s = WEST;};
};
{if (isPlayer _x && {count _this == 0 || {side _x == _s}} && {!surfaceisWater getposATL _x}) then {_p set [count _p,_x];};} foreach _pU;
if (count _p == 0) then {_p = [dataStorageS];};
_p