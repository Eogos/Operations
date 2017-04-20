private ["_FTFail","_F1","_condNoWEST","_time","_wp1","_tg1wp1","_posPl","_class","_random","_unitrate","_tg1","_tank","_mecOrNot","_header","_Lna","_Tid","_marS","_size","_start2","_st2","_timer","_locationA","_marrr","_uCar","_VarVEH","_ALLunits","_VEHs","_INFgroups","_VEHgroups","_RedGuardPs","_FrGuardPs","_RedCamps","_FrCamps","_tA","_text","_V","_classes","_group","_nul","_n","_ran","_ker","_C","_Zcol","_st","_star","_classs","_F","_E","_G","_num","_mP","_ResultColor","_dist","_mar5","_data","_desc","_wpPP","_mid","_someId"];


_condNoWEST = {
private ["_bol"];
_bol = false; 
if ({alive _x && {isNil{_x getvariable "SaOkSurrendered"}} && {side _x != EAST && {side _x != CIVILIAN}}} count (_this nearEntities [["Man"],100]) < 2) then {_bol = true;};
_bol
};

_F1 = {
/*
{
VehicleGroups set [count VehicleGroups,_x];
} foreach (_this select 0);
*/
{
CARS set [count CARS,_x];
_x setvariable ["EndS",1];
} foreach (_this select 1);
{
Pgroups set [count Pgroups,_x];
} foreach (_this select 2);
};

_FTFail = {
_n = [getMarkerPos (_this select 0),"EAST"] CALL GuardPostSide;
["ScoreRemoved",["Enemy attack succeeded. You lost camp",30]] call bis_fnc_showNotification;
_nul = [(_this select 1),"FAILED"] call SAOKCOTASK;
(_this select 0) setmarkercolor "ColorRed";
};

//INIT
_VEHgroups = [];
_INFgroups = [];
_VEHs = [];
_ALLunits = [];
_VarVEH = (ARMEDVEHICLES select 1)+(ARMEDTANKS select 1);
_uCar =[ENEMYC1,ENEMYC2,ENEMYC3] call RETURNRANDOM;
_marrr = (_this select 0);
UndAttackMs set [count UndAttackMs, _marrr]; 
_locationA = getmarkerpos (_this select 0);
_timer = time + (180 + (random 500));
_dist = 100 + (random 250);
_st2 = [_locationA, 1200,"(1 - sea) * (1 + meadow)",""] CALL FUNKTIO_POS;
_start2 = (_st2 select 0) select 0;
_size = 1200;
while {{_start2 distance _x < 500} count VarBlackListE > 0 || {{_start2 distance _x < 500} count VarBlackListF > 0} || {player distance _start2 < 900} || {_start2 distance _locationA < 900}} do {
sleep 1;
_st2 = [_locationA, _size,"(1 - sea) * (1 + meadow)",""] CALL FUNKTIO_POS;
_start2 = (_st2 select 0) select 0;
_size = _size + 50;
};
_marS = format ["LINEmar%1",NUMM];
NUMM=NUMM+1;
_mar5 = [_marS,_locationA,"Select",[0.9,0.9],"ColorBlack","Assist to Defend"] CALL FUNKTIO_CREATEMARKER;
if ({getmarkercolor _x == "ColorRed" && {getmarkerpos _x distance (getmarkerpos _mar5) < 5000}} count AAsM == 0) then {
_wpPP = getmarkerpos _mar5;
_mid = [((_start2 select 0)+(_wpPP select 0))*0.5,((_start2 select 1)+(_wpPP select 1))*0.5,0];
[[_mid],"mil_arrow","ColorRed",([_start2, _wpPP] call BIS_fnc_dirTo)] SPAWN SAOKCREATEMARKER;
};
[["WLA","Battle"]] call BIS_fnc_advHint;
_data = ["EXPECTED BATTLE",_locationA,[],[["I_static_AT_F","n_unknown"],["I_HMG_01_high_F","n_unknown"]]] CALL BattleVirtualIntel;
_ResultColor = _data select 0;
_Tid = format ["TaskBat%1",NUMM];
NUMM=NUMM+1;
_TidE = format ["TaskBatE%1",NUMM];
NUMM=NUMM+1;
_Lna = _locationA CALL NEARESTLOCATIONNAME;
_header = format ["Defend Camp near %1",_Lna];
_desc =("One of friendly camps is about to get under attack by persians. Should we give them hand or hope their defenses is enough?"+_ResultColor);
[
WEST, // Task owner(s)
_Tid, // Task ID (used when setting task state, destination or description later)
[_desc, _header, _header], // Task description
_locationA, // Task destination
"CREATED" // true to set task as current upon creation
] call BIS_fnc_taskCreate;
_header = format ["Attack Camp near %1",_Lna];
_desc =("We are preparing to attack one camp that is hold by NATO. Care to join?"+_ResultColor);
[
EAST, // Task owner(s)
_TidE, // Task ID (used when setting task state, destination or description later)
[_desc, _header, _header], // Task description
_locationA, // Task destination
"CREATED" // true to set task as current upon creation
] call BIS_fnc_taskCreate;

//_ran = ["STR_Sp8t2r1","STR_Sp8t2r1a","STR_Sp8t2r1b","STR_Sp8t2r1c"] call BIS_fnc_selectRandom;
///////////RADIO CHAT
_RedCamps = 0;
_RedGuardPs =0;
_FrCamps = 0;
_FrGuardPs =0;
{if (_x distance _locationA < 1700) then {
if (getmarkercolor (_x getvariable "Gmark") == "ColorRed") then {_RedGuardPs = _RedGuardPs + 1;} else {_FrGuardPs = _FrGuardPs + 1;};
};} foreach GuardPosts;
{if ((getmarkerpos _x) distance _locationA < 1700) then {
if ((getmarkercolor _x) == "ColorRed") then {_RedCamps = _RedCamps + 1;} else {_FrCamps = _FrCamps + 1;};
};} foreach AmbientZonesN;
_text = ("Wolf, our camp near "+_Lna+" is about to get attacked by 1-3 enemy vehicles and infantry");
//_text = _text + (getText (configfile >> "CfgVehicles" >> _tank >> "displayName"));
if ("o_air" in (_data select 2) || {"o_armor" in (_data select 2)} || {"o_uav" in (_data select 2)}) then {
_text = _text + ". We also have reports of possible recent hostile";
_tA = [];
if ("o_air" in (_data select 2)) then {_tA = _tA + ["air_support"];};
if ("o_armor" in (_data select 2)) then {_tA = _tA + ["armor"];};
if ("o_uav" in (_data select 2)) then {_tA = _tA + ["UAV"];};
{_text = _text + " "+_x; _tA = _tA - [_x]; if (count _tA == 1) then {_text = _text + " and";}; if (count _tA > 1) then {_text = _text + ",";};} foreach _tA;
_text = _text + " presence in the AO that could support the attack"; 
};
if (_RedCamps > 1 || {_RedGuardPs > 0}) then {_text = _text + ". There is "; };
if (_RedCamps > 1) then {
//_text = _text + "another ";[[WEST,"base"],"Radio_1"] CALL RadioF; 
if ((_RedCamps-1) != 1) then {_text = _text + (format ["%1",(_RedCamps-1)]);};
_text = _text + " camp";_V = (format ["N%1",(_RedCamps-1)]);if (_V != "N1") then {};};
if (_RedCamps == 2) then {};
if (_RedCamps > 2) then {_text = _text +"s";};
if (_RedCamps > 1 && {_RedGuardPs > 0}) then {_text = _text + " and ";};
if (_RedGuardPs > 0) then {if (_RedGuardPs != 1) then {_text = _text +(format ["%1",_RedGuardPs]);};
_text = _text +" guardpost";_V = (format ["N%1",_RedGuardPs]);if (_V != "N1") then {};};
if (_RedGuardPs == 1) then {};
if (_RedGuardPs > 1) then {_text = _text + "s";  };
if (_RedCamps > 1 || {_RedGuardPs > 0}) then {_text = _text + " with hostile activity nearby that could have unknown role"; };
_text = _text + ".";
[[BaseR, _text],"SAOKMULTIGCHAT",nil,false] spawn BIS_fnc_MP;
sleep 6;
_text = "";
if ("b_air" in (_data select 2) || {"b_armor" in (_data select 2)} || {"b_uav" in (_data select 2)} || {"n_plane" in (_data select 2)} || {"n_air" in (_data select 2)} || {"n_armor" in (_data select 2)} || {"n_uav" in (_data select 2)}) then {
_text = _text + " We have friendly";
_tA = [];
if ("b_air" in (_data select 2) || {"n_plane" in (_data select 2)} || {"n_air" in (_data select 2)}) then {_tA = _tA + ["air_support"];};
if ("b_armor" in (_data select 2) || {"n_armor" in (_data select 2)}) then {_tA = _tA + ["armor"];};
if ("b_uav" in (_data select 2) || {"n_uav" in (_data select 2)}) then {_tA = _tA + ["UAV"];};
{_text = _text + " "+_x; _tA = _tA - [_x]; if (count _tA == 1) then {_text = _text + " and";}; if (count _tA > 1) then {_text = _text + ",";};} foreach _tA;
_text = _text + " operating near the camp which should heading to help us. ";
};
if (_FrCamps > 1 || {_FrGuardPs > 0}) then {_text = _text + "To defend our assests, nearby ";} else {_text = _text + " We have no nearby camps or any guardposts supporting us.";};
if (_FrCamps > 1) then {if ((_FrCamps-1) != 1) then {_text = _text + (format ["%1 ",(_FrCamps-1)]);};
_text = _text + "camp";_V = (format ["N%1",(_FrCamps-1)]);if (_V != "N1") then {};};
if (_FrCamps == 2) then {};
if (_FrCamps > 2) then {_text = _text +"s";};
if (_FrCamps > 1 && {_FrGuardPs > 0}) then {_text = _text + " and ";};
if (_FrGuardPs > 0) then {if (_FrGuardPs != 1) then {_text = _text +(format ["%1 ",_FrGuardPs]);}; 
 _text = _text + "guardpost";_V = (format ["N%1",_FrGuardPs]);if (_V != "N1") then {};};
if (_FrGuardPs == 1) then {};
if (_FrGuardPs > 1) then {_text = _text + "s"; };
if (_FrCamps > 1 || {_FrGuardPs > 0}) then {_text = _text + " are called to send men join the battle.";};

_text = _text + " If you are unattached, we could use an extra hand here. Out.";
[[BaseR, _text],"SAOKMULTIGCHAT",nil,false] spawn BIS_fnc_MP;
////////////////////////////


waitUntil {sleep 5; ({_x distance _locationA < 1400} count ([] CALL AllPf) > 0) || {_timer < time}};
if ({_x distance _locationA < 1400} count ([] CALL AllPf) > 0) then {
//CLOSE
sleep 15;
_v = [EAST,_locationA,3000] CALL SAOKZONEVEHICLESNEARBY;
_size = [0,0,0,0,1,1,1,2] call RETURNRANDOM;
for "_i" from 0 to _size do {
if (count _v > 0) then {
_mecOrNot = [0,1] call RETURNRANDOM;
_pickV = _v call RETURNRANDOM;
if (count crew _pickV > 0) then {
_VEHgroups = _VEHgroups + [group (crew _pickV select 0)];
(group (crew _pickV select 0)) SPAWN SAOKREMOVEWAYPOINTS; 
};
_VEHs = _VEHs + [_pickV];
_pickV forcespeed 3;
_unitrate = [4,5];
_random = round(random (_unitrate select 1));
while {_random < (_unitrate select 0)} do {_random = round(random (_unitrate select 1));};
_classes = [];
while {_random > 0} do {_classes set [count _classes,_uCar call RETURNRANDOM];_random = _random - 1;};
_group = [[(_start2 select 0)+40,(_start2 select 1)+30,0], EAST, _classes,[],[],[0.4,0.7]] call SpawnGroupCustom;
_INFgroups = _INFgroups + [_group];
if (_mecOrNot == 1 && {typeof _pickV in ["O_APC_Wheeled_02_rcws_F","O_APC_Tracked_02_cannon_F"]}) then {
{_x moveincargo _pickV;}foreach units _group;
_group SPAWN {waitUntil {sleep 3; {alive _x} count units _this == 0|| {behaviour (leader _this) == "COMBAT"}}; if !({alive _x} count units _this == 0) then {{unassignvehicle _x;} foreach units _this;(units _this) ordergetin false;};};
};
} else {
_unitrate = [4,5];
_random = round(random (_unitrate select 1));
while {_random < (_unitrate select 0)} do {_random = round(random (_unitrate select 1));};
_classes = [];
while {_random > 0} do {_classes set [count _classes,_uCar call RETURNRANDOM];_random = _random - 1;};
_group = [[(_start2 select 0)+40,(_start2 select 1)+30,0], EAST, _classes,[],[],[0.4,0.7]] call SpawnGroupCustom;
_INFgroups = _INFgroups + [_group];
};
};
{_ALLunits = _ALLunits + (units _x);} foreach _VEHgroups + _INFgroups;
waitUntil {sleep 5; _timer < time || {vehicle player distance _locationA < _dist}};
//AIR SUPPORT
if (random 1 < 0.3 && {_size < 1} && {([] CALL FPSGOOD)}) then {
_class = (AIRFIGTHER select 1)+(AIRARMCHOP select 1); 
_class = _class call RETURNRANDOM;	
_tg1 = [[(getposATL vehicle player select 0)+2500,(getposATL vehicle player select 1)+2500,50], 0, _class, EAST] call SPAWNVEHICLE;
_posPl = [(getposATL (vehicle player) select 0) + 100 -(random 200), (getposATL (vehicle player) select 1)+ 100 -(random 200), 0];
_tg1wp1= (_tg1 select 2) addWaypoint [_locationA, 0]; 
[(_tg1 select 2), 1] setWaypointBehaviour "AWARE";
[(_tg1 select 2), 1] setWaypointType "GUARD";
_nul = [(_tg1 select 2), [1541.39,5059.05,0],200] SPAWN FUNKTIO_MAD;
};
//BEGIN ATTACK
if ({getmarkercolor _x == "ColorRed" && {getmarkerpos _x distance (getmarkerpos _mar5) < 5000}} count AAsM == 0) then {
_wpPP = getmarkerpos _mar5;
_mid = [((_start2 select 0)+(_wpPP select 0))*0.5,((_start2 select 1)+(_wpPP select 1))*0.5,0];
[[_mid],"mil_arrow","ColorRed",([_start2, _wpPP] call BIS_fnc_dirTo)] SPAWN SAOKCREATEMARKER;
};
{
if (!isNil{_x getvariable "GMar"}) then {
[_x getvariable "GMar", _locationA] SPAWN ZoneMove;
} else {
_tg1wp1= _x addWaypoint [_locationA, 0]; 
[_x, 1] setWaypointBehaviour "COMBAT";
};
} foreach _VEHgroups;
{
_wp1 = _x addWaypoint [_locationA, 0];
[_x, 1] setWaypointCombatMode "RED";
[_x, 1] setWaypointType "GUARD";
} foreach _INFgroups;


_time = time + 600;
_ran = ["STR_Sp8t2r4","STR_Sp8t2r4a","STR_Sp8t2r4b"] call BIS_fnc_selectRandom;
[[BaseR, localize _ran],"SAOKMULTIGCHAT",nil,false] spawn BIS_fnc_MP;
_ker = (count _ALLunits)*0.2;
waitUntil {sleep 5; {alive _x && {isNil{_x getvariable "SaOkSurrendered"}} && {!(fleeing _x)}} count _ALLunits < _ker || {_time < time}  ||  {getmarkercolor _marrr ==  "ColorRed"}};
if (getmarkercolor _marrr ==  "ColorRed") then {
//END2 LOOSING

[_VEHgroups,_VEHs,_INFgroups] SPAWN _F1;
//[_marrr,_Tid] SPAWN _FTFail;

_nul = [_Tid,"FAILED"] call BIS_fnc_taskSetState;
_nul = [_TidE,"SUCCEEDED"] call BIS_fnc_taskSetState;
_marrr setmarkercolor "ColorRed";
[getMarkerPos _marrr,EAST] SPAWN ADDR;
_ran = ["STR_Sp8t2r3","STR_Sp8t2r3a","STR_Sp8t2r3b"] call BIS_fnc_selectRandom;
[["Enemy attack succeeded. You lost camp",WEST],"HINTSAOK",nil,false] spawn BIS_fnc_MP;
[[BaseR, localize _ran],"SAOKMULTIGCHAT",nil,false] spawn BIS_fnc_MP;

deletemarker _mar5;
} else {
//END C WINNING
[_VEHgroups,_VEHs,_INFgroups] SPAWN _F1;

[getMarkerPos _marrr,WEST] SPAWN ADDR;
_nul = [_Tid,"SUCCEEDED"] call BIS_fnc_taskSetState;
_nul = [_TidE,"FAILED"] call BIS_fnc_taskSetState;
//_nul = [] SPAWN {VarPG = VarPG - 1;sleep 900;VarPG = VarPG + 1;};
_ran = ["STR_Sp8t2r2","STR_Sp8t2r2a","STR_Sp8t2r2b"] call BIS_fnc_selectRandom;
[["Enemy attack didnt succeed",WEST],"HINTSAOK",nil,false] spawn BIS_fnc_MP;
[[BaseR, localize _ran],"SAOKMULTIGCHAT",nil,false] spawn BIS_fnc_MP;
deletemarker _mar5;
};

} else {
//FAR W T
_time = time + 600;
_ran = ["STR_Sp8t2r4","STR_Sp8t2r4a","STR_Sp8t2r4b"] call BIS_fnc_selectRandom;
[[BaseR, localize _ran],"SAOKMULTIGCHAT",nil,false] spawn BIS_fnc_MP;
waitUntil {sleep 5; _time < time ||  {getmarkercolor _marrr ==  "ColorRed"} || {{_x distance _locationA < 1400} count ([] CALL AllPf) > 0}};
if ({_x distance _locationA < 1400} count ([] CALL AllPf) > 0) then {
//CLOSE
sleep 15;
_v = [EAST,_locationA,3000] CALL SAOKZONEVEHICLESNEARBY;
_size = [0,0,0,0,1,1,1,2] call RETURNRANDOM;
for "_i" from 0 to _size do {
if (count _v > 0) then {
_mecOrNot = [0,1] call RETURNRANDOM;
_pickV = _v call RETURNRANDOM;
if (count crew _pickV > 0) then {
_VEHgroups = _VEHgroups + [group (crew _pickV select 0)];
(group (crew _pickV select 0)) SPAWN SAOKREMOVEWAYPOINTS; 
};
_VEHs = _VEHs + [_pickV];
_pickV forcespeed 3;
_unitrate = [4,5];
_random = round(random (_unitrate select 1));
while {_random < (_unitrate select 0)} do {_random = round(random (_unitrate select 1));};
_classes = [];
while {_random > 0} do {_classes set [count _classes,_uCar call RETURNRANDOM];_random = _random - 1;};
_group = [[(_start2 select 0)+40,(_start2 select 1)+30,0], EAST, _classes,[],[],[0.4,0.7]] call SpawnGroupCustom;
_INFgroups = _INFgroups + [_group];
if (_mecOrNot == 1 && {typeof _pickV in ["O_APC_Wheeled_02_rcws_F","O_APC_Tracked_02_cannon_F"]}) then {
{_x moveincargo _pickV;}foreach units _group;
_group SPAWN {waitUntil {sleep 3; {alive _x} count units _this == 0|| {behaviour (leader _this) == "COMBAT"}}; if !({alive _x} count units _this == 0) then {{unassignvehicle _x;} foreach units _this;(units _this) ordergetin false;};};
};
} else {
_unitrate = [4,5];
_random = round(random (_unitrate select 1));
while {_random < (_unitrate select 0)} do {_random = round(random (_unitrate select 1));};
_classes = [];
while {_random > 0} do {_classes set [count _classes,_uCar call RETURNRANDOM];_random = _random - 1;};
_group = [[(_start2 select 0)+40,(_start2 select 1)+30,0], EAST, _classes,[],[],[0.4,0.7]] call SpawnGroupCustom;
_INFgroups = _INFgroups + [_group];
};
};
{_ALLunits = _ALLunits + (units _x);} foreach _VEHgroups + _INFgroups;
waitUntil {sleep 5; _timer < time || {{vehicle _x distance _locationA < _dist} count ([] CALL AllPf) > 0}};
//RANDOM AIR SUPPORT 
if (random 1 < 0.3 && {_size < 1} && {([] CALL FPSGOOD)}) then {
_class = (AIRFIGTHER select 1)+(AIRARMCHOP select 1); 
_class = _class call RETURNRANDOM;	
_tg1 = [[(getposATL vehicle player select 0)+2500,(getposATL vehicle player select 1)+2500,50], 0, _class, EAST] call SPAWNVEHICLE;
_posPl = [(getposATL (vehicle player) select 0) + 100 -(random 200), (getposATL (vehicle player) select 1)+ 100 -(random 200), 0];
_tg1wp1= (_tg1 select 2) addWaypoint [_locationA, 0]; 
[(_tg1 select 2), 1] setWaypointBehaviour "AWARE";
[(_tg1 select 2), 1] setWaypointType "GUARD";
_nul = [(_tg1 select 2), [1541.39,5059.05,0],200] SPAWN FUNKTIO_MAD;
};
//BEGIN ATTACK
if ({getmarkercolor _x == "ColorRed" && {getmarkerpos _x distance (getmarkerpos _mar5) < 5000}} count AAsM == 0) then {
_wpPP = getmarkerpos _mar5;
_mid = [((_start2 select 0)+(_wpPP select 0))*0.5,((_start2 select 1)+(_wpPP select 1))*0.5,0];
[[_mid],"mil_arrow","ColorRed",([_start2, _wpPP] call BIS_fnc_dirTo)] SPAWN SAOKCREATEMARKER;
};
{
if (!isNil{_x getvariable "GMar"}) then {
[_x getvariable "GMar", _locationA] SPAWN ZoneMove;
} else {
_tg1wp1= _x addWaypoint [_locationA, 0]; 
[_x, 1] setWaypointBehaviour "COMBAT";
};
} foreach _VEHgroups;
{
_wp1 = _x addWaypoint [_locationA, 0];
[_x, 1] setWaypointCombatMode "RED";
[_x, 1] setWaypointType "GUARD";
} foreach _INFgroups;


_time = time + 600;
_ran = ["STR_Sp8t2r4","STR_Sp8t2r4a","STR_Sp8t2r4b"] call BIS_fnc_selectRandom;
[[BaseR, localize _ran],"SAOKMULTIGCHAT",nil,false] spawn BIS_fnc_MP;
_ker = (count _ALLunits)*0.2;
waitUntil {sleep 5; {alive _x && {isNil{_x getvariable "SaOkSurrendered"}} && {!(fleeing _x)}} count _ALLunits < _ker || {_time < time}  ||  {getmarkercolor _marrr ==  "ColorRed"}};
if (getmarkercolor _marrr == "ColorRed") then {
//END2
[_VEHgroups,_VEHs,_INFgroups] SPAWN _F1;
//[_marrr,_Tid] SPAWN _FTFail;
[getMarkerPos _marrr,EAST] SPAWN ADDR;
_nul = [_Tid,"FAILED"] call BIS_fnc_taskSetState;
_nul = [_TidE,"SUCCEEDED"] call BIS_fnc_taskSetState;
_marrr setmarkercolor "ColorRed";
_ran = ["STR_Sp8t2r3","STR_Sp8t2r3a","STR_Sp8t2r3b"] call BIS_fnc_selectRandom;
[["Enemy attack succeeded. You lost camp",WEST],"HINTSAOK",nil,false] spawn BIS_fnc_MP;
[[BaseR, localize _ran],"SAOKMULTIGCHAT",nil,false] spawn BIS_fnc_MP;
deletemarker _mar5;
} else {
//END C
[_VEHgroups,_VEHs,_INFgroups] SPAWN _F1;
[getMarkerPos _marrr,WEST] SPAWN ADDR;
_nul = [_Tid,"SUCCEEDED"] call BIS_fnc_taskSetState;
_nul = [_TidE,"FAILED"] call BIS_fnc_taskSetState;
//_nul = [] SPAWN {VarPG = VarPG - 1;sleep 900;VarPG = VarPG + 1;};
_ran = ["STR_Sp8t2r2","STR_Sp8t2r2a","STR_Sp8t2r2b"] call BIS_fnc_selectRandom;
[["Enemy attack didnt succeed",WEST],"HINTSAOK",nil,false] spawn BIS_fnc_MP;
[[BaseR, localize _ran],"SAOKMULTIGCHAT",nil,false] spawn BIS_fnc_MP;
deletemarker _mar5;
};

} else {
//FAR W T
_num = 0.5;

_F = [];
_E = [];
_G = [];
_C = [];
_C = _C + [["I_static_AT_F","n_unknown"],["I_HMG_01_high_F","n_unknown"]];
_size = [0,1,2] call RETURNRANDOM;
for "_i" from 0 to _size do {
_C = _C + ["INFR"];
_Zcol = "ColorRed";
_st = [getmarkerpos _marrr, 400,"(1 - trees) * (1 - sea) * (1 - houses)"] CALL FUNKTIO_POS;
_star = (_st select 0) select 0;
_classs = if (_Zcol == "ColorRed") then {ARMEDVEHICLES select 1} else {ARMEDVEHICLES select 2};
_classs = [_classs call RETURNRANDOM,_classs call RETURNRANDOM];
if (_Zcol == "ColorRed") then {
_n = [_star, _Zcol,_classs] CALL AddVehicleZone;
} else {
_n = [_star, "ColorGreen",_classs,"n_armor"] CALL AddVehicleZone;
};
};
_mP = getmarkerpos _marrr;
{
if (getmarkerpos _x distance _mP < 1700) then {
if (getmarkercolor _x != "ColorRed") then {_F set [count _F,_x];} else {_E set [count _E,_x];};
};
} foreach VEHZONES;
{
if (_x distance _mP < 1700) then {
_G = _G + [_x];
};
} foreach GuardPosts;

{
if (getmarkerpos _x distance _mP < 1700) then {
_C = _C + [_x];
};
} foreach AmbientZonesN;
_ResultColor = [_F,_E,_G,_C,"CAMP BATTLE",_locationA] CALL BattleVirtualCamp;
_marrr setmarkercolor _ResultColor;

if (_ResultColor ==  "ColorRed") then {
//[_marrr,_Tid] SPAWN _FTFail;
_nul = [_Tid,"FAILED"] call BIS_fnc_taskSetState;
_nul = [_TidE,"SUCCEEDED"] call BIS_fnc_taskSetState;
//_marrr setmarkercolor "ColorRed";
_n = [getMarkerPos _marrr,"EAST"] CALL GuardPostSide;
_ran = ["STR_Sp8t2r3","STR_Sp8t2r3a","STR_Sp8t2r3b"] call BIS_fnc_selectRandom;
[[BaseR, localize _ran],"SAOKMULTIGCHAT",nil,false] spawn BIS_fnc_MP;
} else {
//["ScoreAdded",["Enemy attack didnt succeed",10]] call bis_fnc_showNotification;
_nul = [_Tid,"SUCCEEDED"] call BIS_fnc_taskSetState;
_nul = [_TidE,"FAILED"] call BIS_fnc_taskSetState;
//_nul = [] SPAWN {VarPG = VarPG - 1;sleep 900;VarPG = VarPG + 1;};
_ran = ["STR_Sp8t2r2","STR_Sp8t2r2a","STR_Sp8t2r2b"] call BIS_fnc_selectRandom;
[[BaseR, localize _ran],"SAOKMULTIGCHAT",nil,false] spawn BIS_fnc_MP;
};
deletemarker _mar5;
};
};
UndAttackMs = UndAttackMs - [_marrr];

sleep 60;
_n = [_Tid] CALL BIS_fnc_deleteTask;
_n = [_TidE] CALL BIS_fnc_deleteTask;
