private ["_R","_walls2","_walls","_nnn","_clcl","_benc","_ang","_radius","_start","_To","_To2","_size","_ToP","_Tp","_r2","_Tower","_class","_earlier","_id","_forEachIndex","_p","_type","_rad","_ran","_wallT","_post"];
_p = _this select 0;
if (surfaceIsWater _p) exitWith {};
_type = _this select 1;
_rad = _this select 2;

_ff = {
private ["_post","_class","_pos","_dir"];
_post = _this select 0;
_class = _this select 1;
_pos = _this select 2;
_dir = _this select 3;
_earlier = _post getvariable "StaticO";
_id = "N"+(format["%1",count _earlier]);
_post setvariable ["StaticO",_earlier + [[_class,_pos, _dir, (surfaceNormal _pos),_id]],true];
};

_ran = ["Land_Shoot_House_Wall_Long_F","Land_HBarrier_5_F","Land_Mil_WallBig_4m_F","Land_CncWall4_F","Land_CncWall4_F","Land_HBarrierWall6_F","Land_BagFence_Long_F","Land_BagFence_Long_F","Land_HBarrier_3_F","Land_HBarrierBig_F","Land_HBarrierWall4_F"] call RETURNRANDOM;
_wallT = if (count _this > 3) then {_this select 3} else {_ran};
_R = + _p;
if (_type == "RoadB" && {count (_p nearroads 20) > 0}) then {_R = getposATL ((_p nearroads 20) select 0);}; 
_walls = [];
//_walls = [getposATL player,20,"Land_Shoot_House_Wall_Long_F"] CALL FUNKTIO_DrawCircle;
if (random 1 < 0.5) then {
_walls2 = ([_R,_rad,_wallT,""] CALL FUNKTIO_DrawBox);
deletevehicle (_walls2 call RETURNRANDOM);
deletevehicle (_walls2 call RETURNRANDOM);
_walls = _walls + _walls2;
} else {
_walls = _walls + ([_R,_rad,_wallT,""] CALL FUNKTIO_DrawCircle);
};

//WC and other stuff in circle Land_ToiletBox_F  Land_BarrelWater_F  CamoNet_OPFOR_F
_nnn = [1,2,3] call RETURNRANDOM;
_clcl = ["Land_FieldToilet_F","Land_ToiletBox_F"]call RETURNRANDOM;
_walls = _walls + ([_R,((7+random 5)),_clcl,_nnn] CALL FUNKTIO_DrawCircle);

_nnn = [1,2,3] call RETURNRANDOM;
_clcl = ["Land_BarrelWater_F","Land_MetalBarrel_F"]call RETURNRANDOM;
_walls = _walls + ([_R,((7+random 5)),_clcl,_nnn] CALL FUNKTIO_DrawCircle);

if (random 1 < 0.5) then {
_nnn = [1,2,3] call RETURNRANDOM;
_clcl = ["CamoNet_OPFOR_F","CamoNet_OPFOR_open_F"]call RETURNRANDOM;
_walls = _walls + ([_R,((12+random 5)),_clcl,_nnn] CALL FUNKTIO_DrawCircle);
};
if (random 1 < 0.5) then {
_nnn = [1] call RETURNRANDOM;
_clcl = ["MapBoard_altis_F","MapBoard_stratis_F","Land_MapBoard_F"]call RETURNRANDOM;
_walls = _walls + ([_R,((7+random 5)),_clcl,_nnn] CALL FUNKTIO_DrawCircle);
};

_size = [0,1] call RETURNRANDOM;
for "_i" from 0 to _size do {
//TABLE OR FIREPLACE with benches
_clcl = ["Land_CampingTable_small_F","Land_CampingTable_F","Land_Campfire_F","Campfire_burning_F","Land_WoodenLog_F","Land_WoodenTable_large_F","Land_WoodenTable_small_F","Land_Pallets_stack_F"]call RETURNRANDOM;
_ang = random 360;
_radius = 6 + (random 5);
_start = [(_R select 0)+((sin _ang)*_radius),(_R select 1)+((cos _ang)*_radius),0];
_To2 = createVehicle [_clcl, _start, [], 0, "NONE"];
_To2 setdir (random 360);
_walls = _walls + [_To2];
_size = [0,1,2,3] call RETURNRANDOM;
_ang = random 360;
_ToP = getposATL _To2;
for "_i" from 0 to _size do {
_benc = ["Land_Sleeping_bag_brown_F","Land_Sleeping_bag_brown_folded_F","Land_Bench_F","Land_ChairPlastic_F","Land_ChairWood_F","Land_CampingChair_V1_F","Land_CampingChair_V1_folded_F","Land_CampingChair_V2_F"] call RETURNRANDOM;
_ang = _ang + (30+random 60);
_radius = 1 + (random 1);
_start = [(_ToP select 0)+((sin _ang)*_radius),(_ToP select 1)+((cos _ang)*_radius),0];
_To = createVehicle [_benc, _start, [], 0, "NONE"];
_To setdir (random 360);
_walls = _walls + [_To];
};
};

_size = [0,1,2,3] call RETURNRANDOM;
for "_i" from 0 to _size do {
//RANDOM LAMPS
_clcl = ["Land_PortableLight_single_F","Land_PortableLight_double_F","Land_Camping_Light_F"]call RETURNRANDOM;
_ang = random 360;
_radius = 5 + (random 8);
_start = [(_R select 0)+((sin _ang)*_radius),(_R select 1)+((cos _ang)*_radius),0];
_To = createVehicle [_clcl, _start, [], 0, "NONE"];
_To setdir (random 360);
_walls = _walls + [_To];
};


_r2 = 5;
_Tp = [(_R select 0),(_R select 1),-0.2];
while {count (_Tp nearroads 12) > 0} do {_Tp = [(_R select 0)+_r2 - (random _r2)*2,(_R select 1)+_r2 - (random _r2)*2,-0.2];sleep 0.1;_r2 = _r2 + 5;};
_ran = ["Land_Cargo_Patrol_V2_F","Land_Cargo_HQ_V1_F","Land_BagBunker_Large_F","Land_BagBunker_Tower_F","Land_HBarrierTower_F"] call RETURNRANDOM;
_Tower = createVehicle [_ran, _Tp, [], 0, "NONE"];
_Tower setdir (random 360);
if (_ran in ["Land_BagBunker_Large_F","Land_BagBunker_Tower_F","Land_HBarrierTower_F"]) then {_Tower setvectorup (surfaceNormal (getposATL _Tower));};
[_Tower,""] CALL GUARDPOST;
_post = ([(getposATL _Tower)] CALL RETURNGUARDPOST);
_post setvariable ["StaticW",[],true];
_post setvariable ["StaticO",[],true];
_post setvariable ["Vallattu",1,true];

if (_rad < ((_Tp distance _p)+(0.4*_rad))) then {
if (random 1 < 0.5) then {
_walls2 = ([_Tp,(0.4*_rad),"Land_BagFence_Long_F"] CALL FUNKTIO_DrawBox);
deletevehicle (_walls2 call RETURNRANDOM);
deletevehicle (_walls2 call RETURNRANDOM);
_walls = _walls + _walls2;
} else {
_walls = _walls + ([_Tp,(0.4*_rad),"Land_BagFence_Long_F"] CALL FUNKTIO_DrawCircle);
};
};

_r2 = _rad * 0.5;
if (_type == "RoadB") then {
_Tp = [(_R select 0)+_r2 - (random _rad),(_R select 1)+_r2 - (random _rad),-0.2];
while {count (_Tp nearroads 12) > 0 || {_x distance _Tp < 15} count _walls > 0} do {_Tp = [(_R select 0)+_r2 - (random _rad),(_R select 1)+_r2 - (random _rad),-0.2];sleep 0.1;_r2 = _r2 + 5 + _rad * 0.5;};
_Tower = createVehicle ["Land_Cargo_House_V1_F", _Tp, [], 0, "NONE"];
_Tower setdir (random 360);
_class = typeof _Tower;
_earlier = _post getvariable "StaticO";
_id = "N"+(format["%1",count _earlier]);
_post setvariable ["StaticO",_earlier + [[_class,getposATL _Tower, direction _Tower, (surfaceNormal (getposATL _Tower)),_id]],true];
deletevehicle _Tower;
};

{
_r2 = _rad * 0.5;
_Tp = [(_R select 0)+_r2 - (random _rad),(_R select 1)+_r2 - (random _rad),-0.2];
while {count (_Tp nearroads 12) > 0 || {_x distance _Tp < 7} count _walls > 0} do {_Tp = [(_R select 0)+_r2 - (random _rad),(_R select 1)+_r2 - (random _rad),-0.2];sleep 0.1;_r2 = _r2 + 5 + _rad * 0.5;};
_Tower = createVehicle [_x, _Tp, [], 0, "NONE"];
_Tower setdir (random 360);
_class = typeof _Tower;
_earlier = _post getvariable "StaticO";
_id = "N"+(format["%1",count _earlier]);
_post setvariable ["StaticO",_earlier + [[_class,getposATL _Tower, direction _Tower, (surfaceNormal (getposATL _Tower)),_id]],true];
deletevehicle _Tower;
} foreach ["Land_TentA_F","Land_TentA_F","Land_TentA_F","Land_TentA_F"];


{if (isNil"_x" || {isNull _x}) then {_walls = [_walls,_forEachIndex] call BIS_fnc_removeIndex;};} foreach _walls;
{
_class = typeof _x;
_earlier = _post getvariable "StaticO";
_id = "N"+(format["%1",count _earlier]);
_post setvariable ["StaticO",_earlier + [[_class,getposATL _x, direction _x, (surfaceNormal (getposATL _x)),_id]],true];
deletevehicle _x;
} foreach _walls;

//_n = [(getposATL _Tower),"EAST"] CALL GuardPostSide;
_ran = ["AA-Team","AT-Team"] call RETURNRANDOM;
{
_post setvariable [_x,1,true];
} foreach ["MG-Team",_ran,"Sniper-Team","Medic-Team"];