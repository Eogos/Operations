CGTasks = CGTasks + 1;
_ranP = [random 15000,random 15000,0];
_roads = (_ranP nearRoads 450);
while {count _roads == 0} do {
_ranP = [random 15000,random 15000,0];
_roads = (_ranP nearRoads 450);
};
_locat = getposATL (_roads select 0);
_side = [WEST,EAST]call RETURNRANDOM;
_Tid = format ["TaskCreg%1",NUMM];
NUMM=NUMM+1;
_Lna = _locat CALL NEARESTLOCATIONNAME;
_header = format ["Create Guardpost next to marked road near %1",_Lna];
_desc =("We need to get control of this road by creating guardpost inside 100m radius from this point with at least one static weapon or vehicle");
[
_side, // Task owner(s)
_Tid, // Task ID (used when setting task state, destination or description later)
[_desc, _header, _header], // Task description
_locat, // Task destination
"CREATED" // true to set task as current upon creation
] call BIS_fnc_taskCreate;
_Mcolor = "ColorGreen";
if (_side == EAST) then {_Mcolor = "ColorRed";};
waitUntil {sleep 8; _locat distance (getposATL ([_locat] CALL RETURNGUARDPOST)) < 100 && {count (([_locat] CALL RETURNGUARDPOST) getvariable "StaticW") > 0} && (getmarkercolor (([_locat] CALL RETURNGUARDPOST) getvariable "Gmark")) == _Mcolor};
_nul = [_Tid,"SUCCEEDED"] call BIS_fnc_taskSetState;
[_locat,_side] SPAWN ADDR;
_n = [_side,350] SPAWN PrestigeUpdate;
[[350, "RoadBlock Created",_side],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
CGTasks = CGTasks - 1;