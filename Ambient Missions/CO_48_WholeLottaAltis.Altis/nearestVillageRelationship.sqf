private ["_rela","_nearest"];
_nearest = ([] CALL NEARESTVILLAGE);
if (count _this > 0) then {_nearest = ([_this select 0] CALL NEARESTVILLAGE);};
_rela = "Neutral";
if !((_nearest + "A") CALL SAOKVILCON) then {_rela = "Neutral";} else {_rela = (_nearest + "A") CALL SAOKVILRET;};
_rela