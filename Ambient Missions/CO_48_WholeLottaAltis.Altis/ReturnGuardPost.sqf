private ["_pos","_nearest"];
_pos = _this select 0; 
_nearest = NullGuardP;
if (count _this < 2) then {
{if (_x distance _pos < _nearest distance _pos) then {_nearest = _x;};} foreach GuardPosts;
} else {
{if (getmarkercolor (_x getvariable "Gmark") == (_this select 1) && {_x distance _pos < _nearest distance _pos}) then {_nearest = _x;};} foreach GuardPosts;
};
_nearest