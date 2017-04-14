private ["_f3","_f2","_f1","_atLeastOnce","_ambpos","_diir","_start","_end","_class","_tank","_posPl","_wp","_Ppos","_timePassed","_maxPatrol","_nul","_d","_ran","_inf","_ordercode"];
if (!isServer) exitWith {};

//INIT
Pgroups = [];
VarAlarm = false;
[[1],"MusicT",nil,false] spawn BIS_fnc_MP;

_f1 = {
	private ["_xx","_start","_yy","_Ppos","_roads"];
    _xx = random (1300);
	_yy = 1300 - _xx;
	if (random 1 < 0.5) then {_xx = _xx*(-1)};
	_Ppos = getposATL (vehicle (([WEST] CALL AllPf) call RETURNRANDOM));
	_start = [(_Ppos select 0) + _xx,(_Ppos select 1) + _yy,0];
	_roads = (_start nearRoads 650);
	if (count _roads > 0) then {_start = getposATL (_roads select 0);}; 
	[_start,_Ppos]
};

_f2 = {
private ["_xx","_yy","_end","_start","_roads"];
_start = _this select 0;
_xx = random (2000);
_yy = 2000 - _xx;
if (random 1 < 0.5) then {_xx = _xx*(-1)};
if (random 1 < 0.5) then {_yy = _yy*(-1)};
_end = [(_this select 0) + _xx,(_this select 1) + _yy,0];
_roads = (_end nearRoads 650);
if (count _roads > 0) then {_end = getposATL (_roads select 0);};  
_end
};

_f3 = {
private ["_start","_posPl","_tank","_inf","_nul"];
_start = _this select 0;
_posPl = _this select 1;
sleep (20+(random 20));
_tank = (["C",1] CALL VEHARRAY);	
_oC = [ENEMYC1,ENEMYC2,ENEMYC3] call RETURNRANDOM; 
if (count Pgroups < (VarPG + 1)) then {
_tank = (["C",1] CALL VEHARRAY);
_tank = _tank call RETURNRANDOM;	
_inf = [_oC call RETURNRANDOM,_oC call RETURNRANDOM,_oC call RETURNRANDOM,_oC call RETURNRANDOM];
_nul = [_start, _posPl, _posPl, EAST, 90, _tank,_inf,[0.6,0.7],0] SPAWN FLandTransport;
};
if (random 1 < 0.1 && {count Pgroups < VarPG} && {(getmarkerpos (["ColorRed",(vehicle (leader (([WEST] CALL AllPf) call RETURNRANDOM)))] CALL NEARESTCAMP) distance (vehicle (leader (([WEST] CALL AllPf) call RETURNRANDOM))) < 4000)}) then {
sleep 10;
_tank = (["C",1] CALL VEHARRAY);
_tank = _tank call RETURNRANDOM;	
_inf = [_oC call RETURNRANDOM,_oC call RETURNRANDOM,_oC call RETURNRANDOM,_oC call RETURNRANDOM];
_nul = [_start, _posPl, _posPl, EAST, 90, _tank,_inf,[0.6,0.7],0] SPAWN FLandTransport;
};
if (random 1 < 0.1 && {count Pgroups < VarPG} && {(getmarkerpos (["ColorRed",(vehicle (leader (([WEST] CALL AllPf) call RETURNRANDOM)))] CALL NEARESTCAMP) distance (vehicle (leader (([WEST] CALL AllPf) call RETURNRANDOM))) < 4000)}) then {
sleep 10;
_tank = _tank call RETURNRANDOM;	
_inf = [_oC call RETURNRANDOM,_oC call RETURNRANDOM,_oC call RETURNRANDOM,_oC call RETURNRANDOM];
_nul = [_start, _posPl, _posPl, EAST, 90, _tank,_inf,[0.6,0.7],0] SPAWN FLandTransport;
};
};

sleep 55;
while {true} do {
_maxPatrol = 0;
_timePassed = time  + 40 + (random 40);
waitUntil {sleep 5; !(surfaceIsWater getposATL (([WEST] CALL AllPf) call RETURNRANDOM))};
//PATROLS
_atLeastOnce = 1;
while {{side _x == EAST && {_x knowsabout (([WEST] CALL AllPf) call RETURNRANDOM) > 0.1}} count allGroups == 0 || {_atLeastOnce > 0}} do {
if (_timePassed < time && {_maxPatrol > 0}) then {_timePassed = time + 40 + (random 40);_maxPatrol = _maxPatrol - 1;};
_atLeastOnce = _atLeastOnce - 1;
if (!isNil"debugi") then {hint "State - Patrol";};
_Ppos = getposATL (vehicle (([WEST] CALL AllPf) call RETURNRANDOM));
_ambpos = [(_Ppos select 0) + 700 - random (1400),(_Ppos select 1) + 700 - random (1400),0];
while {surfaceIsWater _ambpos} do {
waitUntil {sleep 5; !(surfaceIsWater getposATL (([WEST] CALL AllPf) call RETURNRANDOM))};
sleep 1; 
_Ppos = getposATL (vehicle (([WEST] CALL AllPf) call RETURNRANDOM));
_ambpos = [(_Ppos select 0) + 700 - random (1400),(_Ppos select 1) + 700 - random (1400),0];};
if ((getmarkerpos (["ColorRed",_ambpos] CALL NEARESTCAMP) distance _ambpos < 6000)) then {
if (count Pgroups < VarPG && {_maxPatrol < 4*DIFLEVEL}) then {_nul = [_ambpos,900,VarPGSize] SPAWN FUNKTIO_AmbientPatrol; _maxPatrol = _maxPatrol + 1;};
};
VarAlarm = false;
waitUntil {sleep 5; !(surfaceIsWater getposATL (([WEST] CALL AllPf) call RETURNRANDOM))};
if (random 1 < 0.1) then {
if (random 1 < 0.2 && {(getmarkerpos (["ColorRed",(vehicle (([WEST] CALL AllPf) call RETURNRANDOM))] CALL NEARESTCAMP) distance (vehicle (([WEST] CALL AllPf) call RETURNRANDOM)) < 4000)}) then {
	_diir= random 360;
	_d = [] CALL _f1;
	_start = _d select 0;
	_Ppos = _d select 1;
	while  {surfaceIsWater [_start select 0, _start select 1]} do {
	sleep 3;
	_d = [] CALL _f1;
	_start = _d select 0;
	_Ppos = _d select 1;
	};	
	sleep 1;
	_end = _Ppos CALL _f2;
	while  {surfaceIsWater [_end select 0, _end select 1]} do {
	sleep 5;
	_end = _Ppos CALL _f2;
	};
	_oC = [ENEMYC1,ENEMYC2,ENEMYC3] call RETURNRANDOM; 
	if (count Pgroups < VarPG && {MAXCARS > 0}) then {
	_ran = (["C",1] CALL VEHARRAY) call RETURNRANDOM;	
	_inf = [_oC call RETURNRANDOM,_oC call RETURNRANDOM,_oC call RETURNRANDOM,_oC call RETURNRANDOM];
	_class = [[_ran,_inf]];
	_class = _class call RETURNRANDOM;
	_nul = [_class select 0,_start,_end,EAST,_diir,_class select 1, 0] SPAWN AmbientScoutCar;
	};
	if (random 1 < 0.1*DIFLEVEL && {count Pgroups < VarPG} && {MAXCARS > 0}) then {
	_ran = (["C",1] CALL VEHARRAY) call RETURNRANDOM;	
	_inf = [_oC call RETURNRANDOM,_oC call RETURNRANDOM,_oC call RETURNRANDOM,_oC call RETURNRANDOM];
	_class = [[_ran,_inf]];
	_class = _class call RETURNRANDOM;
	_nul = [_class select 0,_start,_end,EAST,_diir,_class select 1, 0] SPAWN AmbientScoutCar;
	};
	if (random 1 < 0.1*DIFLEVEL && {count VehicleGroups < EVEHMAX} && {MAXCARS > 0}) then {
	_ran = (["C",1] CALL VEHARRAY) call RETURNRANDOM;	
	_inf = [_oC call RETURNRANDOM,_oC call RETURNRANDOM,_oC call RETURNRANDOM,_oC call RETURNRANDOM];
	_class = [[_ran,_inf]];
	_class = _class call RETURNRANDOM;
	_nul = [_class,_start,_end,EAST,_diir,[], 1] SPAWN AmbientScoutCar;
	};
} else {
	_diir= random 360;
	_d = [] CALL _f1;
	_start = _d select 0;
	_Ppos = _d select 1;
	while  {surfaceIsWater [_start select 0, _start select 1]} do {
	sleep 5;
	_d = [] CALL _f1;
	_start = _d select 0;
	_Ppos = _d select 1;
	};	
	sleep 1;
	_end = _Ppos CALL _f2;
	while  {surfaceIsWater [_end select 0, _end select 1]} do {
	sleep 5;
	_end = _Ppos CALL _f2;
	};
	if (count VehicleGroups < EVEHMAX && {MAXCARS > 0} && {(getmarkerpos (["ColorRed",_start] CALL NEARESTCAMP) distance _start < 4000)}) then {
	_class = (["VEH",1] CALL VEHARRAY) call RETURNRANDOM;	
	_nul = [_class,_start,_end,EAST,_diir,[], 1] SPAWN AmbientScoutCar;
	};
	if (random 1 < 0.1*DIFLEVEL && {count VehicleGroups < EVEHMAX} && {MAXCARS > 0} && {(getmarkerpos (["ColorRed",_start] CALL NEARESTCAMP) distance _start < 4000)}) then {
	sleep 5;
	_class = (["VEH",1] CALL VEHARRAY) call RETURNRANDOM;	
	_nul = [_class,_start,_end,EAST,_diir,[], 1] SPAWN AmbientScoutCar;
	};
	if (random 1 < 0.05*DIFLEVEL && {count VehicleGroups < EVEHMAX} && {MAXCARS > 0} && {(getmarkerpos (["ColorRed",_start] CALL NEARESTCAMP) distance _start < 4000)}) then {
	sleep 5;
	_class = (["VEH",1] CALL VEHARRAY) call RETURNRANDOM;	
	_nul = [_class,_start,_end,EAST,_diir,[], 1] SPAWN AmbientScoutCar;
	};
	if (random 1 < 0.05*DIFLEVEL && {count VehicleGroups < EVEHMAX} && {MAXCARS > 0} && {(getmarkerpos (["ColorRed",_start] CALL NEARESTCAMP) distance _start < 4000)}) then {
	sleep 5;
	_class = (["VEH",1] CALL VEHARRAY) call RETURNRANDOM;	
	_nul = [_class,_start,_end,EAST,_diir,[], 1] SPAWN AmbientScoutCar;
	};
};
}; 
sleep 1;
while {count Pgroups >= VarPG && {{side _x == EAST && {_x knowsabout (([WEST] CALL AllPf) call RETURNRANDOM) > 0.1}} count allGroups == 0}} do {sleep (20/DIFLEVEL);};
};
//FAST REINFORCEMENTS
[[2],"MusicT",nil,false] spawn BIS_fnc_MP;
if (!isNil"debugi") then {hint "State - Fast Reinf";};
VarAlarm = true;

{if (behaviour leader _x != "COMBAT") then {_x setbehaviour "AWARE";};} foreach Pgroups;
_posPl=getposATL vehicle (([WEST] CALL AllPf) call RETURNRANDOM);
{
while {(count (waypoints _x)) > 0} do
{
deleteWaypoint ((waypoints _x) select 0);
};
_wp = _x addWaypoint [[(_posPl select 0) + 300 - random (600),(_posPl select 1) + 300 - random (600),0], 0]; 
} foreach Pgroups;
if (VARCoLoop) then {_nul = [] SPAWN FUNKTIO_CL;};



if (random 1 < 0.3) then {

if (VarTRChop && {VarRes > 0.3} && {count Pgroups < (VarPG + 1)} && {!(SurfaceIsWater getposATL (([WEST] CALL AllPf) call RETURNRANDOM))} && {(getmarkerpos (["ColorRed",(vehicle (leader (([WEST] CALL AllPf) call RETURNRANDOM)))] CALL NEARESTCAMP) distance (vehicle (leader (([WEST] CALL AllPf) call RETURNRANDOM))) < 6000)}) then {
//["O_Ka60_Unarmed_F"]
_tank = (["AIRC",1] CALL VEHARRAY); 
_tank = _tank call RETURNRANDOM;	
_oC = [ENEMYC1,ENEMYC2,ENEMYC3] call RETURNRANDOM; 
_inf = [_oC call RETURNRANDOM,_oC call RETURNRANDOM,_oC call RETURNRANDOM,_oC call RETURNRANDOM,_oC call RETURNRANDOM];
_Ppos = getposATL (vehicle (([WEST] CALL AllPf) call RETURNRANDOM));
_nul = [[1036.67,7113.46,50], [(_Ppos select 0)+500-(random 1000),(_Ppos select 1)+500-(random 1000),0], [(_Ppos select 0)+(500-(random 1000))*0.5,(_Ppos select 1)+(500-(random 1000))*0.5,0], EAST, 290, _tank, 50,_inf,[0.6,0.7],0] SPAWN FChopperTransport;
if (random 1 < 0.1*DIFLEVEL && {count Pgroups < VarPG} && {(getmarkerpos (["ColorRed",(vehicle (leader (([WEST] CALL AllPf) call RETURNRANDOM)))] CALL NEARESTCAMP) distance (vehicle (leader (([WEST] CALL AllPf) call RETURNRANDOM))) < 6000)}) then {
_tank = (["AIRC",1] CALL VEHARRAY); 
_tank = _tank call RETURNRANDOM;	
_oC = [ENEMYC1,ENEMYC2,ENEMYC3] call RETURNRANDOM; 
_inf = [_oC call RETURNRANDOM,_oC call RETURNRANDOM,_oC call RETURNRANDOM,_oC call RETURNRANDOM,_oC call RETURNRANDOM];
_nul = [[1046.67,7103.46,50], [(_Ppos select 0)+500-(random 1000),(_Ppos select 1)+500-(random 1000),0], [(_Ppos select 0)+(500-(random 1000))*0.5,(_Ppos select 1)+(500-(random 1000))*0.5,0], EAST, 290, _tank, 50,_inf,[0.6,0.7],0] SPAWN FChopperTransport;
};
if (random 1 < 0.1*DIFLEVEL && {count Pgroups < VarPG} && {(getmarkerpos (["ColorRed",(vehicle (leader (([WEST] CALL AllPf) call RETURNRANDOM)))] CALL NEARESTCAMP) distance (vehicle (leader (([WEST] CALL AllPf) call RETURNRANDOM))) < 6000)}) then {
_tank = (["AIRC",1] CALL VEHARRAY); 
_tank = _tank call RETURNRANDOM;	
_oC = [ENEMYC1,ENEMYC2,ENEMYC3] call RETURNRANDOM; 
_inf = [_oC call RETURNRANDOM,_oC call RETURNRANDOM,_oC call RETURNRANDOM,_oC call RETURNRANDOM,_oC call RETURNRANDOM];
_nul = [[1056.67,7123.46,50], [(_Ppos select 0)+500-(random 1000),(_Ppos select 1)+500-(random 1000),0], [(_Ppos select 0)+(500-(random 1000))*0.5,(_Ppos select 1)+(500-(random 1000))*0.5,0], EAST, 290, _tank, 50,_inf,[0.6,0.7],0] SPAWN FChopperTransport;
};
};

} else {
if (!(SurfaceIsWater getposATL (([WEST] CALL AllPf) call RETURNRANDOM))) then { 
	_d = [] CALL _f1;
	_start = _d select 0;
	_Ppos = _d select 1;
while  {surfaceIsWater _start} do {
sleep 5;
	_d = [] CALL _f1;
	_start = _d select 0;
	_Ppos = _d select 1;
};
_nul = [_start,_posPl] SPAWN _f3; 
};
};

sleep (110 + (random 70));
//SLOW REINFORCEMENTS
[[3],"MusicT",nil,false] spawn BIS_fnc_MP;
if (!(surfaceIsWater getposATL (([WEST] CALL AllPf) call RETURNRANDOM))) then {
if (!isNil"debugi") then {hint "State - Slow Reinf";};


if !([] CALL SAOKREINFCUT) then {
_nul = [_posPl] SPAWN EnemySupport;
};
if (random 1 < 0.3) then {_nul = [] SPAWN FriendlySupport;};
};
sleep 400;
//ALIVE GROUPS TO PATROL
_gps = + Pgroups;
_c = count _gps - 1;
for "_i" from 0 to _c do {
private ["_xx"];
_xx = _gps select _i;
if (!isNil"_xx" && {isNil{_xx getvariable "Diversion"}}) then { 
while {(count (waypoints _xx)) > 0} do {deleteWaypoint ((waypoints _xx) select 0);};
[_xx, [(_posPl select 0) + 1100 -(random 2200),(_posPl select 1) + 1100 -(random 2200),0],600] call bis_fnc_taskPatrol;
};
sleep 0.1;
};
[[1],"MusicT",nil,false] spawn BIS_fnc_MP;
};