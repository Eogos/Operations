
private ["_ok","_myDisplay","_text"];
sleep (random 0.1);
if (dialog) exitWith {}; 
//WLAMenu
[["WLA","WLAMenu"]] call BIS_fnc_advHint;
disableserialization;
_ok = createDialog "WLADialog"; 
_myDisplay = findDisplay 32144;
if (player CALL NEARESTLOCATIONNAME == "factory") then {ctrlSetText [1600,"Factory"];};
if !(((vehicle player distance (getmarkerpos ([] CALL NEARESTAIRFIELD)) < 200 && {!((getmarkerpos ([] CALL NEARESTAIRFIELD)) distance (getmarkerpos (["ColorRed"] CALL NEARESTCAMP)) < 800)}) || {((vehicle player) distance (getmarkerpos ([] CALL NEARESTCAMP)) < 100 && {getmarkercolor ([] CALL NEARESTCAMP) == "ColorBlue"})} || {({vehicle player distance (getmarkerpos _x) < 50 && getmarkercolor _x == "ColorGreen"} count PierMarkers > 0)})) then {
ctrlEnable [1601, false];
};
_post = ([(getposATL player)] CALL RETURNGUARDPOST);
if (_post distance player < 50 && {!isNil{_post getvariable "BaseCamp"}}) then {ctrlEnable [1601, true];};
if !(((vehicle player) distance (getmarkerpos ([] CALL NEARESTVILLAGE)) < (getmarkersize ([] CALL NEARESTVILLAGE) select 0))) then {
ctrlEnable [1600, false];
};
if !(vehicle player distance (getmarkerpos (["ColorBlue"] CALL NEARESTCAMP)) < 100 || {count (nearestObjects [player, ["Land_TBox_F"], 20]) > 0}  || {{alive _x} count ((getposATL player) nearEntities [["B_Truck_01_ammo_F", "I_Truck_02_ammo_F", "O_Truck_02_Ammo_F"], 20]) > 0}) then {
ctrlEnable [1607, false];
};
if (DIFLEVEL < 0.5) then {ctrlEnable [1607, true];};
if !((vehicle player distance (getmarkerpos (["ColorBlue"] CALL NEARESTCAMP)) < 100) || {DIFLEVEL < 1 && {(_post distance vehicle player < 30)} && {getmarkercolor  (_post getvariable "Gmark") == "ColorGreen"}}) then {
ctrlEnable [1603, false];
};
if (DIFLEVEL < 0.5) then {ctrlEnable [1603, true];};
ctrlEnable [1604, false];
ctrlEnable [1609, false];
ctrlEnable [1608, false];
_text = "";
_text = _text + "Steal/Take: Y" + "<br/>";
_text = _text + "Talk: Shift+Y" + "<br/>";
_text = _text + "Construct: Shift+C" + "<br/>";
_text = _text + "Minefield: Shift+L" + "<br/>";
_text = _text + "Load Crate: Shift+9" + "<br/>";
_text = _text + "Flip Car: Shift+4" + "<br/>";
_text = _text + "Push Boat: Shift+4" + "<br/>";
_text = _text + "Street Lights: Shift+7" + "<br/>";
_text = _text + "Change to Civ: Alt+Y" + "<br/>";

(_myDisplay displayCtrl 1100) ctrlSetStructuredText parseText _text;