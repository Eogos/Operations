private ["_oldG","_bp","_Vest","_itS","_itP","_da","_hat","_uni","_typeOf","_we","_uI","_vI","_bC","_mag","_mag2"];

_oldG = player getvariable "GearData";
_vI = _oldG select 0;
_uI = _oldG select 1;
_bp = _oldG select 2;
_bC = _oldG select 3;
_mag = _oldG select 4;
_mag2 = _oldG select 5;
_we = _oldG select 6;
_typeOf = _oldG select 7;
_uni = _oldG select 8;
_hat = _oldG select 9;
_da= _oldG select 10;
_Vest = _oldG select 11;
_itP = _oldG select 12;
_itS = _oldG select 13;

removeallweapons player;
removeHeadgear player;
removeVest player;
player forceadduniform _uni;
if (!isNil"_hat") then {
player addHeadgear _hat;
};
if (!isNil"_Vest") then {
player addVest _Vest;
};
if (count _mag > 0) then {player addmagazine (_mag select 0);}; 
if (count _mag2 > 0) then {player addmagazine (_mag2 select 0);};
{if (_x != "" && {isClass(configFile >> "cfgWeapons" >> _x)}) then {player addweapon _x;};} foreach _we;

if (_bp != "") then {
removeBackpack player;
player addBackpack _bp;
clearAllItemsFromBackpack player;
};


removeAllPrimaryWeaponItems player; 
{
if (_x != "") then {
player addPrimaryWeaponItem _x;
};
} foreach _itP;
{
if (_x != "") then {
player addSecondaryWeaponItem _x;
};
} foreach _itS;

{
if (_x != "") then {
if (isClass(configFile >> "cfgWeapons" >> _x)) then {
player addItem _x;
} else {player addmagazine _x;};
};
} foreach _vI + _uI + _bC;

 





