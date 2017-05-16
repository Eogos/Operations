//pisteet = 700;
//CAMP SHOP (SHIFT + 1)
sleep 5;
[] SPAWN {
private ["_keydown","_aika"];
while {true} do {
//sleep 1;
//_nearest = [] CALL NEARESTCAMP; 
//_color = getmarkercolor _nearest;
waitUntil {sleep 1; (vehicle player distance (getmarkerpos ([] CALL NEARESTAIRFIELD)) < 200 && !((getmarkerpos ([] CALL NEARESTAIRFIELD)) distance (getmarkerpos (["ColorRed"] CALL NEARESTCAMP)) < 800)) || (((vehicle player) call RETURNRANDOM) distance (getmarkerpos ([] CALL NEARESTCAMP)) < (getmarkersize ([] CALL NEARESTCAMP) select 0) && getmarkercolor ([] CALL NEARESTCAMP) == "ColorBlue")};
//if (_nearest == [] CALL NEARESTCAMP && getmarkercolor _nearest != "ColorRed") then {
waituntil {!(IsNull (findDisplay 46))};
_keyDown = (findDisplay 46) displayAddEventHandler ["KeyDown", "if (_this select 2 && _this select 1 == 0x02 && leader player == player) then {_nul = [] SPAWN KAUPPA;};"];
//_nearest = [] CALL NEARESTCAMP; 
//_color = getmarkercolor _nearest;
_aika = time + 30;
waitUntil {sleep 2; _aika < time || ((((vehicle player) distance (getmarkerpos ([] CALL NEARESTCAMP))) >= (getmarkersize ([] CALL NEARESTCAMP) select 0) || "ColorBlue" != getmarkercolor ([] CALL NEARESTCAMP)) && !(vehicle player distance (getmarkerpos ([] CALL NEARESTAIRFIELD)) < 200 && !((getmarkerpos ([] CALL NEARESTAIRFIELD)) distance (getmarkerpos (["ColorRed"] CALL NEARESTCAMP)) < 800)))};
waituntil {!(IsNull (findDisplay 46))};
(findDisplay 46) displayRemoveEventHandler ["KeyDown",_keyDown];
//};

};
};



//SUPPORT (SHIFT + 6)
[] SPAWN {
private ["_keydown"];
while {true} do {
waituntil {!(IsNull (findDisplay 46))};
_keyDown = (findDisplay 46) displayAddEventHandler ["KeyDown", "if (_this select 2 && _this select 1 == 0x07 && leader player == player) then {_nul = [] execVM ""SupportDialog.sqf"";};"];
sleep 30;
waituntil {!(IsNull (findDisplay 46))};
(findDisplay 46) displayRemoveEventHandler ["KeyDown",_keyDown];
};
};

//VILLAGE SHOP (SHIFT + 5)
[] SPAWN {
private ["_nearest","_keydown"];
while {true} do {
//sleep 1;
//_nearest = [] CALL NEARESTVILLAGE; 
//_color = getmarkercolor _nearest;
waitUntil {sleep 1; (vehicle player) distance (getmarkerpos ([] CALL NEARESTVILLAGE)) < (getmarkersize ([] CALL NEARESTVILLAGE) select 0)};
//if (_nearest == [] CALL NEARESTVILLAGE) then {
waituntil {!(IsNull (findDisplay 46))};
_keyDown = (findDisplay 46) displayAddEventHandler ["KeyDown", "if (_this select 2 && _this select 1 == 0x06 && leader player == player) then {_nul = [] SPAWN KAUPPAVILLAGE;};"];
//_nearest = [] CALL NEARESTVILLAGE; 
//_color = getmarkercolor _nearest;
_aika = time + 30;
waitUntil {sleep 2;_aika < time || ((vehicle player) distance (getmarkerpos ([] CALL NEARESTVILLAGE))) >= (getmarkersize ([] CALL NEARESTVILLAGE) select 0)};
waituntil {!(IsNull (findDisplay 46))};
(findDisplay 46) displayRemoveEventHandler ["KeyDown",_keyDown];
//};

};
};

//TALK TO CIVILIAN (SHIFT + 2)
[] SPAWN {
private ["_keydown"];
while {true} do {
sleep 1;
waituntil {sleep 2; {[_x,player] CALL FUNKTIO_LOS} count ((getposATL player) nearEntities [["Civilian"],15]) > 0};
waituntil {!(IsNull (findDisplay 46))};
_keyDown = (findDisplay 46) displayAddEventHandler ["KeyDown", "if (_this select 2 && _this select 1 == 0x03 && leader player == player) then {_nul = [] SPAWN CONVERSATIONWITHCIVILIANS;};"];
waituntil {sleep 2; {[_x,player] CALL FUNKTIO_LOS} count ((getposATL player) nearEntities [["Civilian"],15]) == 0};
waituntil {!(IsNull (findDisplay 46))};
(findDisplay 46) displayRemoveEventHandler ["KeyDown",_keyDown];
};
};

/*
//MINEFIELD Shift+L
[] SPAWN {
private ["_keydown"];
while {true} do {
waituntil {!(IsNull (findDisplay 46))};
_keyDown = (findDisplay 46) displayAddEventHandler ["KeyDown", "if (_this select 2 && _this select 1 == 0x26 && leader player == player) then {_nul = (groupSelectedUnits (leader (([] CALL AllPf) call RETURNRANDOM))) execVM ""MinefieldInit.sqf"";};"];
sleep 30;
waituntil {!(IsNull (findDisplay 46))};
(findDisplay 46) displayRemoveEventHandler ["KeyDown",_keyDown];
};
};
*/
//CONSTRUCT Shift+C 
[] SPAWN {
private ["_keydown"];
while {true} do {
waituntil {!(IsNull (findDisplay 46))};
_keyDown = (findDisplay 46) displayAddEventHandler ["KeyDown", "if (_this select 2 && _this select 1 == 0x2E && leader player == player) then {_nul = [] execVM ""ConstructionDialog.sqf"";};"];
sleep 30;
waituntil {!(IsNull (findDisplay 46))};
(findDisplay 46) displayRemoveEventHandler ["KeyDown",_keyDown];
};
};

//WAIT TIME Shift+3
[] SPAWN {
private ["_keydown"];
while {true} do {
waituntil {!(IsNull (findDisplay 46))};
_keyDown = (findDisplay 46) displayAddEventHandler ["KeyDown", "if (_this select 2 && _this select 1 == 0x04 && leader player == player) then {_nul = (groupSelectedUnits (leader (([] CALL AllPf) call RETURNRANDOM))) execVM ""WaitTime.sqf"";};"];
sleep 30;
waituntil {!(IsNull (findDisplay 46))};
(findDisplay 46) displayRemoveEventHandler ["KeyDown",_keyDown];
};
};


//Fast Travel Shift+4
[] SPAWN {
private ["_keydown"];
while {true} do {
waituntil {!(IsNull (findDisplay 46))};
_keyDown = (findDisplay 46) displayAddEventHandler ["KeyDown", "if (_this select 2 && _this select 1 == 0x05 && leader player == player) then {_nul = [] execVM ""FastTravelDialog.sqf"";};"];
sleep 30;
waituntil {!(IsNull (findDisplay 46))};
(findDisplay 46) displayRemoveEventHandler ["KeyDown",_keyDown];
};
};

