private ["_posPl","_xx","_yy","_start","_st","_tank","_tg1","_tg1wp1","_class","_random","_classes","_raa","_group2","_wp1","_nul","_sPosi","_pPosi","_distKM"];
if ({(getmarkerpos (["ColorRed"] CALL NEARESTCAMP) distance vehicle _x < 2000)} count ([WEST] CALL AllPf) == 0) exitWith {};
_pPosi = getposATL vehicle (([WEST] CALL AllPf)call RETURNRANDOM);
_distKM = (getmarkerpos (["ColorRed"] CALL NEARESTCAMP) distance _pPosi)*0.001;
sleep (10+(random 20)*_distKM);
_posPl = _this select 0;
if (count VehicleGroups < EVEHMAX) then {
_xx = random 2000;
_yy = 2000 - _xx;
if (random 1 < 0.5) then {_xx = _xx*(-1)};
if (random 1 < 0.5) then {_yy = _yy*(-1)};

_sPosi = getmarkerpos (["ColorRed"] CALL NEARESTCAMP);
_start = [(_sPosi select 0) + _xx,(_sPosi select 1) + _yy,0];
_st = [_start, 400,"(1 - forest) * (1 - sea) * (1 - houses)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
while  {{_start distance vehicle _x < 1000} count ([WEST] CALL AllPf) > 0|| {_start distance ([_start] CALL NEARESTGUARDPOST) < 800} || {surfaceIsWater [_start select 0, _start select 1]} || {{_start distance _x < 500} count VarBlackListE > 0} || {{_start distance (getmarkerpos _x) < (getmarkersize _x select 0)} count Bpositions > 0}} do {
sleep 5;
_xx = random 2000;
_yy = 2000 - _xx;
if (random 1 < 0.5) then {_xx = _xx*(-1)};
if (random 1 < 0.5) then {_yy = _yy*(-1)};
_start = [(_sPosi select 0) + _xx,(_sPosi select 1) + _yy,0];
_st = [_start, 400,"(1 - forest) * (1 - sea) * (1 - houses)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
};

_tank = (["VEH",1] CALL VEHARRAY) call RETURNRANDOM;	
_tg1 = [_start, 0, _tank, EAST] call SPAWNVEHICLE;
(_tg1 select 0) SPAWN {_this allowdamage false; sleep 10; _this allowdamage true;};

_tg1wp1= (_tg1 select 2) addWaypoint [_posPl, 0]; 
//[(_tg1 select 2), 1] setWaypointBehaviour "COMBAT";
VehicleGroups set [count VehicleGroups,(_tg1 select 2)];
_nul = [(_tg1 select 2),"ColorRed"] SPAWN FUNKTIO_GM;
_nul = [(_tg1 select 0), _posPl] SPAWN FUNKTIO_VS;
CARS set [count CARS,(_tg1 select 0)];
if (random 1 > VarRes) then {(_tg1 select 0) setfuel (random VarRes);};

if (_tank in ["O_MRAP_02_gmg_F","O_MRAP_02_hmg_F","O_APC_Wheeled_02_rcws_F"] && {random 1 < 0.7}) then {
_random = 3;
if (_tank in ["O_APC_Wheeled_02_rcws_F"]) then {_random = 3 + floor (random 2);};
_classes = [];
_raa = [ENEMYC1,ENEMYC2] call RETURNRANDOM;
while {_random > 0} do {_classes set [count _classes,_raa select (floor(random (count _raa)))];_random = _random - 1;};
_group2 = [_start, EAST, _classes,[],[],[0.3,0.6]] call SpawnGroupCustom;

{_x moveincargo (_tg1 select 0);} foreach units _group2;
_posPl = [(_posPl select 0) + 250 - (random 500), (_posPl select 1)+ 250 - (random 500), 0];
_wp1= _group2 addWaypoint [_posPl, 0]; 
[_group2, 1] setWaypointType "GUARD";
_nul = [_group2, (_tg1 select 2)] SPAWN {
private ["_group","_carg"];
_group = _this select 0;
_carg = _this select 1;
waituntil {sleep 1; isNull _group || {isNull _carg} || {behaviour leader _carg == "COMBAT"} || {behaviour leader _group  == "COMBAT"}}; 
if (!isNull _group && !isNull _carg) then {
vehicle (leader _carg) forcespeed 0;
{unassignvehicle _x; [_x] ordergetin false;} foreach units _group;
sleep 4;
vehicle (leader _carg) forcespeed -1;
};
};
Pgroups set [count Pgroups,_group2];
}; 


};

_distKM = (getmarkerpos (["ColorRed"] CALL NEARESTCAMP) distance _pPosi)*0.001;
sleep (10+(random 20)*_distKM);
if ({_pPosi distance getposATL (vehicle _x) < 1000} count ([WEST] CALL AllPf) ==0 ) exitWith {};
if (random 1 < 0.3*DIFLEVEL && {count VehicleGroups < EVEHMAX}) then {
_xx = random 2000;
_yy = 2000 - _xx;
if (random 1 < 0.5) then {_xx = _xx*(-1)};
if (random 1 < 0.5) then {_yy = _yy*(-1)};

_sPosi = getmarkerpos (["ColorRed"] CALL NEARESTCAMP);
_start = [(_sPosi select 0) + _xx,(_sPosi select 1) + _yy,0];
_st = [_start, 400,"(1 - forest) * (1 - sea) * (1 - houses)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
while  {{_start distance vehicle _x < 1000} count ([WEST] CALL AllPf) > 0 || {_start distance ([_start] CALL NEARESTGUARDPOST) < 800} || {surfaceIsWater [_start select 0, _start select 1]} || {{_start distance _x < 500} count VarBlackListE > 0} || {{_start distance (getmarkerpos _x) < (getmarkersize _x select 0)} count Bpositions > 0}} do {
sleep 5;
_xx = random 2000;
_yy = 2000 - _xx;
if (random 1 < 0.5) then {_xx = _xx*(-1)};
if (random 1 < 0.5) then {_yy = _yy*(-1)};
_start = [(_sPosi select 0) + _xx,(_sPosi select 1) + _yy,0];
_st = [_start, 400,"(1 - forest) * (1 - sea) * (1 - houses)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
};
_class = (ARMEDVEHICLES select 1);	
if(isNil"DisableUAV") then {_class = _class + ["O_UGV_01_rcws_F"];}; 
_class = _class call RETURNRANDOM;	
_tg1 = [_start, 0, _class, EAST] call SPAWNVEHICLE;
(_tg1 select 0) SPAWN {_this allowdamage false; sleep 10; _this allowdamage true;};

_tg1wp1= (_tg1 select 2) addWaypoint [_posPl, 0]; 
[(_tg1 select 2), 1] setWaypointBehaviour "COMBAT";
VehicleGroups set [count VehicleGroups,(_tg1 select 2)];
_nul = [(_tg1 select 2),"ColorRed"] SPAWN FUNKTIO_GM;
_nul = [(_tg1 select 0), _posPl] SPAWN FUNKTIO_VS;
CARS set [count CARS,(_tg1 select 0)];
if (random 1 > VarRes) then {(_tg1 select 0) setfuel (random VarRes);};
if (_class in ["O_MRAP_02_gmg_F","O_MRAP_02_hmg_F","O_APC_Wheeled_02_rcws_F"] && {random 1 < 0.3}) then {
_random = 3;
if (_class in ["O_APC_Wheeled_02_rcws_F"]) then {_random = 3 + floor (random 2);};
_classes = [];
_raa = [ENEMYC1,ENEMYC2] call RETURNRANDOM;
while {_random > 0} do {_classes set [count _classes,_raa select (floor(random (count _raa)))];_random = _random - 1;};
_group2 = [_start, EAST, _classes,[],[],[0.3,0.6]] call SpawnGroupCustom;

{_x moveincargo (_tg1 select 0);} foreach units _group2;
_posPl = [(_posPl select 0) + 250 - (random 500), (_posPl select 1)+ 250 - (random 500), 0];
_wp1= _group2 addWaypoint [_posPl, 0]; 
[_group2, 1] setWaypointType "GUARD";
_nul = [_group2, (_tg1 select 2)] SPAWN {
private ["_group","_carg"];
_group = _this select 0;
_carg = _this select 1;
waituntil {sleep 1;  isNull _group || {isNull _carg} || {behaviour leader _carg == "COMBAT"} || {behaviour leader _group  == "COMBAT"}}; 
if (!isNull _group && {!isNull _carg}) then {
vehicle (leader _carg) forcespeed 0;
{unassignvehicle _x; [_x] ordergetin false;} foreach units _group;
sleep 4;
vehicle (leader _carg) forcespeed -1;
};
};
Pgroups set [count Pgroups,_group2];
}; 

};
_distKM = (getmarkerpos (["ColorRed"] CALL NEARESTCAMP) distance _pPosi)*0.001;
sleep (10+(random 20)*_distKM);
if ({_pPosi distance getposATL (vehicle _x) < 1000} count ([WEST] CALL AllPf) == 0) exitWith {};
if (random 1 < 0.3*DIFLEVEL && {count VehicleGroups < EVEHMAX}) then {
_xx = random 2000;
_yy = 2000 - _xx;
if (random 1 < 0.5) then {_xx = _xx*(-1)};
if (random 1 < 0.5) then {_yy = _yy*(-1)};

_sPosi = getmarkerpos (["ColorRed"] CALL NEARESTCAMP);
_start = [(_sPosi select 0) + _xx,(_sPosi select 1) + _yy,0];
_st = [_start, 400,"(1 - forest) * (1 - sea) * (1 - houses)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
while  {{_start distance vehicle _x < 1000} count ([WEST] CALL AllPf) > 0 || {_start distance ([_start] CALL NEARESTGUARDPOST) < 800} || {surfaceIsWater [_start select 0, _start select 1]} || {{_start distance _x < 500} count VarBlackListE > 0} || {{_start distance (getmarkerpos _x) < (getmarkersize _x select 0)} count Bpositions > 0}} do {
sleep 5;
_xx = random 2000;
_yy = 2000 - _xx;
if (random 1 < 0.5) then {_xx = _xx*(-1)};
if (random 1 < 0.5) then {_yy = _yy*(-1)};
_start = [(_sPosi select 0) + _xx,(_sPosi select 1) + _yy,0];
_st = [_start, 400,"(1 - forest) * (1 - sea) * (1 - houses)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
};
_class = (ARMEDVEHICLES select 1);	
if(isNil"DisableUAV") then {_class = _class + ["O_UGV_01_rcws_F"];}; 
_class = _class call RETURNRANDOM;	
_tg1 = [_start, 0, _class, EAST] call SPAWNVEHICLE;
(_tg1 select 0) SPAWN {_this allowdamage false; sleep 10; _this allowdamage true;};

_tg1wp1= (_tg1 select 2) addWaypoint [_posPl, 0]; 
[(_tg1 select 2), 1] setWaypointBehaviour "COMBAT";
VehicleGroups set [count VehicleGroups,(_tg1 select 2)];
_nul = [(_tg1 select 2),"ColorRed"] SPAWN FUNKTIO_GM;
_nul = [(_tg1 select 0), _posPl] SPAWN FUNKTIO_VS;
CARS set [count CARS,(_tg1 select 0)];
if (random 1 > VarRes) then {(_tg1 select 0) setfuel (random VarRes);};
if (_class in ["O_MRAP_02_gmg_F","O_MRAP_02_hmg_F","O_APC_Wheeled_02_rcws_F"] && random 1 < 0.1) then {
_random = 3;
if (_class in ["O_APC_Wheeled_02_rcws_F"]) then {_random = 3 + floor (random 2);};
_classes = [];
_raa = [ENEMYC1,ENEMYC2] call RETURNRANDOM;
while {_random > 0} do {_classes set [count _classes,_raa select (floor(random (count _raa)))];_random = _random - 1;};
_group2 = [_start, EAST, _classes,[],[],[0.3,0.6]] call SpawnGroupCustom;

{_x moveincargo (_tg1 select 0);} foreach units _group2;
_posPl = [(_posPl select 0) + 250 - (random 500), (_posPl select 1)+ 250 - (random 500), 0];
_wp1= _group2 addWaypoint [_posPl, 0]; 
[_group2, 1] setWaypointType "GUARD";
_nul = [_group2, (_tg1 select 2)] SPAWN {
private ["_group","_carg"];
_group = _this select 0;
_carg = _this select 1;
waituntil {sleep 1;  isNull _group || {isNull _carg} || {behaviour leader _carg == "COMBAT"} || {behaviour leader _group  == "COMBAT"}}; 
if (!isNull _group && {!isNull _carg}) then {
vehicle (leader _carg) forcespeed 0;
{unassignvehicle _x; [_x] ordergetin false;} foreach units _group;
sleep 4;
vehicle (leader _carg) forcespeed -1;
};
};
Pgroups set [count Pgroups,_group2];
}; 
};
