private ["_side","_change"];
_side = _this select 0;
_change = _this select 1;
if (_side == WEST) then {
pisteet = pisteet + _change;publicVariable "pisteet";
} else {
pisteetE = pisteetE + _change;publicVariable "pisteetE";
};

//_n = [WEST,_price] SPAWN PrestigeUpdate;