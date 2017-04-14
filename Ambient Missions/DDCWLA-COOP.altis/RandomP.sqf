private ["_p","_pU","_s"];
_p = [];
_pU = ([] CALL AllPf);
_s = _pU call RETURNRANDOM;
{if (isPlayer _x) then {_p = _p + [_x];};} foreach _pU;
if (count _p > 0) then {_s = _p call RETURNRANDOM;};
_s