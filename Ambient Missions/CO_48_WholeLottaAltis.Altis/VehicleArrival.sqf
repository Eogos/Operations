//"B_G_Offroad_01_F"
private ["_vClass","_vRoom","_unitsG","_cU","_c","_all","_cars","_driver","_aU","_obj","_veh","_group","_side","_end","_start","_st","_startV","_wp1"];
_group = _this select 0;
_side = _this select 1;
_end = _this select 2;

_sC = {
private ["_bol"];
_bol = true;
if (!isNil{_x getvariable "StuckP"} && {(_x getvariable "StuckP") distance (getposATL _x) < 2}) then {_bol = false;} else {_x setvariable ["StuckP",(getposATL _x)];};
_bol
};

_start = [(_end select 0)+700-(random 1400),(_end select 1)+700-(random 1400),0];
while {surfaceiswater _start || {{vehicle _x distance _start < 400} count ([] CALL AllPf) > 0}} do {_start = [(_end select 0)+700-(random 1400),(_end select 1)+700-(random 1400),0]; sleep 0.1;};

_veh = ["B_G_Offroad_01_F",6];
switch _side do {
//VEH ZONE "O_Truck_03_covered_F","O_Truck_03_transport_F",
case EAST: {_veh = [["O_Truck_03_transport_F",9],["O_Truck_03_covered_F",9],["B_G_Offroad_01_F",6],["B_G_Quadbike_01_F",2],["O_Truck_02_covered_F",9],["O_Truck_02_transport_F",9],["O_MRAP_02_F",3]] call RETURNRANDOM;};
case WEST: {_veh = [["B_G_Offroad_01_F",6],["B_G_Quadbike_01_F",2],["I_MRAP_03_F",3],["I_Truck_02_covered_F",9],["I_Truck_02_transport_F",9]] call RETURNRANDOM;};
};
if (count _this > 3 && {count (_this select 3) > 0}) then {
_veh = _this select 3;
};
_vClass = _veh select 0;
_vRoom = _veh select 1;
_unitsG = units _group;
_cU = count _unitsG;
cVar = [];
_all = [];
{
private ["_c"];
cVar = cVar + [_x];
if (count cVar >= _vRoom) then {_c = + cVar;_all = _all + [_c];cVar = [];};
} foreach _unitsG;
if (count cVar > 0) then {_c = + cVar;_all = _all + [_c];};
cVar = nil;
_cars = [];
{
private ["_au","_st","_startV","_obj","_driver"];
_st = [_start, 100,"(1 - sea) * (1 + meadow)* (1 - hills)",""] CALL FUNKTIO_POS;
_startV = (_st select 0) select 0;
_driver = (_x select 0);
_aU = _x - [_driver];
_obj = createVehicle [_vClass,_startV, [], 0, "NONE"]; 
_cars = _cars + [_obj];
_driver moveindriver _obj;
{_x moveincargo _obj;} foreach _aU;
} foreach _all;
//if (count _this > 4) then {_wp1 = _group addWaypoint [_end, 0];};

_wp1 = _group addWaypoint [_end, 0];

sleep 25;
waitUntil {sleep 8; {!isNull _x} count _unitsG == 0 || {{!isNil"_x"} count _unitsG == 0} || {{alive _x} count _unitsG == 0} || {{_x distance _end < 50 || behaviour _x == "COMBAT"} count _unitsG > 0} || {{_x distance _end < 30} count _cars > 0} || {{!(_x call _sC)} count _cars > 0}};
_unitsG ordergetin false;
{unassignvehicle _x;} foreach _unitsG;
{CARS = CARS + [_x];_x SPAWN {waitUntil {sleep 2; isNull _this || {count crew _this == 0}};if (!isNull _this) then {[_this,0] SPAWN VehLife;};waitUntil {sleep 2; isNull _this || {count crew _this > 0}};if (!isNull _this) then {[_this,1] SPAWN VehLife;};};} foreach _cars;
if ({alive _x} count _unitsG > 0 && {count _this > 5}) then {
_nul = [_unitsG] SPAWN AICampBehaviour;
};
