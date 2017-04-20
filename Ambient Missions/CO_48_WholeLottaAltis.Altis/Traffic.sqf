private ["_funcSupply2","_funcSupply","_cmilc","_ccarc","_diir","_endF","_end","_startF","_start","_milc","_carc","_d","_pPosi","_nul","_ran","_type","_classR","_Np","_nF","_num"];

_carc = + CIVVEH;
_milc = (ARMEDVEHICLES select 1)+(ARMEDSUPPORT select 1)+(ARMEDSUPPORT select 2)+(ARMEDCARRIER select 1)+CIVVEH;
_ccarc = count _carc;
_cmilc = count _milc;

_startF = {
private ["_xx","_yy","_start","_pPosi","_roads"];
_xx = random 1000;
_yy = 1000 - _xx;
if (random 1 < 0.5) then {_xx = _xx*(-1)};
if (random 1 < 0.5) then {_yy = _yy*(-1)};
_pPosi = getposATL (vehicle ([] call RandomP));
_start = [(_pPosi select 0) + _xx,(_pPosi select 1) + _yy,0];
_roads = (_start nearRoads 450);
if (count _roads > 0) then {_start = getposATL (_roads select 0);};
[_start,_pPosi]
};

_endF = {
private ["_xx","_yy","_end","_roads"];
_xx = random 1000;
_yy = 1000 - _xx;
if (random 1 < 0.5) then {_xx = _xx*(-1)};
if (random 1 < 0.5) then {_yy = _yy*(-1)};
_end = [(_this select 0) + _xx,(_this select 1) + _yy,0];
_roads = (_end nearRoads 450);
if (count _roads > 0) then {_end = getposATL (_roads select 0);}; 
_end
};

_funcSupply = {
	private ["_start","_cl","_tr","_dir","_w","_end","_nul","_aika","_n"];
	_cl = _this select 0;
	_start = _this select 1;
	_end = _this select 2;
	if (random 1 < 0.4) then {
	_s = getmarkerpos (["ColorRed"] CALL NEARESTCAMP);
	if (random 1 < 0.5 && {{vehicle _x distance _s < 600} count ([] CALL AllPf) == 0}) then {_start = _s;} else {_end = getmarkerpos (["ColorRed"] CALL NEARESTCAMP);};
	};
	_dir = random 360;
	_tr = [_start,1,_cl,EAST] call SPAWNVEHICLE;
	(_tr select 0) setdir _dir;
	(_tr select 0) lock true;
	_w = (_tr select 2) addWaypoint [_end, 0]; 
	_aika = time + 660;
	waituntil {sleep 15; isNull (_tr select 0) || {(_tr select 0) distance _end < 30} || {!(alive (_tr select 0))} || {{alive _x} count crew (_tr select 0) == 0} || {_aika < time}};
	if ((_tr select 0) distance _end > 30 && {(!(alive (_tr select 0)) || {{alive _x} count crew (_tr select 0) == 0})} && {{vehicle _x distance (_tr select 0) < 700} count ([WEST] CALL AllPf) > 0}) then {
	_n = [WEST,150] SPAWN PrestigeUpdate;
	[[150, "Destroyed Enemy Supply Truck",WEST],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
	};
	if (isNull (_tr select 0)) exitWith {};
	waituntil {sleep 15; {vehicle _x distance (_tr select 0) < 900} count ([] CALL AllPf) == 0};
	{deletevehicle _x;} foreach units (_tr select 2) + [(_tr select 0)];
};

_funcSupply2 = {
	private ["_start","_cl","_tr","_dir","_w","_end","_aika","_n","_nul"];
	_cl = _this select 0;
	_start = _this select 1;
	_end = _this select 2;
	if (random 1 < 0.8) then {
	if (random 1 < 0.5 && {{position ([_start] CALL NEARESTFACTORY) distance _x < 450} count ([] CALL AllPf) == 0}) then {_start = position ([_start] CALL NEARESTFACTORY);} else {_end = position ([] CALL NEARESTFACTORY);};
	};
	_dir = random 360;
	_tr = [_start,1,_cl,WEST] call SPAWNVEHICLE;
	(_tr select 0) setdir _dir;
	(_tr select 0) lock true;
	_w = (_tr select 2) addWaypoint [_end, 0]; 
	_aika = time + 660;
	waituntil {sleep 15; isNull (_tr select 0) || {(_tr select 0) distance _end < 30} || {!(alive (_tr select 0))} || {{alive _x} count crew (_tr select 0) == 0} || {_aika < time}};
	if ((_tr select 0) distance _end > 30 && {(!(alive (_tr select 0)) || {{alive _x} count crew (_tr select 0) == 0})} && {{vehicle _x distance (_tr select 0) < 700} count ([EAST] CALL AllPf) > 0}) then {
	_n = [EAST,150] SPAWN PrestigeUpdate;
	[[150, "Destroyed Enemy Supply Truck",EAST],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
	};
	if (isNull (_tr select 0)) exitWith {};
	waituntil {sleep 15; {vehicle _x distance (_tr select 0) < 900} count ([] CALL AllPf) == 0};
	{deletevehicle _x;} foreach units (_tr select 2) + [(_tr select 0)];
};

sleep (10+(random 10));	
while {true} do {
	waitUntil {sleep 5; {isPlayer _x} count ([] CALL AllPf) > 0 && {([] CALL FPSGOOD)}};
	_diir = random 360;
	_d = [] CALL _startF;
	_start = _d select 0;
	_pPosi = _d select 1;
	while {surfaceIsWater _start || {{_start distance (getmarkerpos _x) < (getmarkersize _x select 0)} count Bpositions > 0}} do {
	sleep 5;
	_d = [] CALL _startF;
	_start = _d select 0;
	_pPosi = _d select 1;
	};	
	sleep 1;
	_end = _pPosi CALL _endF;
	while  {surfaceIsWater _end} do {
	sleep 5;
	_end = _pPosi CALL _endF;
	};
	sleep 1;
	_num = floor(random 10);
	if (_num < 7) then {
	_ran = CIVVEH call RETURNRANDOM;		
	if ({count crew _x > 0 && {side driver _x == CIVILIAN} && {(getposATL _x) select 2 < 1}} count vehicles < 3) then {_nul = [_ran,_start,_end,civilian,_diir] SPAWN FUNKTIO_AmbientCarCIV;};   
	} else {
	//MILITARY (ARMEDVEHICLES select 1)+(ARMEDSUPPORT select 1)+(ARMEDSUPPORT select 2)
	if (random 1 < 0.7 && {MAXCARS > 0}) then {
	_ran = ((ARMEDVEHICLES select 1)+(ARMEDSUPPORT select 1)+(ARMEDSUPPORT select 2)+(ARMEDCARRIER select 1)+CIVVEH) call RETURNRANDOM;
	_type = 0;
	if (_ran in (ARMEDVEHICLES select 1)) then {_type = 1;};
	if (_ran in (ARMEDSUPPORT select 1)) then {_type = 2;};
	if (_ran in (ARMEDSUPPORT select 2)) then {_type = 3;};
	if ((_type == 1 && {count VehicleGroups < (EVEHMAX + 1)}) || (_type == 0 && {count Pgroups < (VarPG + 1)})) then {
	_classR = [];
	for "_i" from 1 to 3 do {
	_classR set [count _classR,(ENEMYC1 call RETURNRANDOM)];
	};
	_nul = [_ran,_start,_end,EAST,_diir,_classR, _type] SPAWN AmbientScoutCar; 
	};
	_Np = getmarkerpos (["ColorRed",_start] CALL NEARESTCAMP);
	if (_type == 2 && {(_Np distance _start < 4000)} && {{(_Np distance vehicle _x < 400)} count ([] CALL AllPf) == 0} && {{count crew _x > 0 && {side driver _x == EAST} && {(getposATL _x) select 2 < 1}} count vehicles < 6}) then {
	[_ran,_start,_end] SPAWN _funcSupply;
	};
	_nF = position ([_start] CALL NEARESTFACTORY);
	if (_type == 3 && {{_nF distance _x < 6000} count ([] CALL AllPf) > 0} && {[_nF] CALL NEARESTVILLAGERELATIONSHIP == "Friendly"} && {{count crew _x > 0 && {side driver _x == EAST} && {(getposATL _x) select 2 < 1}} count vehicles < 7}) then {
	[_ran,_start,_end] SPAWN _funcSupply2;
	
	};
	};
	};
sleep (20+(random 40));	
};			

//[[2754.31,5282.63,0],10,[4402.38,6362.95,0],[5274.75,8624.66,0],270]

