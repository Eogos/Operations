private ["_noMax","_c","_dis","_func","_vZ","_AAdistance","_resF","_resFexit"];
_func = {
private ["_cc","_color","_side","_arr","_vehicles","_units","_obj","_c","_w","_ss","_obj2","_si","_star","_wpT","_forEachIndex","_wpPP","_start","_mid","_dis","_ca","_ar","_vd","_n"];
//SIDE CHECK
if !(_this in allmapmarkers) exitWith {};
_color = getmarkercolor _this;
_side = if (_color == "ColorRed") then {EAST} else {WEST};
//START POS SEARCH
_star = getmarkerpos _this;
if ((getmarkertype _this in ["o_naval","b_naval"]) || {_this in NOMOVEZONES}) then {} else {
while {{vehicle _x distance _star < 800} count ([] CALL AllPf) > 0} do {
sleep 0.1;
_star = [getmarkerpos _this,1200,800,"(1 - trees) * (1 - sea) * (1 - houses)"] CALL SAOKSEEKPOS;
};
};
_arr = _this CALL SAOKZONEDR;
if (isNil"_arr" || {count _arr == 0}) exitWith {deletemarker _this;};
//SPAWN
_vehicles = [];
_units = [];
_wpT = "MOVE";
if (_color != "ColorRed") then {_wpT = "GUARD";};
if ((_arr select 0) isKindOf "Plane") then {_star = [_star select 0,_star select 1,100];};
if ((_arr select 0) isKindOf "Helicopter") then {_star = [_star select 0,_star select 1,50];_wpT = "LOITER";};
_vd = [_star,1, _arr select 0,_side];
if (_this in NOMOVEZONES) then {_vd pushBack "";};
_obj = _vd call SPAWNVEHICLE;
if (_color == "ColorRed") then {CantCommand pushBack (_obj select 2);};
leader (_obj select 2) setRank "LIEUTENANT";
(_obj select 0) setvariable ["ZoneVehi",1];
[_this, (_obj select 2)] CALL SAOKZONEG;

_vehicles pushBack (_obj select 0);
_units = _units + (units (_obj select 2));
_c = 1;
if (_color != "ColorRed") then {(_obj select 2) setvariable ["VZoneG",1];};
{
if (_forEachIndex != 0) then {
_ss = [(_star select 0) + (35*_c),_star select 1,0];
if (_x isKindOf "Plane") then {_star = [_star select 0,_star select 1,100];};
_vd = [_ss,1,_x,_side];
if (_this in NOMOVEZONES) then {_vd pushBack "";};
_obj2 = _vd call SPAWNVEHICLE;
_units = _units + (units (_obj2 select 2));
(_obj2 select 0) setvariable ["ZoneVehi",1];
if (_color == "ColorRed") then {CantCommand pushBack (_obj2 select 2);VehicleGroups pushBack (_obj2 select 2);};
units (_obj2 select 2) join (_obj select 2);
_vehicles pushBack (_obj2 select 0);

_c = _c + 1;
};
sleep 0.1;
} foreach _arr;
if (_side == EAST) then {(_obj select 2) setvariable ["VehG",1];
};
//MOVING OR NOT
_wpPP = [getmarkerpos _this];
if ({_this == _x select 0} count ZONEMS > 0 && {count (_this CALL SAOKZONEMW) > 0}) then {_wpPP = _this CALL SAOKZONEMW;};
if (!isNil"_wpPP" && {!isNil"_obj"} && {!isNull (_obj select 2)} && {typename (_obj select 0) == "OBJECT"} && {!(_this in NOMOVEZONES)}) then {
(_obj select 2) setvariable ["GMar",_this];
_cc = 0;
{
_w = (_obj select 2) addWaypoint [_x, 0]; 
_w setWaypointStatements ["true", "if (!isNil""thisList"") then {thisList call SAOKVZFUNC1;};"];
_w setWaypointType _wpT;
if (_cc == 0) then {
_cc = 1;
_start = getposATL (_obj select 0);
_mid = [((_start select 0)+(_x select 0))*0.5,((_start select 1)+(_x select 1))*0.5,0];
if (_start distance _mid > 50) then {
[_mid,"mil_arrow",(getmarkercolor _this),([_start, _mid] call BIS_fnc_dirTo)] SPAWN SAOKCREATEMARKER;
};
};
sleep 0.1;
} foreach _wpPP;
};
if (!isnil"_units") then {
[_units,_this] SPAWN SAOKSHF9;
};
//WAITUNTIL PLAYER IS FAR
_dis = (["V"] CALL DIS); if (getmarkertype _this in ["o_air","b_air","n_air","n_plane","o_uav","i_uav","n_uav","o_plane","b_plane"]) then {_dis = (["V"] CALL DIS)*2;};
waitUntil {sleep 5; {vehicle _x distance (getmarkerpos _this) < _dis} count ([] CALL AllPf) == 0 || {{alive _x && {vehicle _x != _x}} count units (_obj select 2) == 0}};
_ar = [];
if (!isnil"_vehicles") then {
{if (alive _x && {{alive _x} count crew _x > 0}) then {_ar pushBack (typeOf _x);};} foreach _vehicles;};
[_this,_ar] CALL SAOKZONED;
_arr = [];
if (!isnil"_vehicles") then {_arr = _arr + _vehicles;};
{
_x spawn SAOKSHF10;
sleep 0.1;
} foreach _arr;
_arr = [];
if (!isnil"_units") then {_arr = _arr + _units;};
{_x spawn SAOKSHF11;

sleep 0.1;} foreach _arr;
ACTIVEZ = ACTIVEZ - [_this];
if (count _ar > 0) then {
_si = 0.65 + (0.15*(count _ar));
_this setMarkerSize [_si,_si];
VEHZONES pushBack _this;
if ({_this == _x select 0} count ZONEMS > 0 && {count (_this CALL SAOKZONEMW) > 0}) then {
_ca = + (_this CALL SAOKZONEMW);
_n = _this CALL SAOKZONEM;
sleep 0.5;
_c = count _ca - 1;
for "_i" from 0 to _c do {
if (_i == 0) then {[_this, _ca select _i,""] SPAWN ZoneMove;} else {[_this, _ca select _i] SPAWN ZoneMove;};
sleep 5.5;
};
};
} else {
_this CALL SAOKZONED;
_this CALL SAOKZONEG;
_this setmarkercolor "ColorGrey"; 
_this spawn SAOKSHF12;
};
};


_resF = {

private ["_arM","_mar2","_mar"];
RESERVEZONE pushBack  _this;
_this setMarkerAlpha 0.35;
_arM = format ["ZoneResM%1",_this];
_mar2 = createMarker [_arM,getmarkerpos _this];
_mar2 setMarkerShape "ELLIPSE";
_mar2 setMarkerAlpha 0.35;
_mar2 setMarkerBrush "SolidBorder";
_mar2 setMarkerSize [200,200];
_mar2 setMarkerDir 0;
_mar2 setMarkerColor "ColorWhite"; 
_mar = format ["%1a",_arM];
_mar2 = createMarker [_mar,getmarkerpos _this];
_mar2 setMarkerShape "ICON";
_mar2 setMarkerType "mil_box";
_mar2 setMarkerAlpha 0.45;
_mar2 setMarkerSize [0.7,0.7];
_mar2 setMarkerColor "ColorWhite";
_mar2 setMarkerText " In Reserve, Location Unknown";
[_arM,_this] SPAWN SAOKSHF13;
RESERVEAMARKS pushBack [_this, _arM];
};

_resFexit = {

private ["_forEachIndex"];
{
if (_x select 0 == _this) exitWith {
deletemarker ((_x select 1)+"a");
deletemarker (_x select 1);
RESERVEAMARKS = [RESERVEAMARKS,_forEachIndex] call BIS_fnc_removeIndex;
};
} foreach RESERVEAMARKS;
RESERVEZONE = RESERVEZONE - [_this];
_this setMarkerAlpha 1;
};

_noMax = {
private ["_bol","_mC"];
_bol = false;
_mC = getmarkercolor _this;
if (_mC == "ColorRed") then {
if ({getmarkercolor _x == _mC} count ACTIVEZ < MAXACTIVEV) then {_bol = true;};
} else {
if (_mC in ["ColorBlue","ColorGreen"]) then {
if ({getmarkercolor _x in ["ColorBlue","ColorGreen"]} count ACTIVEZ < MAXACTIVEV) then {_bol = true;};
};
};
_bol
};

AAsM = [];
_AAdistance = DIFLEVEL * 4000;
while {true} do {
_co1 = {private ["_b"];_b = if ({(_this select 0) distance vehicle _x < (_this select 1)} count ([] CALL AllPf) > 0) then {true} else {false};_b};
if ({getmarkercolor _x == "ColorRed" && {[getmarkerpos _x,_AAdistance] call _co1}} count AAsM > 0) then {AAclose = true;} else {AAclose = nil;};
sleep 4;
_dis = (["V"] CALL DIS);
_c = count RESERVEZONE - 1;

for "_i" from 0 to _c do {
if (_i >= 0 && {count RESERVEZONE > _i} && {{vehicle _x distance getmarkerpos (RESERVEZONE select _i) < _dis} count ([] CALL AllPf) == 0}) then {
(RESERVEZONE select _i) call _resFexit;
};
};
sleep 3;
_vZ = + VEHZONES;
_c = count _vZ - 1;
for "_i" from 0 to _c do {
private ["_xx"];
_xx = _vZ select _i;
if (getmarkerpos _xx distance [0,0,0] < 40 || {!(_xx in allmapmarkers)}) then {
_xx SPAWN SAOKSHF14;
} else {
if (markertext _xx == " AA" && {!(_xx in AAsM)}) then {AAsM pushBack _xx;};
_dis = (["V"] CALL DIS); 
if (getmarkertype _xx in ["o_air","b_air","n_air","n_plane","o_uav","i_uav","n_uav"]) then {_dis = (["V"] CALL DIS)*2;};
if ({vehicle _x distance getmarkerpos _xx < _dis} count ([] CALL AllPf) > 0) then {
if (_xx CALL _noMax || {_xx in SZONES}) then {
_xx SPAWN _func; VEHZONES = VEHZONES - [_xx]; ACTIVEZ pushBack _xx;
if (_xx in RESERVEZONE) then {_xx call _resFexit;};
} else {
if !(_xx in RESERVEZONE) then {
_xx call _resF;
};
};
};
};
sleep 0.01;
};
};