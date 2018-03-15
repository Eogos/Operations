/*
    Author - HoverGuy
	© All Fucks Reserved
	Website - http://www.sunrise-production.com

    Defines available items shops
	
	class YourShopClass - Used as a param for the call, basically the shop you want to display
	{
		conditionToAccess - STRING - Condition that must return either true or false, if true the player will have access to the shop
		
		class YourShopCategory - Shop category, can be whatever you want
		{
			displayName - STRING - Category display name
			items - ARRAY OF ARRAYS - Shop content
			|- 0 - STRING - Classname
			|- 1 - INTEGER - Price
			|- 2 - STRING - Condition that must return either true or false, if true the item appears in the list else no
		};
	};
*/

class HG_DefaultShop // HG_DefaultShop is just a placeholder for testing purposes, you can delete it completely and make your own
{
	conditionToAccess = "true"; // Example: "(playerSide in [west,independent]) AND ((rank player) isEqualTo 'COLONEL')"
	
	class Items
	{
	    displayName = "$STR_HG_SHOP_ITEMS";
		items[] =
		{
		    {"ACRE_PRC117F",100,"true"},
			{"ACRE_PRC148",50,"true"},
			{"ACRE_PRC152",50,"true"},
			{"ACRE_PRC343",0,"true"},
			{"ACRE_PRC77",75,"true"},
			{"ACE_fieldDressing",1,"true"},
			{"ACE_elasticBandage",5,"true"},
			{"ACE_quikclot",5,"true"},
			{"ACE_packingBandage",5,"true"},
			{"ACE_Morphine",1,"true"},
			{"ACE_epinephrine",5,"true"},
			{"ACE_adenosine",1,"true"},
			{"ACE_personalAidKit",50,"true"},
			{"ACE_surgicalKit",25,"true"},
			{"ACE_tourniquet",3,"true"},
			{"ACE_salineIV_250",50,"true"},
			{"ACE_salineIV_500",75,"true"},
			{"ACE_salineIV",100,"true"},
			{"murshun_cigs_cigpack",10,"true"},
			{"immersion_cigs_cigar0",20,"true"},
			{"murshun_cigs_lighter",15,"true"},
			{"immersion_pops_poppack",1,"true"},
			{"murshun_cigs_matches",2,"true"},
			{"ACE_EarPlugs",0,"true"},
			{"ACE_EntrenchingTool",80,"true"},
			{"ACE_Fortify",5000,"(rank player) isEqualTo 'SERGEANT'"},
			{"ACE_Flashlight_MX991",15,"true"},
			{"ACE_CableTie",1,"true"},
			{"ACE_DefusalKit",50,"true"},
			{"ACE_DeadManSwitch",5,"true"},
			{"ACE_Clacker",20,"true"},
			{"DemoCharge_Remote_Mag",15,"true"},
			{"SatchelCharge_Remote_Mag",30,"true"},
			{"ATMine_Range_Mag",200,"true"},
			{"CUP_IED_V1_M",100,"true"},
			{"CUP_IED_V2_M",100,"true"},
			{"CUP_IED_V3_M",100,"true"},
			{"CUP_IED_V4_M",100,"true"},
			{"APERSTripMine_Wire_Mag",150,"true"},
			{"Chemlight_green",2,"true"},
			{"ACE_Chemlight_HiOrange",2,"true"},
			{"ACE_Chemlight_HiRed",2,"true"},
			{"ACE_Chemlight_HiWhite",1,"true"},
			{"HandGrenade",5,"true"},
			{"SmokeShell",1,"true"},
			{"SmokeShellRed",3,"true"},
			{"SmokeShellGreen",3,"true"},
			{"SmokeShellOrange",3,"true"},
			{"cup_muzzle_pb6p9",1000,"true"},
			{"hlc_muzzle_762sup_ak",3000,"true"},
			{"hlc_muzzle_545sup_ak",5000,"true"},
			{"cup_svd_camo_d_half",10,"true"},
			{"cup_svd_camo_d",20,"true"},
			{"cup_svd_camo_g_half",5,"true"},
			{"cup_svd_camo_g",15,"true"}
		};
	};
	
	class Magazines
	{
	    displayName = "$STR_HG_SHOP_MAGAZINES";
		items[] =
		{
		    {"CUP_100Rnd_TE4_LRT4_762x54_PK_Tracer_Green_M",47,"true"},
            {"30Rnd_762x39_Mag_Tracer_Green_F",6,"true"},
	        {"30Rnd_545x39_Mag_Tracer_Green_F",8,"true"},
			{"hlc_VOG25_AK",30,"true"},
			{"hlc_GRD_White",10,"true"},
			{"hlc_GRD_green",20,"true"},
			{"hlc_GRD_orange",20,"true"},
			{"hlc_GRD_Red",20,"true"},
			{"CUP_IlumFlareWhite_GP25_M",25,"true"},
			{"hlc_200Rnd_792x57_T_MG42",120,"true"},
			{"hlc_100Rnd_792x57_T_MG42",60,"true"},
			{"hlc_50Rnd_792x57_T_MG42",30,"true"},
			{"hlc_45Rnd_762x39_t_rpk",9,"true"},
			{"hlc_75Rnd_762x39_m_rpk",16,"true"},
			{"hlc_45Rnd_545x39_t_rpk",11,"true"},
			{"hlc_5rnd_3006_1903",3,"true"},
			{"10Rnd_303_Magazine",5,"true"},
			{"CUP_10Rnd_762x54_SVD_M",5,"true"},
			{"CUP_8Rnd_9x18_Makarov_M",2,"true"},
			{"CUP_10Rnd_B_765x17_Ball_M",2,"true"},
			{"CUP_20Rnd_B_765x17_Ball_M",5,"true"},
			{"CUP_7Rnd_45ACP_1911",2,"true"}
		};
	};
	
	class Scopes
	{
	    displayName = "$STR_HG_SHOP_SCOPES";
		items[] =
		{
		    {"hlc_optic_kobra",450,"true"},
			{"bnae_scope_v3_virtual",250,"true"},
			{"cup_optic_pso_1",400,"true"},
			{"cup_optic_goshawk",10000,"true"}
		};
	};
};
