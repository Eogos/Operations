/*
    Author - HoverGuy
	© All Fucks Reserved
	Website - http://www.sunrise-production.com
	
    Defines available traders
	
	class YourDealerClass - Used as a param for the call, basically the dealer you want to display
	{
		conditionToAccess - STRING - Condition that must return either true or false, if true the player will have access to the dealer
		
		interestedIn - ARRAY OF ARRAYS - Vehicles that the dealer is interested in buying
		|- 0 - STRING - Vehicle classname
		|- 1 - INTEGER - Vehicle sell price
	};
*/

class HG_DefaultDealer // HG_DefaultDealer is just a placeholder for testing purposes, you can delete it completely and make your own
{
	conditionToAccess = "true"; // Example: "(playerSide in [west,independent]) AND ((rank player) isEqualTo 'COLONEL')"
	
	interestedIn[] = 
	{
			{"CUP_C_TT650_TK_CIV",250,"true"},
			{"CUP_C_S1203_CIV",1000,"true"},
			{"CUP_C_S1203_Ambulance_CIV",1000,"true"},
			{"CUP_C_Ikarus_TKC",1250,"true"},
			{"CUP_C_Lada_GreenTK_CIV",500,"true"},
			{"CUP_C_Lada_TK2_CIV",500,"true"},
			{"CUP_C_LR_Transport_CTK",750,"true"},
			{"CUP_C_V3S_Open_TKC",1500,"true"},
			{"CUP_C_V3S_Covered_TKC",1500,"true"},
			{"CUP_C_UAZ_Unarmed_TK_CIV",2000,"true"},
			{"CUP_C_UAZ_Open_TK_CIV",2000,"true"},
			{"CUP_C_Ural_Civ_01",3500,"true"},
			{"CUP_C_Volha_Blue_TKCIV",500,"true"},
			{"CUP_C_Volha_Gray_TKCIV",500,"true"},
			{"CUP_C_Volha_Limo_TKCIV",500,"true"},
			{"CUP_I_Ural_ZU23_TK_Gue",5000,"true"},
            {"CUP_I_BMP1_TK_GUE",19500,"true"},
            {"CUP_I_BRDM2_TK_Gue",3500,"true"},
            {"CUP_I_BRDM2_HQ_TK_Gue",3000,"true"},
            {"CUP_I_BTR40_MG_TKG",3000,"true"},
            {"CUP_I_BTR40_TKG",2500,"true"},
            {"CUP_I_Datsun_PK_TK",1250,"true"},
            {"CUP_I_Datsun_PK_TK_Random",1250,"true"},
            {"CUP_I_V3S_Open_TKG",1500,"true"},
            {"CUP_I_V3S_Covered_TKG",1500,"true"},
            {"CUP_I_V3S_Rearm_TKG",1500,"true"},
            {"CUP_I_V3S_Refuel_TKG",1500,"true"},
            {"CUP_I_V3S_Repair_TKG",1500,"true"},
            {"CUP_I_T34_TK_GUE",32500,"true"},
            {"CUP_I_T55_TK_GUE",40000,"true"}
	};
};
