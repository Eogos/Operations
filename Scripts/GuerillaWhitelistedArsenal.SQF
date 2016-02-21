nul = [this, -1, west, "MEDIUM"] execVM "R3F_LOG\USER_FUNCT\init_creation_factory.sqf";
clearMagazineCargo this; clearItemCargo this; clearWeaponCargo this;
//Init stuff
_crate = _this select 0;
["AmmoboxInit",[_crate,false,{true}]] spawn BIS_fnc_arsenal;

//Lists of items to include
_availableHeadgear = [
        "H_Shemag_olive",
        "H_ShemagOpen_tan",
        "H_Bandanna_khk",
        "H_Bandanna_camo",
        "H_Cap_oli",
        "H_Booniehat_oli",
        "H_Booniehat_oli",
        "MNP_MC_USW",
        "MNP_MC_OD";
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
        "RH_mak",
];

_availableItems = [
        "Binocular",
        "ACE_Vector",
        "ItemMap",
        "ACRE_PRC148_ID_1",
        "ItemCompass",
        "ItemWatch",
];
//Populate with predefined items and whatever is already in the crate
[_crate,((backpackCargo _crate) + _availableBackpacks)] call BIS_fnc_addVirtualBackpackCargo;
[_crate,((itemCargo _crate) + _availableHeadgear + _availableGoggles + _availableUniforms + _availableVests)] call BIS_fnc_addVirtualItemCargo;
[_crate,(magazineCargo _crate)] call BIS_fnc_addVirtualMagazineCargo;
[_crate,(weaponCargo _crate) + _availableWeapons] call BIS_fnc_addVirtualWeaponCargo;
