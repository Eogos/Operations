private ["_places","_picked","_pp"];
_places = ["InsertionM"];
if (count AmbientCivN > 0) then {
_places = AmbientCivN + AmbientZonesN + ["AirC","AirC_1","AirC_2","AirC_3","AirC_4"];
};
_picked = (_places select 0);
_pp = vehicle player;
if (isDedicated) then {
_pp = ([] CALL AllPf) call RETURNRANDOM;
};
{if ((getmarkerpos _picked) distance _pp > (getmarkerpos _x) distance _pp) then {_picked = _x;};} foreach _places;
_picked