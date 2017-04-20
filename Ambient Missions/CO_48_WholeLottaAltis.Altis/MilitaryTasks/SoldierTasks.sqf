private ["_tasks"];
_tasks = ["MilitaryTasks\TaskFindOfficer.sqf","MilitaryTasks\TaskKillOfficer.sqf","MilitaryTasks\TaskCreateGuardpost.sqf","MilitaryTasks\TaskConvoy.sqf","MilitaryTasks\TaskZone.sqf"];
if ({getmarkercolor _x == "ColorRed"} count AmbientZonesN > 0 && {{getmarkercolor _x == "ColorBlue"} count AmbientZonesN > 0}) then {_tasks = _tasks + ["MilitaryTasks\TaskAttackCamp.sqf"];};
if ({_x distance player < 4000 && {getmarkercolor (_x getvariable "Gmark") == "ColorGreen"} && {isNil{_x getvariable "Taken"}}} count GuardPosts > 0) then {_tasks = _tasks + ["MilitaryTasks\TaskGuardRoadBlock.sqf"];};
if (count _this > 0) then {_tasks = _tasks - [_this select 0];};
_tasks