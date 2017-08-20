// Delete empty groups
_deleteEmptyGrups = [] execVM "Scripts\DeleteEmptyGroups.sqf";

// Handle respawn of players - add respawn position for the team and delete older corpse (so only one for each player can be present)
addMissionEventHandler ["EntityRespawned",
{
	private _new = _this select 0;
	private _old = _this select 1;

	if (isPlayer _new)  then
	{
		private _oldBody = _old getVariable ["BIS_oldBody", objNull];
		if (!isNull _oldBody) then
		{
			deleteVehicle _oldBody;
		};

                _new setVariable ["BIS_oldBody", _old];

		[east,_new] call BIS_fnc_addRespawnPosition;
	};
}];

// Add initial respawn position and remove it after a timeout
[] spawn {
	_initSpawn = [east,"respawn",localize "STR_A3_EscapeFromMalden_respawnVigny"] call BIS_fnc_addRespawnPosition;
	sleep 300;
	waitUntil {sleep 5; {alive _x} count allPlayers > 0};
	_initSpawn call BIS_fnc_removeRespawnPosition;
};

// Start special events if enabled
[] spawn {
	sleep 5;

	if (missionNamespace getVariable "BIS_specialEvents" == 1) then
	{
                      _events = [10,15] spawn BIS_fnc_EfM_specialEvents;
	};
};

// Limit equipment of already existing enemy units
[] spawn {
	if (missionNamespace getVariable "BIS_enemyEquipment" == 1) then
	{
		{if ((side group _x == West) or (side group _x == Resistance)) then {_null = _x execVM "Scripts\LimitEquipment.sqf"}} forEach allUnits;
	};
};

// Escape task for players
[BIS_grpMain, "objEscape", [format [localize "STR_A3_EscapeFromTanoa_tskEscapeDesc", "<br/>"], localize "STR_A3_EscapeFromMalden_tskEscapeTitle", "<br/>"], objNull, TRUE] call BIS_fnc_taskCreate;

// Initial music
[] spawn {
	sleep 15;
	"LeadTrack02_F_Jets" remoteExec ["playMusic",east,false];
};

/*
LeadTrack03_F_Mark
LeadTrack04_F_EXP
LeadTrack06b_F_EPC
*/

// Definitions of vehicles and groups to be spawned
BIS_civilCars =
[
	"C_Offroad_01_F",
	"C_Quadbike_01_F",
	"C_SUV_01_F",
	"C_Van_01_transport_F",
	/*"C_Offroad_02_unarmed_F",*/
	"C_Truck_02_transport_F"
];

BIS_supportVehicles =
[
	"C_Van_01_fuel_F",
	"C_Truck_02_fuel_F",
	"C_Offroad_01_repair_F"
];

BIS_NATOPatrols =
[
	/*"BUS_InfTeam",
	"BUS_InfSquad",*/
	"EfM_W_Team01",
	"EfM_W_Team02",
	"EfM_W_Team03",
	"EfM_W_Team04",
	"EfM_W_Squad01",
        "EfM_W_Squad02"
];

// Spawning enemy units & vehicles, empty transport and support vehicles
{

	// NATO patrols
	if (triggerText _x == "NATO_infantry") then
	{
		_x spawn
		{
			_basePos = position _this;
			_rad = (triggerArea _this) select 0;
			deleteVehicle _this;

			waitUntil {sleep 5; ({(_x distance2d _basePos) < (1000)} count allPlayers > 0)};

			// if ({side _x == west} count allGroups > 120) exitWith {"Too many WEST groups at the same time!" call BIS_fnc_log};

			_newGrp = grpNull;
			_newGrp = [_basePos, west, missionConfigFile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry" >> (selectRandom BIS_NATOPatrols), [], [], [0.2, 0.3]] call BIS_fnc_spawnGroup;

			// Remove backpack with spare NLAWs - balance ftw
			// {if (typeOf _x == "B_Soldier_LAT_F") then {removeBackpackGlobal _x}} forEach (units _newGrp);

			// Enable Dynamic simulation
			_newGrp enableDynamicSimulation true;

			// Limit unit equipment if set by server
			if (missionNamespace getVariable "BIS_enemyEquipment" == 1) then {{_null = _x execVM "Scripts\LimitEquipment.sqf"} forEach units _newGrp};

			// Limit aiming accuracy
			{_x setSkill ["AimingAccuracy",0.15]} forEach (units _newGrp);

			if ((random 1) > 0.65)
			then
			{	
				/*_wp = _newGrp addWaypoint [position leader _newGrp, 0];
				_wp setWaypointType "GUARD";*/
				_stalk = [_newGrp,group (allPlayers select 0)] spawn BIS_fnc_stalk;
			} else
			{
				{
					_wp = _newGrp addWaypoint [_basePos, _rad];
					_wp setWaypointType "MOVE";
					_wp setWaypointSpeed "LIMITED";
					_wp setWaypointBehaviour "SAFE";
				} forEach [1, 2, 3, 4, 5];
				_wp = _newGrp addWaypoint [waypointPosition [_newGrp, 1], 0];
				_wp setWaypointType "CYCLE";
			};
		};
	};

	// NATO patrolling vehicles
	if (triggerText _x == "NATO_patrolVeh") then {
		_x spawn {
			_basePos = position _this;
			_dir = (triggerArea _this) select 2;
			if (_dir < 0) then {_dir = 360 + _dir};
			_vehType = (triggerStatements _this) select 1;
			_wpPath = group ((synchronizedObjects _this) select 0);	// synchronized civilian unit is used as waypoint storage
			deleteVehicle ((synchronizedObjects _this) select 0);
			deleteVehicle _this;

			waitUntil {sleep 2.5; ({(_x distance _basePos) < 1000} count allPlayers > 0)};

			_vehClass = switch (_vehType) do
			{
				case "MRAP": {selectRandom ["B_MRAP_01_gmg_F","B_MRAP_01_hmg_F"]};
				case "APC": {"B_APC_Tracked_01_rcws_F"};
				case "IFV": {"B_APC_Wheeled_01_cannon_F"};
				case "AAA": {"B_APC_Tracked_01_AA_F"};
				case "LSV": {"B_LSV_01_armed_F"};
				case "LSVU": {"B_LSV_01_unarmed_F"};
				case "UGV": {"B_UGV_01_rcws_F"};
				case "Boat": {"B_Boat_Armed_01_minigun_F"};

				default {"B_LSV_01_armed_F"};
			};
			_veh = createVehicle [_vehClass, _basePos, [], 0, "NONE"];
			_veh setDir _dir;
			createVehicleCrew _veh;
			_vehCrew = crew _veh;
			_vehGroup = group (_vehCrew select 0);

			_vehGroup copyWaypoints _wpPath;
			deleteGroup _wpPath;
			{clearMagazineCargoGlobal _x; clearWeaponCargoGlobal _x; clearBackpackCargoGlobal _x; clearItemCargoGlobal _x} forEach [_veh];
			_veh addItemCargoGlobal ["FirstAidKit",2];
			_veh setFuel (0.2 + random 0.2);
			_veh setVehicleAmmo (0.4 + random 0.4);

			// If the vehicle is unarmed LSV, create crew for FFV positions and disable getting out in combat
			if (_vehType == "LSVU") then {
				_veh setUnloadInCombat [false,false];

				_unit01 = _vehGroup createUnit ["B_Soldier_AR_F", [0,0,0], [], 0, "CAN COLLIDE"];
				_unit01 moveInCargo _veh;
				[_unit01] orderGetIn true;

				_unit02 = _vehGroup createUnit [selectRandom ["B_Soldier_GL_F","B_Soldier_F"], [0,0,0], [], 0, "CAN COLLIDE"];
				_unit02 moveInCargo _veh;
				[_unit02] orderGetIn true;

				_unit03 = _vehGroup createUnit ["B_Soldier_F", [0,0,0], [], 0, "CAN COLLIDE"];
				_unit03 moveInCargo _veh;
				[_unit03] orderGetIn true;

                                _vehCrew = crew _veh;
			};

			// Handle immobilization
			if (missionNamespace getVariable "BIS_crewInImmobile" == 1) then
			{
				_veh allowCrewInImmobile true;
			};
/*
			// Chance to create a second vehicle of the same type - only for armed LSV and UGV
			if ((_vehType in ["UGV","LSV"]) and {random 100 < 35}) then {

				_veh02 = createVehicle [_vehClass, [(_basePos select 0) - 7, (_basePos select 1) - 7, 0], [], 0, "NONE"];
				_veh02 setDir _dir;
				createVehicleCrew _veh02;
				_veh02Crew = crew _veh02;
				_veh02Crew joinSilent _vehGroup;

				{clearMagazineCargoGlobal _x; clearWeaponCargoGlobal _x; clearBackpackCargoGlobal _x; clearItemCargoGlobal _x} forEach [_veh02];
				_veh02 addItemCargoGlobal ["FirstAidKit",2];
				_veh02 setFuel (0.1 + random 0.1);
				_veh02 setVehicleAmmo (0.4 + random 0.4);

				// Handle immobilization
				if (missionNamespace getVariable "BIS_crewInImmobile" == 1) then
				{
					_veh02 allowCrewInImmobile true;
				};

			};
*/
			// Limit unit equipment if set by server
			if ((missionNamespace getVariable "BIS_enemyEquipment" == 1) and {_vehType != "UGV"}) then {{_null = _x execVM "Scripts\LimitEquipment.sqf"} forEach (units _vehGroup)};

			// Limit aiming accuracy
			{_x setSkill ["AimingAccuracy",0.1]} forEach (units _vehGroup);

			// Enable Dynamic simulation
			_vehGroup enableDynamicSimulation true;

		};
	};

	// Civilian vehicles
	if (triggerText _x == "GEN_civilCar") then
	{
		_x spawn
		{
			_basePos = position _this;
			_dir = (triggerArea _this) select 2;
			if (_dir < 0) then {_dir = 360 + _dir};

			deleteVehicle _this;

			waitUntil {sleep 5; ({(_x distance _basePos) < 1000} count allPlayers > 0)};

			_veh = (selectRandom BIS_civilCars) createVehicle _basePos;
			_veh setFuel (0.2 + (random 0.2));
			_veh setDir _dir;
			{clearMagazineCargoGlobal _x; clearWeaponCargoGlobal _x; clearBackpackCargoGlobal _x; clearItemCargoGlobal _x} forEach [_veh];
			_veh addItemCargoGlobal ["FirstAidKit",1];
			_veh enableDynamicSimulation true;

		};
	};
} forEach (allMissionObjects "EmptyDetector");

// Check if the players are escaping
BIS_Escaped = false;
publicVariable "BIS_Escaped";

[] spawn
{
	while {!(BIS_Escaped)} do
	{
		sleep 5;
		// _awayList = [];
		// {_awayList = _awayList + list _x} forEach [BIS_getaway_area_1, BIS_getaway_area_2, BIS_getaway_area_3, BIS_getaway_area_4];
		_livePlayers = ({alive _x} count allPlayers);
		if (({!((vehicle _x) in (list BIS_trgMalden)) and ((vehicle _x isKindOf "Ship") or (vehicle _x isKindOf "Air"))} count units BIS_grpMain == _livePlayers) and (_livePlayers > 0)) then
		{
			["objEscape", "Succeeded"] remoteExec ["BIS_fnc_taskSetState",east,true];
			["end1"] remoteExec ["BIS_fnc_endMission",east,true];
			BIS_Escaped = true;
			publicVariable "BIS_Escaped";
		};
	};
};

// Mission fail if everyone is dead
[] spawn
{
	sleep 300;
	waitUntil {sleep 5; {alive _x} count (units BIS_grpMain) > 0};
	waitUntil {sleep 5; {alive _x} count (units BIS_grpMain) == 0};
	["objEscape", "Failed"] remoteExec ["BIS_fnc_taskSetState",east,true];
	["Loser", false] remoteExec ["BIS_fnc_endMission",east,true];
};

// Music when somebody gets into one of the escape vehicles
[] spawn
{
	sleep 5;
	waitUntil {sleep 5; {/*(vehicle _x isKindOf "Ship") or */(vehicle _x isKindOf "Air")} count units BIS_grpMain > 0};
	5 fadeMusic 0.75;
	"LeadTrack01_F_Jets" remoteExec ["playMusic",east,false];
};
