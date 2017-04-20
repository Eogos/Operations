SAOKATLTOASL = {
private ["_ar"];
_ar = + _this;
if (count _ar == 3) then {_ar = ATLtoASL _ar;};
_ar 
};

SAOKSETTIMUL = {
setTimeMultiplier _this;
};

SAOKUNSTUCKUN = {
private ["_start"];
{
if (surfaceiswater getposATL _x) then {
_start = [_x,30,0,"(1 - sea)"] CALL SAOKSEEKPOS;
if (!surfaceiswater _start) then {_x setpos _start;} else {_x setpos [(getposATL _x select 0)+10-(random 20),(getposATL _x select 1)+10-(random 20),0];};
} else {
_x setpos [(getposATL _x select 0)+10-(random 20),(getposATL _x select 1)+10-(random 20),0];
};
_x switchmove "";
_x enablesimulation true;
sleep 0.01;
} foreach (groupSelectedUnits player);
};

SAOKBUILDINGPOS = {
private ["_tO","_waypoints","_c","_array"];
_tO = typeof _this;
_waypoints = [];
if ({_tO == (_x select 0)} count GOODBUILDING == 0) then {
_c = 0;
_array = _this buildingPos _c;
while {!(_array isEqualTo [0,0,0]) && {_c < 20}} do {	
_waypoints pushBack _c;
_c = _c + 1;
_array = _this buildingPos _c;
};
if (count _waypoints > 0) then {GOODBUILDING pushback [_tO,_waypoints];};
} else {
{if (_tO == (_x select 0)) exitWith {_waypoints = _x select 1;};} foreach GOODBUILDING;
};
_waypoints
};

SAOKISBUILDING = {
private ["_bol"];
_bol = false;
if ({typeof _this == (_x select 0)} count GOODBUILDING > 0 || {count (_this call SAOKBUILDINGPOS) > 0}) then {_bol = true;};
_bol
};

SAOKATLTOASL = {
private ["_ar"];
_ar = + _this;
if (count _ar == 3) then {_ar = ATLtoASL _ar;};
_ar 
};

CivNx = [];
SAOKVILAD = {
private ["_c","_p","_xx","_yy","_a","_b","_foreachIndex","_xd"];
_c = count AmbientCivN - 1;
for "_i" from 0 to _c do {
private ["_pi"];
_pi = AmbientCivN select _i;
_p = getmarkerpos _pi;
_p = [floor ((_p select 0)*0.001), floor ((_p select 1)*0.001)];
_xx = 0;
{if (_p select 0 < _x) exitWith {_xx = _x;};} foreach [7,14,21,28,35,42];
_yy = 0;
{if (_p select 1 < _x) exitWith {_yy = _x;};} foreach [7,14,21,28,35,42];
_a = [_xx,_yy];
_b = 0;
{_xd = _x select 0; if (_a select 0 == _xd select 0 && {_a select 1 == _xd select 1}) exitWith {CivNx pushBack ((CivNx select _foreachIndex)+[_pi]);_b = 1;};} foreach CivNx;
if (_b == 0) then {CivNx pushBack [_a,_pi];};
};
};

SAOKVILAR = {
private ["_ar","_r","_d","_pt"];
_ar = [];
_pt = [_this,2] call BIS_fnc_removeIndex;
_pt = [((_pt select 0)*0.001),((_pt select 1)*0.001)];
{
if (_pt distance (_x select 0) < 20) then {
_r = + _x;
_r = [_r,0] call BIS_fnc_removeIndex;
_ar = _ar +_r;
};
} foreach CivNx;
_d = 20;
while {count _ar == 0 && {count CivNx > 0} && {_d < 45}} do {
{
if (_pt distance (_x select 0) < _d) then {
_r = + _x;
_r = [_r,0] call BIS_fnc_removeIndex;
_ar = _ar + _r;
};
} foreach CivNx;
_d = _d + 20;
};
_ar 
};

SAOKADDPATROL = {

private ["_random","_unitrate","_classes","_cl","_group"];
_unitrate = if (count _this > 1) then {_this select 1} else {[4,5]};
_random = round(random (_unitrate select 1));
while {_random <  (_unitrate select 0)} do {_random = round(random (_unitrate select 1));};
_classes = [];
_cl = [ENEMYC1,ENEMYC2,ENEMYC3] call RETURNRANDOM;
while {_random > 0} do {_classes set [count _classes,_cl call RETURNRANDOM];_random = _random - 1;};
_group = [_this select 0, EAST, _classes,[],[],[0.4,0.8]] call SpawnGroupCustom;
Pgroups pushBack _group;
[_group, _this select 0, 100] call bis_fnc_taskPatrol;
};

SAOKONRUNWAY = {
private ["_NRun","_funcRun","_bol","_runW"];
_bol = false;
_NRun = {
private ["_run"];
_run = "";
{if ((_this select 0) distance (getmarkerpos _x) < (_this select 1)) exitWith {_run = _x;};} foreach AIRFIELDLOCATIONS;
//["AirC","AirC_1","AirC_2","AirC_3","AirC_4","AirC_5"]
switch _run do {
case "AirC": {_run = runway0;};
case "AirC_1": {_run = runway1;};
case "AirC_2": {_run = runway2;};
case "AirC_3": {_run = runway3;};
case "AirC_4": {_run = runway4;};
case "AirC_5": {_run = runway5;};
case "": {_run = runwayNul;};
};
_run
};
_funcRun = {
private ["_bol"];
_bol = false;
if (([_this select 0, _this select 1] call BIS_fnc_inTrigger)) then {_bol = true;};
_bol
};
_runW = [_this, 2000] CALL _NRun;
if (([_runW, _this] call _funcRun)) then {_bol = true;};
_bol
};

if (isNil"SAOKVILD") then {SAOKVILD = [];};
if (isNil"SAOKVILL") then {SAOKVILL = [];};
SAOKVILSET = {
private ["_forEachIndex"];
if (typename (_this select 0) != "STRING" || {(_this select 0) in ["","A","B"]}) exitWith {};
{if (_x select 0 == _this select 0) exitWith {SAOKVILD = [SAOKVILD,_forEachIndex] call BIS_fnc_removeIndex;};} foreach SAOKVILD;
SAOKVILD pushBack _this;
publicvariable "SAOKVILD";
};
SAOKVILRET = {
private ["_dat","_forEachIndex"];
_dat = "";
{if (count SAOKVILD > _x && {(SAOKVILD select _x) select 0 == _this}) exitWith {_dat = (SAOKVILD select _x) select 1;};} foreach SAOKVILL;
if (_dat == "") then {
{if (_x select 0 == _this) exitWith {
_dat = _x select 1;
SAOKVILL pushBack _forEachIndex;
if (count SAOKVILL > 10) then {SAOKVILL = [SAOKVILL,0] call BIS_fnc_removeIndex;};
};} foreach SAOKVILD;
};
_dat
};

SAOKVILCON = {
private ["_bol","_forEachIndex"];
_bol = false;
{if (count SAOKVILD > _x && {(SAOKVILD select _x) select 0 == _this}) exitWith {_bol = true;};} foreach SAOKVILL;
if (!_bol) then {
{
if (_x select 0 == _this) exitWith {
_bol = true;
SAOKVILL pushBack _forEachIndex;
if (count SAOKVILL > 10) then {SAOKVILL = [SAOKVILL,0] call BIS_fnc_removeIndex;};
};
} foreach SAOKVILD;
};
_bol
};

SAOKVILDATREM = {
private ["_forEachIndex"];
{if (_x select 0 == _this) exitWith {SAOKVILD = [SAOKVILD,_forEachIndex] call BIS_fnc_removeIndex;publicvariable "SAOKVILD";};} foreach SAOKVILD;
};

SAOKIMPREL = {
private ["_str"];
_str = _this;
if !(_str CALL SAOKVILCON) then {
[_str,"Friendly"] SPAWN SAOKVILSET;
} else {
if (_str CALL SAOKVILRET == "Neutral") then {
[_str,"Friendly"] SPAWN SAOKVILSET;
};
if (_str CALL SAOKVILRET == "Angry") then {
[_str,"Neutral"] SPAWN SAOKVILSET;
};
if (_str CALL SAOKVILRET == "Hostile") then {
[_str,"Angry"] SPAWN SAOKVILSET;
};
};
};


SAOKADDPROG = {
private ["_cur"];
_cur = if (!isNil{SaOkmissionnamespace getvariable "Progress"}) then {SaOkmissionnamespace getvariable "Progress"} else {[]};
if !(_this in _cur) then {SaOkmissionnamespace setvariable ["Progress",_cur + [_this],true];};
};

if (isNil"ZONEDATA") then {ZONEDATA = [];};

SAOKCRTASK = {
private ["_a"];
_a = + _this;
if (!isNil"SAOKRESUMEINPROG") then {_a pushBack false;_a pushBack false;};
_a CALL BIS_fnc_taskCreate;
};

SAOKCOTASK = {
private ["_a"];
_a = + _this;
if (!isNil"SAOKRESUMEINPROG") then {_a pushBack false;_a pushBack false;};
_a CALL BIS_fnc_taskSetState;
};

SAOKZONED = {
private ["_forEachIndex"];
_n = 0;
{if !((_x select 0) in allmapmarkers) exitWith {ZONEDATA = [ZONEDATA,_forEachIndex] call BIS_fnc_removeIndex;_n = 1;};} foreach ZONEDATA; 
if (typename _this == "ARRAY") exitWith {
{if (_this select 0 == _x select 0) exitWith {ZONEDATA = [ZONEDATA,_forEachIndex] call BIS_fnc_removeIndex;};} foreach ZONEDATA; 
ZONEDATA pushBack _this;
publicVariable "ZONEDATA";
};
if (typename _this == "STRING") exitWith {
{if (_this == _x select 0) exitWith {ZONEDATA = [ZONEDATA,_forEachIndex] call BIS_fnc_removeIndex;_n = 1;};} foreach ZONEDATA; 
if (_n == 1) then {publicVariable "ZONEDATA";};
};
if (_n == 1) then {publicVariable "ZONEDATA";};
};

SAOKZONEDR = {
private ["_ar"];
_ar = [];
{if (_this == _x select 0) exitWith {_ar = _x select 1;};} foreach ZONEDATA; 
_ar
};

if (isNil"ZONEMG") then {ZONEMG = [];};
SAOKZONEG = {
private ["_forEachIndex"];
if (random 1 < 0.3) then {_n = 0;{if !((_x select 0) in allmapmarkers) exitWith {ZONEDATA = [ZONEDATA,_forEachIndex] call BIS_fnc_removeIndex;_n = 1;};} foreach ZONEDATA;if (_n == 1) then {publicVariable "ZONEDATA";};};
{if (!((_x select 0) in allmapmarkers) || {isNull (_x select 1)} ) exitWith {ZONEMG = [ZONEMG,_forEachIndex] call BIS_fnc_removeIndex;};} foreach ZONEMG; 
{if !((_x select 0) in allmapmarkers) exitWith {ZONEMS = [ZONEMS,_forEachIndex] call BIS_fnc_removeIndex;publicVariable "ZONEMS";};} foreach ZONEMS; 
if (typename _this == "ARRAY") exitWith {
{if (_this select 0 == _x select 0) exitWith {ZONEMG = [ZONEMG,_forEachIndex] call BIS_fnc_removeIndex;};} foreach ZONEMG; 
ZONEMG pushBack _this;
};
if (typename _this == "STRING") exitWith {
{if (_this == _x select 0) exitWith {ZONEMG = [ZONEMG,_forEachIndex] call BIS_fnc_removeIndex;};} foreach ZONEMG; 
};
};

if (isNil"ZONEMS") then {ZONEMS = [];};
SAOKZONEM = {
private ["_forEachIndex","_w","_c"];
if (random 1 < 0.3) then {_n = 0;{if !((_x select 0) in allmapmarkers) exitWith {ZONEDATA = [ZONEDATA,_forEachIndex] call BIS_fnc_removeIndex;_n = 1;};} foreach ZONEDATA;if (_n == 1) then {publicVariable "ZONEDATA";};};
{if (!((_x select 0) in allmapmarkers) || {isNull (_x select 1)}) exitWith {ZONEMG = [ZONEMG,_forEachIndex] call BIS_fnc_removeIndex;};} foreach ZONEMG; 
{if !((_x select 0) in allmapmarkers) exitWith {ZONEMS = [ZONEMS,_forEachIndex] call BIS_fnc_removeIndex;publicVariable "ZONEMS";};} foreach ZONEMS; 
//ADD W _n = ["ZoneName",[0,0,0]] CALL SAOKZONEM;
if (typename _this == "ARRAY" && {typename (_this select 1) == "ARRAY"}) exitWith {
if ({_this select 0 == _x select 0} count ZONEMS > 0) then {
{if (_this select 0 == _x select 0) exitWith {ZONEMS set [_foreachindex, [_this select 0, ((ZONEMS select _foreachindex) select 1)+[(_this select 1)]]];publicVariable "ZONEMS";};} foreach ZONEMS;
} else {
ZONEMS pushBack [_this select 0, [_this select 1]];
publicVariable "ZONEMS";
};
};
//REMOVE WHOLE DATA _n = "ZoneName" CALL SAOKZONEM;
if (typename _this == "STRING") exitWith {
{if (_this == _x select 0) exitWith {ZONEMS = [ZONEMS,_forEachIndex] call BIS_fnc_removeIndex;publicVariable "ZONEMS";};} foreach ZONEMS;
};
//REMOVE LAST W _n = ["ZoneName",""] CALL SAOKZONEM;
if (typename _this == "ARRAY" && {typename (_this select 1) == "STRING"}) exitWith {
{
if (_this select 0 == _x select 0) exitWith {
_w = _x select 1;
_c = count _w - 1;
if (_c <= 0) exitWith {ZONEMS = [ZONEMS,_forEachIndex] call BIS_fnc_removeIndex;};
_w = [_w,0] call BIS_fnc_removeIndex;
ZONEMS set [_foreachindex, [_this select 0,_w]];
publicVariable "ZONEMS";
};
} foreach ZONEMS;
};
};
//RETURN WAYPOINTS _n = "ZoneName" CALL SAOKZONEMW;
SAOKZONEMW = {
private ["_w"];
_w = [];
{if (_this == _x select 0) exitWith {_w = _x select 1};} foreach ZONEMS;
_w
};

SAOKMILCENLIST = {
private ["_added"];
lbClear 1500;
_added = [];
switch _this do {
case "Other": {
lbAdd [1500, "Water Barrel"];
lbAdd [1500, "Mine/Construction-Truck"];
if (isNil"IFENABLED" && {side player != EAST}) then {
lbAdd [1500, "Hunter"];
lbAdd [1500, "Strider"];
lbAdd [1500, "Offroad FIA"];
};
};
case "Boats": {
lbAdd [1500, "Empty Rubberboat"];
if (isNil"IFENABLED") then {
lbAdd [1500, "Empty Motorboat"];
if ("USHelp" in (SaOkmissionnamespace getvariable "Progress") || {"GreenHelp" in (SaOkmissionnamespace getvariable "Progress")}) then {
lbAdd [1500, "Empty Assault Boat"];
lbAdd [1500, "Empty Speedboat MG"];
lbAdd [1500, "Empty SDV"];
};
};
};
case "Supplies": {
lbAdd [1500, "Empty Repair Truck"];
if (vehicle player distance (getmarkerpos ([] CALL NEARESTAIRFIELD)) < 200 && {getmarkercolor ([] CALL NEARESTAIRFIELD) == "ColorGreen"}) then {
lbAdd [1500, "Empty Fuel Truck"];
lbAdd [1500, "Empty Rearm Truck"];
lbAdd [1500, "Empty Medical Truck"];
};
};
//crew = "B_UAV_AI";
case "CSAT Air Vehicles": {
{if (!(_x in _added) && {!(getText (configfile >> "CfgVehicles" >> _x >> "crew") in ["B_UAV_AI","O_UAV_AI","I_UAV_AI"])}) then {lbAdd [1500, getText (configfile >> "CfgVehicles" >> _x >> "displayName")];_added set [count _added, _x];};} foreach (AIRARMCHOP select 1);
{if (!(_x in _added) && {!(getText (configfile >> "CfgVehicles" >> _x >> "crew") in ["B_UAV_AI","O_UAV_AI","I_UAV_AI"])}) then {lbAdd [1500, getText (configfile >> "CfgVehicles" >> _x >> "displayName")];_added set [count _added, _x];};} foreach (AIRFIGTHER select 1);
};
case "Soviet Air Vehicles": {
{if (!(_x in _added) && {!(getText (configfile >> "CfgVehicles" >> _x >> "crew") in ["B_UAV_AI","O_UAV_AI","I_UAV_AI"])}) then {lbAdd [1500, getText (configfile >> "CfgVehicles" >> _x >> "displayName")];_added set [count _added, _x];};} foreach (AIRARMCHOP select 1);
{if (!(_x in _added) && {!(getText (configfile >> "CfgVehicles" >> _x >> "crew") in ["B_UAV_AI","O_UAV_AI","I_UAV_AI"])}) then {lbAdd [1500, getText (configfile >> "CfgVehicles" >> _x >> "displayName")];_added set [count _added, _x];};} foreach (AIRFIGTHER select 1);
};
case "CSAT Land Vehicles": {
{if (!(_x in _added) && {!(getText (configfile >> "CfgVehicles" >> _x >> "crew") in ["B_UAV_AI","O_UAV_AI","I_UAV_AI"])}) then {lbAdd [1500, getText (configfile >> "CfgVehicles" >> _x >> "displayName")];_added set [count _added, _x];};} foreach (ARMEDVEHICLES select 1);
{if (!(_x in _added) && {!(getText (configfile >> "CfgVehicles" >> _x >> "crew") in ["B_UAV_AI","O_UAV_AI","I_UAV_AI"])}) then {lbAdd [1500, getText (configfile >> "CfgVehicles" >> _x >> "displayName")];_added set [count _added, _x];};} foreach (ARMEDTANKS select 1);
};
case "Soviet Land Vehicles": {
{if (!(_x in _added) && {!(getText (configfile >> "CfgVehicles" >> _x >> "crew") in ["B_UAV_AI","O_UAV_AI","I_UAV_AI"])}) then {lbAdd [1500, getText (configfile >> "CfgVehicles" >> _x >> "displayName")];_added set [count _added, _x];};} foreach (ARMEDVEHICLES select 1);
{if (!(_x in _added) && {!(getText (configfile >> "CfgVehicles" >> _x >> "crew") in ["B_UAV_AI","O_UAV_AI","I_UAV_AI"])}) then {lbAdd [1500, getText (configfile >> "CfgVehicles" >> _x >> "displayName")];_added set [count _added, _x];};} foreach (ARMEDTANKS select 1);
};
case "NATO Air Vehicles": {
{if (!(_x in _added) && {!(getText (configfile >> "CfgVehicles" >> _x >> "crew") in ["B_UAV_AI","O_UAV_AI","I_UAV_AI"])}) then {lbAdd [1500, getText (configfile >> "CfgVehicles" >> _x >> "displayName")];_added set [count _added, _x];};} foreach (AIRARMCHOP select 0);
{if (!(_x in _added) && {!(getText (configfile >> "CfgVehicles" >> _x >> "crew") in ["B_UAV_AI","O_UAV_AI","I_UAV_AI"])}) then {lbAdd [1500, getText (configfile >> "CfgVehicles" >> _x >> "displayName")];_added set [count _added, _x];};} foreach (AIRFIGTHER select 0);
};
case "US Air Vehicles": {
{if (!(_x in _added) && {!(getText (configfile >> "CfgVehicles" >> _x >> "crew") in ["B_UAV_AI","O_UAV_AI","I_UAV_AI"])}) then {lbAdd [1500, getText (configfile >> "CfgVehicles" >> _x >> "displayName")];_added set [count _added, _x];};} foreach (AIRARMCHOP select 0);
{if (!(_x in _added) && {!(getText (configfile >> "CfgVehicles" >> _x >> "crew") in ["B_UAV_AI","O_UAV_AI","I_UAV_AI"])}) then {lbAdd [1500, getText (configfile >> "CfgVehicles" >> _x >> "displayName")];_added set [count _added, _x];};} foreach (AIRFIGTHER select 0);
};
case "GREEN Air Vehicles": {
"CH-49 comes with ability to construct guardposts and minefields" SPAWN HINTSAOK;
{if (!(_x in _added) && {!(getText (configfile >> "CfgVehicles" >> _x >> "crew") in ["B_UAV_AI","O_UAV_AI","I_UAV_AI"])}) then {lbAdd [1500, getText (configfile >> "CfgVehicles" >> _x >> "displayName")];_added set [count _added, _x];};} foreach (AIRARMCHOP select 2);
{if (!(_x in _added) && {!(getText (configfile >> "CfgVehicles" >> _x >> "crew") in ["B_UAV_AI","O_UAV_AI","I_UAV_AI"])}) then {lbAdd [1500, getText (configfile >> "CfgVehicles" >> _x >> "displayName")];_added set [count _added, _x];};} foreach (AIRFIGTHER select 2);
};
case "German Air Vehicles": {
//"CH-49 comes with ability to construct guardposts and minefields" SPAWN HINTSAOK;
{if (!(_x in _added) && {!(getText (configfile >> "CfgVehicles" >> _x >> "crew") in ["B_UAV_AI","O_UAV_AI","I_UAV_AI"])}) then {lbAdd [1500, getText (configfile >> "CfgVehicles" >> _x >> "displayName")];_added set [count _added, _x];};} foreach (AIRARMCHOP select 2);
{if (!(_x in _added) && {!(getText (configfile >> "CfgVehicles" >> _x >> "crew") in ["B_UAV_AI","O_UAV_AI","I_UAV_AI"])}) then {lbAdd [1500, getText (configfile >> "CfgVehicles" >> _x >> "displayName")];_added set [count _added, _x];};} foreach (AIRFIGTHER select 2);
};
case "GUER Land Vehicles": {
{if (!(_x in _added) && {!(getText (configfile >> "CfgVehicles" >> _x >> "crew") in ["B_UAV_AI","O_UAV_AI","I_UAV_AI"])}) then {lbAdd [1500, getText (configfile >> "CfgVehicles" >> _x >> "displayName")];_added set [count _added, _x];};} foreach (ARMEDVEHICLES select 3);
};
case "Polish Land Vehicles": {
{if (!(_x in _added) && {!(getText (configfile >> "CfgVehicles" >> _x >> "crew") in ["B_UAV_AI","O_UAV_AI","I_UAV_AI"])}) then {lbAdd [1500, getText (configfile >> "CfgVehicles" >> _x >> "displayName")];_added set [count _added, _x];};} foreach (ARMEDVEHICLES select 3);
};
case "GREEN Land Vehicles": {
{if (!(_x in _added) && {!(getText (configfile >> "CfgVehicles" >> _x >> "crew") in ["B_UAV_AI","O_UAV_AI","I_UAV_AI"])}) then {lbAdd [1500, getText (configfile >> "CfgVehicles" >> _x >> "displayName")];_added set [count _added, _x];};} foreach (ARMEDVEHICLES select 2);
{if (!(_x in _added) && {!(getText (configfile >> "CfgVehicles" >> _x >> "crew") in ["B_UAV_AI","O_UAV_AI","I_UAV_AI"])}) then {lbAdd [1500, getText (configfile >> "CfgVehicles" >> _x >> "displayName")];_added set [count _added, _x];};} foreach (ARMEDTANKS select 2);
};
case "German Land Vehicles": {
{if (!(_x in _added) && {!(getText (configfile >> "CfgVehicles" >> _x >> "crew") in ["B_UAV_AI","O_UAV_AI","I_UAV_AI"])}) then {lbAdd [1500, getText (configfile >> "CfgVehicles" >> _x >> "displayName")];_added set [count _added, _x];};} foreach (ARMEDVEHICLES select 2);
{if (!(_x in _added) && {!(getText (configfile >> "CfgVehicles" >> _x >> "crew") in ["B_UAV_AI","O_UAV_AI","I_UAV_AI"])}) then {lbAdd [1500, getText (configfile >> "CfgVehicles" >> _x >> "displayName")];_added set [count _added, _x];};} foreach (ARMEDTANKS select 2);
};
case "NATO Land Vehicles": {
{if (!(_x in _added) && {!(getText (configfile >> "CfgVehicles" >> _x >> "crew") in ["B_UAV_AI","O_UAV_AI","I_UAV_AI"])}) then {lbAdd [1500, getText (configfile >> "CfgVehicles" >> _x >> "displayName")];_added set [count _added, _x];};} foreach (ARMEDVEHICLES select 0);
{if (!(_x in _added) && {!(getText (configfile >> "CfgVehicles" >> _x >> "crew") in ["B_UAV_AI","O_UAV_AI","I_UAV_AI"])}) then {lbAdd [1500, getText (configfile >> "CfgVehicles" >> _x >> "displayName")];_added set [count _added, _x];};} foreach (ARMEDTANKS select 0);
};
case "US Land Vehicles": {
{if (!(_x in _added) && {!(getText (configfile >> "CfgVehicles" >> _x >> "crew") in ["B_UAV_AI","O_UAV_AI","I_UAV_AI"])}) then {lbAdd [1500, getText (configfile >> "CfgVehicles" >> _x >> "displayName")];_added set [count _added, _x];};} foreach (ARMEDVEHICLES select 0);
{if (!(_x in _added) && {!(getText (configfile >> "CfgVehicles" >> _x >> "crew") in ["B_UAV_AI","O_UAV_AI","I_UAV_AI"])}) then {lbAdd [1500, getText (configfile >> "CfgVehicles" >> _x >> "displayName")];_added set [count _added, _x];};} foreach (ARMEDTANKS select 0);
};
case "AI Support": {
//lbAdd [1500, "Mortar Team"];
if (isNil"IFENABLED") then {
lbAdd [1500, "AR-2 Darter (AI)"];
lbAdd [1500, "UGV Stomper (AI)"];
lbAdd [1500, "UGV Stomper RCWS (AI)"];
lbAdd [1500, "MQ4A Greyhawk (AI)"];
};
};
};
lbSetCurSel [1500, 0];
};

SAOKBOXHINT = {
private ["_disp"];
28 cutRsc ["MyRscTitle8","PLAIN"];
disableSerialization;
_disp = uiNamespace getVariable "d8_MyRscTitle";
if (typename _this == "ARRAY") then {
(_disp displayCtrl 308) ctrlSetStructuredText parseText (_this select 0);
} else {
(_disp displayCtrl 308) ctrlSetStructuredText parseText ("<t color='#FF6600'>"+_this+"</t>");
};
};

SAOKLAUNCDYNTASK = {
private ["_n","_bol","_c"];
_c = count SAOKDYNTASKS - 1;
_bol = true;
while {_c >= 0 && {_bol}} do {
if ((count (SAOKDYNTASKS select _c) > 1 && {[] CALL ((SAOKDYNTASKS select _c) select 1)}) || {((SAOKDYNTASKS select _c) select 0) CALL SAOKTCOND}) then {
if (!isNil{SaOkmissionnamespace getvariable ((SAOKDYNTASKS select _c) select 0)}) then {
_n = [] SPAWN (SaOkmissionnamespace getvariable ((SAOKDYNTASKS select _c) select 0));
} else {
_n = [] execVM ((SAOKDYNTASKS select _c) select 0);
};
_bol = false;
SAOKDYNTASKS = [SAOKDYNTASKS,_c] call BIS_fnc_removeIndex;
};
_c = _c - 1;
sleep 0.2;
};
};

SAOKMORECSAT = {
private ["_r","_max","_n","_max2","_start","_rC","_gP","_nP"];
if (random 1.5 > DIFLEVEL) exitWith {};
_max = 5 * ({getmarkercolor _x == "ColorRed"} count AmbientZonesN);
if (_max > 70) then {_max = 70;};
if ({getmarkercolor _x == "ColorRed"} count VEHZONESA > _max) exitWith {};
_gP = [];
{if (getmarkercolor _x == "ColorYellow") then {_gP pushBack _x;};} foreach PierMarkers;
if (count _gP == 0) exitWith {};
_n = _gP call RETURNRANDOM;
_max2 = 0;
_nP = getmarkerpos _n;
while {(getmarkercolor _n != "ColorYellow" || {getmarkerpos(["ColorBlue",_nP] CALL NEARESTCAMP) distance _nP > getmarkerpos(["ColorRed",_nP] CALL NEARESTCAMP) distance _nP}) && {_max2 < 15}} do {_n = _gP call RETURNRANDOM;_max2 = _max2 + 1; sleep 0.1;};
if !(_max2 < 15) exitWith {};
_start = [getmarkerpos _n,100,30,"(1 - trees) * (1 - sea) * (1 - houses)"] CALL SAOKSEEKPOS;
_rC = ["C","P","T","V","T","V","T","V","AA","S"] call RETURNRANDOM;
_r = [2,3,4] call RETURNRANDOM;
if (_rC in ["AA","S"]) then {_r = [1,2] call RETURNRANDOM;};
["EAST",_rC,_r,_start] SPAWN SAOKMOREVEHZONES;
};

SAOKVZFUNC1 = {
private ["_g","_mar","_n"];
_g = "";
{if (!isNull _x) exitWith {_g = group _x;};} foreach _this;
if (typename _g == "STRING") exitWith {};
_mar = _g getvariable "GMar";
_n = [_mar,""] CALL SAOKZONEM;
};

SAOKEJECT = {
private ["_f1","_f2","_f3","_unit","_veh","_Vpos","_itemCargoBackPack","_magCargoBackPack","_weaCargoBackPack","_bp","_BackPackBol"];
_f1 = {
private ["_unit","_typ","_cW","_c","_num"];
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
private ["_unit","_typ","_cW","_c","_num"];
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
private ["_unit","_typ","_cW","_c","_num"];
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
_unit = _this select 0;
_veh = _this select 1;
_bp = backpack _unit;
_itemCargoBackPack = [];
_magCargoBackPack = [];
_weaCargoBackPack = [];
_BackPackBol = !isnull (BackPackContainer _unit);
if (!isNil"_BackPackBol" && {_BackPackBol}) then {
_itemCargoBackPack = (getitemCargo (BackPackContainer _unit));
_magCargoBackPack = (getMagazineCargo (BackPackContainer _unit));
_weaCargoBackPack = (getWeaponCargo (BackPackContainer _unit));
};
removeBackpack _unit;
_unit addbackpack "B_Parachute";
_unit disableCollisionWith _veh; 
_unit allowdamage false;
sleep 1;
_Vpos = getposATL _veh;
_unit setpos [_Vpos select 0,_Vpos select 1,(_Vpos select 2)-12];
if (vehicle _unit != _unit) then {
_unit action ["Eject", _veh];
[_unit] ordergetin false;
};
unassignvehicle _unit;
sleep (1.5+(random 0.5));
_unit action ["OpenParachute",_unit];
[_unit, _veh] SPAWN {
private ["_unit","_veh"];
_unit = _this select 0;
_veh = _this select 1;
waitUntil {isNull _unit || {vehicle _unit != _unit} || {getposATL _unit select 2 < 20}};
_unit allowdamage false;
waitUntil {isNull _unit || {vehicle _unit != _unit} || {getposATL _unit select 2 < 1}};
if (getposATL _unit select 2 > 1) then {
vehicle _unit disableCollisionWith _veh; 
};
if (!isPlayer _unit) then {_unit switchmove "";};
sleep 2;
_unit allowdamage true;
};
sleep 6;
_unit allowdamage true;
waitUntil {sleep 1; getposATL _unit select 2 < 1};
if (alive _unit && {_bp != ""}) then {
if (!isPlayer _unit) then {_unit switchmove "";};
_unit addBackpack _bp;
clearMagazineCargo BackpackContainer _unit;
clearWeaponCargo BackpackContainer _unit;
clearItemCargo BackpackContainer _unit;
if (_BackPackBol) then {
[_weaCargoBackPack,_unit,"B"] CALL _f3;
[_itemCargoBackPack,_unit,"B"] CALL _f2;
[_magCargoBackPack,_unit,"B"] CALL _f1;
};
};
};

SAOKMZDIALOG = {
private ["_ok","_myDisplay"];
disableserialization;
_ok = createDialog "CreateVMDialog"; 
_myDisplay = findDisplay 12453;
{
lbAdd [1499, _x];
} foreach [
"Armored",
"Light Armored",
"Anti-Air",
"Chopper",
"Plane",
"Support"
];
lbSetCurSel [1499, 0];
};

SAOKMZCAT = {
//lbClear 1501;

private ["_foreachindex","_myDisplay","_ctrl","_text","_ctrl2","_u","_nn"];
lbClear 1500;
_myDisplay = findDisplay 12453;
_ctrl = (_myDisplay displayCtrl 1500);
_text = "";
_ctrl2 = (_myDisplay displayCtrl 1100);
//_ctrl2 ctrlSetStructuredText parseText _text;
_u = [];
_nn = 0;
switch _this do {
case "Armored": {{if !(_x in _u) then {_u pushback _x;lbAdd [1500,  getText(configfile >> "CfgVehicles" >> _x >> "displayName")];_ctrl lbSetPicture [_nn,gettext (configfile >> "CfgVehicles" >> _x >> "picture")];_nn = _nn + 1;};} foreach (ARMEDTANKS select 0)+(ARMEDTANKS select 2)+(ARMEDTANKS select 3);};
case "Light Armored": {{if !(_x in _u) then {_u pushback _x;lbAdd [1500,  getText(configfile >> "CfgVehicles" >> _x >> "displayName")];_ctrl lbSetPicture [_nn,gettext (configfile >> "CfgVehicles" >> _x >> "picture")];_nn = _nn + 1;};} foreach (ARMEDVEHICLES select 0)+(ARMEDVEHICLES select 2)+(ARMEDVEHICLES select 3);};
case "Anti-Air": {{if !(_x in _u) then {_u pushback _x;lbAdd [1500,  getText(configfile >> "CfgVehicles" >> _x >> "displayName")];_ctrl lbSetPicture [_nn,gettext (configfile >> "CfgVehicles" >> _x >> "picture")];_nn = _nn + 1;};} foreach (ARMEDAA select 0)+(ARMEDAA select 2)+(ARMEDAA select 3);};
case "Chopper": {{if !(_x in _u) then {_u pushback _x;lbAdd [1500,  getText(configfile >> "CfgVehicles" >> _x >> "displayName")];_ctrl lbSetPicture [_nn,gettext (configfile >> "CfgVehicles" >> _x >> "picture")];_nn = _nn + 1;};} foreach (AIRARMCHOP select 0)+(AIRARMCHOP select 2)+(AIRARMCHOP select 3);};
case "Plane": {{if !(_x in _u) then {_u pushback _x;lbAdd [1500,  getText(configfile >> "CfgVehicles" >> _x >> "displayName")];_ctrl lbSetPicture [_nn,gettext (configfile >> "CfgVehicles" >> _x >> "picture")];_nn = _nn + 1;};} foreach (AIRFIGTHER select 0)+(AIRFIGTHER select 2)+(AIRFIGTHER select 3);};
case "Support": {{if !(_x in _u) then {_u pushback _x;lbAdd [1500,  getText(configfile >> "CfgVehicles" >> _x >> "displayName")];_ctrl lbSetPicture [_nn,gettext (configfile >> "CfgVehicles" >> _x >> "picture")];_nn = _nn + 1;};} foreach (ARMEDSUPPORT select 0)+(ARMEDSUPPORT select 2);};
};
};

SAOKMZADD = {
private ["_v","_cl","_n","_cost","_c","_ar","_text","_myDisplay"];
if (_this != "" && {lbSize 1501 < 3}) then {lbAdd [1501, _this];};
_n = lbSize 1501 - 1;
_ar = [];
_v = [];
//(ARMEDTANKS select 0)+(ARMEDVEHICLES select 0)+(ARMEDAA select 0)+(AIRARMCHOP select 0)+(AIRFIGTHER select 0)+(ARMEDSUPPORT select 0)
switch (lbText [1499,(lbCurSel 1499)]) do {
case "Armored": {_v = (ARMEDTANKS select 0)+(ARMEDTANKS select 2)+(ARMEDTANKS select 3);};
case "Light Armored": {_v = (ARMEDVEHICLES select 0)+(ARMEDVEHICLES select 2)+(ARMEDVEHICLES select 3);};
case "Anti-Air": {_v = (ARMEDAA select 0)+(ARMEDAA select 2)+(ARMEDAA select 3);};
case "Chopper":  {_v = (AIRARMCHOP select 0)+(AIRARMCHOP select 2)+(AIRARMCHOP select 3);};
case "Plane":  {_v = (AIRFIGTHER select 0)+(AIRFIGTHER select 2)+(AIRFIGTHER select 3);};
case "Support":  {_v = (ARMEDSUPPORT select 0)+(ARMEDSUPPORT select 2);};
};
while {_n >= 0} do {
_cl = "";
{if (getText(configfile >> "CfgVehicles" >> _x >> "displayName") == lbText [1501, _n]) exitWith {_cl = _x;};} foreach (ARMEDTANKS select 0)+(ARMEDVEHICLES select 0)+(ARMEDAA select 0)+(AIRARMCHOP select 0)+(AIRFIGTHER select 0)+(ARMEDSUPPORT select 0);
if (_cl == "") then {
{if (getText(configfile >> "CfgVehicles" >> _x >> "displayName") == lbText [1501, _n]) exitWith {_cl = _x;};} foreach (ARMEDTANKS select 2)+(ARMEDVEHICLES select 2)+(ARMEDAA select 2)+(AIRARMCHOP select 2)+(AIRFIGTHER select 2)+(ARMEDSUPPORT select 2);
};
if (_cl == "") then {
{if (getText(configfile >> "CfgVehicles" >> _x >> "displayName") == lbText [1501, _n]) exitWith {_cl = _x;};} foreach (ARMEDTANKS select 3)+(ARMEDVEHICLES select 3)+(ARMEDAA select 3)+(AIRARMCHOP select 3)+(AIRFIGTHER select 3);
};
if (_cl != "") then {_ar pushBack _cl;};
_n = _n - 1;
};
_c = 0;
{
_cost = ((getText(configfile >> "CfgVehicles" >> _x >> "displayName")) CALL SUPPORTCOST) * 0.7;
_c = _c + _cost;
} foreach _ar;
_text = format ["Price %1",_c];
_myDisplay = findDisplay 12453;
(_myDisplay displayCtrl 1100) ctrlSetStructuredText parseText _text;
};

SAOKMZREM = {

private ["_v","_cl","_n","_cost","_c","_ar","_text","_myDisplay"];
lbDelete [1501, _this];
_n = lbSize 1501 - 1;
_ar = [];
_v = [];
switch (lbText [1499,(lbCurSel 1499)]) do {
case "Armored": {_v = (ARMEDTANKS select 0)+(ARMEDTANKS select 2)+(ARMEDTANKS select 3);};
case "Light Armored": {_v = (ARMEDVEHICLES select 0)+(ARMEDVEHICLES select 2)+(ARMEDVEHICLES select 3);};
case "Anti-Air": {_v = (ARMEDAA select 0)+(ARMEDAA select 2)+(ARMEDAA select 3);};
case "Chopper":  {_v = (AIRARMCHOP select 0)+(AIRARMCHOP select 2)+(AIRARMCHOP select 3);};
case "Plane":  {_v = (AIRFIGTHER select 0)+(AIRFIGTHER select 2)+(AIRFIGTHER select 3);};
case "Support":  {_v = (ARMEDSUPPORT select 0)+(ARMEDSUPPORT select 2);};
};
while {_n >= 0} do {
_cl = "";
{if (getText(configfile >> "CfgVehicles" >> _x >> "displayName") == lbText [1501, _n]) exitWith {_cl = _x;};} foreach (ARMEDTANKS select 0)+(ARMEDVEHICLES select 0)+(ARMEDAA select 0)+(AIRARMCHOP select 0)+(AIRFIGTHER select 0)+(ARMEDSUPPORT select 0);
if (_cl == "") then {
{if (getText(configfile >> "CfgVehicles" >> _x >> "displayName") == lbText [1501, _n]) exitWith {_cl = _x;};} foreach (ARMEDTANKS select 2)+(ARMEDVEHICLES select 2)+(ARMEDAA select 2)+(AIRARMCHOP select 2)+(AIRFIGTHER select 2)+(ARMEDSUPPORT select 2);
};
if (_cl == "") then {
{if (getText(configfile >> "CfgVehicles" >> _x >> "displayName") == lbText [1501, _n]) exitWith {_cl = _x;};} foreach (ARMEDTANKS select 3)+(ARMEDVEHICLES select 3)+(ARMEDAA select 3)+(AIRARMCHOP select 3)+(AIRFIGTHER select 3);
};
if (_cl != "") then {_ar pushBack _cl;};
_n = _n - 1;
};
_c = 0;
{
_cost = ((getText(configfile >> "CfgVehicles" >> _x >> "displayName")) CALL SUPPORTCOST) * 0.7;
_c = _c + _cost;
} foreach _ar;
_text = format ["Price %1",_c];
_myDisplay = findDisplay 12453;
(_myDisplay displayCtrl 1100) ctrlSetStructuredText parseText _text;
};

SAOKMZCALLIN = {

private ["_typ","_v","_tex","_cl","_n","_cost","_c","_nul","_star","_ar"];
_typ = "";
_v = [];
_tex = "";
switch (lbText [1499,(lbCurSel 1499)]) do {
case "Armored": {_typ = "b_armor";_v = (ARMEDTANKS select 0)+(ARMEDTANKS select 2)+(ARMEDTANKS select 3);};
case "Light Armored": {_typ = "b_mech_inf";_v = (ARMEDVEHICLES select 0)+(ARMEDVEHICLES select 2)+(ARMEDVEHICLES select 3);};
case "Anti-Air": {_typ = "b_art";_v = (ARMEDAA select 0)+(ARMEDAA select 2)+(ARMEDAA select 3); _tex = " AA";};
case "Chopper":  {_typ = "b_air";_v = (AIRARMCHOP select 0)+(AIRARMCHOP select 2)+(AIRARMCHOP select 3);};
case "Plane":  {_typ = "b_plane";_v = (AIRFIGTHER select 0)+(AIRFIGTHER select 2)+(AIRFIGTHER select 3);};
case "Support":  {_typ = "b_support";_v = (ARMEDSUPPORT select 0)+(ARMEDSUPPORT select 2);};
};
_n = lbSize 1501 - 1;
_ar = [];
while {_n >= 0} do {
_cl = "";
{if (getText(configfile >> "CfgVehicles" >> _x >> "displayName") == lbText [1501, _n]) exitWith {_cl = _x;};} foreach (ARMEDTANKS select 0)+(ARMEDVEHICLES select 0)+(ARMEDAA select 0)+(AIRARMCHOP select 0)+(AIRFIGTHER select 0)+(ARMEDSUPPORT select 0);
if (_cl == "") then {
{if (getText(configfile >> "CfgVehicles" >> _x >> "displayName") == lbText [1501, _n]) exitWith {_cl = _x;};} foreach (ARMEDTANKS select 2)+(ARMEDVEHICLES select 2)+(ARMEDAA select 2)+(AIRARMCHOP select 2)+(AIRFIGTHER select 2)+(ARMEDSUPPORT select 2);
};
if (_cl == "") then {
{if (getText(configfile >> "CfgVehicles" >> _x >> "displayName") == lbText [1501, _n]) exitWith {_cl = _x;};} foreach (ARMEDTANKS select 3)+(ARMEDVEHICLES select 3)+(ARMEDAA select 3)+(AIRARMCHOP select 3)+(AIRFIGTHER select 3);
};
if (_cl != "") then {_ar pushBack _cl;};
_n = _n - 1;
};
if (count _ar > 0 && {_typ != ""}) then {

_c = 0;
{
_cost = ((getText(configfile >> "CfgVehicles" >> _x >> "displayName")) CALL SUPPORTCOST) * 0.7;
_c = _c + _cost;
} foreach _ar;
if (([side player] CALL PrestigeS) > _c) then {
_n = [WEST,- _c] SPAWN PrestigeUpdate;
[[- _c, "Called Platoon"],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
"Cash" SPAWN SAOKPLAYSOUND;
_star = [getposATL player,1500,500,"(1 + meadow) * (1 - sea)"] CALL SAOKSEEKPOS;
//_n = [_star, "ColorBlue",_ar,_typ,_tex] CALL AddVehicleZone;
[[_star, "ColorBlue",_ar,_typ,_tex],"AddVehicleZone",false,false] spawn BIS_fnc_MP;
} else {(format ["%1 More Prestige Needed",_c - ([side player] CALL PrestigeS)]) SPAWN HINTSAOK;};
};

};

//["Sheep_random_F","Cock_random_F","Fin_random_F","Alsatian_Random_F","Hen_random_F","Goat_random_F"]
// animal1 = [getposATL player, "Fin_random_F"] CALL SAOKANIMAL;
SAOKBIRDMSF = {
	private ["_crow","_st","_end","_dis","_wp","_time"];
	_crow = _this select 0;
	_st = _this select 1;
	_end = _this select 2;
	_wp = [
	(_st select 0) - 10 + (random 20),
	(_st select 1) - 10 + (random 20),
	20 + random 10
	];
	_dis = _crow distance _wp;
	_time = (_dis);
	_crow camsetpos _wp;
	_crow camcommit _time;
	sleep (1+(random 2));
	_wp = [
	(_end select 0) - 10 + (random 20),
	(_end select 1) - 10 + (random 20),
	(_end select 2) + random 10
	];
	_dis = _crow distance _wp;
	_time = (_dis);
	_crow camsetpos _wp;
	_crow camcommit _time;
};
//[""] SPAWN SAOKSPAWNBIGCAMP;
SAOKFREEMORTAR = {

private ["_start","_tg1","_Gid"];
_start = [(vehicle (([] CALL AllPf) call RETURNRANDOM)),5000,2000,"(1 + meadow) * (1 - sea)"] CALL SAOKSEEKPOS;
_tg1 = [_start, 0, "I_G_Mortar_01_F", WEST] call SPAWNVEHICLE;
(_tg1 select 2) allowfleeing 0;
_Gid = "Mortar Team";
//_Gid = "Sandstorm";
//if (_tank == "B_MBT_01_arty_F") then {_Gid = "Scorcher";};
IDNUM = IDNUM + 1;
_Gid = _Gid + format ["%1",IDNUM];
(_tg1 select 2) setgroupid [_Gid];
(vehicle (leader (_tg1 select 2))) synchronizeObjectsAdd [mudo1]; mudo1 synchronizeObjectsAdd [(vehicle (leader (_tg1 select 2)))]; 
[] SPAWN {sleep 10;(format ["You can give fire missions for %1 via 0-8 channel.","Mortar Team"]) SPAWN HINTSAOK;};
[(_tg1 select 2)] SPAWN {

private ["_group","_veh","_wP","_vt","_aika"];
_group = _this select 0;
_veh = (vehicle (leader _group)); 
_wP = (magazines _veh) select 0;
_vt = typeof _veh;
DONTDELGROUPS = DONTDELGROUPS +  [_group];
CantCommand = CantCommand + [_group];
_aika = time + 20;
waitUntil {sleep 5; !alive _veh || {count units _group == 0} || {(!(_wP in (magazines _veh)) && {!(_vt == "B_MBT_01_arty_F")}) || {(_vt == "B_MBT_01_arty_F" && {(count (magazines _veh) < 3)})}}};
CARS = CARS + [_veh];
CantCommand = CantCommand + [_group];
DONTDELGROUPS = DONTDELGROUPS -  [_group];
(vehicle (leader _group)) synchronizeObjectsRemove [mudo1]; mudo1 synchronizeObjectsRemove [(vehicle (leader _group))]; 
};
};
//[EAST,_locationA,3000] CALL SAOKZONEVEHICLESNEARBY;
SAOKZONEVEHICLESNEARBY = {
private ["_veh","_vehs","_side","_cen","_rad"];
_side = _this select 0;
_cen = _this select 1;
_rad = _this select 2;
_vehs = [];
{if (_x distance _cen < _rad && {{alive _x && {side _x == _side}} count crew _x > 0} && {!isNil{_x getvariable "ZoneVehi"}}) then {
_veh = _x;
if ({typeof _veh in _x} count ARMEDVEHICLES > 0 || {typeof _veh in _x} count ARMEDTANKS > 0) then {
_vehs pushBack _x;
};
};} foreach vehicles;
_vehs
};

SAOKSPAWNBIGCAMP = {
private ["_start","_d","_st","_pAr","_nul"];
_d = 12000;
sleep 0.1;
_st = [vehicle (([] CALL AllPf) call RETURNRANDOM), 12000,1000,"(1 - sea)* (1 + meadow)* (1 - hills)",""] CALL SAOKSEEKPOSAR;
_start = "";
{if ([_x,40] CALL SAOKISFLAT) exitWith {_start = _x;};} foreach (_st select 0);
while {typename _start == "STRING" || {count (_st select 0) == 0} || {surfaceisWater _start} || {{_x distance _start < 400} count GuardPosts > 0} ||{{getmarkerpos _x distance _start < 400} count AmbientZonesN > 0} || {!([_start,80] CALL SAOKISFLAT)} || {count (_start nearRoads 60) > 0}} do {
sleep 0.1;
if (_d < 15000) then {_d = _d + 300;};
sleep 0.1;
_st = [vehicle (([] CALL AllPf) call RETURNRANDOM), _d,1000,"(1 - sea)* (1 + meadow)* (1 - hills)",""] CALL SAOKSEEKPOSAR;
{if ([_x,40] CALL SAOKISFLAT) exitWIth {_start = _x;};} foreach (_st select 0);
sleep 0.2;
};
_pAr = [_start,"",(65+random 25)];
if (count _this > 0) then {_pAr pushBack (_this select 0);};
_nul = _pAr SPAWN CreateRoadBlock;
waitUntil {sleep 0.1; scriptdone _nul};
};

SAOKTASKDIALOG = {
private ["_ok","_myDisplay"];
disableserialization;
_ok = createDialog "TaskDialog"; 
_myDisplay = findDisplay 3992;
{
lbAdd [1500, _x];
} foreach [
"Transport Chopper Duty"
];
};

SAOKTASKLAUNCH = {
switch _this do {
case "Transport Chopper Duty": {[] SPAWN TASK_AirTask1;};
case "Rescue Officer": {["MilitaryTasks\TaskFindOfficer.sqf"] SPAWN SA_TASKM1;};
case "Kill Officer": {["MilitaryTasks\TaskKillOfficer.sqf"] SPAWN SA_TASKM2;};
case "MilitaryTasks\TaskCreateGuardpost.sqf": {["MilitaryTasks\TaskCreateGuardpost.sqf"] SPAWN SA_TASKM3;};
case "MilitaryTasks\TaskConvoy.sqf": {["MilitaryTasks\TaskConvoy.sqf"] SPAWN SA_TASKM4;};
case "MilitaryTasks\TaskZone.sqf": {["MilitaryTasks\TaskZone.sqf"] SPAWN SA_TASKM5;};
case "MilitaryTasks\TaskAttackCamp.sqf": {["MilitaryTasks\TaskAttackCamp.sqf"] SPAWN SA_TASKM6;};
case "MilitaryTasks\TaskGuardRoadBlock.sqf": {["MilitaryTasks\TaskGuardRoadBlock.sqf"] SPAWN SA_TASKM7;};
};
};

SAOKTAKENBOX = {
private ["_xM","_xP","_yM","_yP","_z6","_z3","_yy","_zz","_xx","_size","_bol","_start","_p8","_p7","_p6","_p5","_p4","_p3","_p2","_p1"];
_bol = false;
_start = _this select 0;
_size = if (count _this > 1) then {if (typename (_this select 1) == "STRING") then {((_this select 1) CALL SAOKBSIZE)*0.5} else {(_this select 1)}} else {5};
if (typename _size != "SCALAR") then {hint str (_this select 1);};
_xx = _start select 0;
_yy = _start select 1;
_zz = if (count _start > 2) then {_start select 2} else {0};
_z3 = _zz + 0.3;
_z6 = _zz + 6;
_yP = _yy + _size;
_yM = _yy - _size;
_xP = _xx + _size;
_xM = _xx - _size;
_p1 = ATLtoASL [_xM,_yP,_z3];
_p2 = ATLtoASL [_xM,_yP,_z6];
_p3 = ATLtoASL [_xP,_yP,_z3];
_p4 = ATLtoASL [_xP,_yP,_z6];
_p5 = ATLtoASL [_xM,_yM,_z3];
_p6 = ATLtoASL [_xM,_yM,_z6];
_p7 = ATLtoASL [_xP,_yM,_z3];
_p8 = ATLtoASL [_xP,_yM,_z6];
if (lineIntersects [_p3,_p5] || {lineIntersects [_p3,_p7]} || {lineIntersects [_p5,_p7]} || {lineIntersects [_p1,_p7]} || {lineIntersects [_p1,_p5]} || {lineIntersects [_p1,_p3]} || {lineIntersects [_p1,_p2]} || {lineIntersects [_p3,_p4]} || {lineIntersects [_p5,_p6]} || {lineIntersects [_p7,_p8]}) then {_bol = true;};
_bol
};

SAOKANIMALEVENT2 = {
private ["_s","_sHou","_a","_m","_all","_t","_c","_pos","_e"];
if (true) exitWith {};
if ("SAOKANIMALEVENT2" in CurrentEvents) exitWith {};
CurrentEvents = CurrentEvents + ["SAOKANIMALEVENT2"];
_all = [];
_t = ["Sheep_random_F","Goat_random_F"] call RETURNRANDOM; 
_c = 6 + floor random 9;
_pos = getposATL player;
_s = [(_pos select 0) + 150 - (random 300), (_pos select 1) + 150 - (random 300), 0];
while {_s distance player < 50 || {[_s,player] CALL FUNKTIO_LOSOBJ}} do {_s = [(_pos select 0) + 150 - (random 300), (_pos select 1) + 150 - (random 300), 0]; sleep 0.1;};
_e = [(_pos select 0) + 150 - (random 300), (_pos select 1) + 150 - (random 300), 0];
for "_i" from 0 to _c do {
_sHou = [(_s select 0) + 10 - (random 20), (_s select 1) + 10 - (random 20), 0];
_a = [_sHou, _t] CALL SAOKANIMAL;
_all pushBack _a;
_m = [(_e select 0) + 5 - (random 10), (_e select 1) + 5 - (random 10), 0];
_a domove _m;
sleep 0.1;
};
waitUntil {sleep 5; {_x distance player < 500} count _all == 0};
{deletevehicle _x;} foreach _all;
CurrentEvents = CurrentEvents - ["SAOKANIMALEVENT2"];
};

SAOKANIMALEVENT1 = {
private ["_c","_array","_sHou","_waypoints","_building","_t","_a","_xx","_m","_pP","_all","_pos","_time"];
if (true) exitWith {};
if ("SAOKANIMALEVENT1" in CurrentEvents) exitWith {};
CurrentEvents = CurrentEvents + ["SAOKANIMALEVENT1"];
_all = [];
_c = 3 + floor random 6;
_pos = getposATL player;
for "_i" from 0 to _c do {
_c = 0;
_building = objNull;
_sHou = [(_pos select 0) + 100 - (random 200), (_pos select 1) + 100 - (random 200), 0];
_building = nearestBuilding _sHou;
_waypoints = _building call SAOKBUILDINGPOS;
if (count _waypoints > 0) then {
_sHou = _building buildingPos (_waypoints call RETURNRANDOM);
};
_t = ["Fin_random_F","Alsatian_Random_F"] call RETURNRANDOM; 
_a = [_sHou, _t] CALL SAOKANIMAL;
_a setpos _sHou;
_all pushBack _a;
sleep 0.1;
};
_time = time + 120;
while {_pos distance vehicle player < 300 && {_time > time}} do {
sleep (random 3);
_pP = getposATL player;
_c = count _all - 1;
for "_i" from 0 to _c do {
if (random 1 < 0.3) then {
_xx = _all select _i;
_m = [(_pP select 0) + 5 - (random 10), (_pP select 1) + 5 - (random 10), 0];
_xx domove _m;
sleep (random 2);
if ({_x distance player < 20} count _all > 0 && {abs (PSHOT - time) < 5}) exitWith {};
};
sleep 0.1;
};
};
waitUntil {sleep 5; {_x distance player < 400} count _all == 0};
{deletevehicle _x;} foreach _all;
CurrentEvents = CurrentEvents - ["SAOKANIMALEVENT1"];
};

SAOKANIMAL = {
private ["_g","_a"];
_g = creategroup civilian;
_a = _g createUnit [_this select 1, _this select 0, [], 0, "NONE"]; 
_a
};

SAOKREMOVEWAYPOINTS = {
private ["_c","_cc"];
_c = waypoints _this;
_cc = count _c;
if (_cc < 1) exitWith {};
for "_i" from _cc to 0 step -1  do {
deleteWaypoint (_c select _i); 
};
};
//acts_CrouchingCoveringRifle01 Acts_starterPistol_fire
SAOKGUNPOINTING = {
private ["_unts","_Lna","_header"];
while {true} do {
  sleep 1;
  _unts = ((getposATL player) nearEntities [["Civilian"],14]);
  if (count _unts > 0) then {
  if (!isNull cursorTarget && {cursorTarget in _unts} && {isNil{cursorTarget getvariable "CivNo"}} && {currentWeapon player != ""} && {(player weaponDirection currentWeapon player) select 2 > -0.4} && {([player, cursorTarget] CALL FUNKTIO_LOS)}) then {
  if (isNil{cursorTarget getvariable "Talki"}) then {
  //cursorTarget playMoveNow "AmovPercMstpSnonWnonDnon_AmovPercMstpSsurWnonDnon";
  [[cursorTarget,"AmovPercMstpSnonWnonDnon_AmovPercMstpSsurWnonDnon"],"SAOKPMOVE",nil,false] spawn BIS_fnc_MP;
  cursorTarget setvariable ["Uhkailtu",1,true];
  if (random 1 < 0.1) then {
	_Lna = (getposATL player) CALL NEARESTLOCATIONNAME;
	_header = format ["NATO Soldiers Seen Pointing Guns at Civilians in %1",_Lna];
	[_header, date] CALL SAOKEVENTLOG;
  };
  sleep 5;
  };
  };
  };
 };
};
[] SPAWN SAOKGUNPOINTING;

if (isServer) then {
SaOkmissionnamespace setvariable ["RandomEvents",[],true];
};
SAOKADDRANDOMEVENTS = {
private ["_b"];
_b = SaOkmissionnamespace getvariable "RandomEvents";
_b = _b + _this;
SaOkmissionnamespace setvariable ["RandomEvents",_b,true];
};

SAOKTRANDOMEVENT = {
private ["_c","_p","_n"];
_c = SaOkmissionnamespace getvariable "RandomEvents"; 
if (count _c == 0) exitWith {};
_p = _c call RETURNRANDOM; 
while {_p in _c} do {_c = _c - [_p];};
SaOkmissionnamespace setvariable ["RandomEvents",_c,true];
switch _p do {
case "CSATBASE1": {_n = [2,30,"CSAT SUN RISING",("CSAT Is Building Fast New Command Center to Unknown Location on "+(format ["%1",worldname]))] SPAWN SAOKCOMINGCHAP;};
case "CSATBASE2": {_n = [6,30,"CSAT EXPANDING",("CSAT Preparing Another Large Post to Unknown Location on "+(format ["%1",worldname]))] SPAWN SAOKCOMINGCHAP;};
case "CSATAIR": {_n = [1,40,"CSAT AIR OPERATION","CSAT Fighters Seen Leaving Stratis"] SPAWN SAOKCOMINGCHAP;};
case "CSATLAND": {_n = [1,45,"CSAT LAND OPERATION",("Unresponding Cargo Ships Heading Towards "+(format ["%1",worldname]))] SPAWN SAOKCOMINGCHAP;};
};
};

SAOKCHAPTEREVENTS = {
private ["_n"];
[((_this)+" STARTED"), date] CALL SAOKEVENTLOG;
switch _this do {
case "CSATBASE1": {_n = [] SPAWN SAOKSPAWNBIGCAMP;["CSATBASE2"] SPAWN SAOKADDRANDOMEVENTS;gameLogic1 globalchat localize "STR_milC1_l3";};
case "CSATBASE2": {_n = [] SPAWN SAOKSPAWNBIGCAMP;gameLogic1 globalchat localize "STR_milC1_l4";};
case "CSAT AIR OPERATION": {
["EAST","P",2] SPAWN SAOKMOREVEHZONES;["EAST","C",2] SPAWN SAOKMOREVEHZONES;
gameLogic1 globalchat localize "STR_milC1_l1";
sleep (120 + random 900);
["EAST","P",2] SPAWN SAOKMOREVEHZONES;["EAST","C",2] SPAWN SAOKMOREVEHZONES;
};
case "CSAT LAND OPERATION": {
["EAST","T",4] SPAWN SAOKMOREVEHZONES;["EAST","V",2] SPAWN SAOKMOREVEHZONES;["EAST","AA",1] SPAWN SAOKMOREVEHZONES;
gameLogic1 globalchat localize "STR_milC1_l2";
sleep (120 + random 900);
["EAST","T",4] SPAWN SAOKMOREVEHZONES;["EAST","V",2] SPAWN SAOKMOREVEHZONES;["EAST","AA",1] SPAWN SAOKMOREVEHZONES;
};
};
};



SAOKTMSKILLUP = {
private ["_unit","_r","_p"];
{
_unit = _x;
_r = 0.3 / DIFLEVEL;
if (random 1 < _r) then {
_p = if (isNil{_unit getvariable "PointSK"}) then {0} else {_unit getvariable "PointSK"};
_unit setvariable ["PointSK",(_p+(1 + (floor random 2))),true];
};
} foreach units group player - [player];
};

SAOKSUPTEXT = {
private ["_text","_myDisplay"];
_text = "";
switch _this do {
case "Air Support": {_text = "Autonomous AI support";};
case "Land Support": {_text = "Autonomous, but can also be HighCommanded via Ctrl+Space";};
case "Infantry Support": {_text = "Autonomous, but can also be HighCommanded via Ctrl+Space";};
case "Artillery": {_text = "Use by pressing 0-8";};
case "Gear Drop": {_text = "Paradropped nearby after few minutes";};
case "Support": {_text = "Can be HighCommanded via Ctrl+Space or called by pressing 5-1";};
case "Diversions": {_text = "Nearby enemy vehicles will head away with certain changes";};
case "Vehicles [Para]": {_text = "Paradropped nearby after few minutes";};
case "Teammates [Para]": {_text = "Paradropped nearby and joined automatically";};
case "Undercover": {_text = "Move Undercover exitzone more nearby. You can also exit this mode in any friendly camp";};
case "Transport": {_text = "Be picked after few minutes delay and transported to any wanted location.";};
};
_myDisplay = findDisplay 1235;
(_myDisplay displayCtrl 1101) ctrlSetStructuredText parseText _text;
};

//_unit getvariable "PointSK"
SAOKUNITSELTEXT = {
private ["_unit","_text","_v","_myDisplay"];
_myDisplay = findDisplay 1212;
(_myDisplay displayCtrl 1603) ctrlEnable false;
_unit = player;
{if (_this == name _x) exitWith {_unit = _x;};} foreach units group player;
_text = (name _unit)+"<br/>";
_text = _text + (rank _unit)+"<br/>" +"<br/>";
_text = _text + "SKILLS";
if (!isNil{_unit getvariable "PointSK"}) then {_text = _text + format [" (%1)",_unit getvariable "PointSK"];
if (_unit getvariable "PointSK" > 0) then {(_myDisplay displayCtrl 1603) ctrlEnable true;} else {(_myDisplay displayCtrl 1603) ctrlEnable false;};
};
_text = _text +"<br/>";
{
_v = 100*(_unit skill _x);
_v = [_v,0] CALL BIS_fnc_cutDecimals;
_text = _text + format ["%2: %1",_v, _x] +"<br/>";
} foreach ["General","Commanding","ReloadSpeed","Courage","SpotTime","SpotDistance","Endurance","AimingSpeed","AimingShake","AimingAccuracy"];
(_myDisplay displayCtrl 1100) ctrlSetStructuredText parseText _text;
};

SAOKADDSKILLP = {
private ["_unitN","_skill","_unit","_k","_p"];
_unitN = _this select 0;
_skill = _this select 1;
_unit = player;
{if (_unitN == name _x) exitWith {_unit = _x;};} foreach units group player;
_p = if (!isNil{_unit getvariable "PointSK"}) then {_unit getvariable "PointSK"} else {0};
if (!isPlayer _unit && {_p > 0}) then {
_k = _unit skill _skill;
if (_k + 0.01 <= 1) then {_unit setSkill [_skill, (_k + 0.01)];_p = _p - 1;_unit setvariable ["PointSK",(floor _p),true];};
};
};

SAOKWLATEXT = {
private ["_text","_myDisplay","_v","_foreachIndex","_unit","_colors"];
switch _this do {
_text = "";
case "Mod Info": {
_text = _text + "<t size='0.9'>";
_text = _text + "FOR ADMIN. Any mod vehicles and units can be enabled to appear (for AI/Shops/Support) during the mission via Mods-button. Mod gear appears automatically for AI units and in shops. The mods just need to be enabled when starting the game.";
_text = _text + "<br/><br/>Mission can also be played on Staszow, Napf, Bornholm, Sara (Sahrani), smd_sahrani_a3 (SMD Sahrani), Fallujah, FDF_isle1_a (Podagorsk), Clafghan, Isladuala3, Panthera3, Chernarus and Takistan by renaming pbo file to e.g. WLA.Chernarus.pbo. Support for more maps coming soon.<br/><br/>Automatic MOD support for RHS Escalation and Iron Front (enable in MP lobby parameters)";
_text = _text + "</t>";
};
case "Legend Forces": {
{_text = _text + format ["<img size='1.2' image='%1'/> ",(getText (configfile >> "CfgMarkers" >> _x >> "icon"))];} foreach ["o_armor","b_armor","n_armor"];
_text = _text + " Armor<br/>";
{_text = _text + format ["<img size='1.2' image='%1'/> ",(getText (configfile >> "CfgMarkers" >> _x >> "icon"))];} foreach ["o_mech_inf","b_mech_inf","n_mech_inf"];
_text = _text + " Armored Vehicle<br/>";
{_text = _text + format ["<img size='1.2' image='%1'/> ",(getText (configfile >> "CfgMarkers" >> _x >> "icon"))];} foreach ["o_air","b_air","n_air"];
_text = _text + " Chopper<br/>";
{_text = _text + format ["<img size='1.2' image='%1'/> ",(getText (configfile >> "CfgMarkers" >> _x >> "icon"))];} foreach ["o_plane","b_plane","n_plane"];
_text = _text + " Plane<br/>";
{_text = _text + format ["<img size='1.2' image='%1'/> ",(getText (configfile >> "CfgMarkers" >> _x >> "icon"))];} foreach ["o_uav","b_uav","n_uav"];
_text = _text + " UAV<br/>";
{_text = _text + format ["<img size='1.2' image='%1'/> ",(getText (configfile >> "CfgMarkers" >> _x >> "icon"))];} foreach ["o_naval","b_naval","n_naval"];
_text = _text + " Armored Boat<br/>";
{_text = _text + format ["<img size='1.2' image='%1'/> ",(getText (configfile >> "CfgMarkers" >> _x >> "icon"))];} foreach ["o_art","b_art","n_art"];
_text = _text + " Artillery/Anti-Air<br/>";
{_text = _text + format ["<img size='1.2' image='%1'/> ",(getText (configfile >> "CfgMarkers" >> _x >> "icon"))];} foreach ["o_mortar","b_mortar","n_mortar"];
_text = _text + " Mortar<br/>";
{_text = _text + format ["<img size='1.2' image='%1'/> ",(getText (configfile >> "CfgMarkers" >> _x >> "icon"))];} foreach ["o_support","b_support","n_support"];
_text = _text + " Support Truck<br/>";
{_text = _text + format ["<img size='1.2' image='%1'/> ",(getText (configfile >> "CfgMarkers" >> _x >> "icon"))];} foreach ["o_med","b_med","n_med"];
_text = _text + " Medical<br/>";
};
case "Legend Other": {
{_text = _text + format ["<img size='1.2' image='%1'/> ",(getText (configfile >> "CfgMarkers" >> _x >> "icon"))];} foreach ["o_hq","n_hq"];
_text = _text + " Camp<br/>";
{_text = _text + format ["<img size='1.2' image='%1'/> ",(getText (configfile >> "CfgMarkers" >> _x >> "icon"))];} foreach ["o_installation","n_installation"];
_text = _text + " Guardpost<br/>";
{_text = _text + format ["<img size='1.2' image='%1'/> ",(getText (configfile >> "CfgMarkers" >> _x >> "icon"))];} foreach ["o_service","n_service"];
_text = _text + " Supply Depot<br/>";
{_text = _text + format ["<img size='1.2' image='%1'/> ",(getText (configfile >> "CfgMarkers" >> _x >> "icon"))];} foreach ["u_installation"];
_text = _text + " Factory or Airfield (Orange)<br/>";
{_text = _text + format ["<img size='1.2' image='%1'/> ",(getText (configfile >> "CfgMarkers" >> _x >> "icon"))];} foreach ["loc_Power"];
_text = _text + " Power Plant<br/>";
{_text = _text + format ["<img size='1.2' image='%1'/> ",(getText (configfile >> "CfgMarkers" >> _x >> "icon"))];} foreach ["loc_Quay"];
_text = _text + " Pier<br/>";
{_text = _text + format ["<img size='1.2' image='%1'/> ",(getText (configfile >> "CfgMarkers" >> _x >> "icon"))];} foreach ["n_service"];
_text = _text + " Storage<br/>";
};
case "Hotkeys": {
_text = _text + "<t size='0.8'>";
_text = _text + "Flip Vehicle/Push Boat: SHIFT + 4<br/>";
_text = _text + "Minefield Creating System: SHIFT  + L<br/>";
_text = _text + "Construction View: SHIFT + C<br/>";
_text = _text + "Talk To Civilians/Soldiers: SHIFT + Y (WEST ONLY)<br/>";
//_text = _text + "Toggle Streetlights: SHIFT + 7<br/>";
_text = _text + "Steal Car/Take Objects: Y<br/>";
_text = _text + "Load Crates to Truck: SHIFT + 9<br/>";
//_text = _text + "Change to Civ: ALT+Y<br/>";
//_text = _text + "(Un)holster pistol (when undercover): CTRL+Y<br/>";
//_text = _text + "Toggle 3D Icons: Shift+U<br/>";
_text = _text + "Use Fist (when unarmed): U<br/>";
_text = _text + "YELL (To make CSAT surrender, when armed): U (WEST ONLY)<br/><br/>";
_text = _text + "See Field-Manual (ESC) or Notes (M) for more info. Also check Important Notes section above.";
_text = _text+ "</t>";
};
case "Important Notes": {
_text = _text + "<t size='0.9'>";
_text = _text + "FOR ADMIN. Mission features own savegame system with more fluent mission loading and performance reseting. Always save your game in WLA-menu or using autosave trough WLA-menu options. The ESC-menu save DONT create my custom savegame file.";
_text = _text + "<br/><br/>To load your mission progress, leave parameter in MP lobby to default position. To start new progress, you need to toggle the setting off in the parameters";
_text = _text+ "<br/><br/>When saving, wait for ""Completed""-hint before exiting the game.</t>";
};
case "Event Log": {
_text = _text + "<t size='0.8'>";
{_text = _text + _x + "|";} foreach (SaOkmissionnamespace getvariable "EventLog");
_text = _text+ "</t>";
};
case "Team-mates": {
_colors = ["<t color='#0000FF'>","<t color='#00FF00'>","<t color='#990000'>","<t color='#990099'>","<t color='#99FFFF'>","<t color='#CCFF00'>","<t color='#FF0000'>","<t color='#CCFFFF'>","<t color='#FFFF00'>","<t color='#FF0033'>"];
{
_unit = _x;
_text = _text + (rank _x)+" "+(name _x) + " " + "<t size='0.8'>";
{
_v = (_unit skill _x);
_v = [_v,1] CALL BIS_fnc_cutDecimals;
_text = _text + (_colors select _foreachIndex) +format ["%1",_v] +"</t>" +"|";
} foreach ["general","commanding","reloadSpeed","courage","spotTime","spotDistance","endurance","aimingSpeed","aimingShake","aimingAccuracy"];
_text = _text + "</t>" + "<br/>";
} foreach units group player - [player];
_text = _text + "<br/>" + "<t size='0.7'>";
{_text = _text + (_colors select _foreachIndex) + _x+ "</t>" +"|";} foreach ["general","commanding","reloadSpeed","courage","spotTime","spotDistance","endurance","aimingSpeed","aimingShake","aimingAccuracy"];
_text = _text+ "</t>";
};
};
_myDisplay = findDisplay 32144;
(_myDisplay displayCtrl 1100) ctrlSetStructuredText parseText _text;
};

if (isServer) then {
SaOkmissionnamespace setvariable ["EventLog",[],true];
};
SAOKEVENTLOG = {
private ["_old","_text","_log","_time"];
_old = (SaOkmissionnamespace getvariable "EventLog");
if (count _old > 20) then {_old = [_old,((count _old) - 1)] call BIS_fnc_removeIndex;};
_text = _this select 0;
_time = _this select 1;
_log = (format ["%1:%2 ",_time select 3,_time select 4]) + _text; 
SaOkmissionnamespace setvariable ["EventLog",(_old+[_log]),true];
};



//[] SPAWN {_function = missionnamespace getvariable "SAOKCOMINGCHAP";_n = [0,1,"CSAT AIR OPERATION","CSAT Fighters Seen Leaving Stratis"] SPAWN _function;};
SAOKCOMINGCHAP = {
private ["_m","_h","_d","_name","_dateThen","_log"];
_h = _this select 0;
_m = _this select 1;
_name = _this select 2;
_dateThen = date;
_d = 0;
_m = (_dateThen select 4) + _m;
_h = (_dateThen select 3) + _h;
_d = (_dateThen select 2);
if (_m > 59) then {_m = _m - 60;_h = _h + 1;};
if (_h > 23) then {_h = _h - 24;_d = _d + 1;};
_dateThen set [4,_m];
_dateThen set [3,_h];
_dateThen set [2,_d];
SaOkmissionnamespace setvariable ["ComingChapters",((SaOkmissionnamespace getvariable "ComingChapters")+[[_name,_dateThen]]),true];
_log = if (count _this > 3) then {_this select 3} else {("New chapter coming at "+(format ["%1:%2 ",_dateThen select 3,_dateThen select 4]))};
[_log, date] CALL SAOKEVENTLOG;
};

SAOKTRIGGETCHAP = {
private ["_ar","_t","_forEachIndex"];
_ar = (SaOkmissionnamespace getvariable "ComingChapters");
{
_t = _x select 1;
if (dateToNumber date > dateToNumber _t) exitWith {
(_x select 0) SPAWN SAOKCHAPTERADD;
_ar = [_ar,_forEachIndex] call BIS_fnc_removeIndex;
SaOkmissionnamespace setvariable ["ComingChapters",_ar,true];
};
} foreach _ar;
};

SAOKCL1 = {
private ["_t","_nameA","_f"];
_t = getText(configfile >> (_this select 0) >> (_this select 1) >> "displayName");
_nameA = toArray (_this select 1);
if (count _nameA > 1) then {
_f = [_nameA select 0, _nameA select 1];
_f = toString _f;
if (_f in ["B_","I_","O_","b_","i_","o_"]) then {
_nameA = toArray _f;
_f = [_nameA select 0];
_f = toString _f;
_t = _t + " ("+_f+")";
};
};
_t
};

SA_TASK1 = compile preprocessfileLineNumbers "VillageTasks\TaskFindRes.sqf";
SA_TASK2 = compile preprocessfileLineNumbers "VillageTasks\TaskCrate.sqf";
SA_TASK3 = compile preprocessfileLineNumbers "VillageTasks\TaskWater.sqf";
SA_TASK4 = compile preprocessfileLineNumbers "VillageTasks\TaskCivPOW.sqf";
SA_TASK5 = compile preprocessfileLineNumbers "VillageTasks\TaskEscort.sqf";
SA_TASK6 = compile preprocessfileLineNumbers "VillageTasks\TaskRepair.sqf";
SA_TASK7 = compile preprocessfileLineNumbers "VillageTasks\TaskFortress.sqf";
SA_TASK8 = compile preprocessfileLineNumbers "VillageTasks\TaskGuardPost.sqf";


SA_TASKM1 = compile preprocessfileLineNumbers "MilitaryTasks\TaskFindOfficer.sqf";
SA_TASKM2 = compile preprocessfileLineNumbers "MilitaryTasks\TaskKillOfficer.sqf";
SA_TASKM3 = compile preprocessfileLineNumbers "MilitaryTasks\TaskCreateGuardpost.sqf";
SA_TASKM4 = compile preprocessfileLineNumbers "MilitaryTasks\TaskConvoy.sqf";
SA_TASKM5 = compile preprocessfileLineNumbers "MilitaryTasks\TaskZone.sqf";
SA_TASKM6 = compile preprocessfileLineNumbers "MilitaryTasks\TaskAttackCamp.sqf";
SA_TASKM7 = compile preprocessfileLineNumbers "MilitaryTasks\TaskGuardRoadBlock.sqf";

SA_TASKP1 = compile preprocessfileLineNumbers "PowInfo\InfoNothing.sqf";
SA_TASKP2 = compile preprocessfileLineNumbers "PowInfo\InfoCrate.sqf";
SA_TASKP3 = compile preprocessfileLineNumbers "PowInfo\InfoNothing.sqf";

SA_TASKS1 = compile preprocessfileLineNumbers "MainTasks\BrokenTruck.sqf";
SA_TASKS2 = compile preprocessfileLineNumbers "MainTasks\HiddenEnemyVeh.sqf";
SA_TASKS3 = compile preprocessfileLineNumbers "MainTasks\AAVehicle.sqf";

SAOKSTARTTASK = {
switch (_this select 0) do {
case "MainTasks\BrokenTruck.sqf": {_n = ["MainTasks\BrokenTruck.sqf"] SPAWN SA_TASKS1;waitUntil {sleep 30; scriptdone _n};};
case "MainTasks\HiddenEnemyVeh.sqf": {_n = ["MainTasks\HiddenEnemyVeh.sqf"] SPAWN SA_TASKS2;waitUntil {sleep 30; scriptdone _n};};
case "MainTasks\AAVehicle.sqf": {_n = ["MainTasks\AAVehicle.sqf"] SPAWN SA_TASKS3;waitUntil {sleep 30; scriptdone _n};};

case "PowInfo\InfoNothing.sqf": {["PowInfo\InfoNothing.sqf"] SPAWN SA_TASKP1;};
case "PowInfo\InfoCrate.sqf": {["PowInfo\InfoCrate.sqf"] SPAWN SA_TASKP2;};
case "PowInfo\InfoDepot.sqf": {["PowInfo\InfoDepot.sqf"] SPAWN SA_TASKP3;};

case "MilitaryTasks\TaskFindOfficer.sqf": {["MilitaryTasks\TaskFindOfficer.sqf"] SPAWN SA_TASKM1;};
case "MilitaryTasks\TaskKillOfficer.sqf": {["MilitaryTasks\TaskKillOfficer.sqf"] SPAWN SA_TASKM2;};
case "MilitaryTasks\TaskCreateGuardpost.sqf": {["MilitaryTasks\TaskCreateGuardpost.sqf"] SPAWN SA_TASKM3;};
case "MilitaryTasks\TaskConvoy.sqf": {["MilitaryTasks\TaskConvoy.sqf"] SPAWN SA_TASKM4;};
case "MilitaryTasks\TaskZone.sqf": {["MilitaryTasks\TaskZone.sqf"] SPAWN SA_TASKM5;};
case "MilitaryTasks\TaskAttackCamp.sqf": {["MilitaryTasks\TaskAttackCamp.sqf"] SPAWN SA_TASKM6;};
case "MilitaryTasks\TaskGuardRoadBlock.sqf": {["MilitaryTasks\TaskGuardRoadBlock.sqf"] SPAWN SA_TASKM7;};

case "VillageTasks\TaskFindRes.sqf": {[] SPAWN SA_TASK1;};
case "VillageTasks\TaskCrate.sqf": {["VillageTasks\TaskCrate.sqf"] SPAWN SA_TASK2;};
case "VillageTasks\TaskWater.sqf": {["VillageTasks\TaskWater.sqf"] SPAWN SA_TASK3;};
case "VillageTasks\TaskCivPOW.sqf": {["VillageTasks\TaskCivPOW.sqf"] SPAWN SA_TASK4;};
case "VillageTasks\TaskEscort.sqf": {["VillageTasks\TaskEscort.sqf"] SPAWN SA_TASK5;};
case "VillageTasks\TaskRepair.sqf": {["VillageTasks\TaskRepair.sqf"] SPAWN SA_TASK6;};
case "VillageTasks\TaskFortress.sqf": {["VillageTasks\TaskFortress.sqf"] SPAWN SA_TASK7;};
case "VillageTasks\TaskGuardPost.sqf": {["VillageTasks\TaskGuardPost.sqf"] SPAWN SA_TASK8;};
};
};



if (isClass(configFile >> "cfgSounds" >> "cow1")) then {
SAOKANIMALVOICES = {
private ["_f"];
_f = {
private ["_animal","_c","_listA","_voice"];
_listA = (getposATL player) nearEntities [["Fin_random_F","Alsatian_Random_F","Sheep_random_F","Cock_random_F","Goat_random_F"],35];
_c = count _listA - 1;
if (_c < 0) exitWith {};
for "_i" from 0 to _c do {
_animal = _listA select _i;
if (player distance _animal < 10 && {random 1 < 0.2}) then {
_voice = ["barking1","barking1","barking2","barking3","barking4","barking5"] call BIS_fnc_selectRandom;
if (typeof _animal iskindof "WildBoar") then {_voice = ["boar1","boar1","boar2","boar3","boar4"] call BIS_fnc_selectRandom;};
if (typeof _animal iskindof "Cock_random_F") then {_voice = ["Chicken1","Rooster1","Rooster2","Rooster3","Rooster4","Rooster5"] call BIS_fnc_selectRandom;};
if (typeof _animal iskindof "Sheep_random_F" || {typeof _animal iskindof "Goat_random_F"} || {typeof _animal iskindof "Sheep"} || {typeof _animal iskindof "Goat"}) then {_voice = ["Goat1","Goat2","Goat3","Goat4","Goat5","Goat6","Goat7"] call BIS_fnc_selectRandom;};
_voice = [_animal, _voice] CALL FUNKTIO_ECHO;
//player say3d "Goat1";
if (alive player) then {_animal say3d _voice;};
}; 
sleep (random 0.5);
};
};
while {true} do {
sleep (3+random 5);
if (vehicle player == player) then {
[] SPAWN _f;
};
};
};
[] SPAWN SAOKANIMALVOICES;
};

//["EAST","A",7] SPAWN SAOKMOREVEHZONES;

SAOKMOREVEHZONES = {
private ["_vB","_vA","_atyp","_side","_type","_amount","_center","_center2","_c","_m","_star","_n","_ar"];
_side = _this select 0;
_type = _this select 1;
_amount = _this select 2;
_center2 = if (count _this > 3) then {_this select 3} else {getposATL vehicle (([] CALL AllPf) call RETURNRANDOM)};
_vA = 10000;_vB = 2000;
if (count _this > 3) then {_vA = 500;_vB = 40;};
_c = "R";
switch (_side) do {
case "WEST": {_c = "U"};
case "GREEN": {_c = "N";};
case "RES": {_c = "L";};
};
//_center
_atyp = "(1 + meadow) * (1 - sea)";
if (_type in ["P","C","B"]) then {_atyp = "(1 + sea)";};
_center = [_center2,_vA,_vB,_atyp] CALL SAOKSEEKPOS;
if (_type in ["P","C","B"]) then {
while {!surfaceisWater _center} do {sleep 0.1;_center = [_center2,_vA,_vB,_atyp] CALL SAOKSEEKPOS;};
} else {
while {surfaceisWater _center} do {sleep 0.1;_center = [_center2,_vA,_vB,_atyp] CALL SAOKSEEKPOS;};
};
_m = _amount * 500;
while {_amount > 0} do {
sleep 0.1;
_amount = _amount - 1;
_star = [_center,_m,0,"(1 + meadow) * (1 - sea)"] CALL SAOKSEEKPOS;
_ar = [_c,_type,_star];
if (count _this > 4) then {_ar = _ar + ["NOMOVE"];};
_n = _ar SPAWN CVZ;
};
};

SAOKMOREVEHZONESC = {
private ["_vB","_vA","_atyp","_side","_type","_amount","_center","_center2","_c","_m","_star","_n","_ar","_zones"];
_side = _this select 0;
_type = _this select 1;
_amount = _this select 2;
_center2 = if (count _this > 3) then {_this select 3} else {getposATL vehicle (([] CALL AllPf) call RETURNRANDOM)};
_vA = 10000;_vB = 2000;
if (count _this > 3) then {_vA = 500;_vB = 40;};
_c = "R";
switch (_side) do {
case "WEST": {_c = "U"};
case "GREEN": {_c = "N";};
case "RES": {_c = "L";};
};
//_center
_atyp = "(1 + meadow) * (1 - sea)";
if (_type in ["P","C","B"]) then {_atyp = "(1 + sea)";};
_center = [_center2,_vA,_vB,_atyp] CALL SAOKSEEKPOS;
if (_type in ["P","C","B"]) then {
while {!surfaceisWater _center} do {sleep 0.1;_center = [_center2,_vA,_vB,_atyp] CALL SAOKSEEKPOS;};
} else {
while {surfaceisWater _center} do {sleep 0.1;_center = [_center2,_vA,_vB,_atyp] CALL SAOKSEEKPOS;};
};
_m = _amount * 500;
_zones = [];
while {_amount > 0} do {
sleep 0.1;
_amount = _amount - 1;
_star = [_center,_m,0,"(1 + meadow) * (1 - sea)"] CALL SAOKSEEKPOS;
_ar = [_c,_type,_star];
if (count _this > 4) then {_ar = _ar + ["NOMOVE"];};
_n = _ar CALL CVZC;
_zones pushBack _n;
};
_zones
};


SAOKRETURNDEFENSES = {
private ["_t","_g","_u","_post"];
_t = "";
_g = [];
_u = [0,0];
{if (_x distance _this < 500 && {getmarkercolor (_x getvariable "Gmark") == "ColorGreen"}) then {_g pushBack _x;};} foreach GuardPosts;
{
_post = _x;
_u set [0, (_u select 0)+(count (_post getvariable "StaticW"))];
{
if (!isNil{_post getvariable _x}) then {_u set [1, (_u select 1)+1];};
} foreach ["MG-Guard","AA-Guard","AT-Guard","Sniper-Guard","Medic-Guard"];
} foreach _g;
if (count _g > 0) then {_t = _t + format ["Extra %1 Posts<br/>(with ",count _g];};
if ((_u select 0) == 0 && {(_u select 1) == 0}) then {_t = "Low";};
if ((_u select 0) > 0) then {_t = _t + format ["%1 Static",(_u select 0)];};
if ((_u select 0) > 0 && {(_u select 1) > 0}) then {_t = _t + "|";};
if ((_u select 1) > 0) then {_t = _t + format ["%1 Men",(_u select 1)];};
if ((_u select 0) > 0 || {(_u select 1) > 0}) then {_t = _t + ")";};
_t
};

SAOKISCAMPDANGER = {
private ["_bol","_mar"];
_bol = false; 
_mar = format ["Camp%1",_this];
if (_mar in allMapMarkers) then {_bol = true;};
_bol
};

SAOKISCAMPOK = {
private ["_camp","_c","_n"];
_c = count _this - 1;
if (_c < 0) exitWith {};
_n = (SaOkmissionnamespace getvariable "SaOkCautionCamps");
for "_i" from 0 to _c do {
_camp = _this select _i;
if ({getmarkercolor _x == "ColorRed" && {!(getmarkertype _x in ["o_naval","o_art","o_mortar"])} && {getmarkerpos _x distance getmarkerpos _camp < 1000}} count VEHZONESA == 0) then {deletemarker _camp;_n = _n - [_camp];};
sleep 0.1;
};
SaOkmissionnamespace setvariable ["SaOkCautionCamps",_n,true];
};

// (SaOkmissionnamespace getvariable "SaOkCautionCamps") SPAWN SAOKISCAMPOK;
if (isServer) then {
SaOkmissionnamespace setvariable ["SaOkCautionCamps",[],true];
};
SAOKCAMPSINDANGER = {
private ["_c","_m","_mar","_mar2"];
_c = count _this - 1;
if (_c < 0) exitWith {};
for "_i" from 0 to _c do {
_m = _this select _i;
_mar = format ["Camp%1",_m];
if !(_mar in allMapMarkers) then {
_mar2 = createMarker [_mar,getmarkerpos _m];
_mar2 setMarkerShape "ELLIPSE";
_mar2 setMarkerAlpha 0.25;
_mar2 setMarkerBrush "SolidBorder";
_mar2 setMarkerSize [1000,1000];
_mar2 setMarkerDir 0;
_mar2 setMarkerText "";
_mar2 setMarkerColor "ColorOrange"; 
SaOkmissionnamespace setvariable ["SaOkCautionCamps",((SaOkmissionnamespace getvariable "SaOkCautionCamps") + [_mar]),true];
};
sleep 0.1;
};
};

//["WEST","P",4] SPAWN SAOKMOREVEHZONES;["WEST","C",4] SPAWN SAOKMOREVEHZONES;["WEST","T",4] SPAWN SAOKMOREVEHZONES;["WEST","T",4] SPAWN SAOKMOREVEHZONES;[""] SPAWN SAOKCSATTOWARDCAMP; [] SPAWN SAOKCSATTOWARDCAMP;
SAOKNOTCSATFACTORY = {

private ["_Mp","_nGp","_ar"];
_ar = [];
{_Mp = getmarkerpos _x; _nGp = ([_Mp] CALL NearestGuardPost); if (!isNil{_nGp getvariable "Gmark"} && {(getmarkercolor (_nGp getvariable "Gmark")) == "ColorRed"} && {_nGp distance _Mp < 150}) then {} else {
if (_Mp distance getmarkerpos (["ColorRed",_Mp] CALL NEARESTCAMP) < _Mp distance getmarkerpos (["ColorBlue",_Mp] CALL NEARESTCAMP)) then {
_ar set [count _ar, _x];
};
};} foreach FacMarkers;
_ar
};

SAOKCSATFACTORIES = {

private ["_Mp","_nGp","_ar"];
_ar = [];
{_Mp = getmarkerpos _x; _nGp = ([_Mp] CALL NearestGuardPost); if (!isNil{_nGp getvariable "Gmark"} && {(getmarkercolor (_nGp getvariable "Gmark")) == "ColorRed"} && {_nGp distance _Mp < 150}) then {_ar pushBack _x;};} foreach FacMarkers;
_ar
};

SAOKCSATTAKEFACTORY = {

private ["_nul","_d","_start","_s","_b","_xx","_mP","_max","_p","_tar","_wp","_ma","_t","_c","_ar","_er"];
_ar = [] CALL SAOKNOTCSATFACTORY;
_er = [];
_b = 0;
if (count _ar > 0) then {
_c = count _ar - 1; 
for "_i" from 0 to _c do {
_xx = _ar select _i;
_mP = getmarkerpos _xx;
if ({_mP distance getmarkerpos _x < 500 && {getmarkercolor _x == "ColorRed"}} count VEHZONESA > 0) then {
if (getmarkercolor _xx  == "ColorGreen") then {
if (!(_xx in AMBbattles) && {count AMBbattles < 3}) then {
_nul = [_xx] SPAWN FDefendFactory;AMBbattles pushBack _xx;
};
} else {
if ({_mP distance getmarkerpos _x < 500 && {getmarkercolor _x in ["ColorBlue","ColorGreen"]}} count VEHZONESA == 0 && {_mP distance ([_mP,"ColorRed"] CALL NEARESTGUARDPOST) > 400}) then {
_start = [getmarkerpos _xx, 100,0,"(1 - sea) * (1 + meadow)* (1 - hills)",150] CALL SAOKSEEKPOS;
_d = 100;
_s = (15+random 25);
sleep 0.1;
while {!([_start,_s] CALL SAOKISFLAT)} do {
_d = _d + 2;
_start = [getmarkerpos _xx, _d,0,"(1 - sea) * (1 + meadow)* (1 - hills)",150] CALL SAOKSEEKPOS;
sleep 0.2;
};
_nul = [_start,"",_s] SPAWN CreateRoadBlock;
};
};
_b = 1;} else {_er pushBack _xx;};
};
if (_b == 0 && {count _er > 0}) then {
_t = 0;
_ma = 0;
while {_ma < 5} do {
_ma = _ma + 1;
_p = VEHZONES call RETURNRANDOM; 
_max = 0;
while {_max < 7 && {(getmarkercolor _p != "ColorRed" || {getmarkertype _p in ["o_naval","o_art","o_mortar"]}) || {_p call SAOKVZMOVING}}} do {sleep 0.1;_max = _max + 1; _p = VEHZONES call RETURNRANDOM;};
if (_max < 7) then {
_tar = _er call RETURNRANDOM;  
_wp = [getmarkerpos _tar,300,40,"(1 + meadow) * (1 - sea)"] CALL SAOKSEEKPOS;  
[_p,["o_air","o_uav","o_plane"],_wp] SPAWN SAOKFINDROUTEANDMOVE;
};
sleep 0.1;
};

};
};
};

//[_p,(_dt select 3),_wp] SPAWN SAOKFINDROUTEANDMOVE;
SAOKFINDROUTEANDMOVE = {
private ["_done","_ap","_ap2","_ap3","_p","_dt","_wp"];
_p = _this select 0;
_dt = _this select 1;
_wp = _this select 2;
if (isNil"_wp" || {typename _wp != "ARRAY"} || {count _wp < 2} || {_wp distance [0,0,0] < 40}) exitWith {};
if (getmarkertype _p in _dt || {!([getmarkerpos _p,_wp] CALL SAOKWATERBETWEEN)}) then {
[_p, _wp] SPAWN ZoneMove;
} else {
_ap = getmarkerpos "Help1";
_ap = [(_ap select 0)+200 - random 400, (_ap select 1)+200 - random 400,0];
_ap2 = getmarkerpos "Help2";
_ap2 = [(_ap2 select 0)+200 - random 400, (_ap2 select 1)+200 - random 400,0];
sleep 0.1;
_done = 0;
if (_done == 0 && {{_x distance _ap > _x distance _ap2} count [getmarkerpos _p,_wp] == 0} && {!([getmarkerpos _p,_ap] CALL SAOKWATERBETWEEN)} && {!([_wp,_ap] CALL SAOKWATERBETWEEN)}) then {
[_p, _ap] SPAWN ZoneMove;sleep 0.2;
[_p, _wp] SPAWN ZoneMove;
_done = 1;
}; 
if (_done == 0 && {!([getmarkerpos _p,_ap] CALL SAOKWATERBETWEEN)} && {!([_wp,_ap2] CALL SAOKWATERBETWEEN)}) then {
[_p, _ap] SPAWN ZoneMove;sleep 0.2;
[_p, _ap2] SPAWN ZoneMove;sleep 0.2;
[_p, _wp] SPAWN ZoneMove;
_done = 1;
}; 
sleep 0.1;
if (_done == 0 && {!([getmarkerpos _p,_ap2] CALL SAOKWATERBETWEEN)} && {!([_wp,_ap] CALL SAOKWATERBETWEEN)}) then {
[_p, _ap2] SPAWN ZoneMove;sleep 0.2;
[_p, _ap] SPAWN ZoneMove;sleep 0.2;
[_p, _wp] SPAWN ZoneMove;
_done = 1;
}; 
if (_done == 0 && {getmarkerpos "Help5" distance _x < 2000} count [getmarkerpos _p,_wp] > 0) then {
_done = 1;
//ALL WEST SIDE
if ({_ap2 distance _x > _ap distance _x} count [getmarkerpos _p,_wp] == 0) then {
_ap = getmarkerpos "Help5";
_ap = [(_ap select 0)+50 - random 100, (_ap select 1)+50 - random 100,0];
_ap2 = getmarkerpos "Help3";
_ap2 = [(_ap2 select 0)+200 - random 400, (_ap2 select 1)+200 - random 400,0];
if (getmarkerpos _p distance _ap < _wp distance _ap) then {
if ([getmarkerpos _p,_ap2] CALL SAOKWATERBETWEEN && {!([_wp,_ap] CALL SAOKWATERBETWEEN)}) then {
[_p, _ap] SPAWN ZoneMove;sleep 0.2;
[_p, _ap2] SPAWN ZoneMove;
} else {[_p, _ap2] SPAWN ZoneMove;};
} else {
[_p, _ap2] SPAWN ZoneMove;sleep 0.2;
[_p, _ap] SPAWN ZoneMove;
};
} else {
_ap = getmarkerpos "Help1";
_ap = [(_ap select 0)+200 - random 400, (_ap select 1)+200 - random 400,0];
_ap2 = getmarkerpos "Help2";
_ap2 = [(_ap2 select 0)+200 - random 400, (_ap2 select 1)+200 - random 400,0];
_ap3 = getmarkerpos "Help3";
_ap3 = [(_ap2 select 0)+100 - random 200, (_ap2 select 1)+100 - random 200,0];
if (!([getmarkerpos _p,_ap] CALL SAOKWATERBETWEEN) && {!([_wp,_ap2] CALL SAOKWATERBETWEEN)}) then {
[_p, _ap] SPAWN ZoneMove;sleep 0.2;
[_p, _ap2] SPAWN ZoneMove;sleep 0.2;
[_p, _ap3] SPAWN ZoneMove;
}; 
};
};
if (_done == 0 && {getmarkerpos "Help4" distance _x < 2000} count [getmarkerpos _p,_wp] > 0) then {
//ALL WEST SIDE
if ({_ap2 distance _x > _ap distance _x} count [getmarkerpos _p,_wp] == 0) then {
_ap = getmarkerpos "Help4";
_ap = [(_ap select 0)+50 - random 100, (_ap select 1)+50 - random 100,0];
_ap2 = getmarkerpos "Help3";
_ap2 = [(_ap2 select 0)+200 - random 400, (_ap2 select 1)+200 - random 400,0];
if (getmarkerpos _p distance _ap < _wp distance _ap) then {
if ([getmarkerpos _p,_ap2] CALL SAOKWATERBETWEEN && {!([_wp,_ap] CALL SAOKWATERBETWEEN)}) then {
[_p, _ap] SPAWN ZoneMove;sleep 0.2;
[_p, _ap2] SPAWN ZoneMove;
} else {[_p, _ap2] SPAWN ZoneMove;};
} else {
[_p, _ap2] SPAWN ZoneMove;sleep 0.2;
[_p, _ap] SPAWN ZoneMove;
};
} else {
_ap = getmarkerpos "Help1";
_ap = [(_ap select 0)+200 - random 400, (_ap select 1)+200 - random 400,0];
_ap2 = getmarkerpos "Help2";
_ap2 = [(_ap2 select 0)+200 - random 400, (_ap2 select 1)+200 - random 400,0];
_ap3 = getmarkerpos "Help3";
_ap3 = [(_ap2 select 0)+100 - random 200, (_ap2 select 1)+100 - random 200,0];
if (!([getmarkerpos _p,_ap] CALL SAOKWATERBETWEEN) && {!([_wp,_ap2] CALL SAOKWATERBETWEEN)}) then {
[_p, _ap] SPAWN ZoneMove;sleep 0.2;
[_p, _ap2] SPAWN ZoneMove;sleep 0.2;
[_p, _ap3] SPAWN ZoneMove;
}; 
};
};
};
};

SAOKNEARVZNUM = {
private ["_cen","_col","_count"];
_cen = _this select 0;
_col = _this select 1;
_count = {getmarkercolor _x == _col && {getmarkerpos _x distance _cen < 1000}} count VEHZONESA;
_count
};
// {if (_x call SAOKVZMOVING) then {_x call SAOKVZMOVESTOP;};} foreach VEHZONESA;

SAOKVZMOVESTOP = {

private ["_n"];
_n = _this CALL SAOKZONEM;
};

SAOKVZMOVING = {
private ["_bol"];
_bol = true; 
if ({_this == _x select 0} count ZONEMS == 0 || {count (_this CALL SAOKZONEMW) == 0}) then {_bol = false;};
_bol
};

SAOKOUTOFMAP = {
private ["_bol"];
_bol = false;
if ({_x > SAOKMAPSIZE || {_x < 0}} count _this > 0) then {_bol = true;};
_bol
};
SAOKBISCHECK = {
private ["_bol","_a","_s"];
_bol = false;
_a = toArray (str _this);
if (count _a > 2) then {_s = toString [_a select 0,_a select 1,_a select 2];if (_s == "BIS") then {_bol = true;};};
_bol
};

SAOKCSATTOWARDCAMP = {
private ["_dt","_v","_n","_p","_tar","_wp","_ar","_flm"];
if (count VEHZONES == 0 || {!isNil"NOCSATATTACKS"}) exitWith {};
_v = + VEHZONES;  
_n = 10*DIFLEVEL;  
while {_n > 0 && {count _v > 0}} do {  
_n = _n - 1;  
_p = _v call RETURNRANDOM;  
_v = _v - [_p]; 
_dt = ["ColorRed","ColorRed","ColorBlue",["o_air","o_uav","o_plane"]];
if (count _this > 0) then {_dt = ["ColorBlue","ColorGreen","ColorRed",["b_air","b_uav","b_plane","i_air","i_uav","i_plane"]];};
if (!(getmarkertype _p in ["b_naval","o_naval","n_naval","o_art","o_mortar","o_support","b_art","b_mortar","b_support","o_med","b_med","i_med"]) && {getmarkercolor _p == (_dt select 0)} && {getmarkerpos _p distance getmarkerpos ([(_dt select 2),getmarkerpos _p] CALL NEARESTCAMP) > 800} && {!(_p CALL SAOKVZMOVING)}) then {  
_tar = [([(_dt select 2),getmarkerpos _p] CALL NEARESTCAMP)]; 
{if (getmarkercolor _x ==  (_dt select 2) && {getmarkerpos _x distance getmarkerpos _p < 8000} && {[getmarkerpos _x,"ColorRed"] CALL SAOKNEARVZNUM < 3}) then {_tar pushBack _x;};} foreach AmbientZonesN;
_tar = _tar call RETURNRANDOM;  
_wp = [getmarkerpos _tar,700,40,"(1 + meadow) * (1 - sea)"] CALL SAOKSEEKPOS;  
if (getmarkertype _p in (_dt select 3) && {random 1 < 0.3}) then {
_tar = ([getmarkerpos _p,(_dt select 1)] CALL NEARESTAIRFIELD);  
if (getmarkercolor _tar == (_dt select 0)) then {
_wp = [getmarkerpos _tar,100,0,"(1 - sea)"] CALL SAOKSEEKPOS;  
};
};
[_p,(_dt select 3),_wp] SPAWN SAOKFINDROUTEANDMOVE;
} else {
if !(_p CALL SAOKVZMOVING) then {
if (getmarkertype _p in ["o_naval"]) then {
_wp = [getmarkerpos _p,1000,50,"(1 - sea)"] CALL SAOKSEEKPOS;  
if (surfaceiswater _wp && {!(_wp call SAOKOUTOFMAP)} && {!([getmarkerpos _p,_wp] CALL SAOKLANDBETWEEN)}) then {[_p, _wp] SPAWN ZoneMove;};
};
if (getmarkertype _p in ["o_support","o_med"]) then {
_ar = [] CALL SAOKCSATFACTORIES;
if (random 1 < 0.5) then {
{if ((getmarkerpos _x) distance (getmarkerpos _p) < 5000 && {getmarkercolor _x == "ColorRed"}) then {_ar pushBack _x;};} foreach AmbientZonesN;
} else {
{if (_x distance (getmarkerpos _p) < 5000 && {getmarkercolor (_x getvariable "Gmark") == "ColorRed"}) then {_ar pushBack _x;};} foreach GuardPosts;
};
_wp = _ar call RETURNRANDOM;
if (!isNil"_wp" && {typename _wp != "ARRAY"}) then {
if (typename _wp == "STRING") then {_wp = getmarkerpos _wp;} else {_wp = getposATL _wp};
};
if (!isNil"_wp" && {typename _wp == "ARRAY"} && {count _wp > 1}) then {
_wp = [_wp,100,0,"(1 - sea)"] CALL SAOKSEEKPOS;  
[_p,[],_wp] SPAWN SAOKFINDROUTEANDMOVE;
};
};
if (getmarkertype _p in ["o_art","o_mortar"]) then {
_flm = _p CALL SAOKNEARESTFL;
if (!isNil"_flm" && {typename _flm == "STRING"} && {_flm != ""}) then {_wp = [getmarkerpos _flm,100,0,"(1 - sea)"] CALL SAOKSEEKPOS; [_p,[],_wp] SPAWN SAOKFINDROUTEANDMOVE;};
};

};
};
sleep 1;  
};
};

SAOKNUMTOROMAN = {
private ["_num","_a"];
_num = _this;
_a = "";
while {_num > 1000} do {_num = _num - 1000; _a = _a + "M";};
while {_num > 500} do {_num = _num - 500; _a = _a + "D";};
while {_num > 100} do {_num = _num - 100; _a = _a + "C";};
while {_num > 50} do {_num = _num - 50; _a = _a + "L";};
while {_num > 10} do {_num = _num - 10; _a = _a + "X";};
switch _num do {
case 1: {_num = "I";};
case 2: {_num = "II";};
case 3: {_num = "III";};
case 4: {_num = "IV";};
case 5: {_num = "V";};
case 6: {_num = "VI";};
case 7: {_num = "VII";};
case 8: {_num = "VIII";};
case 9: {_num = "IX";};
case 10: {_num = "X";};
};
_num = _a + _num;
_num
};

SAOKCHAPTERHINT = {
private ["_disp"];
78 cutRsc ["MyRscTitle10","PLAIN"];
disableSerialization;
_disp = uiNamespace getVariable "d10_MyRscTitle";
(_disp displayCtrl 310) ctrlSetStructuredText parseText ("<t color='#990000'>"+_this+"</t>");
};

SAOKCHAPTERADD = {
private ["_ar","_text"];
_ar = SaOkmissionnamespace getvariable "SaOkChapters";
if (_this in _ar) exitWith {};
_ar pushBack _this;
_this SPAWN SAOKCHAPTEREVENTS;
SaOkmissionnamespace setvariable ["SaOkChapters", _ar,true];
_text = format ["Chapter %1 %2", (count _ar) call SAOKNUMTOROMAN,_this];
_text SPAWN SAOKCHAPTERHINT;
};

SAOKMODTEMP = {
//IFENABLED = nil;
//RHSENABLED = nil;
//IFSOVIET = nil;
CRATECLAS = [
["Box_NATO_Ammo_F","Box_NATO_Wps_F","Box_NATO_Grenades_F","Box_NATO_WpsLaunch_F","Box_NATO_AmmoOrd_F","Box_NATO_WpsSpecial_F"]
,["Box_East_Grenades_F","Box_East_AmmoOrd_F","Box_East_Ammo_F","Box_East_WpsSpecial_F","Box_East_Wps_F"]
,["Box_IND_Ammo_F","Box_IND_Wps_F","Box_IND_Grenades_F","Box_IND_WpsLaunch_F","Box_IND_AmmoOrd_F","Box_IND_WpsSpecial_F"]
,["Box_FIA_Ammo_F","Box_FIA_Wps_F","Box_FIA_Support_F"]
];
switch _this do {
case 0: {
ARMEDVEHICLES = [
["B_MRAP_01_hmg_F","B_MRAP_01_gmg_F","B_APC_Wheeled_01_cannon_F","B_APC_Tracked_01_rcws_F","B_APC_Tracked_01_CRV_F","B_UGV_01_rcws_F"],
["O_APC_Wheeled_02_rcws_F","O_MRAP_02_gmg_F","O_MRAP_02_hmg_F","O_APC_Wheeled_02_rcws_F","O_APC_Tracked_02_cannon_F"],
["I_APC_tracked_03_cannon_F","I_APC_tracked_03_cannon_F","I_MRAP_03_gmg_F","I_MRAP_03_hmg_F","I_APC_Wheeled_03_cannon_F","I_UGV_01_rcws_F"],
["I_G_Offroad_01_armed_F","B_G_Offroad_01_armed_F"]
];

ARMEDTANKS = [
["B_MBT_01_cannon_F","B_MBT_01_TUSK_F"],
["O_MBT_02_cannon_F"],
["I_MBT_03_cannon_F"],
["I_G_Offroad_01_armed_F","B_G_Offroad_01_armed_F"]
];

ARMEDAA = [
["B_APC_Tracked_01_AA_F"],
["O_APC_Tracked_02_AA_F"],
["I_APC_tracked_03_cannon_F"],
["I_G_Offroad_01_armed_F","B_G_Offroad_01_armed_F"]
];

ARMEDCARRIER = [
["B_Truck_01_transport_F","B_Truck_01_covered_F","B_G_Offroad_01_F","B_APC_Tracked_01_rcws_F","B_APC_Wheeled_01_cannon_F"],
["O_APC_Wheeled_02_rcws_F","O_APC_Tracked_02_cannon_F","O_Truck_03_covered_F","O_Truck_03_transport_F","O_Truck_02_covered_F","O_Truck_02_transport_F"],
["I_Truck_02_covered_F","I_Truck_02_transport_F","I_G_Offroad_01_armed_F","I_APC_Wheeled_03_cannon_F","I_MRAP_03_F","I_APC_tracked_03_cannon_F","I_APC_tracked_03_cannon_F","I_MBT_03_cannon_F"],
["B_G_Van_01_transport_F","B_G_Offroad_01_F","I_G_Van_01_transport_F","I_G_Offroad_01_armed_F","I_G_Offroad_01_F"]
];

ARMEDSTATIC = [
["B_static_AT_F","B_static_AA_F","B_HMG_01_F","B_HMG_01_high_F","B_GMG_01_F","B_GMG_01_high_F"],
["O_static_AT_F","O_static_AA_F","O_HMG_01_F","O_HMG_01_high_F","O_GMG_01_F","O_GMG_01_high_F"],
["I_static_AT_F","I_static_AA_F","I_HMG_01_F","I_HMG_01_high_F","I_GMG_01_F","I_GMG_01_high_F"],
["I_static_AT_F","I_static_AA_F","I_HMG_01_F","I_HMG_01_high_F","I_GMG_01_F","I_GMG_01_high_F"]
];

ARMEDSUPPORT = [
["B_Truck_01_ammo_F","B_Truck_01_fuel_F","B_Truck_01_medical_F","B_Truck_01_Repair_F"],
["O_Truck_02_box_F","O_Truck_02_medical_F","O_Truck_02_fuel_F","O_Truck_02_Ammo_F","O_Truck_03_repair_F","O_Truck_03_medical_F","O_Truck_03_fuel_F","O_Truck_03_ammo_F"],
["I_Truck_02_box_F","I_Truck_02_medical_F","I_Truck_02_fuel_F","I_Truck_02_Ammo_F"]
];

CIVVEH = ["C_Van_01_fuel_F","C_SUV_01_F","C_Van_01_box_F","C_Van_01_transport_F","C_Hatchback_01_sport_F","C_Hatchback_01_F","C_Offroad_01_F","C_Quadbike_01_F"];

AIRFIGTHER = [
["B_UAV_02_CAS_F","B_Plane_CAS_01_F"],
["O_UAV_02_F","O_Plane_CAS_02_F"],
["I_Plane_Fighter_03_AA_F","I_Plane_Fighter_03_CAS_F"],
["I_Plane_Fighter_03_AA_F","I_Plane_Fighter_03_CAS_F"]
];

AIRARMCHOP = [
["B_Heli_Attack_01_F","B_Heli_Light_01_armed_F"],
["O_Heli_Attack_02_F","O_Heli_Attack_02_black_F","O_Heli_Light_02_F"],
["I_Heli_light_03_F"],
["I_Heli_light_03_F"]
];
AIRCARRIERCHOP = [
["B_Heli_Transport_01_F","B_Heli_Light_01_F"],
["O_Heli_Light_02_unarmed_F","O_Heli_Light_02_v2_F"],
["I_Heli_Transport_02_F","I_Heli_light_03_unarmed_F"],
["I_Heli_light_03_unarmed_F"]
];
if (isClass(configFile >> "cfgVehicles" >> "B_Heli_Transport_03_F")) then {AIRCARRIERCHOP set [0,(AIRCARRIERCHOP select 0)+["B_Heli_Transport_03_F","B_Heli_Transport_03_unarmed_F"]];};
if (isClass(configFile >> "cfgVehicles" >> "O_Heli_Transport_04_covered_F")) then {AIRCARRIERCHOP set [1,(AIRCARRIERCHOP select 1)+["O_Heli_Transport_04_covered_F","O_Heli_Transport_04_covered_F"]];};

ENEMYC1 = ["O_Soldier_AAR_F","O_Soldier_AAT_F","O_Soldier_A_F","O_Soldier_AR_F","O_medic_F","O_engineer_F","O_soldier_exp_F","O_Soldier_GL_F","O_soldier_M_F","O_Soldier_AT_F","O_officer_F","O_soldier_repair_F","O_Soldier_F","O_Soldier_LAT_F","O_Soldier_lite_F","O_Soldier_SL_F","O_Soldier_TL_F","O_spotter_F","O_sniper_F"];
ENEMYC2 = ["O_recon_exp_F","O_recon_JTAC_F","O_recon_M_F","O_recon_medic_F","O_recon_F","O_recon_LAT_F","O_recon_TL_F"];
ENEMYC3 = ["O_soldierU_A_F","O_soldierU_AAR_F","O_soldierU_AAT_F","O_soldierU_AR_F","O_soldierU_medic_F","O_engineer_U_F","O_soldierU_exp_F","O_SoldierU_GL_F","O_soldierU_M_F","O_soldierU_AT_F","O_soldierU_repair_F","O_soldierU_LAT_F","O_SoldierU_SL_F","O_soldierU_TL_F"];
FRIENDC1 = ["B_soldier_AAR_F","B_soldier_AAA_F","B_soldier_AAT_F","b_sniper_f","b_spotter_f","B_Soldier_A_F","B_soldier_AR_F","B_medic_F","B_engineer_F","B_soldier_exp_F","B_Soldier_GL_F","B_soldier_M_F","B_soldier_AA_F","B_soldier_AT_F","B_soldier_repair_F","B_soldier_repair_F","B_Soldier_F","B_soldier_LAT_F","B_Soldier_lite_F","B_Soldier_SL_F","B_Soldier_TL_F"];
if (isClass(configFile >> "cfgVehicles" >> "AV_IndUs_AR")) then {FRIENDC1 = ["AV_IndUs_medic","AV_IndUs_REP","AV_IndUs_EXP","AV_IndUs_AT","AV_IndUs_Rifleman2","AV_IndUs_Rifleman","AV_IndUs_Rifleman_light","AV_IndUs_SL"];};
FRIENDC2 = ["I_Soldier_AAR_F","I_Soldier_AAA_F","I_Soldier_AAT_F","I_Soldier_A_F","I_Soldier_AR_F","I_medic_F","I_engineer_F","I_Soldier_exp_F","I_Soldier_GL_F","I_Soldier_M_F","I_Soldier_AA_F","I_Soldier_AT_F","I_officer_F","I_Soldier_repair_F","I_soldier_F","I_Soldier_LAT_F","I_Soldier_lite_F","I_Soldier_SL_F","I_Soldier_TL_F","I_Spotter_F","I_Sniper_F"];
FRIENDC3 = ["B_recon_JTAC_F","B_recon_exp_F","B_recon_M_F","B_recon_medic_F","B_recon_F","B_recon_LAT_F","B_recon_TL_F"];
FRIENDC4 = ["I_G_Soldier_A_F","I_G_Soldier_AR_F","I_G_medic_F","I_G_engineer_F","I_G_Soldier_exp_F","I_G_Soldier_GL_F","I_G_Soldier_M_F","I_G_officer_F","I_G_Soldier_F","I_G_Soldier_LAT_F","I_G_Soldier_lite_F","I_G_Soldier_SL_F","I_G_Soldier_TL_F"];

};
case 1: {
ARMEDVEHICLES = [
["RHS_M2A3_BUSKIII","RHS_M2A3_BUSKIII_wd","RHS_M2A3_BUSKI","RHS_M2A3_BUSKI_wd","RHS_M2A3","RHS_M2A3_wd","RHS_M2A2_BUSKI","RHS_M2A2_BUSKI_wd","RHS_M2A2","RHS_M2A2_wd","rhsusf_m113_usarmy","rhsusf_m113d_usarmy"],
["rhs_btr80a_vv","rhs_btr80a_vmf","rhs_btr80a_vdv","rhs_btr80a_msv","rhs_btr80_vv","rhs_btr80_vmf","rhs_btr80_vdv","rhs_btr80_msv","rhs_btr70_vv","rhs_btr70_vmf","rhs_btr70_vdv","rhs_btr70_msv","rhs_btr60_vv","rhs_btr60_vmf","rhs_btr60_vdv","rhs_btr60_msv","rhs_brm1k_vv","rhs_brm1k_vdv","rhs_brm1k_tv","rhs_brm1k_msv","rhs_bmp2d_vmf","rhs_bmp2d_vdv","rhs_bmp2d_vv","rhs_bmp2d_msv","rhs_bmp2d_tv","rhs_bmp2k_vmf","rhs_bmp2k_vdv","rhs_bmp2k_vv","rhs_bmp2k_msv","rhs_bmp2k_tv","rhs_bmp2_vmf","rhs_bmp2_vdv","rhs_bmp2_vv","rhs_bmp2_msv","rhs_bmp2_tv","rhs_bmp2e_vmf","rhs_bmp2e_vdv","rhs_bmp2e_vv","rhs_bmp2e_msv","rhs_bmp2e_tv","rhs_bmp1k_vmf","rhs_bmp1k_vdv","rhs_bmp1k_vv","rhs_bmp1k_msv","rhs_bmp1k_tv","rhs_bmp1k_vmf","rhs_bmp1k_vdv","rhs_bmp1k_vv","rhs_bmp1k_msv","rhs_bmp1k_tv","rhs_bmp1p_vmf","rhs_bmp1p_vdv","rhs_bmp1p_vv","rhs_bmp1p_msv","rhs_bmp1p_tv","rhs_bmp1_vmf","rhs_bmp1_vdv","rhs_bmp1_vv","rhs_bmp1_msv","rhs_bmp1_tv","rhs_bmd4ma_vdv","rhs_bmd4m_vdv","rhs_bmd4_vdv","rhs_bmd2m","rhs_bmd2k","rhs_bmd2","rhs_bmd1r","rhs_bmd1pk","rhs_bmd1p","rhs_bmd1k","rhs_bmd1"],
["I_APC_tracked_03_cannon_F","I_APC_tracked_03_cannon_F","I_MRAP_03_gmg_F","I_MRAP_03_hmg_F","I_APC_Wheeled_03_cannon_F","I_UGV_01_rcws_F"],
["I_G_Offroad_01_armed_F","B_G_Offroad_01_armed_F"]
];

ARMEDTANKS = [
["rhsusf_m1a2sep1tuskid_usarmy","rhsusf_m1a2sep1tuskiwd_usarmy","rhsusf_m1a2sep1d_usarmy","rhsusf_m1a1aimwd_usarmy","rhsusf_m1a1aimd_usarmy","rhsusf_m1a1aim_tuski_wd","rhsusf_m1a1aim_tuski_d","rhsusf_m1a1hc_d"],
["rhs_t80u","rhs_t80bvk","rhs_t80bv","rhs_t80bk","rhs_t80b","rhs_t80a","rhs_t80","rhs_t72bc_tv","rhs_t72bb_tv","rhs_t72ba_tv","rhs_sprut_vdv"],
["I_MBT_03_cannon_F"],
["I_G_Offroad_01_armed_F","B_G_Offroad_01_armed_F"]
];

ARMEDAA = [
["RHS_M6","RHS_M6_wd"],
["rhs_zsu234_aa"],
["I_APC_tracked_03_cannon_F"],
["I_G_Offroad_01_armed_F","B_G_Offroad_01_armed_F"]
];

ARMEDCARRIER = [
["RHS_M2A3_BUSKIII","RHS_M2A3_BUSKIII_wd","RHS_M2A3_BUSKI","RHS_M2A3_BUSKI_wd","RHS_M2A3","RHS_M2A3_wd","RHS_M2A2_BUSKI","RHS_M2A2_BUSKI_wd","RHS_M2A2","RHS_M2A2_wd","rhsusf_m1025_w","rhsusf_m1025_d","rhsusf_m1025_w_s","rhsusf_m1025_w_s","rhsusf_m113_usarmy","rhsusf_m113d_usarmy"],
["rhs_gaz66_vv","rhs_gaz66_vmf","rhs_gaz66_vdv","rhs_gaz66_msv","rhs_gaz66o_vv","rhs_gaz66o_vmf","rhs_gaz66o_vdv","rhs_gaz66o_msv","RHS_Ural_Open_VV_01","RHS_Ural_Open_VMF_01","RHS_Ural_Open_VDV_01","RHS_Ural_Open_MSV_01","RHS_Ural_VV_01","RHS_Ural_VDV_01","RHS_Ural_VMF_01","RHS_Ural_MSV_01","rhs_typhoon_vdv","rhs_typhoon_vdv","rhs_typhoon_vdv","rhs_typhoon_vdv","rhs_tigr_vv","rhs_tigr_vmf","rhs_tigr_vmf","rhs_tigr_vdv","rhs_tigr_msv","rhs_btr80a_vv","rhs_btr80a_vmf","rhs_btr80a_vdv","rhs_btr80a_msv","rhs_btr80_vv","rhs_btr80_vmf","rhs_btr80_vdv","rhs_btr80_msv","rhs_btr70_vv","rhs_btr70_vmf","rhs_btr70_vdv","rhs_btr70_msv","rhs_btr60_vv","rhs_btr60_vmf","rhs_btr60_vdv","rhs_btr60_msv","rhs_brm1k_vv","rhs_brm1k_vdv","rhs_brm1k_tv","rhs_brm1k_msv","rhs_bmp2d_vmf","rhs_bmp2d_vdv","rhs_bmp2d_vv","rhs_bmp2d_msv","rhs_bmp2d_tv","rhs_bmp2k_vmf","rhs_bmp2k_vdv","rhs_bmp2k_vv","rhs_bmp2k_msv","rhs_bmp2k_tv","rhs_bmp2_vmf","rhs_bmp2_vdv","rhs_bmp2_vv","rhs_bmp2_msv","rhs_bmp2_tv","rhs_bmp2e_vmf","rhs_bmp2e_vdv","rhs_bmp2e_vv","rhs_bmp2e_msv","rhs_bmp2e_tv","rhs_bmp1k_vmf","rhs_bmp1k_vdv","rhs_bmp1k_vv","rhs_bmp1k_msv","rhs_bmp1k_tv","rhs_bmp1k_vmf","rhs_bmp1k_vdv","rhs_bmp1k_vv","rhs_bmp1k_msv","rhs_bmp1k_tv","rhs_bmp1p_vmf","rhs_bmp1p_vdv","rhs_bmp1p_vv","rhs_bmp1p_msv","rhs_bmp1p_tv","rhs_bmp1_vmf","rhs_bmp1_vdv","rhs_bmp1_vv","rhs_bmp1_msv","rhs_bmp1_tv","rhs_bmd4ma_vdv","rhs_bmd4m_vdv","rhs_bmd4_vdv","rhs_bmd2m","rhs_bmd2k","rhs_bmd2","rhs_bmd1r","rhs_bmd1pk","rhs_bmd1p","rhs_bmd1k","rhs_bmd1"],
["I_Truck_02_covered_F","I_Truck_02_transport_F","I_G_Offroad_01_armed_F","I_APC_Wheeled_03_cannon_F","I_MRAP_03_F","I_APC_tracked_03_cannon_F","I_APC_tracked_03_cannon_F","I_MBT_03_cannon_F"],
["B_G_Van_01_transport_F","B_G_Offroad_01_F","I_G_Van_01_transport_F","I_G_Offroad_01_armed_F","I_G_Offroad_01_F"]
];

ARMEDSTATIC = [
["B_static_AT_F","B_static_AA_F","B_HMG_01_F","B_HMG_01_high_F","B_GMG_01_F","B_GMG_01_high_F"],
["O_static_AT_F","O_static_AA_F","O_HMG_01_F","O_HMG_01_high_F","O_GMG_01_F","O_GMG_01_high_F"],
["I_static_AT_F","I_static_AA_F","I_HMG_01_F","I_HMG_01_high_F","I_GMG_01_F","I_GMG_01_high_F"],
["I_static_AT_F","I_static_AA_F","I_HMG_01_F","I_HMG_01_high_F","I_GMG_01_F","I_GMG_01_high_F"]
];

ARMEDSUPPORT = [
["B_Truck_01_ammo_F","B_Truck_01_fuel_F","B_Truck_01_medical_F","B_Truck_01_Repair_F"],
["rhs_gaz66_r142_vmf","rhs_gaz66_r142_vmf","rhs_gaz66_r142_vdv","rhs_gaz66_r142_vv","rhs_gaz66_ap2_vdv","rhs_gaz66_ap2_msv","rhs_gaz66_ap2_msv","rhs_gaz66_ap2_vv","rhs_prp3_vv","rhs_prp3_vdv","rhs_prp3_tv","rhs_prp3_msv","rhs_gaz66_repair_msv","rhs_gaz66_repair_vdv","rhs_gaz66_repair_vmf","rhs_gaz66_repair_vv"],
["I_Truck_02_box_F","I_Truck_02_medical_F","I_Truck_02_fuel_F","I_Truck_02_Ammo_F"]
];

CIVVEH = ["RHS_Ural_Open_Civ_02","RHS_Ural_Civ_02","RHS_Ural_Open_Civ_03","RHS_Ural_Civ_03","RHS_Ural_Open_Civ_01","RHS_Ural_Civ_01","C_Van_01_fuel_F","C_SUV_01_F","C_Van_01_box_F","C_Van_01_transport_F","C_Hatchback_01_sport_F","C_Hatchback_01_F","C_Offroad_01_F","C_Quadbike_01_F"];

AIRFIGTHER = [
["rhs_A10"],
["RHS_Su25SM_vvs","RHS_Su25SM_vvsc"],
["I_Plane_Fighter_03_AA_F","I_Plane_Fighter_03_CAS_F"],
["I_Plane_Fighter_03_AA_F","I_Plane_Fighter_03_CAS_F"]
];

AIRARMCHOP = [
["rhs_ah64d_wd","rhs_ah64d"],
["RHS_Mi24V_vvsc","RHS_Mi24P_vvsc","RHS_Mi24V_vvs","RHS_Mi24P_vvs","RHS_Mi24V_vdv","RHS_Mi24P_vdv","RHS_Ka52_vvs","RHS_Ka52_vvsc"],
["I_Heli_light_03_F"],
["I_Heli_light_03_F"]
];
AIRCARRIERCHOP = [
["RHS_UH60M_d","RHS_UH60M","RHS_CH_47F_light","RHS_CH_47F"],
["RHS_Mi8MTV3_vvsc","RHS_Mi8mt_vvsc","RHS_Mi8MTV3_vvs","RHS_Mi8mt_vvs","RHS_Mi8mt_vv","RHS_Mi8MTV3_vdv","RHS_Mi8mt_vdv","RHS_Mi8AMTSh_vvsc","RHS_Mi8AMT_vvsc","RHS_Mi8AMTSh_vvs","RHS_Mi8AMT_vvs","RHS_Mi8AMTSh_vdv","RHS_Mi8AMT_vdv","RHS_Mi24V_vvsc","RHS_Mi24P_vvsc","RHS_Mi24V_vvs","RHS_Mi24P_vvs","RHS_Mi24V_vdv","RHS_Mi24P_vdv","rhs_ka60_grey","rhs_ka60_c"],
["I_Heli_Transport_02_F","I_Heli_light_03_unarmed_F"],
["I_Heli_light_03_unarmed_F"]
];
ENEMYC1 = ["rhs_msv_aa","rhs_msv_engineer","rhs_msv_grenadier","rhs_msv_at","rhs_msv_strelok_rpg_assist","rhs_msv_junior_sergeant","rhs_msv_machinegunner","rhs_msv_machinegunner_assistant","rhs_msv_marksman","rhs_msv_medic","rhs_msv_rifleman","rhs_msv_LAT","rhs_msv_RShG2","rhs_msv_sergeant"];
ENEMYC2 = ["rhs_vdv_aa","rhs_vdv_engineer","rhs_vdv_grenadier","rhs_vdv_at","rhs_vdv_strelok_rpg_assist","rhs_vdv_junior_sergeant","rhs_vdv_machinegunner","rhs_vdv_machinegunner_assistant","rhs_vdv_marksman","rhs_vdv_medic","rhs_vdv_rifleman","rhs_vdv_LAT","rhs_vdv_RShG2","rhs_vdv_sergeant"];
ENEMYC3 = ["rhs_vdv_aa","rhs_vdv_engineer","rhs_vdv_grenadier","rhs_vdv_at","rhs_vdv_strelok_rpg_assist","rhs_vdv_junior_sergeant","rhs_vdv_machinegunner","rhs_vdv_machinegunner_assistant","rhs_vdv_marksman","rhs_vdv_medic","rhs_vdv_rifleman","rhs_vdv_LAT","rhs_vdv_RShG2","rhs_vdv_sergeant"];
FRIENDC1 = ["rhsusf_army_ucp_autorifleman","rhsusf_army_ucp_aa","rhsusf_army_ucp_javelin","rhsusf_army_ucp_engineer","rhsusf_army_ucp_grenadier","rhsusf_army_ucp_machinegunner","rhsusf_army_ucp_machinegunnera","rhsusf_army_ucp_marksman","rhsusf_army_ucp_medic","rhsusf_army_ucp_rifleman","rhsusf_army_ucp_riflemanl","rhsusf_army_ucp_riflemanat","rhsusf_army_ucp_squadleader","rhsusf_army_ucp_teamleader"];
FRIENDC2 = ["I_Soldier_AAR_F","I_Soldier_AAA_F","I_Soldier_AAT_F","I_Soldier_A_F","I_Soldier_AR_F","I_medic_F","I_engineer_F","I_Soldier_exp_F","I_Soldier_GL_F","I_Soldier_M_F","I_Soldier_AA_F","I_Soldier_AT_F","I_officer_F","I_Soldier_repair_F","I_soldier_F","I_Soldier_LAT_F","I_Soldier_lite_F","I_Soldier_SL_F","I_Soldier_TL_F","I_Spotter_F","I_Sniper_F"];
FRIENDC3 = ["rhsusf_army_ocp_aa","rhsusf_army_ocp_javelin","rhsusf_army_ocp_autorifleman","rhsusf_army_ocp_engineer","rhsusf_army_ocp_grenadier","rhsusf_army_ocp_machinegunner","rhsusf_army_ocp_machinegunnera","rhsusf_army_ocp_marksman","rhsusf_army_ocp_medic","rhsusf_army_ocp_rifleman","rhsusf_army_ocp_riflemanl","rhsusf_army_ocp_riflemanat","rhsusf_army_ocp_squadleader","rhsusf_army_ocp_teamleader"];
FRIENDC4 = ["I_G_Soldier_A_F","I_G_Soldier_AR_F","I_G_medic_F","I_G_engineer_F","I_G_Soldier_exp_F","I_G_Soldier_GL_F","I_G_Soldier_M_F","I_G_officer_F","I_G_Soldier_F","I_G_Soldier_LAT_F","I_G_Soldier_lite_F","I_G_Soldier_SL_F","I_G_Soldier_TL_F"];
NORANWEES = true;
RHSENABLED = true;
publicVariable "NORANWEES";
publicVariable "RHSENABLED";
};
case 2: {
"Play as Germans against Soviet" SPAWN HINTSAOK;
lbClear 1503;
lbAdd [1503, "Recon"];
lbSetPicture [1503,0,"\A3\ui_f\data\map\markers\nato\b_recon.paa"];
lbSetTooltip [1503,0,"Lead 5 men team"];
lbSetCurSel [1503, 0];
//1 US 2 GERMAN 3 RUS 4 POLAND
ARMEDVEHICLES = [
["LIB_PzKpfwVI_B","LIB_PzKpfwVI_B","LIB_PzKpfwVI_B_camo","LIB_PzKpfwIV_H","LIB_PzKpfwV","LIB_StuG_III_G","LIB_StuG_III_G_WS","LIB_StuG_III_G","LIB_StuG_III_G_WS","LIB_StuG_III_G","LIB_StuG_III_G_WS"],
["LIB_JS2_43","LIB_JS2_43","LIB_t34_76","LIB_t34_85","LIB_SU85","LIB_t34_76","LIB_t34_85","LIB_t34_76","LIB_t34_85"],
["LIB_PzKpfwVI_B","LIB_PzKpfwVI_B","LIB_PzKpfwVI_B_camo","LIB_PzKpfwIV_H","LIB_PzKpfwV","LIB_StuG_III_G","LIB_StuG_III_G_WS","LIB_StuG_III_G","LIB_StuG_III_G_WS","LIB_StuG_III_G","LIB_StuG_III_G_WS"],
["LIB_PzKpfwVI_B","LIB_PzKpfwVI_B","LIB_PzKpfwVI_B_camo","LIB_PzKpfwIV_H","LIB_PzKpfwV","LIB_StuG_III_G","LIB_StuG_III_G_WS","LIB_StuG_III_G","LIB_StuG_III_G_WS","LIB_StuG_III_G","LIB_StuG_III_G_WS"]
];

ARMEDTANKS = [
["LIB_PzKpfwVI_B","LIB_PzKpfwVI_B","LIB_PzKpfwVI_B_camo","LIB_PzKpfwIV_H","LIB_PzKpfwV","LIB_StuG_III_G","LIB_StuG_III_G_WS","LIB_StuG_III_G","LIB_StuG_III_G_WS","LIB_StuG_III_G","LIB_StuG_III_G_WS"],
["LIB_JS2_43","LIB_JS2_43","LIB_t34_76","LIB_t34_85","LIB_SU85","LIB_t34_76","LIB_t34_85","LIB_t34_76","LIB_t34_85"],
["LIB_PzKpfwVI_B","LIB_PzKpfwVI_B","LIB_PzKpfwVI_B_camo","LIB_PzKpfwIV_H","LIB_PzKpfwV","LIB_StuG_III_G","LIB_StuG_III_G_WS","LIB_StuG_III_G","LIB_StuG_III_G_WS","LIB_StuG_III_G","LIB_StuG_III_G_WS"],
["LIB_PzKpfwVI_B","LIB_PzKpfwVI_B","LIB_PzKpfwVI_B_camo","LIB_PzKpfwIV_H","LIB_PzKpfwV","LIB_StuG_III_G","LIB_StuG_III_G_WS","LIB_StuG_III_G","LIB_StuG_III_G_WS","LIB_StuG_III_G","LIB_StuG_III_G_WS"]
];

ARMEDAA = [
["LIB_SdKfz_7_AA","LIB_FlaK_38","LIB_Flakvierling_38"],
["LIB_61k"],
["LIB_SdKfz_7_AA","LIB_FlaK_38","LIB_Flakvierling_38"],
["LIB_SdKfz_7_AA","LIB_FlaK_38","LIB_Flakvierling_38"]
];

ARMEDCARRIER = [
["LIB_opelblitz_open_y_camo","LIB_opelblitz_tent_y_camo","Lib_sdkfz251","LIB_SdKfz_7"],
["LIB_Scout_m3","Lib_SdKfz251_captured","lib_us6_tent","lib_us6_open","lib_zis5v"],
["LIB_opelblitz_open_y_camo","LIB_opelblitz_tent_y_camo","Lib_sdkfz251","LIB_SdKfz_7"],
["LIB_opelblitz_open_y_camo","LIB_opelblitz_tent_y_camo","Lib_sdkfz251","LIB_SdKfz_7"]
];

ARMEDSTATIC = [
["LIB_61k","LIB_Zis3","LIB_BM37","SearchLight_SU"],
["LIB_61k","LIB_Zis3","LIB_BM37","SearchLight_SU"],
["SearchLight_GER","LIB_Pak40","LIB_Flakvierling_38","LIB_FlaK_38"],
["LIB_61k","LIB_Zis3","LIB_BM37","SearchLight_SU"]
];

ARMEDSUPPORT = [
["LIB_opelblitz_ambulance","lib_opelblitz_ammo","LIB_opelblitz_fuel","LIB_opelblitz_parm"],
["lib_zis6_parm","lib_zis5v_fuel","lib_zis5v_med","lib_us6_ammo","lib_us6_bm13"],
["LIB_opelblitz_ambulance","lib_opelblitz_ammo","LIB_opelblitz_fuel","LIB_opelblitz_parm"]
];

CIVVEH = ["LIB_US_GMC_Tent","LIB_US_GMC_Open"];

AIRFIGTHER = [
["LIB_FW190F8","LIB_Ju87"],
["LIB_Pe2","LIB_P39"],
["LIB_FW190F8","LIB_Ju87"],
["LIB_FW190F8","LIB_Ju87"]
];

AIRARMCHOP = [
["LIB_FW190F8","LIB_Ju87"],
["LIB_Pe2","LIB_P39"],
["LIB_FW190F8","LIB_Ju87"],
["LIB_FW190F8","LIB_Ju87"]
];
AIRCARRIERCHOP = [
["LIB_FW190F8","LIB_Ju87"],
["LIB_Pe2","LIB_P39"],
["LIB_FW190F8","LIB_Ju87"],
["LIB_FW190F8","LIB_Ju87"]
];
CRATECLAS = [
["LIB_BasicAmmunitionBox_GER","LIB_BasicWeaponsBox_GER","LIB_WeaponsBox_Big_GER"]
,["LIB_Lone_Big_Box","LIB_WeaponsBox_Big_SU","LIB_BasicWeaponsBox_SU","LIB_Mine_Ammo_Box_Su","LIB_BasicAmmunitionBox_SU"]
,["LIB_BasicAmmunitionBox_GER","LIB_BasicWeaponsBox_GER","LIB_WeaponsBox_Big_GER"]
,["LIB_BasicAmmunitionBox_GER","LIB_BasicWeaponsBox_GER","LIB_WeaponsBox_Big_GER"]
];
ENEMYC1 = ["LIB_SOV_sergeant","LIB_SOV_p_officer","LIB_SOV_smgunner","LIB_SOV_smgunner","LIB_SOV_LC_rifleman","LIB_SOV_mgunner","LIB_SOV_medic","LIB_SOV_AT_grenadier","LIB_SOV_AT_grenadier","LIB_SOV_AT_soldier","LIB_SOV_AT_soldier","LIB_SOV_rifleman"];
ENEMYC2 = ["LIB_SOV_sergeant","LIB_SOV_p_officer","LIB_SOV_smgunner","LIB_SOV_smgunner","LIB_SOV_LC_rifleman","LIB_SOV_mgunner","LIB_SOV_medic","LIB_SOV_AT_grenadier","LIB_SOV_AT_grenadier","LIB_SOV_AT_soldier","LIB_SOV_AT_soldier","LIB_SOV_rifleman"];
ENEMYC3 = ["LIB_SOV_sergeant","LIB_SOV_p_officer","LIB_SOV_smgunner","LIB_SOV_smgunner","LIB_SOV_LC_rifleman","LIB_SOV_mgunner","LIB_SOV_medic","LIB_SOV_AT_grenadier","LIB_SOV_AT_grenadier","LIB_SOV_AT_soldier","LIB_SOV_AT_soldier","LIB_SOV_rifleman"];
FRIENDC2 = ["LIB_GER_AT_soldier","LIB_GER_AT_grenadier","LIB_GER_smgunner","LIB_GER_scout_smgunner","LIB_GER_ober_lieutenant","LIB_GER_scout_lieutenant","LIB_GER_mgunner","LIB_GER_scout_mgunner","LIB_GER_medic","LIB_GER_radioman","LIB_GER_ober_rifleman","LIB_GER_scout_ober_rifleman","LIB_GER_rifleman","LIB_GER_scout_rifleman","LIB_GER_sapper","LIB_GER_sapper_gefr","LIB_GER_lieutenant","LIB_GER_unterofficer","LIB_GER_scout_sniper","LIB_GER_stggunner"];
FRIENDC3 = ["SG_sturmtrooper_unterofficer","SG_sturmtrooper_mgunner","SG_sturmtrooper_sniper","SG_sturmtrooper_ober_rifleman","SG_sturmtrooper_stggunner","SG_sturmtrooper_stggunner","SG_sturmtrooper_rifleman","SG_sturmtrooper_rifleman","SG_sturmtrooper_rifleman","SG_sturmtrooper_medic"];
FRIENDC1 = ["LIB_GER_AT_soldier","LIB_GER_AT_grenadier","LIB_GER_smgunner","LIB_GER_scout_smgunner","LIB_GER_ober_lieutenant","LIB_GER_scout_lieutenant","LIB_GER_mgunner","LIB_GER_scout_mgunner","LIB_GER_medic","LIB_GER_radioman","LIB_GER_ober_rifleman","LIB_GER_scout_ober_rifleman","LIB_GER_rifleman","LIB_GER_scout_rifleman","LIB_GER_sapper","LIB_GER_sapper_gefr","LIB_GER_lieutenant","LIB_GER_unterofficer","LIB_GER_scout_sniper","LIB_GER_stggunner"];
FRIENDC4 = ["SG_sturmtrooper_unterofficer","SG_sturmtrooper_mgunner","SG_sturmtrooper_sniper","SG_sturmtrooper_ober_rifleman","SG_sturmtrooper_stggunner","SG_sturmtrooper_stggunner","SG_sturmtrooper_rifleman","SG_sturmtrooper_rifleman","SG_sturmtrooper_rifleman","SG_sturmtrooper_medic"];
NORANWEES = true;
IFENABLED = true;
IFSOVIET = true;
publicVariable "NORANWEES";
publicVariable "IFENABLED";
publicVariable "IFSOVIET";
lbClear 1504;
lbAdd [1504, "Land Insertion"];
lbSetPicture [1504,0,"\A3\ui_f\data\map\markers\handdrawn\unknown_CA.paa"];
lbSetTooltip [1504,0,"Your team begin from green marked location"];
lbSetCurSel [1504, 0];
};
case 3: {
"Fictional - Play as Americans allied, with Germans and Polish, against Soviet" SPAWN HINTSAOK;
lbClear 1503;
lbAdd [1503, "Recon"];
lbSetPicture [1503,0,"\A3\ui_f\data\map\markers\nato\b_recon.paa"];
lbSetTooltip [1503,0,"Lead 5 men team"];
lbSetCurSel [1503, 0];
//1 US 2 GERMAN 3 RUS 4 POLAND
ARMEDVEHICLES = [
["LIB_M4A3_75"],
["LIB_JS2_43","LIB_JS2_43","LIB_t34_76","LIB_t34_85","LIB_SU85","LIB_t34_76","LIB_t34_85","LIB_t34_76","LIB_t34_85"],
["LIB_PzKpfwVI_B","LIB_PzKpfwVI_B","LIB_PzKpfwVI_B_camo","LIB_PzKpfwIV_H","LIB_PzKpfwV","LIB_StuG_III_G","LIB_StuG_III_G_WS","LIB_StuG_III_G","LIB_StuG_III_G_WS","LIB_StuG_III_G","LIB_StuG_III_G_WS"],
["Lib_Willys_MB"]
];

ARMEDTANKS = [
["LIB_M4A3_75"],
["LIB_JS2_43","LIB_JS2_43","LIB_t34_76","LIB_t34_85","LIB_SU85","LIB_t34_76","LIB_t34_85","LIB_t34_76","LIB_t34_85"],
["LIB_PzKpfwVI_B","LIB_PzKpfwVI_B","LIB_PzKpfwVI_B_camo","LIB_PzKpfwIV_H","LIB_PzKpfwV","LIB_StuG_III_G","LIB_StuG_III_G_WS","LIB_StuG_III_G","LIB_StuG_III_G_WS","LIB_StuG_III_G","LIB_StuG_III_G_WS"],
["Lib_Willys_MB"]
];

ARMEDAA = [
["LIB_61k"],
["LIB_61k"],
["LIB_SdKfz_7_AA","LIB_FlaK_38","LIB_Flakvierling_38"],
["Lib_Willys_MB"]
];

ARMEDCARRIER = [
["LIB_US_GMC_Tent","LIB_US_GMC_Open","LIB_US_Scout_m3","LIB_US_Scout_m3"],
["LIB_Scout_m3","Lib_SdKfz251_captured","lib_us6_tent","lib_us6_open","lib_zis5v"],
["LIB_opelblitz_open_y_camo","LIB_opelblitz_tent_y_camo","Lib_sdkfz251","LIB_SdKfz_7"],
["lib_us6_tent","lib_us6_open"]
];

ARMEDSTATIC = [
["LIB_61k","LIB_Zis3","LIB_BM37","SearchLight_SU"],
["LIB_61k","LIB_Zis3","LIB_BM37","SearchLight_SU"],
["SearchLight_GER","LIB_Pak40","LIB_Flakvierling_38","LIB_FlaK_38"],
["LIB_61k","LIB_Zis3","LIB_BM37","SearchLight_SU"]
];

ARMEDSUPPORT = [
["LIB_US_GMC_Ambulance","LIB_US_GMC_Ammo","LIB_US_GMC_Fuel","LIB_US_GMC_Parm"],
["lib_zis6_parm","lib_zis5v_fuel","lib_zis5v_med","lib_us6_ammo","lib_us6_bm13"],
["LIB_opelblitz_ambulance","lib_opelblitz_ammo","LIB_opelblitz_fuel","LIB_opelblitz_parm"]
];

CIVVEH = ["LIB_US_GMC_Tent","LIB_US_GMC_Open"];

AIRFIGTHER = [
["LIB_P47"],
["LIB_Pe2","LIB_P39"],
["LIB_FW190F8","LIB_Ju87"],
["LIB_Pe2","LIB_P39"]
];

AIRARMCHOP = [
["LIB_P47"],
["LIB_Pe2","LIB_P39"],
["LIB_FW190F8","LIB_Ju87"],
["LIB_Pe2","LIB_P39"]
];
AIRCARRIERCHOP = [
["LIB_P47"],
["LIB_Pe2","LIB_P39"],
["LIB_FW190F8","LIB_Ju87"],
["LIB_Pe2","LIB_P39"]
];
CRATECLAS = [
["LIB_BasicWeaponsBox_US","LIB_Mine_AmmoBox_US","LIB_BasicAmmunitionBox_US"]
,["LIB_Lone_Big_Box","LIB_WeaponsBox_Big_SU","LIB_BasicWeaponsBox_SU","LIB_Mine_Ammo_Box_Su","LIB_BasicAmmunitionBox_SU"]
,["LIB_BasicAmmunitionBox_GER","LIB_BasicWeaponsBox_GER","LIB_WeaponsBox_Big_GER"]
,["LIB_Lone_Big_Box","LIB_WeaponsBox_Big_SU","LIB_BasicWeaponsBox_SU","LIB_Mine_Ammo_Box_Su","LIB_BasicAmmunitionBox_SU"]
];
ENEMYC1 = ["LIB_SOV_sergeant","LIB_SOV_p_officer","LIB_SOV_smgunner","LIB_SOV_smgunner","LIB_SOV_LC_rifleman","LIB_SOV_mgunner","LIB_SOV_medic","LIB_SOV_AT_grenadier","LIB_SOV_AT_grenadier","LIB_SOV_AT_soldier","LIB_SOV_AT_soldier","LIB_SOV_rifleman"];
ENEMYC2 = ["LIB_SOV_sergeant","LIB_SOV_p_officer","LIB_SOV_smgunner","LIB_SOV_smgunner","LIB_SOV_LC_rifleman","LIB_SOV_mgunner","LIB_SOV_medic","LIB_SOV_AT_grenadier","LIB_SOV_AT_grenadier","LIB_SOV_AT_soldier","LIB_SOV_AT_soldier","LIB_SOV_rifleman"];
ENEMYC3 = ["LIB_SOV_sergeant","LIB_SOV_p_officer","LIB_SOV_smgunner","LIB_SOV_smgunner","LIB_SOV_LC_rifleman","LIB_SOV_mgunner","LIB_SOV_medic","LIB_SOV_AT_grenadier","LIB_SOV_AT_grenadier","LIB_SOV_AT_soldier","LIB_SOV_AT_soldier","LIB_SOV_rifleman"];
FRIENDC2 = ["LIB_GER_AT_soldier","LIB_GER_AT_grenadier","LIB_GER_smgunner","LIB_GER_scout_smgunner","LIB_GER_ober_lieutenant","LIB_GER_scout_lieutenant","LIB_GER_mgunner","LIB_GER_scout_mgunner","LIB_GER_medic","LIB_GER_radioman","LIB_GER_ober_rifleman","LIB_GER_scout_ober_rifleman","LIB_GER_rifleman","LIB_GER_scout_rifleman","LIB_GER_sapper","LIB_GER_sapper_gefr","LIB_GER_lieutenant","LIB_GER_unterofficer","LIB_GER_scout_sniper","LIB_GER_stggunner"];
FRIENDC3 = ["SG_sturmtrooper_unterofficer","SG_sturmtrooper_mgunner","SG_sturmtrooper_sniper","SG_sturmtrooper_ober_rifleman","SG_sturmtrooper_stggunner","SG_sturmtrooper_stggunner","SG_sturmtrooper_rifleman","SG_sturmtrooper_rifleman","SG_sturmtrooper_rifleman","SG_sturmtrooper_medic"];
FRIENDC1 = ["LIB_US_AT_soldier","LIB_US_engineer","LIB_US_grenadier","LIB_US_radioman","LIB_US_second_lieutenant","LIB_US_sniper","LIB_US_smgunner","LIB_US_mgunner","LIB_US_medic","LIB_US_corporal","LIB_US_mgunner","LIB_US_FC_rifleman","LIB_US_FC_rifleman","LIB_US_rifleman","LIB_US_rifleman","LIB_US_rifleman"];
FRIENDC4 = ["LIB_wp_saper","LIB_wp_sniper","LIB_wp_AT_grenadier","LIB_wp_porucznic","LIB_wp_sierzant","LIB_wp_mgunner","LIB_wp_sniper","LIB_wp_starszy_strzelec","LIB_wp_stggunner","LIB_wp_AT_grenadier","LIB_wp_strzelec","LIB_wp_strzelec","LIB_wp_strzelec","LIB_wp_medic"];
NORANWEES = true;
IFENABLED = true;
publicVariable "NORANWEES";
publicVariable "IFENABLED";
lbClear 1504;
lbAdd [1504, "Land Insertion"];
lbSetPicture [1504,0,"\A3\ui_f\data\map\markers\handdrawn\unknown_CA.paa"];
lbSetTooltip [1504,0,"Your team begin from green marked location"];
lbSetCurSel [1504, 0];
};
};
publicVariable "FRIENDC4";
publicVariable "FRIENDC3";
publicVariable "FRIENDC2";
publicVariable "FRIENDC1";
publicVariable "ENEMYC3";
publicVariable "ENEMYC2";
publicVariable "ENEMYC1";
publicVariable "CRATECLAS";
publicVariable "AIRCARRIERCHOP";
publicVariable "AIRARMCHOP";
publicVariable "AIRFIGTHER";
publicVariable "CIVVEH";
publicVariable "ARMEDSUPPORT";
publicVariable "ARMEDTANKS";
publicVariable "ARMEDSTATIC";
publicVariable "ARMEDCARRIER";
publicVariable "ARMEDAA";
publicVariable "ARMEDVEHICLES";
};




