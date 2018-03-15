/*
    Author - HoverGuy
	© All Fucks Reserved
	Website - http://www.sunrise-production.com
	
    Defines available vehicle shops
	
	class YourShopClass - Used as a param for the call, basically the shop you want to display
	{
		conditionToAccess - STRING - Condition that must return either true or false, if true the player will have access to the shop
		
		class YourShopCategory - Shop category, can be whatever you want
		{
			displayName - STRING - Category display name
			vehicles - ARRAY OF ARRAYS - Shop content
			|- 0 - STRING - Classname
			|- 1 - INTEGER - Price
			|- 2 - STRING - Condition that must return either true or false, if true the vehicle appears in the list else no
			spawnPoints - ARRAY OF ARRAYS - Spawn positions (markers/positions)
			|- 0 - STRING - Display name in the dialog
			|- 1 - ARRAY OF MIXED - Markers/positions
		};
	};
*/

class HG_DefaultShop // HG_DefaultShop is just a placeholder for testing purposes, you can delete it completely and make your own
{
    conditionToAccess = "true"; // Example: "(playerSide in [west,independent]) AND ((rank player) isEqualTo 'COLONEL')"
	
    class Civilian
	{
	    displayName = "$STR_HG_SHOP_CIVILIAN";
		vehicles[] =
		{
		    {"CUP_C_TT650_TK_CIV",500,"true"},
			{"CUP_C_S1203_CIV",2000,"true"},
			{"CUP_C_S1203_Ambulance_CIV",2000,"true"},
			{"CUP_C_Ikarus_TKC",2500,"true"},
			{"CUP_C_Lada_GreenTK_CIV",1000,"true"},
			{"CUP_C_Lada_TK2_CIV",1000,"true"},
			{"CUP_C_LR_Transport_CTK",1500,"true"},
			{"CUP_C_V3S_Open_TKC",3000,"true"},
			{"CUP_C_V3S_Covered_TKC",3000,"true"},
			{"CUP_C_UAZ_Unarmed_TK_CIV",4000,"true"},
			{"CUP_C_UAZ_Open_TK_CIV",4000,"true"},
			{"CUP_C_Ural_Civ_01",7000,"true"},
			{"CUP_C_Volha_Blue_TKCIV",1000,"true"},
			{"CUP_C_Volha_Gray_TKCIV",1000,"true"},
			{"CUP_C_Volha_Limo_TKCIV",1000,"true"}
		};
	    spawnPoints[] =
		{
			{"civilian_vehicles_spawn_1"}
		};
	};
	
	class Military
	{
	    displayName = "$STR_HG_SHOP_MILITARY";
		vehicles[] =
		{
		    {"CUP_I_Ural_ZU23_TK_Gue",10000,"true"},
            {"CUP_I_BMP1_TK_GUE",39000,"true"},
            {"CUP_I_BRDM2_TK_Gue",7000,"true"},
            {"CUP_I_BRDM2_HQ_TK_Gue",6000,"true"},
            {"CUP_I_BTR40_MG_TKG",6000,"true"},
            {"CUP_I_BTR40_TKG",5000,"true"},
            {"CUP_I_Datsun_PK_TK",2500,"true"},
            {"CUP_I_Datsun_PK_TK_Random",2500,"true"},
            {"CUP_I_V3S_Open_TKG",3000,"true"},
            {"CUP_I_V3S_Covered_TKG",3000,"true"},
            {"CUP_I_V3S_Rearm_TKG",3000,"true"},
            {"CUP_I_V3S_Refuel_TKG",3000,"true"},
            {"CUP_I_V3S_Repair_TKG",3000,"true"},
            {"CUP_I_T34_TK_GUE",65000,"true"},
            {"CUP_I_T55_TK_GUE",80000,"true"}
	    };
		spawnPoints[] =
		{
			{"military_vehicles_spawn_1"}
		};
	};
};
