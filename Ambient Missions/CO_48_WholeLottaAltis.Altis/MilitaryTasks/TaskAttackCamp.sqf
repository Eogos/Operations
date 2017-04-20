private ["_nV","_str","_mar","_mP","_marker","_Tid","_Lna","_header","_nul","_nearest","_n","_tasks","_picked","_head","_toChoose"];
//CONVERSATION
(player getvariable "CivC") SPAWN {
_aika = time + 4;
if (!isNil{player getvariable "LastW"}) then {
waitUntil {sleep 0.1; player kbWasSaid [_this, "PlaV", (player getvariable "LastW"), 3] || {_aika < time}};
} else {sleep 3;};
_p = ["Sol6"]call RETURNRANDOM;
[_this,player, "ZafV", _p]SPAWN SAOKKBTELL;
};
_head = "We are preparing an assault to nearby CSAT camp. Do you want to join the party?";
_toChoose = ["That would be nice, sure","No way","Anything else I could do?"];
_nul = [_head, _toChoose,"S",[["V17","JinN15","JinN51","JinN52"],["V18","JinN7","JinN8"],["V40"]],(player getvariable "CivC")] SPAWN FConversationDialogSol;
//TASK TAKEN
waitUntil {sleep 0.5; scriptdone _nul};
if (isNil"LineSelected") exitWith {};
if (LineSelected == 0) then {
//_pick = (["ColorBlue",getposATL player] CALL NEARESTCAMP);
[player,"SAOKMULTITASKAC",false,false] spawn BIS_fnc_MP;
} else {
//ANOTHER TASK
if (LineSelected == 2) then {
_tasks = ["MilitaryTasks\TaskAttackCamp.sqf"] CALL SOLDIERSTASKS;
if (count _this > 0) then {_tasks = _tasks - [_this select 0];};
_picked = _tasks call RETURNRANDOM;
if (!isNil{SaOkmissionnamespace getvariable "TaskChosen"} && {SaOkmissionnamespace getvariable "TaskChosen" != "Random Task"}) then {_picked = SaOkmissionnamespace getvariable "TaskChosen";};

_nul = [_picked] SPAWN SAOKSTARTTASK;
};
};

