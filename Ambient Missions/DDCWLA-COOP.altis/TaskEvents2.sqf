SAOKCIV1 = {
CurTaskS set [count CurTaskS, "SAOKCIV1"];
sleep (random 120);
_actor1 = [CIVILIAN,(CIVS1 call RETURNRANDOM),150,[1000,1000,0],objNull] CALL FUNKTIO_SPAWNACTOR;
SAOKanswerCi1 = {
switch _this do {
case 0: {"Thank you, and we just want to get closure what have happened to him"};
case 1: {"Thats understable, I need to continue searching him alone"};
}; 
};
SAOKanswerCi2 = {
switch _this do {
case 0: {"I hope to find him alive"};
case 1: {"Be carefull, when searching him"};
}; 
};
_n = [
[getposATL player, player, _actor1],
[],
[
[[[_actor1], "Hi there. Sorry to bother, but one of our villagers have got missing",6]]
,[[[_actor1], ["CSAT dragged him into nearby wooden area for questioning. Havent seen him since"],7]]
,[[[player], "",6,["Okay, we will try looking for him, but could be hard find him","Sorry, but we cant currently help you with that"]]]
,[[[_actor1], {(SAOKCHOSEN SELECT 0) CALL SAOKanswerCi1},6]]
,[[[player], {(SAOKCHOSEN SELECT 0) CALL SAOKanswerCi2},5]]
]
] SPAWN SAOKCUTSCENE;
waitUntil {sleep 0.1; scriptdone _n}; 
_nul = [_actor1,""] SPAWN FHideAndDelete;
_n = (SAOKCHOSEN SELECT 0);
SAOKanswerCi1 = nil;
SAOKanswerCi2 = nil;
SAOKCHOSEN = [];
if (_n == 0) then {
_start = [(vehicle player),4000,600,"(1 + trees) * (1 + forest)"] CALL SAOKSEEKPOS;
[
WEST, // Task owner(s)
"taskCIV1", // Task ID (used when setting task state, destination or description later)
["Civilian have been reported to be taken in woods by CSAT units and no sight of him since. We could try to find him.", "Find Missing Civilian", "Find Missing Civilian"], // Task description
//[21857.4,10972.3,0], // Task destination
true // true to set task as current upon creation
] call SAOKCRTASK;
NUMM=NUMM+1;
_someId = format ["IDSAOK%1",NUMM];
[_someId, "onEachFrame", {
	if (isNil"IC3D") exitWith {};
	drawIcon3D ["\A3\ui_f\data\map\markers\military\circle_CA.paa", ICONCOLORBLUE, _this, 0.8, 0.8, 0, (format ["Find missing civilian inside 120m radius: %1m",round (_this distance player)]), 1, SAOKFSI, "TahomaB"];
}, _start] call BIS_fnc_addStackedEventHandler;
_mar = format ["MainTaskM%1",NUMM];
NUMM=NUMM+1;
_marker = [_mar,_start, "mil_circle", [0.8,0.8], "ColorBlue", "Find Missing Civilian"] CALL FUNKTIO_CREATEMARKER;
waitUntil {sleep 5; player distance _start < 400};
_start = [_start,120,0,"(1 + trees) * (1 + forest)"] CALL SAOKSEEKPOS;
_actor1 = [CIVILIAN,(CIVS1 call RETURNRANDOM),150,_start,objNull] CALL FUNKTIO_SPAWNACTOR;
_actor1 setdamage 1;
waitUntil {sleep 5; (isNull _actor1 || {player distance _actor1 < 7}) && {player distance _start < 400}};
deletemarker _marker;
[_someId, "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
if (isNull _actor1) then {
_nul = ["taskCIV1","FAILED"] call SAOKCOTASK;
_n = [
[getposATL player, player, player],
[],
[
[[[player], "This is hopeless, there is no way to find him. Sad but true",5]]
]
] SPAWN SAOKCUTSCENE;
waitUntil {sleep 1; scriptdone _n};
} else {
_nul = ["taskCIV1","SUCCEEDED"] call SAOKCOTASK;

_actor1 = [CIVILIAN,(CIVS1 call RETURNRANDOM),150,[1000,1000,0],objNull] CALL FUNKTIO_SPAWNACTOR;
SAOKanswerCi1 = {
switch _this do {
case 0: {"Good to hear, I hope those CSAT forces arent here to stay for long"};
case 1: {"Okay, I will prepare some villagers to defend our homes"};
}; 
};
_n = [
[getposATL player, player, _actor1],
[],
[
[[[_actor1], "You found him, so sad to see him dead.",6]]
,[[[_actor1], ["Sorry for following you but couldnt stay back."],7]]
,[[[_actor1], ["But thanks for you help. I have hidden some weapons that I dont need, take them please"],7]]
,[[[player], "",6,["We will accept your offer, will deliver those for resistance","We cant take them, keep them for your own use"]]]
,[[[_actor1], {(SAOKCHOSEN SELECT 0) CALL SAOKanswerCi1},6]]
]
] SPAWN SAOKCUTSCENE;
waitUntil {sleep 0.1; scriptdone _n}; 
_nul = [_actor1,""] SPAWN FHideAndDelete;
_n = (SAOKCHOSEN SELECT 0);
SAOKanswerCi1 = nil;
SAOKCHOSEN = [];
if (_n == 0) then {
_size = 1200;
_st2 = [getposATL player, 1200,"(1 - sea) * (1 + trees)* (1 - hills)",""] CALL FUNKTIO_POS;
_start4 = (_st2 select 0) select 0;
while {_start4 distance getposATL player < 300} do {
sleep 1;
_st2 = [getposATL player, _size,"(1 - sea) * (1 + trees)* (1 - hills)",""] CALL FUNKTIO_POS;
_start4 = (_st2 select 0) select 0;
_size = _size + 50;
};
"Look for crate location on map" SPAWN HINTSAOK;
_mar2 = format ["MainTaskM%1",NUMM];
NUMM=NUMM+1;
_marker = [_mar2,_start4, "mil_flag", [0.5,0.5], "ColorGreen", "Weapon Crate"] CALL FUNKTIO_CREATEMARKER;
_obj = createVehicle ["Box_East_WpsSpecial_F",_start4, [], 0, "NONE"]; 
_obj setvariable ["AmCrate",1];
_obj setdir (random 360);
[_obj,_marker] SPAWN {sleep 1200; (_this select 0) setvariable ["AmCrate",nil];deletemarker (_this select 1);};
};
};
};
[] SPAWN SAOKCIV2;
CurTaskS = CurTaskS - ["SAOKCIV1"];
};

SAOKCIV2 = {CurTaskS = CurTaskS + ["SAOKCIV2"];};

SAOKUSEX1 = {
CurTaskS = CurTaskS + ["SAOKUSEX1"];
sleep 7;
waitUntil {sleep 5; {getmarkercolor _x == "ColorBlue"} count AmbientZonesN > 0};
_nC = getmarkerpos (["ColorBlue"] CALL NEARESTCAMP);
_cl = if (isNil"IFENABLED") then {"I_G_officer_F"} else {"LIB_SOV_captain"};
_actor1 = [WEST,_cl,150,[1000,1000,0],objNull] CALL FUNKTIO_SPAWNACTOR;
SAOKanswerEX1 = {
switch _this do {
case 0: {"Great thing, I will follow you. Here is the camp I would be heading"};
case 1: {"Thats bad, but no problem. I will head back to canteen then"};
}; 
};
_n = [
[getposATL player, player, _actor1],
[],
[
[[[_actor1], "Hey, Lieutenant. I hope I dont interrupt any your work, but would you be heading soon to visit our camps?",11]]
,[[[_actor1], ["I have been waiting for pick up, but it was delayed for hours. Any faster method would be nice"],7]]
,[[[player], "",6,["Yes, ah sure Officer. We can keep you company to get there","I am sorry Officer, but my team have very busy schedule currently"]]]
,[[[_actor1], {(SAOKCHOSEN SELECT 0) CALL SAOKanswerEX1},6]]
]
] SPAWN SAOKCUTSCENE;
waitUntil {sleep 0.1; scriptdone _n}; 
_n = (SAOKCHOSEN SELECT 0);
SAOKanswerEX1 = nil;
SAOKCHOSEN = [];
if (_n == 0) then {
[_actor1] joinSilent player;
NUMM=NUMM+1;
_someId = format ["IDSAOK%1",NUMM];
[_someId, "onEachFrame", {
	if (isNil"IC3D") exitWith {};
	drawIcon3D ["\A3\ui_f\data\map\markers\military\circle_CA.paa", ICONCOLORBLUE, _this, 0.8, 0.8, 0, (format ["Bring the Officer alive here: %1m",round (_this distance player)]), 1, SAOKFSI, "TahomaB"];
}, _nC] call BIS_fnc_addStackedEventHandler;
waitUntil {sleep 6; isNull _actor1 || {!alive _actor1} || {vehicle _actor1 == _actor1 && {_actor1 distance _nC < 50}}};
[_someId, "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
if (isNull _actor1 || {!alive _actor1}) then {
} else {
pisteet = pisteet + 500;
_nul = [500, "Officer Escorted"] SPAWN PRESTIGECHANGE;
_g = creategroup WEST;
[_actor1] joinsilent _g;
_n = [
[getposATL player, player, _actor1],
[],
[
[[[_actor1], "Thank you very much, Lieutentant. That saved much time for me. I will not forget your assistance",9]]
,[[[player], "No problem, was nice trip here. But we better move on now, have a safe day",6]]
]
] SPAWN SAOKCUTSCENE;
 waitUntil {sleep 0.1; scriptdone _n}; 
_nul = [_actor1,""] SPAWN FHideAndDelete;
};
} else {_nul = [_actor1,""] SPAWN FHideAndDelete;};
[] SPAWN SAOKUSEX2;
CurTaskS = CurTaskS - ["SAOKUSEX1"];
};

SAOKUSEX2 = {
CurTaskS = CurTaskS + ["SAOKUSEX2"];
sleep 15;
gameLogic1 globalchat localize "STR_milT9_l1";
sleep 7;
player sidechat localize "STR_milT9_l12";
_start = [(vehicle player),4000,600,"(1 + trees) * (1 + forest)"] CALL SAOKSEEKPOS;
[
WEST, // Task owner(s)
"taskUEX7", // Task ID (used when setting task state, destination or description later)
["Papa Pear have got new intel of fleeing CSAT officer moving towards wooden area. We need to get him dead or alive.", "Find Hiding CSAT Officer", "Find Hiding CSAT Officer"], // Task description
//[21857.4,10972.3,0], // Task destination
true // true to set task as current upon creation
] call SAOKCRTASK;
NUMM=NUMM+1;
_someId = format ["IDSAOK%1",NUMM];
[_someId, "onEachFrame", {
	if (isNil"IC3D") exitWith {};
	drawIcon3D ["\A3\ui_f\data\map\markers\military\circle_CA.paa", ICONCOLORRED, _this, 0.8, 0.8, 0, (format ["Find CSAT Officer inside 200m radius: %1m",round (_this distance player)]), 1, SAOKFSI, "TahomaB"];
}, _start] call BIS_fnc_addStackedEventHandler;
_mar = format ["MainTaskM%1",NUMM];
NUMM=NUMM+1;
_marker = [_mar,_start, "mil_circle", [0.8,0.8], "ColorRed", "Find CSAT Officer"] CALL FUNKTIO_CREATEMARKER;
waitUntil {sleep 5; player distance _start < 500};
_start = [_start,200,0,"(1 + trees) * (1 + forest)"] CALL SAOKSEEKPOS;
_eOc = if (isNil"IFENABLED") then {"O_officer_F"} else {"LIB_SOV_captain"};
_actor1 = [CIVILIAN,_eOc,random 360,_start,objNull] CALL FUNKTIO_SPAWNACTOR;
_actor1 setvariable ["NoTalkative",1];
_g = [group _actor1];
DONTDELGROUPS = DONTDELGROUPS + _g;
{
removeallweapons _x;
_x setcaptive true;
_x setbehaviour "CARELESS";
_x allowfleeing 0;
_x disableAI "MOVE";
_x setdamage 0.5;
} foreach [_actor1];
_pat = [_start,120,10,"(1 + meadow) * (1 - sea)"] CALL SAOKSEEKPOS;
[_pat, [2,3]] SPAWN SAOKADDPATROL;
sleep 1;
_pat = [_start,120,10,"(1 + meadow) * (1 - sea)"] CALL SAOKSEEKPOS;
[_pat, [2,3]] SPAWN SAOKADDPATROL;
waitUntil {sleep 5; {alive _x && {isNil{_x getvariable "SaOkSurrendered"}} && {side _x == EAST}} count (_start nearEntities [["Man"],250]) == 0 || {player distance _start < 30 && {{alive _x && {isNil{_x getvariable "SaOkSurrendered"}} && {side _x == EAST}} count (_start nearEntities [["Man"],120]) == 0}}};
{DONTDELGROUPS = DONTDELGROUPS - [_x];} foreach _g;
deletemarker _marker;
[_someId, "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
if ({!isNull _x && {alive _x}} count [_actor1] > 0) then {
_pic = [];
{if (alive _x) exitWith {_pic = _x;};} foreach [_actor1];
if (typename _pic != "ARRAY") then {
_n = [
[getposATL player, player, _pic],
[],
[
[[[_pic], "I give up, dont shoot dont shoot!",5]]
,[[[player], ["Stay put and dont do anything stupid"],6]]
]
] SPAWN SAOKCUTSCENE;
waitUntil {sleep 0.1; scriptdone _n}; 
};
pisteet = pisteet + 500;
_nul = [500, "Officer Captured"] SPAWN PRESTIGECHANGE;
_nul = ["taskUEX7","SUCCEEDED"] call SAOKCOTASK;
player sidechat localize "STR_milT9_l3";
sleep 7;
gameLogic1 globalchat localize "STR_milT9_l4";
{if (alive _x) then {_x SPAWN SAOKCPICK;};sleep 1;} foreach [_actor1];
} else {
_nul = ["taskUEX7","FAILED"] call SAOKCOTASK;
player sidechat localize "STR_milT9_l5";
sleep 7;
gameLogic1 globalchat localize "STR_milT9_l6";
};
[] SPAWN SAOKUSEX3;
CurTaskS = CurTaskS - ["SAOKUSEX2"];
};

SAOKUSEX3 = {CurTaskS = CurTaskS + ["SAOKUSEX3"];};
