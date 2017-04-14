private ["_vehicle"];
_vehicle = _this select 0;
sleep 120;
waituntil {sleep 300;{_x distance _vehicle < 1200 && {_x in _vehicle}} count ([] CALL AllPf) == 0};
deletevehicle _vehicle;