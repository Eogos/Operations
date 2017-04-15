private ["_pos","_side","_dis","_marker"];
_pos = _this select 0;
_side = _this select 1;
_dis = if (count _this > 2) then {_this select 2} else {400};
//GuardPosts (_x getvariable "Gmark")
{
_marker = (_x getvariable "Gmark");
if (_x distance _pos < _dis && {markertext _marker == ""}) then {
if ((_side == "EAST" && {getmarkercolor _marker == "ColorGreen"}) || {(_side != "EAST" && {getmarkercolor _marker == "ColorRed"})}) then {
if (_side == "EAST") then {
(_x getvariable "Resp") call BIS_fnc_removeRespawnPosition; 
_data = [EAST,_x] call BIS_fnc_addRespawnPosition;
_typ = "o_installation";
_marker setmarkercolor "ColorRed";
[[_marker,"ColorRed"],"SAOKMARKCOL",nil,false] spawn BIS_fnc_MP;
if (!isNil{_x getvariable "supplyDepot"}) then {_typ = "o_service";};
_marker setMarkerType _typ;
if (_x in activatedPost) then {_x CALL SAOKCONSCHANGESIDE;};
_marker setMarkerSize [0,0];
if (!isNil{_x getvariable "PowCells"}) then {
_ar = (_x getvariable "PowCells");
{_ar set [_foreachIndex,[_x select 0,""]];} foreach _ar;
_x setvariable ["PowCells",_ar];
};
} else  {
(_x getvariable "Resp") call BIS_fnc_removeRespawnPosition; 
_data = [WEST,_x] call BIS_fnc_addRespawnPosition;
_typ = "n_installation";
if (!isNil{_x getvariable "supplyDepot"}) then {_typ = "n_service";};
_marker setMarkerType _typ;
_marker setmarkercolor "ColorGreen";
[[_marker,"ColorGreen"],"SAOKMARKCOL",nil,false] spawn BIS_fnc_MP;
if (_x in activatedPost) then {_x CALL SAOKCONSCHANGESIDE;};
};
};
};
} foreach GuardPosts;
[] SPAWN SAOKLINES;