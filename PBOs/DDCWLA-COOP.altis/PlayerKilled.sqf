private ["_killer","_tk"];
_killer = _this select 1;
if (isPlayer _killer && {alive _killer} && {_killer != player} && {side _killer == side player}) then {
player setvariable ["ResPos",getposATL _killer,true];
removeallweapons _killer;
if (isNil{_killer getvariable "TKiller"}) then {_killer setvariable ["TKiller",1,true]; "You will get spawned at location where you where killed after you choose any location in respawn menu. Your killer was punished by make him loosing his weapons - it was his first TK" SPAWN HINTSAOK;} else {
_killer setvariable ["TKiller",(_killer getvariable "TKiller")+1,true];
_killer setdamage 1;
_tk = (_killer getvariable "TKiller");
_killer setvariable ["Punished",60*_tk,true];
(format ["Your killer was sent to holding cell to %2 seconds. It was his %1. teamkill",_tk,60*_tk]) SPAWN HINTSAOK;;
};
};