

private ["_ranZ","_mark","_locat","_Tid","_Lna","_header","_desc","_mar","_marker","_st","_star","_classs","_n","_nul"];
_ranZ = VEHZONES call RETURNRANDOM;
while {getmarkercolor _ranZ != "ColorRed" || {surfaceisWater (getmarkerpos _ranZ)}} do {sleep 1;_ranZ = VEHZONES call RETURNRANDOM;};
_locat = getmarkerpos _ranZ;

_Tid = format ["TaskOff%1",NUMM];

NUMM=NUMM+1;
_Lna = _locat CALL NEARESTLOCATIONNAME;
_header = format ["Help Green Air Forces to enter near %1",_Lna];
_desc =("CSAT are blocking Green Air Forces to operate. Taking out CSAT zones inside 2km radius would bring some Green Air zones to this area");
[
WEST, // Task owner(s)
_Tid, // Task ID (used when setting task state, destination or description later)
[_desc, _header, _header], // Task description
_locat, // Task destination
"CREATED"
] call BIS_fnc_taskCreate;

_mar = format ["TTmar%1",NUMM];
NUMM=NUMM+1;
_marker = createMarker [_mar,_locat];
_marker setMarkerShape "ELLIPSE";
_marker setMarkerSize [2000, 2000];
_marker setMarkerColor "ColorRed";
_marker setMarkerBrush "BORDER";

_st = [_locat, 1200,"(1 - trees) * (1 - sea) * (1 - houses)"] CALL FUNKTIO_POS;
_star = (_st select 0) select 0;
_classs = ARMEDVEHICLES select 1;
_classs = ["O_APC_Tracked_02_AA_F"];
_n = [_star, "ColorRed",_classs] CALL AddVehicleZone;
_st = [_locat, 1200,"(1 - trees) * (1 - sea) * (1 - houses)"] CALL FUNKTIO_POS;
_star = (_st select 0) select 0;
_classs = ARMEDVEHICLES select 1;
_classs = ["O_APC_Tracked_02_AA_F"];
_n = [_star, "ColorRed",_classs] CALL AddVehicleZone;

_mark = [];
{if (getmarkerpos _x distance _locat < 2000) then {_mark = _mark + [_x];};} foreach VEHZONES;

waitUntil {sleep 10; {_x in AllMapMarkers && {getmarkercolor _x == "ColorRed"} && {getmarkerpos _x distance _locat < 2000} && {!surfaceisWater (getmarkerpos _x)}} count _mark == 0};
_nul = [_Tid,"SUCCEEDED"] call BIS_fnc_taskSetState;
_n = [side player,1000] SPAWN PrestigeUpdate;
[[1000, "Enemy Zone Cleared",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;

sleep 10;
_st = [_locat, 1200,"(1 - trees) * (1 - sea) * (1 - houses)"] CALL FUNKTIO_POS;
_star = (_st select 0) select 0;
_n = [_star, "ColorGreen",["I_Plane_Fighter_03_CAS_F"],"n_plane"] CALL AddVehicleZone;
_st = [_locat, 1200,"(1 - trees) * (1 - sea) * (1 - houses)"] CALL FUNKTIO_POS;
_star = (_st select 0) select 0;
_n = [_star, "ColorGreen",["I_Plane_Fighter_03_CAS_F"],"n_plane"] CALL AddVehicleZone;
sleep 60;
_n = [_Tid] CALL BIS_fnc_deleteTask;
deletemarker _marker;