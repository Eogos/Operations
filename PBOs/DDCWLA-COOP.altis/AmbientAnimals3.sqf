private ["_dd","_d","_f","_objs","_units","_kerroin","_y","_forEachIndex"];
waitUntil {sleep 1; !isNil"StartMission"};
waitUntil {!isNil"MULTLIFE"};
_objs = [];
_units = [];
_kerroin = 40*(MULTLIFE+1);
Aunits = [];
_f = {
private ["_d","_animalc","_ran","_st","_start","_rd","_animal"];
_animalc = ["Sheep_random_F","Sheep_random_F","Sheep_random_F","Cock_random_F","Fin_random_F","Alsatian_Random_F","Hen_random_F","Goat_random_F"];
_ran = _animalc call RETURNRANDOM;
_d = (["Lb"] CALL DIS);
switch (_ran) do {
case "Rabbit_F": {
_start = [vehicle ([] call RandomP),30,20,"(1 - sea)"] CALL SAOKSEEKPOS;
_rd = floor(random 6);
if (surfaceisWater _start) exitWith {};
while {_rd > 0} do {
sleep 0.1;
_animal = createAgent ["Rabbit_F", _start, [], 0, "FORM"]; 
_animal setdir (random 360);
Aunits pushBack _animal;
_rd = _rd - 1;
};

};
case "Hen_random_F": {
_start = [vehicle ([] call RandomP),_d,100,"(1 + houses) * (1 - sea)"] CALL SAOKSEEKPOS;
_rd = floor(random 6);
if (surfaceisWater _start) exitWith {};
while {_rd > 0} do {
sleep 0.1;
_animal = createAgent ["Hen_random_F", _start, [], 0, "FORM"];
_animal setdir (random 360);
Aunits pushBack _animal;
_rd = _rd - 1;
};
};
case "Alsatian_Random_F": {
_start = [vehicle ([] call RandomP),_d,200,"(1 + houses) * (1 - sea)"] CALL SAOKSEEKPOS;
_rd =1;
if (surfaceisWater _start) exitWith {};
while {_rd > 0} do {
sleep 0.1;
_animal = createAgent ["Alsatian_Random_F", _start, [], 0, "FORM"];
_animal setdir (random 360);
Aunits pushBack _animal;
_rd = _rd - 1;
};
};

case "Goat_random_F": {
_start = [vehicle ([] call RandomP),_d,200,"(1 + meadow) * (1 + houses)* (1 + hills) * (1 - sea)"] CALL SAOKSEEKPOS;
_rd = floor(random 5);
if (surfaceisWater _start) exitWith {};
while {_rd > 0} do {
sleep 0.1;
_animal = createAgent ["Goat_random_F", [(_start select 0) + 50 - (random 100), (_start select 1) + 50 - (random 100),0], [], 0, "FORM"];
_animal setdir (random 360);
Aunits pushBack _animal;
_rd = _rd - 1;
};
};
case "Fin_random_F": {
_start = [vehicle ([] call RandomP),_d,200,"(1 + houses) * (1 - sea)"] CALL SAOKSEEKPOS;
_rd =1;
if (surfaceisWater _start) exitWith {};
while {_rd > 0} do {
sleep 0.1;
_animal = createAgent ["Fin_random_F", _start, [], 0, "FORM"];
_animal setdir (random 360);
Aunits pushBack _animal;
_rd = _rd - 1;
};
};
case "Cock_random_F": {
_start = [vehicle ([] call RandomP),_d,100,"(1 + houses) * (1 - sea)"] CALL SAOKSEEKPOS;
_rd = 1;
if (surfaceisWater _start) exitWith {};
while {_rd > 0} do {
sleep 0.1;
_animal = createAgent ["Cock_random_F", _start, [], 0, "FORM"];
_animal setdir (random 360);
Aunits pushBack _animal;
_rd = _rd - 1;
};
};
case "Sheep_random_F": {
_start = [vehicle ([] call RandomP),_d,200,"(1 + meadow) * (1 - sea)"] CALL SAOKSEEKPOS;
_rd = floor(random 8);
if (surfaceisWater _start) exitWith {};
if (player distance _start < 200) then {_rd = 0;};
while {_rd > 0} do {
sleep 0.1;
_animal = createAgent ["Sheep_random_F", [(_start select 0) + 25 - (random 50), (_start select 1) + 25 - (random 50),0], [], 0, "FORM"];
_animal setdir (random 360);
Aunits pushBack _animal;
_rd = _rd - 1;
};
};
};
};

waitUntil {sleep 1; !isNil"StartMission"};
while {true} do {
sleep 5;
while {count Aunits >= _kerroin || {{isPlayer _x} count ([] CALL AllPf) == 0}} do {
_dd = (["Lb"] CALL DIS) + 100;
{_y = _x; if ({vehicle _x distance _y < _dd} count ([] CALL AllPf) == 0) then {deletevehicle _x;Aunits = Aunits - [_x];};sleep 0.01;} foreach Aunits; 
sleep 0.1;
{if (isnull _x) exitWith {Aunits = Aunits - [_x];};sleep 0.01;} foreach Aunits; 
sleep 0.1;
{if (isNil"_x") exitWith {Aunits = [Aunits,_forEachIndex] call BIS_fnc_removeIndex;};sleep 0.01;} foreach Aunits;
sleep 10;
};
_d = [] SPAWN _f;
waitUntil {sleep 3; scriptdone _d};
};
