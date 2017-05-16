private ["_class","_tg1","_wp","_Ppos","_posPl","_tg1wp1","_nul","_ty","_t","_xx","_c","_inf","_tank","_LZ","_isWpos","_params","_nC","_rrr"];
//if (vehicle player != player && {typeof (vehicle player) iskindof "Air"}) exitWith {};
{
if (leader _x distance (_this select 0) < 1300) then {
_x SPAWN SAOKREMOVEWAYPOINTS; 
_wp = _x addWaypoint [[((_this select 0) select 0) + 300 - random 600,((_this select 0) select 1) + 300 - random 600,0], 0];
};
sleep 0.1;
} foreach VehicleGroups;
_nC = ["ColorRed",(_this select 0)] CALL NEARESTCAMP;
{
if (leader _x distance (_this select 0) < 1300) then {
_x SPAWN SAOKREMOVEWAYPOINTS; 
if ((_this select 0) distance getmarkerpos _nC < 200 && {leader _x distance getmarkerpos _nC < 300}) then {
CAMPREINFAR pushBack [_nC,(units _x)];
_wp = _x addWaypoint [[((_this select 0) select 0) + 30 - random 60,((_this select 0) select 1) + 30 - random 60,0], 0];
_wp setWaypointType "GUARD";
} else {
_wp = _x addWaypoint [[((_this select 0) select 0) + 300 - random 600,((_this select 0) select 1) + 300 - random 600,0], 0];
};
};
sleep 0.1;
} foreach Pgroups;
if (count ([WEST] CALL AllPf) == 0) exitWith {};
_t = 0;
_rrr = [2,3,4] call RETURNRANDOM;
if ([(_this select 0),"ColorRed"] CALL SAOKNEARVZNUM < 3) then {
_c = count VEHZONES - 1;
for "_i" from 0 to _c do {
if !(count VEHZONES > _i) exitWith {};
_xx = VEHZONES select _i;
if (!isNil"_xx" && {!(getmarkertype _xx in ["o_art","o_support","o_mortar","o_med"])}) then {
if (getmarkercolor _xx == "ColorRed" && {!(_xx CALL SAOKVZMOVING)}) then {
sleep 0.1;
if (!([getmarkerpos _xx,(_this select 0)] CALL SAOKWATERBETWEEN) || {getmarkertype _xx in ["o_air","o_uav","o_plane"]}) then {
_wp = [(_this select 0),100,0,"(1 - sea)"] CALL SAOKSEEKPOS;  
[_xx, _wp] SPAWN ZoneMove;
_t = _t + 1;
};
};
};
if (_t >= _rrr) exitWith {};
sleep 0.1;
};
};
//[(_this select 0)] SPAWN SAOKSHF2;
[[(_this select 0)],"SAOKSHF2",nil,false] spawn BIS_fnc_MP;
[(_this select 0),"SolidBorder","ColorRed",300] SPAWN SAOKCREATEMARKERA;
sleep 30; 

if (random 1 < 0.3) then {
_class = (["AIRF",1] CALL VEHARRAY)+(["AIRARMC",1] CALL VEHARRAY); 
_class = _class call RETURNRANDOM;	
_Ppos = _this select 0;
_tg1 = [[(_Ppos select 0)+2500,(_Ppos select 1)+2500,50], 0, _class, EAST] call SPAWNVEHICLE;
_posPl = [(_Ppos select 0) + 100 -(random 200), (_Ppos select 1)+ 100 -(random 200), 0];
_tg1wp1= (_tg1 select 2) addWaypoint [_posPl, 0]; 
[(_tg1 select 2), 1] setWaypointBehaviour "AWARE";
[(_tg1 select 2), 1] setWaypointType "GUARD";
_nul = [(_tg1 select 2), [1541.39,5059.05,0],200] SPAWN FUNKTIO_MAD;
_ty = (getText (configfile >> "CfgVehicles" >> _class >> "displayName"));
_nul = [(_tg1 select 0),_ty] SPAWN SAOKSHF3; 
sleep 30;
{
if (side _x == EAST && {{alive _x} count units _x > 1} && {(leader _x) distance (_this select 0) < 1500}) then {
_x SPAWN SAOKAISMOKEGREEN;
};
sleep 0.1;
} foreach allGroups;
} else {
_nul = [EAST,ENEMYC3,([4,5,6] call RETURNRANDOM),(_this select 0), 80,{_this addWaypoint [getposATL (leader _this), 0]; [_this, 1] setWaypointType "GUARD";}] SPAWN InfFromHouse;
_isWpos = [(_this select 0), 1800, 400] CALL SAOKSEARCHPOS;
if (surfaceiswater _isWpos) then {
_Ppos = _this select 0;
_posPl = [(_Ppos select 0) + 100 -(random 200), (_Ppos select 1)+ 100 -(random 200), 0];
_inf = ["O_Soldier_AR_F","O_soldier_exp_F","O_soldier_M_F","O_medic_F"];
_tank = ["O_Boat_Armed_01_hmg_F","O_Boat_Transport_01_F"] call RETURNRANDOM; 
_LZ = [_isWpos,_posPl] CALL SAOKSEEKSHORE;  
_isWpos = _isWpos CALL SAOKCORRECTSEASTART;
_params = [_isWpos, _LZ, _posPl, EAST, 90, _tank,_inf,[0.6,0.7],0,""];
_nul = _params SPAWN FUNKTIO_LandTransport;
};

};

