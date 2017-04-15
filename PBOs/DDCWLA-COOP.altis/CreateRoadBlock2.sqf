
private ["_p","_R","_cRoads","_rA","_rB","_di","_rCenter","_life","_rad","_p2","_data","_p2b","_p3","_o","_p2c","_p4","_gds","_ucc","_classes","_group","_nul"];
_p = _this select 0;
if ({_p distance _x < 10} count RBLOCATIONS > 0) exitWith {if (count _this < 2) then {TOTALRO = TOTALRO - 1;};};
RBLOCATIONS set [count RBLOCATIONS, _p];
_R = ((_p nearroads 20) select 0);
_cRoads = roadsConnectedTo _R;
if (count _cRoads != 2) exitWith {if (count _this < 2) then {TOTALRO = TOTALRO - 1;};};
_rA = getposATL (_cRoads select 0);
_rB = getposATL (_cRoads select 1);
_di = [_rB, _rA] call BIS_fnc_dirTo;

_rCenter = getposATL _R;

_life = [];

_rad = _di + 90;
_p = [(_rCenter select 0)+((sin _rad)*20),(_rCenter select 1)+((cos _rad)*20),0];
_rad = _di + 270;
_p2 = [(_rCenter select 0)+((sin _rad)*20),(_rCenter select 1)+((cos _rad)*20),0];
_ranW = ["Land_BagFence_Long_F","Land_HBarrier_3_F","Land_HBarrier_3_F"] call RETURNRANDOM;
if (count _this < 2) then {
_data = [_p,_p2,_ranW] CALL FUNKTIO_DrawFence;
_life = _life + (_data select 0);
};

_rad = _di + 180;
_p2b = [(_rCenter select 0)+((sin _rad)*7),(_rCenter select 1)+((cos _rad)*7),0];
_rad = _di + 270;
_p3 = [(_p2b select 0)+((sin _rad)*7),(_p2b select 1)+((cos _rad)*7),0];
_o = createVehicle ["Land_BagBunker_Small_F", _p3, [], 0, "CAN_COLLIDE"];
_o setdir (_di+270);
_life = _life + [_o];

_rad = _di + 180;
_p2c = [(_rCenter select 0)+((sin _rad)*-7),(_rCenter select 1)+((cos _rad)*-7),0];
_rad = _di + 90;
_p4 = [(_p2c select 0)+((sin _rad)*7),(_p2c select 1)+((cos _rad)*7),0];
_o = createVehicle ["Land_BagBunker_Small_F", _p4, [], 0, "CAN_COLLIDE"];
_o setdir (_di+90);
_life = _life + [_o];
_gds = [];
_ucc = [ENEMYC1,ENEMYC2,ENEMYC3] call RETURNRANDOM;
_classes = [_ucc call RETURNRANDOM];
_group = [_p3, EAST, _classes,[],[],[0.4,0.8]] call SpawnGroupCustom;
leader _group setpos _p3;
leader _group setunitpos "UP";
leader _group setformdir (_di+90);
_gds = _gds + [leader _group];
_classes = [_ucc call RETURNRANDOM];
_group = [_p4, EAST, _classes,[],[],[0.4,0.8]] call SpawnGroupCustom;
leader _group setpos _p4;
leader _group setunitpos "UP";
leader _group setformdir (_di+270);
_gds = _gds + [leader _group];

_life = _life + _gds;
_rad = _di + 180;
//+((sin _rad)*(-2))
_p = [(_rCenter select 0)+((sin _rad)*2),(_rCenter select 1)+((cos _rad)*2),0];
_o = createVehicle ["Land_BarGate_F", _p, [], 0, "CAN_COLLIDE"];
_wTm = _o worldToModel _p;
_o allowdamage false;
_p = [(_p select 0)+(_wTm select 0),(_p select 1)+(_wTm select 1),0];
sleep 0.5;
_o setpos _p;
_o setdir _di;
_o allowdamage false;
_life = _life + [_o];

//RAN VEH GUARD
if (random 1 < 0.3) then {
_class = ["O_GMG_01_F","O_GMG_01_high_F"]call RETURNRANDOM;
_st = [_rCenter, 40,"(1 + meadow)  * (1 - sea) * (1 - hills)",""] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
while {isOnRoad _start || {_rCenter distance _start < 15}} do {
sleep 1;
_st = [_rCenter, 50,"(1 + meadow)  * (1 - sea) * (1 - hills)",""] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
};
_classes = ENEMYC1 call RETURNRANDOM;

_obj = createVehicle [_class, _start, [], 0, "NONE"]; 
_group = [_start, EAST, [_classes],[],[],[0.4,0.8]] call SpawnGroupCustom;
_obj setvectorup (surfaceNormal (getposATL _obj));
_dir = random 360;
_obj setdir _dir;
_group setformdir _dir;
leader _group moveingunner _obj;
_life = _life + [leader _group,_obj];
_obj lock 2;
};

_nul = [_o,_gds] SPAWN {

private ["_o","_gds","_gP"];
_o = _this select 0;
_gds = _this select 1;
_gP = (getposATL _o);
while {!isNull _o && {{!alive _x} count _gds == 0}} do {  
waitUntil {sleep 1; isNull _o || {{!alive _x} count _gds > 0} || {{count crew _x > 0 && {(!isPlayer driver _x)}} count (_gP nearEntities [["Car"],30]) > 0}}; 
if (isNull _o || {{!alive _x} count _gds > 0}) exitWith {};
_o animate ["Door_1_rot", 1];  
waitUntil {sleep 1; isNull _o || {{!alive _x} count _gds > 0}  || {{count crew _x > 0 && {(!isPlayer driver _x)}} count (_gP nearEntities [["Car"],30]) == 0}}; 
if (isNull _o || {{!alive _x} count _gds > 0}) exitWith {};
_o animate ["Door_1_rot", 0];  
};  
};

waitUntil {sleep 10; {(vehicle _x) distance _rCenter < 1500} count ([] CALL AllPf) == 0 || {{isNull _x} count _gds > 0 && {{(vehicle _x) distance _rCenter < 1000} count ([] CALL AllPf) == 0}}};
{deletevehicle _x;} foreach _life; 
if (count _this < 2) then {TOTALRO = TOTALRO - 1;};
//[_someId3, "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
{if (_x distance _p < 5) exitWith {RBLOCATIONS = [RBLOCATIONS,_forEachIndex] call BIS_fnc_removeIndex;};} foreach RBLOCATIONS;
//hint format ["%1",_cRoads]; "Land_BagBunker_Small_F" "Land_BagFence_Long_F"
