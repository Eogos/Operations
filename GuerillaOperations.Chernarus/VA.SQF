
// INIT SCRIPT
// this addAction["Open Virtual Arsenal", {null = [_this] execVM "virtual_arsenal_init.sqf";}];

_crate = _this select 0 select 0;
_caller = _this select 0 select 1;
_id = _this select 0 select 2;
_crate removeAction _id;

clearMagazineCargoGlobal _crate;
clearWeaponCargoGlobal _crate;
clearItemCargoGlobal _crate;
clearBackpackCargoGlobal _crate;

["AmmoboxInit",[_crate,false,{true}]] spawn BIS_fnc_arsenal;

_availableHeadgear = [
        "H_Shemag_olive",
        "H_ShemagOpen_tan",
        "H_Bandanna_khk",
        "H_Bandanna_camo",
        "H_Cap_oli",
        "H_Booniehat_oli",
        "H_Booniehat_oli",
        "MNP_MC_USW",
        "MNP_MC_OD"
        ];

_availableGoggles = [
	      "G_Balaclava_oli",
        "G_Balaclava_blk",
        "G_Bandanna_oli",
        "G_Bandanna_khk",
        "G_Bandanna_shades",
        "G_Bandanna_aviator",
        "G_Bandanna_beast",
        "TRYK_kio_balaclava_BLK"
        ];

_availableUniforms = [
	"U_BG_Guerrilla_6_1",
        "U_BG_Guerilla1_1",
        "U_BG_leader"
        ];

_availableVests = [
	      "V_TacVest_camo",
        "V_TacVest_oli",
        "V_Chestrig_oli",
        "V_Chestrig_rgr",
        "TRYK_LOC_AK_chestrig_OD",
        "MNP_V_M81_Harness",
        "CUP_B_CivPack_WDL"
        ];

_availableBackpacks = [
	      "B_FieldPack_khk",
        "B_FieldPack_oli",
        "B_TacticalPack_oli",
        "B_Carryall_oli",
        "CUP_B_AlicePack_Khaki"
        ];

_availableMagazines = [
        "hlc_VOG25_AK",
        "hlc_GRD_White",
        "hlc_GRD_Red",
        "hlc_GRD_green",
        "hlc_GRD_yellow",
        "hlc_GRD_purple",
        "hlc_GRD_blue",
        "hlc_GRD_orange",
        "hlc_30Rnd_545x39_B_AK",
        "hlc_30Rnd_762x39_b_ak",
        "hlc_20rnd_762x51_b_G3",
        "hlc_20Rnd_762x51_B_fal",
        "hlc_75Rnd_762x39_m_rpk",
        "hlc_45Rnd_545x39_t_rpk",
        "hlc_10rnd_12g_buck_S12",
        "hlc_10rnd_12g_slug_S12",
        "20Rnd_762x51_Mag",
        "CUP_5Rnd_127x108_KSVK_M",
        "CUP_10x_303_M",
        "CUP_5x_22_LR_17_HMR_M",
        "RH_16Rnd_9x19_CZ",
        "RH_7Rnd_45cal_m1911",
        "RH_8Rnd_9x18_Mak",
        "RH_8Rnd_762_tt33",
        "HandGrenade",
        "SmokeShell",
        "SmokeShellYellow",
        "SmokeShellOrange",
        "Chemlight_green",
        "Chemlight_red",
        "Chemlight_yellow",
        "Chemlight_blue",
        "ACE_HandFlare_White",
        "ACE_HandFlare_Red",
        "ACE_HandFlare_Green",
        "ACE_HandFlare_Yellow",
        "IEDLandSmall_Remote_Mag",
        "IEDUrbanSmall_Remote_Mag"
];

_availableAttachments = [
        "HLC_Optic_1p29",
        "hlc_optic_kobra",
        "hlc_optic_suit",
        "hlc_optic_accupoint_g3",
        "HLC_Optic_ZFSG1",
        "ACE_optic_SOS_2D"
];

_availableWeapons = [
        "hlc_rifle_g3sg1",
        "hlc_rifle_ak74_dirty",
        "hlc_rifle_akmgl",
        "hlc_rifle_c1A1",
        "hlc_rifle_rpk74n",
        "srifle_DMR_06_olive_F",
        "hlc_rifle_saiga12k",
        "hlc_rifle_rpk",
        "CUP_srifle_CZ550",
        "CUP_srifle_ksvk",
        "hlc_rifle_aks74",
        "hlc_rifle_aks74u",
        "hlc_rifle_aks74_GL",
        "hlc_rifle_ak47",
        "CUP_srifle_LeeEnfield_rail",
        "RH_cz75",
        "RH_m1911",
        "RH_tt33",
        "RH_mak"
        ];

_availableItems = [
        "Binocular",
        "ACE_Vector",
        "ItemMap",
        "ACRE_PRC148",
        "ItemCompass",
        "ItemWatch",
        "ACE_EarPlugs",
        "ACE_Flashlight_XL50",
        "ACE_DeadManSwitch",
        "MCC_multiTool",
        "ACE_Cellphone",
        "ACE_RangeCard",
        "ACE_Sandbag_empty",
        "ACE_bodyBag",
        "ACE_fieldDressing",
        "ACE_packingBandage",
        "ACE_elasticBandage",
        "ACE_tourniquet",
        "ACE_morphine",
        "ACE_epinephrine",
        "ACE_personalAidKit"
        ];

//Populate with predefined items and whatever is already in the crate
[_crate,((backpackCargo _crate) + _availableBackpacks)] call BIS_fnc_addVirtualBackpackCargo;
[_crate,((itemCargo _crate) + _availableHeadgear + _availableGoggles + _availableUniforms + _availableVests + _availableAttachments + _availableItems )] call BIS_fnc_addVirtualItemCargo;
[_crate,((magazineCargo _crate) + _availableMagazines )] call BIS_fnc_addVirtualMagazineCargo;
[_crate,((weaponCargo _crate) +_availableWeapons)] call BIS_fnc_addVirtualWeaponCargo;
