
private ["_closest","_dist","_posPl","_nul","_wp","_boole","_y","_forEachIndex","_ranP"];
VARCoLoop = false;

while {VarAlarm} do {

//player pos is revealed if his team is receiving damage
_boole = false;
_EnSeenP = [];
{
_y = _x; 
{
// && {[_x,leader _y] CALL FUNKTIO_LOS}
if (side _y == EAST && {_y knowsabout vehicle _x > 0.4} && {behaviour leader _y == "COMBAT"} && {(leader _y distance vehicle _x < 500)}) exitWith {_EnSeenP = _EnSeenP + [[leader _y, _x]];}; 
} foreach ([WEST] CALL AllPf);
} foreach allGroups;

_takenGs = [];
{if (isNil"_x") then {Pgroups = [Pgroups,_forEachIndex] call BIS_fnc_removeIndex;};} foreach Pgroups;
sleep 0.1;
{if (isNil"_x") then {Pgroups = [Pgroups,_forEachIndex] call BIS_fnc_removeIndex;};} foreach VehicleGroups;
sleep 0.1;
{if (isNil"_x") then {Pgroups = [Pgroups,_forEachIndex] call BIS_fnc_removeIndex;};} foreach NAPAveh;
sleep 0.1;
{
_e = (_x select 0);
_p = (_x select 1);
if (random 1 < 0.1 && {isNil"NOARTYY"}) then {[getposATL _p,EAST] SPAWN F_AIArtyVirtual;};
{
if (_e distance (leader _x) < 1500 && {!(_x in _takenGs)} && {!surfaceisWater getposATL _e}) then {
_takenGs = _takenGs + [_x];
while {(count (waypoints _x)) > 0} do {deleteWaypoint ((waypoints _x) select 0);};
_dist = vehicle _p distance _e;
_start2 = getposATL leader _x;
_posPl=[(getposATL vehicle _p select 0)+(_dist*0.5)-(random _dist),(getposATL vehicle _p select 1)+(_dist*0.5)-(random _dist),0];
[[_start2],"hd_unknown","ColorRed",0] SPAWN SAOKCREATEMARKER;
_mid = [((_start2 select 0)+(_posPl select 0))*0.5,((_start2 select 1)+(_posPl select 1))*0.5,0];
[[_mid],"mil_arrow2","ColorRed",([_start2, _posPl] call BIS_fnc_dirTo)] SPAWN SAOKCREATEMARKER;
_wp = _x addWaypoint [[(_posPl select 0) + 200 - random (400),(_posPl select 1) + 200 - random (400),0], 0]; 
};
} foreach Pgroups + VehicleGroups + NAPAveh;
} foreach _EnSeenP;
waitUntil {sleep 5;!([] CALL SAOKREINFCUT)};
sleep (15+(random 60));
};
VARCoLoop = true;

