private ["_y","_nul","_current","_xx","_yy","_start","_r","_forEachIndex"];
_notDel = [];
if (!isNil"BIS_SUPP_HQ_WEST") then {_notDel = [BIS_SUPP_HQ_WEST];};
if (!isNil"BIS_SUPP_HQ_RESISTANCE") then {_notDel set [count _notDel, BIS_SUPP_HQ_RESISTANCE];};
if (!isNil"bis_hc_mainscope") then {_notDel set [count _notDel, bis_hc_mainscope];};
_lva = + (AllUnits - _notDel);
_c = count _lva - 1;
for "_i" from 0 to _c do {
private ["_xx"];
_xx = _lva select _i;
if !(_xx CALL SAOKBISCHECK) then {
//Is on water
_posATL = (getposATL _xx);
if (surfaceIsWater _posATL && {_posATL select 2 < 2} && {!(typeof _xx in ["O_diver_TL_F","O_diver_F","O_diver_exp_F"])} && {_xx == vehicle _xx} && {!isPlayer (leader group _xx)}) then {
if (isNil{_xx getvariable "OnSea"}) then {
	_xx setvariable ["OnSea",1];
	} else {
	if (_xx getvariable "OnSea" > 3) then {deletevehicle _xx;} else {_xx setvariable ["OnSea",(_xx getvariable "OnSea")+ 1];};
	};
};
};
sleep 0.1;
};
_c = count _lva - 1;
for "_i" from 0 to _c do {
private ["_xx"];
_xx = _lva select _i;
if !(_xx CALL SAOKBISCHECK) then {
_posATL = (getposATL _xx);
if (_posATL distance [0,0,0] < 250 && {!isPlayer _xx}) then {
deletevehicle _xx;
};
};
sleep 0.1;
};
sleep 0.5;
_lva = + vehicles;
_c = count _lva - 1;
for "_i" from 0 to _c do {
private ["_xx"];
_xx = _lva select _i;
if !(_xx CALL SAOKBISCHECK) then {
if ({_xx distance vehicle _x < 300} count ([] CALL AllPf) == 0 && {{alive _x} count crew _xx == 0}) then {
if (isNil{_xx getvariable "AmCrate"}) then {
CARS set [count CARS,_xx];
};
};
};
sleep 0.1;
};
sleep 0.5;
{
if !(_x in DONTDELGROUPS) then {
_y = _x;
if (count units _x == 0) then {deleteGroup _x;} else {
	if ({(vehicle leader _y) distance vehicle _x < 1400} count ([] CALL AllPf) == 0) then {
		_current = if (!isNil{_x getVariable "TooFar"}) then {_x getVariable "TooFar"} else {0};
		_current = _current + 1;
		if ((_current < 8 || {(_current < 25 && {(getposATL (vehicle leader _x) select 2) > 15})})) then {_x setvariable ["TooFar",_current];} 
			else {
			if (vehicle leader _x != leader _x) then {deletevehicle (vehicle leader _x);};
			{_nul = [_x] SPAWN FUNKTIO_DELUNIT;} foreach units _x;
			};
	 
	};
};
};
sleep 0.01;
} forEach allGroups - DONTDELGROUPS;


{
_x SPAWN {
sleep (random 1);
private ["_y"];
_y = _this;
if (isNil"_y") exitWith {};
if (!isNil{_y getVariable "ReInf"} && {{leader _y distance vehicle _y < 2000} count ([] CALL AllPf) == 0} && {vehicle leader _y == leader _y}) then {
_xx = random (1100);
_yy = 1100 - _xx;
if (random 1 < 0.5) then {_xx = _xx*(-1)};
_yy = _yy*(-1);
_r = ([] CALL AllPf) call RETURNRANDOM;
_start = [(getposATL vehicle _r select 0) + _xx,(getposATL vehicle _r select 1) + _yy,0];
while  {surfaceIsWater _start || {{_start distance _y < 500} count VarBlackListF > 0}} do {
sleep 1;
_xx = random (1100);
_yy = 1100 - _xx;
if (random 1 < 0.5) then {_xx = _xx*(-1)};
_yy = _yy*(-1);
_r = ([] CALL AllPf) call RETURNRANDOM;
_start = [(getposATL vehicle _r select 0) + _xx,(getposATL vehicle _r select 1) + _yy,0];
};
{
_x setpos _start;
} foreach units _y;
};
};
sleep 0.1;
} foreach DONTDELGROUPS;

if (!isNil"BIS_fnc_getRespawnPositions_listWEST") then {
_c = count BIS_fnc_getRespawnPositions_listWEST;
{if (isNil"_x" || {(typename _x == "OBJECT" && {isNull _x})} || {(typename _x == "STRING" && {_x == ""})}) then {BIS_fnc_getRespawnPositions_listWEST = [BIS_fnc_getRespawnPositions_listWEST,_forEachIndex] call BIS_fnc_removeIndex;};} foreach BIS_fnc_getRespawnPositions_listWEST;
if (_c != count BIS_fnc_getRespawnPositions_listWEST) then {publicvariable "BIS_fnc_getRespawnPositions_listWEST";};
};
if (!isNil"BIS_fnc_getRespawnPositions_listEAST") then {
_c = count BIS_fnc_getRespawnPositions_listEAST;
{if (isNil"_x" || {(typename _x == "OBJECT" && {isNull _x})} || {(typename _x == "STRING" && {_x == ""})}) then {BIS_fnc_getRespawnPositions_listEAST = [BIS_fnc_getRespawnPositions_listEAST,_forEachIndex] call BIS_fnc_removeIndex;};} foreach BIS_fnc_getRespawnPositions_listEAST;
if (_c != count BIS_fnc_getRespawnPositions_listEAST) then {publicvariable "BIS_fnc_getRespawnPositions_listEAST";};
};
if (isNil"CLEANNUM") then {CLEANNUM = 0;};
if (CLEANNUM == 0) then {
{if (isNil"_x") exitWith {DONTDELGROUPS = [DONTDELGROUPS,_forEachIndex] call BIS_fnc_removeIndex;};sleep 0.01;} foreach DONTDELGROUPS; 
{if (isNull _x) then {CARS  = CARS - [_x];};sleep 0.01;} foreach CARS;
sleep 0.5;
{if (isNil"_x") exitWith {CARS = [CARS,_forEachIndex] call BIS_fnc_removeIndex;};sleep 0.01;} foreach CARS;
sleep 0.5;
{if (isNull _x) then {NAPAveh = NAPAveh- [_x];};sleep 0.01;} foreach NAPAveh;
sleep 0.5;
{if (isNil"_x") exitWith {NAPAveh = [NAPAveh,_forEachIndex] call BIS_fnc_removeIndex;};sleep 0.01;} foreach NAPAveh;
sleep 0.5;
{if (isNil"_x") exitWith {CantCommand = [CantCommand,_forEachIndex] call BIS_fnc_removeIndex;};sleep 0.01;} foreach CantCommand;
sleep 0.5;
{if (isNull _x) then {CantCommand  = CantCommand - [_x];};sleep 0.01;} foreach CantCommand;
};
if (CLEANNUM == 1) then {
sleep 0.5;
{if (isNull _x) then {CIVIGNORE = CIVIGNORE - [_x];};sleep 0.01;} foreach CIVIGNORE;
sleep 0.5;
{if (isNil"_x") exitWith {CIVIGNORE = [CIVIGNORE,_forEachIndex] call BIS_fnc_removeIndex;};sleep 0.01;} foreach CIVIGNORE;
sleep 0.5;
{if (isNull _x) then {HeliGroups = HeliGroups - [_x];};sleep 0.01;} foreach HeliGroups;
sleep 0.5;
{if (isNil"_x") exitWith {HeliGroups = [HeliGroups,_forEachIndex] call BIS_fnc_removeIndex;};sleep 0.01;} foreach HeliGroups;
sleep 0.5;
{if (isNull _x) then {CampGroups = CampGroups - [_x];};sleep 0.01;} foreach CampGroups;
sleep 0.5;
{if (isNil"_x") exitWith {CampGroups = [CampGroups,_forEachIndex] call BIS_fnc_removeIndex;};sleep 0.01;} foreach CampGroups;
sleep 0.5;
};
if (CLEANNUM == 2) then {
{if (isNull _x) then {VehicleGroups = VehicleGroups - [_x];};sleep 0.01;} foreach VehicleGroups;
sleep 0.5;
{if (isNil"_x") exitWith {VehicleGroups = [VehicleGroups,_forEachIndex] call BIS_fnc_removeIndex;};sleep 0.01;} foreach VehicleGroups;
};
if (CLEANNUM == 3) then {
{if (isNull _x) then {FriendlyVehicles = FriendlyVehicles - [_x];}; if (leader _x == vehicle leader _x) then { _nul = [_x] SPAWN FUNKTIO_MAAGD; FriendlyVehicles = FriendlyVehicles - [_x];};sleep 0.01;} foreach FriendlyVehicles;
sleep 0.5;
{if (isNil"_x") exitWith {FriendlyVehicles = [FriendlyVehicles,_forEachIndex] call BIS_fnc_removeIndex;};sleep 0.01;} foreach FriendlyVehicles;
sleep 0.5;
{if (isNull _x) then {FriendlyInf = FriendlyInf - [_x];};sleep 0.01;} foreach FriendlyInf;
sleep 0.5;
{if (isNil"_x") exitWith {FriendlyInf = [FriendlyInf,_forEachIndex] call BIS_fnc_removeIndex;};sleep 0.01;} foreach FriendlyInf;
sleep 0.5;
{if (isNull _x) then {Pgroups = Pgroups - [_x];};sleep 0.01;} foreach Pgroups; 
sleep 0.5;
{if (isNil"_x") exitWith {Pgroups = [Pgroups,_forEachIndex] call BIS_fnc_removeIndex;};sleep 0.01;} foreach Pgroups;
sleep 0.5;
{
     if ((_x distance [0,0,0]) < 1) then {
         deleteVehicle _x;
     };
sleep 0.01;	 
} count (allMissionObjects "EmptyDetector");
};
if (CLEANNUM == 4) then {
{if (isNil"_x" || {typename _x != "STRING"} || {_x == ""}) exitWith {VEHZONES = [VEHZONES,_forEachIndex] call BIS_fnc_removeIndex;};sleep 0.01;} foreach VEHZONES;
sleep 0.5;
{if (isNil"_x" || {typename _x != "STRING"} || {_x == ""}) exitWith {AmbientZones = [AmbientZones,_forEachIndex] call BIS_fnc_removeIndex;};sleep 0.01;} foreach AmbientZones;
sleep 0.5;
{if (isNil"_x" || {typename _x != "STRING"} || {_x == ""}) exitWith {AmbientZonesN = [AmbientZonesN,_forEachIndex] call BIS_fnc_removeIndex;};sleep 0.01;} foreach AmbientZonesN;
sleep 0.5;
{if (isNil"_x" || {typename _x != "OBJECT"} || {isNull _x}) exitWith {GuardPosts = [GuardPosts,_forEachIndex] call BIS_fnc_removeIndex;};sleep 0.01;} foreach GuardPosts;
sleep 0.5;
{if (isNil"_x" || {typename _x != "STRING"} || {_x == ""}) exitWith {Bpositions = [Bpositions,_forEachIndex] call BIS_fnc_removeIndex;};sleep 0.01;} foreach Bpositions;
sleep 0.5;
{if (isNil"_x" || {typename _x != "STRING"} || {_x == ""}) exitWith {AMBbattles = [AMBbattles,_forEachIndex] call BIS_fnc_removeIndex;};sleep 0.01;} foreach AMBbattles;
};
CLEANNUM = CLEANNUM + 1;
if (CLEANNUM > 4) then {CLEANNUM = 0;};
sleep 5;
{_y = _x; if ({(vehicle _x) distance (vehicle leader _y) < 900} count ([] CALL AllPf) == 0 && {(vehicle leader _y == leader _y || {{alive _x} count units _y == 0})}) then {{_nul = [_x] SPAWN FUNKTIO_DELUNIT;sleep 0.01;} foreach units _x;if !(_x in DONTDELGROUPS) then {Pgroups = Pgroups - [_x];};};sleep 0.01;} foreach Pgroups; 
sleep 0.5;
{_y = _x;if ({(vehicle _x) distance (vehicle leader _y) < 1350} count ([] CALL AllPf) == 0) then { {_nul = [_x] SPAWN FUNKTIO_DELUNIT;} foreach units _x; VehicleGroups = VehicleGroups - [_x]; };sleep 0.01;} foreach VehicleGroups;
sleep 5;
{_y = _x;if ({(vehicle _x) distance (vehicle leader _y) < 1350} count ([] CALL AllPf) == 0) then {{_nul = [_x] SPAWN FUNKTIO_DELUNIT;} foreach units _x; FriendlyVehicles = FriendlyVehicles - [_x];sleep 0.01;};} foreach FriendlyVehicles;
sleep 0.5;
{_y = _x;if ({(vehicle _x) distance (vehicle leader _y) < 900} count ([] CALL AllPf) == 0 && {(vehicle leader _y == leader _y || {{alive _x} count units _y == 0})}) then {{_nul = [_x] SPAWN FUNKTIO_DELUNIT;sleep 0.01;} foreach units _x;if !(_x in DONTDELGROUPS) then {FriendlyInf = FriendlyInf - [_x];};};sleep 0.01;} foreach FriendlyInf;
//sleep 10;
//RANDOM CUSTOM BEHAVIOUR
sleep 0.5;
//Surrendering when alone
{
if (side (leader _x) == EAST) then {
if (count (units _x) < 3) then {
if (random 1 < 0.4) then {
if (behaviour leader _x == "COMBAT" && (count ((getposATL leader _x) nearEntities [["SoldierEB"],100]) < 3 && count ((getposATL leader _x) nearEntities [["SoldierWB"],300]) > 2)) then {
sleep (random 10);
{[_x] SPAWN FUNKTIO_ANTAUDU; _x setvariable ["SaOkSurrendered",1,true];} foreach units _x;
};
};
};
};
sleep 0.01;
} foreach AllGroups; 