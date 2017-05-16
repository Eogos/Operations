private ["_nearest","_units","_state","_pos","_group","_state2","_c","_classT","_classes","_nul","_array","_waypoints","_building","_houses","_wp1","_apu1","_apu2"];

while {true} do {
_nearest = [] CALL NEARESTVILLAGE; 
_units = [];

_state = missionNamespace getvariable (_nearest + "A");
_state2 = missionNamespace getvariable (_nearest + "B");
if (isNil"_state") then {_state = "";};
if (isNil"_state2") then {_state2 = "";};
_pos = getmarkerpos _nearest;
//ANGRY CIVS
if (!isNil{missionNamespace getvariable (_nearest + "A")}) then {
if ((missionNamespace getvariable (_nearest + "A") == "Hostile")) then {
_classT = [ENEMYC1,ENEMYC2] call RETURNRANDOM;
_classes = [_classT call RETURNRANDOM,_classT call RETURNRANDOM,_classT call RETURNRANDOM];
_group = [ [(_pos select 0) + 50 - (random 100),(_pos select 1) + 50 - (random 100),0], EAST, _classes,[],[],[0.6,0.9]] call SpawnGroupCustom;
{_units set [count _units,_x];} foreach units _group;
_nul = [units _group,nearestObjects [leader _group, ["FirePlace_burning_F","Land_FirePlace_F"], 100], [getposATL leader _group,100],[]] SPAWN AICampBehaviour;
{_c = [_x] SPAWN ConvertToArmedCivilianL;} foreach units _group;
};
if ((missionNamespace getvariable (_nearest + "A") == "Friendly")) then {
//_classT = + FRIENDC4;
_classes = [FRIENDC4 call RETURNRANDOM,FRIENDC4 call RETURNRANDOM];
_group = [ [(_pos select 0) + 50 - (random 100),(_pos select 1) + 50 - (random 100),0], WEST, _classes,[],[],[0.6,0.9]] call SpawnGroupCustom;
{_units set [count _units,_x];} foreach units _group;
_nul = [units _group,nearestObjects [leader _group, ["FirePlace_burning_F","Land_FirePlace_F"], 100], [getposATL leader _group,100],[]] SPAWN AICampBehaviour;
//{_c = [_x] SPAWN ConvertToArmedCivilianL;} foreach units _group;


};
};
//SPECIAL
if (!isNil{missionNamespace getvariable (_nearest + "B")} && {!isNil{missionNamespace getvariable (_nearest + "A")}}) then {
//MEDIC
if ((missionNamespace getvariable (_nearest + "B") == "Medical") && {missionNamespace getvariable (_nearest + "A") == "Friendly"}) then {
_group = [ [(_pos select 0) + 50 - (random 100),(_pos select 1) + 50 - (random 100),0], WEST, ["I_G_medic_F"],[],[],[0.6,0.9]] call SpawnGroupCustom;
{_units set [count _units,_x];} foreach units _group;
_houses =  [getposATL leader _group,100];
if (count _this > 4 && count _houses > 0) then {
{
_waypoints = [];
_c = 0;
_building = _houses call RETURNRANDOM;
_array = _building buildingPos _c;
while {str(_array) != "[0,0,0]"} do {	
_waypoints set [count _waypoints,_c];
_c = _c + 1;
_array = _building buildingPos _c;
};
if (count _waypoints > 0) then {
_pos = _building buildingPos (_waypoints call RETURNRANDOM);
_x setpos _pos;
};
} foreach units _group;
};
{_c = [_x] SPAWN ConvertToArmedCivilianL;} foreach units _group;
_wp1= _group addWaypoint [getposATL leader _group, 0]; 
[_group, 1] setWaypointType "SUPPORT";
};

//MG
if ((missionNamespace getvariable (_nearest + "B") == "MachineGunners") && {missionNamespace getvariable (_nearest + "A") == "Friendly"}) then {
_group = [ [(_pos select 0) + 50 - (random 100),(_pos select 1) + 50 - (random 100),0], WEST, ["I_G_Soldier_AR_F"],[],[],[0.6,0.9]] call SpawnGroupCustom;
{_units set [count _units,_x];} foreach units _group;
{_c = [_x] SPAWN ConvertToArmedCivilian;} foreach units _group;
_nul = [units _group,nearestObjects [leader _group, ["FirePlace_burning_F","Land_FirePlace_F"], 100], [getposATL leader _group,100],[]] SPAWN AICampBehaviour;
};

//AA
if ((missionNamespace getvariable (_nearest + "B") == "AntiAir") && {missionNamespace getvariable (_nearest + "A") == "Friendly"}) then {
_group = [ [(_pos select 0) + 50 - (random 100),(_pos select 1) + 50 - (random 100),0], WEST, ["I_Soldier_AA_F"],[],[],[0.6,0.9]] call SpawnGroupCustom;
{_units set [count _units,_x];} foreach units _group;
{_c = [_x] SPAWN ConvertToArmedCivilian;} foreach units _group;
_nul = [units _group,nearestObjects [leader _group, ["FirePlace_burning_F","Land_FirePlace_F"], 100], [getposATL leader _group,100],[]] SPAWN AICampBehaviour;
};

//AT
if ((missionNamespace getvariable (_nearest + "B") == "AntiTank") && {missionNamespace getvariable (_nearest + "A") == "Friendly"}) then {
_group = [ [(_pos select 0) + 50 - (random 100),(_pos select 1) + 50 - (random 100),0], WEST, ["I_G_Soldier_LAT_F"],[],[],[0.6,0.9]] call SpawnGroupCustom;
{_units set [count _units,_x];} foreach units _group;
{_c = [_x] SPAWN ConvertToArmedCivilian;} foreach units _group;
_nul = [units _group,nearestObjects [leader _group, ["FirePlace_burning_F","Land_FirePlace_F"], 100], [getposATL leader _group,100],[]] SPAWN AICampBehaviour;
};

};
_apu1 = "";
_apu2 = "";
if (!isNil{missionNamespace getvariable (_nearest + "A")}) then {_apu1 = (missionNamespace getvariable (_nearest + "A"));};
if (!isNil{missionNamespace getvariable (_nearest + "B")}) then {_apu2 = (missionNamespace getvariable (_nearest + "B"));};
while {_nearest == [] CALL NEARESTVILLAGE && {_state == _apu1} && {_state2 == _apu2}} do {
if (!isNil{missionNamespace getvariable (_nearest + "A")}) then {_apu1 = (missionNamespace getvariable (_nearest + "A"));};
if (!isNil{missionNamespace getvariable (_nearest + "B")}) then {_apu2 = (missionNamespace getvariable (_nearest + "B"));};
sleep 7;
};

{
[_x] SPAWN {
private ["_unit"];
_unit = _this select 0;
waituntil {sleep 3; {vehicle _x distance _unit < 600} count ([WEST] CALL AllPf) == 0};
deletevehicle _unit;
};
} foreach _units;
sleep 2;
};