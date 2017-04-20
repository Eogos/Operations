_str = (([] CALL NEARESTVILLAGE) + "Task"); 
if (isNil{SaOkmissionNamespace getvariable _str}) then {
//CONVERSATION
(player getvariable "CivC") SPAWN {
_aika = time + 6;
if (!isNil{player getvariable "LastW"}) then {
waitUntil {sleep 0.1; player kbWasSaid [_this, "PlaV", (player getvariable "LastW"), 3] || {_aika < time}};
} else {sleep 6;};
[_this,player, "PlaV", "CivT2"]SPAWN SAOKKBTELL;
};
_head = "Persians are holding a building here in the village causing much fear. Drive them away and you get our support";
_toChoose = ["Dont worry, they wont be here for long","Sorry, we cant drive them away. Too risky for our operation"];
_nul = [_head, _toChoose,"S",[["V17"],["V18"],["V41"]],(player getvariable "CivC")] SPAWN FConversationDialog;
//TASK TAKEN
waitUntil {sleep 0.5; scriptdone _nul};
if (isNil"LineSelected") exitWith {};
if (LineSelected == 0) then {
[player,"TaskFortress",false,false] spawn BIS_fnc_MP;

} else {
//TASK ABORTED (NOT NEEDED)
};

} else {
"You havent completed previous task yet for this village" SPAWN HINTSAOK;
};