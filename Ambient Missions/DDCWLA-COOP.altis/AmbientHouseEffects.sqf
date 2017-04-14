
private ["_picked","_objc","_y"];
if (!isServer) exitWith {};
		private ["_picked","_objc"];
		//"Land_WoodenTable_small_F","Land_WoodenTable_large_F","Land_MapBoard_F","Land_ShelvesWooden_khaki_F","Land_ShelvesWooden_blue_F","Land_ShelvesWooden_F","Land_ShelvesMetal_F","Land_Rack_F","Land_Metal_wooden_rack_F","Land_Metal_rack_Tall_F","Land_Metal_rack_F","Land_Icebox_F","Land_TableDesk_F","Land_ChairWood_F","Land_ChairPlastic_F","Land_CashDesk_F","Land_Bench_F"
		_objc =["Land_WoodenTable_small_F","Land_WoodenTable_large_F","Land_MapBoard_F","Land_ShelvesWooden_khaki_F","Land_ShelvesWooden_blue_F","Land_ShelvesWooden_F","Land_ShelvesMetal_F","Land_Rack_F","Land_Metal_wooden_rack_F","Land_Metal_rack_Tall_F","Land_Metal_rack_F","Land_Icebox_F","Land_TableDesk_F","Land_ChairWood_F","Land_ChairPlastic_F","Land_CashDesk_F","Land_Bench_F","Land_WaterPurificationTablets_F","Land_BottlePlastic_V2_F","Land_VitaminBottle_F","Land_TinContainer_F","Land_TacticalBacon_F","Land_SurvivalRadio_F","Land_Suitcase_F","Land_Map_unfolded_F","Land_Map_F","Land_Shovel_F","Land_SatellitePhone_F","Land_RiceBox_F","Land_PowderedMilk_F","Land_Poster_04_F","Land_BottlePlastic_V1_F","Land_BottlePlastic_V1_F","Land_Money_F","Land_Photos_V6_F","Land_Photos_V5_F","Land_Photos_V4_F","Land_Photos_V3_F","Land_Photos_V1_F","Land_Photos_V1_F","Land_PensAndPencils_F","Land_PencilYellow_F","Land_PencilRed_F","Land_PencilGreen_F","Land_PencilBlue_F","Land_PenRed_F","Land_PenBlack_F","Land_PainKillers_F","Land_Notepad_F","Land_MobilePhone_old_F","Land_MobilePhone_smart_F","Land_MetalWire_F","Land_Map_stratis_F","Land_Map_altis_F","Land_Map_blank_F","Land_Magazine_rifle_F","Land_LuggageHeap_04_F","Land_LuggageHeap_05_F","Land_LuggageHeap_01_F","Land_LuggageHeap_01_F","Land_LuggageHeap_03_F","Land_Laptop_unfolded_F","Land_Laptop_F","Land_HeatPack_F","Land_HandyCam_F,""Land_GasCooker_F","Land_GasCanister_F","Land_FMradio_F","Land_FireExtinguisher_F","Land_File2_F","Land_FilePhotos_F","Land_File1_F","Land_DuctTape_F","Land_DisinfectantSpray_F","Land_Defibrillator_F","Land_CerealsBox_F","Land_Canteen_F","Land_CanisterPlastic_F","Land_CanisterOil_F","Land_CanisterFuel_F","Land_CanOpener_F","Land_Can_V1_F","Land_Can_Rusty_F","Land_Can_V3_F","Land_Can_V2_F","Land_Can_Dented_F","Land_ButaneTorch_F","Land_ButaneCanister_F","Land_Bucket_painted_F","Land_Bucket_clean_F","Land_Bucket_F","Land_BloodBag_F","Land_BloodBag_F","Land_Battery_F","Land_Bandage_F","Land_BakedBeans_F","Land_Antibiotic_F","Land_Ammobox_rounds_F"];
		
		waitUntil {sleep 1; count AmbientCiv > 0};
		sleep 3;
		AmbientH = + AmbientCiv;
		while {true} do {
		sleep 6;
		
		_picked = "";
		//{_mP = getmarkerpos _x;if ({_mP distance vehicle _x < 900} count ([WEST] CALL AllPf) > 0 && {([_mP] CALL NEARESTVILLAGERELATIONSHIP) in ["Hostile","Angry"]}) then {_x CALL FIREVILLAGE;};} foreach AmbientCiv;
		{_y = _x; if ({vehicle _x distance (getmarkerpos _y) < 900} count ([WEST] CALL AllPf) > 0) exitwith {_picked = _x; AmbientH = AmbientH - [_x]};} foreach AmbientH;


		if (_picked != "") then {
		[_picked,_objc] SPAWN {
		private ["_objc","_size","_picked","_pos", "_dis","_pos2","_dis2","_poss", "_buildings","_PS","_worldpos","_PSlist","_firep","_st","_start","_obj"];
		_picked = _this select 0;
		_objc = _this select 1;
		_pos = getmarkerpos _picked;
		_sizeA = ((getmarkersize _picked) select 0);
		//fireplaces
		_firep = [];
		_size = floor (((getmarkersize _picked) select 0)*0.008);
		if (_size == 0) then {_size = 1;};
		for "_i" from 0 to _size do {
		
		
		if (false && {[_pos] CALL NEARESTVILLAGERELATIONSHIP in ["Hostile","Angry"]} && {random 1 < 0.8}) then {
		_start = [(_pos select 0) + 200 - (random 400),(_pos select 1) + 200 - (random 400),0];
		while {surfaceIsWater _start} do {
		sleep 0.5;
		_start = [(_pos select 0) + 200 - (random 400),(_pos select 1) + 200 - (random 400),0];
		};
		_dd = (["Ld"] CALL DIS);
		_obj = [_start, (_dd+100),""] CALL FireSmoke;
		_firep set [count _firep,_obj];
		} else {
		_start = [(_pos select 0) + _sizeA - (random (_sizeA*2)),(_pos select 1) + _sizeA - (random (_sizeA*2)),0];
		while {isOnRoad _start || {{_x distance _start < 20} count _firep > 0} || {surfaceIsWater _start}} do {
		sleep 0.5;
		_start = [(_pos select 0) + _sizeA - (random (_sizeA*2)),(_pos select 1) + _sizeA - (random (_sizeA*2)),0];
		};
		_cl = ["MetalBarrel_burning_F","FirePlace_burning_F"] call RETURNRANDOM;
		_obj = createVehicle [_cl,_start, [], 0, "NONE"]; 
		_obj setvectorup (surfaceNormal (getposATL _obj));
		_firep set [count _firep,_obj];
		};
		};
		
		{_x setvariable ["AmCrate",1];} foreach _firep;
		sleep 10;
		waituntil {sleep 10; {vehicle _x distance getmarkerpos _picked < 900} count ([WEST] CALL AllPf) == 0};
		{_x setvariable ["AmCrate",nil];} foreach _firep;
		{deletevehicle _x;} foreach _firep;
		AmbientH set [count AmbientH,_picked];
		};
		};
};


