private ["_car","_start","_end","_side","_dire","_t1","_way1","_xx","_yy","_wp1","_posC","_pPosi","_roads","_nul","_aika"];
_car = _this select 0;
_start = _this select 1;
_end = _this select 2;
_side = _this select 3;
_dire = _this select 4;

_t1 = [_start,1,_car,_side] call SPAWNVEHICLE;
_nul = [(_t1 select 2),"ColorGreen"] SPAWN FUNKTIO_GM;
_way1= (_t1 select 2) addWaypoint [_end, 0]; 
(_t1 select 0) setdir _dire;
if (count _this > 5) then {(_t1 select 2) setspeedmode (_this select 5)};
if (_side==civilian) then {(_t1 select 2) setbehaviour "CARELESS"; (_t1 select 2) allowfleeing 0;} else {(_t1 select 2) setbehaviour "SAFE";};
if (count _this > 6) then {(_t1 select 2) setbehaviour (_this select 6)};
CARS set [count CARS,_t1 select 0];

_posC = getposATL (_t1 select 0);
sleep 60;
//STUCK CHECK
if (_posC distance (_t1 select 0) < 3 && {{_x in (_t1 select 0)} count ([] CALL AllPf) == 0} && {count (crew (_t1 select 0)) > 0}) then {
_xx = random (1000);
_yy = 1000 - _xx;
if (random 1 < 0.5) then {_xx = _xx*(-1)};
if (random 1 < 0.5) then {_yy = _yy*(-1)};
_pPosi = getposATL (([] CALL AllPf) call RETURNRANDOM);
_start = [(_pPosi select 0) + _xx,(_pPosi select 1) + _yy,0];
_roads = (_start nearRoads 450);
if (count _roads > 0) then {_start = getposATL (_roads select 0);}; 
while {surfaceIsWater [_start select 0, _start select 1]} do {
sleep 5;
_pPosi = getposATL (([] CALL AllPf) call RETURNRANDOM);
_xx = random (1000);
_yy = 1000 - _xx;
if (random 1 < 0.5) then {_xx = _xx*(-1)};
if (random 1 < 0.5) then {_yy = _yy*(-1)};
_start = [(_pPosi select 0) + _xx,(_pPosi select 1) + _yy,0];
_roads = (_start nearRoads 450);
if (count _roads > 0) then {_start = getposATL (_roads select 0);}; 
};
(_t1 select 0) setpos _start;
_xx = random (1000);
_yy = 1000 - _xx;
if (random 1 < 0.5) then {_xx = _xx*(-1)};
if (random 1 < 0.5) then {_yy = _yy*(-1)};
_end = [(_pPosi select 0) + _xx,(_pPosi select 1) + _yy,0];
_roads = (_end nearRoads 450);
if (count _roads > 0) then {_end = getposATL (_roads select 0);}; 
while  {surfaceIsWater [_end select 0, _end select 1]} do {
sleep 5;
_xx = random (1000);
_yy = 1000 - _xx;
if (random 1 < 0.5) then {_xx = _xx*(-1)};
if (random 1 < 0.5) then {_yy = _yy*(-1)};
_end = [(_pPosi select 0) + _xx,(_pPosi select 1) + _yy,0];
_roads = (_end nearRoads 450);
if (count _roads > 0) then {_end = getposATL (_roads select 0);}; 
};
while {!isNil"_t1" && {!isNull (_t1 select 2)} && {(count (waypoints (_t1 select 2))) > 0}} do {deleteWaypoint ((waypoints (_t1 select 2)) select 0);};
_wp1= (_t1 select 2) addWaypoint [_end, 0]; 
[(_t1 select 2), 1] setWaypointBehaviour "CARELESS";
};
_aika = time + 300;
waitUntil {sleep 10;isNil"_t1" || {typeName _t1 != "ARRAY"}  || {isNull (_t1 select 2)} || {((leader  (_t1 select 2) distance (_end)) < 50)} || {!(alive leader  (_t1 select 2))} || {{(vehicle _x == (_t1 select 0))} count ([] CALL AllPf) > 0} ||{!(alive (_t1 select 0))} || {_aika < time}};
if (!(alive leader (_t1 select 2)) || {{(vehicle _x == (_t1 select 0))} count ([] CALL AllPf) > 0} || {!(alive (_t1 select 0))}) then {
{_nul = [_x] SPAWN {
_y = _this select 0;
waituntil {sleep 5; {_y distance _x < 400} count ([] CALL AllPf) == 0}; 
deletevehicle _y;
};} foreach (units (_t1 select 2));

_nul = [(_t1 select 2)]SPAWN {
    private ["_y"];    
_y = _this select 0;
waituntil {sleep 5; count units _y == 0}; 
deletegroup _y;
};


};
while {!isNil"_t1" && {!isNull (_t1 select 2)} && {{vehicle _x distance leader (_t1 select 2) < 500} count ([] CALL AllPf) > 0}} do {
_xx = random (1000);
_yy = 1000 - _xx;
if (random 1 < 0.5) then {_xx = _xx*(-1)};
if (random 1 < 0.5) then {_yy = _yy*(-1)};
_pPosi = getposATL (vehicle (([] CALL AllPf) call RETURNRANDOM));
_end = [(_pPosi select 0) + _xx,(_pPosi select 1) + _yy,0];
_roads = (_end nearRoads 300);
if (count _roads > 0) then {_end = getposATL (_roads select 0);};  
while  {surfaceIsWater _end} do {
sleep 5;
_pPosi = getposATL (vehicle (([] CALL AllPf) call RETURNRANDOM));
_xx = random 2000;
_yy = 2000 - _xx;
if (random 1 < 0.5) then {_xx = _xx*(-1)};
if (random 1 < 0.5) then {_yy = _yy*(-1)};
_end = [(_pPosi select 0) + _xx,(_pPosi select 1) + _yy,0];
if (count _roads > 0) then {_end = getposATL (_roads select 0);}; 
};
while {!isNil"_t1" && {!isNull (_t1 select 2)} && {(count (waypoints (_t1 select 2))) > 0}} do {deleteWaypoint ((waypoints (_t1 select 2)) select 0);};
_wp1= (_t1 select 2) addWaypoint [_end, 0]; 
waitUntil {sleep 10;((leader  (_t1 select 2) distance (_end)) < 50) || {!(alive leader  (_t1 select 2))} || {{(vehicle _x == (_t1 select 0))} count ([] CALL AllPf) > 0} ||{!(alive (_t1 select 0))}};
if ( !(alive leader  (_t1 select 2)) || {{(vehicle _x == (_t1 select 0))} count ([] CALL AllPf) > 0} ||{!(alive (_t1 select 0))}) exitWith {
{_nul = [_x]SPAWN {
_y = _this select 0;
waituntil {sleep 5; {_y distance _x < 400} count ([] CALL AllPf) == 0}; 
deletevehicle _y;
};} foreach (units (_t1 select 2));

_nul = [(_t1 select 2)]SPAWN {
_x = _this select 0;
waituntil {sleep 5; count units _x == 0}; 
deletegroup _x;
};


};
sleep 5;
};



if ({_x distance leader  (_t1 select 2) < 500} count ([] CALL AllPf) == 0) then {
{unassignvehicle _x;[_x] ordergetin false;} foreach units  (_t1 select 2);
waitUntil {sleep 10; isNil"_t1" || {typeName _t1 != "ARRAY"} || {isNull (_t1 select 2)} || {(vehicle leader  (_t1 select 2) == leader  (_t1 select 2) && {{(_x distance leader  (_t1 select 2) < 500)} count ([] CALL AllPf) == 0})}};
{deletevehicle _x;} foreach [(_t1 select 0)];
{deletevehicle _x;} foreach (units (_t1 select 2));
{deletegroup _x;} foreach [(_t1 select 2)];
};
MAXCARS=MAXCARS+1;