private ["_unit","_f1","_f2","_f3","_uniF","_hats","_vI","_uI","_vests","_inv","_weR","_maR","_t","_nul"];
_f1 = {
private ["_unit","_typ","_cW","_c"];
//MAGAZINE CARGO
_cW = _this select 0;
_unit = _this select 1;
_typ = _this select 2;
_c = count (_cW select 0) - 1;
if (_c < 0) exitWith {};
for "_i" from 0 to _c do {
private ["_class"];
_class = (_cW select 0) select _i;
_num = (_cW select 1) select _i;
while {_num > 0} do {
_num = _num -1;
switch (_typ) do {
case "U": {(uniformContainer _unit) addMagazineCargo [_class , 1];};
case "V": {(vestContainer _unit) addMagazineCargo [_class , 1];};
case "B": {(backpackContainer _unit) addMagazineCargo [_class , 1];};
};
};
};
};

_f2 = {
private ["_unit","_typ","_cW","_c"];
//ITEM CARGO
_cW = _this select 0;
_unit = _this select 1;
_typ = _this select 2;
_c = count (_cW select 0) - 1;
if (_c < 0) exitWith {};
for "_i" from 0 to _c do {
private ["_class","_nameA","_f"];
_class = (_cW select 0) select _i;
_num = (_cW select 1) select _i;
while {_num > 0} do {
_num = _num -1;
switch (_typ) do {
case "U": {(uniformContainer _unit) addItemCargo [_class , 1];};
case "V": {(vestContainer _unit) addItemCargo [_class , 1];};
case "B": {(backpackContainer _unit) addItemCargo [_class , 1];};
};
};
};
};
_f3 = {
private ["_unit","_typ","_cW","_c"];
//WEAPON CARGO
_cW = _this select 0;
_unit = _this select 1;
_typ = _this select 2;
_c = count (_cW select 0) - 1;
if (_c < 0) exitWith {};
for "_i" from 0 to _c do {
private ["_class","_nameA","_f"];
_class = (_cW select 0) select _i;
_num = (_cW select 1) select _i;
while {_num > 0} do {
_num = _num -1;
switch (_typ) do {
case "U": {(uniformContainer _unit) addWeaponCargo [_class , 1];};
case "V": {(vestContainer _unit) addWeaponCargo [_class , 1];};
case "B": {(backpackContainer _unit) addWeaponCargo [_class , 1];};
};
};
};
};
_unit = (_this select 0);

_itemCargoUni = [];
_magCargoUni = [];
_weaCargoUni = [];
_uniBol = !isnull (uniformContainer _unit);
if (_uniBol) then {
_itemCargoUni = (getitemCargo (uniformContainer _unit)) ;
_magCargoUni = (getMagazineCargo (uniformContainer _unit));
_weaCargoUni = (getWeaponCargo (uniformContainer _unit));
};

_itemCargoBackPack = [];
_magCargoBackPack = [];
_weaCargoBackPack = [];
_BackPackBol = !isnull (BackPackContainer _unit);
if (_BackPackBol) then {
_itemCargoBackPack = (getitemCargo (BackPackContainer _unit));
_magCargoBackPack = (getMagazineCargo (BackPackContainer _unit));
_weaCargoBackPack = (getWeaponCargo (BackPackContainer _unit));
};

_itemCargoVest = [];
_magCargoVest = [];
_weaCargoVest = [];
_VestBol = !isnull (VestContainer _unit);
if (_VestBol) then {
_itemCargoVest = (getitemCargo (VestContainer _unit));
_magCargoVest = (getMagazineCargo (VestContainer _unit));
_weaCargoVest = (getWeaponCargo (VestContainer _unit));
};


sleep 2;
_uniF = ["U_C_Poor_1","U_C_Poloshirt_tricolour","U_C_Poloshirt_stripped","U_C_Poloshirt_salmon","U_C_Poloshirt_redwhite","U_C_Poloshirt_burgundy","U_C_Poloshirt_blue","U_C_HunterBody_grn","U_C_Poloshirt_redwhite","U_C_Poloshirt_salmon","U_C_Poloshirt_tricolour","U_C_Poloshirt_redwhite","U_C_Poloshirt_stripped"];
//COULD FIT FOR CIVS TOO
if (isClass(configFile >> "cfgWeapons" >> "U_PMC_GTShirt_DJeans")) then {_uniF = _uniF + ["U_PMC_WhtPolo_GrnPants","U_PMC_WhtPolo_BluPants","U_PMC_WhtPolo_BgPants","U_PMC_GrnPolo_BgPants","U_PMC_BrnPolo_BluPants","U_PMC_BrnPolo_BgPants","U_PMC_BluPolo_GrnPants","U_PMC_BlckPolo_BluPants","U_PMC_BlckPolo_BgPants","U_PMC_BgPolo_GrnPants","U_PMC_BluPolo_BgPants","U_PMC_BlackPoloShirt_BeigeCords","U_PMC_RedPlaidShirt_DenimCords","U_PMC_BluePlaidShirt_BeigeCords","U_PMC_WTShirt_DJeans","U_PMC_BluTShirt_SJeans","U_PMC_BlkTShirt_SJeans","U_PMC_BlkTShirt_DJeans","U_PMC_GTShirt_SJeans","U_PMC_GTShirt_DJeans"];};
//COMBAT
if (isClass(configFile >> "cfgWeapons" >> "U_PMC_GTShirt_DJeans")) then {_uniF = _uniF + ["U_PMC_CombatUniformLS_ChckP_BPBB","U_PMC_CombatUniformLS_ChckLR_SPBB","U_PMC_CombatUniformLS_ChckLB_GPBB","U_PMC_CombatUniformLS_ChckDBS_GPSB","U_PMC_CombatUniformLS_SSGPSB","U_PMC_CombatUniformLS_SSGPBB","U_PMC_CombatUniformLS_SSBPBB","U_PMC_CombatUniformLS_IndPBSBB","U_PMC_CombatUniformLS_GSSPBB","U_PMC_CombatUniformLS_GSBPBB","U_PMC_CombatUniformLS_BSSPSB","U_PMC_CombatUniformLS_BSSPBB","U_PMC_CombatUniformLS_BSGPSB","U_PMC_CombatUniformLS_BSGPBB","U_PMC_CombatUniformRS_ChckP_BPBB","U_PMC_CombatUniformRS_ChckLR_SPBB","U_PMC_CombatUniformRS_ChckLB_GPBB","U_PMC_CombatUniformRS_ChckDBS_GPSB","U_PMC_CombatUniformRS_SSGPSB","U_PMC_CombatUniformRS_SSGPBB","U_PMC_CombatUniformRS_SSBPBB","U_PMC_CombatUniformRS_IndPBSBB","U_PMC_CombatUniformRS_GSSPBB","U_PMC_CombatUniformRS_GSBPBB","U_PMC_CombatUniformRS_BSSPSB","U_PMC_CombatUniformRS_BSSPBB","U_PMC_CombatUniformRS_BSGPSB","U_PMC_CombatUniformRS_BSGPBB"];};

_hats = ["H_Watchcap_sgg","H_Watchcap_khk","H_Watchcap_camo","H_Watchcap_blk","H_TurbanO_blk","H_StrawHat_dark","H_StrawHat","H_ShemagOpen_tan","H_ShemagOpen_khk","H_Shemag_tan","H_Shemag_olive","H_Shemag_khk","H_Hat_tan","H_Hat_grey","H_Hat_checker","H_Hat_camo","H_Hat_brown","H_Hat_blue","H_Cap_tan","H_Cap_red","H_Cap_oli","H_Cap_grn_BI","H_Cap_grn","H_Cap_blu_SPECOPS","H_Cap_blu","H_Cap_blk_Raven","H_Cap_blk_ION","H_Cap_blk_CMMG","H_Cap_blk","H_Booniehat_tan","H_Booniehat_mcamo","H_Booniehat_khk","H_Booniehat_indp","H_Booniehat_grn","H_Booniehat_dirty","H_Booniehat_dgtl","H_Beret_red","H_Beret_ocamo","H_Beret_grn","H_Beret_grn_SF","H_Beret_brn_SF","H_Beret_blk_POLICE","H_Beret_blk","H_BandMask_reaper","H_BandMask_khk","H_BandMask_demon","H_BandMask_blk","H_Bandanna_surfer","H_Bandanna_sgg","H_Bandanna_mcamo","H_Bandanna_khk","H_Bandanna_gry","H_Bandanna_cbr","H_Bandanna_camo","H_MilCap_mcamo","H_MilCap_ocamo","H_Cap_blu","H_Cap_brn_SERO","H_Cap_red"];

if (isClass(configFile >> "cfgWeapons" >> "U_PMC_GTShirt_DJeans")) then {_hats = _hats + ["H_Booniehat_DMARPAT","H_Booniehat_GCAMO","H_Booniehat_rgr","H_Capbw_tan_pmc","H_Capbw_pmc","H_Cap_pmc_headphones","H_Cap_tan_pmc","H_Cap_pmc"];};
if (isClass(configFile >> "cfgWeapons" >> "shemagh_faceD")) then {_hats = _hats + ["Tact_HoodOD","Tact_HoodACU","Tact_HoodMAR","Tact_HoodMC","Tact_HoodTAN","Head_WrapTAN","Head_Wrap","shemagh_neckOD","shemagh_neckD","shemagh_faceOD","shemagh_faceD"];};


removeGoggles _unit; 
removeUniform _unit; 
if (isClass(configFile >> "cfgWeapons" >> "U_PMC_GTShirt_DJeans")) then {
removeVest _unit; 
_vests = ["V_TacVest_darkblck","V_PlateCarrierInd_PMC_grn","V_PlateCarrierInd_PMC_blk","V_PlateCarrier1_PMC_khki","V_PlateCarrier1_PMC_rgr","V_PlateCarrier1_PMC_blk","V_PlateCarrier1_PMC_marpat"];
if !(typeof _unit in ["B_recon_medic_F","B_medic_F"]) then {_unit addVest (_vests call RETURNRANDOM);} else {_unit addVest "V_TacVestMedic";};
};

removeHeadgear _unit; 
_unit forceadduniform (_uniF call RETURNRANDOM);
if (random 1 < 0.9) then {_unit addHeadgear (_hats call RETURNRANDOM);};
clearMagazineCargo UniformContainer _unit;
clearWeaponCargo UniformContainer _unit;
clearItemCargo UniformContainer _unit;

clearMagazineCargo VestContainer _unit;
clearWeaponCargo VestContainer _unit;
clearItemCargo VestContainer _unit;

/*
if (_BackPackBol) then {
//clearMagazineCargo BackpackContainer _unit;
//clearWeaponCargo BackpackContainer _unit;
//clearItemCargo BackpackContainer _unit;
};
*/


if (_uniBol) then {
[_weaCargoUni,_unit,"U"] CALL _f3;
[_itemCargoUni,_unit,"U"] CALL _f2;
//[_magCargoUni,_unit,"U"] CALL _f1;
};

if (_BackPackBol) then {
[_weaCargoBackPack,_unit,"B"] CALL _f3;
[_itemCargoBackPack,_unit,"B"] CALL _f2;
//[_magCargoBackPack,_unit,"B"] CALL _f1;
};

if (_VestBol) then {
[_weaCargoVest,_unit,"V"] CALL _f3;
[_itemCargoVest,_unit,"V"] CALL _f2;
//[_magCargoVest,_unit,"V"] CALL _f1;
};




if (count (_this select 1) > 0) then {
{_parentsAr = [(configfile >> "CfgMagazines" >> _x),true] call BIS_fnc_returnParents; if (!("CA_LauncherMagazine" in _parentsAr) && {!("HandGrenade" in _parentsAr)}) then {_unit removeMagazines _x;};} foreach magazines _unit;
removeAllWeapons _unit; 
if (random 1 < 0.4 && {count SAOKps > 0}) then {


_weR = SAOKps call RETURNRANDOM;
_maR = (getArray (configfile >> "CfgWeapons" >> _weR >> "magazines")) call RETURNRANDOM;
_t = 0;
while {(_maR == "30Rnd_65x39_case_mag" || {!isClass(configFile >> "cfgMagazines" >> _maR)} || {(getNumber (configfile >> "CfgMagazines" >> _maR >> "scope")) == 0}) && {_t < 7}} do {
_weR = SAOKps call RETURNRANDOM;
_maR = (getArray (configfile >> "CfgWeapons" >> _weR >> "magazines")) call RETURNRANDOM;
_t = _t + 1;
};
{_unit addmagazine _maR;} foreach [0,1,2,3,4];
_unit addweapon _weR;


} else {
_nul = [_unit, [0,1] call RETURNRANDOM] CALL FUNKTIO_NATORUS;
};
} else {
_nul = [_unit, [0,1] call RETURNRANDOM] CALL FUNKTIO_NATORUS;
};
sleep 1;
if (primaryWeapon _unit != "") then {_unit selectweapon (primaryWeapon _unit);};



