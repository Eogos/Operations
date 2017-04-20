private ["_all","_keyDown"];
if (isDedicated) exitWith {};
waituntil {!(IsNull (findDisplay 46))};
//(findDisplay 46) displayRemoveAllEventHandlers "KeyDown"; 
_all = [];
waitUntil {sleep 1; !isNil"StartMission"};
LIIKUTAOBJEKTI = nil;
SaOkmissionnamespace setvariable ["ConsMoved",nil];
waituntil {0.1;!(IsNull (findDisplay 46))};
//MINEFIELD Shift+L
_keyDown = (findDisplay 46) displayAddEventHandler ["KeyDown", "if (_this select 2 && {_this select 1 == 0x26} && {!dialog} && {isNil""LIIKUTAOBJEKTI""}) then {_nul = (groupSelectedUnits player) SPAWN FUNK_MinefieldInit;};"];
_all set [count _all,_keyDown];
//CONSTRUCT Shift+C 
_keyDown = (findDisplay 46) displayAddEventHandler ["KeyDown", "if (_this select 2 && {_this select 1 == 0x2E} && {!dialog}) then {
if (isNil""LIIKUTAOBJEKTI"") then {
_nul = [] SPAWN FUNK_ConstructionDialog;
} else {
SaOkmissionnamespace setvariable [""MovingObj"",nil];
};
};"];
_all set [count _all,_keyDown];
//WLA Menu (SHIFT + 1)
_keyDown = (findDisplay 46) displayAddEventHandler ["KeyDown", "if (_this select 2 && {_this select 1 == 0x02} && {!dialog} && {isNil""LIIKUTAOBJEKTI""}) then {_nul = [] SPAWN WLADialog;};"];
_all set [count _all,_keyDown];

//TALK TO CIVILIAN (SHIFT + Y)
_keyDown = (findDisplay 46) displayAddEventHandler ["KeyDown", "if (_this select 2 && {isNil""SAOKCUT""} && {_this select 1 == 0x15} && {({[_x,player] CALL FUNKTIO_LOS} count ((getposATL player) nearEntities [[""Civilian""],7]) > 0)} && {!dialog} && {isNil""LIIKUTAOBJEKTI""}) then {_nul = [] SPAWN CONVERSATIONWITHCIVILIANS;};"];
_all set [count _all,_keyDown];
//TALK TO SURRENDERED (SHIFT + Y)
_keyDown = (findDisplay 46) displayAddEventHandler ["KeyDown", "if (_this select 2 && {isNil""SAOKCUT""} && {_this select 1 == 0x15} && {({leader _x != player && {!isNil{(_x getvariable ""SaOkSurrendered"")}} && {isNil{(_x getvariable ""NoTalkative"")}} && {[_x,player] CALL FUNKTIO_LOS}} count ((getposATL player) nearEntities [[""Man""],7]) > 0)} && {!dialog} && {isNil""LIIKUTAOBJEKTI""}) then {_nul = [] SPAWN CONVERSATIONWITHSURRENDERED;};"];
_all set [count _all,_keyDown];
//TALK TO SOLDIER (SHIFT + Y)
_keyDown = (findDisplay 46) displayAddEventHandler ["KeyDown", "if (_this select 2 && {isNil""SAOKCUT""} && {_this select 1 == 0x15} && {({leader _x != player && {side _x != EAST && {side _x != CIVILIAN}}&& {isNil{(_x getvariable ""NoTalkative"")}} && {[_x,player] CALL FUNKTIO_LOS}} count ((getposATL player) nearEntities [[""Man""],7]) > 0)} && {!dialog} && {isNil""LIIKUTAOBJEKTI""}) then {_nul = [] SPAWN CONVERSATIONWITHSOLDIERS;};"];
_all set [count _all,_keyDown];

/*
//Street Lights Shift+7
_keyDown = (findDisplay 46) displayAddEventHandler ["KeyDown", "if (_this select 2 && {_this select 1 == 0x08} && {!dialog} && {nearestObject [player, ""Land_spp_Transformer_F""] distance player < 10} && {vehicle player == player} && {isNil""LIIKUTAOBJEKTI""}) then {_nul = [] SPAWN LightsDialog;};"];
_all set [count _all,_keyDown];
*/
//Break in Car Y
_keyDown = (findDisplay 46) displayAddEventHandler ["KeyDown", "if (!(_this select 2) && {!(_this select 3)} && {!(_this select 4)} && {_this select 1 == 0x15} && {vehicle player == player}) then {_nul = [] SPAWN StealOrTake;};"];
_all set [count _all,_keyDown];
//Crate Shift+9
_keyDown = (findDisplay 46) displayAddEventHandler ["KeyDown", "if (_this select 2 && {_this select 1 == 0x0A} && {!dialog} && {isNil""LIIKUTAOBJEKTI""}) then {
if !(typeof vehicle player isKindOf ""Air"") then {
_nul = [] SPAWN FCrateDialog;
} else {
if (productVersion select 2 >= 136 && {false}) then {_nul = [] SPAWN SAOKSLINGDIA;} else {};
};
};"];
_all set [count _all,_keyDown];
//""Slingloading isnt supported with your game version"" SPAWN HINTSAOK;
 //FLIP VEHICLE Shift+4
_keyDown = (findDisplay 46) displayAddEventHandler ["KeyDown", "if (_this select 2 && {_this select 1 == 0x05}) then {_nul = [] SPAWN F_CorrectCar;};"];
_all set [count _all,_keyDown];
/*
//Holster Weapon (CTRL + Y)
_keyDown = (findDisplay 46) displayAddEventHandler ["KeyDown", "if (_this select 3 && {!isNil{CIVMODE}} && {_this select 1 == 0x15}) then {_nul = [] SPAWN ToggleW;};"];
_all set [count _all,_keyDown];
*/
//SHOW 3D ICONS SHIFT+U
_keyDown = (findDisplay 46) displayAddEventHandler ["KeyDown", "if (_this select 2 && {_this select 1 == 0x16}) then {if (isNil""IC3D"") then {IC3D = true;} else {IC3D = nil;};};"];
_all set [count _all,_keyDown];

//FIST ACTION U
_keyDown = (findDisplay 46) displayAddEventHandler ["KeyDown", "if (!(_this select 2) && {!(_this select 3)} && {_this select 1 == 0x16}) then {
_n = [] SPAWN FPlayerFist;
if (side player == WEST) then {
_n = [] SPAWN SAOKYELLTOSURRENDER;
};
};"];
_all set [count _all,_keyDown];
/*
//CHANGE TO CIV (ALT + Y)
_keyDown = (findDisplay 46) displayAddEventHandler ["KeyDown", "if (_this select 4 && {_this select 1 == 0x15}) then {_nul = [] SPAWN CivPlayer;};"];
_all set [count _all,_keyDown];
*/
SaOkmissionNamespace setVariable ["DEH",_all];