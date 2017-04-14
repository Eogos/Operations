
private ["_group","_ind","_St","_Batman","_vo","_eh","_cur","_vI","_uI","_ma","_ynit","_weap","_packs","_vests","_uniF","_hats","_nul","_num","_mag","_ok"];
SAOKSTARTDIASET = {
switch _this do {
case "Long Walls": {
	if ((lbCurSel 1506) == 0) then {Bwalll = nil;};
	if ((lbCurSel 1506) == 1) then {Bwalll = 1;};
};
case "Asset Unlocking": {
	SAOKSARN set [0, (lbCurSel 1506)];
	if ((lbCurSel 1506) == 0) then {Zorro = 0;};
	if ((lbCurSel 1506) == 1) then {Zorro = 1;};
};
case "Player Respawning": {
	SAOKSARN set [1, (lbCurSel 1506)];
	if ((lbCurSel 1506) == 0) then {Bumblebeeman = 0; SaOkmissionnamespace setvariable ["ResTT",25];};
	if ((lbCurSel 1506) == 1) then {Bumblebeeman = 0; SaOkmissionnamespace setvariable ["ResTT",10];};
	if ((lbCurSel 1506) == 2) then {Bumblebeeman = 1; SaOkmissionnamespace setvariable ["ResTT",nil];};
};
case "Start Time": {
	SAOKSARN set [2, (lbCurSel 1506)];
	if ((lbCurSel 1506) == 0) then {Stime = 13;};
	if ((lbCurSel 1506) == 1) then {Stime = 18;};
	if ((lbCurSel 1506) == 2) then {Stime = 0;};
	if ((lbCurSel 1506) == 3) then {Stime = 8;};
	if ((lbCurSel 1506) == 4) then {Stime = random 24;};
	if ((lbCurSel 1506) == 5) then {Stime = -1;};
};
case "Dynamic Weather": {
if ((lbCurSel 1506) == 0) then {FogOFF = nil; RainyW = nil;DisW = nil;};
if ((lbCurSel 1506) == 1) then {FogOFF = true; RainyW = nil;DisW = nil;};
if ((lbCurSel 1506) == 2) then {FogOFF = nil; RainyW = true;DisW = nil;};
if ((lbCurSel 1506) == 3) then {FogOFF = true; RainyW = nil;DisW = 1;};
if ((lbCurSel 1506) == 4) then {FogOFF = true; RainyW = nil;DisW = 2;};
};
case "Player Respawning": {
if ((lbCurSel 1506) == 0) then {SaOkmissionnamespace setvariable ["NewRespawn",nil];};
if ((lbCurSel 1506) == 1) then {SaOkmissionnamespace setvariable ["NewRespawn",1];};
};
case "Player Needs": {
if ((lbCurSel 1506) == 0) then {PNEEDS = true;};
if ((lbCurSel 1506) == 1) then {PNEEDS = nil;};
};
case "Constructing": {
if ((lbCurSel 1506) == 0) then {GUARDLIM = true;};
if ((lbCurSel 1506) == 1) then {GUARDLIM = false;};
};
case "Ambient Life": {
if ((lbCurSel 1506) == 0) then {MULTLIFE=2;HITEMDIS = 40;};
if ((lbCurSel 1506) == 1) then {MULTLIFE=1;HITEMDIS = 35;};
if ((lbCurSel 1506) == 2) then {MULTLIFE=0;HITEMDIS = 30;};
if ((lbCurSel 1506) == 3) then {MULTLIFE=-0.5;HITEMDIS = 25;};
};
case "Life Range": {
if ((lbCurSel 1506) == 0) then {DISVAR = 1000;};
if ((lbCurSel 1506) == 1) then {DISVAR = 1100;};
if ((lbCurSel 1506) == 2) then {DISVAR = 1200;};
if ((lbCurSel 1506) == 3) then {DISVAR = 1300;};
if ((lbCurSel 1506) == 4) then {DISVAR = 1400;};
if ((lbCurSel 1506) == 5) then {DISVAR = 1500;};
};
case "PP-Effects": {
SAOKSARN set [3, (lbCurSel 1506)];
SAOKPP = (lbText [1506, (lbCurSel 1506)]);
[(lbText [1506, (lbCurSel 1506)])] CALL BIS_fnc_setPPeffectTemplate;
};
case "AI Artillery": {
if ((lbCurSel 1506) == 0) then {VarDisableArty = nil;};
if ((lbCurSel 1506) == 1) then {VarDisableArty = true;};
};
case "Autosave": {
if ((lbCurSel 1506) == 0) then {SaOkmissionnamespace setvariable ["Autosave",nil];};
if ((lbCurSel 1506) == 1) then {SaOkmissionnamespace setvariable ["Autosave",60];};
if ((lbCurSel 1506) == 2) then {SaOkmissionnamespace setvariable ["Autosave",45];};
if ((lbCurSel 1506) == 3) then {SaOkmissionnamespace setvariable ["Autosave",30];};
if ((lbCurSel 1506) == 4) then {SaOkmissionnamespace setvariable ["Autosave",15];};
};
};
};
SAOKSARN = [0,0,2,0];
SAOKSTARTDIACAT = {
lbClear 1506;
switch _this do {
case "Long Walls": {
lbAdd [1506, "Enabled"];
lbSetTooltip [1506,0,"CSAT is able to build long walls around their camps and factories"];
lbAdd [1506, "Disabled"];
lbSetTooltip [1506,1,"No long walls. Bit more stable FPS and less troublesome for AI"];
_c = 1;
if (isNil"Bwalll") then {_c = 0;};
lbSetCurSel [1506, _c];
};
case "Asset Unlocking": {
lbAdd [1506, "From Tasks"];
lbSetTooltip [1506,0,"More content comes available in support call/constructing/other during made progress in tasks"];
lbAdd [1506, "All Available"];
lbSetTooltip [1506,1,"All stuff available from start, kind of cheat mode and conflict with the mission's story"];
lbSetCurSel [1506, SAOKSARN select 0];
};
case "Player Respawning": {
lbAdd [1506, "Normal"];
lbSetTooltip [1506,0,"Full waittime, when respawning"];
lbAdd [1506, "Faster"];
lbSetTooltip [1506,1,"Shorter waittime, when respawning"];
lbAdd [1506, "Disabled"];
lbSetTooltip [1506,2,"Mission ends when dieing"];
lbSetCurSel [1506, SAOKSARN select 1];
};
case "Start Time": {
lbAdd [1506, "Night"];
lbAdd [1506, "Dawn"];
lbAdd [1506, "Mid-Day"];
lbAdd [1506, "Dusk"];
lbAdd [1506, "Random"];
lbSetCurSel [1506, SAOKSARN select 2];
};
case "Dynamic Weather": {
_n = 0;
if (!isNil"FogOFF" && {isNil"RainyW"} && {isNil"DisW"}) then {_n = 1;};
if (isNil"FogOFF" && {!isNil"RainyW"} && {isNil"DisW"}) then {_n = 2;};
if (!isNil"FogOFF" && {isNil"RainyW"} && {!isNil"DisW"} && {DisW == 1}) then {_n = 3;};
if (!isNil"FogOFF" && {isNil"RainyW"} && {!isNil"DisW"} && {DisW == 2}) then {_n = 4;};
lbAdd [1506, "Normal"];
lbSetTooltip [1506,0,"Random dynamic weather"];
lbAdd [1506, "Fog OFF"];
lbSetTooltip [1506,1,"Random dynamic weather without fog"];
lbAdd [1506, "Rainy"];
lbSetTooltip [1506,2,"Rainy dynamic weather"];
lbAdd [1506, "Cloudy(D)"];
lbSetTooltip [1506,3,"Cloudy and fixed weather"];
lbAdd [1506, "Sunny(D)"];
lbSetTooltip [1506,4,"Sunny and fixed weather"];
lbSetCurSel [1506, _n];
};
case "Player Needs": {
lbAdd [1506, "Enabled"];
lbSetTooltip [1506,0,"Blurry screen effects if getting thirsty, hungry, sleepy or sick"];
lbAdd [1506, "Disabled"];
lbSetTooltip [1506,1,"Player always in good shape. No blur effects"];
_c = 0;
if (!isNil"PNEEDS") then {_c = 0;};
if (isNil"PNEEDS") then {_c = 1;};
lbSetCurSel [1506, _c];
};
case "Constructing": {
lbAdd [1506, "LimitedForFPS"];
lbSetTooltip [1506,0,"Constructing posts have set limits to keep FPS good more likely"];
lbAdd [1506, "Freedom"];
lbSetTooltip [1506,1,"No limits when constructing, player need to keep eye on performance changes by himself"];
_c = 0;
if (GUARDLIM) then {_c = 0;};
if (!GUARDLIM) then {_c = 1;};
lbSetCurSel [1506, _c];
};

case "Ambient Life": {
lbAdd [1506, "Triple"];
lbAdd [1506, "Double"];
lbAdd [1506, "Normal"];
lbAdd [1506, "Half"];
_c = 0;
if (MULTLIFE == 2) then {_c = 0;};
if (MULTLIFE == 1) then {_c = 1;};
if (MULTLIFE == 0) then {_c = 2;};
if (MULTLIFE < 0) then {_c = 3;};
lbSetCurSel [1506, _c];
};
case "Life Range": {
lbAdd [1506, "Normal"];
lbSetTooltip [1506,0,"Enemy patrols are met close more likely, camps and posts are spawned inside smaller distance"];
lbAdd [1506, "+10%"];
lbAdd [1506, "+20%"];
lbSetTooltip [1506,2,"Enemy patrols are met less close more likely, camps and posts are spawned inside around 200-400m bigger distance. Bit more CPU demanding"];
lbAdd [1506, "+30%"];
lbAdd [1506, "+40%"];
lbAdd [1506, "+50%"];
lbSetTooltip [1506,5,"Enemy patrols are met far more likely, camps and posts are spawned inside around 500-1000m bigger distance. More CPU demanding"];
_c = 0;
if (DISVAR == 1000) then {_c = 0;};
if (DISVAR == 1100) then {_c = 1;};
if (DISVAR == 1200) then {_c = 2;};
if (DISVAR == 1300) then {_c = 3;};
if (DISVAR == 1400) then {_c = 4;};
if (DISVAR == 1500) then {_c = 5;};
lbSetCurSel [1506, _c];
};
case "PP-Effects": {
lbAdd [1506, "Default"];
_count = (count (configFile / "CfgPostProcessTemplates")) - 1; 
while {_count > 0} do {
_n = configName ((configFile / "CfgPostProcessTemplates") select _count);
_count = _count - 1;
if (_n != "Default") then {lbAdd [1506, _n];};
};
lbSetCurSel [1506, SAOKSARN select 3];
};
case "AI Artillery": {
lbAdd [1506, "Enabled"];
lbSetTooltip [1506,0,"Enemy can call artillery and mortar strikes if there is related marked zone nearby"];
lbAdd [1506, "Disabled"];
lbSetTooltip [1506,1,"Enemy cannot call artillery and mortar strikes"];
_c = 0;
if (isNil"VarDisableArty") then {_c = 0;};
if (!isNil"VarDisableArty") then {_c = 1;};
lbSetCurSel [1506, _c];
};
case "Player Respawning": {
lbAdd [1506, "NEW for AI fix"];
lbSetTooltip [1506,0,"Enemy dont know your respawn location. Some mods may not work"];
lbAdd [1506, "OLD for Mods"];
lbSetTooltip [1506,1,"Certain mods work better, but enemy knows your respawn location"];
_c = 0;
if (isNil{SaOkmissionnamespace getvariable "NewRespawn"}) then {_c = 0;};
if (!isNil{SaOkmissionnamespace getvariable "NewRespawn"}) then {_c = 1;};
lbSetCurSel [1506, _c];
};
case "Autosave": {
lbAdd [1506, "Never"];
lbSetTooltip [1506,0,"Never autosaving"];
lbAdd [1506, "60min"];
lbSetTooltip [1506,1,"Creates custom savegame file that can be resumed in mission start options even if restarting mission"];
lbAdd [1506, "45min"];
lbSetTooltip [1506,2,"Creates custom savegame file that can be resumed in mission start options even if restarting mission"];
lbAdd [1506, "30min"];
lbSetTooltip [1506,3,"Creates custom savegame file that can be resumed in mission start options even if restarting mission"];
lbAdd [1506, "15min"];
lbSetTooltip [1506,4,"Creates custom savegame file that can be resumed in mission start options even if restarting mission"];
_c = 0;
if (isNil{SaOkmissionnamespace getvariable "Autosave"}) then {_c = 0;};
if (!isNil{SaOkmissionnamespace getvariable "Autosave"} && {SaOkmissionnamespace getvariable "Autosave" == 60}) then {_c = 1;};
if (!isNil{SaOkmissionnamespace getvariable "Autosave"} && {SaOkmissionnamespace getvariable "Autosave" == 45}) then {_c = 2;};
if (!isNil{SaOkmissionnamespace getvariable "Autosave"} && {SaOkmissionnamespace getvariable "Autosave" == 30}) then {_c = 3;};
if (!isNil{SaOkmissionnamespace getvariable "Autosave"} && {SaOkmissionnamespace getvariable "Autosave" == 15}) then {_c = 4;};
lbSetCurSel [1506, _c];
};
};
};

SAOKWLAOPTIONS = {
if (dialog) exitWith {};
"Changes may take time to have effect" SPAWN HINTSAOK;
disableserialization;
_ok = createDialog "WLAOptions"; 
if (serverCommandAvailable "#kick" || {(!isDedicated && {isServer})}) then {
lbAdd [1500, "Difficulty"];
lbAdd [1500, "Time Multiplier"];
lbAdd [1500, "Player Needs"];
lbAdd [1500, "Constructing"];
lbAdd [1500, "Ambient Life"];
lbAdd [1500, "Life Range"];
lbAdd [1500, "AI Artillery"];
lbAdd [1500, "Autosave"];
lbAdd [1500, "Max VZones"];
lbAdd [1500, "Random Weapons AI"];
lbAdd [1500, "Animals"];
};
//lbAdd [1500, "Weather"];
lbAdd [1500, "PP-Effects"];
//lbAdd [1500, "Fatigue"];
lbSetCurSel [1500, 0];
};


//MAXACTIVEV setTimeMultiplier RANWEES
SAOKWLAOPTIONSELECTED = {
lbClear 1501;
switch _this do {
case "Weather": {
_n = 0;
if (!isNil"FogOFF" && {isNil"RainyW"} && {isNil"DisW"}) then {_n = 1;};
if (isNil"FogOFF" && {!isNil"RainyW"} && {isNil"DisW"}) then {_n = 2;};
if (!isNil"FogOFF" && {isNil"RainyW"} && {!isNil"DisW"} && {DisW == 1}) then {_n = 3;};
if (!isNil"FogOFF" && {isNil"RainyW"} && {!isNil"DisW"} && {DisW == 2}) then {_n = 4;};
lbAdd [1501, "Normal"];
lbAdd [1501, "Fog OFF"];
lbAdd [1501, "Rainy"];
lbAdd [1501, "Cloudy(D)"];
lbAdd [1501, "Sunny(D)"];
lbSetCurSel [1501, 0];
};
case "Random Weapons AI": {
lbAdd [1501, "Enabled"];
lbAdd [1501, "Disabled"];
_c = 0;
if (!isNil"NORANWEES") then {_c = 1;};
lbSetCurSel [1501, _c];
};

case "Time Multiplier": {
lbAdd [1501, "Normal"];
lbAdd [1501, "4x"];
lbAdd [1501, "10x"];
lbAdd [1501, "60x"];
_c = 0;
if (TIMMUL == 1) then {_c = 0;};
if (TIMMUL == 4) then {_c = 1;};
if (TIMMUL == 10) then {_c = 2;};
if (TIMMUL == 60) then {_c = 3;};
lbSetCurSel [1501, _c];
};
case "Max VZones": {
"How many active vehicle zones there can be at once for side, other wait in reserve state" SPAWN HINTSAOK;
lbAdd [1501, "1"];
lbAdd [1501, "2"];
lbAdd [1501, "3"];
lbAdd [1501, "4"];
lbAdd [1501, "5"];
lbAdd [1501, "6"];
_c = MAXACTIVEV - 1;
lbSetCurSel [1501, _c];
};
case "Difficulty": {
lbAdd [1501, "Hard"];
lbAdd [1501, "Challenging"];
lbAdd [1501, "Normal"];
lbAdd [1501, "Easy"];
_c = 0;
if (DIFLEVEL == 2) then {_c = 0;};
if (DIFLEVEL == 1) then {_c = 1;};
if (DIFLEVEL == 0.5) then {_c = 2;};
if (DIFLEVEL == 0.25) then {_c = 3;};
lbSetCurSel [1501, _c];
};
case "Player Needs": {
lbAdd [1501, "Enabled"];
lbAdd [1501, "Disabled"];
_c = 0;
if (!isNil"PNEEDS") then {_c = 0;};
if (isNil"PNEEDS") then {_c = 1;};
lbSetCurSel [1501, _c];
};
case "Constructing": {
lbAdd [1501, "LimitedForFPS"];
lbAdd [1501, "Freedom"];
_c = 0;
if (GUARDLIM) then {_c = 0;};
if (!GUARDLIM) then {_c = 1;};
lbSetCurSel [1501, _c];
};

case "Ambient Life": {
lbAdd [1501, "Triple"];
lbAdd [1501, "Double"];
lbAdd [1501, "Normal"];
lbAdd [1501, "Half"];
_c = 0;
if (MULTLIFE == 2) then {_c = 0;};
if (MULTLIFE == 1) then {_c = 1;};
if (MULTLIFE == 0) then {_c = 2;};
if (MULTLIFE < 0) then {_c = 3;};
lbSetCurSel [1501, _c];
};
case "Life Range": {
lbAdd [1501, "Normal"];
lbAdd [1501, "+10%"];
lbAdd [1501, "+20%"];
lbAdd [1501, "+30%"];
lbAdd [1501, "+40%"];
lbAdd [1501, "+50%"];
_c = 0;
if (DISVAR == 1000) then {_c = 0;};
if (DISVAR == 1100) then {_c = 1;};
if (DISVAR == 1200) then {_c = 2;};
if (DISVAR == 1300) then {_c = 3;};
if (DISVAR == 1400) then {_c = 4;};
if (DISVAR == 1500) then {_c = 5;};
lbSetCurSel [1501, _c];
};
case "PP-Effects": {
lbAdd [1501, "Default"];
_count = (count (configFile / "CfgPostProcessTemplates")) - 1; 
while {_count > 0} do {
_n = configName ((configFile / "CfgPostProcessTemplates") select _count);
_count = _count - 1;
if (_n != "Default") then {lbAdd [1501, _n];};
};
lbSetCurSel [1501, 0];

};
case "AI Artillery": {
lbAdd [1501, "Enabled"];
lbAdd [1501, "Disabled"];
_c = 0;
if (isNil"VarDisableArty") then {_c = 0;};
if (!isNil"VarDisableArty") then {_c = 1;};
lbSetCurSel [1501, _c];
};
case "Respawn": {
"With NEW, enemy dont know your respawn location. With OLD, certain mods work better" SPAWN HINTSAOK;
lbAdd [1501, "NEW for AI fix"];
lbAdd [1501, "OLD for Mods"];
_c = 0;
if (isNil{SaOkmissionnamespace getvariable "NewRespawn"}) then {_c = 0;};
if (!isNil{SaOkmissionnamespace getvariable "NewRespawn"}) then {_c = 1;};
lbSetCurSel [1501, _c];
};
case "Fatigue": {
lbAdd [1501, "Enabled"];
lbAdd [1501, "Disabled"];
_c = 0;
if (isNil{SaOkmissionnamespace getvariable "NewFatigue"}) then {_c = 0;};
if (!isNil{SaOkmissionnamespace getvariable "NewFatigue"}) then {_c = 1;};
lbSetCurSel [1501, _c];
};
case "Autosave": {
lbAdd [1501, "Never"];
lbAdd [1501, "60min"];
lbAdd [1501, "45min"];
lbAdd [1501, "30min"];
lbAdd [1501, "15min"];
_c = 0;
if (isNil{SaOkmissionnamespace getvariable "Autosave"}) then {_c = 0;};
if (!isNil{SaOkmissionnamespace getvariable "Autosave"} && {SaOkmissionnamespace getvariable "Autosave" == 60}) then {_c = 1;};
if (!isNil{SaOkmissionnamespace getvariable "Autosave"} && {SaOkmissionnamespace getvariable "Autosave" == 45}) then {_c = 2;};
if (!isNil{SaOkmissionnamespace getvariable "Autosave"} && {SaOkmissionnamespace getvariable "Autosave" == 30}) then {_c = 3;};
if (!isNil{SaOkmissionnamespace getvariable "Autosave"} && {SaOkmissionnamespace getvariable "Autosave" == 15}) then {_c = 4;};
lbSetCurSel [1501, _c];
};
case "Animals": {
lbAdd [1501, "Enabled"];
lbAdd [1501, "Disabled"];
_c = 0;
if (isNil{SaOkmissionnamespace getvariable "SaOkNoAnimals"}) then {_c = 0;};
if (!isNil{SaOkmissionnamespace getvariable "SaOkNoAnimals"}) then {_c = 1;};
lbSetCurSel [1501, _c];
};

};
};

//MAXACTIVEV setTimeMultiplier "Random Weapons AI"
SAOKWLAOPTIONCHANGED = {
switch (lbText [1500, (lbCurSel 1500)]) do {
case "Animals": {
if ((lbCurSel 1501) == 0) then {SaOkNoAnimals = nil;};
if ((lbCurSel 1501) == 1) then {SaOkNoAnimals = 1;};
publicvariable "SaOkNoAnimals";
};
case "Random Weapons AI": {
if ((lbCurSel 1501) == 0) then {NORANWEES = nil;};
if ((lbCurSel 1501) == 1) then {NORANWEES = 1;};
publicvariable "NORANWEES";
};
case "Weather": {
if ((lbCurSel 1501) == 0) then {FogOFF = nil; RainyW = nil;DisW = nil;};
if ((lbCurSel 1501) == 1) then {FogOFF = true; RainyW = nil;DisW = nil;};
if ((lbCurSel 1501) == 2) then {FogOFF = nil; RainyW = true;DisW = nil;};
if ((lbCurSel 1501) == 3) then {FogOFF = true; RainyW = nil;DisW = 1;};
if ((lbCurSel 1501) == 4) then {FogOFF = true; RainyW = nil;DisW = 2;};
publicvariable "FogOFF";
publicvariable "RainyW";
publicvariable "DisW";
};
case "Time Multiplier": {
if ((lbCurSel 1501) == 0) then {TIMMUL = 1;};
if ((lbCurSel 1501) == 1) then {TIMMUL = 4;};
if ((lbCurSel 1501) == 2) then {TIMMUL = 10;};
if ((lbCurSel 1501) == 3) then {TIMMUL = 60;};
//setTimeMultiplier TIMMUL;
[TIMMUL,"SAOKSETTIMUL",false,false] spawn BIS_fnc_MP;
publicvariable "TIMMUL";
};
case "Max VZones": {
MAXACTIVEV = (lbCurSel 1501) + 1;
publicvariable "MAXACTIVEV";
};
case "Fatigue": {
if ((lbCurSel 1501) == 0) then {SaOkmissionnamespace setvariable ["NewFatigue",nil]; player enableFatigue true;};
if ((lbCurSel 1501) == 1) then {SaOkmissionnamespace setvariable ["NewFatigue",1]; player enableFatigue false;};
};
case "Respawn": {
if ((lbCurSel 1501) == 0) then {SaOkmissionnamespace setvariable ["NewRespawn",nil];};
if ((lbCurSel 1501) == 1) then {SaOkmissionnamespace setvariable ["NewRespawn",1];};
};
case "Difficulty": {
if ((lbCurSel 1501) == 0) then {DIFLEVEL = 2;PLSTREGHT = 1;};
if ((lbCurSel 1501) == 1) then {DIFLEVEL = 1;PLSTREGHT = 0.5;};
if ((lbCurSel 1501) == 2) then {DIFLEVEL = 0.5;PLSTREGHT = 0.4;};
if ((lbCurSel 1501) == 3) then {DIFLEVEL = 0.25;PLSTREGHT = 0.2;};
publicvariable "DIFLEVEL";
publicvariable "PLSTREGHT";
};
case "Player Needs": {
if ((lbCurSel 1501) == 0) then {PNEEDS = true;};
if ((lbCurSel 1501) == 1) then {PNEEDS = nil;};
publicvariable "PNEEDS";
};
case "Constructing": {
if ((lbCurSel 1501) == 0) then {GUARDLIM = true;};
if ((lbCurSel 1501) == 1) then {GUARDLIM = false;};
publicvariable "GUARDLIM";
};
case "Ambient Life": {
if ((lbCurSel 1501) == 0) then {MULTLIFE=2;HITEMDIS = 40;};
if ((lbCurSel 1501) == 1) then {MULTLIFE=1;HITEMDIS = 35;};
if ((lbCurSel 1501) == 2) then {MULTLIFE=0;HITEMDIS = 30;};
if ((lbCurSel 1501) == 3) then {MULTLIFE=-0.5;HITEMDIS = 25;};
publicvariable "MULTLIFE";
publicvariable "HITEMDIS";
};
case "Life Range": {
if ((lbCurSel 1501) == 0) then {DISVAR = 1000;};
if ((lbCurSel 1501) == 1) then {DISVAR = 1100;};
if ((lbCurSel 1501) == 2) then {DISVAR = 1200;};
if ((lbCurSel 1501) == 3) then {DISVAR = 1300;};
if ((lbCurSel 1501) == 4) then {DISVAR = 1400;};
if ((lbCurSel 1501) == 5) then {DISVAR = 1500;};
publicvariable "DISVAR";
};
case "PP-Effects": {
SAOKPP = (lbText [1501, (lbCurSel 1501)]);
[(lbText [1501, (lbCurSel 1501)])] CALL BIS_fnc_setPPeffectTemplate;
};
case "AI Artillery": {
if ((lbCurSel 1501) == 0) then {VarDisableArty = nil;};
if ((lbCurSel 1501) == 1) then {VarDisableArty = true;};
publicvariable "VarDisableArty";
};
case "Autosave": {
if ((lbCurSel 1501) == 0) then {SaOkmissionnamespace setvariable ["Autosave",nil,true];};
if ((lbCurSel 1501) == 1) then {SaOkmissionnamespace setvariable ["Autosave",60,true];};
if ((lbCurSel 1501) == 2) then {SaOkmissionnamespace setvariable ["Autosave",45,true];};
if ((lbCurSel 1501) == 3) then {SaOkmissionnamespace setvariable ["Autosave",30,true];};
if ((lbCurSel 1501) == 4) then {SaOkmissionnamespace setvariable ["Autosave",15,true];};
};
};
};

if (isServer) then {
_fN = "SaOkSaveWLAMP";
_op = true;
if (worldname != "Altis") then {_fN = _fN + worldname;};
if (!isNil{profileNamespace getvariable _fN} && {(paramsArray select 9) == 1}) then {
SAOKRESUME = true; 
publicvariable "SAOKRESUME";
_nn = [""] SPAWN FSaOkSave;
sleep 4;
StartMission = true; publicvariable "StartMission";
waitUntil {sleep 1;scriptdone _nn};
setTimeMultiplier TIMMUL;
if (!isnil{SaOkmissionNamespace getvariable "Progress"} && {"MetResContact" in (SaOkmissionNamespace getvariable "Progress")}) then {
_nul = ["task2","SUCCEEDED"] call BIS_fnc_taskSetState;
};
} else {
[] SPAWN {
sleep 20;
{
if (random 1 < 0.5) then {
_st = [getmarkerpos _x, 150,"(1 - sea) * (1 + meadow)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
_nul = [_start,"",25] SPAWN CreateRoadBlock;
};
sleep 0.1;
} foreach FacMarkers;
};
};
if (isServer) then {
SaOkmissionnamespace setvariable ["Autosave",45,true];
TIMMUL = (paramsArray select 1);
setTimeMultiplier TIMMUL;
_tiyi = if ((paramsArray select 5) == 4) then {random 24} else {2};
if ((paramsArray select 5) == 0) then {_tiyi = 13;};
if ((paramsArray select 5) == 1) then {_tiyi = 20;};
if ((paramsArray select 5) == 3) then {_tiyi = 8;};
if (isNil"SAOKRESUME") then {skipTime _tiyi;};
if ((paramsArray select 7) == 0 && {isNil"SAOKRESUME"}) then {NOARTYY = true;};
if ((paramsArray select 8) == 1 && {isNil"SAOKRESUME"}) then {PNEEDS = true;publicVariable "PNEEDS";};
};
StartMission = true; publicvariable "StartMission";
if ((paramsArray select 0) != 0) then {sleep 90;[] CALL SAOKRESETVEHZ;};
};
if (!isDedicated && {!isNil"SAOKRESUME"}) then {

};
Bumblebeeman = 0;
SAOKSTARTDIACAT = nil;
SAOKSTARTDIASET = nil;
SAOKSARN = nil;