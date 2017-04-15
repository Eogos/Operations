private ["_nV","_str","_mar","_mP","_marker","_Tid","_Lna","_header","_nul","_nearest","_n","_tasks","_picked","_head","_toChoose"];
//CONVERSATION
(player getvariable "CivC") SPAWN {
_aika = time + 4;
if (!isNil{player getvariable "LastW"}) then {
waitUntil {sleep 0.1; player kbWasSaid [_this, "PlaV", (player getvariable "LastW"), 3] || {_aika < time}};
} else {sleep 3;};
_p = ["Sol9"]call RETURNRANDOM;
[_this,player, "ZafV", _p]SPAWN SAOKKBTELL;
};
_head = "We lost contact to one of our officers, probably got ambushed. Cant spare any teams to check it out yet, unless you could search the site?";
_toChoose = ["I see what can I do","Sorry, I cant do that","Anything else I could do?"];
_nul = [_head, _toChoose,"S",[["V17","JinN51","JinN52"],["V18","JinN9","JinN10"],["V40"]],(player getvariable "CivC")] SPAWN FConversationDialogSol;
//TASK TAKEN
waitUntil {sleep 0.5; scriptdone _nul};
if (isNil"LineSelected") exitWith {};
if (LineSelected == 0) then {
[1,"TASK_OFFICER",false,false] spawn BIS_fnc_MP;
} else {
//ANOTHER TASK
if (LineSelected == 2) then {
_tasks = ["MilitaryTasks\TaskKillOfficer.sqf"] CALL SOLDIERSTASKS;
if (count _this > 0) then {_tasks = _tasks - [_this select 0];};
_picked = _tasks call RETURNRANDOM;
if (!isNil{SaOkmissionnamespace getvariable "TaskChosen"} && {SaOkmissionnamespace getvariable "TaskChosen" != "Random Task"}) then {_picked = SaOkmissionnamespace getvariable "TaskChosen";};

_nul = [_picked] SPAWN SAOKSTARTTASK;
}
};

