

private ["_str","_s","_nul","_nearest","_ran","_b","_n","_h","_dPos","_dir","_speedd","_speed","_ff","_didsee","_car","_objc"];
_ff = {
private ["_pos","_cl","_vel"];
_pos = _this select 0;
_vel = _this select 2;
_veh = _this select 1;
_veh disableCollisionWith (_this select 3); 
_veh setpos _pos;
_y = random 1;
_x = random 1;
_z = random 1;
_veh setvectorUp [_y, _x, _z];
sleep 0.05;
_veh setvelocity [(_vel select 0)*0.5- 2 +random 4,(_vel select 1)*0.5- 2 +random 4,(_vel select 2)*0.5+1+random 1];
//[_veh] SPAWN {sleep 15; deletevehicle (_this select 0);};
};

_didsee = {
private ["_see","_nearest","_str"];
_see = false;
{
if ([player,_x] CALL FUNKTIO_LOS) exitWith {
_see = true;
if (false) then {
_s = ["steal15","steal14","steal13","steal12","steal11","steal10","steal9","steal8","steal7","steal6","steal5","steal4","steal3","steal1","steal2"]call RETURNRANDOM;
[_x, "CivV", "CivV\sounds.bikb", ""] CALL SAOKKBTOPIC;
[_x, player, "CivV", _s] SPAWN SAOKKBTELL;
} else {
//"stealV1","stealV2","stealV3","stealV4",
_s = ["CivS14","CivS13","CivS12","CivS11","CivS10","CivS9","CivS8","CivS7","CivS6","CivS5","CivS4","CivS3","CivS2","CivS1"]call RETURNRANDOM;
[_x, "ZafV", "ZafVoices\sounds.bikb", ""]CALL SAOKKBTOPIC;
[_x, player, "ZafV", _s] SPAWN SAOKKBTELL;
};
};
} foreach (player nearEntities [["Civilian"],15]);
if (_see) then {
[] SPAWN SAOKLOWERRELVIL;
_Lna = (getposATL player) CALL NEARESTLOCATIONNAME;
_header = format ["NATO Soldiers Raiding Houses in %1?",_Lna];
[_header, date] CALL SAOKEVENTLOG;
};
};

[] SPAWN SAOKRESETVEHICLE;

if (player CALL NEARESTLOCATIONNAME == "factory" && {(vehicle player) distance (getmarkerpos ([] CALL NEARESTVILLAGE)) < 40}) then {
if (!isNull cursorTarget && {count crew cursorTarget == 0} && {{typeof cursorTarget iskindof _x} count ["Car","Air","Tank","LandVehicle"] > 0}) then {deletevehicle cursorTarget; FACRES = FACRES + 1;publicvariable "FACRES";"Vehicle scrapped - Received resource point" SPAWN HINTSAOK;};
};
/*
//RESOURCE GATHERING 
if (!isNil{player getvariable "LastVeh"} && {alive (player getvariable "LastVeh")} && {(player getvariable "LastVeh") distance player < 100}) then {
_g = [];
//hint format ["%1",((getposATL player) nearEntities [["ReammoBox_F","Man"],9])];
{if (typeof _x == "WeaponHolderSimulated") then {_g set [count _g, "Ground"];_x CALL SAOKGATHERCRATE;deletevehicle _x;};} foreach ((getposATL player) nearEntities ["All",5]);
{if ((_x distance player < 5) && {isNil{_x getvariable "Gathered"}}) then {_g set [count _g, getText(configfile >> "CfgVehicles" >> (typeOf _x) >> "displayName")];_x CALL SAOKGATHERUNIT; _x setvariable ["Gathered",1,true];};} foreach allDeadMen;
{if (alive _x && {_x call SAOKGATHERCRATEB}) then {_g set [count _g, getText(configfile >> "CfgVehicles" >> (typeOf _x) >> "displayName")];_x CALL SAOKGATHERCRATE;};} foreach ((getposATL player) nearEntities [["ReammoBox_F"],5]);
{if (alive _x && {_x call SAOKGATHERCRATEB}) then {_g set [count _g, (format ["<img size='1.2' image='%1'/>",(getText (configfile >> "CfgVehicles" >> typeof _x >> "picture"))])];_x CALL SAOKGATHERCRATE;};} foreach ((getposATL player) nearEntities [["LandVehicle"],12]);
if (count _g > 0) then {
_t = "Gear gathered from ";
_c = count _g - 1;
{
_t = _t + (format ["%1",_x]);
if (_c > 0) then {
if (_c > 1) then {
_t = _t +", ";
} else {
_t = _t +" and ";
};
};
_c = _c - 1;
} foreach _g;
_t SPAWN HINTSAOK;
};
};
*/


_car = nearestObject [player, "Car"];
if (!isNull _car && {locked _car == 2} && {isNil{_car getvariable "NoCOwner"}} && {_car distance player < 7}) then {
_s = ["breakV","breakV2"]call RETURNRANDOM;
_s SPAWN SAOKPLAYSOUND;
[_car,1] SPAWN VehLife;
sleep 2;
_nul = _car SPAWN FCarAlarmLights;
[[_car,0],"SAOKCARLOCK",false,false] spawn BIS_fnc_MP;
{
if ([player,_x] CALL FUNKTIO_LOS) exitWith {
[] SPAWN SAOKLOWERRELVIL;
_Lna = (getposATL player) CALL NEARESTLOCATIONNAME;
_header = format ["NATO Soldiers Seen Stealing Car in %1, Locals Loosing Hope",_Lna];
[_header, date] CALL SAOKEVENTLOG;
};
} foreach (player nearEntities [["Civilian"],15]);
};
if (!isNull _car && {_car distance player < 7} && {locked _car in [0,1]} && {!isNil{player getvariable "LastVeh"}} && {(player getvariable "LastVeh") == _car}) exitWith {_car lock 2;_car setvariable ["NoCOwner", name player,true]; "Car Locked" SPAWN HINTSAOK;};
if (!isNull _car && {_car distance player < 7} && {locked _car == 2} && {!isNil{_car getvariable "NoCOwner"}} && {(_car getvariable "NoCOwner") == name player}) exitWith {_car lock 0;_car setvariable ["NoCOwner", nil,true]; "Car UnLocked" SPAWN HINTSAOK;};


//_objc =["Land_WoodenTable_small_F","Land_WoodenTable_large_F","Land_MapBoard_F","Land_ShelvesWooden_khaki_F","Land_ShelvesWooden_blue_F","Land_ShelvesWooden_F","Land_ShelvesMetal_F","Land_Rack_F","Land_Metal_wooden_rack_F","Land_Metal_rack_Tall_F","Land_Metal_rack_F","Land_Icebox_F","Land_TableDesk_F","Land_ChairWood_F","Land_ChairPlastic_F","Land_CashDesk_F","Land_Bench_F","Land_WaterPurificationTablets_F","Land_BottlePlastic_V2_F","Land_VitaminBottle_F","Land_TinContainer_F","Land_TacticalBacon_F","Land_SurvivalRadio_F","Land_Suitcase_F","Land_Map_unfolded_F","Land_Map_F","Land_Shovel_F","Land_SatellitePhone_F","Land_RiceBox_F","Land_PowderedMilk_F","Land_Poster_04_F","Land_BottlePlastic_V1_F","Land_BottlePlastic_V1_F","Land_Money_F","Land_Photos_V6_F","Land_Photos_V5_F","Land_Photos_V4_F","Land_Photos_V3_F","Land_Photos_V1_F","Land_Photos_V1_F","Land_PensAndPencils_F","Land_PencilYellow_F","Land_PencilRed_F","Land_PencilGreen_F","Land_PencilBlue_F","Land_PenRed_F","Land_PenBlack_F","Land_PainKillers_F","Land_Notepad_F","Land_MobilePhone_old_F","Land_MobilePhone_smart_F","Land_MetalWire_F","Land_Map_stratis_F","Land_Map_altis_F","Land_Map_blank_F","Land_Magazine_rifle_F","Land_LuggageHeap_04_F","Land_LuggageHeap_05_F","Land_LuggageHeap_01_F","Land_LuggageHeap_03_F","Land_Laptop_unfolded_F","Land_Laptop_F","Land_HeatPack_F","Land_HandyCam_F,""Land_GasCooker_F","Land_GasCanister_F","Land_FMradio_F","Land_FireExtinguisher_F","Land_File2_F","Land_FilePhotos_F","Land_File1_F","Land_DuctTape_F","Land_DisinfectantSpray_F","Land_Defibrillator_F","Land_CerealsBox_F","Land_Canteen_F","Land_CanisterPlastic_F","Land_CanisterOil_F","Land_CanisterFuel_F","Land_CanOpener_F","Land_Can_V1_F","Land_Can_Rusty_F","Land_Can_V3_F","Land_Can_V2_F","Land_Can_Dented_F","Land_ButaneTorch_F","Land_ButaneCanister_F","Land_Bucket_painted_F","Land_Bucket_clean_F","Land_Bucket_F","Land_BloodBag_F","Land_BloodBag_F","Land_Battery_F","Land_Bandage_F","Land_BakedBeans_F","Land_Antibiotic_F","Land_Ammobox_rounds_F"];
_objc =["Land_Trophy_01_bronze_F","Land_Trophy_01_gold_F","Land_Trophy_01_silver_F","Land_Baseball_01_F","Land_Basketball_01_F","Land_Football_01_F","Land_Rugbyball_01_F","Land_Volleyball_01_F","Land_File_F","Land_Axe_fire_F","Land_Axe_F","Land_WaterPurificationTablets_F","Land_BottlePlastic_V2_F","Land_VitaminBottle_F","Land_TinContainer_F","Land_TacticalBacon_F","Land_SurvivalRadio_F","Land_Suitcase_F","Land_Map_unfolded_F","Land_Map_F","Land_Shovel_F","Land_SatellitePhone_F","Land_RiceBox_F","Land_PowderedMilk_F","Land_BottlePlastic_V1_F","Land_BottlePlastic_V1_F","Land_Money_F","Land_Photos_V6_F","Land_Photos_V5_F","Land_Photos_V4_F","Land_Photos_V3_F","Land_Photos_V1_F","Land_Photos_V1_F","Land_PensAndPencils_F","Land_PencilYellow_F","Land_PencilRed_F","Land_PencilGreen_F","Land_PencilBlue_F","Land_PenRed_F","Land_PenBlack_F","Land_PainKillers_F","Land_Notepad_F","Land_MobilePhone_old_F","Land_MobilePhone_smart_F","Land_Map_stratis_F","Land_Map_altis_F","Land_Map_blank_F","Land_Magazine_rifle_F","Land_Laptop_unfolded_F","Land_Laptop_F","Land_HeatPack_F","Land_HandyCam_F,""Land_GasCooker_F","Land_GasCanister_F","Land_FMradio_F","Land_File2_F","Land_FilePhotos_F","Land_File1_F","Land_DisinfectantSpray_F","Land_Defibrillator_F","Land_CerealsBox_F","Land_Canteen_F","Land_CanisterPlastic_F","Land_CanisterOil_F","Land_CanisterFuel_F","Land_CanOpener_F","Land_Can_V1_F","Land_Can_Rusty_F","Land_Can_V3_F","Land_Can_V2_F","Land_Can_Dented_F","Land_ButaneTorch_F","Land_ButaneCanister_F","Land_Bucket_painted_F","Land_Bucket_clean_F","Land_Bucket_F","Land_BloodBag_F","Land_BloodBag_F","Land_Bandage_F","Land_BakedBeans_F","Land_Antibiotic_F","Land_Ammobox_rounds_F"];
{
_b = true;
if (typeof _x in ["Land_Trophy_01_bronze_F","Land_Trophy_01_gold_F","Land_Trophy_01_silver_F","Land_File_F","Land_Ammobox_rounds_F","Land_File2_F","Land_FilePhotos_F","Land_File1_F","Land_Map_stratis_F","Land_Map_altis_F","Land_Map_blank_F","Land_MobilePhone_old_F","Land_MobilePhone_smart_F","Land_Notepad_F","Land_Suitcase_F","Land_Map_unfolded_F","Land_Map_F","Land_Money_F","Land_Photos_V6_F","Land_Photos_V5_F","Land_Photos_V4_F","Land_Photos_V3_F","Land_Photos_V1_F","Land_Photos_V1_F","Land_Laptop_unfolded_F","Land_Laptop_F"]) then {
_ran = floor (10 + (random 70));
_n = [side player,_ran] SPAWN PrestigeUpdate;
[[_ran, "Gathered Item",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
_s = ["Cash","breakV","breakV2"]call RETURNRANDOM;
_s SPAWN SAOKPLAYSOUND;
deletevehicle _x;_b = false;
_n = [] sPAWn _didsee;
};
if (["TaskNalka"] CALL BIS_fnc_taskExists && {!isNil{TNalka}}) then {
if (typeof _x in ["Land_BakedBeans_F","Land_BakedBeans_F","Land_RiceBox_F","Land_CerealsBox_F"]) then {
_ran = floor (30 + (random 70));
_n = [side player,_ran] SPAWN PrestigeUpdate;
[[_ran, "Found somethin to eat",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
TNalka = nil;
_s = ["eat","cateat"]call RETURNRANDOM;
_s SPAWN SAOKPLAYSOUND;
_nul = ["TaskNalka","SUCCEEDED"] call BIS_fnc_taskSetState;
"TaskNalka" SPAWN {sleep 30; _n = [_this] CALL BIS_fnc_deleteTask;};
deletevehicle _x;_b = false;
_n = [] sPAWn _didsee;
};
};
if (["TaskJano"] CALL BIS_fnc_taskExists && {!isNil{TJano}}) then {
if (typeof _x in ["Land_BottlePlastic_V2_F","Land_PowderedMilk_F","Land_BottlePlastic_V1_F","Land_Can_V1_F","Land_Can_Rusty_F","Land_Can_V3_F","Land_Can_V2_F","Land_Can_Dented_F"]) then {
_ran = floor (20 + (random 30));
_n = [side player,_ran] SPAWN PrestigeUpdate;
[[_ran, "Found something to drink",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
_s = ["drinking","drinking2","drinking3"]call RETURNRANDOM;
_s SPAWN SAOKPLAYSOUND;
TJano = nil;
_nul = ["TaskJano","SUCCEEDED"] call BIS_fnc_taskSetState;
"TaskJano" SPAWN {sleep 30; _n = [_this] CALL BIS_fnc_deleteTask;};
deletevehicle _x;_b = false;
_n = [] sPAWn _didsee;
};
};
if (["TaskKipea"] CALL BIS_fnc_taskExists && {!isNil{TKipea}}) then {
if (typeof _x in ["Land_VitaminBottle_F","Land_Antibiotic_F","Land_PainKillers_F"]) then {
_ran = floor (50 + (random 70));
_n = [side player,_ran] SPAWN PrestigeUpdate;
[[_ran, "You are feeling better",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
_s = ["pills","pills2"]call RETURNRANDOM;
TKipea = nil;
_s SPAWN SAOKPLAYSOUND;
_nul = ["TaskKipea","SUCCEEDED"] call BIS_fnc_taskSetState;
"TaskKipea" SPAWN {sleep 30; _n = [_this] CALL BIS_fnc_deleteTask;};
deletevehicle _x;_b = false;
_n = [] sPAWn _didsee;
};
};
if (_b) then {
_n = [] sPAWn _didsee;
_h = ((eyepos player) select 2)-((getposASL player) select 2);
_dPos = player modelToWorld [0,1,_h];
_dir = direction player;
_speedd =20+(random 20);
[_x,1] SPAWN VehLife;
_speed = [((sin _dir)*_speedd*(0.80+random 0.4)),((cos _dir)*_speedd*(0.80+random 0.4)),(0.1+random 4)];
_nul = [_dPos, _x,_speed,player] SPAWN _ff;
};
} foreach (nearestObjects [player,_objc, 3]);

//Land_Money_F (nearestObjects [player,"Land_Money_F", 3])