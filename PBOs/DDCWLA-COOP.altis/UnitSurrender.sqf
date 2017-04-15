
private ["_unit", "_g", "_nul"];
//////////////////////////////////////////////////////////////////
// Function file for Armed Assault
// Created by: TODO: Author Name
//////////////////////////////////////////////////////////////////
sleep (random 39);
_unit = _this select 0;
if (alive _unit) then {
_g = creategroup EAST;	
[_unit] join _g;
_unit setcaptive true;
_unit stop true;
_unit setunitpos "UP";
removeAllWeapons _unit;	
sleep 1;};
if (alive _unit) then {
//_unit playMoveNow "AmovPercMstpSnonWnonDnon_AmovPercMstpSsurWnonDnon";
[[_unit,"AmovPercMstpSnonWnonDnon_AmovPercMstpSsurWnonDnon"],"SAOKPMOVE",nil,false] spawn BIS_fnc_MP;
};
if (alive _unit) then {_nul = [_unit] SPAWN FUNKTIO_POISTANTAUTUNUT;};
