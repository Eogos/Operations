private ["_pos","_color","_classes","_mar2","_mar","_mT","_si"];
_pos = _this select 0;
_color = _this select 1;
_classes = _this select 2;
NUMM=NUMM+1;
_mar = if (!(count _this > 5) || {(_this select 5) in allMapMarkers}) then {format ["VVZoneM%1",NUMM]} else {_this select 5};
while {_mar in allMapMarkers} do {NUMM=NUMM+1; _mar = format ["VVZoneM%1",NUMM]};
_mar2 = createMarker [_mar,_pos];
_mar2 setMarkerShape "ICON";
_mT = if (_color == "colorRed") then {
if !(_classes select 0 isKindOf "Air") then {"o_armor"} else {"o_air"}
} else {
if !(_classes select 0 isKindOf "Air") then {"b_armor"} else {
if (_classes select 0 isKindOf "Helicopter") then {
"b_air"
} else {
"b_plane"
}
}
};
if (count _this > 3) then {_mT = _this select 3;};
_mar2 setMarkerType _mT;
//(size _x)
_si = 0.65 + (0.15*(count _classes));
_mar2 setMarkerSize [_si,_si];
_mar2 setMarkerColor _color;
_tex = "";
if (count _this > 4 && {typename (_this select 4) == "STRING"}) then {_tex = (_this select 4);};
_mar2 setMarkerText _tex;
VEHZONES pushBack _mar2;
VEHZONESA pushBack _mar2;
publicVariable "VEHZONESA";
[_mar,_classes] CALL SAOKZONED;
_mar2