private ["_cars","_roads","_pRan","_dir","_pos","_veh"];
if (!isServer) exitWith {};
while {true} do {
_lP = leader (([WEST] CALL AllPf)call RETURNRANDOM);

_cars = [];
while {vehicle _lP distance (getmarkerpos ([getposATL (vehicle _lP)] CALL NEARESTVILLAGE)) < 300} do {
{if (isNull _x) then {_cars = _cars - [_x];};} foreach _cars;
{if (isNil"_x") then {_cars = [_cars,_forEachIndex] call BIS_fnc_removeIndex;};} foreach _cars;
sleep 0.1;
{if (isNil{_x getvariable "TaskCar"} && {_x distance vehicle _lP > 150}) then {_cars = _cars - [_x];deletevehicle _x;};} foreach _cars;
sleep 0.1;
if (count _cars < 5) then {
_roads = ((getposATL vehicle _lP) nearRoads 150); 
if (count _roads > 0) then {
_pRan = _roads call RETURNRANDOM;
sleep 0.1;
while {_lP distance _pRan < 30} do {_pRan = _roads call RETURNRANDOM;sleep 3;};
_ro = (roadsConnectedTo _pRan); 
_dir = random 360;
sleep 0.1;
if (count _ro > 0) then {_ro = _ro call RETURNRANDOM; _dir = [getposATL _ro,getposATL _pRan] call BIS_fnc_dirTo;};
_p = [[5,0.2],[-5,-0.2]]call RETURNRANDOM;
_ad = (_p select 1);
_pos = _pRan modelToWorld [(_p select 0)+_ad,0,0];
_od =((_p select 1)*7);
sleep 0.1;
while {abs _ad < 6 && {isOnRoad _pos} && {!(lineIntersects [_pRan modelToWorld [((_p select 0)+_ad),0,0.3], _pRan modelToWorld [((_p select 0)+_ad+_od),0,0.3]])}} do {
//while {abs _ad < 6 && isOnRoad _pos} do {
_ad = _ad + (_p select 1);
_pos = _pRan modelToWorld [(_p select 0)+_ad,0,0];
sleep 0.1;
};
//if (abs _ad >= 3 || isOnRoad _pos) then {hint "bong";} else {hint "dong"; player setpos _pos;};
sleep 0.1;
if (_ad < 6 && {{_x distance _pos < 20} count _cars == 0} && {!(isOnRoad _pos)}) then {
_veh = createVehicle [["C_SUV_01_F","C_Van_01_box_F","C_Van_01_transport_F","C_Hatchback_01_sport_F","C_Hatchback_01_F","C_Offroad_01_F","C_Quadbike_01_F"] call RETURNRANDOM, [(getposATL _lP select 0)+1000-(random 2000),(getposATL _lP select 1)+1000-(random 2000),0], [], 0, "NONE"];
_veh setdir _dir;
_veh setpos _pos;
_veh getvariable ["AmCrate",1];
sleep 0.1;
if !("CivHelp" in (SaOkmissionnamespace getvariable "Progress")) then {_veh lock true;};
_cars set [count _cars,_veh];
sleep 1;
_veh setpos _pos;
};
};
sleep 3;
};
};

{
[_x] SPAWN {
private ["_unit"];
_unit = _this select 0;
waituntil {sleep 5; isNull _unit || {{_unit distance (vehicle _x) < 150} count ([WEST] CALL AllPf) == 0}};
if (!(isNull _unit) && count crew _unit == 0) then {_unit getvariable ["AmCrate",nil];deletevehicle _unit;};
if (count crew _unit > 0) then {CARS set [count CARS,_unit];};
};
} foreach _cars;
sleep 2;
};

