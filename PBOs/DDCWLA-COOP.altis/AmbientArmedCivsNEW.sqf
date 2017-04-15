private ["_nearest","_s","_MainF"];

_MainF = {
private ["_c","_classT","_classes","_group","_nul","_nA","_wp1","_nB","_apu1","_apu2","_f","_nearest","_units","_state","_state2","_pos"];
_f = {
private ["_bLar","_xx","_u","_c","_array","_pos","_group","_pO","_sHou","_building","_waypoints"];
_bLar = ["Land_Bridge_Asphalt_PathLod_F","Land_Bridge_Concrete_PathLod_F","Land_Bridge_HighWay_PathLod_F","Land_Pier_F","Land_nav_pier_m_F","Land_Cargo_HQ_V1_F","Land_Cargo_Patrol_V2_F","Land_Cargo_House_V1_F"];
_group = _this;
_u = units _group;
_c = count _u - 1;
for "_i" from 0 to _c do {
_xx = _u select _i;
_group = group _xx;
_pO = getposATL leader _group;
_sHou = [(_pO select 0)+ 100 - (random 200), (_pO select 1)+ 100 - (random 200), 0];
_building = nearestBuilding _sHou;
_waypoints = [];
_c = 0;
_array = _building buildingPos _c;
if !(typeof _building in _bLar) then {
while {!(_array isEqualTo [0,0,0]) && {_c < 20}} do {	
sleep 0.1;
_waypoints pushBack _c;
_c = _c + 1;
_array = _building buildingPos _c;
};
};
sleep 0.1;
if (count _waypoints > 0) then {
_pos = _building buildingPos (_waypoints call RETURNRANDOM);
_xx setpos _pos;
};
sleep 0.1;
};
};
_nearest = _this select 0;
_ranP = _this select 1;
_units = [];
_state = (_nearest + "A") CALL SAOKVILRET;
_state2 = (_nearest + "B") CALL SAOKVILRET;
_pos = getmarkerpos _nearest;
//ANGRY CIVS
if ((_nearest + "A") CALL SAOKVILCON) then {
_nA = (_nearest + "A") CALL SAOKVILRET;
if ((_nA == "Hostile")) then {
_classT = [ENEMYC1,ENEMYC2] call RETURNRANDOM;
_classes = [_classT call RETURNRANDOM,_classT call RETURNRANDOM,_classT call RETURNRANDOM];
_group = [ [(_pos select 0) + 50 - (random 100),(_pos select 1) + 50 - (random 100),0], EAST, _classes,[],[],[0.3,0.4]] call SpawnGroupCustom;
_units = _units + (units _group);
_nul = [units _group] SPAWN AICampBehaviour;
{_c = [_x] SPAWN ConvertToArmedCivilianL;sleep 0.1;} foreach units _group;
_group SPAWN _f;
};
if ((_nA == "Friendly")) then {
//_classT = + FRIENDC4;
_classes = [FRIENDC4 call RETURNRANDOM,FRIENDC4 call RETURNRANDOM];
_group = [ [(_pos select 0) + 50 - (random 100),(_pos select 1) + 50 - (random 100),0], WEST, _classes,[],[],[0.6,0.9]] call SpawnGroupCustom;
CantCommand pushBack  _group;
_units = _units + (units _group);
_nul = [units _group] SPAWN AICampBehaviour;
//{_c = [_x] SPAWN ConvertToArmedCivilianL;} foreach units _group;
_group SPAWN _f;

};
};
//SPECIAL
if ((_nearest + "B") CALL SAOKVILCON && {(_nearest + "A") CALL SAOKVILCON}) then {
//MEDIC
_nB = (_nearest + "B") CALL SAOKVILRET;
if ((_nB == "Medical") && {_nA == "Friendly"}) then {
_c = "I_G_medic_F";
if (!isNil"IFENABLED") then {_c = "LIB_GER_medic";};
_group = [ [(_pos select 0) + 50 - (random 100),(_pos select 1) + 50 - (random 100),0], WEST, [_c],[],[],[0.6,0.9]] call SpawnGroupCustom;
_units = _units + (units _group);
_group SPAWN _f;

//_houses =  [getposATL leader _group,100];"LIB_wp_medic"



{_c = [_x] SPAWN ConvertToArmedCivilianL;sleep 0.1;} foreach units _group;
_wp1= _group addWaypoint [getposATL leader _group, 0]; 
[_group, 1] setWaypointType "SUPPORT";
};

//MG
if ((_nB == "MachineGunners") && {_nA == "Friendly"}) then {
_c = "I_G_Soldier_AR_F";
if (!isNil"IFENABLED") then {_c = "LIB_GER_mgunner";};
_group = [ [(_pos select 0) + 50 - (random 100),(_pos select 1) + 50 - (random 100),0], WEST, [_c],[],[],[0.6,0.9]] call SpawnGroupCustom;
_units = _units + (units _group);
{_c = [_x] SPAWN ConvertToArmedCivilian;sleep 0.1;} foreach units _group;
_nul = [units _group] SPAWN AICampBehaviour;
_group SPAWN _f;
};

//AA
if ((_nB == "AntiAir") && {_nA == "Friendly"}) then {
_c = "I_Soldier_AA_F";
if (!isNil"IFENABLED") then {_c = "LIB_GER_mgunner";};
_group = [ [(_pos select 0) + 50 - (random 100),(_pos select 1) + 50 - (random 100),0], WEST, [_c],[],[],[0.6,0.9]] call SpawnGroupCustom;
_units = _units + (units _group);
{_c = [_x] SPAWN ConvertToArmedCivilian;sleep 0.1;} foreach units _group;
_nul = [units _group] SPAWN AICampBehaviour;
_group SPAWN _f;
};

//AT
if ((_nB == "AntiTank") && {_nA == "Friendly"}) then {
_c = "I_G_Soldier_LAT_F";
if (!isNil"IFENABLED") then {_c = "LIB_GER_AT_grenadier";};
_group = [ [(_pos select 0) + 50 - (random 100),(_pos select 1) + 50 - (random 100),0], WEST, [_c],[],[],[0.6,0.9]] call SpawnGroupCustom;
_units = _units + (units _group);
{_c = [_x] SPAWN ConvertToArmedCivilian;sleep 0.1;} foreach units _group;
_nul = [units _group] SPAWN AICampBehaviour;
_group SPAWN _f;
};

};
_apu1 = "";
_apu2 = "";
if ((_nearest + "A") CALL SAOKVILCON) then {_apu1 = (_nearest + "A") CALL SAOKVILRET;};
if ((_nearest + "B") CALL SAOKVILCON) then {_apu2 = (_nearest + "B") CALL SAOKVILRET;};
while {_nearest == [_ranP] CALL NEARESTVILLAGE && {_state == _apu1} && {_state2 == _apu2}} do {
if ((_nearest + "A") CALL SAOKVILCON) then {_apu1 = (_nearest + "A") CALL SAOKVILRET;};
if ((_nearest + "B") CALL SAOKVILCON) then {_apu2 = (_nearest + "B") CALL SAOKVILRET;};
sleep 7;
};

{
[_x] SPAWN SAOKSHF4;
sleep 0.1;
} foreach _units;
};

while {true} do {
_ranP = ([] CALL AllPf) call RETURNRANDOM;
_nearest = [_ranP] CALL NEARESTVILLAGE; 
_s = [_nearest,_ranP] SPAWN _MainF;
waitUntil {sleep 5; scriptdone _s};
};