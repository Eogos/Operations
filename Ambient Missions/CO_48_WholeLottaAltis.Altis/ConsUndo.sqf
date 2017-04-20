private ["_gP","_mode","_ar","_pB","_cost","_nul"];
_gP = _this select 0;
_mode = _this select 1;
if (_mode == 0) then {
if (!isNil{_gP getvariable "ObjectsNow"} && {count (_gP getvariable "ObjectsNow") > 0}) then {
_gp CALL SAOKCONSREMO;
};
} else {
if (!isNil{_gP getvariable "WeaponsNow"} && {count (_gP getvariable "WeaponsNow") > 0}) then {
_gp CALL SAOKCONSREMW;
};
};

