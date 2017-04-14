private ["_nV","_str","_mar","_mP","_marker","_Tid","_Lna","_header","_nul","_nearest","_n","_tasks","_picked","_head","_toChoose"];
//CONVERSATION
(player getvariable "CivC") SPAWN {
_aika = time + 4;
if (!isNil{player getvariable "LastW"}) then {
waitUntil {sleep 0.1; player kbWasSaid [_this, "PlaV", (player getvariable "LastW"), 3] || {_aika < time}};
} else {sleep 3;};
_p = ["Pow7"]call RETURNRANDOM;
[_this,player, "ZafV", _p]SPAWN SAOKKBTELL;
};
_head = "Wait, they have one depot not far from here";
_toChoose = ["Tell me more","Not interested of your traps"];
_nul = [_head, _toChoose,"S",[["JinN33","JinN32"],["JinN42","JinN43","JinN38"]]] SPAWN FConversationDialogSol;
//TASK TAKEN
waitUntil {sleep 0.5; scriptdone _nul};
if (isNil"LineSelected") exitWith {};
if (LineSelected == 0) then {
[player,"SAOKMULTIPOWDEPOT",false,false] spawn BIS_fnc_MP;
};

