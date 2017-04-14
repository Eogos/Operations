private ["_places","_picked","_cen","_col","_t0","_bList"];
_places = ["InsertionM"];
if (count AmbientZonesN > 0) then {_places = AmbientZonesN;};
_picked = (_places select 0);
_cen = vehicle player;
if (isDedicated) then {
_cen = ([] CALL AllPf) call RETURNRANDOM;
};
_bList = [];
if (count _this > 2) then {_bList = _this select 2;};
if (count _this > 1) then {_cen = _this select 1;};
if (count _this > 0) then {
_t0 = (_this select 0);
{_col = getmarkercolor _x;if (((_col  == _t0 && (getmarkerpos _picked) distance _cen > (getmarkerpos _x) distance _cen) || {(_col  == _t0 && getmarkercolor _picked  != _t0)}) && {!(_x in _bList)}) then {_picked = _x;};} foreach _places;
} else {
{if (((getmarkerpos _picked) distance _cen > (getmarkerpos _x) distance _cen) && {!(_x in _bList)}) then {_picked = _x;};} foreach _places;
};
_picked