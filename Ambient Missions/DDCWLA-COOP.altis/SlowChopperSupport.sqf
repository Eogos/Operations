private ["_chopg","_tim","_reveal","_driver","_nul","_xx","_yy","_pP","_wp"];
_chopg = _this select 0;
_tim = _this select 1;
_reveal = _this select 2;
_driver = driver (vehicle (leader _chopg));
_driver setbehaviour "CARELESS";
{_x setCombatMode "YELLOW";} foreach units _chopg - [_driver];
if (_reveal == 1) then {
_nul = [_chopg] SPAWN {
private ["_s", "_unit", "_tar"];
_s = _this select 0;
while {!isNull _s && {count units _s > 0}} do {
_tar = (([WEST] CALL AllPf)call RETURNRANDOM) nearTargets 600; 
{
_unit = _x;
{
_unit reveal [_x select 4, 4];
} foreach _tar;
} foreach units _s;
sleep 15;
};
};
};
while {_tim > 0 && {(alive vehicle leader _chopg)} && {alive (driver (vehicle leader _chopg))}} do {
while {(count (waypoints _chopg)) > 0} do
{
deleteWaypoint ((waypoints _chopg) select 0);
};
_xx = random (600);
_yy = 600 - _xx;
if (random 1 < 0.5) then {_xx = _xx*(-1)};
if (random 1 < 0.5) then {_yy = _yy*(-1)};
_pP = getposATL (([WEST] CALL AllPf) call RETURNRANDOM);
_wp = _chopg addWaypoint [[(_pP select 0) + _xx,(_pP select 1) + _yy,0], 0]; 
_wp setWaypointSpeed "LIMITED";
//_wp setWaypointBehaviour "CARELESS";
sleep 20;
_tim = _tim - 20;
};
if (alive (driver (vehicle leader _chopg))) then {_nul = [_chopg, [3481.24,12732.3,0], 7] SPAWN FMoveAndDelete;} else {_nul = [_chopg] SPAWN FMoveAwayAndGetDeleted; CARS = CARS + [(vehicle leader _chopg)];};
