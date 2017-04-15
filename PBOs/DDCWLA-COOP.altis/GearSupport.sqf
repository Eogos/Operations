private ["_price","_type","_cl","_pos","_nul"];
_price = _this select 0;
_type = _this select 1;
_cl = "";
switch (_type) do {
case "Basic Ammo": {_cl = "Box_NATO_Ammo_F";};
case "Basic Weapons": {_cl = "Box_NATO_Wps_F";};
case "Grenades": {_cl = "Box_NATO_Grenades_F";};
case "Launchers": {_cl = "Box_NATO_WpsLaunch_F";};
case "Explosives": {_cl = "Box_NATO_AmmoOrd_F";};
case "Special": {_cl = "Box_NATO_WpsSpecial_F";};
case "Medical Supplies": {_cl = "ACE_medicalSupplyCrate_advanced";};
case "Chemlights": {_cl = "ACE_Box_Chemlights";};
case "82mm HE": {_cl = "ACE_Box_82mm_Mo_HE";};
case "82mm Illumination": {_cl = "ACE_Box_82mm_Mo_Illum";};
case "82mm Smoke": {_cl = "ACE_Box_82mm_Mo_Smoke";};
case "Radios": {_cl = "ACRE_RadioSupplyCrate";};
case "NATO SF weapons": {_cl = "Box_mas_us_rifle_Wps_F";};
case "Russian weapons": {_cl = "Box_mas_ru_rifle_Wps_F";};
case "Supply[NATO]": {_cl = "B_supplyCrate_F";};
case "Supply[AAF]": {_cl = "I_supplyCrate_F";};
case "Support[NATO]": {_cl = "Box_NATO_Support_F";};
case "Support[AAF]": {_cl = "Box_IND_Support_F";};
case "VehAmmo[NATO]": {_cl = "Box_NATO_AmmoVeh_F";};
case "VehAmmo[AAF]": {_cl = "Box_IND_AmmoVeh_F";};
case "Construction Truck": {_cl = "I_G_Van_01_transport_F";};
};
if (_cl == "") then {
{if (getText (configfile >> "CfgVehicles" >> _x >> "displayName") == _type) exitWith {_cl = _x;};} foreach (["Lib_sdkfz251","I_G_Van_01_transport_F"] + (ARMEDVEHICLES select 0)+(ARMEDCARRIER select 0));
};

if (_cl == "") exitWith {};
if (([side player] CALL PrestigeS) >= _price) then {
_n = [side player,(-1*_price)] SPAWN PrestigeUpdate;
"Cash" SPAWN SAOKPLAYSOUND;
[[-_price, "Support Call",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
//_trigger = _this select 0;
//_trigger setTriggerActivation ["NONE", "PRESENT", true];
_tx = ("Wolf to Base, we need more gear. Could you drop us crate of "+_type+". Over");
[[leader player, _tx],"SAOKMULTISCHAT",nil,false] spawn BIS_fnc_MP;
[player,player, "PlaV", "V5"] SPAWN SAOKKBTELL;
sleep 7;
[[[side player,"HQ"], (localize "STR_Sp1s1r8")],"SAOKMULTISCHAT",nil,false] spawn BIS_fnc_MP;
"Radio4" SPAWN SAOKPLAYSOUND;
//sleep (60 + (random 60));
if (_type != "Construction Truck") then {
_pos = [(getposATL player select 0)+150-(random 300),(getposATL player select 1)+150-(random 300),0];
while {surfaceIsWater _pos} do {sleep 5;_pos = [(getposATL player select 0)+150-(random 100),(getposATL player select 1)+150-(random 300),0];};
if (_cl iskindof "ReammoBox_F" || {!isNil"IFENABLED"} || {true}) then {
_nul = [_pos,"",1,_cl] SPAWN FSupportDrop;
} else {
_nul = [_cl ,_pos] SPAWN SAOKSLINGVEH;
};
} else {
if (!isNil"IFENABLED" || {true}) then {
_nul = [getposATL player,_cl] SPAWN FSupportDrop;
} else {
_nul = [_cl ,getposATL vehicle player] SPAWN SAOKSLINGVEH;
};
};
sleep 600 + (random 300);
//_trigger setTriggerActivation ["Echo", "PRESENT", true];
//hint "Gear Support is available again via radio channel - Echo";
} else {
(format ["%1 more prestige value needed to order gear drop", _price - ([side player] CALL PrestigeS)]) SPAWN HINTSAOK;
};