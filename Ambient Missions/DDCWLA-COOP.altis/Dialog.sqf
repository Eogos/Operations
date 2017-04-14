
private ["_vii3", "_vii4", "_v3", "_v4", "_ok"];
//////////////////////////////////////////////////////////////////
// Function file for Armed Assault
// Created by: TODO: Author Name
//////////////////////////////////////////////////////////////////

Hint "If you have addon version of the TPW or/and Mando Scripts. Set them disabled in this dialog. \n \n Mando Missile Scripts' effect on FPS on long run isnt yet tested. Set to disabled as default for that reason \n \n If you have ""else very awesome""-Blastcore mod, consider disabling it. The current version is conficting with this mission causing heavy suddent FPS drop after 1-1,5hours of playing. Sad but true. \n\n Feel free to post feedback in ArmaHolic, OFPEC or to mission´s topic in biforum - named ""[SP/MP] Dynamic Whole Map Missions by SaOk""";

//_vii3 = "<t color='#F3F308'>Hard</t>"; 
_vii4 = "<t color='#0FC31B'>Normal</t>";
_vii5 = "<t color='#0FC31B'>Enabled</t>";
_vii6 = "<t color='#D80C0C'>Disabled</t>";
_vii7 = "<t color='#0FC31B'>Enabled</t>";
_v3 = 3;
_v4 = 0;
_v5 = 1;
_v6 = 1;
_v7 = 0;
_ok = createDialog "MyHelloWorldDialog"; 
	lbAdd [114, "None"];
	lbAdd [114, "TPWCAS"];
	lbAdd [114, "TPWLOS"];
	lbAdd [114, "TPWCAS+TPWLOS"];
	lbSetCurSel [114, 3];
	lbAdd [115, "Half"];
	lbAdd [115, "Normal"];
	lbAdd [115, "Doubled"];
	lbAdd [115, "Tripled"];
	lbAdd [115, "4x"];
	lbAdd [115, "5x"];
	lbSetCurSel [115, 1];
	lbAdd [116, "Enabled"];
	lbAdd [116, "Disabled"];
	lbSetCurSel [116, 1];
	lbAdd [117, "Enabled"];
	lbAdd [117, "Disabled"];
	lbSetCurSel [117, 1];
	lbAdd [118, "Enabled"];
	lbAdd [118, "Disabled"];
	lbSetCurSel [118, 0];
	sleep 0.1;
	while {dialog} do {
	if ((lbCurSel 114) == 0) then {_vii3 = "<t color='#D80C0C'>None</t>"; _v3=0;};
	if ((lbCurSel 114) == 1) then {_vii3 = "<t color='#F3F308'>TPWCAS</t>"; _v3=1;};
	if ((lbCurSel 114) == 2) then {_vii3 = "<t color='#F3F308'>TPWLOS</t>"; _v3=2;};
	if ((lbCurSel 114) == 3) then {_vii3 = "<t color='#0FC31B'>TPWCAS+TPWLOS</t>"; _v3=3;};
	if ((lbCurSel 115) == 0) then {_vii4 = "<t color='#0FC31B'>Half</t>"; _v4=-0.5;};
	if ((lbCurSel 115) == 1) then {_vii4 = "<t color='#F3F308'>Normal</t>"; _v4=0;};
	if ((lbCurSel 115) == 2) then {_vii4 = "<t color='#D80C0C'>Doubled</t>"; _v4=1;}; 
	if ((lbCurSel 115) == 3) then {_vii4 = "<t color='#D80C0C'>Tripled</t>"; _v4=2;}; 
	if ((lbCurSel 115) == 4) then {_vii4 = "<t color='#D80C0C'>4x</t>"; _v4=3;}; 
	if ((lbCurSel 115) == 5) then {_vii4 = "<t color='#D80C0C'>5x</t>"; _v4=4;}; 
	if ((lbCurSel 116) == 0) then {_vii5 = "<t color='#0FC31B'>Enabled</t>"; _v5=0;};
	if ((lbCurSel 116) == 1) then {_vii5 = "<t color='#D80C0C'>Disabled</t>"; _v5=1;};
	if ((lbCurSel 117) == 0) then {_vii6 = "<t color='#0FC31B'>Enabled</t>"; _v6=0;};
	if ((lbCurSel 117) == 1) then {_vii6 = "<t color='#D80C0C'>Disabled</t>"; _v6=1;};
	if ((lbCurSel 118) == 0) then {_vii7 = "<t color='#0FC31B'>Enabled</t>"; _v7=0;};
	if ((lbCurSel 118) == 1) then {_vii7 = "<t color='#D80C0C'>Disabled</t>"; _v7=1;};
	sleep 0.1;
};
if (_v3 == 0) then {_vii3 = "<t color='#D80C0C'>None<</t>";};
if (_v3 == 1) then {_vii3 = "<t color='#F3F308'>TPWCAS</t>"; if (isClass(configFile/"CfgPatches"/"cba_main")) then {_nul = [] execvm "tpwcas\tpwcas.sqf";} else {_vii3 = "<t color='#D80C0C'>CBA wasnt detected - No TPW</t>";};};
if (_v3 == 2) then {_vii3 = "<t color='#F3F308'>TPWLOS</t>"; if (isClass(configFile/"CfgPatches"/"cba_main")) then {_nul = [] execvm "tpw_ai_los.sqf";} else {_vii3 = "<t color='#D80C0C'>CBA wasnt detected - No TPW</t>";};};
if (_v3 == 3) then {_vii3 = "<t color='#0FC31B'>TPWCAS+TPWLOS</t>"; if (isClass(configFile/"CfgPatches"/"cba_main")) then {_nul = [] execvm "tpwcas\tpwcas.sqf";_nul = [] execvm "tpw_ai_los.sqf";} else {_vii3 = "<t color='#D80C0C'>CBA wasnt detected - No TPWs</t>";};};
if (_v4 == -0.5) then {_vii4 = "<t color='#0FC31B'>Half</t>"; MULTLIFE=-0.5;};
if (_v4 == 0) then {_vii4 = "<t color='#F3F308'>Normal</t>"; MULTLIFE=0;};
if (_v4 == 1) then {_vii4 = "<t color='#D80C0C'>Doubled</t>"; MULTLIFE=1;};
if (_v4 == 2) then {_vii4 = "<t color='#D80C0C'>Tripled</t>"; MULTLIFE=2;};
if (_v4 == 3) then {_vii4 = "<t color='#D80C0C'>4x</t>"; MULTLIFE=3;};
if (_v4 == 4) then {_vii4 = "<t color='#D80C0C'>5x</t>"; MULTLIFE=4;};
if (_v5 == 0) then {_vii5 = "<t color='#0FC31B'>Enabled</t>"; FAID=1;};
if (_v5 == 1) then {_vii5 = "<t color='#D80C0C'>Disabled</t>"; FAID=0;};
if (_v6 == 0) then {_vii6 = "<t color='#0FC31B'>Enabled</t>";};
if (_v6 == 1) then {_vii6 = "<t color='#D80C0C'>Disabled</t>";};
if (_v7 == 0) then {_vii7 = "<t color='#0FC31B'>Enabled</t>";};
if (_v7 == 1) then {_vii7 = "<t color='#D80C0C'>Disabled</t>";VarDisableArty=true;};
sleep 1;
BIS_AdvHints_THeader =  "GAMEPLAY SETTINGS";
BIS_AdvHints_TInfo = format ["Ambient Life: %1", _vii4] + "<br/>" + format ["Advanced First Aid: %1", _vii5] + "<br/>" + format ["TPW Script: %1", _vii3] + "<br/>" + format ["Mando Scripts: %1", _vii6]+ "<br/>" + format ["Enemy Artillery/Car Bombs: %1", _vii7];
BIS_AdvHints_TAction = "";
BIS_AdvHints_TBinds = "";
BIS_AdvHints_Text = call BIS_AdvHints_formatText;
BIS_AdvHints_Duration = 6;
BIS_AdvHints_Seamless = true;
BIS_AdvHints_Silent = true;
call BIS_AdvHints_showHint;

//if (isnil"DIFLEVEL") then {DIFLEVEL=1;};
if (isnil"MULTLIFE") then {MULTLIFE=0;};
if (isnil"FAID") then {FAID=1;};
//if (isnil"COMM") then {COMM=0;};
//saveVar "DIFLEVEL";
saveVar "MULTLIFE";
saveVar "FAID";
//saveVar "COMM";
if (_v6 == 0) then {
// Mando Missisle initialization
[false] execVM "mando_missiles\mando_missileinit.sqf";
// Wait for Mando Missile script suite initialization
waitUntil {!isNil "mando_missile_init_done"};
waitUntil {mando_missile_init_done}; 
if (isClass(configFile/"CfgPatches"/"ace_main")) then {[]execVM "mando_missiles\mando_setup_ace.sqf";} else {[]execVM "mando_missiles\mando_setup_full.sqf";};
};