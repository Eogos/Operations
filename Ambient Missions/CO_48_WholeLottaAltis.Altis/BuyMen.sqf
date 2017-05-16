private ["_group","_pos"];
if (([side player] CALL PrestigeS) >= 200) then {
_n = [side player,(-1*200)] SPAWN PrestigeUpdate;
[[-200, "Received Team-mate",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
_pos = getposATL vehicle player;
_group = [ [(_pos select 0) + 50 - (random 100),(_pos select 1) + 50 - (random 100),0], WEST, [_this select 0],[],[],[0.6,0.9]] call SpawnGroupCustom;


//_houses =  [getposATL leader _group,100];

{
_x setSkill ["aimingaccuracy", 0.30 + (random 0.4)];
_x setSkill ["aimingShake", 0.30 + (random 0.4)];
_x setSkill ["aimingSpeed", 0.30 + (random 0.4)];
_x setSkill ["spotDistance", 0.20 + (random 0.4)];
_x setSkill ["spotTime", 0.35 + (random 0.35)];
_x setSkill ["endurance", 0.35 + (random 0.35)];
_x setSkill ["courage", 0.35 + (random 0.35)];
_x setSkill ["reloadSpeed", 0.35 + (random 0.35)];
_x setSkill ["commanding", 0.15 + (random 0.35)];
_x setSkill ["general", 0.35 + (random 0.35)];
} foreach [leader _group];


{
_waypoints = [];
_c = 0;
_building = objNull;

_sHou = [(_pos select 0) + 100 - (random 200), (_pos select 1) + 100 - (random 200), 0];
_building = nearestBuilding _sHou;


_array = _building buildingPos _c;
while {str(_array) != "[0,0,0]"} do {	
_waypoints set [count _waypoints,_c];
_c = _c + 1;
_array = _building buildingPos _c;
};
if (count _waypoints > 0) then {
_pos = _building buildingPos (_waypoints call RETURNRANDOM);
_x setpos _pos;
};
} foreach units _group;

units _group join player;
} else {
if (([side player] CALL PrestigeS) < 200) then {
(format ["%1 more prestige value needed to receive new team-mate", 200 - ([side player] CALL PrestigeS)])SPAWN HINTSAOK;
} else {

};
};

