CurTaskS = CurTaskS + ["MainTasks\US1.sqf"];
private ["_nul","_ordercode","_cur"];
[
WEST, // Task owner(s)
"taskUS1", // Task ID (used when setting task state, destination or description later)
["To get NATO support, we need to capture at least one pier for our use", "Secure Pier for NATO Support", "Secure Pier for NATO Support"], // Task description
//[21857.4,10972.3,0], // Task destination
true // true to set task as current upon creation
] call BIS_fnc_taskCreate;

_n = [side player,100] SPAWN PrestigeUpdate;
[[100, "From Task",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;

waitUntil {sleep 3;  {getmarkercolor _x == "ColorGreen"} count PierMarkers > 0};

_nul = ["taskUS1","SUCCEEDED"] call BIS_fnc_taskSetState;
[[4],"MusicT",nil,false] spawn BIS_fnc_MP;
[["NATO military support also available now in the support menu and many squads have arrived on island and ready to be commanded in map view - M",WEST],"HINTSAOK",nil,false] spawn BIS_fnc_MP;

_cur = (SaOkmissionnamespace getvariable "Progress");
SaOkmissionnamespace setvariable ["Progress",_cur + ["USHelp"],true];
_n = ["NATO"] SPAWN SAOKSPAWNBIGCAMP;
_nul = [] execVM "USZonesArrive.sqf";
CurTaskS = CurTaskS - ["MainTasks\US1.sqf"];
sleep 20;
[] SPAWN TASK_BlueZonesArrive;
sleep 120;
[] SPAWN TASK_BlueZonesArrive;