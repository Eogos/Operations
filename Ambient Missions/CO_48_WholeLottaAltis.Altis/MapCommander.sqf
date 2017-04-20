
private ["_MAPCLICK"];
F_funcM = {
private ["_gp","_wp","_marks","_ar","_nul","_odds","_na","_hint","_cZ","_bG","_markers","_bl","_nCampZ","_mar","_marker","_ccc","_lastP","_nCampWP"];
if (_shift && {isNil{SaOkmissionnamespace getvariable "CurTeam"}} && {productVersion select 2 < 132}) then {
_gp = group player;
_gp SPAWN SAOKREMOVEWAYPOINTS; 
_wp = _gp addWaypoint [_pos, 0]; 
};
if !(_shift) then {
if (!isNil{SaOkmissionnamespace getvariable "CurTeamMarkers"}) then {SaOkmissionnamespace setvariable ["CurTeam", nil];_marks = + (SaOkmissionnamespace getvariable "CurTeamMarkers");{deletemarker _x;} foreach _marks;};
_ar = [];
{
if (getmarkercolor _x in ["ColorGreen","ColorBlue"] && {(getmarkerpos _x) distance _pos < 90}) then {
_ar pushBack _x;
};
} foreach VEHZONESA;
if (count _ar > 0) then {
_ar = [_ar,[_pos],{(getmarkerpos _x) distance (_this select 0)},"ASCEND"] call BIS_fnc_sortBy;
SaOkmissionnamespace setvariable ["CurTeam", (_ar select 0)];
_nul = (_ar select 0) SPAWN F_MarkerSelectedZone;
} else {SaOkmissionnamespace setvariable ["CurTeam", nil];};
if (!isNil{SaOkmissionnamespace getvariable "CurTeam"}) then {
if (!isNil{SaOkmissionnamespace getvariable "CurTeamMarkers"}) then {_marks = + (SaOkmissionnamespace getvariable "CurTeamMarkers");{deletemarker _x;} foreach _marks;};
_cZ = SaOkmissionnamespace getvariable "CurTeam";
//INFO HINT
_bG = [];
_bG = _bG + (_cZ CALL SAOKZONEDR);
_hint = "" +"<br/>";
{
_odds = _x call battleodds;
_na = if (_odds select 3 != "") then {_odds select 3} else {(getText (configfile >> "CfgVehicles" >> _x >> "displayName"))};
_hint = _hint + (format ["<img size='1.3' color='#00FF00' image='%1'/>",(getText (configfile >> "CfgVehicles" >> _x >> "picture"))]) + format [" %1",_na] +"<br/>";
} foreach _bG;
//hint parseText _hint;
[_hint,_cZ] SPAWN {

private ["_disp"];
68 cutRsc ["MyRscTitle11","PLAIN"];
disableSerialization;
_disp = uiNamespace getVariable "d11_MyRscTitle";

(_disp displayCtrl 311) ctrlSetPosition (findDisplay 12 displayCtrl 51 ctrlMapWorldToScreen (getmarkerpos (_this select 1)));
(_disp displayCtrl 311) ctrlCommit 0;
(_disp displayCtrl 311) ctrlSetStructuredText parseText (_this select 0);
while {!isNull _disp} do {
(_disp displayCtrl 311) ctrlSetPosition (findDisplay 12 displayCtrl 51 ctrlMapWorldToScreen (getmarkerpos (_this select 1)));
(_disp displayCtrl 311) ctrlCommit 0;
sleep 0.01;
};

//(_disp displayCtrl 308) ctrlSetPosition (findDisplay 12 displayCtrl 51 ctrlMapWorldToScreen (getmarkerpos (_this select 1)));
};

if (getmarkertype _cZ == "n_naval" || {getmarkercolor _cZ == "ColorBlue"}) exitWith {};
_markers = [];
_bl = [];
_nCampZ = ["ColorBlue", getmarkerpos _cZ] CALL NEARESTCAMP;
_mar = format ["CAMPLmar%1",NUMM];
NUMM=NUMM+1;
_marker = createMarker [_mar,getmarkerpos _nCampZ];
_marker setMarkerShape "ELLIPSE";
_marker setMarkerSize [4000, 4000];
_marker setMarkerColor "ColorBlack";
_marker setMarkerBrush "Border";
_markers pushBack _marker;
SaOkmissionnamespace setvariable ["CurTeamMarkers",_markers];
};
};
if (_shift && {!isNil{SaOkmissionnamespace getvariable "CurTeam"}}) then {
_cZ = SaOkmissionnamespace getvariable "CurTeam";
_nCampZ = ["ColorBlue", getmarkerpos _cZ] CALL NEARESTCAMP;
_nCampWP = ["ColorBlue", _pos] CALL NEARESTCAMP;
if (getmarkercolor _cZ == "ColorGreen" && {!(getmarkertype _cZ in ["n_naval","n_plane","n_air"])} && {getmarkerpos _nCampZ distance _pos > 4000}) exitWith {
"Too far, over 4km, from nearest green camp" SPAWN HINTSAOK;
};
_lastP = getmarkerpos _cZ;
if ({_cZ == _x select 0} count ZONEMS > 0 && {count (_cZ CALL SAOKZONEMW) > 0}) then {
_ccc = count (_cZ CALL SAOKZONEMW) - 1;
_lastP = (_cZ CALL SAOKZONEMW) select _ccc;
};
if (([_lastP,_pos] CALL SAOKWATERBETWEEN) && {!(getmarkertype _cZ in ["n_naval","n_plane","n_air","b_naval","b_plane","b_air"])}) exitWith {
"Waypoint cant cross with water" SPAWN HINTSAOK;
};
if (!_alt) then {
[[_cZ, _pos],"ZoneMove",false,false] spawn BIS_fnc_MP;
//[_cZ, _pos] SPAWN ZoneMove;
} else {
//_cZ CALL SAOKVZMOVESTOP; [_cZ,"SAOKVZMOVESTOP",false,false] spawn BIS_fnc_MP;
}; 
};
};
_MAPCLICK = ["mclick1","onMapSingleClick","F_funcM"] call BIS_fnc_addStackedEventHandler;

