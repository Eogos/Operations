private ["_ran","_pos","_dam","_soundSource","_wp"];
_ran = "Sound_Alarm2"; 
_pos = getposATL (_this select 0);
_dam = damage (_this select 0);
(_this select 0) setvariable  ["WithAlarm",true];
waitUntil {sleep 2; _dam < damage (_this select 0) || {{vehicle _x distance _pos < 210} count ([] CALL AllPf) == 0}};
if (count (crew (_this select 0)) == 0 && {{vehicle _x distance (_this select 0) < 210} count ([] CALL AllPf) > 0}) then {
//(nearestBuilding _pos) buildingPos 0
//(_this select 0) say "AlarmCar";

[(_this select 0),"FCarAlarmLights",nil,false] spawn BIS_fnc_MP;

{
if (leader _x distance _pos < 200) then {
while {(count (waypoints _x)) > 0} do {
deleteWaypoint ((waypoints _x) select 0);
};  
_pP = getposATL (_this select 0);
_wp = _x addWaypoint [[(_pP select 0) + 50 - (random 100),(_pP select 1) + 50 - (random 100),0], 0];
};
} foreach  Pgroups + FriendlyInf;

sleep 20;

};
(_this select 0) setvariable  ["WithAlarm",nil];