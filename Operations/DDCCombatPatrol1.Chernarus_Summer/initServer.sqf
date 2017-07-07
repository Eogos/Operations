/******************************************************************************************
 * This work is licensed under the APL-SA.                                                *
 ******************************************************************************************
	Author : 		basstard420
	Date : 			25/06/2017 (jj/mm/aaaa)
	Version : 		0.1
	
	Description :	Mission initialization file.
					This file is an example and should not be used as is.
					The class names and CfgGroups entry used for soldiers are from the Project Opfor's ISIS faction.
	
	Usage :			N/A
	
	Syntax :		N/A
	
	Parameters :	N/A
*/


/*
Here you define the ennemy soldiers. There are three possibilities to do so:
	1) 	You can use predefined groups (F2 in 3den editor). It is the way BIS devs have chosen so if you want to stick to it, you need to put a CfgGroups config file entry in the following variables.
		Note that obviously, if the ennemy faction you want to use doesn't have groups defined in CfgGroups you can't use this solution.
	2) 	You can use custom defined groups. It's a good way to raise the difficulty by putting more soldiers in each group, as well as it can be used to lower the difficulty by putting less soldiers.
		If you want to go this way you need to put an array of class names in the following variables.
	3) 	You can use groups defined in the Vanilla Combat Patrol. To do so, simply initialize the following variables with nil.
*/
BIS_CP_enemyGrp_sentry = configFile >> "cfgGroups" >> "East" >> "LOP_ISTS_OPF" >> "Infantry" >> "LOP_ISTS_OPF_Patrol_section";	// use a CfgGroups entry
BIS_CP_enemyGrp_sentry = ["LOP_ISTS_OPF_Infantry_Rifleman", "LOP_ISTS_OPF_Infantry_Rifleman_3"];								// use a custom defined group
BIS_CP_enemyGrp_sentry = nil;																									// use Vanilla Combat Patrol group

BIS_CP_enemyGrp_fireTeam = configFile >> "cfgGroups" >> "East" >> "LOP_ISTS_OPF" >> "Infantry" >> "LOP_ISTS_OPF_Fireteam";
BIS_CP_enemyGrp_fireTeam = ["LOP_ISTS_OPF_Infantry_TL", "LOP_ISTS_OPF_Infantry_AR", "LOP_ISTS_OPF_Infantry_GL", "LOP_ISTS_OPF_Infantry_Rifleman_2"];
BIS_CP_enemyGrp_fireTeam = nil;

BIS_CP_enemyGrp_rifleSquad = configFile >> "cfgGroups" >> "East" >> "LOP_ISTS_OPF" >> "Infantry" >> "LOP_ISTS_OPF_Rifle_squad";
BIS_CP_enemyGrp_rifleSquad = ["LOP_ISTS_OPF_Infantry_TL", "LOP_ISTS_OPF_Infantry_Rifleman_2", "LOP_ISTS_OPF_Infantry_Corpsman", "LOP_ISTS_OPF_Infantry_Rifleman", "LOP_ISTS_OPF_Infantry_Rifleman", "LOP_ISTS_OPF_Infantry_Rifleman_3"];
BIS_CP_enemyGrp_rifleSquad = nil;

/*
The BIS_CP_enemyTroops variable must be an array of class names (it contains the units that will be randomly picked and placed in buildings).
For this particular variable you only have the choice between a custom define (solution 2) or using nil (solution 3).
Note that using nil doesn't imply you will have CSAT units in buildings. The code behind the scene extract the class names of the config file entry contained in BIS_CP_enemyGrp_rifleSquad.
Using nil is only a valid option in the two following cases:
	1)	BIS_CP_enemyGrp_rifleSquad = nil and BIS_CP_enemyTroops = nil (CSAT units will spawn for both groups).
	2)	BIS_CP_enemyGrp_rifleSquad = config file entry and BIS_CP_enemyTroops = nil (custom units defined will spawn for both groups).
*/
BIS_CP_enemyTroops = ["LOP_ISTS_OPF_Infantry_TL", "LOP_ISTS_OPF_Infantry_Rifleman_2", "LOP_ISTS_OPF_Infantry_Corpsman"];	// custom defined units will spawn in buildings
BIS_CP_enemyTroops = nil;																									// the units extracted from BIS_CP_enemyGrp_rifleSquad will spawn in buildings


/*
Here you define the ennemy vehicles.
All variables except BIS_CP_enemyVeh_Truck need to be initialized with a single class name or nil.
Concerning BIS_CP_enemyVeh_Truck it can be used the same way as the first three variables (BIS_CP_enemyGrp_sentry, BIS_CP_enemyGrp_fireTeam and BIS_CP_enemyGrp_rifleSquad).
*/
BIS_CP_enemyVeh_MRAP = "LOP_ISTS_OPF_Landrover_M2";	// custom defined vehicle
BIS_CP_enemyVeh_MRAP = nil;							// Arma 3 Vanilla vehicle

BIS_CP_enemyVeh_Truck = configFile >> "cfgGroups" >> "East" >> "LOP_ISTS_OPF" >> "Motorized" >> "LOP_ISTS_OPF_MotInf_Team_BTR60";
BIS_CP_enemyVeh_Truck = ["LOP_ISTS_OPF_Infantry_TL", "LOP_ISTS_OPF_BTR60", "LOP_ISTS_OPF_Infantry_AR", "LOP_ISTS_OPF_Infantry_AT", "LOP_ISTS_OPF_Infantry_Corpsman", "LOP_ISTS_OPF_Infantry_Rifleman_2"];
BIS_CP_enemyVeh_Truck = nil;

BIS_CP_enemyVeh_UAV_big = "rhs_pchela1t_vvs";
BIS_CP_enemyVeh_UAV_big = nil;

BIS_CP_enemyVeh_UAV_small = "O_UAV_01_F";
BIS_CP_enemyVeh_UAV_small = nil;

/* BIS_CP_enemyVeh_reinf1 must contain a ground vehicle (eg. wheeled APC) */
BIS_CP_enemyVeh_reinf1 = "LOP_ISTS_OPF_M113_W";
BIS_CP_enemyVeh_reinf1 = nil;

/* BIS_CP_enemyVeh_reinf2 must contain a ground vehicle (eg. tracked APC) */
BIS_CP_enemyVeh_reinf2 = "LOP_ISTS_OPF_BTR60";
BIS_CP_enemyVeh_reinf2 = nil;

/* BIS_CP_enemyVeh_reinfAir must contain an air vehicle to paradrop units (eg. transport helicopter) */
BIS_CP_enemyVeh_reinfAir = "LOP_TKA_Mi8MT_Cargo";
BIS_CP_enemyVeh_reinfAir = nil;


/*
Here you define the support vehicles used in the task "destroy ammo truck and refuel truck".
The BIS_CP_supportClasses variable must be an array of two class names (refuel truck class name and ammo truck class name) or nil.
*/
BIS_CP_supportClasses = ["CUP_O_Ural_Refuel_TKA", "CUP_O_Ural_Reammo_TKA"];		// custom defined trucks
BIS_CP_supportClasses = nil;													// Arma 3 Vanilla trucks


/*
Here you define the HVT character used in the task "kill the HVT". When you define the HVT class here, the guards will be randomly picked in the BIS_CP_enemyTroops array
The BAS_CCP_HVT variable offers three initialization possibilities:
	1)	You can use a single class name. The HVT will always be the same character.
	2)	You can use an array of class names. The code behind the scene randomly picks one class name inside the array.
	3)	You can use nil to get the Vanilla experience.
*/
BAS_CCP_HVT = "CUP_C_C_Functionary_01";													// custom defined HVT
BAS_CCP_HVT = ["CUP_C_C_Functionary_01", "CUP_C_C_Functionary_02", "C_journalist_F"];	// random HVT
BAS_CCP_HVT = nil;																		// Arma 3 Vanilla HVT and guards

/*
A variable to make visible or not the area in the AO showing where the HVT is patroling.
Should be false IMO because it makes this objective too easy.
*/
BAS_CCP_ShowHVTZone = false;

/* Set initialization done flag */
CCP_Init_Done = true;	// don't touch this one, modifying it could lead to malfunctions
