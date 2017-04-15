private ["_units"];
_units = _this select 0;
{
if (typename _x == "OBJECT") then {
if (isServer) then {
_x SPAWN SAOKAICAMPADDF;
} else {
[_x,"SAOKAICAMPADDF",false,false] spawn BIS_fnc_MP;
};
};
sleep 0.1;
} foreach _units;