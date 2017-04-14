sleep (30 + (random 90));
if (random 1 < 0.2 && {!(["TaskKipea"] CALL BIS_fnc_taskExists)}) then {
[
player, // Task owner(s)
((name player)+"TaskKipea"), // Task ID (used when setting task state, destination or description later)
["You are feeling little sick, try to find medicines from houses using Y to pick up objects. Finding medicine from houses gives prestige bonus", "Find Medicine", "Find Medicine"], // Task description
true // true to set task as current upon creation
] call BIS_fnc_taskCreate;
};
if (random 1 < 0.5 && {!(["TaskNalka"] CALL BIS_fnc_taskExists)}) then {
[
player, // Task owner(s)
((name player)+"TaskNalka"), // Task ID (used when setting task state, destination or description later)
["You are getting hungry, try to find food from houses using Y to pick up objects. Finding food from houses gives prestige bonus", "Find Something to Eat", "Find Something to Eat"], // Task description
true // true to set task as current upon creation
] call BIS_fnc_taskCreate;
};
if (random 1 < 0.5 && {!(["TaskJano"] CALL BIS_fnc_taskExists)}) then {
[
player, // Task owner(s)
((name player)+"TaskJano"), // Task ID (used when setting task state, destination or description later)
["You are getting thirsty, try to find something to drink from houses using Y to pick up objects. Finding something to drink from houses gives prestige bonus", "Find Something to Drink", "Find Something to Drink"], // Task description
true // true to set task as current upon creation
] call BIS_fnc_taskCreate;
};
while {true} do {
sleep (300+(random 700));
//PLAYER CONDITION TASKS
if (random 1 < 0.1 && {!(["TaskKipea"] CALL BIS_fnc_taskExists)}) then {
[
player, // Task owner(s)
((name player)+"TaskKipea"), // Task ID (used when setting task state, destination or description later)
["You are feeling little sick, try to find medicines from houses using Y to pick up objects. Finding medicine from houses gives prestige bonus", "Find Medicine", "Find Medicine"], // Task description
true // true to set task as current upon creation
] call BIS_fnc_taskCreate;
};
if (random 1 < 0.25 && {!(["TaskNalka"] CALL BIS_fnc_taskExists)}) then {
[
player, // Task owner(s)
((name player)+"TaskNalka"), // Task ID (used when setting task state, destination or description later)
["You are getting hungry, try to find food from houses using Y to pick up objects. Finding food from houses gives prestige bonus", "Find Something to Eat", "Find Something to Eat"], // Task description
true // true to set task as current upon creation
] call BIS_fnc_taskCreate;
};
if (random 1 < 0.4 && {!(["TaskJano"] CALL BIS_fnc_taskExists)}) then {
[
player, // Task owner(s)
((name player)+"TaskJano"), // Task ID (used when setting task state, destination or description later)
["You are getting thirsty, try to find something to drink from houses using Y to pick up objects. Finding something to drink from houses gives prestige bonus", "Find Something to Drink", "Find Something to Drink"], // Task description
true // true to set task as current upon creation
] call BIS_fnc_taskCreate;
};

};
