private ["_u"];
_u = [];
{if !(isPlayer _x) then {_u = _u + [_x];};} foreach ((units group player) - [player]);
{_x setpos (getposATL player);} foreach _u;