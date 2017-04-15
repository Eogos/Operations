private ["_maksaa","_pos","_nul","_ordercode"];
_maksaa = if(count _this > 1) then {_this select 1} else {400};
if (([side player] CALL PrestigeS) >= _maksaa) then {
_n = [side player,(-1*_maksaa)] SPAWN PrestigeUpdate;
[[-_maksaa, "Received Vehicle",WEST],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
_pos = getposATL vehicle player;
_nul = [_pos,_this select 0] SPAWN FSupportDrop;
} else {
if (([side player] CALL PrestigeS) < _maksaa) then {
(format ["%1 more prestige value needed to receive vehicle",(_maksaa- ([side player] CALL PrestigeS))]) SPAWN HINTSAOK;
};
};

