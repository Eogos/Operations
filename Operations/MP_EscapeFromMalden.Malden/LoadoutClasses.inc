class CfgRoles
{
	class Assault
	{
		displayName = $STR_A3_Role_Assault;
		icon = "a3\missions_f_exp\data\img\classes\assault_ca.paa";
	};
	class Support
	{
		displayName = $STR_A3_Role_Support;
		icon = "a3\missions_f_exp\data\img\classes\support_ca.paa";
	};
	class Recon
	{
		displayName = $STR_A3_Role_Recon;
		icon = "a3\missions_f_exp\data\img\classes\recon_ca.paa";
	};
};

class CfgRespawnInventory
{
	//*******************
	// Standard equipment
	//*******************
	class O_SquadLeader
	{
		displayName = $STR_b_soldier_sl_f0;
		role = "Assault";
		icon = "\A3\ui_f\data\map\VehicleIcons\iconManLeader_ca.paa";
		show = "side group _this == east";
		weapons[] = {
			"arifle_Katiba_F",
			"Rangefinder",
			"hgun_Pistol_heavy_02_F"
		};
		magazines[] = {
			"SmokeShell",
			"SmokeShell",
			"6Rnd_45ACP_Cylinder",
			"6Rnd_45ACP_Cylinder",
			"6Rnd_45ACP_Cylinder",
			"30Rnd_65x39_caseless_green_mag_Tracer",
			"30Rnd_65x39_caseless_green_mag_Tracer",
			"30Rnd_65x39_caseless_green_mag_Tracer",
			"30Rnd_65x39_caseless_green_mag_Tracer",
			"30Rnd_65x39_caseless_green_mag_Tracer",
			"30Rnd_65x39_caseless_green_mag_Tracer",
			"30Rnd_65x39_caseless_green_mag_Tracer",
			"30Rnd_65x39_caseless_green_mag_Tracer",
			"HandGrenade",
			"HandGrenade"
		};
		items[] = {
			"FirstAidKit"
		};
		linkedItems[] = {
			"V_TacVest_khk",
			"H_HelmetLeaderO_ocamo",
			"optic_Arco_blk_F",
			"acc_pointer_IR",
			"NVGoggles_OPFOR",
			"ItemGPS",
			"ItemMap",
			"ItemCompass",
			"ItemWatch",
			"ItemRadio"
		};
		uniformClass = "U_O_CombatUniform_ocamo";
	};
	class O_Marksman
	{
		displayName = $STR_b_soldier_m_f0;
		role = "Assault";
		icon = "\A3\ui_f\data\map\VehicleIcons\iconMan_ca.paa";
		show = "side group _this == east";
		weapons[] = {
			"srifle_DMR_01_F",
			"Rangefinder",
			"hgun_Rook40_F"
		};
		magazines[] = {
			"SmokeShell",
			"SmokeShell",
			"16Rnd_9x21_Mag",
			"16Rnd_9x21_Mag",
			"16Rnd_9x21_Mag",
			"10Rnd_762x54_Mag",
			"10Rnd_762x54_Mag",
			"10Rnd_762x54_Mag",
			"10Rnd_762x54_Mag",
			"10Rnd_762x54_Mag",
			"10Rnd_762x54_Mag",
			"10Rnd_762x54_Mag",
			"10Rnd_762x54_Mag",
			"10Rnd_762x54_Mag",
			"10Rnd_762x54_Mag",
			"10Rnd_762x54_Mag",
			"10Rnd_762x54_Mag",
			"HandGrenade",
			"HandGrenade"
		};
		items[] = {
			"FirstAidKit"
		};
		linkedItems[] = {
			"V_HarnessO_brn",
			"H_HelmetSpecO_ocamo",
			"optic_dms",
			"bipod_02_F_blk",
			"NVGoggles_OPFOR",
			"ItemGPS",
			"ItemMap",
			"ItemCompass",
			"ItemWatch",
			"ItemRadio"
		};
		uniformClass = "U_O_CombatUniform_ocamo";
	};
	class O_Autorifleman
	{
		displayName = $STR_b_soldier_ar_f0;
		role = "Assault";
		icon = "\A3\ui_f\data\map\VehicleIcons\iconManMG_ca.paa";
		show = "side group _this == east";
		weapons[] = {
			"LMG_Zafir_F",
			"hgun_Rook40_F"
		};
		magazines[] = {
			"SmokeShell",
			"SmokeShell",
			"16Rnd_9x21_Mag",
			"16Rnd_9x21_Mag",
			"16Rnd_9x21_Mag",
			"150Rnd_762x54_Box",
			"150Rnd_762x54_Box",
			"150Rnd_762x54_Box",
			"HandGrenade",
			"HandGrenade"
		};
		items[] = {
			"FirstAidKit"
		};
		linkedItems[] = {
			"V_HarnessO_brn",
			"H_HelmetO_ocamo",
			"acc_pointer_IR",
			"NVGoggles_OPFOR",
			"ItemGPS",
			"ItemMap",
			"ItemCompass",
			"ItemWatch",
			"ItemRadio"
		};
		uniformClass = "U_O_CombatUniform_ocamo";
	};
	class O_Grenadier
	{
		displayName = $STR_b_soldier_gl_f0;
		role = "Assault";
		icon = "\A3\ui_f\data\map\VehicleIcons\iconMan_ca.paa";
		show = "side group _this == east";
		weapons[] = {
			"arifle_Katiba_GL_F",
			"hgun_Rook40_F"
		};
		magazines[] = {
			"SmokeShell",
			"SmokeShell",
			"16Rnd_9x21_Mag",
			"16Rnd_9x21_Mag",
			"16Rnd_9x21_Mag",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green",
			"HandGrenade",
			"HandGrenade",
			"1Rnd_HE_Grenade_shell",
			"1Rnd_HE_Grenade_shell",
			"1Rnd_HE_Grenade_shell",
			"1Rnd_HE_Grenade_shell",
			"1Rnd_HE_Grenade_shell",
			"1Rnd_HE_Grenade_shell"
		};
		items[] = {
			"FirstAidKit"
		};
		linkedItems[] = {
			"V_HarnessOGL_brn",
			"H_HelmetO_ocamo",
			"optic_ACO_grn",
			"acc_pointer_IR",
			"NVGoggles_OPFOR",
			"ItemGPS",
			"ItemMap",
			"ItemCompass",
			"ItemWatch",
			"ItemRadio"
		};
		uniformClass = "U_O_CombatUniform_ocamo";
	};
	class O_Rifleman
	{
		displayName = $STR_A3_cfgvehicles_b_soldier_f0;
		role = "Assault";
		icon = "\A3\ui_f\data\map\VehicleIcons\iconMan_ca.paa";
		show = "side group _this == east";
		weapons[] = {
			"arifle_Katiba_F",
			"hgun_Rook40_F"
		};
		magazines[] = {
			"SmokeShell",
			"SmokeShell",
			"16Rnd_9x21_Mag",
			"16Rnd_9x21_Mag",
			"16Rnd_9x21_Mag",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green",
			"HandGrenade",
			"HandGrenade"
		};
		items[] = {
			"FirstAidKit"
		};
		linkedItems[] = {
			"V_HarnessO_brn",
			"H_HelmetO_ocamo",
			"optic_ACO_grn",
			"acc_pointer_IR",
			"NVGoggles_OPFOR",
			"ItemGPS",
			"ItemMap",
			"ItemCompass",
			"ItemWatch",
			"ItemRadio"
		};
		uniformClass = "U_O_CombatUniform_ocamo";
	};
        class O_AT
	{
		displayName = $STR_b_soldier_lat_f0;
		role = "Assault";
		icon = "\A3\ui_f\data\map\VehicleIcons\iconManAT_ca.paa";
		show = "side group _this == east";
		weapons[] = {
			"arifle_Katiba_F",
			"hgun_Rook40_F",
			"launch_RPG32_F"
		};
		magazines[] = {
			"SmokeShell",
			"SmokeShell",
			"16Rnd_9x21_Mag",
			"16Rnd_9x21_Mag",
			"16Rnd_9x21_Mag",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green",
			"HandGrenade",
			"HandGrenade",
			"RPG32_F",
			"RPG32_F",
			"RPG32_HE_F"
		};
		items[] = {
			"FirstAidKit"
		};
		linkedItems[] = {
			"V_HarnessO_brn",
			"H_HelmetO_ocamo",
			"optic_ACO_grn",
			"acc_pointer_IR",
			"NVGoggles_OPFOR",
			"ItemGPS",
			"ItemMap",
			"ItemCompass",
			"ItemWatch",
			"ItemRadio"
		};
		uniformClass = "U_O_CombatUniform_ocamo";
		backpack = "B_FieldPack_ocamo";
	};
        class O_Engineer
	{
		displayName = $STR_b_engineer_f0;
		role = "Support";
		icon = "\A3\ui_f\data\map\VehicleIcons\iconManEngineer_ca.paa";
		show = "side group _this == east";
		weapons[] = {
			"arifle_Katiba_C_F",
			"hgun_Rook40_F"
		};
		magazines[] = {
			"SmokeShell",
			"SmokeShell",
			"16Rnd_9x21_Mag",
			"16Rnd_9x21_Mag",
			"16Rnd_9x21_Mag",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green",
			"DemoCharge_Remote_Mag",
			"DemoCharge_Remote_Mag"
		};
		items[] = {
			"FirstAidKit",
			"Toolkit",
			"MineDetector"
		};
		linkedItems[] = {
			"V_HarnessO_brn",
			"H_HelmetO_ocamo",
			"optic_ACO_grn",
			"acc_pointer_IR",
			"NVGoggles_OPFOR",
			"ItemGPS",
			"ItemMap",
			"ItemCompass",
			"ItemWatch",
			"ItemRadio"
		};
		uniformClass = "U_O_CombatUniform_ocamo";
		backpack = "B_AssaultPack_ocamo";
	};
	class O_CombatLifesaver
	{
		displayName = $STR_b_medic_f0;
		role = "Support";
		icon = "\A3\ui_f\data\map\VehicleIcons\iconManMedic_ca.paa";
		show = "side group _this == east";
		weapons[] = {
			"arifle_Katiba_C_F",
			"hgun_Rook40_F"
		};
		magazines[] = {
			"SmokeShellRed",
			"SmokeShellRed",
			"SmokeShellRed",
			"SmokeShellRed",
			"16Rnd_9x21_Mag",
			"16Rnd_9x21_Mag",
			"16Rnd_9x21_Mag",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green"
		};
		items[] = {
			"FirstAidKit",
			"Medikit"
		};
		linkedItems[] = {
			"V_TacVest_khk",
			"H_HelmetO_ocamo",
			"optic_ACO_grn",
			"acc_pointer_IR",
			"NVGoggles_OPFOR",
			"ItemGPS",
			"ItemMap",
			"ItemCompass",
			"ItemWatch",
			"ItemRadio"
		};
		uniformClass = "U_O_CombatUniform_ocamo";
		backpack = "B_AssaultPack_ocamo";
	};
	//******************
	// Limited equipment
	//******************
	class O_SquadLeader_L
	{
		displayName = $STR_b_soldier_sl_f0;
		role = "Assault";
		icon = "\A3\ui_f\data\map\VehicleIcons\iconManLeader_ca.paa";
		show = "side group _this == east";
		weapons[] = {
			"arifle_Katiba_F",
			"Binocular",
			"hgun_Pistol_heavy_02_F"
		};
		magazines[] = {
			"SmokeShell",
			"SmokeShell",
			"6Rnd_45ACP_Cylinder",
			"6Rnd_45ACP_Cylinder",
			"6Rnd_45ACP_Cylinder",
			"30Rnd_65x39_caseless_green_mag_Tracer",
			"30Rnd_65x39_caseless_green_mag_Tracer",
			"30Rnd_65x39_caseless_green_mag_Tracer",
			"30Rnd_65x39_caseless_green_mag_Tracer",
			"HandGrenade",
			"HandGrenade"
		};
		items[] = {
			"FirstAidKit"
		};
		linkedItems[] = {
			"V_TacVest_khk",
			"H_HelmetLeaderO_ocamo",
			"optic_Arco_blk_F",
			"NVGoggles_OPFOR",
			"ItemGPS",
			"ItemMap",
			"ItemCompass",
			"ItemWatch",
			"ItemRadio"
		};
		uniformClass = "U_O_CombatUniform_ocamo";
	};
	class O_Marksman_L
	{
		displayName = $STR_b_soldier_m_f0;
		role = "Assault";
		icon = "\A3\ui_f\data\map\VehicleIcons\iconMan_ca.paa";
		show = "side group _this == east";
		weapons[] = {
			"srifle_DMR_01_F",
			"Binocular",
			"hgun_Rook40_F"
		};
		magazines[] = {
			"SmokeShell",
			"SmokeShell",
			"16Rnd_9x21_Mag",
			"16Rnd_9x21_Mag",
			"16Rnd_9x21_Mag",
			"10Rnd_762x54_Mag",
			"10Rnd_762x54_Mag",
			"10Rnd_762x54_Mag",
			"10Rnd_762x54_Mag",
			"10Rnd_762x54_Mag",
			"10Rnd_762x54_Mag",
			"HandGrenade",
			"HandGrenade"
		};
		items[] = {
			"FirstAidKit"
		};
		linkedItems[] = {
			"V_HarnessO_brn",
			"H_HelmetSpecO_ocamo",
			"optic_dms",
			"bipod_02_F_blk",
			"NVGoggles_OPFOR",
			"ItemMap",
			"ItemCompass",
			"ItemWatch",
			"ItemRadio"
		};
		uniformClass = "U_O_CombatUniform_ocamo";
	};
	class O_Autorifleman_L
	{
		displayName = $STR_b_soldier_ar_f0;
		role = "Assault";
		icon = "\A3\ui_f\data\map\VehicleIcons\iconManMG_ca.paa";
		show = "side group _this == east";
		weapons[] = {
			"LMG_Zafir_F",
			"hgun_Rook40_F"
		};
		magazines[] = {
			"SmokeShell",
			"SmokeShell",
			"16Rnd_9x21_Mag",
			"16Rnd_9x21_Mag",
			"16Rnd_9x21_Mag",
			"150Rnd_762x54_Box",
			"150Rnd_762x54_Box",
			"HandGrenade",
			"HandGrenade"
		};
		items[] = {
			"FirstAidKit"
		};
		linkedItems[] = {
			"V_HarnessO_brn",
			"H_HelmetO_ocamo",
			"NVGoggles_OPFOR",
			"ItemMap",
			"ItemCompass",
			"ItemWatch",
			"ItemRadio"
		};
		uniformClass = "U_O_CombatUniform_ocamo";
	};
	class O_Grenadier_L
	{
		displayName = $STR_b_soldier_gl_f0;
		role = "Assault";
		icon = "\A3\ui_f\data\map\VehicleIcons\iconMan_ca.paa";
		show = "side group _this == east";
		weapons[] = {
			"arifle_Katiba_GL_F",
			"hgun_Rook40_F"
		};
		magazines[] = {
			"SmokeShell",
			"SmokeShell",
			"16Rnd_9x21_Mag",
			"16Rnd_9x21_Mag",
			"16Rnd_9x21_Mag",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green",
			"HandGrenade",
			"HandGrenade",
			"1Rnd_HE_Grenade_shell",
			"1Rnd_HE_Grenade_shell",
			"1Rnd_HE_Grenade_shell",
			"1Rnd_HE_Grenade_shell"
		};
		items[] = {
			"FirstAidKit"
		};
		linkedItems[] = {
			"V_HarnessOGL_brn",
			"H_HelmetO_ocamo",
			"optic_ACO_grn",
			"NVGoggles_OPFOR",
			"ItemMap",
			"ItemCompass",
			"ItemWatch",
			"ItemRadio"
		};
		uniformClass = "U_O_CombatUniform_ocamo";
	};
	class O_Rifleman_L
	{
		displayName = $STR_A3_cfgvehicles_b_soldier_f0;
		role = "Assault";
		icon = "\A3\ui_f\data\map\VehicleIcons\iconMan_ca.paa";
		show = "side group _this == east";
		weapons[] = {
			"arifle_Katiba_F",
			"hgun_Rook40_F"
		};
		magazines[] = {
			"SmokeShell",
			"SmokeShell",
			"16Rnd_9x21_Mag",
			"16Rnd_9x21_Mag",
			"16Rnd_9x21_Mag",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green",
			"HandGrenade",
			"HandGrenade"
		};
		items[] = {
			"FirstAidKit"
		};
		linkedItems[] = {
			"V_HarnessO_brn",
			"H_HelmetO_ocamo",
			"optic_ACO_grn",
			"NVGoggles_OPFOR",
			"ItemMap",
			"ItemCompass",
			"ItemWatch",
			"ItemRadio"
		};
		uniformClass = "U_O_CombatUniform_ocamo";
	};
        class O_AT_L
	{
		displayName = $STR_b_soldier_lat_f0;
		role = "Assault";
		icon = "\A3\ui_f\data\map\VehicleIcons\iconManAT_ca.paa";
		show = "side group _this == east";
		weapons[] = {
			"arifle_Katiba_F",
			"hgun_Rook40_F",
			"launch_RPG32_F"
		};
		magazines[] = {
			"SmokeShell",
			"SmokeShell",
			"16Rnd_9x21_Mag",
			"16Rnd_9x21_Mag",
			"16Rnd_9x21_Mag",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green",
			"HandGrenade",
			"HandGrenade",
			"RPG32_F",
			"RPG32_F",
			"RPG32_HE_F"
		};
		items[] = {
			"FirstAidKit"
		};
		linkedItems[] = {
			"V_HarnessO_brn",
			"H_HelmetO_ocamo",
			"optic_ACO_grn",
			"NVGoggles_OPFOR",
			"ItemMap",
			"ItemCompass",
			"ItemWatch",
			"ItemRadio"
		};
		uniformClass = "U_O_CombatUniform_ocamo";
		backpack = "B_FieldPack_ocamo";
	};
        class O_Engineer_L
	{
		displayName = $STR_b_engineer_f0;
		role = "Support";
		icon = "\A3\ui_f\data\map\VehicleIcons\iconManEngineer_ca.paa";
		show = "side group _this == east";
		weapons[] = {
			"arifle_Katiba_C_F",
			"hgun_Rook40_F"
		};
		magazines[] = {
			"SmokeShell",
			"SmokeShell",
			"16Rnd_9x21_Mag",
			"16Rnd_9x21_Mag",
			"16Rnd_9x21_Mag",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green",
			"DemoCharge_Remote_Mag",
			"DemoCharge_Remote_Mag"
		};
		items[] = {
			"FirstAidKit",
			"Toolkit",
			"MineDetector"
		};
		linkedItems[] = {
			"V_HarnessO_brn",
			"H_HelmetO_ocamo",
			"optic_ACO_grn",
			"NVGoggles_OPFOR",
			"ItemMap",
			"ItemCompass",
			"ItemWatch",
			"ItemRadio"
		};
		uniformClass = "U_O_CombatUniform_ocamo";
		backpack = "B_AssaultPack_ocamo";
	};
	class O_CombatLifesaver_L
	{
		displayName = $STR_b_medic_f0;
		role = "Support";
		icon = "\A3\ui_f\data\map\VehicleIcons\iconManMedic_ca.paa";
		show = "side group _this == east";
		weapons[] = {
			"arifle_Katiba_C_F",
			"hgun_Rook40_F"
		};
		magazines[] = {
			"SmokeShellRed",
			"SmokeShellRed",
			"SmokeShellRed",
			"SmokeShellRed",
			"16Rnd_9x21_Mag",
			"16Rnd_9x21_Mag",
			"16Rnd_9x21_Mag",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green"
		};
		items[] = {
			"FirstAidKit",
			"Medikit"
		};
		linkedItems[] = {
			"V_TacVest_khk",
			"H_HelmetO_ocamo",
			"optic_ACO_grn",
			"NVGoggles_OPFOR",
			"ItemMap",
			"ItemCompass",
			"ItemWatch",
			"ItemRadio"
		};
		uniformClass = "U_O_CombatUniform_ocamo";
		backpack = "B_AssaultPack_ocamo";
	};
	//*********
	// Survivor
	//*********
	class O_SquadLeader_S
	{
		displayName = $STR_b_soldier_sl_f0;
		role = "Assault";
		icon = "\A3\ui_f\data\map\VehicleIcons\iconManLeader_ca.paa";
		show = "side group _this == east";
		weapons[] = {
			"arifle_Katiba_F",
			"Binocular",
			"hgun_Pistol_heavy_02_F"
		};
		magazines[] = {
			"SmokeShell",
			"SmokeShell",
			"6Rnd_45ACP_Cylinder",
			"6Rnd_45ACP_Cylinder",
			"6Rnd_45ACP_Cylinder",
			"30Rnd_65x39_caseless_green_mag_Tracer",
			"30Rnd_65x39_caseless_green_mag_Tracer",
			"HandGrenade",
			"HandGrenade"
		};
		items[] = {
			"FirstAidKit"
		};
		linkedItems[] = {
			"V_TacVest_khk",
			"H_HelmetLeaderO_ocamo",
			"NVGoggles_OPFOR",
			"ItemMap",
			"ItemCompass",
			"ItemWatch",
			"ItemRadio"
		};
		uniformClass = "U_O_CombatUniform_ocamo";
	};
	class O_Marksman_S
	{
		displayName = $STR_b_soldier_m_f0;
		role = "Assault";
		icon = "\A3\ui_f\data\map\VehicleIcons\iconMan_ca.paa";
		show = "side group _this == east";
		weapons[] = {
			"srifle_DMR_01_F",
			"hgun_Rook40_F"
		};
		magazines[] = {
			"SmokeShell",
			"SmokeShell",
			"16Rnd_9x21_Mag",
			"16Rnd_9x21_Mag",
			"16Rnd_9x21_Mag",
			"10Rnd_762x54_Mag",
			"10Rnd_762x54_Mag",
			"10Rnd_762x54_Mag",
			"HandGrenade",
			"HandGrenade"
		};
		items[] = {
			"FirstAidKit"
		};
		linkedItems[] = {
			"V_HarnessO_brn",
			"H_HelmetSpecO_ocamo",
			"bipod_02_F_blk",
			"NVGoggles_OPFOR",
			"ItemMap",
			"ItemCompass",
			"ItemWatch",
			"ItemRadio"
		};
		uniformClass = "U_O_CombatUniform_ocamo";
	};
	class O_Autorifleman_S
	{
		displayName = $STR_b_soldier_ar_f0;
		role = "Assault";
		icon = "\A3\ui_f\data\map\VehicleIcons\iconManMG_ca.paa";
		show = "side group _this == east";
		weapons[] = {
			"LMG_Zafir_F",
			"hgun_Rook40_F"
		};
		magazines[] = {
			"SmokeShell",
			"SmokeShell",
			"16Rnd_9x21_Mag",
			"16Rnd_9x21_Mag",
			"16Rnd_9x21_Mag",
			"150Rnd_762x54_Box",
			"HandGrenade",
			"HandGrenade"
		};
		items[] = {
			"FirstAidKit"
		};
		linkedItems[] = {
			"V_HarnessO_brn",
			"H_HelmetO_ocamo",
			"NVGoggles_OPFOR",
			"ItemMap",
			"ItemCompass",
			"ItemWatch",
			"ItemRadio"
		};
		uniformClass = "U_O_CombatUniform_ocamo";
	};
	class O_Grenadier_S
	{
		displayName = $STR_b_soldier_gl_f0;
		role = "Assault";
		icon = "\A3\ui_f\data\map\VehicleIcons\iconMan_ca.paa";
		show = "side group _this == east";
		weapons[] = {
			"arifle_Katiba_GL_F",
			"hgun_Rook40_F"
		};
		magazines[] = {
			"SmokeShell",
			"SmokeShell",
			"16Rnd_9x21_Mag",
			"16Rnd_9x21_Mag",
			"16Rnd_9x21_Mag",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green",
			"HandGrenade",
			"HandGrenade",
			"1Rnd_HE_Grenade_shell",
			"1Rnd_HE_Grenade_shell"
		};
		items[] = {
			"FirstAidKit"
		};
		linkedItems[] = {
			"V_HarnessOGL_brn",
			"H_HelmetO_ocamo",
			"NVGoggles_OPFOR",
			"ItemMap",
			"ItemCompass",
			"ItemWatch",
			"ItemRadio"
		};
		uniformClass = "U_O_CombatUniform_ocamo";
	};
	class O_Rifleman_S
	{
		displayName = $STR_A3_cfgvehicles_b_soldier_f0;
		role = "Assault";
		icon = "\A3\ui_f\data\map\VehicleIcons\iconMan_ca.paa";
		show = "side group _this == east";
		weapons[] = {
			"arifle_Katiba_F",
			"hgun_Rook40_F"
		};
		magazines[] = {
			"SmokeShell",
			"SmokeShell",
			"16Rnd_9x21_Mag",
			"16Rnd_9x21_Mag",
			"16Rnd_9x21_Mag",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green",
			"HandGrenade",
			"HandGrenade"
		};
		items[] = {
			"FirstAidKit"
		};
		linkedItems[] = {
			"V_HarnessO_brn",
			"H_HelmetO_ocamo",
			"NVGoggles_OPFOR",
			"ItemMap",
			"ItemCompass",
			"ItemWatch",
			"ItemRadio"
		};
		uniformClass = "U_O_CombatUniform_ocamo";
	};
        class O_AT_S
	{
		displayName = $STR_b_soldier_lat_f0;
		role = "Assault";
		icon = "\A3\ui_f\data\map\VehicleIcons\iconManAT_ca.paa";
		show = "side group _this == east";
		weapons[] = {
			"arifle_Katiba_F",
			"hgun_Rook40_F",
			"launch_RPG32_F"
		};
		magazines[] = {
			"SmokeShell",
			"SmokeShell",
			"16Rnd_9x21_Mag",
			"16Rnd_9x21_Mag",
			"16Rnd_9x21_Mag",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green",
			"HandGrenade",
			"HandGrenade",
			"RPG32_F",
			"RPG32_F",
			"RPG32_HE_F"
		};
		items[] = {
			"FirstAidKit"
		};
		linkedItems[] = {
			"V_HarnessO_brn",
			"H_HelmetO_ocamo",
			"NVGoggles_OPFOR",
			"ItemMap",
			"ItemCompass",
			"ItemWatch",
			"ItemRadio"
		};
		uniformClass = "U_O_CombatUniform_ocamo";
		backpack = "B_FieldPack_ocamo";
	};
        class O_Engineer_S
	{
		displayName = $STR_b_engineer_f0;
		role = "Support";
		icon = "\A3\ui_f\data\map\VehicleIcons\iconManEngineer_ca.paa";
		show = "side group _this == east";
		weapons[] = {
			"arifle_Katiba_C_F",
			"hgun_Rook40_F"
		};
		magazines[] = {
			"SmokeShell",
			"SmokeShell",
			"16Rnd_9x21_Mag",
			"16Rnd_9x21_Mag",
			"16Rnd_9x21_Mag",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green",
			"DemoCharge_Remote_Mag",
			"DemoCharge_Remote_Mag"
		};
		items[] = {
			"FirstAidKit",
			"Toolkit",
			"MineDetector"
		};
		linkedItems[] = {
			"V_HarnessO_brn",
			"H_HelmetO_ocamo",
			"NVGoggles_OPFOR",
			"ItemMap",
			"ItemCompass",
			"ItemWatch",
			"ItemRadio"
		};
		uniformClass = "U_O_CombatUniform_ocamo";
		backpack = "B_AssaultPack_ocamo";
	};
	class O_CombatLifesaver_S
	{
		displayName = $STR_b_medic_f0;
		role = "Support";
		icon = "\A3\ui_f\data\map\VehicleIcons\iconManMedic_ca.paa";
		show = "side group _this == east";
		weapons[] = {
			"arifle_Katiba_C_F",
			"hgun_Rook40_F"
		};
		magazines[] = {
			"SmokeShellRed",
			"SmokeShellRed",
			"SmokeShellRed",
			"SmokeShellRed",
			"16Rnd_9x21_Mag",
			"16Rnd_9x21_Mag",
			"16Rnd_9x21_Mag",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green"
		};
		items[] = {
			"FirstAidKit",
			"Medikit"
		};
		linkedItems[] = {
			"V_TacVest_khk",
			"H_HelmetO_ocamo",
			"NVGoggles_OPFOR",
			"ItemMap",
			"ItemCompass",
			"ItemWatch",
			"ItemRadio"
		};
		uniformClass = "U_O_CombatUniform_ocamo";
		backpack = "B_AssaultPack_ocamo";
	};
};
