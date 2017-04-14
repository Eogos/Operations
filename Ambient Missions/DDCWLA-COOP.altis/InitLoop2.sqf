
private ["_nul","_y","_nP","_copy","_c"];
SAOKnP = {
private ["_nP","_d","_copy"];
_copy = + ([] CALL AllPf);
_d = dataStorageS;
if (count _copy > 0) then {
_copy = [_copy,[_this],{(_this select 0) distance _x},"ASCEND"] call BIS_fnc_sortBy;
_d = (_copy select 0);
};
_d
};

if (count alldead > 15) then {
_copy = + allDead;
//if ((([] CALL AllPf) select 0) != dataStorageS) then {_copy = [_copy,[],{(_x call SAOKnP) distance _x},"ASCEND"] call BIS_fnc_sortBy;};
_c = count _copy - 1;
while {count alldead > 15} do {deletevehicle (_copy select _c); sleep 0.1;_c = _c - 1;};
};

sleep 1;
{
if !(_x in (([] CALL AllPf)+vehicles+[BaseR])) then {
_y = _x;
	if(!(_x isKindOf "Animal")) then {
	
	if (({vehicle _x distance _y < 200} count ([] CALL AllPf) == 0 || {count AllDeadMen > 20}) && {isNil {_x getvariable "WaitingD"}}) then {_x setvariable ["WaitingD",1];_nul =[_x] SPAWN {sleep 50; waituntil {sleep 15; isNull (_this select 0) || {{vehicle _x distance (_this select 0) < 50} count ([] CALL AllPf) ==0 } || {(count AllDeadmen > 70 && {{vehicle _x distance (_this select 0) < 20} count ([] CALL AllPf) == 0})}}; if (!isNull (_this select 0)) then {[(_this select 0)] SPAWN FUNKTIO_DELUNIT;};};} 
	else {};
	};	
};	
} foreach (allDead); 
sleep 20;
{if ((count crew _x) == 0 || {!(alive driver _x)}) then {_nul = [_x] SPAWN FUNKTIO_POISTAKARRY;};} forEach CARS;