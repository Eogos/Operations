private ["_time","_wp1","_tg1wp1","_posPl","_class","_random","_unitrate","_tg1","_tank","_header","_Lna","_Tid","_marS","_size","_start2","_st2","_timer","_locationA","_marrr","_uCar","_VarVEH","_ALLunits","_VEHs","_INFgroups","_VEHgroups","_RedGuardPs","_FrGuardPs","_RedCamps","_FrCamps","_tA","_text","_V","_classes","_group","_l","_nul","_n","_ran","_ordercode","_ker","_C","_Zcol","_st","_star","_classs","_F","_E","_G","_num","_mP","_ResultColor","_dist","_data","_mar5","_desc"];

//INIT
_VEHgroups = [];
_INFgroups = [];
_VEHs = [];
_ALLunits = [];
_VarVEH = (ARMEDVEHICLES select 1)+(ARMEDTANKS select 1);
_uCar =[ENEMYC1,ENEMYC2,ENEMYC3] call RETURNRANDOM;
_marrr = (_this select 0);
_locationA = getmarkerpos (_this select 0);
_timer = time + (180 + (random 500));
_dist = 100 + (random 250);
_st2 = [_locationA, 1200,"(1 - forest) * (1 - sea) * (1 - houses)",1] CALL FUNKTIO_POS;
_start2 = (_st2 select 0) select 0;
_size = 1200;
while {{_start2 distance _x < 500} count VarBlackListE > 0 || {{_start2 distance _x < 500} count VarBlackListF > 0} || {{_x distance _start2 < 900} count ([] CALL AllPf) > 0} || {_start2 distance _locationA < 900}} do {
sleep 1;
_st2 = [_locationA, _size,"(1 - forest) * (1 - sea) * (1 - houses)",1] CALL FUNKTIO_POS;
_start2 = (_st2 select 0) select 0;
_size = _size + 50;
};
_marS = format ["LINEmar%1",NUMM];
NUMM=NUMM+1;
_data = ["EXPECTED BATTLE",_locationA,[],["INFI",["I_ATgroup","n_inf"],["I_Snipergroup","n_inf"]]] CALL BattleVirtualIntel;
_ResultColor = _data select 0;
//_mar5 = [_marS,_locationA,"Select",[0.9,0.9],"ColorPink","Defend This Point"] CALL FUNKTIO_CREATEMARKER;
_Tid = format ["TaskBat%1",NUMM];
_TidE = format ["TaskBatE%1",NUMM];
NUMM=NUMM+1;
_Lna = _locationA CALL NEARESTLOCATIONNAME;
_header = format ["Protect Strategic Point near %1",_Lna];
_desc =("Persian are trying to hurt our ways to get resources. Was the area protected enough or should we head there?"+_ResultColor);
[
WEST, // Task owner(s)
_Tid, // Task ID (used when setting task state, destination or description later)
[_desc, _header, _header], // Task description
_locationA, // Task destination
"CREATED" // true to set task as current upon creation
] call BIS_fnc_taskCreate;
_header = format ["Assist to take Strategic Point near %1",_Lna];
_desc =("We are heading to take Strategic Point that NATO is holding. Join us if near."+_ResultColor);
[
EAST, // Task owner(s)
_TidE, // Task ID (used when setting task state, destination or description later)
[_desc, _header, _header], // Task description
_locationA, // Task destination
"CREATED" // true to set task as current upon creation
] call BIS_fnc_taskCreate;
[] SPAWN {sleep 20; "Look for map, where the help is needed. You can fast travel to the AO via Shift+1" SPAWN HINTSAOK;};

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
_text = ("Wolf, our strategic point near "+_Lna+" is about to get pillaged down by some enemy vehicles and infantry");

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
if (_RedCamps > 1 || {_RedGuardPs > 0}) then {_text = _text + ". There is ";};
if (_RedCamps > 1) then {_text = _text + "another ";
if ((_RedCamps-1) != 1) then {_text = _text + (format ["%1",(_RedCamps-1)]);};
_text = _text + " camp";_V = (format ["N%1",(_RedCamps-1)]);if (_V != "N1") then {};};
if (_RedCamps == 2) then {};
if (_RedCamps > 2) then {_text = _text +"s";};
if (_RedCamps > 1 && {_RedGuardPs > 0}) then {_text = _text + " and ";};
if (_RedGuardPs > 0) then {if (_RedGuardPs != 1) then {_text = _text +(format ["%1",_RedGuardPs]);};
_text = _text +" guardpost";_V = (format ["N%1",_RedGuardPs]);if (_V != "N1") then {};};
if (_RedGuardPs == 1) then {};
if (_RedGuardPs > 1) then {_text = _text + "s"; };
if (_RedCamps > 1 || {_RedGuardPs > 0}) then {_text = _text + " with passive hostile activity nearby that could have unknown role";};
_text = _text + ".";
[[BaseR, _text],"SAOKMULTIGCHAT",nil,false] spawn BIS_fnc_MP;
sleep 9;
_text = "";
if ("b_air" in (_data select 2) || {"b_armor" in (_data select 2)} || {"b_uav" in (_data select 2)} || {"n_plane" in (_data select 2)} || {"n_air" in (_data select 2)} || {"n_armor" in (_data select 2)} || {"n_uav" in (_data select 2)}) then {
_text = _text + " We have friendly";
_tA = [];
if ("b_air" in (_data select 2) || {"n_plane" in (_data select 2)} || {"n_air" in (_data select 2)}) then {_tA = _tA + ["air_support"];};
if ("b_armor" in (_data select 2) || {"n_armor" in (_data select 2)}) then {_tA = _tA + ["armor"];};
if ("b_uav" in (_data select 2) || {"n_uav" in (_data select 2)}) then {_tA = _tA + ["UAV"];};
{_text = _text + " "+_x; _tA = _tA - [_x]; if (count _tA == 1) then {_text = _text + " and";}; if (count _tA > 1) then {_text = _text + ",";};} foreach _tA;
_text = _text + " operating near the camp which should heading to protect the point.";
};
if (_FrCamps > 1 || {_FrGuardPs > 0}) then {_text = _text + "Nearby ";} else {_text = _text + " There is no nearby friendly camps or any guardposts covering the point."; };
if (_FrCamps > 1) then {if ((_FrCamps-1) != 1) then {_text = _text + (format ["%1",(_FrCamps-1)]);};
_text = _text + " camp";_V = (format ["N%1",(_FrCamps-1)]);if (_V != "N1") then {};};
if (_FrCamps == 2) then {};
if (_FrCamps > 2) then {_text = _text +"s";};
if (_FrCamps > 1 && {_FrGuardPs > 0}) then {_text = _text + " and ";};
if (_FrGuardPs > 0) then {if (_FrGuardPs != 1) then {_text = _text +(format ["%1",_FrGuardPs]);}; 
 _text = _text + " guardpost";_V = (format ["N%1",_FrGuardPs]);if (_V != "N1") then {};};
if (_FrGuardPs == 1) then {};
if (_FrGuardPs > 1) then {_text = _text + "s"; };
if (_FrCamps > 1 || {_FrGuardPs > 0}) then {_text = _text + " are called to send men join the battle.";};

_text = _text + " But if you are available, any extra help there could keep our resources flowing. Out";
[[BaseR, _text],"SAOKMULTIGCHAT",nil,false] spawn BIS_fnc_MP;
////////////////////////////
waitUntil {sleep 5; ({_x distance _locationA < 1400} count ([] CALL AllPf) > 0) || {_timer < time}};
if ({_x distance _locationA < 1400} count ([] CALL AllPf) > 0) then {
//CLOSE
_size = [0,0,0,0,1,1,1,2] call RETURNRANDOM;
for "_i" from 0 to _size do {
_tank = _VarVEH call RETURNRANDOM;	
_tg1 = [[(_start2 select 0)-30+(random 60),(_start2 select 1)-30+(random 60),0], 0, _tank, EAST] call BIS_fnc_spawnVehicle;
_VEHgroups = _VEHgroups + [(_tg1 select 2)];
_VEHs = _VEHs + [(_tg1 select 0)];
(_tg1 select 0) forcespeed 3;
_unitrate = [4,5];
_random = round(random (_unitrate select 1));
while {_random < (_unitrate select 0)} do {_random = round(random (_unitrate select 1));};
_classes = [];
while {_random > 0} do {_classes set [count _classes,_uCar call RETURNRANDOM];_random = _random - 1;};
_group = [[(_start2 select 0)+40,(_start2 select 1)+30,0], EAST, _classes,[],[],[0.4,0.7]] call SpawnGroupCustom;
_INFgroups = _INFgroups + [_group];
};
{_ALLunits = _ALLunits + (units _x);} foreach _VEHgroups + _INFgroups;
waitUntil {sleep 5; _timer < time || {{vehicle _x distance _locationA < _dist} count ([] CALL AllPf) > 0}};
//AIR SUPPORT
if (random 1 < 0.3 && _size < 1) then {
_class = ["O_Heli_Attack_02_F","O_Heli_Attack_02_black_F","O_Heli_Light_02_F","O_UAV_02_F","O_UAV_02_F"]; 
_class = _class call RETURNRANDOM;	
_l  = getposATL vehicle (([] CALL AllPf) call RETURNRANDOM);
_tg1 = [[(_l select 0)+2500,(_l select 1)+2500,50], 0, _class, EAST] call SPAWNVEHICLE;
_posPl = [(_l select 0) + 100 -(random 200), (_l select 1)+ 100 -(random 200), 0];
_tg1wp1= (_tg1 select 2) addWaypoint [_locationA, 0]; 
[(_tg1 select 2), 1] setWaypointBehaviour "AWARE";
[(_tg1 select 2), 1] setWaypointType "GUARD";
_nul = [(_tg1 select 2), [1541.39,5059.05,0],200] SPAWN FUNKTIO_MAD;
};
//BEGIN ATTACK
{
_tg1wp1= _x addWaypoint [_locationA, 0]; 
[_x, 1] setWaypointBehaviour "COMBAT";
} foreach _VEHgroups;
{
_wp1 = _x addWaypoint [_locationA, 0];
[_x, 1] setWaypointCombatMode "RED";
[_x, 1] setWaypointType "GUARD";
} foreach _INFgroups;
_time = time + 600;
_ran = ["STR_Sp8t4r2"] call BIS_fnc_selectRandom;
[[BaseR, localize _ran],"SAOKMULTIGCHAT",nil,false] spawn BIS_fnc_MP;
_ker = (count _ALLunits)*0.2;
waitUntil {sleep 5; {alive _x && {!(fleeing _x)}} count _ALLunits < _ker || {_time < time}  || {alive _x && {_x distance _locationA < 30}} count _ALLunits >= _ker};
if ({alive _x && {_x distance _locationA < 30}} count _ALLunits >= _ker) then {
//END2
{
VehicleGroups set [count VehicleGroups,_x];
} foreach _VEHgroups;
{
CARS set [count CARS,_x];
_x setvariable ["EndS",1];
} foreach _VEHs;
{
Pgroups set [count Pgroups,_x];
} foreach _INFgroups;
_n = [getMarkerPos _marrr,"EAST"] CALL GuardPostSide;
[getMarkerPos _marrr,EAST] SPAWN ADDR;
_nul = [_Tid,"FAILED"] call BIS_fnc_taskSetState;
_nul = [_TidE,"SUCCEEDED"] call BIS_fnc_taskSetState;
_marrr setmarkercolor "ColorYellow";
if (_marrr in FacMarkers) then {_marrr setMarkerType "u_installation";};

_ran = ["STR_Sp8t4r4"] call BIS_fnc_selectRandom;
[["Enemy attack succeeded. You lost strategic point",WEST],"HINTSAOK",nil,false] spawn BIS_fnc_MP;
[[BaseR, localize _ran],"SAOKMULTIGCHAT",nil,false] spawn BIS_fnc_MP;

//deletemarker _mar5;
} else {
//END C
{
VehicleGroups set [count VehicleGroups,_x];
} foreach _VEHgroups;
{
CARS set [count CARS,_x];
_x setvariable ["EndS",1];
} foreach _VEHs;
{
Pgroups set [count Pgroups,_x];
} foreach _INFgroups;
_marrr setmarkercolor "ColorGreen";
[getMarkerPos _marrr,WEST] SPAWN ADDR;
_nul = [_Tid,"SUCCEEDED"] call BIS_fnc_taskSetState;
_nul = [_TidE,"FAILED"] call BIS_fnc_taskSetState;
//_nul = [] SPAWN {VarPG = VarPG - 1;sleep 900;VarPG = VarPG + 1;};
_ran = ["STR_Sp8t4r3"] call BIS_fnc_selectRandom;
[["Enemy attack didnt succeed",WEST],"HINTSAOK",nil,false] spawn BIS_fnc_MP;
[[BaseR, localize _ran],"SAOKMULTIGCHAT",nil,false] spawn BIS_fnc_MP;
//deletemarker _mar5;
};

} else {
//FAR W T
_time = time + 600;
_ran = ["STR_Sp8t4r2"] call BIS_fnc_selectRandom;
[[BaseR, localize _ran],"SAOKMULTIGCHAT",nil,false] spawn BIS_fnc_MP;
waitUntil {sleep 5; _time < time || {{_x distance _locationA < 1400} count ([] CALL AllPf) > 0}};
if ({_x distance _locationA < 1400} count ([] CALL AllPf) > 0) then {
//CLOSE
_size = [0,0,0,0,1,1,1,2] call RETURNRANDOM;
for "_i" from 0 to _size do {
_tank = _VarVEH call BIS_fnc_selectRandom;	
_tg1 = [[(_start2 select 0)-30+(random 60),(_start2 select 1)-30+(random 60),0], 0, _tank, EAST] call BIS_fnc_spawnVehicle;
_VEHgroups = _VEHgroups + [(_tg1 select 2)];
_VEHs = _VEHs + [(_tg1 select 0)];
(_tg1 select 0) forcespeed 3;
_unitrate = [4,5];
_random = round(random (_unitrate select 1));
while {_random < (_unitrate select 0)} do {_random = round(random (_unitrate select 1));};
_classes = [];
while {_random > 0} do {_classes set [count _classes,_uCar call RETURNRANDOM];_random = _random - 1;};
_group = [[(_start2 select 0)+40,(_start2 select 1)+30,0], EAST, _classes,[],[],[0.4,0.7]] call SpawnGroupCustom;
_INFgroups = _INFgroups + [_group];
};
{_ALLunits = _ALLunits + (units _x);} foreach _VEHgroups + _INFgroups;

//AIR SUPPORT
if (random 1 < 0.3 && _size < 1) then {
_class = ["O_Heli_Attack_02_F","O_Heli_Attack_02_black_F","O_Heli_Light_02_F","O_UAV_02_F","O_UAV_02_F"]; 
_class = _class call RETURNRANDOM;	
_l  = getposATL vehicle (([] CALL AllPf) call RETURNRANDOM);
_tg1 = [[(_l select 0)+2500,(_l select 1)+2500,50], 0, _class, EAST] call SPAWNVEHICLE;
_posPl = [(_l select 0) + 100 -(random 200), (_l select 1)+ 100 -(random 200), 0];
_tg1wp1= (_tg1 select 2) addWaypoint [_locationA, 0]; 
[(_tg1 select 2), 1] setWaypointBehaviour "AWARE";
[(_tg1 select 2), 1] setWaypointType "GUARD";
_nul = [(_tg1 select 2), [1541.39,5059.05,0],200] SPAWN FUNKTIO_MAD;
};
//BEGIN ATTACK
{
_tg1wp1= _x addWaypoint [_locationA, 0]; 
[_x, 1] setWaypointBehaviour "COMBAT";
} foreach _VEHgroups;
{
_wp1 = _x addWaypoint [_locationA, 0];
[_x, 1] setWaypointCombatMode "RED";
[_x, 1] setWaypointType "GUARD";
} foreach _INFgroups;
_ker = (count _ALLunits)*0.2;
waitUntil {sleep 5; {alive _x && {!(fleeing _x)}} count _ALLunits < _ker || {_time < time} || {alive _x && {_x distance _locationA < 30}} count _ALLunits >= _ker};
if ({alive _x && {_x distance _locationA < 30}} count _ALLunits >= _ker) then {
//END2
{
VehicleGroups set [count VehicleGroups,_x];
} foreach _VEHgroups;
{
CARS set [count CARS,_x];
_x setvariable ["EndS",1];
} foreach _VEHs;
{
Pgroups set [count Pgroups,_x];
} foreach _INFgroups;

[getMarkerPos _marrr,EAST] SPAWN ADDR;
_nul = [_Tid,"FAILED"] call BIS_fnc_taskSetState;
_nul = [_TidE,"SUCCEEDED"] call BIS_fnc_taskSetState;
_marrr setmarkercolor "ColorYellow";
if (_marrr in FacMarkers) then {_marrr setMarkerType "u_installation";};
_n = [getMarkerPos _marrr,"EAST"] CALL GuardPostSide;

_ran = ["STR_Sp8t4r4"] call BIS_fnc_selectRandom;
[["Enemy attack succeeded. You lost strategic point",WEST],"HINTSAOK",nil,false] spawn BIS_fnc_MP;
[[BaseR, localize _ran],"SAOKMULTIGCHAT",nil,false] spawn BIS_fnc_MP;

//deletemarker _mar5;
} else {
//END C
{
VehicleGroups set [count VehicleGroups,_x];
} foreach _VEHgroups;
{
CARS set [count CARS,_x];
_x setvariable ["EndS",1];
} foreach _VEHs;
{
Pgroups set [count Pgroups,_x];
} foreach _INFgroups;
_marrr setmarkercolor "ColorGreen";
[getMarkerPos _marrr,WEST] SPAWN ADDR;
_nul = [_Tid,"SUCCEEDED"] call BIS_fnc_taskSetState;
_nul = [_TidE,"FAILED"] call BIS_fnc_taskSetState;
//_nul = [] SPAWN {VarPG = VarPG - 1;sleep 900;VarPG = VarPG + 1;};
_ran = ["STR_Sp8t4r3"] call BIS_fnc_selectRandom;
[["Enemy attack didnt succeed",WEST],"HINTSAOK",nil,false] spawn BIS_fnc_MP;
[[BaseR, localize _ran],"SAOKMULTIGCHAT",nil,false] spawn BIS_fnc_MP;
//deletemarker _mar5;
};

} else {
//FAR W T
_num = 0.5;
_F = [];
_E = [];
_G = [];
_C = [];
_C = _C + ["INFI",["I_ATgroup","n_inf"],["I_Snipergroup","n_inf"]];
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
if (getmarkercolor _x != "ColorRed") then {_F = _F + [_x];} else {_E = _E + [_x];};
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
_ResultColor = [_F,_E,_G,_C,"STRATEGIC POINT BATTLE",_locationA] CALL BattleVirtualCamp;

if (_ResultColor == "ColorRed") then {
//["ScoreRemoved",["Enemy attack succeeded. You lost strategic point",30]] call bis_fnc_showNotification;
_nul = [_Tid,"FAILED"] call BIS_fnc_taskSetState;
_nul = [_TidE,"SUCCEEDED"] call BIS_fnc_taskSetState;
_marrr setmarkercolor "ColorYellow";
if (_marrr in FacMarkers) then {_marrr setMarkerType "u_installation";};
_n = [getMarkerPos _marrr,"EAST"] CALL GuardPostSide;
_ran = ["STR_Sp8t4r4"] call BIS_fnc_selectRandom;
[[BaseR, localize _ran],"SAOKMULTIGCHAT",nil,false] spawn BIS_fnc_MP;
} else {
_marrr setmarkercolor "ColorGreen";
//["ScoreAdded",["Enemy attack didnt succeed",10]] call bis_fnc_showNotification;
_nul = [_Tid,"SUCCEEDED"] call BIS_fnc_taskSetState;
_nul = [_TidE,"FAILED"] call BIS_fnc_taskSetState;
//_nul = [] SPAWN {VarPG = VarPG - 1;sleep 900;VarPG = VarPG + 1;};
_ran = ["STR_Sp8t4r3"] call BIS_fnc_selectRandom;
[[BaseR, localize _ran],"SAOKMULTIGCHAT",nil,false] spawn BIS_fnc_MP;
};
//deletemarker _mar5;
};
};

AMBbattles = AMBbattles - [_marrr];
sleep 60;
_n = [_Tid] CALL BIS_fnc_deleteTask;
_n = [_TidE] CALL BIS_fnc_deleteTask;