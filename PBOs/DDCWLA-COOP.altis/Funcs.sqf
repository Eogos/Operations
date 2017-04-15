
if (isServer) then {
F_GUARDPOSTCLIENT = {
private ["_col","_typ","_mar","_marker","_data","_gua"];
_gua = _this select 0;
if ({_x distance _gua < 30} count GuardPosts == 0) then {
_col = "ColorGreen";_typ = "n_installation";
if ((_this select 1) == EAST) then {_col = "ColorRed";_typ = "o_installation";};
_mar = format ["GuardPMM%1",NUMM];
NUMM=NUMM+1;
_marker = createMarker [_mar,getposATL _gua];
_marker setMarkerShape "ICON";
_marker setMarkerType _typ;
_marker setMarkerSize [0,0];
_marker setMarkerColor _col;
_marker setMarkerText "";
_gua setvariable ["Gmark",_mar,true];
_gua setvariable ["GCreator", name (_this select 2), true];
GuardPosts pushback _gua;
publicvariable "GuardPosts";
_data = [(_this select 1),_gua] call BIS_fnc_addRespawnPosition;
_gua setvariable ["Resp",_data];
};
};
};

if !(isDedicated) then {

};