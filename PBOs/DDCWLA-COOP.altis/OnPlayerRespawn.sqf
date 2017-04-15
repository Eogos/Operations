private ["_unit","_pp","_b","_n","_vI","_xx","_yy","_pos","_c","_start","_nul","_class"];
_unit = _this select 0;

_nul = [side _unit,_unit] call BIS_fnc_addRespawnPosition;
if !(isPlayer _unit) exitWith {};
[player,"PlaV", "JinVoices\sounds.bikb", ""] CALL SAOKKBTOPIC;
//if (!isNil{player getvariable "ResPos"}) exitWith {_pos = (player getvariable "ResPos"); _pos = [_pos select 0,_pos select 1,0]; player setpos _pos; player setvariable ["ResPos",nil,true];};
if (!isNil{player getvariable "Punished"}) exitWith {
removeallweapons player;
player setpos jail1;
(format ["You need to serve %1 seconds in cell before able to respawn elsewhere",(player getvariable "Punished")]) SPAWN HINTSAOK;;
(player getvariable "Punished") SPAWN {sleep _this; player setvariable ["Punished",nil,true]; "You are free to go now, use fast-travel or respawn." SPAWN HINTSAOK;};
};
player setvariable ["JustTeleported",nil];
if (side player == WEST && {!("B_UavTerminal" in (items player))}) then {player additem "B_UavTerminal";};

if (!isNil{player getvariable "GearData"}) then {[] SPAWN CopyOldGear;} else {
if ((paramsArray select 0) == 1 && {side player == WEST}) then {
[[player,["rhs_uniform_cu_ucp"],["rhsusf_ach_helmet_headset_ucp","rhsusf_ach_helmet_ucp"],["rhsusf_iotv_ucp","rhsusf_iotv_ucp_squadleader"]],"GearToRandom",false,false] spawn BIS_fnc_MP;
//_n = [player,["rhs_uniform_cu_ucp"],["rhsusf_ach_helmet_headset_ucp","rhsusf_ach_helmet_ucp"],["rhsusf_iotv_ucp","rhsusf_iotv_ucp_squadleader"]] SPAWN GearToRandom;
//_nul = [player, 1] SPAWN FUNKTIO_NATORUS;
[[player, 1],"FUNKTIO_NATORUS",false,false] spawn BIS_fnc_MP;
};
if ((paramsArray select 0) in [2,3]) then {
if (!isnull (BackPackContainer player)) then {removeBackpack player;};
if ((paramsArray select 0) == 3) then {
[[player,["U_LIB_US_Off","U_LIB_US_Corp"],["H_LIB_US_Helmet_Net","H_LIB_US_Helmet_First_lieutenant"],["V_LIB_US_Vest_Carbine","V_LIB_US_Vest_Carbine_nco"],["B_LIB_US_RocketBag","B_LIB_US_Radio","B_LIB_US_MGbag","B_LIB_US_MedicBackpack","B_LIB_US_Backpack","B_LIB_US_Backpack_eng","B_LIB_US_Bandoleer"]],"GearToRandom",false,false] spawn BIS_fnc_MP;
//_n = [player,["U_LIB_US_Off","U_LIB_US_Corp"],["H_LIB_US_Helmet_Net","H_LIB_US_Helmet_First_lieutenant"],["V_LIB_US_Vest_Carbine","V_LIB_US_Vest_Carbine_nco"],["B_LIB_US_RocketBag","B_LIB_US_Radio","B_LIB_US_MGbag","B_LIB_US_MedicBackpack","B_LIB_US_Backpack","B_LIB_US_Backpack_eng","B_LIB_US_Bandoleer"]] SPAWN GearToRandom;
} else {
[[player,["U_LIB_GER_Soldier_camo","U_LIB_GER_Soldier_camo"],["H_LIB_GER_HelmetCamo","H_LIB_GER_HelmetCamo"],["V_LIB_GER_VestMP40","V_LIB_GER_VestMP40"],["B_LIB_GER_SapperBackpack","B_LIB_GER_Radio","B_LIB_GER_Panzer","B_LIB_GER_MedicBackpack","B_LIB_GER_A_frame"]],"GearToRandom",false,false] spawn BIS_fnc_MP;
//_n = [player,["U_LIB_GER_Soldier_camo","U_LIB_GER_Soldier_camo"],["H_LIB_GER_HelmetCamo","H_LIB_GER_HelmetCamo"],["V_LIB_GER_VestMP40","V_LIB_GER_VestMP40"],["B_LIB_GER_SapperBackpack","B_LIB_GER_Radio","B_LIB_GER_Panzer","B_LIB_GER_MedicBackpack","B_LIB_GER_A_frame"]] SPAWN GearToRandom;
};
[[player, 1],"FUNKTIO_NATORUS",false,false] spawn BIS_fnc_MP;
player unassignItem "NVGoggles";
player removeItem "NVGoggles";
};
};
player enableFatigue false;
player allowdamage false;

[["WLA","IslandInsertion"]] call BIS_fnc_advHint;

_dloc = if (!isNil{player getvariable "Klocation"}) then {player getvariable "Klocation"} else {[0,0,0]};
_aika = time + 20;
waitUntil {sleep 0.1;_dloc distance _unit > 3 || {_aika < time}}; 
_jumpP = getposATL _unit;
if (isNil{(player getvariable "InsertionT")} || {(player getvariable "InsertionT")}) then {
_sta = startP;
if (side player == EAST) then {_sta = startP2;};
player setposATL (getposATL _sta);
waitUntil {sleep 0.5; isNull player || {!alive player} || {player distance getposATL _sta > 20}|| {!isNil{player getvariable "JustTeleported"}}};
if (isNull player || {!alive player} || {!isNil{player getvariable "JustTeleported"}}) exitWith {player allowdamage true;};
titlecut ["","black out",2];
sleep 2;
if (_jumpP distance _sta < 100) then {_jumpP = getposATL startD;};
player setpos _jumpP;
};
if (!isNil"NEARESTCAMP" && {(getmarkerpos (["ColorRed", player] CALL NEARESTCAMP)) distance player < 400} && {{_x distance player < 500} count ([side player,""] CALL AllPf) == 0}) exitWith {titlecut ["","black in",2];player allowdamage true;};
sleep 0.5;
if (leader player == player && {{!isPlayer _x} count units group player > 0}) then {"After landing you can move your AI-teammates at you by clicking 0-0-3" SPAWN HINTSAOK;};
_class = typeOf unitBackpack _unit;
_n = getMagazineCargo (backpackContainer _unit);
_vI = backpackItems _unit;
sleep 0.6;
removeBackpack _unit;
_unit addbackpack "B_Parachute";
_pp = getposATL _unit;
_xx = random 450;
_yy = 450 - _xx;
if (random 1 < 0.5) then {_xx = _xx*(-1)};
if (random 1 < 0.5) then {_yy = _yy*(-1)};
_start = [(_pp select 0) + _xx,(_pp select 1) + _yy,200];
_c = 4;
while {surfaceisWater _start && {_c > 0}} do {
_c = _c - 1;
_xx = random (450);
_yy = 450 - _xx;
if (random 1 < 0.5) then {_xx = _xx*(-1)};
if (random 1 < 0.5) then {_yy = _yy*(-1)};
_start = [(_pp select 0) + _xx,(_pp select 1) + _yy,200];
};
if (_start distance [0,0,0] < 1000) then {_start = [10000,10000,0];};
_unit setpos _start;
sleep (1.5+(random 0.5));
titlecut ["","black in",2];
_unit action ["OpenParachute",_unit];
waitUntil {sleep 1; !alive _unit || {getposATL _unit select 2 < 1}};
sleep 2;
if (alive _unit && {!isNil"_class"} && {_class != ""}) then {
removeBackpack _unit;
_unit addbackpack _class;
sleep 0.5;
clearMagazineCargo backpackContainer _unit;
sleep 0.5;
_b = unitBackpack _unit;
sleep 0.5;
{
if (count _x > 1 && {typename (_x select 1) == "SCALAR"} && {(_x select 1) > 0}) then {
_b addMagazineCargo [_x select 0,_x select 1];
};
} foreach _n;
{
if (_x != "") then {
if (isClass(configFile >> "cfgWeapons" >> _x)) then {
_unit addItem _x;
} else {_unit addmagazine _x;};
};
} foreach _vI;
};
sleep 10;
_p = [((getposATl player) select 0)+150-(random 300),((getposATl player) select 1)+150-(random 300),0];
if ({alive _x && {player distance _x < 300} && {{alive _x} count crew _x == 0}} count vehicles == 0 && {count vehicles < 50}) then {
"You are receiving vehicle from sky. Team-leader is able construct guardposts with the truck. Press Shift + C when near it." SPAWN HINTSAOK;
_nul = [_p,"I_G_Van_01_transport_F"] SPAWN FSupportDrop;
} else {};
player allowdamage true;
[["WLA","GetStarted"]] call BIS_fnc_advHint;