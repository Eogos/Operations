_f = {
private ["_unit"];
_unit = _this;
_unit setcaptive true;
_unit stop true;
_unit setunitpos "UP";
removeAllWeapons _unit;	
//_unit playMoveNow "AmovPercMstpSnonWnonDnon_AmovPercMstpSsurWnonDnon";
[[_unit,"AmovPercMstpSnonWnonDnon_AmovPercMstpSsurWnonDnon"],"SAOKPMOVE",nil,false] spawn BIS_fnc_MP;
};

_f2 = {
private ["_unit"];
_unit = _this;
_unit setcaptive false;
_unit stop false;
_unit setunitpos "UP";
removeAllWeapons _unit;	
//_unit SwitchMove "";
[[_unit,""],"SAOKSMOVE",nil,false] spawn BIS_fnc_MP;
_unit allowfleeing 1;
};

_center = _this;
_pows = [];
_guards = [];
_ran = CIVS1 call RETURNRANDOM;
_group = [_center, CIVILIAN, [_ran],[],[],[0.6,0.9]] call SpawnGroupCustom;
_pows = _pows + (units _group);
_ran = CIVS1 call RETURNRANDOM;
_p = [(_center select 0)+2,(_center select 1)+2,0];
_group = [_p, CIVILIAN, [_ran],[],[],[0.6,0.9]] call SpawnGroupCustom;
_pows = _pows + (units _group);
_p = [(_center select 0)-2,(_center select 1)-2,0];
_ran = CIVS1 call RETURNRANDOM;
_group = [_p, CIVILIAN, [_ran],[],[],[0.6,0.9]] call SpawnGroupCustom;
_pows = _pows + (units _group);
{_x SPAWN _f;} foreach _pows;  
_p = [(_center select 0)+2,(_center select 1)-6,0];
_ran = ENEMYC1 call RETURNRANDOM;
_group = [_p, EAST, [_ran],[],[],[0.6,0.9]] call SpawnGroupCustom;
_guards = _guards + (units _group);
_p = [(_center select 0)+6,(_center select 1)-2,0];
_ran = ENEMYC1 call RETURNRANDOM;
_group = [_p, EAST, [_ran],[],[],[0.6,0.9]] call SpawnGroupCustom;
_guards = _guards + (units _group);
_dead = {
private ["_bol"];
_bol = false;
if ({alive _x} count _this == 0) then {_bol = true;};
_bol
};
waitUntil {sleep 3; {_center distance _x < 800} count ([] CALL AllPf) == 0 || {_pows CALL _dead} || {_guards CALL _dead}};
//VIL REL GET WORSE
if (_pows CALL _dead) then {
[["More worse local relationship from died civilians",WEST],"HINTSAOK",nil,false] spawn BIS_fnc_MP;
_nearest = [_center] CALL NEARESTVILLAGE; 
_nearest CALL SAOKLOWERRELVIL;
};
//VIL REL IMPROVE
if (_guards CALL _dead && {!(_pows CALL _dead)}) then {
[_center,side _player] SPAWN ADDR;
[["Improved local relationship from saved civilians",WEST],"HINTSAOK",nil,false] spawn BIS_fnc_MP;
{_x SPAWN _f2;} foreach _pows;
_nearest = [_center] CALL NEARESTVILLAGE; 
_str = (_nearest + "A"); 
_str CALL SAOKIMPREL;
};
waitUntil {sleep 4; {_center distance _x < 800} count ([] CALL AllPf) == 0};
{deletevehicle _x;} foreach (_pows+_guards);