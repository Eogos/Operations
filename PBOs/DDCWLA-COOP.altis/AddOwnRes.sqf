private ["_pos","_side"];
_pos = _this select 0;
_side = _this select 1;
{
if (_x distance _pos < 300) then {
_x setvariable ["OwnRes",(_x getvariable "OwnRes") + 1,true];
};
} foreach ([_side] CALL AllPf);