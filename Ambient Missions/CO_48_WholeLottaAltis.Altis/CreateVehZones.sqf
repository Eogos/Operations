

private ["_c","_n","_ar","_m","_marT","_tex","_tt","_classs","_side","_type","_pos"];
_side = _this select 0;
_type = _this select 1;
_pos = _this select 2;
_c = "ColorRed";
_n = 1;
switch (_side) do {
case "U": {_c = "ColorBlue";_n = 0;};
case "N": {_c = "ColorGreen";_n = 2;};
case "L": {_c = "ColorGreen";_n = 3;};
};
_ar = [];
_m = _side;
switch (_type) do {
case "V": {_ar = ARMEDVEHICLES select _n;_m = _m + "V";};
case "T": {_ar = ARMEDTANKS select _n;_m = _m + "T";};
case "AA": {_ar = ARMEDAA select _n;_m = _m + "AA";};
case "P": {_ar = AIRFIGTHER select _n;_m = _m + "P";};
case "C": {_ar = AIRARMCHOP select _n;_m = _m + "C";};
case "B": {_ar = AIRARMCHOP select _n;_m = _m + "B";};
case "S": {_ar = ARMEDSUPPORT select _n;_m = _m + "S";};
};
_marT = "";
_tex = "";
switch (_m) do {
case "HB": {_marT = "o_naval";};
case "UB": {_marT = "b_naval";};
case "NB": {_marT = "n_naval";};
case "LB": {_marT = "n_naval";};
case "HC": {_marT = "o_air";};
case "UC": {_marT = "b_air";};
case "NC": {_marT = "n_air";};
case "LC": {_marT = "n_air";};
case "HP": {_marT = "o_plane";};
case "UP": {_marT = "b_plane";};
case "NP": {_marT = "n_plane";};
case "LP": {_marT = "n_plane";};
case "HV": {_marT = "o_mech_inf";};
case "UV": {_marT = "b_mech_inf";};
case "NV": {_marT = "n_mech_inf";};
case "LV": {_marT = "n_mech_inf";};
case "HT": {_marT = "o_armor";};
case "UT": {_marT = "b_armor";};
case "NT": {_marT = "n_armor";};
case "LT": {_marT = "n_armor";};
case "HS": {_marT = "o_support";};
case "US": {_marT = "b_support";};
case "NS": {_marT = "n_support";};
case "LS": {_marT = "n_support";};
case "HAA": {_marT = "o_art";_tex = " AA";};
case "UAA": {_marT = "b_art";_tex = " AA";};
case "NAA": {_marT = "n_art";_tex = " AA";};
case "LAA": {_marT = "n_art";_tex = " AA";};
};
_classs = [];
_tt = 2;
_z = "";
if (count _this > 3) then {_tt = _this select 3;};
if (_type in ["P","C"]) then {_tt = 1;};
while {_tt > 0} do {_tt = _tt - 1;_classs = _classs + [_ar call RETURNRANDOM];};
if (_marT != "") then {
_z = [_pos, _c,_classs,_marT,_tex] CALL AddVehicleZone;
} else {
_z = [_pos, _c,_classs] CALL AddVehicleZone;
};
if (_z != "" && {count _this > 3}) then {NOMOVEZONES pushBack _z;};
//_n = [getposATL player, "ColorRed",["O_G_Offroad_01_F","O_G_Offroad_01_F","O_G_Offroad_01_F","O_G_Offroad_01_F"]] CALL AddVehicleZone;