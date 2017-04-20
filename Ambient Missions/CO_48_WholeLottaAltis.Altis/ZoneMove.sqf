private ["_gr","_wpPP","_start","_zone","_whereTo","_speed","_marS","_mar5","_type","_c","_time","_dist","_Dx","_Dy","_perSx","_perSy","_w","_msize","_n"];
//{[_x, getposATL player] SPAWN ZoneMove;} foreach VEHZONES;
_zone = _this select 0;
if (_zone in NOMOVEZONES) exitWith {};
_start = getmarkerpos _zone;
_type = getmarkertype _zone;
_whereTo = _this select 1;
if (isNil"_whereTo" || {isNil"_zone"} || {typename _whereTo != "ARRAY"} || {!((count _whereTo) in [2,3])} || {!(_zone in allmapmarkers)}) exitWith {};
if (!(_zone in VEHZONES) && {{_x select 0 == _zone} count ZONEMG > 0}) then {
_gr = "";
{if (_x select 0 == _zone) exitWith {_gr = _x select 1;};} foreach ZONEMG;
if (typename _gr == "GROUP" && {_gr in allgroups}) then {
_w = _gr addWaypoint [_whereTo, 0]; 
_w setWaypointStatements ["true", "if (!isNil""thisList"") then {thisList call SAOKVZFUNC1;};"];
};
};

NUMM=NUMM+1;
_marS = format ["SELZ%2Wmar%1",NUMM,_zone];
_msize = [0.6,0.6];
_mar5 = "";
if (getmarkercolor _zone == "ColorRed") then {
_msize = [0,0];
} else {
_mar5 = [_marS,_whereTo,"waypoint",_msize,"ColorBlack",""] CALL FUNKTIO_CREATEMARKER;
};
sleep 5;
//METERS IN SECOND
_speed = 19;
if (_type in ["o_air","b_air","n_air","b_plane","o_plane","n_plane","o_uav","i_uav","n_uav"] && {!(count _this > 2)}) then {_speed = 80;};
_n = [_zone,_whereTo] CALL SAOKZONEM;
_wpPP = _zone CALL SAOKZONEMW;
if (count _wpPP > 1 && {count _this < 3}) exitWith {
if (_mar5 == "") exitWith {};
_aika = time + 60;
waitUntil {sleep 2; {_zone == _x select 0} count ZONEMS == 0 || {_aika < time} || {{_x distance (getmarkerpos _mar5) < 10} count (_zone CALL SAOKZONEMW) == 0}  || {!(_zone in VEHZONES)} || {_zone in ACTIVEZ}}; 
deletemarker _mar5;
};
if (_mar5 != "") then {
[_mar5,_zone] SPAWN {private ["_zone","_mar5"];_aika = time + 60;_mar5 = _this select 0;_zone = _this select 1; waitUntil {sleep 2; {_zone == _x select 0} count ZONEMS == 0 || {_aika < time} || {{_x distance (getmarkerpos _mar5) < 10} count (_zone CALL SAOKZONEMW) == 0}  || {!(_zone in VEHZONES)} || {_zone in ACTIVEZ}}; deletemarker _mar5;};
};
_c = getmarkerpos _zone;
while {count _wpPP > 0 && {_zone in VEHZONES} && {{_zone == _x select 0} count ZONEMS > 0}} do {
_whereTo = _wpPP select 0;
_start = getmarkerpos _zone;
_dist = _start distance _whereTo;
_time = _dist / _speed; 
_Dx = ((_start select 0) - (_whereTo select 0));
_Dy = ((_start select 1) - (_whereTo select 1));
_perSx = _Dx / _time * 0.1;
_perSy = _Dy / _time * 0.1;
_c = getmarkerpos _zone;
while {_time > 0 && {_zone in VEHZONES} && {{_zone == _x select 0} count ZONEMS > 0}} do {
_c = getmarkerpos _zone;
_zone setmarkerpos [(_c select 0)- _perSx,(_c select 1)- _perSy,0];
sleep 0.1;
_time = _time - 0.1;
};
if !(_time > 0) then {
_n = [_zone,""] CALL SAOKZONEM;
};
sleep 0.1;
_wpPP = _zone CALL SAOKZONEMW;
};
if (count _whereTo == 0 || {_c distance _whereTo < 20}) then {_zone CALL SAOKVZMOVESTOP;};



