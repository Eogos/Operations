private ["_camps","_pick","_t","_n","_nul","_cPos"];
if (!isServer) exitWith {};
TASK_CreateGuardpost = compileFinal preprocessfileLineNumbers "MainTasks\CreateGuardpost.sqf";
TASK_OFFICER = compileFinal preprocessfileLineNumbers "MainTasks\Officer.sqf";
FDefendBeach =compile preprocessfileLineNumbers "MainTasks\DefendBeach.sqf";
waitUntil {sleep 10; ("ResHelp" in (SaOkmissionnamespace getvariable "Progress")) || {{getmarkercolor _x == "ColorBlue"} count AmbientZonesN > 2}};
sleep (300 + (random 300));
while {true} do {
waitUntil {sleep 20; count AMBbattles < 2};
if (random 1 < 0.7) then {[] SPAWN SAOKCSATTAKEFACTORY;};
//if (random 1 < 0.1) then {[] SPAWN TASK_Bobcat;sleep (30+(random 90));};

if (((worldname CALL SAOKMAPDATA) select 6) && {random 1 < 0.3}) then {
[] SPAWN FDefendBeach;
} else {
if (random 1 < 0.2 && {{getmarkercolor _x == "ColorGreen"} count (PierMarkers + StoMarkers + PowMarkers) > 0}) then {
//STRATEGIC POINT ACTION
if (random 1 < 0.75) then {
_pick = (PierMarkers + StoMarkers + PowMarkers) call RETURNRANDOM;
while {getmarkercolor _pick != "ColorGreen"} do {_pick = (PierMarkers + StoMarkers + PowMarkers) call RETURNRANDOM; sleep 5;};
AMBbattles pushBack _pick;
_nul = [_pick] SPAWN FDefendFactory;
} else {
//SUPPLY LINE ACTION
_nul = [] SPAWN FDefendSupply;
};
} else {
//CAMP ACTION
waitUntil {sleep 5; {getmarkercolor _x == "ColorRed"} count AmbientZonesN > 0 && {{getmarkercolor _x == "ColorBlue"} count AmbientZonesN > 0}};
_camps = [];
{_cPos = getmarkerpos _x;if (getmarkercolor _x == "ColorBlue" && {!(_x in AMBbattles)} && {{getmarkercolor _x == "ColorRed" && {!(getmarkertype _x in ["o_naval","o_art","o_mortar"])} && {getmarkerpos _x distance _cPos < 1000}} count VEHZONESA > 0}) then {_camps pushBack _x;};sleep 0.1;} foreach AmbientZonesN;
_n = _camps SPAWN SAOKCAMPSINDANGER;
waitUntil {sleep 1; scriptdone _n};
_n = (SaOkmissionnamespace getvariable "SaOkCautionCamps") SPAWN SAOKISCAMPOK;
waitUntil {sleep 1; scriptdone _n};
if (random 2 < DIFLEVEL) then {[] SPAWN SAOKCSATTOWARDCAMP;};
if (count _camps > 0 && {random 1 < 0.7}) then {
_pick = _camps call RETURNRANDOM;
AMBbattles pushBack _pick;
[_pick] SPAWN {sleep 1200; AMBbattles = AMBbattles - [_this select 0];};
_nul = [_pick] SPAWN FDefendRandom;
} else {
if (random 2 < DIFLEVEL) then {[] SPAWN SAOKCSATTOWARDCAMP;};
if (random 2 < DIFLEVEL) then {[""] SPAWN SAOKCSATTOWARDCAMP;};
_camps = [];
{_cPos = getmarkerpos _x;if (getmarkercolor _x == "ColorRed" && {!(_x in AMBbattles)} && {{getmarkercolor _x in ["ColorBlue","ColorGreen"] && {getmarkerpos _x distance _cPos < 1000}} count VEHZONESA > 1}) then {_camps pushBack _x;};sleep 0.1;} foreach AmbientZonesN;
if (count _camps > 0) then {
_pick = _camps call RETURNRANDOM;
AMBbattles pushBack _pick;
_nul = [_pick] SPAWN FAttackRandom;
};
};
};
};
_t = 500 + (random 1300);
if (DIFLEVEL < 1) then {_t = 2200 + (random 2300);};
if (DIFLEVEL < 0.5) then {_t = 3500 + (random 2300);};
sleep _t;
};

//ZoneC_1_1_1 _nul = ["ZoneC_1_1_1"] SPAWN FDefendRandom; _nul = ["ZoneC_6"] SPAWN FAttackRandom;

/*
_pick = AmbientZonesN call RETURNRANDOM;
while {getmarkercolor _pick != "ColorBlue"} do {_pick = AmbientZonesN call RETURNRANDOM;};
_nul = [_pick] SPAWN FDefendRandom;
*/