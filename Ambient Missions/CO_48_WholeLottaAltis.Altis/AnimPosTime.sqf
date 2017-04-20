_unit = _this select 0;
_anim = _this select 1;
_pos = _this select 2;
_dir =  _this select 3;
_time = if (count _this > 4) then {_this select 4} else {0};
_pM = if (count _this > 5) then {_this select 5} else {0};
//"InBaseMoves_sitHighUp1" c5efe_HonzaLoop c5efe_MichalLoop
_unit setpos _pos;
_unit setdir _dir;
group _unit setformdir _dir;
if (_pM == 0) then {_unit switchMove _anim;} else {_unit playMove _anim;};
if (_time > 0) then {
sleep _time;
while {!isNull _unit && behaviour _unit != "COMBAT" && alive _unit} do {
_unit setpos _pos;
_unit setdir _dir;
group _unit setformdir _dir;
if (_pM == 0) then {_unit switchMove _anim;} else {_unit playMove _anim;};
sleep _time;
};
};