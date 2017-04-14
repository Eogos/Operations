private ["_dd","_g"];
//LISÄÄ
if (count _this == 0) then {
_dd = (["Lb"] CALL DIS);
_g = [];
{
if (_x distance vehicle player < _dd) then {_g = _g + [_x];_x setvariable ["KeepG",true];};
} foreach GuardPosts;
if (!isNil{SaOkmissionNamespace getvariable "KeepGs"}) then {_g = _g + (SaOkmissionNamespace getvariable "KeepGs");};
SaOkmissionNamespace setvariable ["KeepGs",_g];
} else {
//POISTA
if (!isNil{SaOkmissionNamespace getvariable "KeepGs"}) then {
{_x setvariable ["KeepG",nil];} foreach (SaOkmissionNamespace getvariable "KeepGs");
SaOkmissionNamespace setvariable ["KeepGs",nil];
};
};