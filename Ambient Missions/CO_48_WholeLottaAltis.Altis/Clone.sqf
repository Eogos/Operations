private ["_f1","_f2","_f3","_un","_bp","_Vest","_itS","_itP","_group","_da","_pP","_hat","_uni","_typeOf","_we","_uI","_vI","_t","_mag","_mag2"];
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
_mag = primaryWeaponMagazine _this;
_mag2 = secondaryWeaponMagazine _this;
_mag3 = handgunMagazine _this;
_typeOf = typeOf _this;
_bp = Backpack _this;
_uni = uniform _this;
_hat = headgear _this;
_pP = getposATL player;
_da= damage _this;
_Vest = Vest _this;
_asI = assignedItems _this;
_itemCargoUni = [];
_magCargoUni = [];
_weaCargoUni = [];
_uniBol = !isnull (uniformContainer _this);
if (_uniBol) then {
_itemCargoUni = (getitemCargo (uniformContainer _this)) ;
_magCargoUni = (getMagazineCargo (uniformContainer _this));
_weaCargoUni = (getWeaponCargo (uniformContainer _this));
};

_itemCargoBackPack = [];
_magCargoBackPack = [];
_weaCargoBackPack = [];
_BackPackBol = !isnull (BackPackContainer _this);
if (_BackPackBol) then {
_itemCargoBackPack = (getitemCargo (BackPackContainer _this));
_magCargoBackPack = (getMagazineCargo (BackPackContainer _this));
_weaCargoBackPack = (getWeaponCargo (BackPackContainer _this));
};

_itemCargoVest = [];
_magCargoVest = [];
_weaCargoVest = [];
_VestBol = !isnull (VestContainer _this);
if (_VestBol) then {
_itemCargoVest = (getitemCargo (VestContainer _this));
_magCargoVest = (getMagazineCargo (VestContainer _this));
_weaCargoVest = (getWeaponCargo (VestContainer _this));
};



//NEW UNIT
_group = [[(_pP select 0)+10-(random 20),(_pP select 1)+10-(random 20),0], WEST, [_typeOf],[],[],[0.9,1.0]] call SpawnGroupCustom;
_un = leader _group;
removeallweapons _un;
removeHeadgear _un;
removeVest _un;
//COPY SKILL
{_un setSkill [_x,(_this skill _x)];} foreach ["general","commanding","reloadSpeed","courage","spotTime","spotDistance","endurance","aimingSpeed","aimingShake","aimingAccuracy"];

_itP = if (!isNil{primaryWeaponItems _this}) then {primaryWeaponItems _this} else {[]};
_itS = if (!isNil{handgunItems _this}) then {handgunItems _this} else {[]};



if (!isnull (UniformContainer _this)) then {
_un forceadduniform _uni;
clearMagazineCargo UniformContainer _un;
clearWeaponCargo UniformContainer _un;
clearItemCargo UniformContainer _un;
};

if (!isNil"_hat") then {
_un addHeadgear _hat;
};
if (!isNil"_Vest") then {
_un addVest _Vest;
clearMagazineCargo VestContainer _un;
clearWeaponCargo VestContainer _un;
clearItemCargo VestContainer _un;
};


removeallweapons _un;
if (handgunWeapon _this != "") then {_un addweapon (handgunWeapon _this);};
if (primaryWeapon _this != "") then {_un addweapon (primaryWeapon _this);};
if (secondaryWeapon _this != "") then {_un addweapon (secondaryWeapon _this);};

if (_bp != "") then {
removeBackpack _un;
_un addBackpack _bp;
clearMagazineCargo BackpackContainer _un;
clearWeaponCargo BackpackContainer _un;
clearItemCargo BackpackContainer _un;
};



removeAllPrimaryWeaponItems _un; 
{
if (_x != "") then {
_un addPrimaryWeaponItem _x;
};
} foreach _itP;
removeAllHandgunItems _un; 
{
if (_x != "") then {
_un addhandgunItem _x;
};
} foreach _itS;


_un setDamage _da;
_un setName (name _this);
_un setFace (face _this);

if (_uniBol) then {
[_weaCargoUni,_un,"U"] CALL _f3;
[_itemCargoUni,_un,"U"] CALL _f2;
[_magCargoUni,_un,"U"] CALL _f1;
};

if (_BackPackBol) then {
[_weaCargoBackPack,_un,"B"] CALL _f3;
[_itemCargoBackPack,_un,"B"] CALL _f2;
[_magCargoBackPack,_un,"B"] CALL _f1;
};

if (_VestBol) then {
[_weaCargoVest,_un,"V"] CALL _f3;
[_itemCargoVest,_un,"V"] CALL _f2;
[_magCargoVest,_un,"V"] CALL _f1;
};

{if (count _x > 0) then {_un addmagazine (_x select 0)};} foreach [_mag,_mag2,_mag3];

{_un assignItem _x;} foreach _asI;

{
if !(isNil{_this getvariable _x}) then {_un setvariable [_x,(_this getvariable _x)];};
} foreach ["Relationship","Tired","Sickness","Mental","CKills","Kills","FKills"];

deletevehicle _this;
[_un] joinSilent player;
sleep 1;
if (primaryWeapon _un != "") then {_un selectweapon (primaryWeapon _un);};