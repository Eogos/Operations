private ["_places","_picked","_pp"];
_places = [objNull];
if (count FACTORYLOCATIONS > 0) then {_places = FACTORYLOCATIONS;};
_picked = (_places select 0);
_pp = vehicle player;
if (isDedicated) then {
_pp = ([] CALL AllPf) call RETURNRANDOM;
};
if (count _this > 0) then {_pp = _this select 0;};
{if ((position _picked) distance _pp > (position _x) distance _pp) then {_picked = _x;};} foreach _places;
_picked