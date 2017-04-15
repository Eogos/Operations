private ["_time","_wp1","_tg1wp1","_random","_unitrate","_tg1","_tank","_header","_Lna","_Tid","_marS","_size","_start2","_timer","_locationA","_marrr","_uCar","_VarVEH","_RedGuardPs","_FrGuardPs","_RedCamps","_FrCamps","_tA","_text","_V","_ran","_nul","_n","_classes","_group","_C","_Zcol","_st","_star","_classs","_F","_E","_G","_mP","_ResultColor","_mar5","_mar6","_data","_desc","_startM","_wpPP","_mid","_closestG","_someId","_someId2"];

//INIT
_VarVEH = (ARMEDVEHICLES select 3);
if ("USHelp" in (SaOkmissionnamespace getvariable "Progress")) then {_VarVEH = _VarVEH + (ARMEDVEHICLES select 0);};
if ("GreenHelp" in (SaOkmissionnamespace getvariable "Progress")) then {_VarVEH = _VarVEH + (ARMEDVEHICLES select 2);};
_tank = _VarVEH call BIS_fnc_selectRandom;	
_uCar =[FRIENDC2,FRIENDC3] call RETURNRANDOM;
_marrr = (_this select 0);
_locationA = getmarkerpos (_this select 0);
_closestG = [_locationA,"ColorGreen"] CALL NearestGuardPost;
_closestG setvariable ["ColorG","Blue"];
_timer = time + (180 + (random 500));

_start2 = [_locationA, 800,0,"(1 - sea) * (1 + meadow)",""] CALL SAOKSEEKPOS;
_size = 800;
while {{_start2 distance _x < 500} count VarBlackListE > 0 || {{_start2 distance _x < 500} count VarBlackListF > 0} || {{_x distance _start2 < 500} count ([] CALL AllPf) > 0} || {_start2 distance _locationA < 500}} do {
sleep 1;
_start2 = [_locationA, _size,0,"(1 - sea) * (1 + meadow)",""] CALL SAOKSEEKPOS;
_size = _size + 50;
};

_marS = format ["LINEmar%1",NUMM];
NUMM=NUMM+1;
_mar5 = [_marS,_locationA,"Select",[0.9,0.9],"ColorBlack","Assist to Capture"] CALL FUNKTIO_CREATEMARKER;
_marS = format ["LINEmar%1",NUMM];
NUMM=NUMM+1;

_mar6 = [_marS,_start2,"hd_start",[0.9,0.9],"ColorGreen","Assault Begin Here"] CALL FUNKTIO_CREATEMARKER;

_startM = getmarkerpos _mar6;
_wpPP = getmarkerpos _mar5;
_mid = [((_startM select 0)+(_wpPP select 0))*0.5,((_startM select 1)+(_wpPP select 1))*0.5,0];
[_mid,"mil_arrow","ColorGreen",([_startM, _wpPP] call BIS_fnc_dirTo)] SPAWN SAOKCREATEMARKER;
[["WLA","Battle"]] call BIS_fnc_advHint;
_data = ["EXPECTED BATTLE",_locationA,[1],[["O_static_AT_F","o_unknown",1],["O_HMG_01_high_F","o_unknown",1]]] CALL BattleVirtualIntel;
_ResultColor = _data select 0;
_Tid = format ["TaskBat%1",NUMM];
_Tide = format ["TaskBatE%1",NUMM];
NUMM=NUMM+1;
_Lna = _locationA CALL NEARESTLOCATIONNAME;
_header = format ["Assault to Camp near %1",_Lna];
_desc =("Friendlies are about to attack on persian camp. Should we assists or stay back?"+_ResultColor);
[
WEST, // Task owner(s)
_Tid, // Task ID (used when setting task state, destination or description later)
[_desc, _header, _header], // Task description
_locationA, // Task destination
"CREATED" // true to set task as current upon creation
] call BIS_fnc_taskCreate;
_header = format ["Defend to Camp near %1",_Lna];
_desc =("There is NATO units approaching us, join the party if near."+_ResultColor);
[
EAST, // Task owner(s)
_Tide, // Task ID (used when setting task state, destination or description later)
[_desc, _header, _header], // Task description
_locationA, // Task destination
"CREATED" // true to set task as current upon creation
] call BIS_fnc_taskCreate;

NUMM=NUMM+1;
_locationA set [2,20];
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
_text = ("Wolf, where are preparing an attack to enemy camp near "+_Lna+" using infantry team supported by ");

_text = _text + (getText (configfile >> "CfgVehicles" >> _tank >> "displayName"));
if ("o_air" in (_data select 2) || {"o_armor" in (_data select 2)} || {"o_uav" in (_data select 2)}) then {
_text = _text + ". We have reports of possible recent hostile"; 
_tA = [];
if ("o_air" in (_data select 2)) then {_tA = _tA + ["air_support"];};
if ("o_armor" in (_data select 2)) then {_tA = _tA + ["armor"];};
if ("o_uav" in (_data select 2)) then {_tA = _tA + ["UAV"];};
{_text = _text + " "+_x; _tA = _tA - [_x]; if (count _tA == 1) then {_text = _text + " and";}; if (count _tA > 1) then {_text = _text + ",";};} foreach _tA;
_text = _text + " presence in the AO"; 
};
if (_RedCamps > 1 || {_RedGuardPs > 0}) then {_text = _text + ". There is "; };
if (_RedCamps > 1) then {

if ((_RedCamps-1) != 1) then {_text = _text + (format ["%1",(_RedCamps-1)]);};
_text = _text + " camp";_V = (format ["N%1",(_RedCamps-1)]);if (_V != "N1") then {};};
if (_RedCamps == 2) then {};
if (_RedCamps > 2) then {_text = _text +"s";};
if (_RedCamps > 1 && {_RedGuardPs > 0}) then {_text = _text + " and ";};
if (_RedGuardPs > 0) then {if (_RedGuardPs != 1) then {_text = _text +(format ["%1",_RedGuardPs]);};
_text = _text +" guardpost";_V = (format ["N%1",_RedGuardPs]);if (_V != "N1") then {};};
if (_RedGuardPs == 1) then {};
if (_RedGuardPs > 1) then {_text = _text + "s";};
if (_RedCamps > 1 || {_RedGuardPs > 0}) then {_text = _text + " with hostile activity nearby that could give us trouble if get their attention";};
_text = _text + ". ";
[[BaseR, _text],"SAOKMULTIGCHAT",nil,false] spawn BIS_fnc_MP;
sleep 6;
_text = "";
if ("b_air" in (_data select 2) || {"b_armor" in (_data select 2)} || {"b_uav" in (_data select 2)} || {"n_plane" in (_data select 2)} || {"n_air" in (_data select 2)} || {"n_armor" in (_data select 2)} || {"n_uav" in (_data select 2)}) then {
_text = _text + "There is friendly";
_tA = [];
if ("b_air" in (_data select 2) || {"n_plane" in (_data select 2)} || {"n_air" in (_data select 2)}) then {_tA = _tA + ["air_support"];};
if ("b_armor" in (_data select 2) || {"n_armor" in (_data select 2)}) then {_tA = _tA + ["armor"];};
if ("b_uav" in (_data select 2) || {"n_uav" in (_data select 2)}) then {_tA = _tA + ["UAV"];};
{_text = _text + " "+_x; _tA = _tA - [_x]; if (count _tA == 1) then {_text = _text + " and";}; if (count _tA > 1) then {_text = _text + ",";};} foreach _tA;
_text = _text + " operating near the AO which wont leave us in trouble. ";
};
if (_FrCamps > 1 || {_FrGuardPs > 0}) then {_text = _text + "On our side,";} else {_text = _text + "We have no nearby friendly camps or any guardposts covering our back. ";};
if (_FrCamps > 1) then {if ((_FrCamps-1) != 1) then {_text = _text + (format [" %1",(_FrCamps-1)]);};
_text = _text + " camp";_V = (format ["N%1",(_FrCamps-1)]);if (_V != "N1") then {};};
if (_FrCamps == 2) then {};
if (_FrCamps > 2) then {_text = _text +"s";};
if (_FrCamps > 1 && {_FrGuardPs > 0}) then {_text = _text + " and";};
if (_FrGuardPs > 0) then {if (_FrGuardPs != 1) then {_text = _text +(format [" %1",_FrGuardPs]);}; 
 _text = _text + " guardpost";_V = (format ["N%1",_FrGuardPs]);if (_V != "N1") then {};};
if (_FrGuardPs == 1) then {};
if (_FrGuardPs > 1) then {_text = _text + "s"; };
if (_FrCamps > 1 || {_FrGuardPs > 0}) then {_text = _text + " will cover our behind if something goes wrong. ";};
_text = _text + "If you are unattached, we could always use an extra hand. Out";
[[BaseR, _text],"SAOKMULTIGCHAT",nil,false] spawn BIS_fnc_MP;
////////////////////////////

//FAR OR CLOSE
waitUntil {sleep 5; _timer < time || {{_x distance _locationA < 1400} count ([] CALL AllPf) > 0} || {{_x distance _start2 < 600} count ([] CALL AllPf) > 0}};
if ({_x distance _locationA < 1400} count ([] CALL AllPf) > 0 || {{_x distance _start2 < 600} count ([] CALL AllPf) > 0}) then {
//REAL ATTACK
//_tank = _VarVEH call BIS_fnc_selectRandom;	
_tg1 = [[(_start2 select 0),(_start2 select 1),0], 0, _tank, WEST] call SPAWNVEHICLE;
_unitrate = [4,5];
_random = round(random (_unitrate select 1));
while {_random <  (_unitrate select 0)} do {_random = round(random (_unitrate select 1));};
_classes = [];
while {_random > 0} do {_classes set [count _classes,_uCar call RETURNRANDOM];_random = _random - 1;};
_group = [[(_start2 select 0)+40,(_start2 select 1)+30,0], WEST, _classes,[],[],[0.4,0.7]] call SpawnGroupCustom;
waitUntil {sleep 5; _timer < time || {{_x distance _locationA < 300} count ([] CALL AllPf) > 0} || {{_x distance _start2 < 300} count ([] CALL AllPf) > 0}  || {getmarkercolor _marrr ==  "ColorBlue"}};
_timer = time + 1200;
_tg1wp1= (_tg1 select 2) addWaypoint [_locationA, 0]; 
[(_tg1 select 2), 1] setWaypointBehaviour "COMBAT";
_wp1 = _group addWaypoint [_locationA, 0];
[_group, 1] setWaypointCombatMode "RED";
[_group, 1] setWaypointType "GUARD";

_time = time + 600;
if (getmarkercolor _marrr !=  "ColorBlue") then {
_ran = ["STR_Sp8t3r4","STR_Sp8t3r4a","STR_Sp8t3r4b"] call BIS_fnc_selectRandom;
[[BaseR, localize _ran],"SAOKMULTIGCHAT",nil,false] spawn BIS_fnc_MP;

_startM = getmarkerpos _mar6;
_wpPP = getmarkerpos _mar5;
_mid = [((_startM select 0)+(_wpPP select 0))*0.5,((_startM select 1)+(_wpPP select 1))*0.5,0];
[_mid,"mil_arrow","ColorGreen",([_startM, _wpPP] call BIS_fnc_dirTo)] SPAWN SAOKCREATEMARKER;
};
//LOSS OR END C
waitUntil {sleep 5; _timer < time || {{alive _x && {_x distance _locationA < 20}} count [(leader _group),(leader (_tg1 select 2))] > 1} || {getmarkercolor _marrr ==  "ColorBlue"} || {{alive _x && !(fleeing _x)} count (units _group)  + (units (_tg1 select 2)) < 2}};
if ({alive _x && {!(fleeing _x)}} count (units _group)  + (units (_tg1 select 2)) < 2 || {_timer < time}) then {
//END CONDITION (LOST)
FriendlyVehicles set [count FriendlyVehicles,(_tg1 select 2)];
CARS set [count CARS,(_tg1 select 0)];
(_tg1 select 0) setvariable ["EndS",1];
CantCommand = CantCommand + [(_tg1 select 2)];
FriendlyInf set [count FriendlyInf,_group];
CantCommand = CantCommand + [_group];
_Lna = _locationA CALL NEARESTLOCATIONNAME;
_header = format ["Operation Against CSAT Camp near %1 Failed",_Lna];
[_header, date] CALL SAOKEVENTLOG;
["ScoreRemoved",["Friendly attack didnt succeed.",30]] call bis_fnc_showNotification;
_nul = [_Tid,"FAILED"] call SAOKCOTASK;
_nul = [_TidE,"SUCCEEDED"] call BIS_fnc_taskSetState;
_ran = ["STR_Sp8t3r2","STR_Sp8t3r2a","STR_Sp8t3r2b"] call BIS_fnc_selectRandom;
[["Friendly attack didnt succeed",WEST],"HINTSAOK",nil,false] spawn BIS_fnc_MP;
[[BaseR, localize _ran],"SAOKMULTIGCHAT",nil,false] spawn BIS_fnc_MP;
deletemarker _mar5;
deletemarker _mar6;
} else {
//LOSS (VICTORY)
FriendlyVehicles set [count FriendlyVehicles,(_tg1 select 2)];
(_tg1 select 0) setvariable ["EndS",1];
CARS set [count CARS,(_tg1 select 0)];
CantCommand = CantCommand + [(_tg1 select 2)];
FriendlyInf set [count FriendlyInf,_group];
CantCommand = CantCommand + [_group];
_Lna = _locationA CALL NEARESTLOCATIONNAME;
_header = format ["Bloody Operation Against CSAT Camp near %1 Ended With Green Victory. Locals Celebrating On Streets",_Lna];
[_header, date] CALL SAOKEVENTLOG;
["ScoreAdded",["Friendly attack succeeded. Enemy lost a camp",60]] call bis_fnc_showNotification;
_nul = [_Tid,"SUCCEEDED"] call SAOKCOTASK;
_nul = [_TidE,"FAILED"] call BIS_fnc_taskSetState;
_marrr setmarkercolor "ColorBlue";
_n = [getMarkerPos _marrr,"WEST"] CALL GuardPostSide;
_ran = ["STR_Sp8t3r3","STR_Sp8t3r3a","STR_Sp8t3r3b"] call BIS_fnc_selectRandom;
[["Friendly attack succeeded. Enemy lost a camp",WEST],"HINTSAOK",nil,false] spawn BIS_fnc_MP;
[[BaseR, localize _ran],"SAOKMULTIGCHAT",nil,false] spawn BIS_fnc_MP;
deletemarker _mar5;
deletemarker _mar6;
};
} else {
//FAKE ATTACK
_startM = getmarkerpos _mar6;
_wpPP = getmarkerpos _mar5;
_mid = [((_startM select 0)+(_wpPP select 0))*0.5,((_startM select 1)+(_wpPP select 1))*0.5,0];
[_mid,"mil_arrow","ColorGreen",([_startM, _wpPP] call BIS_fnc_dirTo)] SPAWN SAOKCREATEMARKER;
_time = time + 600;
_ran = ["STR_Sp8t3r4","STR_Sp8t3r4a","STR_Sp8t3r4b"] call BIS_fnc_selectRandom;
[[BaseR, localize _ran],"SAOKMULTIGCHAT",nil,false] spawn BIS_fnc_MP;
waitUntil {sleep 5; ({_x distance _locationA < 1400} count ([] CALL AllPf) > 0)  || {{_x distance _start2 < 600} count ([] CALL AllPf) > 0} || {_time < time} ||  {getmarkercolor _marrr ==  "ColorBlue"}};
if ({_x distance _locationA < 1400} count ([] CALL AllPf)> 0 || {{_x distance _start2 < 600} count ([] CALL AllPf) > 0}) then {
//CLOSE
//_tank = _VarVEH call BIS_fnc_selectRandom;	
_tg1 = [[(_start2 select 0),(_start2 select 1),0], 0, _tank, WEST] call SPAWNVEHICLE;
_unitrate = [4,5];
_random = round(random (_unitrate select 1));
while {_random <  (_unitrate select 0)} do {_random = round(random (_unitrate select 1));};
_classes = [];
while {_random > 0} do {_classes set [count _classes,_uCar call RETURNRANDOM];_random = _random - 1;};
_group = [[(_start2 select 0)+40,(_start2 select 1)+30,0], WEST, _classes,[],[],[0.4,0.7]] call SpawnGroupCustom;
_tg1wp1= (_tg1 select 2) addWaypoint [_locationA, 0]; 
[(_tg1 select 2), 1] setWaypointBehaviour "COMBAT";
_wp1 = _group addWaypoint [_locationA, 0];
[_group, 1] setWaypointCombatMode "RED";
[_group, 1] setWaypointType "GUARD";

_time = time + 1200;
//LOSS OR END C
waitUntil {sleep 5; ({alive _x && {_x distance _locationA < 20}} count [(leader _group),(leader (_tg1 select 2))] > 1 ||  {getmarkercolor _marrr ==  "ColorBlue"}) || {{alive _x && {!(fleeing _x)}} count (units _group)  + (units (_tg1 select 2)) < 2} || {_time < time}};
if ({alive _x && {!(fleeing _x)}} count (units _group)  + (units (_tg1 select 2)) < 2 || {_time < time}) then {
//END CONDITION (LOST)
FriendlyVehicles set [count FriendlyVehicles,(_tg1 select 2)];
CARS set [count CARS,(_tg1 select 0)];
(_tg1 select 0) setvariable ["EndS",1];
CantCommand = CantCommand + [(_tg1 select 2)];
FriendlyInf set [count FriendlyInf,_group];
CantCommand = CantCommand + [_group];
_nul = [_Tid,"FAILED"] call BIS_fnc_taskSetState;
_nul = [_TidE,"SUCCEEDED"] call BIS_fnc_taskSetState;
[getMarkerPos _marrr,EAST] SPAWN ADDR;
_ran = ["STR_Sp8t3r2","STR_Sp8t3r2a","STR_Sp8t3r2b"] call BIS_fnc_selectRandom;
[["Friendly attack didnt succeed.",WEST],"HINTSAOK",nil,false] spawn BIS_fnc_MP;
[[BaseR, localize _ran],"SAOKMULTIGCHAT",nil,false] spawn BIS_fnc_MP;
deletemarker _mar5;
deletemarker _mar6;
} else {
//LOSS (VICTORY)
FriendlyVehicles set [count FriendlyVehicles,(_tg1 select 2)];
CARS set [count CARS,(_tg1 select 0)];
(_tg1 select 0) setvariable ["EndS",1];
CantCommand = CantCommand + [(_tg1 select 2)];
FriendlyInf set [count FriendlyInf,_group];
CantCommand = CantCommand + [_group];
_n = [getMarkerPos _marrr,"WEST"] CALL GuardPostSide;
_nul = [_Tid,"SUCCEEDED"] call BIS_fnc_taskSetState;
[getMarkerPos _marrr,WEST] SPAWN ADDR;
_nul = [_TidE,"FAILED"] call BIS_fnc_taskSetState;
_marrr setmarkercolor "ColorBlue";
_ran = ["STR_Sp8t3r3","STR_Sp8t3r3a","STR_Sp8t3r3b"] call BIS_fnc_selectRandom;
[["Friendly attack succeeded. Enemy lost a camp",WEST],"HINTSAOK",nil,false] spawn BIS_fnc_MP;
[[BaseR, localize _ran],"SAOKMULTIGCHAT",nil,false] spawn BIS_fnc_MP;
deletemarker _mar5;
deletemarker _mar6;
};

} else {
//FAR WHOLE TIME 
_F = [];
_E = [];
_G = [];
_C = [];
_C = _C + [["O_static_AT_F","o_unknown",1],["O_HMG_01_high_F","o_unknown",1]];
_size = [0,1,2] call RETURNRANDOM;
for "_i" from 0 to _size do {
_C = _C + ["INFI"];
_Zcol = "ColorGreen";
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
_ResultColor = [_F,_E,_G,_C,"CAMP BATTLE",_mP] CALL BattleVirtualCamp;
_marrr setmarkercolor _ResultColor;
if (_ResultColor ==  "ColorBlue") then {
_Lna = _locationA CALL NEARESTLOCATIONNAME;
_header = format ["Bloody Operation Against CSAT Camp near %1 Ended With Green Victory. Locals Celebrating On Streets",_Lna];
[_header, date] CALL SAOKEVENTLOG;
//["ScoreAdded",["Friendly attack succeeded. Enemy lost a camp",60]] call bis_fnc_showNotification;
_nul = [_Tid,"SUCCEEDED"] call BIS_fnc_taskSetState;
_nul = [_TidE,"FAILED"] call BIS_fnc_taskSetState;
_marrr setmarkercolor "ColorBlue";
_n = [getMarkerPos _marrr,"WEST"] CALL GuardPostSide;
//_nul = [] SPAWN {VarPG = VarPG + 1;sleep 900;VarPG = VarPG - 1;};
_ran = ["STR_Sp8t3r3","STR_Sp8t3r3a","STR_Sp8t3r3b"] call BIS_fnc_selectRandom;
[[BaseR, localize _ran],"SAOKMULTIGCHAT",nil,false] spawn BIS_fnc_MP;
} else {
_Lna = _locationA CALL NEARESTLOCATIONNAME;
_header = format ["Operation Against CSAT Camp near %1 Failed",_Lna];
[_header, date] CALL SAOKEVENTLOG;
//["ScoreRemoved",["Friendly attack didnt succeed.",30]] call bis_fnc_showNotification;
_nul = [_Tid,"FAILED"] call BIS_fnc_taskSetState;
_nul = [_Tid,"SUCCEEDED"] call BIS_fnc_taskSetState;
//_nul = [] SPAWN {VarPG = VarPG - 1;sleep 900;VarPG = VarPG + 1;};
_ran = ["STR_Sp8t3r2","STR_Sp8t3r2a","STR_Sp8t3r2b"] call BIS_fnc_selectRandom;
[[BaseR, localize _ran],"SAOKMULTIGCHAT",nil,false] spawn BIS_fnc_MP;
};
deletemarker _mar5;
deletemarker _mar6;
};
};
_closestG setvariable ["ColorG",nil];
AMBbattles = AMBbattles - [_marrr];
sleep 60;
_n = [_Tid] CALL BIS_fnc_deleteTask;
_n = [_TidE] CALL BIS_fnc_deleteTask;
