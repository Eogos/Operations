/*
Populate Military Airbase
*/

// Empty vehicles
/*
_heli01 = "B_Heli_Transport_01_F" createVehicle [8020.73,10197.2,0];
_heli01 setDir 0;
_heli01 setFuel 0.235;
_heli01 setPosATL [8020.73,10197.2,0];
_heli01 enableDynamicSimulation true;

_heli02 = "B_Heli_Transport_01_F" createVehicle [8038.9,10314.3,0];
_heli02 setDir 90;
_heli02 setFuel 0.25;
_heli02 setPosATL [8038.9,10314.3,0];
_heli02 enableDynamicSimulation true;

_heli03 = "B_Heli_Light_01_F" createVehicle [8126.55,10184.2,0];
_heli03 setDir 270;
_heli03 setFuel 0.275;
_heli03 setPosATL [8126.55,10184.2,0];
_heli03 enableDynamicSimulation true;

_heli04 = "B_Heli_Light_01_F" createVehicle [8069.7,10009.1,0.388504];
_heli04 setDir 1;
_heli04 setFuel 0.275;
_heli04 setPosATL [8069.7,10009.1,0.388504];
_heli04 enableDynamicSimulation true;

_vtol = "B_T_VTOL_01_infantry_F" createVehicle [8095.92,10452.6,0];
_vtol setDir 312;
_vtol setFuel 0.275;
_vtol setPosATL [8095.92,10452.6,0];
_vtol enableDynamicSimulation true;

{clearMagazineCargoGlobal _x; clearWeaponCargoGlobal _x; clearItemCargoGlobal _x} forEach [_heli01,_heli02,_heli03,_heli04,_vtol];

sleep 2;
*/
// Enemy vehicles
// Panther

_kamysh = createVehicle ["B_APC_Tracked_01_rcws_F", [7943.02,9981.25,0], [], 0, "NONE"];
_kamysh setDir 0;
createVehicleCrew _kamysh;
_kamyshCrew = crew _kamysh;
_kamyshGroup = group (_kamyshCrew select 0);

_kamyshGroup enableDynamicSimulation true;

{clearMagazineCargoGlobal _x; clearWeaponCargoGlobal _x; clearBackpackCargoGlobal _x; clearItemCargoGlobal _x} forEach [_kamysh];
_wpKamysh01 = _kamyshGroup addWaypoint [[7943.02,9981.25,0], 0];
_wpKamysh02 = _kamyshGroup addWaypoint [[7943.77,10362.8,0], 0];
_wpKamysh03 = _kamyshGroup addWaypoint [[7943.02,9981.25,0], 0];
_wpKamysh03 setWaypointType "Cycle";
_kamyshGroup setSpeedMode "Limited";
if (missionNamespace getVariable "BIS_enemyEquipment" == 1) then {{_null = _x execVM "Scripts\LimitEquipment.sqf"} forEach _kamyshCrew};
{_x setSkill ["AimingAccuracy",0.15]} forEach _kamyshCrew;

if (missionNamespace getVariable "BIS_crewInImmobile" == 1) then
{
	_kamysh allowCrewInImmobile true;
};

sleep 5;

// Cheetah
_tigris = createVehicle ["B_APC_Tracked_01_AA_F", [7999.55,10069.1,0], [], 0, "NONE"];
_tigris setDir 270;
createVehicleCrew _tigris;
_tigrisCrew = crew _tigris;
_tigrisGroup = group (_tigrisCrew select 0);

_tigrisGroup enableDynamicSimulation true;

{clearMagazineCargoGlobal _x; clearWeaponCargoGlobal _x; clearBackpackCargoGlobal _x; clearItemCargoGlobal _x} forEach [_tigris];
if (missionNamespace getVariable "BIS_enemyEquipment" == 1) then {{_null = _x execVM "Scripts\LimitEquipment.sqf"} forEach _tigrisCrew};
{_x setSkill ["AimingAccuracy",0.15]} forEach _tigrisCrew;

if (missionNamespace getVariable "BIS_crewInImmobile" == 1) then
{
	_tigris allowCrewInImmobile true;
};

sleep 5;


// 1st group - runway team
_pos01a = [7890.85,9981.38,0];
_pos01b = [7894.4,10372.8,0];

_grp01 = grpNull;
_grp01 = [_pos01a, west, configFile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry" >> "BUS_InfTeam", [], [], [0.3, 0.4]] call BIS_fnc_spawnGroup;
{_x setBehaviour "Safe"; _x setSpeedMode "Limited"; _x setFormation "Column"} forEach [_grp01];
if (missionNamespace getVariable "BIS_enemyEquipment" == 1) then {{_null = _x execVM "Scripts\LimitEquipment.sqf"} forEach (units _grp01)};
{_x setSkill ["AimingAccuracy",0.15]} forEach (units _grp01);
_grp01 enableDynamicSimulation true;

_wp01a = _grp01 addWaypoint [_pos01a, 0];
_wp01b = _grp01 addWaypoint [_pos01b, 0];
_wp01c = _grp01 addWaypoint [_pos01a, 0];
_wp01c setWaypointType "Cycle";

	// Remove backpack with spare NLAWs
	// {if (typeOf _x == "B_Soldier_LAT_F") then {removeBackpackGlobal _x}} forEach (units _grp01);

sleep 5;

// 2nd group - south squad
_pos02a = [8119.86,9846.13,0];
_pos02b = [8120.78,10063.3,0];

_grp02 = grpNull;
_grp02 = [_pos02a, west, configFile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry" >> "BUS_InfSquad", [], [], [0.3, 0.4]] call BIS_fnc_spawnGroup;
{_x setBehaviour "Safe"; _x setSpeedMode "Limited"; _x setFormation "Column"} forEach [_grp02];
if (missionNamespace getVariable "BIS_enemyEquipment" == 1) then {{_null = _x execVM "Scripts\LimitEquipment.sqf"} forEach (units _grp02)};
{_x setSkill ["AimingAccuracy",0.15]} forEach (units _grp02);
_grp02 enableDynamicSimulation true;

_wp02a = _grp02 addWaypoint [_pos02a, 0];
_wp02b = _grp02 addWaypoint [_pos02b, 0];
_wp02c = _grp02 addWaypoint [_pos02a, 0];
_wp02c setWaypointType "Cycle";

	// Remove backpack with spare NLAWs
	// {if (typeOf _x == "B_Soldier_LAT_F") then {removeBackpackGlobal _x}} forEach (units _grp02);

sleep 5;

// 3rd group - north squad
_pos03a = [8076.68,10212.8,0];
_pos03b = [8065.86,10435.6,0];

_grp03 = grpNull;
_grp03 = [_pos03a, west, configFile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry" >> "BUS_InfSquad", [], [], [0.3, 0.4]] call BIS_fnc_spawnGroup;
{_x setBehaviour "Safe"; _x setSpeedMode "Limited"; _x setFormation "Column"} forEach [_grp03];
if (missionNamespace getVariable "BIS_enemyEquipment" == 1) then {{_null = _x execVM "Scripts\LimitEquipment.sqf"} forEach (units _grp03)};
{_x setSkill ["AimingAccuracy",0.15]} forEach (units _grp03);
_grp03 enableDynamicSimulation true;

_wp03a = _grp03 addWaypoint [_pos03a, 0];
_wp03b = _grp03 addWaypoint [_pos03b, 0];
_wp03c = _grp03 addWaypoint [_pos03a, 0];
_wp03c setWaypointType "Cycle";

	// Remove backpack with spare NLAWs
	// {if (typeOf _x == "B_Soldier_LAT_F") then {removeBackpackGlobal _x}} forEach (units _grp03);
