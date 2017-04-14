private ["_places","_picked","_pp"];
_places = [];
if (count GuardPosts > 0) then {_places = GuardPosts;};
_picked = objNull;
if (count _places > 0) then {
_picked = (_places select 0);
if (count _this > 0) then {
{if (_picked distance (_this select 0) > _x distance (_this select 0)) then {_picked = _x;};} foreach _places;
} else {
_pp = vehicle player;
if (isDedicated) then {
_pp = ([] CALL AllPf) call RETURNRANDOM;
};
{if (_picked distance _pp > _x distance _pp) then {_picked = _x;};} foreach _places;
};
};
_picked