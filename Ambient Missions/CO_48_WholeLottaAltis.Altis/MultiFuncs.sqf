SAOKMULTIPLAYERN = {
if (!isNil"PNEEDS") then {
//PLAYER CONDITION TASKS
if (random 1 < 0.1 && {!(["TaskKipea"] CALL BIS_fnc_taskExists)}) then {
TKipea = true;
[
player, // Task owner(s)
"TaskKipea", // Task ID (used when setting task state, destination or description later)
["You are feeling little sick, try to find medicines from houses using Y to pick up objects or stop by at any friendly camp and use wait time function (Shift+1). Finding medicine from houses gives prestige bonus", "Find Medicine", "Find Medicine"], // Task description
objNull,"CREATED"  ] call BIS_fnc_taskCreate;
};
/*
if (random 1 < 0.1 && {!(["TaskVasynyt"] CALL BIS_fnc_taskExists)}) then {
TVasynyt = true;
[
player, // Task owner(s)
"TaskVasynyt", // Task ID (used when setting task state, destination or description later)
["You are feeling tired. Find a safe place to take nap using wait time function in WLA menu (Shift+1)", "Take a Rest", "Take a Rest"], // Task description
objNull,"CREATED"  ] call BIS_fnc_taskCreate;
};
*/
if (random 1 < 0.25 && {!(["TaskNalka"] CALL BIS_fnc_taskExists)}) then {
TNalka = true;
[
player, // Task owner(s)
"TaskNalka", // Task ID (used when setting task state, destination or description later)
["You are getting hungry, try to find food from houses using Y to pick up objects or stop by at any friendly camp and use wait time function in WLA menu (Shift+1). Finding food from houses gives prestige bonus", "Find Something to Eat", "Find Something to Eat"], // Task description
objNull,
"CREATED"  ] call BIS_fnc_taskCreate;
};
if (random 1 < 0.4 && {!(["TaskJano"] CALL BIS_fnc_taskExists)}) then {
TJano = true;
[
player, // Task owner(s)
"TaskJano", // Task ID (used when setting task state, destination or description later)
["You are getting thirsty, try to find something to drink from houses using Y to pick up objects or stop by at any friendly camp and use wait time function in WLA menu (Shift+1). Finding something to drink from houses gives prestige bonus", "Find Something to Drink", "Find Something to Drink"], // Task description
objNull,"CREATED"  ] call BIS_fnc_taskCreate;
};
};
};

SAOKMULTITASKAC = {
_tar = (["ColorRed",getposATL _this] CALL NEARESTCAMP);
if (!(_tar in AMBbattles) && {getmarkercolor _tar == "ColorRed"}) then {
AMBbattles set [count AMBbattles,_tar];
[_tar] SPAWN {sleep 1200; AMBbattles = AMBbattles - [_this select 0];};
_nul = [_tar] SPAWN FAttackRandom;
} else {
[["Nearest friendly camp have already attack operation going",WEST],"HINTSAOK",nil,false] spawn BIS_fnc_MP;
};
};
SAOKMULTITASKGRB = {
_nearGps = [];
{if (_x distance _this < 4000 && {getmarkercolor (_x getvariable "Gmark") == "ColorGreen"} && {!isNil{_x getvariable "IsRoadBlock"}}) then {_nearGps set [count _nearGps, _x];};} foreach GuardPosts;
if (count _nearGps == 0) exitWith {"Task cancelled, no nearby roadblocks" SPAWN HINTSAOK;};
_nearGps = [_nearGps,[_this],{(_this select 0) distance _x},"ASCEND"] call BIS_fnc_sortBy;
_tar = _nearGps select 0;
_tar setvariable ["Taken",1];
_tarLoc = getposATL _tar;
_mar = format ["GyTaskM%1",NUMM];
NUMM=NUMM+1;
_marker = [_mar,_tarLoc, "mil_flag", [0.8,0.8], "ColorBlue", "Guard this guarpost"] CALL FUNKTIO_CREATEMARKER;
_Tid = format ["TaskMil%1",NUMM];
NUMM=NUMM+1;
_Lna = _tarLoc CALL NEARESTLOCATIONNAME;
_header = format ["Guard Guardpost near %1",_Lna];
[
WEST, // Task owner(s)
_Tid, // Task ID (used when setting task state, destination or description later)
["Time to take some rest and stand guarding nearby roadblock. Better still keep eyes open for suprises", _header, _header], // Task description
_tarLoc, // Task destination
true // true to set task as current upon creation
] call BIS_fnc_taskCreate;
waitUntil {sleep 5; {_x distance _tar < 30} count ([WEST] CALL AllPf) > 0 || {getmarkercolor (_tar getvariable "Gmark") == "ColorRed"}};
if (getmarkercolor (_tar getvariable "Gmark") == "ColorRed") exitWith {deletemarker _marker;_tar setvariable ["Taken",nil];_nul = [_Tid,"FAILED"] call BIS_fnc_taskSetState;[_someId, "onEachFrame"] call BIS_fnc_removeStackedEventHandler;sleep 15;_n = [_Tid] CALL BIS_fnc_deleteTask;};
_uCar =[ENEMYC1,ENEMYC2,ENEMYC3] call RETURNRANDOM;
_VarVEH = (ARMEDVEHICLES select 1)+(ARMEDTANKS select 1);
_st2 = [_tarLoc, 1200,"(1 - sea) * (1 + meadow)",""] CALL FUNKTIO_POS;
_start2 = (_st2 select 0) select 0;
_size = 1200;
while {{_x distance _start2 < 900} count ([] CALL AllPf) > 0} do {
sleep 1;
_st2 = [_tarLoc, _size,"(1 - sea) * (1 + meadow)",""] CALL FUNKTIO_POS;
_start2 = (_st2 select 0) select 0;
_size = _size + 50;
};
_tank = _VarVEH call BIS_fnc_selectRandom;	
_tg1 = [[(_start2 select 0)-30+(random 60),(_start2 select 1)-30+(random 60),0], 0, _tank, EAST] call BIS_fnc_spawnVehicle;
(_tg1 select 0) forcespeed 3;
_unitrate = [4,5];
_random = round(random (_unitrate select 1));
while {_random < (_unitrate select 0)} do {_random = round(random (_unitrate select 1));};
_classes = [];
while {_random > 0} do {_classes set [count _classes,_uCar call RETURNRANDOM];_random = _random - 1;};
_group = [[(_start2 select 0)+40,(_start2 select 1)+30,0], EAST, _classes,[],[],[0.4,0.7]] call SpawnGroupCustom;
if (_mecOrNot == 1 && {_tank in ["O_APC_Wheeled_02_rcws_F","O_APC_Tracked_02_cannon_F"]}) then {
{_x moveincargo (_tg1 select 0);}foreach units _group;
_group SPAWN {waitUntil {sleep 3; {alive _x} count units _this == 0|| {behaviour (leader _this) == "COMBAT"}}; if !({alive _x} count units _this == 0) then {{unassignvehicle _x;} foreach units _this;(units _this) ordergetin false;};};
};

_tg1wp1= (_tg1 select 2) addWaypoint [_tarLoc, 0]; 
[(_tg1 select 2), 1] setWaypointBehaviour "COMBAT";
_wp1 = _group addWaypoint [_tarLoc, 0];
[_group, 1] setWaypointCombatMode "RED";
[_group, 1] setWaypointType "GUARD";
_un = (units _group) + (units (_tg1 select 2));
(_tg1 select 0) SPAWN {waitUntil {sleep 4; isNull _this ||  {{_x distance _this < 200} count ([] CALL AllPf) > 0}}; if (!isNull _this) then {_this forcespeed 3;};};
sleep 30;
[[BaseR, localize "STR_milT1_l1"],"SAOKMULTIGCHAT",nil,false] spawn BIS_fnc_MP;
sleep 10;
[[leader _this, localize "STR_milT1_l2"],"SAOKMULTISCHAT",nil,false] spawn BIS_fnc_MP;
_aika = time + 400;
waitUntil {sleep 5; _aika < time || {{alive _x && {isNil{_x getvariable "SaOkSurrendered"}}} count _un < 3} || {getmarkercolor (_tar getvariable "Gmark") == "ColorRed"}};
if (getmarkercolor (_tar getvariable "Gmark") == "ColorRed") exitWith {deletemarker _marker;_tar setvariable ["Taken",nil];_nul = [_Tid,"FAILED"] call BIS_fnc_taskSetState;[_someId, "onEachFrame"] call BIS_fnc_removeStackedEventHandler;sleep 15;_n = [_Tid] CALL BIS_fnc_deleteTask;};
_n = [WEST,350] SPAWN PrestigeUpdate;
[[350, "Roadblock guarded",WEST],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
_nul = [_Tid,"SUCCEEDED"] call BIS_fnc_taskSetState;
_tar setvariable ["Taken",nil];
deletemarker _marker;
[[BaseR, localize "STR_milT1_l3"],"SAOKMULTIGCHAT",nil,false] spawn BIS_fnc_MP;
sleep 15;
_n = [_Tid] CALL BIS_fnc_deleteTask;
};

SAOKMULTIPOWCRATE = {
_real = true;
_st2 = [getposATL _this, 3150,"(1 - houses) * (1 - sea)"] CALL FUNKTIO_POS;
_home = (_st2 select 0) select 0;
_mP = [(_home select 0)+20-(random 40),(_home select 1)+20-(random 40),0];
_mar = format ["InfoM%1",NUMM];
NUMM=NUMM+1;
_marker = [_mar,_mP, "mil_unknown", [0.8,0.8], "ColorGreen", "Find Weapon Cache"] CALL FUNKTIO_CREATEMARKER;
_Tid = format ["Info%1",NUMM];
NUMM=NUMM+1;
_Lna = _mP CALL NEARESTLOCATIONNAME;
_header = format ["Find Weapon Cache near %1",_Lna];
[
WEST, // Task owner(s)
_Tid, // Task ID (used when setting task state, destination or description later)
["According to surrendered CSAT soldier, there should weapon cache near this location (around inside 20m radius). Should we check it or play safe?", _header, _header], // Task description
_mP, // Task destination
true // true to set task as current upon creation icon = "\A3\ui_f\data\map\markers\military\unknown_CA.paa";
] call BIS_fnc_taskCreate;
NUMM=NUMM+1;
_ranCrate = ["Box_East_WpsSpecial_F","Box_East_Wps_F"] call RETURNRANDOM; 
_crate = createVehicle [_ranCrate,_home, [], 0, "NONE"]; 
_crate setvariable ["AmCrate",1];
waitUntil {sleep 7; {_x distance _crate < 17} count ([WEST] CALL AllPf) > 0};
deletemarker _marker;
_crate setvariable ["AmCrate",nil];
if (_real) then {
_nul = [_Tid,"SUCCEEDED"] call BIS_fnc_taskSetState;
} else {
_nul = [_Tid,"FAILED"] call BIS_fnc_taskSetState;
};
sleep 15;
_n = [_Tid] CALL BIS_fnc_deleteTask;
};

SAOKMULTIPOWDEPOT = {
_real = true;
_st = [getposATL _this, 3000,"(1 - sea) * (1 + meadow)* (1 - hills)",""] CALL FUNKTIO_POS;
_home = (_st select 0) select 0;
_d = 3000;
while {{_x distance _home < 60} count ([] CALL AllPf) > 0} do {
_d = _d + 400;
_st = [getposATL _this, _d,"(1 - sea) * (1 + meadow)* (1 - hills)",""] CALL FUNKTIO_POS;
_home = (_st select 0) select 0;
sleep 0.1;
};
_mP = [(_home select 0)+300-(random 600),(_home select 1)+300-(random 600),0];
_mar = format ["InfoM%1",NUMM];
NUMM=NUMM+1;
_marker = [_mar,_mP, "mil_unknown", [0.8,0.8], "ColorGreen", "Find CSAT Depot"] CALL FUNKTIO_CREATEMARKER;
_Tid = format ["Info%1",NUMM];
NUMM=NUMM+1;
_Lna = _mP CALL NEARESTLOCATIONNAME;
_header = format ["Find CSAT Depot near %1",_Lna];
[
WEST, // Task owner(s)
_Tid, // Task ID (used when setting task state, destination or description later)
["According to surrendered CSAT soldier, there should CSAT Depot near this location (around inside 300m radius). Should we check it or play safe?", _header, _header], // Task description
_mP, // Task destination
true // true to set task as current upon creation
] call BIS_fnc_taskCreate;
NUMM=NUMM+1;
_ranCrate = ["Box_East_WpsSpecial_F","Box_East_Wps_F"] call RETURNRANDOM; 
[_home,40] SPAWN CreateDepot;
waitUntil {sleep 10; {_x distance _home < 50} count ([WEST] CALL AllPf) > 0};
deletemarker _marker;
if (_real) then {
_nul = [_Tid,"SUCCEEDED"] call BIS_fnc_taskSetState;
} else {
_nul = [_Tid,"FAILED"] call BIS_fnc_taskSetState;
};
[_someId, "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
sleep 15;
_n = [_Tid] CALL BIS_fnc_deleteTask;
};

SAOKMULTISMOKESIG = {
_veh = _this select 0;
_veh2 = _this select 1;
{if (leader _x distance vehicle _veh < 700 && (_veh2 == "SmokeShellYellow" || _veh2 == "1Rnd_SmokeYellow_M203" || random 1 < 0.5)) then {
_x move [(getposATL _veh select 0)+(random 100)-(random 100),(getposATL _veh select 1)+(random 100)-(random 100),0];
} else {
if (leader _x distance vehicle _veh < 1000 && random 1 < 0.5 && (_veh2 == "SmokeShellYellow" || _veh2 == "1Rnd_SmokeYellow_M203"|| random 1 < 0.5)) then {
_x move [(getposATL _veh select 0)+(random 100)-(random 100),(getposATL _veh select 1)+(random 100)-(random 100),0];};};
} foreach FriendlyVehicles + FriendlyInf;
};

SAOKMULTISMOKESIG2 = {
_veh = _this select 0;
_veh2 = _this select 1;
{
if (_x distance vehicle _veh < 700 && (_veh2 == "SmokeShellYellow" || _veh2 == "1Rnd_SmokeYellow_M203" || random 1 < 0.5)) then {
unassignvehicle _x; group _x move [(getposATL _veh select 0)+(random 100)-(random 100),(getposATL _veh select 1)+(random 100)-(random 100),0];_nul = [group _x,"ColorYellow"] SPAWN FUNKTIO_GM;
} else {
if (_x distance vehicle _veh < 1000 && random 1 < 0.5 && (_veh2 == "SmokeShellYellow" || _veh2 == "1Rnd_SmokeYellow_M203" || random 1 < 0.5)) then {
unassignvehicle _x; group _x move [(getposATL _veh select 0)+(random 100)-(random 100),(getposATL _veh select 1)+(random 100)-(random 100),0];_nul = [group _x,"ColorYellow"] SPAWN FUNKTIO_GM;
};
};
} foreach CAMPUNITS;
};

SAOKMULTISMOKESIG3 = {
_veh = _this select 0;
_veh2 = _this select 1;
if (_veh2 == "FlareYellow_M203" || _veh2 == "FlareRed_M203" || _veh2 == "FlareGreen_M203"|| _veh2 == "FlareWhite_M203" || _veh2 == "FlareWhite_GP25"|| _veh2 == "FlareGreen_GP25"|| _veh2 == "FlareRed_GP25"|| _veh2 == "FlareYellow_GP25") then {
_isForest = if (surfaceType position _veh == "#CRForest1" || surfaceType position _veh == "#CRForest2" ) then {true} else {false};
_ran = if (_isForest) then {250} else {50};
_g = + CAMPUNITS; 
if (_veh2 == "FlareRed_M203" || _veh2 == "FlareYellow_M203" || _veh2 == "FlareYellow_GP25") then {

{if ((getposATL _veh) distance _x < 1000) then {unassignvehicle _x; group _x move [(getposATL _veh select 0)+(random _ran)-(random _ran),(getposATL _veh select 1)+(random _ran)-(random _ran),0];_nul = [group _x,"ColorYellow"] SPAWN FUNKTIO_GM;};} foreach _g;

_rr = if (_isForest) then {[]} else {FriendlyVehicles};
{if (leader _x distance vehicle _veh < 1000) then {_x move [(getposATL _veh select 0)+(random _ran)-(random _ran),(getposATL _veh select 1)+(random _ran)-(random _ran),0];};} foreach _rr + FriendlyInf;
} else {
{if ((getposATL _veh) distance _x < 600 && (random 1 < 0.5)) then {unassignvehicle _x; group _x move [(getposATL _veh select 0)+(random _ran)-(random _ran),(getposATL _veh select 1)+(random _ran)-(random _ran),0];_nul = [group _x,"ColorYellow"] SPAWN FUNKTIO_GM;};} foreach _g;
_rr = if (_isForest) then {[]} else {FriendlyVehicles};
{if (leader _x distance vehicle _veh < 600 && (random 1 < 0.5)) then {_x move [(getposATL _veh select 0)+(random _ran)-(random _ran),(getposATL _veh select 1)+(random _ran)-(random _ran),0];};} foreach _rr + FriendlyInf;
};
};

};

SAOKMULTIALARM = {
[_this select 0] SPAWN {
private ["_t","_r"];
_t = 0;
_r = ["Alarm","Alarm_OPFOR"] call RETURNRANDOM;
while {_t < 6} do {
_t = _t + 1;
(nearestBuilding (_this select 0)) say3d _r;
sleep 10;
};
};
};
SAOKMULTIPNOW = {(_this select 0) playMoveNow (_this select 1);};

SAOKMULTITTEXT = {
if (side player == EAST || {player distance (_this select 0) > 40}) exitWith {};
titletext [(_this select 1),"PLAIN DOWN",7];
};
SAOKMULTISCHAT = {if (side player == EAST) exitWith {};_s = _this select 0; if (typename _s == "STRING" && {_s == ""}) then {_s = player;}; _s sidechat (_this select 1);};
SAOKMULTIGCHAT = {if (side player == EAST) exitWith {};(_this select 0) globalchat (_this select 1);};

SAOKMULTIHINT1 = {
_veh = _this select 0;
28 cutRsc ["MyRscTitle8","PLAIN"];
disableSerialization;
_disp = uiNamespace getVariable "d8_MyRscTitle";
(_disp displayCtrl 308) ctrlSetStructuredText parseText _veh;
};

SAOKMULTIL1 = {
_veh = _this select 0;
if (_veh distance player > 50 || {side player != WEST}) exitWith {};
[player, player, "PlaV", "V34"] SPAWN SAOKKBTELL;
titletext [((name player)+": This guardpost seems cleared now"),"PLAIN DOWN",1];
};

