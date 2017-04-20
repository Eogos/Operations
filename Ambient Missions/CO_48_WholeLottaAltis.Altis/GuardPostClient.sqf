private ["_gua","_ordercode"];
_gua = _this select 0;
[[_gua,side player,player],"F_GUARDPOSTCLIENT",false,false] spawn BIS_fnc_MP;