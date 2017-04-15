CurTaskS = CurTaskS + ["MainTasks\Resistance2.sqf"];
private ["_nul","_now","_ordercode"];
[
WEST, // Task owner(s)
"taskResC", // Task ID (used when setting task state, destination or description later)
["In order to get resistance groups to work with us, we need to prove our lojalty and strenght by capturing any persian camp for them", "Capture any Persian Camp", "Capture any Persian Camp"], // Task description
(getmarkerpos (["ColorRed"] CALL NEARESTCAMP)), // Task destination
true // true to set task as current upon creation
] call BIS_fnc_taskCreate;

sleep 5;



_now = {getmarkercolor _x == "ColorBlue"} count AmbientZonesN;
waitUntil {sleep 10; _now < {getmarkercolor _x == "ColorBlue"} count AmbientZonesN};

_n = [side player,300] SPAWN PrestigeUpdate;
[[300, "From Task",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
_nul = ["taskResC","SUCCEEDED"] call BIS_fnc_taskSetState;
[[4],"MusicT",nil,false] spawn BIS_fnc_MP;
sleep 5;
_nul = [] SPAWN FSideTasks;
_nul = [] execVM "Cutscenes\MeetRes.sqf";
_nul = [] execVM "Cutscenes\USSitRep.sqf";
CurTaskS = CurTaskS - ["MainTasks\Resistance2.sqf"];
//_nul = [] execVM "Cutscenes\MeetResContact2.sqf";
sleep 70;
[] SPAWN TASK_GreenZonesArrive;
