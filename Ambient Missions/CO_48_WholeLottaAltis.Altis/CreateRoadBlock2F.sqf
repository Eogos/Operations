//[_Roadpos] SPAWN F_GREENROADBLOCK;
private ["_p","_R","_cRoads","_rA","_rB","_di","_rCenter","_life","_rad","_p2","_data","_p2b","_p3","_o","_p2c","_p4","_gds","_ucc","_classes","_group","_nul"];
_p = _this select 0;

_R = ((_p nearroads 20) select 0);
_cRoads = roadsConnectedTo _R;
if (count _cRoads != 2) exitWith {};
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
_post = createVehicle ["Land_BagBunker_Small_F", _p3, [], 0, "CAN_COLLIDE"];
_post setdir (_di+270);
[_post] CALL GUARDPOST;
_post setvariable ["IsRoadBlock",1,true];
_post allowdamage false;
_post setvariable ["StaticW",[],true];
_post setvariable ["StaticO",[],true];
_post setvariable ["StaticOS",[],true];
_post setvariable ["NotReady",1,true];

_rad = _di + 180;
_p2c = [(_rCenter select 0)+((sin _rad)*-7),(_rCenter select 1)+((cos _rad)*-7),0];
_rad = _di + 90;
_p4 = [(_p2c select 0)+((sin _rad)*7),(_p2c select 1)+((cos _rad)*7),0];
_o = createVehicle ["Land_BagBunker_Small_F", _p4, [], 0, "CAN_COLLIDE"];
_o setdir (_di+90);
_life = _life + [_o];
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
{
_class = typeof _x;
_earlier = _post getvariable "StaticO";
_id = "N"+(format["%1",count _earlier]);
_p = getposATL _x;
_wTm = _x worldToModel _p;
_p = [(_p select 0)+(_wTm select 0),(_p select 1)+(_wTm select 1),0];
_post setvariable ["StaticO",_earlier + [[_class,_p, direction _x, (surfaceNormal (getposATL _x)),_id]],true];
deletevehicle _x;
} foreach _life;
_ran = ["AA-Team","AT-Team"] call RETURNRANDOM;
{
_post setvariable [_x,1,true];
} foreach ["MG-Team",_ran,"Sniper-Team","Medic-Team"];
_post setvariable ["NotReady",nil,true];
_dis = (["Lb"] CALL DIS);
if ({_x distance _post < _dis} count ([] CALL AllPf) > 0) then {_aika = time + 100; waitUntil {sleep 2; _post in activatedPost || {_aika < time}};sleep 5;_post CALL SAOKCONSRESETOBJ;};





