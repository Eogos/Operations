private ["_nul","_text","_n","_id","_MAPCLICK","_l","_walls","_weat"];
if (isNil"VEHZONES") then {VEHZONES = [];};
if (isNil"VEHZONESA") then {VEHZONESA = [];};
if (isNil"AmbientZonesN") then {AmbientZonesN = [];};
if (isNil"AmbientZones") then {AmbientZones = [];};
if (isNil"GuardPosts") then {GuardPosts = [];};
enableSaving [false, false];
call compile preprocessfileLineNumbers "SharedFuncs.sqf";
call compile preprocessfileLineNumbers "SharedFuncs2.sqf";
call compile preprocessfileLineNumbers "SharedFuncs3.sqf";
call compile preprocessfileLineNumbers "FrontLineFuncs.sqf";
NUMM=0;
if (isNil"LWalls") then {LWalls = [];};
if (isNil"ALLWalls") then {ALLWalls = [];};
if (isNil"paramsArray" && {!isdedicated}) then {paramsArray =[0,1,0,1,2,4,1,1,0,1,1,0];};
AddVehicleZone = compileFinal preprocessfileLineNumbers "AddVehicleZone.sqf";
FSaOkSave = compile preprocessfileLineNumbers "SaOkSave.sqf";
FStartDialog=compileFinal preprocessfileLineNumbers "StartDialog.sqf";
_n = [] SPAWN FStartDialog;
GUARDPOST = compileFinal preprocessfileLineNumbers "GuardPost.sqf";
IORW = {true};
MISSION_ROOT = call {
    private "_arr";
    _arr = toArray str missionConfigFile;
    _arr resize (count _arr - 15);
    toString _arr
};
if (isServer) then {[] SPAWN BIS_fnc_reviveInit;};
GearToRandom=compile preprocessfileLineNumbers "GearToRandom.sqf";
CONSVEHCLAS = ["LIB_SdKfz_7","LIB_opelblitz_open_y_camo","LIB_opelblitz_tent_y_camo","Lib_sdkfz251","Lib_SdKfz251_captured","lib_us6_tent","lib_us6_open","lib_zis5v","LIB_Scout_m3","LIB_US_GMC_Tent","LIB_US_GMC_Open","LIB_US_Scout_m3","I_MRAP_03_hmg_F","I_MRAP_03_gmg_F","I_MRAP_03_F","I_Heli_Transport_02_F","B_APC_Tracked_01_rcws_F","I_APC_Wheeled_03_cannon_F","B_APC_Wheeled_01_cannon_F","B_MRAP_01_gmg_F","B_MRAP_01_hmg_F","B_MRAP_01_F","B_Truck_01_covered_F","B_Truck_01_transport_F","I_Truck_02_covered_F","I_Truck_02_transport_F","B_Truck_01_box_F","B_Truck_01_Repair_F","C_Van_01_transport_F","I_G_Van_01_transport_F","B_G_Van_01_transport_F"];
SAOKFSI = 0.025;
GOODBUILDING = [];
BADBUILDING = [];
CLEANNUM = 0;
LCON1 = [];
TEST_MODE = false;
//SaOkNoAnimals = true;
CapturedAll = 0;
NOMOVEZONES = [];
DONTSTOREZONES = [];
//SAOKTCOND in sharedfuncs.sqf ["NEARESTVILLAGE"] call BIS_fnc_codePerformance;
//SAOKDYNTASKS = [["SAOKENDT"],["maintasks\captureofficer.sqf"],["SAOKPIERT"]]; 
SAOKDYNTASKS = []; 
UNITSTOSUR = [];
SZONES = [];
TIMMUL = 1;
SAOKMAPSIZE = 30000;
SaOK_factories = 0;
SaOK_power = 0;
SaOK_pier = 0;
SaOK_stor = 0;
FRIENDC5 = [];
RESERVEZONE = [];
RESERVEAMARKS = [];
MAXACTIVEV = 2;
ACTIVEZ = [];
PSHOT = 0;
/*
if (productVersion select 2 > 132) then {
_n = [] execVM "SlingFuncs.sqf";
};
*/
SaOkmissionnamespace setvariable ["CurrentEvents", []];
SaOkmissionnamespace setvariable ["LastVeh", objNull];
SaOkmissionnamespace setvariable ["SaOkChapters", []];
SaOkmissionnamespace setvariable ["ComingChapters",[]];
SpawnGroupCustom = compileFinal preprocessfileLineNumbers "SpawnGroupCustom.sqf"; 
_nul = [] SPAWN compile preprocessfileLineNumbers "SaOkShopInit.sqf";
call compile preprocessfileLineNumbers "TaskEvents.sqf";
call compile preprocessfileLineNumbers "TaskEvents2.sqf";
call compile preprocessfileLineNumbers "FactoryCreation.sqf";
call compile preprocessfileLineNumbers "ConstructFuncs.sqf";
call compile preprocessfileLineNumbers "SaOkGearSaving.sqf";
call compile preprocessfileLineNumbers "SaOkGearInit.sqf";
call compile preprocessfileLineNumbers "SaOkAddOnInit.sqf";
call compile preprocessfileLineNumbers "CustomMapSettings.sqf"; 
call compile preprocessfileLineNumbers "CrateDialog.sqf";
[player,"PlaV", "JinVoices\sounds.bikb", ""] CALL SAOKKBTOPIC;
FUNKTIO_POS=compile preprocessfileLineNumbers "findPos.sqf";
F_SaOkGearCam = compile preprocessfileLineNumbers "SaOkGearCam.sqf";
ICONCOLOR = (configfile >> "cfgmarkercolors" >> "ColorWhite" >> "color") call bis_fnc_colorConfigToRGBA;
ICONCOLORCIV = (configfile >> "cfgmarkercolors" >> "ColorPink" >> "color") call bis_fnc_colorConfigToRGBA;
ICONCOLORBLUE = (configfile >> "cfgmarkercolors" >> "ColorBlue" >> "color") call bis_fnc_colorConfigToRGBA;
ICONCOLORRED = (configfile >> "cfgmarkercolors" >> "ColorRed" >> "color") call bis_fnc_colorConfigToRGBA;
ICONCOLORGREEN = (configfile >> "cfgmarkercolors" >> "ColorGreen" >> "color") call bis_fnc_colorConfigToRGBA;
ICONCOLORORANGE = (configfile >> "cfgmarkercolors" >> "ColorOrange" >> "color") call bis_fnc_colorConfigToRGBA;
ICONCOLORORANGE set [3,0.5];
ICONCOLORBLUE set [3,0.5];
ICONCOLORGREEN set [3,0.5];
ICONCOLORRED set [3,0.5];
ICONCOLORCIV set [3,0.5];
ICONCOLOR set [3,0.5];
DIFLEVEL=1;
MULTLIFE=0;
GUARDLIM = true;
SAOKobjcB = ["Land_ChairPlastic_F","Land_ChairWood_F","Land_CampingChair_V1_F","Land_ChairPlastic_F","Land_ChairWood_F","Land_CampingChair_V1_F","Land_ChairPlastic_F","Land_ChairWood_F","Land_CampingChair_V1_F","Land_ChairPlastic_F","Land_ChairWood_F","Land_CampingChair_V1_F","Land_PortableLight_double_F","Land_PortableLight_single_F","Land_CampingChair_V2_F","Land_CampingChair_V1_folded_F","Land_CampingChair_V1_F","Land_CratesPlastic_F","Land_CratesShabby_F","Land_CratesWooden_F","Land_Sack_F","Land_Sacks_heap_F","Land_Sacks_goods_F","Land_Bricks_V2_F","Land_Bricks_V2_F","Land_Bricks_V3_F","Land_Bricks_V4_F","Land_Basket_F","Land_Cages_F","Land_WaterBarrel_F","Land_BarrelWater_grey_F","Land_BarrelWater_F","Land_BarrelTrash_F","Land_BarrelTrash_grey_F","Land_BarrelSand_grey_F","Land_BarrelSand_F","Land_BarrelEmpty_grey_F","Land_BarrelEmpty_F","Land_MetalBarrel_empty_F","MetalBarrel_burning_F","Land_MetalBarrel_F","Land_CrabCages_F","Land_Wrench_F","Land_WorkStand_F","Land_WoodenBox_F","Land_WheelCart_F","Land_Meter3m_F","Land_Pallets_stack_F","Land_Screwdriver_V1_F","Land_Screwdriver_V2_F","Land_Saw_F","Land_Portable_generator_F","Land_Pliers_F","Land_Pallet_vertical_F","Land_Pallet_F","Land_MultiMeter_F","Land_Hammer_F","Land_Grinder_F","Land_FloodLight_F","Land_CinderBlocks_F","Land_WoodenTable_small_F","Land_WoodenTable_large_F","Land_MapBoard_F","Land_ShelvesWooden_khaki_F","Land_ShelvesWooden_blue_F","Land_ShelvesWooden_F","Land_ShelvesMetal_F","Land_Rack_F","Land_Metal_wooden_rack_F","Land_Metal_rack_Tall_F","Land_Metal_rack_F","Land_Icebox_F","Land_TableDesk_F","Land_ChairWood_F","Land_ChairPlastic_F","Land_CashDesk_F","Land_Bench_F","Land_MetalWire_F","Land_LuggageHeap_01_F","Land_LuggageHeap_03_F","Land_Laptop_unfolded_F","Land_Laptop_F","Land_HeatPack_F","Land_HandyCam_F"];
VEHARRAY = compile preprocessfileLineNumbers "VehClasses.sqf";
MusicP=compile preprocessfileLineNumbers "MusicP.sqf";
AddIdVeh = [];
DISVAR = 1000;
DIS = compile preprocessfileLineNumbers "DIS.sqf";
SAOKFPS = 45;
DebugiMoode = true;
MIlunitsAICAMP = [];
RBLOCATIONS = [];
FORBITTENCEN = [];
FACTORYLOCATIONS = [];
FUNKTIO_LOS = compileFinal preprocessfileLineNumbers "LOS.sqf";
["EastWind"] CALL BIS_fnc_setPPeffectTemplate;
oPKDW3 = compile preprocessfileLineNumbers "onPlayerKilled_dw3.sqf";
BISsmoke = compile preprocessfileLineNumbers "BISsmoke.sqf";
BISsmokeS = compile preprocessfileLineNumbers "BISsmokeS.sqf";
BISfire = compile preprocessfileLineNumbers "BISfire.sqf";
BISfireS = compile preprocessfileLineNumbers "BISfireS.sqf";
BISemitter = compile preprocessfileLineNumbers "BISemitter.sqf";
FireSmoke= compile preprocessfileLineNumbers "FireSmoke.sqf";
FIREVILLAGE= compile preprocessfileLineNumbers "FireVillage.sqf";
IEDNUM = 0;
F_IED = compile preprocessfileLineNumbers "IED.sqf";
F_IEDmil = compile preprocessfileLineNumbers "IEDmil.sqf";
if (isNil"FACRES") then {FACRES = 0;};
IGPOS=compile preprocessfileLineNumbers "IgPos.sqf";
_nul = [] SPAWN compile preprocessfileLineNumbers "PlayerEffects.sqf";
_nul = [] SPAWN compile preprocessfileLineNumbers "Multifuncs.sqf";
call compile preprocessfileLineNumbers "FactoryCreation.sqf";
call compile preprocessfileLineNumbers "SharedFuncs.sqf";
call compile preprocessfileLineNumbers "ConstructFuncs.sqf";
RANDOMTIP = "Call Support - SHIFT + 1 (TEAM-LEADER or Rights)";
//call compile preprocessfileLineNumbers "LightFuncs.sqf";
[player,"PlaV", "JinVoices\sounds.bikb", ""] CALL SAOKKBTOPIC;
FUNKTIO_POS=compile preprocessfileLineNumbers "findPos.sqf";
ICONCOLOR = (configfile >> "cfgmarkercolors" >> "ColorWhite" >> "color") call bis_fnc_colorConfigToRGBA;
ICONCOLORCIV = (configfile >> "cfgmarkercolors" >> "ColorPink" >> "color") call bis_fnc_colorConfigToRGBA;
ICONCOLORBLUE = (configfile >> "cfgmarkercolors" >> "ColorBlue" >> "color") call bis_fnc_colorConfigToRGBA;
ICONCOLORRED = (configfile >> "cfgmarkercolors" >> "ColorRed" >> "color") call bis_fnc_colorConfigToRGBA;
ICONCOLORGREEN = (configfile >> "cfgmarkercolors" >> "ColorGreen" >> "color") call bis_fnc_colorConfigToRGBA;
ICONCOLORBLUE set [3,0.5];
ICONCOLORGREEN set [3,0.5];
ICONCOLORRED set [3,0.5];
ICONCOLORCIV set [3,0.5];
ICONCOLOR set [3,0.5];
IC3D = true;
MIlunitsAICAMP= [];
CreatePrison = compile preprocessfileLineNumbers "CreatePrison.sqf";
VehLife=compile preprocessfileLineNumbers "VehLife.sqf";
if (isServer) then {
_nul = [] SPAWN compile preprocessfileLineNumbers "AICampBehaviourCivGlobal.sqf";
_nul = [] SPAWN compile preprocessfileLineNumbers "AICampBehaviourMILGlobal.sqf";
(paramsArray select 0) SPAWN {
_nul = [] SPAWN compile preprocessfileLineNumbers "AllWeapons.sqf";
waitUntil {sleep 0.1; scriptdone _nul};
_this SPAWN SAOKMODTEMP;
};
} else {
_nul = [] SPAWN compile preprocessfileLineNumbers "AllWeapons.sqf";
};
//0 US, 1 HOSTILE, 2 GREEK, 3 LOCAL
if (isNil"ARMEDVEHICLES") then {
ARMEDVEHICLES = [
["B_MRAP_01_hmg_F","B_MRAP_01_gmg_F","B_APC_Wheeled_01_cannon_F","B_APC_Tracked_01_rcws_F","B_APC_Tracked_01_CRV_F","B_UGV_01_rcws_F"],
["O_APC_Wheeled_02_rcws_F","O_MRAP_02_gmg_F","O_MRAP_02_hmg_F","O_APC_Wheeled_02_rcws_F","O_APC_Tracked_02_cannon_F"],
["I_APC_tracked_03_cannon_F","I_APC_tracked_03_cannon_F","I_MRAP_03_gmg_F","I_MRAP_03_hmg_F","I_APC_Wheeled_03_cannon_F","I_UGV_01_rcws_F"],
["I_G_Offroad_01_armed_F"]
];

ARMEDTANKS = [
["B_MBT_01_cannon_F"],
["O_MBT_02_cannon_F"],
["I_MBT_03_cannon_F"],
["I_G_Offroad_01_armed_F"]
];

ARMEDAA = [
["B_APC_Tracked_01_AA_F"],
["O_APC_Tracked_02_AA_F"],
["I_APC_tracked_03_cannon_F"],
["I_G_Offroad_01_armed_F"]
];

ARMEDCARRIER = [
["B_Truck_01_transport_F","B_Truck_01_covered_F","B_G_Offroad_01_F","B_APC_Tracked_01_rcws_F","B_APC_Wheeled_01_cannon_F"],
["O_APC_Wheeled_02_rcws_F","O_APC_Tracked_02_cannon_F","O_Truck_03_covered_F","O_Truck_03_transport_F","O_Truck_02_covered_F","O_Truck_02_transport_F"],
["I_Truck_02_covered_F","I_Truck_02_transport_F","I_G_Offroad_01_armed_F","I_APC_Wheeled_03_cannon_F","I_MRAP_03_F","I_APC_tracked_03_cannon_F","I_APC_tracked_03_cannon_F","I_MBT_03_cannon_F"],
["I_G_Van_01_transport_F","I_G_Offroad_01_armed_F","I_G_Offroad_01_F"]
];

ARMEDSTATIC = [
["B_static_AT_F","B_static_AA_F","B_HMG_01_F","B_HMG_01_high_F","B_GMG_01_F","B_GMG_01_high_F"],
["O_static_AT_F","O_static_AA_F","O_HMG_01_F","O_HMG_01_high_F","O_GMG_01_F","O_GMG_01_high_F"],
["I_static_AT_F","I_static_AA_F","I_HMG_01_F","I_HMG_01_high_F","I_GMG_01_F","I_GMG_01_high_F"],
["I_static_AT_F","I_static_AA_F","I_HMG_01_F","I_HMG_01_high_F","I_GMG_01_F","I_GMG_01_high_F"]
];

ARMEDSUPPORT = [
["B_Truck_01_ammo_F","B_Truck_01_fuel_F","B_Truck_01_medical_F","B_Truck_01_Repair_F"],
["O_Truck_02_box_F","O_Truck_02_medical_F","O_Truck_02_fuel_F","O_Truck_02_Ammo_F","O_Truck_03_repair_F","O_Truck_03_medical_F","O_Truck_03_fuel_F","O_Truck_03_ammo_F"],
["I_Truck_02_box_F","I_Truck_02_medical_F","I_Truck_02_fuel_F","I_Truck_02_Ammo_F"]
];

CIVVEH = ["C_Van_01_fuel_F","C_SUV_01_F","C_Van_01_box_F","C_Van_01_transport_F","C_Hatchback_01_sport_F","C_Hatchback_01_F","C_Offroad_01_F","C_Quadbike_01_F"];

AIRFIGTHER = [
["B_UAV_02_CAS_F","B_Plane_CAS_01_F"],
["O_UAV_02_F","O_Plane_CAS_02_F"],
["I_Plane_Fighter_03_AA_F","I_Plane_Fighter_03_CAS_F"],
["I_Plane_Fighter_03_AA_F","I_Plane_Fighter_03_CAS_F"]
];

AIRARMCHOP = [
["B_Heli_Attack_01_F","B_Heli_Light_01_armed_F"],
["O_Heli_Attack_02_F","O_Heli_Attack_02_black_F","O_Heli_Light_02_F"],
["I_Heli_light_03_F"],
["I_Heli_light_03_F"]
];
AIRCARRIERCHOP = [
["B_Heli_Transport_01_F","B_Heli_Light_01_F"],
["O_Heli_Light_02_unarmed_F"],
["I_Heli_Transport_02_F","I_Heli_light_03_unarmed_F"],
["I_Heli_light_03_unarmed_F"]
];
CRATECLAS = [
["Box_NATO_Ammo_F","Box_NATO_Wps_F","Box_NATO_Grenades_F","Box_NATO_WpsLaunch_F","Box_NATO_AmmoOrd_F","Box_NATO_WpsSpecial_F"]
,["Box_East_Grenades_F","Box_East_AmmoOrd_F","Box_East_Ammo_F","Box_East_WpsSpecial_F","Box_East_Wps_F"]
,["Box_IND_Ammo_F","Box_IND_Wps_F","Box_IND_Grenades_F","Box_IND_WpsLaunch_F","Box_IND_AmmoOrd_F","Box_IND_WpsSpecial_F"]
,["Box_FIA_Ammo_F","Box_FIA_Wps_F","Box_FIA_Support_F"]
];
};
if (isNil"FacOwnP") then {FacOwnP = [];};
if (isNil"StoOwnP") then {StoOwnP = [];};
if (isNil"FacMarkers") then {FacMarkers = ["Fac6","Fac5","Fac4","Fac3","Fac2","Fac1"];};
if (isNil"PowMarkers") then {PowMarkers = ["Power3","Power2","Power1"];};
if (isNil"StoMarkers") then {StoMarkers = ["Storage1"];};
if (isNil"PierMarkers") then {PierMarkers = ["Pier13","Pier12","Pier11","Pier10","Pier9","Pier8","Pier7","Pier6","Pier4","Pier3","Pier2","Pier1"];};
if (isNil"AIRFIELDLOCATIONS") then {AIRFIELDLOCATIONS = ["AirC","AirC_1","AirC_2","AirC_3","AirC_4","AirC_5"];};
_isWater = true;
_openH = true;
if (isServer) then {
{_x setMarkerShape "ICON";_x setmarkertype "u_installation";_x setmarkersize [0.7,0.7];} foreach FacMarkers;
{_x setMarkerShape "ICON";_x setmarkertype "loc_Power";_x setmarkersize [0.7,0.7];} foreach PowMarkers;
{_x setMarkerShape "ICON";_x setmarkertype "n_service";_x setmarkersize [0.7,0.7];} foreach StoMarkers;
{_x setMarkerShape "ICON";_x setmarkertype "loc_Quay";_x setmarkersize [0.7,0.7];} foreach PierMarkers;
{_x setMarkerColor "colorOrange";_x setMarkerType "Empty";_x setMarkerShape "ICON";_x setmarkertype "u_installation";_x setmarkersize [0.7,0.7]; _x setmarkertext " Airfield";} foreach AIRFIELDLOCATIONS;
if (worldname != "Altis") then {
waitUntil {!isNil"SAOKMAPDATA"};
_dat = (worldname CALL SAOKMAPDATA); 
_isWater = (_dat select 6);
_k = [];
{
if (count FacMarkers >= _foreachIndex) then {
_k set [count _k, (FacMarkers select _foreachIndex)];(FacMarkers select _foreachIndex) setmarkerpos _x;
_vil = createLocation ["NameLocal", [(_x select 0), (_x select 1)-3, 0], 100, 100];
_vil setText "factory";
} else {[_x,"Fac",""] CALL SAOKCREATESTPOINT;};
} foreach (_dat select 0);
{if !(_x in _k) then {FacMarkers = FacMarkers - [_x];deletemarker _x;};} foreach FacMarkers;
_k = [];
{
if (count StoMarkers >= _foreachIndex) then {_k set [count _k, (StoMarkers select _foreachIndex)];(StoMarkers select _foreachIndex) setmarkerpos _x;} else {[_x,"Sto",""] CALL SAOKCREATESTPOINT;};
} foreach (_dat select 1);
{if !(_x in _k) then {StoMarkers = StoMarkers - [_x];deletemarker _x;};} foreach StoMarkers;
_k = [];
{
if (count PierMarkers >= _foreachIndex) then {_k set [count _k, (PierMarkers select _foreachIndex)];(PierMarkers select _foreachIndex) setmarkerpos _x;};
} foreach (_dat select 2);
{if !(_x in _k) then {PierMarkers = PierMarkers - [_x];deletemarker _x;};} foreach PierMarkers;
if !(_isWater) then {{_x setmarkertype "loc_BusStop";} foreach PierMarkers;};
_k = [];
{
if (count PowMarkers >= _foreachIndex) then {_k set [count _k, (PowMarkers select _foreachIndex)];(PowMarkers select _foreachIndex) setmarkerpos _x;};
} foreach (_dat select 3);
{if !(_x in _k) then {PowMarkers = PowMarkers - [_x];deletemarker _x;};} foreach PowMarkers;
_k = [];
{
if (count AIRFIELDLOCATIONS >= _foreachIndex) then {_k set [count _k, (AIRFIELDLOCATIONS select _foreachIndex)];(AIRFIELDLOCATIONS select _foreachIndex) setmarkerpos _x;};
} foreach (_dat select 4);
{if !(_x in _k) then {AIRFIELDLOCATIONS = AIRFIELDLOCATIONS - [_x];deletemarker _x;};} foreach AIRFIELDLOCATIONS;
publicvariable "FacMarkers";
publicvariable "StoMarkers";
publicvariable "PierMarkers";
publicvariable "PowMarkers";
publicvariable "AIRFIELDLOCATIONS";
_boatinspos = (_dat select 5);
SAOKMAPSIZE = (_dat select 7);
publicvariable "SAOKMAPSIZE";
_openH = (_dat select 8);
};
};


CUSARRAY = [];
SaOkVehicleData = [];
CurTaskS = [];
ALLWalls = [];
if (isNil"VEHZONESA") then {VEHZONESA = [];};
UndAttackMs = [];
VisitedCamps = [];
CUTSCNS = [];

FUNKTIO_ECHO = compile preprocessfileLineNumbers "SoundEcho.sqf";
FPSGOOD = compileFinal preprocessfileLineNumbers "FPSGood.sqf";
AllP = [dataStorageS]+(playableUnits+switchableUnits);
RETURNRANDOM = compileFinal preprocessfileLineNumbers "ReturnRandom.sqf";
RandomP = compileFinal preprocessfileLineNumbers "RandomP.sqf";
AllPf = compileFinal preprocessfileLineNumbers "AllP.sqf";
DiagForCPS = compileFinal preprocessfileLineNumbers "DiagForCPS.sqf";
F_CorrectCar = compileFinal preprocessfileLineNumbers "CorrectCar.sqf";
PrestigeUpdate = compileFinal preprocessfileLineNumbers "PrestigeUpdate.sqf";
PrestigeS = compileFinal preprocessfileLineNumbers "PrestigeS.sqf";
ADDR = compileFinal preprocessfileLineNumbers "AddOwnRes.sqf";
DELGUARDPOST = compileFinal preprocessfileLineNumbers "DelGuardPost.sqf";
CopyOldGear = compileFinal preprocessfileLineNumbers "CopyOldGear.sqf";
TASK_CivKiller = compileFinal preprocessfileLineNumbers "MainTasks\CivKiller.sqf";
TASK_CivRobber = compileFinal preprocessfileLineNumbers "MainTasks\CivRobber.sqf";
TASK_ClearZone = compileFinal preprocessfileLineNumbers "MainTasks\ClearZone.sqf";
FPlayerFist = compile preprocessfileLineNumbers "PlayerFist.sqf";
FCRB2 = compile preprocessfileLineNumbers "CreateRoadBlock2.sqf";
FCRB2b = compile preprocessfileLineNumbers "CreateRoadBlock2b.sqf";
FUnitSay = compile preprocessfileLineNumbers "UnitSay.sqf";

CTreward = compile preprocessfileLineNumbers "CTreward.sqf";
FLoadCrate = compile preprocessfileLineNumbers "LoadCrate.sqf";
CVZ = compile preprocessfileLineNumbers "CreateVehZones.sqf";
CVZC = compile preprocessfileLineNumbers "CreateVehZonesC.sqf";
F_GREENROADBLOCK = compile preprocessfileLineNumbers "CreateRoadBlock2F.sqf";
TaskBlackList = [];

F_AIArtyVirtual = compileFinal preprocessfileLineNumbers "AIArtyVirtual.sqf";
F_CROWSANDBUGS = compileFinal preprocessfileLineNumbers "CrowsAndBugs.sqf";
CALL compileFinal preprocessfileLineNumbers "Funcs.sqf";
if !(isDedicated) then {_n = [] SPAWN F_CROWSANDBUGS;};

if !(isDedicated) then {
player setvariable ["OwnRes",1,true];
if ((paramsArray select 2) == 1) then {player setvariable ["OwnRes",10000,true];};
[] SPAWN {
PlayerKilled = compileFinal preprocessfileLineNumbers "PlayerKilled.sqf";
_EHkilledIdx = player addEventHandler ["killed", {_this SPAWN PlayerKilled}];
player setvariable ["LastVeh", vehicle player];
while {true} do {
if (random 1 < 0.1) then {
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
};
sleep 5;
if (vehicle player != player && {player == leader player} && {!(vehicle player iskindof "Paraglide")} && {(player getvariable "LastVeh") != vehicle player}) then {player setvariable ["LastVeh", vehicle player,true];"Vehicle marked as owned (1 max at time) - Can be locked now with Y-key while outside" SPAWN HINTSAOK;};
sleep 5;
if (vehicle player != player && {player == leader player} && {!(vehicle player iskindof "Paraglide")} && {(player getvariable "LastVeh") != vehicle player}) then {player setvariable ["LastVeh", vehicle player,true];"Vehicle marked as owned (1 max at time) - Can be locked now with Y-key while outside" SPAWN HINTSAOK;};
sleep 5;
if (vehicle player != player && {player == leader player} && {!(vehicle player iskindof "Paraglide")} && {(player getvariable "LastVeh") != vehicle player}) then {player setvariable ["LastVeh", vehicle player,true];"Vehicle marked as owned (1 max at time) - Can be locked now with Y-key while outside" SPAWN HINTSAOK;};
sleep 5;
if (vehicle player != player && {player == leader player} && {!(vehicle player iskindof "Paraglide")} && {(player getvariable "LastVeh") != vehicle player}) then {player setvariable ["LastVeh", vehicle player,true];"Vehicle marked as owned (1 max at time) - Can be locked now with Y-key while outside" SPAWN HINTSAOK;};
if (!isNil"LIIKUTAOBJEKTI") then {LIIKUTAOBJEKTI = nil;};
RANDOMTIP = ["Fast Travel - SHIFT + 1","Flip/Unstuck Empty Vehicle - Shift + 4","High Command UI - Ctrl + Space (TEAM-LEADER)","Use ARSENAL near Camp for Custom Gear","Pick up items from houses - Y","Call Support - SHIFT + 1 (TEAM-LEADER or Rights)","Open Map/Briefing - M","Tasks - J","Player Rights - Shift + 1 (TEAM-LEADER)","Construction View - Shift + C (TEAM-LEADER or Rights)","Steal Car/Lock Car/Take Objects - Y","Load Crates to Truck - SHIFT + 9 (TEAM-LEADER or Rights)"] call RETURNRANDOM;
};
};
};


if (isServer) then {
VEHZONES = [];
CVZ = compile preprocessfileLineNumbers "CreateVehZones.sqf";
SUPF = 1;
AMBbattles = [];
TASK_VilPOWs = compileFinal preprocessfileLineNumbers "VillageTasks\TaskVilPOWs.sqf";
TASK_Convoy = compileFinal preprocessfileLineNumbers "MainTasks\Convoy.sqf";
TASK_ClearZone = compileFinal preprocessfileLineNumbers "MainTasks\ClearZone.sqf";
TASK_GreenAirZonesArrive = compileFinal preprocessfileLineNumbers "MainTasks\GreenAirZonesArrive.sqf";
TASK_GreenZonesArrive = compileFinal preprocessfileLineNumbers "MainTasks\GreenZonesArrive.sqf";
TASK_BlueZonesArrive = compileFinal preprocessfileLineNumbers "MainTasks\BlueZonesArrive.sqf";

SaOkmissionnamespace setvariable ["Progress",["ResHelp"],true];
[] SPAWN {
FACTORYLOCATIONS = [];
{if (text _x == "factory") then {FACTORYLOCATIONS set [count FACTORYLOCATIONS,_x];};} foreach (nearestLocations [getmarkerpos "Fac4", ["NameLocal"], 20000]);
publicVariable "FACTORYLOCATIONS";
sleep 1;
};
};
//if ((paramsArray select 0) == 0) then {DebugiMoode = nil;};

//b_service
InitFuncs = compileFinal preprocessfileLineNumbers "InitFuncs.sqf";
if (!isDedicated) then {11 SPAWN InitFuncs;};
StealOrTake = compileFinal preprocessfileLineNumbers "StealOrTake.sqf";
SAVECRATE=compileFinal preprocessfileLineNumbers "SaveCrate.sqf";
CBIRDS = 0;
IntelMarker = compileFinal preprocessfileLineNumbers "IntelMarker.sqf";
FUNKTIO_CROW=compile preprocessfileLineNumbers "Crows.sqf";

BirdFunc3 = compileFinal preprocessfileLineNumbers "BirdFunc3.sqf";
BirdFunc2 = compileFinal preprocessfileLineNumbers "BirdFunc2.sqf";
BirdFunc1 = compileFinal preprocessfileLineNumbers "BirdFunc1.sqf";
ScaredBirds=compileFinal preprocessfileLineNumbers "ScaredBirds.sqf";
ScaredBirdsOnce=compileFinal preprocessfileLineNumbers "ScaredBirdsOnce.sqf";
ScaredBirdsTank=compileFinal preprocessfileLineNumbers "ScaredBirdsTank.sqf";
FUNKTIO_SPAWNACTOR=compileFinal preprocessfileLineNumbers "SpawnActor.sqf";
CONSCOST=compileFinal preprocessfileLineNumbers "ConsCost.sqf";
SUPPORTCOST=compileFinal preprocessfileLineNumbers "SupportCost.sqf";
SPAWNVEHICLE=compileFinal preprocessfileLineNumbers "SpawnVehicle.sqf";
NEARESTFACTORY=compileFinal preprocessfileLineNumbers "NearestFactory.sqf";
NEARESTAIRFIELD=compileFinal preprocessfileLineNumbers "NearestAirfield.sqf";
NEARESTGUARDPOST=compileFinal preprocessfileLineNumbers "NearestGuardPost.sqf";
FUNKTIO_POS=compileFinal preprocessfileLineNumbers "findPos.sqf";
RETURNRANDOM = compileFinal preprocessfileLineNumbers "ReturnRandom.sqf";
NEARESTLOCATIONNAME=compileFinal preprocessfileLineNumbers "NearestLocationName.sqf";


InfFromHouse =compileFinal preprocessfileLineNumbers "InfFromHouse.sqf";
ConvertToArmedCivilianL =compileFinal preprocessfileLineNumbers "ConvertToArmedCivilianL.sqf";
ConvertToArmedCivilian =compileFinal preprocessfileLineNumbers "ConvertToArmedCivilian.sqf";
FMusic =compileFinal preprocessfileLineNumbers "Music.sqf";
FDefendCounterAttack =compileFinal preprocessfileLineNumbers "MainTasks\DefendCounterAttack.sqf";
FDefendFactory =compileFinal preprocessfileLineNumbers "MainTasks\DefendFactory.sqf";
FDefendSupply =compileFinal preprocessfileLineNumbers "MainTasks\DefendSupply.sqf";
FAttackRandom =compileFinal preprocessfileLineNumbers "MainTasks\AttackRandom.sqf";
FDefendRandom =compileFinal preprocessfileLineNumbers "MainTasks\DefendRandom.sqf";
FHaloJump =compileFinal preprocessfileLineNumbers "HaloJump.sqf";
FLandTransportToPatrol =compileFinal preprocessfileLineNumbers "LandTransportToPatrol.sqf";
FAlarmEvents =compileFinal preprocessfileLineNumbers "AlarmEvents.sqf";
FSupportDrop =compileFinal preprocessfileLineNumbers "SupportDrop.sqf";
FCarAlarmLights =compileFinal preprocessfileLineNumbers "CarAlarmLights.sqf";
FWreckOnRoad =compileFinal preprocessfileLineNumbers "WreckOnRoad.sqf";
FSlowChopperSupport =compileFinal preprocessfileLineNumbers "SlowChopperSupport.sqf";
FSlowChopperSupportE =compileFinal preprocessfileLineNumbers "SlowChopperSupportE.sqf";
FSlowChopperSupportF =compileFinal preprocessfileLineNumbers "SlowChopperSupportF.sqf";
FConsUndo =compileFinal preprocessfileLineNumbers "ConsUndo.sqf";
FConversationDialog =compileFinal preprocessfileLineNumbers "ConversationDialog.sqf";
FMoveHCs =compileFinal preprocessfileLineNumbers "MoveHCs.sqf";
FCIVCASULTIE =compileFinal preprocessfileLineNumbers "CIVCASULTIE.sqf";
FENEMYCASULTIE =compileFinal preprocessfileLineNumbers "ENEMYCASULTIE.sqf";
FSmokeSignal =compileFinal preprocessfileLineNumbers "SmokeSignal.sqf";
FvehicleStucked2 =compileFinal preprocessfileLineNumbers "vehicleStucked2.sqf";
FJumpOffCar =compileFinal preprocessfileLineNumbers "JumpOffCar.sqf";

FSideTasks =compileFinal preprocessfileLineNumbers "SideTasks.sqf";
FBuyVehicle =compileFinal preprocessfileLineNumbers "BuyVehicle.sqf";
FBuyMen =compileFinal preprocessfileLineNumbers "BuyMen.sqf";
FJumpOff =compileFinal preprocessfileLineNumbers "JumpOff.sqf";

FMoveAndDelete =compileFinal preprocessfileLineNumbers "MoveAndDelete.sqf";
FMoveAwayAndGetDeleted =compileFinal preprocessfileLineNumbers "MoveAwayAndGetDeleted.sqf";
FSmokeAr =compileFinal preprocessfileLineNumbers "SmokeAr.sqf";

FAirSupport =compileFinal preprocessfileLineNumbers "AirSupport.sqf";
FLandSupport =compileFinal preprocessfileLineNumbers "LandSupport.sqf";
FGearSupport =compileFinal preprocessfileLineNumbers "GearSupport.sqf";
FSupport =compileFinal preprocessfileLineNumbers "Support.sqf";

FTrashCan =compileFinal preprocessfileLineNumbers "TrashCan.sqf";
FTrashCan2 =compileFinal preprocessfileLineNumbers "TrashCan2.sqf";

FChopperTransportP =compileFinal preprocessfileLineNumbers "ChopperTransportP.sqf";



VehicleArrivalA = compileFinal preprocessfileLineNumbers "VehicleArrivalA.sqf";
VehicleArrival = compileFinal preprocessfileLineNumbers "VehicleArrival.sqf";
POWcell = compileFinal preprocessfileLineNumbers "POWcell.sqf";



FUNKTIO_SPAWNACTOR=compileFinal preprocessfileLineNumbers "SpawnActor.sqf";
CONSCOST=compileFinal preprocessfileLineNumbers "ConsCost.sqf";
SUPPORTCOST=compileFinal preprocessfileLineNumbers "SupportCost.sqf";
SPAWNVEHICLE=compileFinal preprocessfileLineNumbers "SpawnVehicle.sqf";
NEARESTFACTORY=compileFinal preprocessfileLineNumbers "NearestFactory.sqf";
NEARESTAIRFIELD=compileFinal preprocessfileLineNumbers "NearestAirfield.sqf";
NEARESTLOCATIONNAME = compileFinal preprocessfileLineNumbers "NearestLocationName.sqf";
//FUNKTIO_POS=compileFinal preprocessfileLineNumbers "findPosSimple.sqf";

if (isNil"AmbientCiv") then {AmbientCiv = [];};
if (isNil"AmbientZones") then {AmbientZones = [];};
if (isNil"AmbientCivN") then {AmbientCivN = [];};
if (isNil"AmbientZonesN") then {AmbientZonesN = [];};
FORTRESSESMM = [];
CantCommand = [];



FStatusWLA=compileFinal preprocessfileLineNumbers "StatusWLA.sqf";
FGatherAIs=compileFinal preprocessfileLineNumbers "GatherAIs.sqf";
Fbriefing=compileFinal preprocessfileLineNumbers "briefing.sqf";
_nul = [] SPAWN Fbriefing;
FORTRESSESVAR = [];
AddWall = compileFinal preprocessfileLineNumbers "AddWall.sqf";
AddFortress = compileFinal preprocessfileLineNumbers "AddFortress.sqf";


GUARDPOSTCLIENT = compileFinal preprocessfileLineNumbers "GuardPostClient.sqf";
RETURNGUARDPOST = compileFinal preprocessfileLineNumbers "ReturnGuardPost.sqf";
LUOKKANIMI = compileFinal preprocessfileLineNumbers "LuokkaNimi.sqf";
KAUPPA = compileFinal preprocessfileLineNumbers "Kauppa.sqf";
KAUPPAVILLAGE = compileFinal preprocessfileLineNumbers "KauppaVillage.sqf";
OSTAMASSA = compileFinal preprocessfileLineNumbers "Ostamassa.sqf";
AmbientScoutCar=compileFinal preprocessfileLineNumbers "AmbientScoutCar.sqf";
EnemySupport=compileFinal preprocessfileLineNumbers "EnemySupport.sqf";
FriendlySupport=compileFinal preprocessfileLineNumbers "FriendlySupport.sqf";
MusicT=compileFinal preprocessfileLineNumbers "Music.sqf";
WLADialog = compileFinal preprocessfileLineNumbers "WLADialog.sqf";
F_FastTravelDialog = compileFinal preprocessfileLineNumbers "FastTravelDialog.sqf";

AICampBehaviour= compileFinal preprocessfileLineNumbers "AICampBehaviourNEW.sqf";


CONVERSATIONWITHCIVILIANS = compile preprocessfileLineNumbers "ConversationWithCivilians.sqf";
CONVERSATIONWITHSOLDIERS = compile preprocessfileLineNumbers "ConversationWithSoldiers.sqf";
CONVERSATIONWITHSURRENDERED = compile preprocessfileLineNumbers "ConversationWithSurrendered.sqf";
SOLDIERSTASKS = compile preprocessfileLineNumbers "MilitaryTasks\SoldierTasks.sqf";
PowInfo = compile preprocessfileLineNumbers "PowInfo\PowInfo.sqf";
FConversationDialogSol =compile preprocessfileLineNumbers "ConversationDialogSol.sqf";
FConversationDialogSur =compile preprocessfileLineNumbers "ConversationDialogSur.sqf";
FUNKTIO_NATORUS = compile preprocessfileLineNumbers "NatoRusWeapon.sqf";

F_KGSNED = compile preprocessfileLineNumbers "KeepGSpawned.sqf";
PRESTIGECHANGE = compileFinal preprocessfileLineNumbers "PrestigeChange.sqf";
if (isNil"pisteet") then {pisteet = 1300;};
if (isNil"pisteetE") then {pisteetE = 300;};
//MORE VILLAGES
[] SPAWN {
_vil = createLocation ["NameVillage", [3814.11,11132.7,0], 100, 100];
_vil setText "Zacharo";
_vil = createLocation ["NameVillage", [3996.38,12405.4,0], 100, 100];
_vil setText "Kiparissia";
_vil = createLocation ["NameVillage", [4731.11,10414.4,0], 100, 100];
_vil setText "Lalas";
_vil = createLocation ["NameVillage", [3630.57,14433.3,0], 100, 100];
_vil setText "Foloi";
_vil = createLocation ["NameVillage", [4688.75,14197.8,0], 100, 100];
_vil setText "Krestena";
_vil = createLocation ["NameVillage", [6088.86,15129.1,0], 100, 100];
_vil setText "Oleni";
_vil = createLocation ["NameVillage", [6775.5,15686.8,0], 100, 100];
_vil setText "Gargaliani";
_vil = createLocation ["NameVillage", [7754.13,16161.4,0], 100, 100];
_vil setText "Epitalio";
_vil = createLocation ["NameVillage", [4330.62,16606.2,0], 100, 100];
_vil setText "Dafni";
_vil = createLocation ["NameVillage", [5101.09,16628.5,0], 100, 100];
_vil setText "Tolo";
_vil = createLocation ["NameVillage", [3750.54,17823.6,0], 100, 100];
_vil setText "Limnes";
_vil = createLocation ["NameVillage", [17292.8,13503.9,0], 100, 100];
_vil setText "Nemea";

_p = getmarkerpos "fac5";
_vil = createLocation ["NameLocal", [(_p select 0), (_p select 1)-3, 0], 100, 100];
_vil setText "factory";
_p = getmarkerpos "fac6";
_vil = createLocation ["NameLocal", [(_p select 0), (_p select 1)-3, 0], 100, 100];
_vil setText "factory";
};

if !(isDedicated) then {
[] SPAWN {
sleep 320+(random 220); 
[["WLA","Prestige"]] call BIS_fnc_advHint;
sleep 320+(random 220); 
[["WLA","OptionalTasks"]] call BIS_fnc_advHint;
sleep 320+(random 220); 
[["WLA","Surrendering"]] call BIS_fnc_advHint;
};
//UP PAR
_nul = [] spawn {
while {true} do {
_s = 7 SPAWN InitFuncs;
waitUntil {sleep 3;scriptdone _s};

};
};

//SCORE PAR
_nul = [] spawn {
while {true} do {
_s = 8 SPAWN InitFuncs;
waitUntil {sleep 3;scriptdone _s};

};
};
};
if (isServer) then {
F_AmbientArmedCivsNEW = compileFinal preprocessfileLineNumbers "AmbientArmedCivsNEW.sqf";
_nul = [] SPAWN F_AmbientArmedCivsNEW;
};


//NEAR VILLAGE/CAMP INFO
NEARESTPLACE=compileFinal preprocessfileLineNumbers "NearestPlace.sqf";
NEARESTVILLAGE=compileFinal preprocessfileLineNumbers "NearestVillage.sqf";
NEARESTCAMP=compileFinal preprocessfileLineNumbers "NearestCamp.sqf";
NEARESTVILLAGERELATIONSHIP=compileFinal preprocessfileLineNumbers "nearestVillageRelationship.sqf";

if !(isDedicated) then {
_nul = [] spawn {
while {true} do {
_s = 10 SPAWN InitFuncs;
waitUntil {sleep 3;scriptdone _s};
};
};

//CIVILIAN NEAR
if (side player == WEST) then {
_nul = [] spawn {
while {true} do {
_s = 9 SPAWN InitFuncs;
waitUntil {sleep 3;scriptdone _s};
};
};
};
};
FUNKTIO_CIVCASULTIE = compileFinal preprocessfileLineNumbers "CIVCASULTIE.sqf";



if (isNil"GuardPosts") then {GuardPosts = [];};

FChopperTransport = compileFinal preprocessfileLineNumbers "ChopperTransport.sqf";
FLandTransport = compileFinal preprocessfileLineNumbers "LandTransport.sqf";
FUNKTIO_LandTransportE=compile preprocessfileLineNumbers "LandTransportE.sqf";
FUNKTIO_LandTransportF=compile preprocessfileLineNumbers "LandTransportF.sqf";
FUNKTIO_LandTransport=compile preprocessfileLineNumbers "LandTransport.sqf";
FLandTransportToPatrol =compile preprocessfileLineNumbers "LandTransportToPatrol.sqf";
FChopperTransportF = compileFinal preprocessfileLineNumbers "ChopperTransportF.sqf";

FORTRESSESVAR = [];
AddFortress = compileFinal preprocessfileLineNumbers "AddFortress.sqf";

GUARDPOST = compileFinal preprocessfileLineNumbers "GuardPost.sqf";
RETURNGUARDPOST = compileFinal preprocessfileLineNumbers "ReturnGuardPost.sqf";
LUOKKANIMI = compileFinal preprocessfileLineNumbers "LuokkaNimi.sqf";
KAUPPA = compileFinal preprocessfileLineNumbers "Kauppa.sqf";
KAUPPAVILLAGE = compileFinal preprocessfileLineNumbers "KauppaVillage.sqf";
OSTAMASSA = compileFinal preprocessfileLineNumbers "Ostamassa.sqf";

EnemySupport=compileFinal preprocessfileLineNumbers "EnemySupport.sqf";
FriendlySupport=compileFinal preprocessfileLineNumbers "FriendlySupport.sqf";
MusicT=compileFinal preprocessfileLineNumbers "Music.sqf";




FUNKTIO_AccTimeAndWeather = compileFinal preprocessfileLineNumbers "AccTimeAndWeather.sqf";
_nul = [] SPAWN FUNKTIO_AccTimeAndWeather;

FUNKTIO_ENEMYCASULTIE = compileFinal preprocessfileLineNumbers "ENEMYCASULTIE.sqf";
FUNKTIO_CIVCASULTIE = compileFinal preprocessfileLineNumbers "CIVCASULTIE.sqf";



//New variables for EnemyTacticLevel.fsm system
SMOKEAR = [0,0,0];
CHOPAVAIL = true;
Pgroups = [];
CantCommand = [];
HeliGroups = [];
CampGroups = [];
VehicleGroups = [];
NAPAveh = [];
VARCoLoop = true;
FriendlyVehicles=[];
FriendlyAir=[];
FriendlyInf=[];
CIVIGNORE = [];
//////Other new variables to handle increasing difficulty level/other changing features through mission
//MAX
EVEHMAX = 1;
FVEHMAX = 1;
FINFMAX = 1;
//places for enemy to attack (0 - NAPA, 1 - CDF, the faction under attack)
VarPlaces = [];
//allow NAPA reinforcements join to player team
VarAllowReInf = false;
//how many russian patrols (in war time)
VarPGRus = 0;
//how many enemy patrols
VarPG = 4;
//how much units in patrol (min and max)
VarPGSize =[3,4];
//enemy use chopper transport
VarTRChop = true;
//enemy send fighters
VarAIR = true;
//vehicle classes that enemy may as slow reinf . "O_MBT_02_arty_F" "O_APC_Tracked_02_AA_F" "O_MBT_02_cannon_F"
VarReUnits = 4;
//~Total number of enemy units in random camps/towers
VarReEnemies = 17;
//How often enemy uses artillery
VarArty = 0;
//How much NAPA friendly help (10 is full)
VarFS = 6;
//Friendly fighters
VarAIRF = false;
//How much CDF friendly help (10 is full)
VarFS2 = 6;
//How much CZ friendly help
VarFS3 = 6;
//Black list for friendly spawn
VarBlackListF = [];
//Enemy resources for vehicles
VarRes = 1;
//Black list for enemy spawn
VarBlackListE = [];

// Do Not Change - Variables
// init.sqf file
if (isNil"ENEMYC1") then {
ENEMYC1 = ["O_Soldier_AAR_F","O_Soldier_AAA_F","O_Soldier_AAT_F","O_Soldier_A_F","O_Soldier_AR_F","O_medic_F","O_engineer_F","O_soldier_exp_F","O_Soldier_GL_F","O_soldier_M_F","O_Soldier_AA_F","O_Soldier_AT_F","O_officer_F","O_soldier_repair_F","O_Soldier_F","O_Soldier_LAT_F","O_Soldier_lite_F","O_Soldier_SL_F","O_Soldier_TL_F","O_spotter_F","O_sniper_F"];
ENEMYC2 = ["O_recon_exp_F","O_recon_JTAC_F","O_recon_M_F","O_recon_medic_F","O_recon_F","O_recon_LAT_F","O_recon_TL_F"];
ENEMYC3 = ["O_soldierU_A_F","O_soldierU_AAR_F","O_soldierU_AAT_F","O_soldierU_AAA_F","O_soldierU_AR_F","O_soldierU_medic_F","O_engineer_U_F","O_soldierU_exp_F","O_SoldierU_GL_F","O_soldierU_M_F","O_soldierU_AA_F","O_soldierU_AT_F","O_soldierU_repair_F","O_soldierU_LAT_F","O_SoldierU_SL_F","O_soldierU_TL_F"];
FRIENDC1 = ["B_soldier_AAR_F","B_soldier_AAA_F","B_soldier_AAT_F","b_sniper_f","b_spotter_f","B_Soldier_A_F","B_soldier_AR_F","B_medic_F","B_engineer_F","B_soldier_exp_F","B_Soldier_GL_F","B_soldier_M_F","B_soldier_AA_F","B_soldier_AT_F","B_soldier_repair_F","B_soldier_repair_F","B_Soldier_F","B_soldier_LAT_F","B_Soldier_lite_F","B_Soldier_SL_F","B_Soldier_TL_F"];
FRIENDC2 = ["I_G_Soldier_A_F","I_G_Soldier_AR_F","I_G_medic_F","I_G_engineer_F","I_G_Soldier_exp_F","I_G_Soldier_GL_F","I_G_Soldier_M_F","I_G_officer_F","I_G_Soldier_F","I_G_Soldier_LAT_F","I_G_Soldier_lite_F","I_G_Soldier_SL_F","I_G_Soldier_TL_F"];
FRIENDC3 = ["B_recon_JTAC_F","B_recon_exp_F","B_recon_M_F","B_recon_medic_F","B_recon_F","B_recon_LAT_F","B_recon_TL_F"];
FRIENDC4 = ["I_G_Soldier_A_F","I_G_Soldier_AR_F","I_G_medic_F","I_G_engineer_F","I_G_Soldier_exp_F","I_G_Soldier_GL_F","I_G_Soldier_M_F","I_G_officer_F","I_G_Soldier_F","I_G_Soldier_LAT_F","I_G_Soldier_lite_F","I_G_Soldier_SL_F","I_G_Soldier_TL_F"];
CIVS1 = ["C_man_p_fugitive_F_afro","C_man_p_beggar_F_afro","C_man_polo_1_F_afro","C_man_polo_2_F_afro","C_man_polo_3_F_afro","C_man_polo_4_F_afro","C_man_polo_5_F_afro","C_man_polo_6_F_afro","C_man_shorts_1_F_afro","C_man_p_shorts_1_F_afro","C_man_shorts_2_F_afro","C_man_shorts_3_F_afro","C_man_shorts_4_F_afro","C_man_p_beggar_F_asia","C_man_polo_1_F_asia","C_man_polo_2_F_asia","C_man_polo_3_F_asia","C_man_polo_4_F_asia","C_man_polo_5_F_asia","C_man_polo_6_F_asia","C_man_shorts_1_F_asia","C_man_p_fugitive_F_asia","C_man_p_shorts_1_F_asia","C_man_shorts_2_F_asia","C_man_shorts_3_F_asia","C_man_shorts_4_F_asia","C_man_p_beggar_F","C_man_1","C_man_polo_1_F","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F","C_man_polo_5_F","C_man_polo_6_F","C_man_shorts_1_F","C_man_1_1_F","C_man_1_2_F","C_man_1_3_F","C_man_p_fugitive_F","C_man_p_shorts_1_F","C_man_hunter_1_F","C_man_shorts_2_F","C_man_shorts_3_F","C_man_shorts_4_F","C_man_w_worker_F","C_Nikos","C_Orestes","C_man_p_beggar_F_euro","C_man_polo_1_F_euro","C_man_polo_2_F_euro","C_man_polo_3_F_euro","C_man_polo_4_F_euro","C_man_polo_5_F_euro","C_man_polo_6_F_euro","C_man_shorts_1_F_euro","C_man_p_fugitive_F_euro","C_man_p_shorts_1_F_euro","C_man_shorts_2_F_euro","C_man_shorts_3_F_euro","C_man_shorts_4_F_euro"];
};
InfoBad = {
private ["_c"];
_c = [];
{if !(isClass(configFile >> "cfgVehicles" >> _x)) then {hint _x;};} foreach _this;
_c
};

[] SPAWN {
private ["_remBad"];
_remBad = {
private ["_c"];
_c = [];
{if (isClass(configFile >> "cfgVehicles" >> _x)) then {_c pushback _x;};} foreach _this;
_c
};
CIVS1 = CIVS1 CALL _remBad;
ENEMYC1 = ENEMYC1 CALL _remBad;
ENEMYC2 = ENEMYC2 CALL _remBad;
ENEMYC3 = ENEMYC3 CALL _remBad;
FRIENDC1 = FRIENDC1 CALL _remBad;
FRIENDC2 = FRIENDC2 CALL _remBad;
FRIENDC3 = FRIENDC3 CALL _remBad;
FRIENDC4 = FRIENDC4 CALL _remBad;
};



NUMM=0;
DONTDELGROUPS = [group BaseR];
CARS = [];



FUNKTIO_AmbientCarCIV = compileFinal preprocessfileLineNumbers "AmbientCarCIV.sqf";










FUNKTIO_LOSOBJ = compileFinal preprocessfileLineNumbers "LOSpos.sqf";
FUNKTIO_DELUNIT = compileFinal preprocessfileLineNumbers "DeleteUnit.sqf";



FUNKTIO_IL = compileFinal preprocessfileLineNumbers "InitLoop1.sqf";
FUNKTIO_IL2 = compileFinal preprocessfileLineNumbers "InitLoop2.sqf";
FUNKTIO_IL3 = compileFinal preprocessfileLineNumbers "InitLoop3.sqf";
FUNKTIO_AmbientPatrol = compileFinal preprocessfileLineNumbers "AmbientPatrol.sqf";
FUNKTIO_DelayVehRem=compileFinal preprocessfileLineNumbers "DelayVehicleRemoval.sqf";
FUNKTIO_CREATEMARKER=compileFinal preprocessfileLineNumbers "CreateMarker.sqf";
FUNKTIO_CREATEMARKERL=compileFinal preprocessfileLineNumbers "CreateMarkerL.sqf";
FUNKTIO_SPAWNACTOR=compileFinal preprocessfileLineNumbers "SpawnActor.sqf";



FUNKTIO_AISMOKE=compileFinal preprocessfileLineNumbers "AIsmoke.sqf";
FUNKTIO_AIFLARE=compileFinal preprocessfileLineNumbers "AIflare.sqf";
FUNKTIO_VS=compileFinal preprocessfileLineNumbers "vehicleStucked.sqf";
FUNKTIO_GM2=compileFinal preprocessfileLineNumbers "GroupMarker2.sqf";
FUNKTIO_GM=compileFinal preprocessfileLineNumbers "GroupMarker.sqf";
FUNKTIO_MAD=compileFinal preprocessfileLineNumbers "MoveAndDelete.sqf";
FUNKTIO_MAAGD=compileFinal preprocessfileLineNumbers "MoveAwayAndGetDeleted.sqf";
FUNKTIO_TM=compileFinal preprocessfileLineNumbers "TimedMarker.sqf";
FUNKTIO_CL=compileFinal preprocessfileLineNumbers "ContactLoop.sqf";








FUNKTIO_POISTAKARRY=compileFinal preprocessfileLineNumbers "CarRemoval.sqf";

FUNKTIO_ANTAUDU=compileFinal preprocessfileLineNumbers "UnitSurrender.sqf"; 
FUNKTIO_POISTANTAUTUNUT=compileFinal preprocessfileLineNumbers "SurrenderedRemoval.sqf"; 
FUNKTIO_FireSmokeEffect=compileFinal preprocessfileLineNumbers "FireSmokeEffect.sqf"; 
FUNKTIO_FLIES=compileFinal preprocessfileLineNumbers "Flies.sqf";
FUNKTIO_ThrowObject2 = compileFinal preprocessfileLineNumbers "ThrowObject2.sqf";

FUNKTIO_BlackListMarkers=compileFinal preprocessfileLineNumbers "BlackListMarkers.sqf";
Bpositions = [];
// Modify freely - Variables
MAXCARS=5;
_nul = [] SPAWN compile preprocessfileLineNumbers "HouseStuff.sqf";
// Dont change
sleep 3;
[WEST,startD] call BIS_fnc_addRespawnPosition;
FUNKTIO_DrawCircle=compileFinal preprocessfileLineNumbers "DrawCircle.sqf";
FUNKTIO_DrawFence=compileFinal preprocessfileLineNumbers "DrawFence.sqf";
FUNKTIO_DrawBox=compileFinal preprocessfileLineNumbers "DrawBox.sqf";
FUNKTIO_DrawCircleV=compileFinal preprocessfileLineNumbers "DrawCircleV.sqf";
FUNKTIO_DrawFenceV=compileFinal preprocessfileLineNumbers "DrawFenceV.sqf";
FUNKTIO_DrawFenceCV=compileFinal preprocessfileLineNumbers "DrawFenceCV.sqf";
FUNKTIO_DrawBoxV=compileFinal preprocessfileLineNumbers "DrawBoxV.sqf";
FDraw = compileFinal preprocessfileLineNumbers "Draw.sqf";
FDrawBuy = compileFinal preprocessfileLineNumbers "DrawBuy.sqf";
if (isServer) then {
FUNKTIO_Commander=compileFinal preprocessfileLineNumbers "Commander.sqf";
};
FUNK_PlayerRightsDialog = compileFinal preprocessfileLineNumbers "PlayerRightsDialog.sqf";
ChopperTransportPara = compileFinal preprocessfileLineNumbers "ChopperTransportPara.sqf";
FUNK_WaitTime = compileFinal preprocessfileLineNumbers "WaitTime.sqf";
FUNK_ConstructionDialog = compileFinal preprocessfileLineNumbers "ConstructionDialog.sqf";
FUNK_SupportDialog = compileFinal preprocessfileLineNumbers "SupportDialog.sqf";
if !(isDedicated) then {
_nul = [] SPAWN compileFinal preprocessfileLineNumbers "HouseStuff.sqf";
FUNKTIO_AfterLoading=compileFinal preprocessfileLineNumbers "AfterLoading.sqf";
_id = addMissionEventHandler ["loaded",{_n = [] SPAWN FUNKTIO_AfterLoading;}];
_n = [] SPAWN FUNKTIO_AfterLoading;
};
TaskPOW = compileFinal preprocessfileLineNumbers "TaskPOW.sqf";
TaskCrate = compileFinal preprocessfileLineNumbers "TaskCrate.sqf";
TaskEscord = compileFinal preprocessfileLineNumbers "TaskEscord.sqf";
TaskFindRes = compileFinal preprocessfileLineNumbers "TaskFindRes.sqf";
TaskFortress = compileFinal preprocessfileLineNumbers "TaskFortress.sqf";
TaskGuardPost = compileFinal preprocessfileLineNumbers "TaskGuardPost.sqf";
TaskRepair = compileFinal preprocessfileLineNumbers "TaskRepair.sqf";
TaskWater = compileFinal preprocessfileLineNumbers "TaskWater.sqf";
FLoadCrate = compileFinal preprocessfileLineNumbers "LoadCrate.sqf";
_nul = [] SPAWN compile preprocessfileLineNumbers "AmbientGuardPost.sqf"; 
FUNKTIO_IGNORETIMED = compileFinal preprocessfileLineNumbers "IgnoreTimed.sqf";
if (isServer) then {
_nul = [] SPAWN compile preprocessfileLineNumbers "AmbientFortress.sqf";
_nul = [] SPAWN compile preprocessfileLineNumbers "ambientzone.sqf";
if (paramsArray select 10 == 1) then {_nul = [] SPAWN compile preprocessfileLineNumbers "AmbientWalls.sqf";};
_nul = [] SPAWN compile preprocessfileLineNumbers "AmbientRoadBlocks.sqf";
_nul = [] SPAWN compile preprocessfileLineNumbers "BattleVirtual.sqf";
_nul = [] SPAWN compile preprocessfileLineNumbers "TrashyCar.sqf";
_nul = [] SPAWN compile preprocessfileLineNumbers "AmbientBattles.sqf";
_nul = [] SPAWN compile preprocessfileLineNumbers "Traffic.sqf";
_nul = [] SPAWN compile preprocessfileLineNumbers "AmbientPersianPrestige.sqf";
_nul = [] SPAWN compile preprocessfileLineNumbers "AmbientHouseEffects.sqf";
_nul = [] SPAWN compile preprocessfileLineNumbers "ambientcivilians4.sqf";
_nul = [] SPAWN compile preprocessfileLineNumbers "ambientcivilians5NEW.sqf";
_nul = [] SPAWN compile preprocessfileLineNumbers "ambientReinforcements.sqf";
_nul = [] SPAWN compile preprocessfileLineNumbers "AmbientCamps.sqf";
_nul = [] SPAWN compile preprocessfileLineNumbers "EnemyTacticLevel.sqf";
_nul = [] SPAWN compile preprocessfileLineNumbers "AmbientVehicleZone.sqf";
_nul = [] SPAWN compile preprocessfileLineNumbers "ambientanimals3.sqf";
_nul = [] SPAWN compile preprocessfileLineNumbers "Events\TimedEvents.sqf";
_n = [] SPAWN compile preprocessfileLineNumbers "AmbientParkedCars.sqf";
_n = [] SPAWN compile preprocessfileLineNumbers "VehicleStorage.sqf";
BattleVirtualCamp = compileFinal preprocessfileLineNumbers "BattleVirtualCamp.sqf";
BattleVirtualIntel = compileFinal preprocessfileLineNumbers "BattleVirtualIntel.sqf";
ZoneMove = compileFinal preprocessfileLineNumbers "ZoneMove.sqf";
CarAlarm = compileFinal preprocessfileLineNumbers "CarAlarm.sqf";
GuardPostSide = compileFinal preprocessfileLineNumbers "GuardPostSide.sqf";
FireSmoke= compileFinal preprocessfileLineNumbers "FireSmoke.sqf";
FIREVILLAGE= compileFinal preprocessfileLineNumbers "FireVillage.sqf";
BattleVirtual= compileFinal preprocessfileLineNumbers "BattleVirtual.sqf";
CreateRoadBlock= compileFinal preprocessfileLineNumbers "CreateRoadBlock.sqf";
};
TASK_AirTask1 = compileFinal preprocessfileLineNumbers "MainTasks\AirTask1.sqf";
F_MarkerSelectedZone = compileFinal preprocessfileLineNumbers "MarkerSelectedZone.sqf";
BattleOdds = compileFinal preprocessfileLineNumbers "BattleOdds.sqf";
MapCommander = compileFinal preprocessfileLineNumbers "MapCommander.sqf";
if !(isDedicated) then {
[] SPAWN MapCommander;
};
if (isServer) then {
_walls = (getposATL jail1) CALL POWcell;
//Body, Ambient Vehicle and emptygroup removal. Also auto rearming near ammotruck if enabled ingame.
sleep 20;
_time = time;
_yy = 0;
while {true} do {
if (!isNil{SaOKmissionnamespace getvariable "Autosave"} && {((SaOkmissionnamespace getvariable "Autosave")*60+_time) < time}) then {_time = time;[] SPAWN FSaOkSave;};
//TASK
if (count AmbientZonesN > 15 && {{getMarkerColor _x == "ColorRed"} count AmbientZonesN == 0}) then {
_nul = ["task0","SUCCEEDED"] call BIS_fnc_taskSetState;
_nul = "end1" SPAWN BIS_fnc_endMission;
_fN = "SaOkSaveWLAMP";
if (worldname != "Altis") then {_fN = _fN + worldname;};
profileNamespace setvariable [_fN,nil];
};
6 SPAWN InitFuncs;
2 SPAWN InitFuncs;
[] SPAWN FUNKTIO_Commander;
sleep 5;
_yy + 1;
if (_yy > 18) then {
_yy = 0;
0 SPAWN InitFuncs;
};
sleep 5;
[] SPAWN FUNKTIO_Commander;
//TASK
//
//3 SPAWN InitFuncs;
[] SPAWN FUNKTIO_Commander;
sleep 5;
6 SPAWN InitFuncs;
5 SPAWN InitFuncs;
[] SPAWN FUNKTIO_Commander;
_nul = [] SPAWN FUNKTIO_IL;
sleep 5;
1 SPAWN InitFuncs;
6 SPAWN InitFuncs;
[] SPAWN FUNKTIO_Commander;
sleep 5;
[] SPAWN FUNKTIO_Commander;
5 SPAWN InitFuncs;
if (!isNil"LIIKUTAOBJEKTI") then {LIIKUTAOBJEKTI = nil;};
if (CBIRDS > 0) then {CBIRDS = CBIRDS - 1;}; 

sleep 10;
[] SPAWN FUNKTIO_Commander;
5 SPAWN InitFuncs;
4 SPAWN InitFuncs;
sleep 10;
[] SPAWN FUNKTIO_Commander;
6 SPAWN InitFuncs;
5 SPAWN InitFuncs;
if (!isNil"LIIKUTAOBJEKTI") then {LIIKUTAOBJEKTI = nil;};
if (CBIRDS > 0) then {CBIRDS = CBIRDS - 1;}; 
_l = (leader ([] call RandomP));
_nul = [getposATL vehicle _l] SPAWN FUNKTIO_BlackListMarkers;
sleep 5;
[] SPAWN FUNKTIO_Commander;
1 SPAWN InitFuncs;
sleep 5;
[] SPAWN FUNKTIO_Commander;
5 SPAWN InitFuncs;
_nul = [] SPAWN FUNKTIO_IL2;
sleep 10;
[] SPAWN FUNKTIO_Commander;
5 SPAWN InitFuncs;
if (CBIRDS > 0) then {CBIRDS = CBIRDS - 1;}; 
4 SPAWN InitFuncs;
sleep 5;
[] SPAWN FUNKTIO_Commander;
6 SPAWN InitFuncs;
1 SPAWN InitFuncs;
sleep 5;
[] SPAWN FUNKTIO_Commander;
5 SPAWN InitFuncs;
if (!isNil"LIIKUTAOBJEKTI") then {LIIKUTAOBJEKTI = nil;};
sleep 10;
[] SPAWN FUNKTIO_Commander;
5 SPAWN InitFuncs;
if (CBIRDS > 0) then {CBIRDS = CBIRDS - 1;}; 
4 SPAWN InitFuncs;
_l = (leader ([] call RandomP));
_nul = [getposATL vehicle _l] SPAWN FUNKTIO_BlackListMarkers;
sleep 5;
[] SPAWN FUNKTIO_Commander;
6 SPAWN InitFuncs;
1 SPAWN InitFuncs;
sleep 5;
};
};