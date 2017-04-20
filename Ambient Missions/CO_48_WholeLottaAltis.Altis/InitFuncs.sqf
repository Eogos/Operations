



private ["_ordercode","_mP","_nG","_pKer","_factories","_power","_pier","_stor","_lisays","_nul","_u","_g","_l","_myGroupX","_msg","_disp","_fM","_fP","_Lna"];
switch (_this) do {
case 0 : {
{
if (isPlayer _x) then {
_x setvariable ["OwnRes",(_x getvariable "OwnRes") + 1,true];
};
sleep 0.1;
} foreach ([EAST] CALL AllPf);
};

case 1 : {

{
if !(_x in AMBbattles) then {
_mP = getmarkerpos _x;
_nG = [_mP] CALL RETURNGUARDPOST;
if (getmarkercolor _x !=  "ColorGreen" && {getmarkercolor (_nG getvariable "Gmark") == "ColorGreen"} && {_mP distance _nG < 150} && {(count (_nG getvariable "StaticW") > 0 || {!isNil{_nG getvariable "MG-Team"}} || {!isNil{_nG getvariable "AA-Team"}} || {!isNil{_nG getvariable "AT-Team"}} || {!isNil{_nG getvariable "Sniper-Team"}} || {!isNil{_nG getvariable "MG-Team"}} || {!isNil{_nG getvariable "Medic-Team"}})}) then {
_x setmarkercolor "ColorGreen";
//["Strategic point enabled",WEST] SPAWN HINTSAOK;SAOKMARKCOL
[["Strategic point enabled",WEST],"HINTSAOK",nil,false] spawn BIS_fnc_MP;
[[_x,"ColorGreen"],"SAOKMARKCOL",nil,false] spawn BIS_fnc_MP;
};
};
} foreach PierMarkers + StoMarkers + PowMarkers;
{
if !(_x in AMBbattles) then {
_mP = getmarkerpos _x;
_nG = [_mP] CALL RETURNGUARDPOST;
if (getmarkercolor _x !=  "ColorGreen" && {getmarkercolor (_nG getvariable "Gmark") == "ColorGreen"} && {[_nG] CALL NEARESTVILLAGERELATIONSHIP == "Friendly"} && {_mP distance _nG < 150} && {(count (_nG getvariable "StaticW") > 0 || {!isNil{_nG getvariable "MG-Team"}} || {!isNil{_nG getvariable "AA-Team"}} || {!isNil{_nG getvariable "AT-Team"}} || {!isNil{_nG getvariable "Sniper-Team"}} || {!isNil{_nG getvariable "MG-Team"}} || {!isNil{_nG getvariable "Medic-Team"}})}) then {
_x setMarkerType "u_installation";
_x setmarkercolor "ColorGreen"; 
[["Strategic point enabled",WEST],"HINTSAOK",nil,false] spawn BIS_fnc_MP;
[[_x,"ColorGreen"],"SAOKMARKCOL",nil,false] spawn BIS_fnc_MP;
};};
} foreach FacMarkers;

};

case 2 : {
if ({getmarkercolor _x == "ColorGreen"} count FacMarkers == 0 && {isNil{SaOkmissionnamespace getvariable "FacTask"}} && {"ResHelp" in (SaOkmissionnamespace getvariable "Progress")}) then {[] SPAWN {
SaOkmissionnamespace setvariable ["FacTask",1];
_Tid = format ["TaskPres%1",NUMM];
NUMM=NUMM+1;
_nearest = FacMarkers call RETURNRANDOM;
[
WEST, // Task owner(s)
_Tid, // Task ID (used when setting task state, destination or description later)
["We need to capture any factory, on the island, in order to create resources to use in this war. To do that we need to build manned guardpost close to the factory and make sure locals are friendly at us, to operate the factory for us<br/><br/><img image='factory.jpg' width='360' height='202.5'/>", "Take Control of Factory", "Take Control of Factory"], // Task description
(getmarkerpos _nearest), // Task destination
"CREATED" // true to set task as current upon creation
] call BIS_fnc_taskCreate;
waitUntil {sleep 15;{getmarkercolor _x == "ColorGreen"} count FacMarkers > 0};
_nul = [_Tid,"SUCCEEDED"] call BIS_fnc_taskSetState;
sleep 15;
_n = [_Tid] CALL BIS_fnc_deleteTask;
SaOkmissionnamespace setvariable ["FacTask",nil];
};
};

if ({getmarkercolor _x == "ColorGreen"} count PowMarkers == 0 && {isNil{SaOkmissionnamespace getvariable "PowTask"}}&& {"ResHelp" in (SaOkmissionnamespace getvariable "Progress")}) then {[] SPAWN {
SaOkmissionnamespace setvariable ["PowTask",1];
_Tid = format ["TaskPres%1",NUMM];
NUMM=NUMM+1;
_nearest = PowMarkers call RETURNRANDOM;
[WEST, // Task owner(s)
_Tid, // Task ID (used when setting task state, destination or description later)
["We need to have control of Power Plant in order to run factories that create resources to use in this war. Manned guardpost need to be built near the plant. (Can be any Power Plant located in the island)<br/><br/><img image='arma3power.jpg' width='360' height='202.5'/>", "Take Control of Power Plant", "Take Control of Power Plant"], // Task description
(getmarkerpos _nearest), // Task destination
"CREATED" // true to set task as current upon creation
] call BIS_fnc_taskCreate;
waitUntil {sleep 15;{getmarkercolor _x == "ColorGreen"} count PowMarkers > 0};
_nul = [_Tid,"SUCCEEDED"] call BIS_fnc_taskSetState;
sleep 15;
_n = [_Tid] CALL BIS_fnc_deleteTask;
SaOkmissionnamespace setvariable ["PowTask",nil];
};
};

if ({getmarkercolor _x == "ColorGreen"} count PierMarkers == 0 && {isNil{SaOkmissionnamespace getvariable "PierTask"}}&& {"ResHelp" in (SaOkmissionnamespace getvariable "Progress")}) then {[] SPAWN {
SaOkmissionnamespace setvariable ["PierTask",1];
_Tid = format ["TaskPres%1",NUMM];
NUMM=NUMM+1;
_nearest = PierMarkers call RETURNRANDOM;
[
WEST, // Task owner(s)
_Tid, // Task ID (used when setting task state, destination or description later)
["Without a pier we cant fight this was with needed assests. Manned guardpost need to be built near the pier.  (Can be any Pier located in the island)<br/><br/><img image='arma3pier.jpg' width='360' height='202.5'/>", "Take Control of Pier", "Take Control of Pier"], // Task description
(getmarkerpos _nearest), // Task destination
"CREATED" // true to set task as current upon creation
] call BIS_fnc_taskCreate;
waitUntil {sleep 15;{getmarkercolor _x == "ColorGreen"} count PierMarkers > 0};
_nul = [_Tid,"SUCCEEDED"] call BIS_fnc_taskSetState;
sleep 15;
_n = [_Tid] CALL BIS_fnc_deleteTask;
SaOkmissionnamespace setvariable ["PierTask",nil];
};
};

if ({getmarkercolor _x == "ColorGreen"} count StoMarkers == 0 && {isNil{SaOkmissionnamespace getvariable "StorTask"}}&& {"ResHelp" in (SaOkmissionnamespace getvariable "Progress")}) then {[] SPAWN {
SaOkmissionnamespace setvariable ["StorTask",1];
_Tid = format ["TaskPres%1",NUMM];
NUMM=NUMM+1;
_nearest = StoMarkers call RETURNRANDOM;
[
WEST, // Task owner(s)
_Tid, // Task ID (used when setting task state, destination or description later)
["Having storage for our use is not vital but may give us small advantage. Manned guardpost need to be built near the storage area. <br/><br/><img image='arma3storage.jpg' width='360' height='202.5'/>", "Take Control of Storage", "Take Control of Storage"], // Task description
(getmarkerpos _nearest), // Task destination
"CREATED" // true to set task as current upon creation
] call BIS_fnc_taskCreate;
waitUntil {sleep 15;{getmarkercolor _x == "ColorGreen"} count StoMarkers > 0};
_nul = [_Tid,"SUCCEEDED"] call BIS_fnc_taskSetState;
sleep 15;
_n = [_Tid] CALL BIS_fnc_deleteTask;
SaOkmissionnamespace setvariable ["StorTask",nil];
};
};
sleep 0.1;
// SaOK_factories SaOK_power SaOK_pier SaOK_stor
_pKer = 0.1;
_factories = ({getmarkercolor _x == "ColorGreen"} count FacMarkers)+({getmarkercolor _x == "ColorPink"} count FacMarkers)*0.5;
SaOK_factories = _factories;
publicvariable "SaOK_factories";
_power = ({getmarkercolor _x == "ColorGreen"} count PowMarkers) + ({getmarkercolor _x == "ColorPink"} count PowMarkers)*0.5;
SaOK_power = _power;
publicvariable "SaOK_power";
_pier = ({getmarkercolor _x == "ColorGreen"} count PierMarkers) + ({getmarkercolor _x == "ColorPink"} count PierMarkers)*0.5;
SaOK_pier = _pier;
publicvariable "SaOK_pier";
SaOK_stor = (({getmarkercolor _x == "ColorGreen"} count StoMarkers) + ({getmarkercolor _x == "ColorPink"} count StoMarkers)*0.5);
publicvariable "SaOK_stor";
_mker = 0;
while {_factories > 0} do {
if (_power >= 0.25 && {_pier >= 0.125}) then {_mker = _mker + 0.5; _power = _power - 0.25;_pier = _pier - 0.125;};
_factories = _factories - 0.5;
FACRES = FACRES + 0.05;
sleep 0.1;
};
publicvariable "FACRES";
_pKer = _pKer + (0.4*_mker*(1 + SaOK_stor*0.1)*SUPF);
//POWS
_fromPows = 0;

{
if (getmarkercolor (_x getvariable "Gmark") == "ColorGreen") then {
if (!isNil{(_x getvariable "PowCells")}) then {
{if ((_x select 1) != "") then {_fromPows = _fromPows + 5;};sleep 0.01;} foreach (_x getvariable "PowCells");
};
};
sleep 0.01;
} foreach GuardPosts;
//
_lisays = (35/DIFLEVEL)*_pKer+_fromPows;
_n = [WEST,_lisays] SPAWN PrestigeUpdate;
[[_lisays, "Time Bonus",WEST],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
sleep 1;
([] CALL NEARESTVILLAGE) setMarkerColor (([] CALL NEARESTVILLAGERELATIONSHIP) CALL SAOKRELTOCOLOR);
sleep 1;
_c = count AIRFIELDLOCATIONS - 1;
for "_i" from 0 to _c do {
private ["_xx"];
_xx = AIRFIELDLOCATIONS select _i;
_mP = getmarkerpos _xx; 
_nG = ([_mP] CALL RETURNGUARDPOST); 
if (_nG distance _mP < 500) then {
_c = getmarkercolor (_nG getvariable "Gmark");
if (getmarkercolor _xx != _c) then {
_xx setmarkercolor _c;
[[_xx,_c],"SAOKMARKCOL",nil,false] spawn BIS_fnc_MP;
};
};
};

};

case 3 : {
};

case 4 : {
{
if (count units _x == 0) then {deleteGroup _x;};
} forEach allGroups - DONTDELGROUPS;
sleep 1;
{if (_x distance [0,0,0] < 400) then {diag_log format ["SaOk Debug - Unit near zero %1, %2, player %3 side %4 FriendlyInf %5 Pgroups %6 CampGroups %7", typeof _x, time, isplayer _x,side _x, _x in FriendlyInf, _x in Pgroups, _x in CampGroups]; _x setpos [10000,10000,0];};} foreach Allunits;
sleep 1;
{if (_x distance [0,0,0] < 400) then {diag_log format ["SaOk Debug - Deadman near zero %1, %2", typeof _x, time]; _x setpos [10000,10000,0];};} foreach alldeadmen; 
sleep 1;
{if (_x distance [0,0,0] < 400) then {diag_log format ["SaOk Debug - Vehicle near zero %1, %2", typeof _x, time]; _x setpos [10000,10000,0];};} foreach vehicles;
sleep 1;
{if (_x distance [0,0,0] < 400) then {diag_log format ["SaOk Debug - Mission object near zero %1, %2", typeof _x, time]; _x setpos [10000,10000,0];};} foreach allMissionObjects "All";
sleep 1;
{if (_x distance [0,0,0] < 400) then {diag_log format ["SaOk Debug - Entity near zero %1, %2", typeof _x, time]; _x setpos [10000,10000,0];};} foreach entities "All";

};

case 5 : {
publicvariable "GuardPosts";{
_l = _x;
if (typeof _l iskindof "Man" && {isPlayer _l} && {!isPlayer (leader _l)}) exitWith {
_g = group _l;
_u = [];
{if (isplayer _x && {group _x == _g}) then {_u = _u + [_x];};} foreach ([] CALL AllPf);
if (count _u > 0) then {_u = _u call RETURNRANDOM; _u addRating 4000;_g selectLeader _u;};
};} foreach ([] CALL AllPf);

_l =([] call RandomP);
{if (typeof _x in ["C_Van_01_fuel_F","C_SUV_01_F","C_Van_01_box_F","C_Van_01_transport_F","C_Hatchback_01_sport_F","C_Hatchback_01_F","C_Offroad_01_F","C_Quadbike_01_F"] && {isNil{_x getvariable "WithAlarm"}}) then {_nul = [_x] SPAWN CarAlarm;};} foreach ((getposATL _l) nearEntities [["Car"],200]);
AllP = ([] CALL AllPf);publicvariable "AllP";
};

case 6 : {
{
    if (isNull _x) then
    {	
        _myGroupX = group _x;
        _x removeAllMPEventHandlers "mpkilled";
        _x removeAllMPEventHandlers "mphit";
        _x removeAllMPEventHandlers "mprespawn";
        _x removeAllEventHandlers "FiredNear";
        _x removeAllEventHandlers "HandleDamage";
        _x removeAllEventHandlers "Killed";
        _x removeAllEventHandlers "Fired";
        _x removeAllEventHandlers "Local";

        deleteVehicle _x;
        deleteGroup _myGroupX;
        _x = nil;
    };
} forEach allMissionObjects "";
};

case 7 : {

	while {true} do {
	waitUntil {sleep 0.1;player == player && {alive player}};
	17 cutRsc ["MyRscTitle","PLAIN"];
	disableSerialization;
	_disp = uiNamespace getVariable "d_MyRscTitle";
	while {alive player && {!isNull _disp} && {!isNil"_disp"}} do {
		_msg = "<t color='#FF9900'>" + format ["<img size='1.2' image='%1'/>","\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\call_ca.paa"]+ "HC Groups|"+"</t>";
		_msg = _msg + (if (count (hcAllGroups leader player) == 0) then {"<t color='#FF0033'>" + format["%1",count (hcAllGroups leader player)] +"</t>"} else {format["%1",count (hcAllGroups leader player)]});
		_msg = _msg + "<t color='#FF9900'>" + "  TIP|"+"</t>";
		_msg = _msg + RANDOMTIP;
		
		if (side player == EAST) then {
		_b = [];
		{if (_x distance startP > 300) then {_b = _b + [_x];};} foreach ([WEST] CALL AllPf);
		if (count _b > 0) then {
		_b = _b call RETURNRANDOM;
		if (isPlayer _b) then {
		_msg = _msg + "<t color='#FF9900'>" + "  Blufor near|"+"</t>";
		_msg = _msg + (_b CALL NEARESTLOCATIONNAME);
		};
		};
		};		
		(_disp displayCtrl 301) ctrlSetStructuredText parseText _msg;		
		sleep 1;
	};
	};
};
case 8 : {

	while {true} do {
	waitUntil {player == player && {alive player}};
	19 cutRsc ["MyRscTitle4","PLAIN"];
	disableSerialization;	_dat = (worldname CALL SAOKMAPDATA); 
	_isWater = (_dat select 6);
	_disp = uiNamespace getVariable "d4_MyRscTitle";	_but = "Pier|</t>";
	if !(_isWater) then {_but = "Passage|</t>";};
	while {alive player && {!isNull _disp} && {!isNil"_disp"}} do {
		if (isNil{player getvariable "OwnRes"} || {typename (player getvariable "OwnRes") != "SCALAR"}) then {player setvariable ["OwnRes",1,true];};
		_msg = "";		if (!visibleMap) then {		_msg = "<t color='#FF9900'>" + format ["<img size='1.2' image='%1'/>","\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\attack_ca.paa"]+"Prestige|"+"</t>";
		_msg = _msg + (format ["%1",([side player] CALL PrestigeS)]) + "<br/>";
		if (vehicle player == player) then {		_msg = _msg + "<t color='#FF9900'>"+ format ["<img size='1.2' image='%1'/>","\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\defend_ca.paa"] + "ARS/Armed Support|"+"</t>";
		_msg = _msg + (format ["%1",(player getvariable "OwnRes")]);
		if (side player == WEST) then {
		_msg = _msg + "<br/>"+ (format ["<t color='#FFCC99'><img size='1.2' image='%1'/>",(getText (configfile >> "CfgMarkers" >> "loc_Stack" >> "icon"))])+"Factory|</t>"+("FAC" CALL SAOKRCOL) +format ["%1",SaOK_factories]+ "</t>";
		sleep 0.1;
		_msg = _msg + "<br/>"+ (format ["<t color='#FFCC99'><img size='1.2' image='%1'/>",(getText (configfile >> "CfgMarkers" >> "loc_Power" >> "icon"))])+"Power|</t>"+("POW" CALL SAOKRCOL) +format ["%1",SaOK_power]+ "</t>";
		sleep 0.1;
		_msg = _msg + "<br/>"+ (format ["<t color='#FFCC99'><img size='1.2' image='%1'/>",(getText (configfile >> "CfgMarkers" >> "loc_Quay" >> "icon"))])+_but+("PIE" CALL SAOKRCOL) +format ["%1",SaOK_pier]+ "</t>";
		sleep 0.1;
		_msg = _msg + "<br/>"+ (format ["<t color='#FFCC99'><img size='1.2' image='%1'/>",(getText (configfile >> "CfgMarkers" >> "n_service" >> "icon"))])+"Storage|</t>"+("STO" CALL SAOKRCOL) +format ["%1",SaOK_stor]+ "</t>";
		};
		};
		};
		(_disp displayCtrl 304) ctrlSetStructuredText parseText _msg;		
		sleep 1;
	};
	};
};
case 9 : {
	private ["_nearest","_disp","_f","_nameA","_msg"];
	while {{leader _x != player && {side _x != EAST} && {behaviour _x != "COMBAT"} && {[_x,player] CALL FUNKTIO_LOS}} count ((getposATL player) nearEntities [["Man"],7]) > 0 || {{leader _x != player && {!isNil{(_x getvariable "SaOkSurrendered")}} && {[_x,player] CALL FUNKTIO_LOS}} count ((getposATL player) nearEntities [["Man"],7]) > 0}} do {
	waitUntil {player == player && {alive player}};
	29 cutRsc ["MyRscTitle6","PLAIN"];
	disableSerialization;
	_disp = uiNamespace getVariable "d6_MyRscTitle";
	if (side player == EAST) exitWith {};
	while {alive player && {!isNull _disp} && {!isNil"_disp"} && {({leader _x != player && {behaviour _x != "COMBAT"} && {[_x,player] CALL FUNKTIO_LOS}} count ((getposATL player) nearEntities [["Civilian","SoldierWB","SoldierGB"],7]) > 0  || {{leader _x != player && {!isNil{(_x getvariable "SaOkSurrendered")}} && {[_x,player] CALL FUNKTIO_LOS}} count ((getposATL player) nearEntities [["SoldierEB"],7]) > 0})}} do {		if (!visibleMap) then {
		_msg = format ["<img size='1.2' image='%1'/>","\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\instructor_ca.paa"]+ " Talk (SHIFT+Y)";
		(_disp displayCtrl 306) ctrlSetStructuredText parseText _msg;		};
	sleep 1;
	if (side player == EAST) exitWith {};
	};
	};
	29 cutText ["","PLAIN"];
};
case 10 : {

	private ["_nearest","_disp","_f","_nameA","_msg"];
	_nearest = [] CALL NEARESTPLACE;
	if (vehicle player distance (getmarkerpos _nearest) < ((getmarkersize _nearest select 0)+100)) then {
	while {_nearest == [] CALL NEARESTPLACE && {vehicle player distance (getmarkerpos _nearest) < ((getmarkersize _nearest select 0)+100)}} do {
	waitUntil {player == player && alive player};
	18 cutRsc ["MyRscTitle3","PLAIN"];
	disableSerialization;
	_disp = uiNamespace getVariable "d3_MyRscTitle";
	_Lna = player CALL NEARESTLOCATIONNAME;	_s = "ColorRed";
	if (side player == EAST) then {_s = "ColorBlue";};
	while {alive player && {!isNull _disp} && {!isNil"_disp"} && {_nearest == [] CALL NEARESTPLACE} && {vehicle player distance (getmarkerpos _nearest) < ((getmarkersize _nearest select 0)+100)}} do {
		_msg = "";
		if (vehicle player distance (getmarkerpos ([] CALL NEARESTCAMP)) < ((getmarkersize ([] CALL NEARESTCAMP) select 0)+100)) then {
		_msg = "<t color='#FF9900'>" +format ["<img size='1.2' image='%1'/>",(getText (configfile >> "CfgMarkers" >> "loc_Bunker" >> "icon"))]+ " Camp Status"+"</t>" + "<br/>";
		_msg = _msg + "<t color='#FF9900'>" +"Defenses|"+"</t>"+"<t color='#FFCC99'>" +(if (getmarkercolor _nearest == _s) then {"Unknown"} else {if ((getposATL ([(getmarkerpos ([] CALL NEARESTCAMP))] CALL RETURNGUARDPOST)) distance (getmarkerpos ([] CALL NEARESTCAMP)) > (((getmarkersize ([] CALL NEARESTCAMP)) select 0)+100)) then {"Normal"} else {"Strong"};})+"</t>" + "<br/>";
		_msg = _msg + (if (getmarkercolor _nearest != _s) then {"Shop (SHIFT+1)"+ "<br/>" + "ARSENAL (SHIFT+1)"} else {""})+ "<br/>";
		}; 
		if (vehicle player distance (getmarkerpos ([] CALL NEARESTVILLAGE)) < (getmarkersize ([] CALL NEARESTVILLAGE) select 0)) then {
		_msg = _msg + "<br/>"+ "<t color='#FF9900'>" + format ["<img size='1.2' image='%1'/> ",(getText (configfile >> "CfgMarkers" >> "loc_Tourism" >> "icon"))]+ _Lna +"</t>" + "<br/>";
		_msg = _msg + "<t color='#FF9900'>" + "Relationship|" +"</t>"+ "<t color='#FFCC99'>" + ([] CALL NEARESTVILLAGERELATIONSHIP)+"</t>" + "<br/>";
		_msg = _msg + "<t color='#FF9900'>" + "Specialty|" +"</t>"+ "<t color='#FFCC99'>" + (if (((_nearest + "B") CALL SAOKVILRET) == "") then {"None"} else {((_nearest + "B") CALL SAOKVILRET)})+"</t>"+ "<br/>";
		_msg = _msg + "SHIFT+1"+ "<br/>";
		}; 
		
		//FacMarkers
		if (vehicle player distance (position ([] CALL NEARESTFACTORY)) < 100) then {
		_fP = (position ([] CALL NEARESTFACTORY));
		_fM = FacMarkers select 0;
		{if (_fP distance getmarkerpos _fM > _fP distance getmarkerpos _x) then {_fM = _x;};} foreach FacMarkers;
		if (getmarkercolor _fM != "_s") then {
		//if ([] CALL NEARESTVILLAGERELATIONSHIP != "Friendly") then {_fM setmarkercolor "ColorYellow";} else {_fM setmarkercolor "ColorGreen";};
		_msg = _msg + "<br/>"+ "<t color='#FF9900'>"+format ["<img size='1.2' image='%1'/>",(getText (configfile >> "CfgMarkers" >> "loc_Stack" >> "icon"))]+" Factory Status" +"</t>" + "<br/>";
		_msg = _msg + "<t color='#FF9900'>" + "Condition|" +"</t>" + "<t color='#FFCC99'>" +(if ([] CALL NEARESTVILLAGERELATIONSHIP != "Friendly") then {"Not operative - relationship too poor"} else {"Operative"})+"</t>" + "<br/>";
		_msg = _msg + "<t color='#FF9900'>" +"Defenses|"+"</t>"+"<t color='#FFCC99'>" +(if ((getposATL ([(position ([] CALL NEARESTFACTORY))] CALL RETURNGUARDPOST)) distance (position ([] CALL NEARESTFACTORY)) > 250) then {"None"} else {"Guarded"})+"</t>" + "<br/>";
		};
		}; 
		
		if (vehicle player distance (getmarkerpos ([] CALL NEARESTAIRFIELD)) < 200) then {
		_msg = _msg + "<br/>"+ "<t color='#FF9900'>" +format ["<img size='1.2' image='%1'/>",(getText (configfile >> "CfgMarkers" >> "respawn_air" >> "icon"))]+" Airfield Status" +"</t>" + "<br/>";
		_msg = _msg + "<t color='#FF9900'>" + "Condition|" +"</t>" + "<t color='#FFCC99'>" +(if ((getmarkerpos ([] CALL NEARESTAIRFIELD)) distance (getmarkerpos (["_s"] CALL NEARESTCAMP)) < 800) then {"Not operative (Hostile Camp Nearby)"} else {"Operative"}) +"</t>"+ "<br/>";
		_msg = _msg + "<t color='#FF9900'>" +"Defenses|"+"</t>"+"<t color='#FFCC99'>" +(if ((getposATL ([(getmarkerpos ([] CALL NEARESTAIRFIELD))] CALL RETURNGUARDPOST)) distance (getmarkerpos ([] CALL NEARESTAIRFIELD)) > 450) then {"None"} else {"Guarded"})+"</t>" + "<br/>";
		_msg = _msg + (if ((getmarkerpos ([] CALL NEARESTAIRFIELD)) distance (getmarkerpos (["_s"] CALL NEARESTCAMP)) < 800) then {""} else {"SHIFT+1"}) + "<br/>";
		};
				
		(_disp displayCtrl 303) ctrlSetStructuredText parseText _msg;		
		sleep 1;
	};
	};
	};
	18 cutText ["","PLAIN"];
};

case 11 : {
	_AAdistance = 4;
	while {true} do {
	if (isDedicated || {side player == EAST}) exitWith {};
	waitUntil {sleep 0.1;player == player && {alive player}};
	39 cutRsc ["MyRscTitle7","PLAIN"];
	disableSerialization;
	_disp = uiNamespace getVariable "d7_MyRscTitle";
	while {alive player && {!isNull _disp} && {!isNil"_disp"}} do {
	_msg = "";
	if (isNil"AAclose" || {"RadarS" in ([] CALL SAOKRETURNPROG)} || {"Radar" in ([] CALL SAOKRETURNPROG)}) then {
	_v = + vehicles;
	_c = count _v - 1;
	_vP = vehicle player;
	for "_i" from 0 to _c do {
	private ["_xx"];
	_xx = _v select _i;
	_n = 1;
	if !(typeof _xx iskindof "ParachuteBase") then {_n = 0;};
	if (alive _xx && {count crew _xx > _n} && {side ((crew _xx) call RETURNRANDOM) == EAST} && {!(typeof _xx iskindof "StaticWeapon")} && {round (speed _xx) > 0} && {_vP distance _xx < 1200}) then {
	_d = _vP distance _xx;
	_jaa = 0.01;
	_dN = "NW";
	_dir = round ([player, _xx] call BIS_fnc_dirTo);
	if (_dir < 0) then {_dir = _dir + 360;};
	if (_dir > 360) then {_dir = _dir - 360;};
	if (_dir < 22.5 || {_dir > 337.5}) then {_dN = "N";};
	if (_dir >= 22.5 && {_dir < 67.5}) then {_dN = "NE";};
	if (_dir >= 67.5 && {_dir < 112.5}) then {_dN = "E";};
	if (_dir >= 112.5 && {_dir < 157.5}) then {_dN = "SE";};
	if (_dir >= 157.5 && {_dir < 202.5}) then {_dN = "S";};
	if (_dir >= 202.5 && {_dir < 247.5}) then {_dN = "SW";};
	if (_dir >= 247.5 && {_dir < 292.5}) then {_dN = "W";};
	_col = "<t color='#A0A0A0'>";
	_val = 2;
	_s = "km";
	if (_d >= 1000) then {_col = "<t color='#F8F8F8'>"; _val = (round ((_vP distance _xx) * _jaa)) * 0.1;};
	if (_d < 1000) then {_s = "m";_jaa = 1;_col = "<t color='#FFFF33'>";_val = round ((_vP distance _xx) * _jaa);};
	if (_d < 750) then {_s = "m";_jaa = 1;_col = "<t color='#FFCC00'>";_val = round ((_vP distance _xx) * _jaa);_xx forcespeed -1;};
	if (_d < 250) then {_s = "m";_jaa = 1;_col = "<t color='#FF3300'>";_val = round ((_vP distance _xx) * _jaa);if (DIFLEVEL < 1 && {typeof _xx isKindOf "LandVehicle"}) then {_xx forcespeed 3;};};
	//_msg = _msg + _col + _dN + " "+ (getText (configfile >> "CfgVehicles" >> typeof _xx >> "displayName")) + (format [" %1%3, %2km/h",_val, round (speed _xx),_s])+"</t>"+" ";
	_msg = _msg + _col + _dN + " "+ format ["<img size='1.2' image='%1'/>",(getText (configfile >> "CfgVehicles" >> typeof _xx >> "picture"))] + (format [" %1%3, %2km/h",_val, round (speed _xx),_s])+"</t>"+" "; 
	};
	sleep 0.1;
	};
	} else {_msg = "               <t color='#FF3300'>" + format [" <img size='1.2' image='%1'/>",(getText (configfile >> "CfgVehicles" >> "B_UAV_02_CAS_F" >> "picture"))]+"UAV intel unavailable, CSAT AA"+format [" <img size='1.2' image='%1'/>",(getText (configfile >> "CfgMarkers" >> "o_art" >> "icon"))]+" inside "+(format ["%1",_AAdistance])+"km radius</t>"};
	(_disp displayCtrl 307) ctrlSetStructuredText parseText _msg;
	sleep 1;
	};
	};
};
};

/*

_text = "";
{if (_x distance [0,0,0] < 400) then {_text = format ["SaOk Debug - Unit near zero %1, %2, player %3 side %4 FriendlyInf %5 Pgroups %6 CampGroups %7", typeof _x, time, isplayer _x,side _x, _x in FriendlyInf, _x in Pgroups, _x in CampGroups]; _x setpos [10000,10000,0];};} foreach Allunits;

{if (_x distance [0,0,0] < 400) then {_text = format ["SaOk Debug - Deadman near zero %1, %2", typeof _x, time]; _x setpos [10000,10000,0];};} foreach alldeadmen; 

{if (_x distance [0,0,0] < 400) then {_text = format ["SaOk Debug - Vehicle near zero %1, %2", typeof _x, time]; _x setpos [10000,10000,0];};} foreach vehicles;

{if (_x distance [0,0,0] < 400) then {_text = format ["SaOk Debug - Mission object near zero %1, %2", typeof _x, time]; _x setpos [10000,10000,0];};} foreach allMissionObjects "All";

{if (_x distance [0,0,0] < 400) then {_text = format ["SaOk Debug - Entity near zero %1, %2", typeof _x, time]; _x setpos [10000,10000,0];};} foreach entities "All";


[_text,WEST] SPAWN HINTSAOK;


*/
