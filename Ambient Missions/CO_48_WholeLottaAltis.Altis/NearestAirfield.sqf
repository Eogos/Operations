private ["_places","_picked","_pp"];
_places = ["InsertionM"];
if (count AIRFIELDLOCATIONS > 0) then {_places = AIRFIELDLOCATIONS;};
_picked = (_places select 0);
_pp = vehicle player;
if (isDedicated) then {
_pp = ([] CALL AllPf) call RETURNRANDOM;
};
{if ((getmarkerpos _picked) distance _pp > (getmarkerpos _x) distance _pp) then {_picked = _x;};} foreach _places;
_picked