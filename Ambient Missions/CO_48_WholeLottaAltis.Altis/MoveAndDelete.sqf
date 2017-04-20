//////////////////////////////////////////////////////////////////
// Function file for Armed Assault
// Created by: TODO: Author Name
//////////////////////////////////////////////////////////////////

private ["_group", "_pos", "_tim","_wp"];

_group = _this select 0;
_pos = _this select 1;
_tim =  _this select 2;
sleep _tim;
//thanks kju for example
if (!isNull _group) then {
while {(count (waypoints _group)) > 0} do
{
 deleteWaypoint ((waypoints _group) select 0);
};
_wp = _group addWaypoint [_pos, 0];
_wp setWaypointSpeed "FULL";
};
waituntil {sleep 3; isNull _group || (leader _group) distance _pos < 400};
if (!isNull _group) then {
{deletevehicle _x;} foreach [vehicle (leader _group)] + (units _group);
};