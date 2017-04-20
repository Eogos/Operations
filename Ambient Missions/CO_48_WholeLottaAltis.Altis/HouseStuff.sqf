private ["_c","_hhh","_oBL","_hBl","_func","_varN","_curV","_cT"];
if (isDedicated) exitWith {};
SAOKobjc = ["Land_MetalBarrel_F","Land_PortableLight_double_F","Land_PortableLight_single_F","Land_CampingChair_V2_F","Land_CampingChair_V1_folded_F","Land_CampingChair_V1_F","Land_CratesPlastic_F","Land_CratesShabby_F","Land_CratesWooden_F","Land_Sack_F","Land_Sacks_heap_F","Land_Sacks_goods_F","Land_Bricks_V2_F","Land_Bricks_V2_F","Land_Bricks_V3_F","Land_Bricks_V4_F","Land_Basket_F","Land_Cages_F","Land_WaterBarrel_F","Land_BarrelWater_grey_F","Land_BarrelWater_F","Land_BarrelTrash_F","Land_BarrelTrash_grey_F","Land_BarrelSand_grey_F","Land_BarrelSand_F","Land_BarrelEmpty_grey_F","Land_BarrelEmpty_F","Land_MetalBarrel_empty_F","MetalBarrel_burning_F","Land_MetalBarrel_F","Land_Wrench_F","Land_WorkStand_F","Land_WoodenBox_F","Land_WheelCart_F","Land_Meter3m_F","Land_Pallets_stack_F","Land_Screwdriver_V1_F","Land_Screwdriver_V2_F","Land_Saw_F","Land_Portable_generator_F","Land_Pliers_F","Land_Pallet_vertical_F","Land_Pallet_F","Land_MultiMeter_F","Land_Hammer_F","Land_Grinder_F","Land_Gloves_F","Land_FloodLight_F","Land_File_F","Land_ExtensionCord_F","Land_DustMask_F","Land_CinderBlocks_F","Land_Axe_fire_F","Land_Axe_F","Land_DrillAku_F","Land_WoodenTable_small_F","Land_WoodenTable_large_F","Land_MapBoard_F","Land_ShelvesWooden_khaki_F","Land_ShelvesWooden_blue_F","Land_ShelvesWooden_F","Land_ShelvesMetal_F","Land_Rack_F","Land_Metal_wooden_rack_F","Land_Metal_rack_Tall_F","Land_Metal_rack_F","Land_Icebox_F","Land_TableDesk_F","Land_ChairWood_F","Land_ChairPlastic_F","Land_CashDesk_F","Land_Bench_F","Land_WaterPurificationTablets_F","Land_BottlePlastic_V2_F","Land_VitaminBottle_F","Land_TinContainer_F","Land_TacticalBacon_F","Land_SurvivalRadio_F","Land_Suitcase_F","Land_Map_unfolded_F","Land_Map_F","Land_Shovel_F","Land_SatellitePhone_F","Land_RiceBox_F","Land_PowderedMilk_F","Land_Poster_04_F","Land_BottlePlastic_V1_F","Land_BottlePlastic_V1_F","Land_Money_F","Land_Photos_V6_F","Land_Photos_V5_F","Land_Photos_V4_F","Land_Photos_V3_F","Land_Photos_V1_F","Land_Photos_V1_F","Land_PensAndPencils_F","Land_PencilYellow_F","Land_PencilRed_F","Land_PencilGreen_F","Land_PencilBlue_F","Land_PenRed_F","Land_PenBlack_F","Land_PainKillers_F","Land_Notepad_F","Land_MobilePhone_old_F","Land_MobilePhone_smart_F","Land_MetalWire_F","Land_Map_stratis_F","Land_Map_altis_F","Land_Map_blank_F","Land_Magazine_rifle_F","Land_LuggageHeap_01_F","Land_LuggageHeap_03_F","Land_Laptop_unfolded_F","Land_Laptop_F","Land_HeatPack_F","Land_HandyCam_F","Land_GasCooker_F","Land_GasCanister_F","Land_FMradio_F","Land_FireExtinguisher_F","Land_File2_F","Land_FilePhotos_F","Land_File1_F","Land_DuctTape_F","Land_DisinfectantSpray_F","Land_Defibrillator_F","Land_CerealsBox_F","Land_Canteen_F","Land_CanisterPlastic_F","Land_CanisterOil_F","Land_CanisterFuel_F","Land_CanOpener_F","Land_Can_V1_F","Land_Can_Rusty_F","Land_Can_V3_F","Land_Can_V2_F","Land_Can_Dented_F","Land_ButaneTorch_F","Land_ButaneCanister_F","Land_Bucket_painted_F","Land_Bucket_clean_F","Land_Bucket_F","Land_BloodBag_F","Land_BloodBag_F","Land_Battery_F","Land_Bandage_F","Land_BakedBeans_F","Land_Antibiotic_F","Land_Ammobox_rounds_F"];
{if (isClass(configFile >> "cfgVehicles" >> _x)) then {SAOKobjc pushback _x};sleep 0.01;} foreach ["Land_Trophy_01_bronze_F","Land_Trophy_01_gold_F","Land_Trophy_01_silver_F","Land_Baseball_01_F","Land_Basketball_01_F","Land_Football_01_F","Land_Rugbyball_01_F","Land_Volleyball_01_F"];
{if (!isClass(configFile >> "cfgVehicles" >> _x)) then {SAOKobjc = SAOKobjc - [_x];sleep 0.01;};} foreach SAOKobjc;
if (isnil"Ctalot") then {Ctalot = [];};
_hBl = ["Land_Bridge_Asphalt_PathLod_F","Land_Bridge_Concrete_PathLod_F","Land_Bridge_HighWay_PathLod_F","Land_Pier_F","Land_nav_pier_m_F","Land_Cargo_HQ_V1_F","Land_Cargo_Patrol_V2_F","Land_Cargo_House_V1_F"];
//_oBL = ["Land_ChairPlastic_F","Land_ChairWood_F","Land_CampingChair_V1_F","Land_Sleeping_bag_F"];
_oBL = [];
//nearestObjects [player, SAOKobjcB, 2];
_func = {
private ["_oBL","_hBl","_posB","_obj","_n","_varN","_data","_c","_array","_ran","_Bp","_waypoints","_sizeS","_cT","_objs"];
sleep (random 1);
_cT = _this select 0;
_hBl = _this select 1;
_oBL = _this select 2;
if (_cT in Ctalot) exitWith {};
_objs = [];
_data = [];
Ctalot pushback _cT;
publicVariable "Ctalot";
//NEW
_objs = [];
//_cT = nearestBuilding player;
if (_cT in talot && {!isNil{SaOkmissionnamespace getvariable _varN}} && {typename (SaOkmissionnamespace getvariable _varN) == "ARRAY"}) then {
//NEW PREVIOUSLY VISITED HOUSE  "Land_TTowerSmall_1_F" _obj = createVehicle ["Land_TTowerSmall_1_F" ,getposATL thisTrigger, [], 0, "NONE"]; 
_varN = format ["Talo%1",_cT]; 
_data = SaOkmissionnamespace getvariable _varN; 
_c = count _data - 1;
for "_i" from 0 to _c do {
private ["_xx"];
_xx = _data select _i;
if !((_xx select 0) in _oBL) then {
_posB = _xx select 1;
_obj = createVehicle [_xx select 0,_posB, [], 0, "NONE"]; 
if (_xx select 0 != "Land_MetalBarrel_F") then {[_obj,0] SPAWN VehLife;} else {_n = _obj SPAWN SAOKBARRELBOMBS;};
_obj setvariable ["Bpo",_posB];
_obj setpos _posB;
_obj setvectorup (surfaceNormal (getposATL _obj));
_obj setdir (_xx select 2);
_objs set [count _objs,_obj];
} else {
if ((_xx select 0) != "Land_Sleeping_bag_F") then {
_posB = _xx select 1;
//_n = [_posB,_cT] CALL AnimCivChair;
(_n select 1) setvariable ["Bpo",_posB];
_objs set [count _objs,_n select 0];
_objs set [count _objs,_n select 1];
} else {
_posB = _xx select 1;
//_n = [_posB,_cT] CALL AnimCivBed;
if (count _n == 0) exitWith {};
(_n select 1) setvariable ["Bpo",_posB];
_objs set [count _objs,_n select 0];
_objs set [count _objs,_n select 1];
};
};
};

} else {
//NEW NEVER VISITED HOUSE
talot set [count talot,_cT];
//_varN = format ["Talo%1",_cT];};
_sizeS = [3,4,2,1,2,1,2,1,2,1,3,3,3,2,1,2,2,2,2,2] call RETURNRANDOM;
_waypoints = [];
_c = 0;
_array = _cT buildingPos _c;
while {str(_array) != "[0,0,0]"} do {	
_waypoints set [count _waypoints,_c];
_c = _c + 1;
_array = _cT buildingPos _c;
};
if !(typeOf _cT in _hBl) then {
for "_i" from 0 to _sizeS do {
		if (count _waypoints > 0) then {
		_ran = SAOKobjc call RETURNRANDOM;
		_Bp = (_waypoints call RETURNRANDOM);
		_waypoints = _waypoints - [_Bp];
		_posB = _cT buildingPos _Bp;
		if !(_ran in _oBL) then {
		_obj = createVehicle [_ran,_posB, [], 0, "CAN_COLLIDE"];
		if (_ran != "Land_MetalBarrel_F") then {[_obj,0] SPAWN VehLife;} else {_n = _obj SPAWN SAOKBARRELBOMBS;};
		_obj setvariable ["Bpo",_posB];
		_obj setpos _posB;
		_obj setdir (random 360);
		_obj setvectorup (surfaceNormal (getposATL _obj));
		_objs set [count _objs,_obj];
		} else {
		if (_ran != "Land_Sleeping_bag_F") then {
		//_n = [_posB,_cT] CALL AnimCivChair;
		(_n select 1) setvariable ["Bpo",_posB];
		_objs set [count _objs,_n select 0];
		_objs set [count _objs,_n select 1];
		} else {
		//_n = [_posB,_cT] CALL AnimCivBed;
		if (count _n == 0) exitWith {};
		(_n select 1) setvariable ["Bpo",_posB];
		_objs set [count _objs,_n select 0];
		_objs set [count _objs,_n select 1];
		};
		};
		};
		sleep 0.1;
};
};
};
waitUntil {sleep 2; player distance _cT > 35};
//OLD HOUSE DATA SAVED
_data = [];
_varN = format ["Talo%1",_cT]; 
{if (!isNull _x && {!(typeof _x iskindof "man")}) then {
_data set [count _data,[typeoF _x, (_x getvariable "Bpo"), direction _x]];
_x setvariable ["Bpo",nil];deletevehicle _x;} else {deletevehicle _x;};} foreach _objs;
if (_ct in talot) then {SaOkmissionnamespace setvariable [_varN,_data];};
{deletevehicle _x;} foreach _objs;
Ctalot = Ctalot - [_ct];
publicVariable "Ctalot";
};



_cT = nearestBuilding player;
talot = [];
while {true} do {
//VILLAGE CHANGED REMOVE OLD VILLAGE HOUSE DATA 
{_varN = format ["Talo%1",_x]; SaOkmissionnamespace setvariable [_varN,nil];} foreach talot;
talot = [];
_curV = ([] CALL NEARESTVILLAGE);
while {_curV == ([] CALL NEARESTVILLAGE)} do {
waitUntil {sleep 2;vehicle player == player};
_hhh = (nearestObjects [player, ["house"], 35]);
_c = count _hhh - 1;
for "_i" from 0 to _c do {[_hhh select _i,_hBl,_oBl] SPAWN _func; sleep 0.1;};

};
};
