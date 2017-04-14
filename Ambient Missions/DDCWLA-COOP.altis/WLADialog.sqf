
private ["_ok","_myDisplay","_nV","_nCb","_nA","_nC","_vP","_pP","_post"];
sleep (random 0.1);
if (dialog) exitWith {}; 
//WLAMenu
if (isNil{player getvariable "nahty"}) then {
player setvariable ["nahty",1];
[["WLA","WLANotes"]] call BIS_fnc_advHint;
"Version 19-08-2015" SPAWN HINTSAOK;
} else {
[["WLA","WLAMenu"]] call BIS_fnc_advHint;
};
_s = ["ColorRed","ColorBlue"];
if (side player == EAST) then {_s = ["ColorRed","ColorBlue"];};
disableserialization;
_ok = createDialog "WLADialog"; 
_myDisplay = findDisplay 32144;
if (isNil{player getvariable "InsertionT"}) then {player setvariable ["InsertionT",true];};
(_myDisplay displayCtrl 2500) ctrlSetChecked (player getvariable "InsertionT");
lbAdd [1501, "Hotkeys"];
lbAdd [1501, "Important Notes"];
lbAdd [1501, "Mod Info"];
lbAdd [1501, "Legend Forces"];
lbAdd [1501, "Legend Other"];
//lbAdd [1501, "Event Log"];
//lbAdd [1501, "Team-mates"];
lbSetCurSel [1501, 0];
_nV = ([] CALL NEARESTVILLAGE);
_nCb = (getmarkerpos (["ColorBlue"] CALL NEARESTCAMP));
_nCr = (getmarkerpos (["ColorRed"] CALL NEARESTCAMP));
_nA = ([] CALL NEARESTAIRFIELD);
_nC = ([] CALL NEARESTCAMP);
_vP = vehicle player;
_pP = getposATL player;
if (_pP CALL NEARESTLOCATIONNAME == "factory") then {ctrlSetText [1600,"Factory"];};
ctrlEnable [1601, false];
if (side player == WEST && {((_vP distance (getmarkerpos _nA) < 200 && {getmarkercolor _nA == "ColorGreen"}) || {((_vP) distance (getmarkerpos _nC) < 100 && {getmarkercolor _nC == "ColorBlue"})} || {({_vP distance (getmarkerpos _x) < 50 && {getmarkercolor _x == "ColorGreen"}} count PierMarkers > 0)})}) then {
ctrlEnable [1601, true];
};
if (side player == EAST && {((_vP) distance (getmarkerpos _nC) < 100 && {getmarkercolor _nC == "ColorRed"})}) then {
ctrlEnable [1601, true];
};
_post = ([_pP] CALL RETURNGUARDPOST);
if (_post distance _pP < 50 && {!isNil{_post getvariable "BaseCamp"}}) then {ctrlEnable [1601, true];};
if !(((_vP) distance (getmarkerpos _nV) < (getmarkersize _nV select 0))) then {
ctrlEnable [1600, false];
};
if !(vehicle player distance (getmarkerpos ([_s select 1] CALL NEARESTCAMP)) < 100 || {count (nearestObjects [player, ["Land_TBox_F"], 20]) > 0}  || {{alive _x} count ((getposATL player) nearEntities [["B_Truck_01_ammo_F", "I_Truck_02_ammo_F", "O_Truck_02_Ammo_F"], 20]) > 0} || {player distance startP < 30} || {player distance startP2 < 30}) then { 
ctrlEnable [1607, false];
};
if ({_x distance player < 500} count ([side player,""] CALL AllPf) > 0 && {player distance startP > 30} && {player distance startP2 > 30}) then {
ctrlEnable [1607, false];
};
/*
if !(_vP distance _nCb < 100 || {count (nearestObjects [_pP, ["Land_TBox_F"], 20]) > 0}  || {{alive _x} count (_pP nearEntities [["B_Truck_01_ammo_F", "I_Truck_02_ammo_F", "O_Truck_02_Ammo_F"], 20]) > 0}) then {
ctrlEnable [1607, false];
};
if (DIFLEVEL < 0.5) then {ctrlEnable [1607, true];};
if (_vP != player) then {ctrlEnable [1607, false];};
*/
if ((player getvariable "OwnRes") <= 0) then {ctrlEnable [1607, false];};
if !((_vP distance _nCb < 100) || {DIFLEVEL < 1 && {(_post distance _vP < 30)} && {getmarkercolor (_post getvariable "Gmark") == "ColorGreen"}}) then {
ctrlEnable [1603, false];
};
if (DIFLEVEL < 0.5) then {ctrlEnable [1603, true];};
if !(serverCommandAvailable "#kick") then {ctrlEnable [1609, false];ctrlEnable [1604, false];};
if (!isDedicated && {isServer}) then {ctrlEnable [1609, true];ctrlEnable [1604, true];};
//CURRENTLY
if (side player == EAST) then {ctrlEnable [1605, false];};
//

//SAOKWLATEXT in sharedfunc2.sqf