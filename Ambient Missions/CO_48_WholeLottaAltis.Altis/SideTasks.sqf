private ["_tasks","_task","_m"];
//SIDE TASK IN RANDOM ORDER
_tasks = ["MainTasks\BrokenTruck.sqf","MainTasks\HiddenEnemyVeh.sqf","MainTasks\AAVehicle.sqf"];
while {count _tasks > 0} do {
sleep (200 + random 600);
_task = _tasks call RETURNRANDOM;
_tasks = _tasks - [_task];
_m = [] execVM _task;
waitUntil {sleep 20; scriptdone _m};
};

