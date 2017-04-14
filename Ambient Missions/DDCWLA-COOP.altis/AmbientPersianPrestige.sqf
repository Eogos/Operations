private ["_n","_nWalls","_Gps","_Func1","_Hintbol","_cWalls","_t","_start","_dir","_end","_nul","_ranW","_center","_radius","_br","_ar","_star","_sel","_obj","_objc","_pos","_objs","_cW","_forEachIndex","_rC"];
waitUntil {sleep 1; !isNil"StartMission"};
sleep 30;
_Hintbol = false;
if (isNil"PERSIANPRESTIGE") then {PERSIANPRESTIGE = 900*DIFLEVEL*0.5;};
if (isNil"WalledCamp") then {WalledCamp = [];};
if (isNil"WalledOther") then {WalledOther = [];};
_Func1 = {
private ["_Fs","_Mp","_nGp"];
_Fs = [];
if (count GuardPosts > 0) then {
{_Mp = getmarkerpos _x; _nGp = ([_Mp] CALL NearestGuardPost); if (!isNil{_nGp getvariable "Gmark"} && {(getmarkercolor (_nGp getvariable "Gmark")) == "ColorRed"} && {_nGp distance _Mp < 350}) then {_Fs set [count _Fs,_x];};} foreach FacMarkers;
};
PERSIANPRESTIGE = PERSIANPRESTIGE + (4*(count _Fs)*DIFLEVEL*0.5);
pisteetE = pisteetE + (4*(count _Fs)*DIFLEVEL*0.5);publicVariable "pisteetE";
_Fs
};


sleep 55;
//ADD WALLS FOR EACH ENEMY CAMP  _walls = [10,0,"Land_Mil_WiredFence_F",0] CALL FUNKTIO_DrawBox; _nul = [_end,_start,"Land_Mil_WiredFence_F",9500] SPAWN AddWall;

if (isNil"Bwalll" && {isNil"SAOKRESUME"}) then {
{
if (!(_x in WalledCamp) && {!(_x in WalledOther)} && {getmarkercolor _x == "ColorRed"} && {random 1 < 0.1}) then {
_ranW = ["Land_CncWall4_F","Land_CncWall4_F","Land_Mil_WallBig_4m_F","Land_Mil_WiredFence_F"] call RETURNRANDOM;
_center = getmarkerpos _x;
WalledCamp set [count WalledCamp,_x];
_radius = 200 + (random 200);
_dir = random 360;
_start = [(_center select 0)+((sin _dir)*_radius),(_center select 1)+((cos _dir)*_radius),0];
_dir = _dir + 90;
_end = [(_center select 0)+((sin _dir)*_radius),(_center select 1)+((cos _dir)*_radius),0];
if (!surfaceIsWater _end && {!surfaceIsWater _start}) then {_nul = [_end,_start,_ranW,200] SPAWN AddWall;};
_t = 1;
while {random 1 < 0.5 && {_t < 3}} do {
_t =_t + 1;
_start = [(_center select 0)+((sin _dir)*_radius),(_center select 1)+((cos _dir)*_radius),0];
_dir = _dir + 90;
_end = [(_center select 0)+((sin _dir)*_radius),(_center select 1)+((cos _dir)*_radius),0];
if (!surfaceIsWater _end && {!surfaceIsWater _start}) then {_nul = [_end,_start,_ranW,200] SPAWN AddWall;};
};
};
sleep 0.1;
} foreach AmbientZonesN;
};


while {true} do {
sleep 60;
//UPDATE PRESTIGE
_Gps = [] CALL _Func1;
//BUILD SOMETHING IF PRESTIGE IS OVER 300
if (PERSIANPRESTIGE > 1200) then {
//NO WALLED FACTORIES
_nWalls = _Gps - WalledOther;
_cWalls = [];
{if (getmarkercolor _x == "ColorRed" && {!(_x in WalledCamp)}) then {_cWalls set [count _cWalls,_x];};sleep 0.1;} foreach AmbientZonesN;
	
//0 NEW ZONE 1 NEW STRAIGHT WALL 2 NEW FACTORY BOX WALL 3 SILO
_n = [0,0,0,0,0];
if (count _nWalls > 0 && {isNil"Bwalll"} && {paramsArray select 10 == 1}) then {_n set [count _n,2];}; 
if (count _cWalls > 0 && {isNil"Bwalll"} && {paramsArray select 10 == 1}) then {_n set [count _n,4];}; 

_n = _n call RETURNRANDOM;

switch _n do {
//VEH ZONE
case 0: {if (_Hintbol) then {Hint "New VEH Zone"};
["CSAT Seen Producing More Military Vehicles from Factory", date] CALL SAOKEVENTLOG;
if ({getmarkercolor _x == "ColorRed"} count VEHZONES < 60) then {
_ar = + _Gps;
_br = [];
if (count _ar == 0) then {
{if (getmarkercolor _x == "ColorRed") then {_br set [count _br, _x];};sleep 0.1;} foreach AmbientZonesN;
};
if (count _ar > 0 || {count _br > 0}) then {
PERSIANPRESTIGE = PERSIANPRESTIGE - 150;
_star = getmarkerpos ((_ar+_br) call RETURNRANDOM);
_start = [_star,100,30,"(1 - trees) * (1 - sea) * (1 - houses)"] CALL SAOKSEEKPOS;
_rC = ["C","P","T","V","AA","S"] call RETURNRANDOM;
["EAST",_rC,2,_start] SPAWN SAOKMOREVEHZONES;
};
};
};
//DISABLED CURRENTLY ["EAST","T",1,_start] SPAWN SAOKMOREVEHZONES;
case 1: {if (_Hintbol) then {Hint "New S Wall"};};
//FACTORY WALLS
case 2: {
if (_Hintbol) then {Hint "New Fac Wall"};
["CSAT Constructing Walls Around One of Their Factories", date] CALL SAOKEVENTLOG;
_sel = _nWalls call RETURNRANDOM;
if ({(getmarkerpos _sel) distance (getmarkerpos _x) < 3000} count (WalledCamp + WalledOther) == 0) then {
PERSIANPRESTIGE = PERSIANPRESTIGE - 900;
WalledOther set [count WalledOther,_sel];
_center = getmarkerpos _sel;
_radius = 150 + (random 200);
_dir = random 360;
_start = [(_center select 0)+((sin _dir)*_radius),(_center select 1)+((cos _dir)*_radius),0];
_dir = _dir + 90;
_end = [(_center select 0)+((sin _dir)*_radius),(_center select 1)+((cos _dir)*_radius),0];
if (!surfaceIsWater _end && {!surfaceIsWater _start}) then {_nul = [_end,_start,"Land_CncWall4_F",200] SPAWN AddWall;};
_t = 1;
while {random 1 < 0.8 && {_t < 3}} do {
_t =_t + 1;
_start = [(_center select 0)+((sin _dir)*_radius),(_center select 1)+((cos _dir)*_radius),0];
_dir = _dir + 90;
_end = [(_center select 0)+((sin _dir)*_radius),(_center select 1)+((cos _dir)*_radius),0];
if (!surfaceIsWater _end && {!surfaceIsWater _start}) then {_nul = [_end,_start,"Land_CncWall4_F",200] SPAWN AddWall;};
};
};
};
//NEW CAMP WALL
case 4: {if (_Hintbol) then {Hint "New C Wall"};
["CSAT Building Walls to Cover One of Their Camps", date] CALL SAOKEVENTLOG;
_cW = _cWalls call RETURNRANDOM;
if ({(getmarkerpos _cW) distance (getmarkerpos _x) < 3000} count (WalledCamp + WalledOther) == 0) then {
PERSIANPRESTIGE = PERSIANPRESTIGE - 1200;
_ranW = ["Land_CncWall4_F","Land_CncWall4_F","Land_Mil_WallBig_4m_F","Land_Mil_WiredFence_F"] call RETURNRANDOM;
_center = getmarkerpos _cW;
WalledCamp set [count WalledCamp,_cW];
_radius = 200 + (random 200);
_dir = random 360;
_start = [(_center select 0)+((sin _dir)*_radius),(_center select 1)+((cos _dir)*_radius),0];
_dir = _dir + 90;
_end = [(_center select 0)+((sin _dir)*_radius),(_center select 1)+((cos _dir)*_radius),0];
if (!surfaceIsWater _end && {!surfaceIsWater _start}) then {_nul = [_end,_start,_ranW,200] SPAWN AddWall;};
_t = 1;
while {random 1 < 0.5 && {_t < 3}} do {
_t =_t + 1;
_start = [(_center select 0)+((sin _dir)*_radius),(_center select 1)+((cos _dir)*_radius),0];
_dir = _dir + 90;
_end = [(_center select 0)+((sin _dir)*_radius),(_center select 1)+((cos _dir)*_radius),0];
if (!surfaceIsWater _end && {!surfaceIsWater _start}) then {_nul = [_end,_start,_ranW,200] SPAWN AddWall;};
};
};
};

};

} else {
/*
//SILO GONE Land_CratesWooden_F
{
if (!alive _x || {isNull _x}) then {PRESTIGESILOS = PRESTIGESILOS - [_x];};
sleep 0.1;
} foreach PRESTIGESILOS;
{if (isNil"_x") exitWith {PRESTIGESILOS = [PRESTIGESILOS,_forEachIndex] call BIS_fnc_removeIndex;};sleep 0.1;} foreach PRESTIGESILOS;
//TURN STORAGED SILO TO PRESTIGE
if (random 1 < 0.4 && {count PRESTIGESILOS > 0}) then {
{if (true) exitWith {deletevehicle _x;PRESTIGESILOS = [PRESTIGESILOS,_forEachIndex] call BIS_fnc_removeIndex;PERSIANPRESTIGE = PERSIANPRESTIGE + 50;};} foreach PRESTIGESILOS;
};
*/
};
};

//PRESTIGE STORING, WALLS, GUARDPOSTS, VEH ZONES, NEW CAMPS, BOAT CARGO PRESTIGE, RADARS?, OTHER SPECIAL COMPOUNDS?