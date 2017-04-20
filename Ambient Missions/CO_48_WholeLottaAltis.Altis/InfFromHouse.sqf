private ["_side","_arr","_num","_pos","_range","_sHou","_building","_c","_array","_ran","_group","_waypoints"];
_side = _this select 0;
_arr = _this select 1;
_num = _this select 2;
_pos = _this select 3;
_range  = _this select 4;
_sHou = [(_pos select 0)+ _range - (random _range)*2, (_pos select 1)+ _range - (random _range)*2, 0];
_building = nearestBuilding _sHou;
while {{_x distance (getposATL _building) < 200} count ([] CALL AllPf) > 0} do {
_range = _range + 200;
sleep 1;
_sHou = [(_pos select 0)+ _range - (random _range)*2, (_pos select 1)+ _range - (random _range)*2, 0];
_building = nearestBuilding _sHou;
};

_waypoints = [];
_c = 0;
_array = _building buildingPos _c;
while {str(_array) != "[0,0,0]"} do {	
_waypoints set [count _waypoints,_c];
_c = _c + 1;
_array = _building buildingPos _c;
};
if (count _waypoints > 0) then {

_ran = [];
for "_i" from 0 to _num do {
_ran = _ran + [_arr call RETURNRANDOM];
};
_group = [[1000,1000,0], _side, _ran,[],[],[0.3,0.5]] call SpawnGroupCustom;
{
_pos = _building buildingPos (_waypoints call RETURNRANDOM);
_x setpos _pos;
} foreach units _group;
if (_side == EAST) then {Pgroups set [count Pgroups,_group];} else {FriendlyInf set [count FriendlyInf,_group];};
if (count _this > 5) then {_group SPAWN (_this select 5);};
};

//E.g. _nul = [EAST,ENEMYC3,4,getposATL player, 80] SPAWN InfFromHouse;

//_nul = [EAST,ENEMYC3,14,getposATL player, 80,{_this addWaypoint [getposATL player, 0]; {_c = [_x] SPAWN ConvertToArmedCivilianL;} foreach units _this;}] SPAWN InfFromHouse;