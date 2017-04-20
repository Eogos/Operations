
CurTaskS = CurTaskS + ["MainTasks\Resistance1.sqf"];
private ["_l","_start","_random","_ranAir","_st","_obj","_obj2","_nul","_cur","_ordercode","_di","_classes","_ran","_tank","_class","_pPosi","_tg1","_posPl","_tg1wp1"];
_ranAir = AIRFIELDLOCATIONS call RETURNRANDOM;	
[
WEST, // Task owner(s)
"task3", // Task ID (used when setting task state, destination or description later)
["Greek army will not be able to re-enter the Altis until you have cleared this marked airfield. We need to find and disable two enemy anti-air vehicles and deal with possible reinforcements. Creating guardpost, or two with AT-launchers, to cut nearby roads could be good thing to do", "Secure Pointed Airfield", "Secure Pointed Airfield"], // Task description
getmarkerpos _ranAir, // Task destination
true // true to set task as current upon creation
] call BIS_fnc_taskCreate;

sleep 1;
_st = [getmarkerpos _ranAir, 500,"(1 - trees) *(1 - houses) * (1 - sea)"] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
sleep 1;
_obj = [_start,1,"O_APC_Tracked_02_AA_F",EAST] call SPAWNVEHICLE;
DONTDELGROUPS = DONTDELGROUPS + [(_obj select 2)];
sleep 1;
_st = [getmarkerpos _ranAir, 500,"(1 - trees) *(1 - houses) * (1 - sea)"] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
sleep 1;
_obj2= [_start,1,"O_APC_Tracked_02_AA_F",EAST] call SPAWNVEHICLE;
DONTDELGROUPS = DONTDELGROUPS + [(_obj2 select 2)];

waitUntil {sleep 3; {alive _x} count (crew (_obj select 0))+(crew (_obj2 select 0)) == 0 || {{alive _x} count [(_obj select 0),(_obj2 select 0)] == 0}};
_n = [side player,400] SPAWN PrestigeUpdate;
[[400, "From Task",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;

DONTDELGROUPS = DONTDELGROUPS - [(_obj select 2)];
_nul = ["task3","SUCCEEDED"] call BIS_fnc_taskSetState;
[getmarkerpos _ranAir,side player] SPAWN ADDR;
_cur = (SaOkmissionnamespace getvariable "Progress");
SaOkmissionnamespace setvariable ["Progress",_cur + ["GreenHelp"],true];
[[4],"MusicT",nil,false] spawn BIS_fnc_MP;
[["Greek army support also available now in the support menu. Dont forget that you can get choppers and planes to fly by visiting purchase menu near any airfield",WEST],"HINTSAOK",nil,false] spawn BIS_fnc_MP;
CurTaskS = CurTaskS - ["MainTasks\Resistance1.sqf"];
_n = ["GREEN"] SPAWN SAOKSPAWNBIGCAMP;
sleep 3;
waitUntil {sleep 5; count ([WEST] CALL AllPf) > 0};
_l = getposATL (([WEST] CALL AllPf) call RETURNRANDOM);
_start = [(_l select 0) + 1700 - (random 3400),(_l select 1) + 1700 - (random 3400),50];
while  {{_start distance vehicle _x < 1500} count ([] CALL AllPf) > 0} do {
sleep 1;
waitUntil {sleep 5; count ([WEST] CALL AllPf) > 0};
_l = getposATL (([WEST] CALL AllPf) call RETURNRANDOM);
_start = [(_l select 0) + 1700 - (random 3400),(_l select 1) + 1700 - (random 3400),50];
};
_di= [_start, _l] call BIS_fnc_dirTo;
_random = 3 + floor (random 3);
_classes = [];
_ran = [FRIENDC2] call RETURNRANDOM;
while {_random > 0} do {_classes set [count _classes,_ran select (floor(random (count _ran)))];_random = _random - 1;};
_tank = ["I_Heli_Transport_02_F"]; 
_tank = _tank call RETURNRANDOM;	
_nul = [_start, getmarkerpos _ranAir, getmarkerpos _ranAir, WEST, _di, _tank, 50,_classes,[0.6,0.7],0,1] execVM "ChopperTransportF.sqf";

FRIENDC2 = ["I_Soldier_AAR_F","I_Soldier_AAA_F","I_Soldier_AAT_F","I_Soldier_A_F","I_Soldier_AR_F","I_medic_F","I_engineer_F","I_Soldier_exp_F","I_Soldier_GL_F","I_Soldier_M_F","I_Soldier_AA_F","I_Soldier_AT_F","I_officer_F","I_Soldier_repair_F","I_soldier_F","I_Soldier_LAT_F","I_Soldier_lite_F","I_Soldier_SL_F","I_Soldier_TL_F","I_Spotter_F","I_Sniper_F"];

sleep 10;
waitUntil {sleep 5; count ([WEST] CALL AllPf) > 0};
_l = getposATL (([WEST] CALL AllPf)call RETURNRANDOM);
_start = [(_l select 0) + 1700 - (random 3400),(_l select 1) + 1700 - (random 3400),100];
while  {{_start distance vehicle _x < 1500} count ([] CALL AllPf) > 0} do {
sleep 1;
_l = getposATL (([WEST] CALL AllPf)call RETURNRANDOM);
_start = [(_l select 0) + 1700 - (random 3400),(_l select 1) + 1700 - (random 3400),100];
};
_class = ["I_Plane_Fighter_03_CAS_F"];
_pPosi = getmarkerpos _ranAir;
_class = _class call RETURNRANDOM;	
_tg1 = [_start, _di, _class, WEST] call SPAWNVEHICLE;
_posPl = [(_pPosi select 0) + (random 200)-(random 200), (_pPosi select 1)+ (random 200)-(random 200), 0];
_tg1wp1= (_tg1 select 2) addWaypoint [_posPl, 0]; 
[(_tg1 select 2), 1] setWaypointBehaviour "AWARE";
[(_tg1 select 2), 1] setWaypointType "GUARD";
_nul = [(_tg1 select 2), [10048.6,25343.7,0],500] SPAWN FUNKTIO_MAD;

sleep 20;
[] SPAWN TASK_GreenZonesArrive;
sleep 120;
[] SPAWN TASK_GreenAirZonesArrive;