private ["_ordercode"];

_ordercode = {
_t = _this select 0;
_text = format ["Units %1 Groups %2 DeadUnits %3 Vehicles %4 FPS %5 CIVLIANS %6 EAST %7 WEST %8 OBJECTS %9 ENTITES %10",count Allunits, count allgroups, count alldeadmen, count vehicles,diag_fps, {side _x == CIVILIAN} count allunits, {side _x == EAST} count allunits, {side _x == WEST} count allunits,count allMissionObjects "All",count entities "All"];
_ordercode = {
_text = _this select 0;
hint _text;
};
//server_object setVariable ["playerorders", [_text,_ordercode], true];
};
//server_object setVariable ["serverorders", ["",_ordercode], true];


/*
_text = format ["%1",CARS];
hint _text;
{NUMM=NUMM+1;  _name = format ["Agemar%1",NUMM];  _mar3 = createMarker [_name,getposATL _x];  _mar3 setMarkerShape "ICON";  _mar3 setMarkerType "mil_triangle";  _mar3 setMarkerSize [0.5,0.5];  _mar3 setMarkerColor "ColorBlack";  _mar3 setMarkerText " A";} foreach (allMissionObjects "All");
*/