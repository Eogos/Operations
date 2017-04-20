private ["_Pstart","_n","_tg1","_veh","_ran","_nul","_start","_st","_p1","_p2","_p3","_p4","_p5","_p6","_p7","_p8","_cls","_str","_roads","_cost"];
_n = _this;
_Pstart = [];
_cP = screenToWorld [0.5,0.5];
if (_cP distance player < 40 && {count (_cP nearObjects ["House",10]) == 0} && {count (_cP nearObjects ["Static",10]) == 0}) then {_Pstart = + _cP;};
if ({_this == getText (configfile >> "CfgVehicles" >> _x >> "displayName")} count ((AIRARMCHOP select 0)+(AIRFIGTHER select 0)+(AIRARMCHOP select 1)+(AIRFIGTHER select 1)+(AIRARMCHOP select 2)+(AIRFIGTHER select 2)) > 0) exitWith {
_p = "";
{if (_this == getText (configfile >> "CfgVehicles" >> _x >> "displayName")) exitWith {_p = _x;};} foreach ((AIRARMCHOP select 0)+(AIRFIGTHER select 0)+(AIRARMCHOP select 1)+(AIRFIGTHER select 1)+(AIRARMCHOP select 2)+(AIRFIGTHER select 2));
if (_p == "") exitWith {};
_cost = ((getText (configfile >> "CfgVehicles" >> _p >> "displayName")) CALL SUPPORTCOST) * 0.8;
if (([side player] CALL PrestigeS) >= _cost) then {
_n = [side player,-_cost] SPAWN PrestigeUpdate;
[[-_cost, "Vehicle Cost",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
"Cash" SPAWN SAOKPLAYSOUND;
_start = [getmarkerpos ([] CALL NEARESTAIRFIELD),80,10,"(1 + meadow) * (1 - sea)"] CALL SAOKSEEKPOS;
_max = 0;
while {[_start,_p] CALL SAOKTAKENBOX && {_max < 7} && {count _Pstart == 0}} do {
_max = _max + 1;
sleep 1;
_start = [getmarkerpos ([] CALL NEARESTAIRFIELD),80,10,"(1 + meadow) * (1 - sea)"] CALL SAOKSEEKPOS;
};
if (count _Pstart > 0) then {_start = + _Pstart;};
_veh = createVehicle [_p, _start, [], 0, "NONE"];
_veh setdir (random 360);
CARS set [count CARS, _veh];
AddIdVeh set [count AddIdVeh, _veh];
} else {
(format ["%1 more prestige value needed to buy", _cost - ([side player] CALL PrestigeS)]) SPAWN HINTSAOK;
};
};

if ({_this == getText (configfile >> "CfgVehicles" >> _x >> "displayName")} count ((ARMEDVEHICLES select 3)+(ARMEDTANKS select 3)+(ARMEDVEHICLES select 2)+(ARMEDVEHICLES select 1)+(ARMEDTANKS select 1)+(ARMEDTANKS select 2)+(ARMEDVEHICLES select 0)+(ARMEDTANKS select 0)) > 0) exitWith {
_p = "";
{if (_this == getText (configfile >> "CfgVehicles" >> _x >> "displayName")) exitWith {_p = _x;};} foreach ((ARMEDVEHICLES select 3)+(ARMEDTANKS select 3)+(ARMEDVEHICLES select 2)+(ARMEDTANKS select 2)+(ARMEDVEHICLES select 1)+(ARMEDTANKS select 1)+(ARMEDVEHICLES select 0)+(ARMEDTANKS select 0));
if (_p == "") exitWith {};
_cost = ((getText (configfile >> "CfgVehicles" >> _p >> "displayName")) CALL SUPPORTCOST) * 0.8;
_nul = [_p,_cost] SPAWN FBuyVehicle;
};


switch (_n) do {
case "Empty A-164 Wipeout": {
_cost = "Empty A-164 Wipeout" CALL SUPPORTCOST;
if (([side player] CALL PrestigeS) >= _cost) then {
_n = [side player,-_cost] SPAWN PrestigeUpdate;
[[-_cost, "Vehicle Cost",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
_start = [getmarkerpos ([] CALL NEARESTAIRFIELD),80,10,"(1 + meadow) * (1 - sea)"] CALL SAOKSEEKPOS;
_max = 0;
while {[_start,_p] CALL SAOKTAKENBOX && {_max < 7} && {count _Pstart == 0}} do {
_max = _max + 1;
sleep 1;
_start = [getmarkerpos ([] CALL NEARESTAIRFIELD),80,10,"(1 + meadow) * (1 - sea)"] CALL SAOKSEEKPOS;
};
if (count _Pstart > 0) then {_start = + _Pstart;};
_veh = createVehicle ["B_Plane_CAS_01_F", _start, [], 0, "NONE"];
_veh setdir ([_start, getposATL player] call BIS_fnc_dirTo);
CARS set [count CARS, _veh];AddIdVeh set [count AddIdVeh, _veh];

} else {
(format ["%1 more prestige value needed to buy", _cost - ([side player] CALL PrestigeS)]) SPAWN HINTSAOK;
};
};

case "Empty Rubberboat": {
if (([side player] CALL PrestigeS) >= 20) then {
_n = [side player,-20] SPAWN PrestigeUpdate;
[[-20, "Rubberboat",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
_st = [player, 40,"(1 + sea)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
_start set [2,0];
_apu = (_st select 0) select 0;
_apu set [2,0];
_t = 10;
while {!surfaceiswater _start || {getTerrainHeightASL _start > -2}} do {_start = [(_apu select 0)+_t-(random _t)*2,(_apu select 1)+_t-(random _t)*2,0];_t = _t + 10;};
_veh = createVehicle ["C_Rubberboat", _start, [], 0, "NONE"];
CARS set [count CARS, _veh];AddIdVeh set [count AddIdVeh, _veh];

} else {
(format ["%1 more prestige value needed to receive Rubberboat", 20 - ([side player] CALL PrestigeS)]) SPAWN HINTSAOK;
};
};

case "Empty Motorboat": {
if (([side player] CALL PrestigeS) >= 70) then {
_n = [side player,-70] SPAWN PrestigeUpdate;
[[-70, "Motorboat",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
_st = [player, 40,"(1 + sea)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
_start set [2,0];
_apu = (_st select 0) select 0;
_apu set [2,0];
_t = 10;
while {!surfaceiswater _start || {getTerrainHeightASL _start > -2}} do {_start = [(_apu select 0)+_t-(random _t)*2,(_apu select 1)+_t-(random _t)*2,0];_t = _t + 10;};
_veh = createVehicle ["C_Boat_Civil_01_F", _start, [], 0, "NONE"];
CARS set [count CARS, _veh];AddIdVeh set [count AddIdVeh, _veh];
} else {
(format ["%1 more prestige value needed to receive Motorboat", 70 - ([side player] CALL PrestigeS)]) SPAWN HINTSAOK;
};
};

case "Empty Assault Boat": {
if (([side player] CALL PrestigeS) >= 30) then {
_n = [side player,-30] SPAWN PrestigeUpdate;
[[-30, "Assault Boat",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
_st = [player, 40,"(1 + sea)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
_start set [2,0];
_apu = (_st select 0) select 0;
_apu set [2,0];
_t = 10;
while {!surfaceiswater _start || {getTerrainHeightASL _start > -2}} do {_start = [(_apu select 0)+_t-(random _t)*2,(_apu select 1)+_t-(random _t)*2,0];_t = _t + 10;};
_veh = createVehicle ["B_Boat_Transport_01_F", _start, [], 0, "NONE"];
CARS set [count CARS, _veh];AddIdVeh set [count AddIdVeh, _veh];
} else {
(format ["%1 more prestige value needed to receive Assault Boat", 30 - ([side player] CALL PrestigeS)]) SPAWN HINTSAOK;
};
};

case "Empty Speedboat MG": {
if (([side player] CALL PrestigeS) >= 120) then {
_n = [side player,-120] SPAWN PrestigeUpdate;
[[-120, "Speedboat MG",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
_st = [player, 40,"(1 + sea)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
_start set [2,0];
_apu = (_st select 0) select 0;
_apu set [2,0];
_t = 10;
while {!surfaceiswater _start || {getTerrainHeightASL _start > -2}} do {_start = [(_apu select 0)+_t-(random _t)*2,(_apu select 1)+_t-(random _t)*2,0];_t = _t + 10;};
_veh = createVehicle ["B_Boat_Armed_01_minigun_F", _start, [], 0, "NONE"];
CARS set [count CARS, _veh];AddIdVeh set [count AddIdVeh, _veh];
} else {
(format ["%1 more prestige value needed to receive Speedboat MG", 120 - ([side player] CALL PrestigeS)]) SPAWN HINTSAOK;
};
};

case "Empty SDV": {
if (([side player] CALL PrestigeS) >= 100) then {
_n = [side player,-100] SPAWN PrestigeUpdate;
[[-100, "SDV",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
_st = [player, 40,"(1 + sea)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
_start set [2,0];
_apu = (_st select 0) select 0;
_apu set [2,0];
_t = 10;
while {!surfaceiswater _start || {getTerrainHeightASL _start > -2}} do {_start = [(_apu select 0)+_t-(random _t)*2,(_apu select 1)+_t-(random _t)*2,0];_t = _t + 10;};
_veh = createVehicle ["B_SDV_01_F", _start, [], 0, "NONE"];
CARS set [count CARS, _veh];AddIdVeh set [count AddIdVeh, _veh];
} else {
(format ["%1 more prestige value needed to receive SDV", 100 - ([side player] CALL PrestigeS)]) SPAWN HINTSAOK;
};
};
case "MQ4A Greyhawk": {
if (([side player] CALL PrestigeS) >= 350) then {
_n = [side player,-350] SPAWN PrestigeUpdate;
[[-350, "Received MQ4A Greyhawk",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
_tg1 = [[(getmarkerpos "InsertionM") select 0, (getmarkerpos "InsertionM") select 1, 50], ([(getmarkerpos "InsertionM"), getposATL player] call BIS_fnc_dirTo), "B_UAV_02_F", WEST] call SPAWNVEHICLE;
//createVehicleCrew (_tg1 select 0);
CARS set [count CARS, (_tg1 select 0)];AddIdVeh set [count AddIdVeh, (_tg1 select 0)];
} else {
(format ["%1 more prestige value needed to receive MQ4A Greyhawk", 350 - ([side player] CALL PrestigeS)]) SPAWN HINTSAOK;
};
};
case "AR-2 Darter": {
if (([side player] CALL PrestigeS) >= 50) then {
_n = [side player,-50] SPAWN PrestigeUpdate;
[[-50, "Received AR-2 Darter",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
_tg1 = [[(getmarkerpos ([] CALL NEARESTCAMP)) select 0, (getmarkerpos ([] CALL NEARESTCAMP)) select 1, 20], 0, "B_UAV_01_F", WEST] call SPAWNVEHICLE;
//createVehicleCrew (_tg1 select 0);
CARS set [count CARS, (_tg1 select 0)];AddIdVeh set [count AddIdVeh, (_tg1 select 0)];
} else {
(format ["%1 more prestige value needed to receive AR-2 Darter", 50 - ([side player] CALL PrestigeS)]) SPAWN HINTSAOK;
};
};
case "UGV Stomper": {
if (([side player] CALL PrestigeS) >= 50) then {
_n = [side player,-50] SPAWN PrestigeUpdate;
[[-50, "Received UGV Stomper",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
_st = [getmarkerpos ([] CALL NEARESTCAMP), 40,"(1 - trees) * (1 - houses) * (1 - sea)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
if (count _st == 0) then {_start = getmarkerpos ([] CALL NEARESTCAMP);};
_p1 = [(_start select 0) - 5,(_start select 1)+5,(_start select 2) + 0.3];
_p2 = [(_start select 0) - 5,(_start select 1)+5,(_start select 2) + 6];
_p3 = [(_start select 0) + 5,(_start select 1)+5,(_start select 2) + 0.3];
_p4 = [(_start select 0) + 5,(_start select 1)+5,(_start select 2) + 6];
_p5 = [(_start select 0) - 5,(_start select 1)-5,(_start select 2) + 0.3];
_p6 = [(_start select 0) - 5,(_start select 1)-5,(_start select 2) + 6];
_p7 = [(_start select 0) + 5,(_start select 1)-5,(_start select 2) + 0.3];
_p8 = [(_start select 0) + 5,(_start select 1)-5,(_start select 2) + 6];
while {lineIntersects [_p3, _p5] || lineIntersects [_p3, _p7] ||  lineIntersects [_p5, _p7] || lineIntersects [_p1, _p7] || lineIntersects [_p1, _p5] || lineIntersects [_p1, _p3] || lineIntersects [_p1, _p2] || lineIntersects [_p3, _p4] || lineIntersects [_p5, _p6] || lineIntersects [_p7, _p8]} do {
sleep 1;
_st = [getmarkerpos ([] CALL NEARESTCAMP), 40,"(1 - trees) * (1 - houses) * (1 - sea)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
if (count _st == 0) then {_start = getmarkerpos ([] CALL NEARESTCAMP);};
_p1 = [(_start select 0) - 5,(_start select 1)+5,(_start select 2) + 0.3];
_p2 = [(_start select 0) - 5,(_start select 1)+5,(_start select 2) + 6];
_p3 = [(_start select 0) + 5,(_start select 1)+5,(_start select 2) + 0.3];
_p4 = [(_start select 0) + 5,(_start select 1)+5,(_start select 2) + 6];
_p5 = [(_start select 0) - 5,(_start select 1)-5,(_start select 2) + 0.3];
_p6 = [(_start select 0) - 5,(_start select 1)-5,(_start select 2) + 6];
_p7 = [(_start select 0) + 5,(_start select 1)-5,(_start select 2) + 0.3];
_p8 = [(_start select 0) + 5,(_start select 1)-5,(_start select 2) + 6];
};
if (count _Pstart > 0) then {_start = + _Pstart;};
_tg1 = [_start, 0, "B_UGV_01_F", WEST] call SPAWNVEHICLE;
//createVehicleCrew (_tg1 select 0);
CARS set [count CARS, (_tg1 select 0)];AddIdVeh set [count AddIdVeh, (_tg1 select 0)];
} else {
(format ["%1 more prestige value needed to receive UGV Stomper", 50 - ([side player] CALL PrestigeS)]) SPAWN HINTSAOK;
};
};
case "UGV Stomper RCWS": {
if (([side player] CALL PrestigeS) >= 100) then {
_n = [side player,-100] SPAWN PrestigeUpdate;
[[-100, "Received UGV Stomper RCWS",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
_st = [getmarkerpos ([] CALL NEARESTCAMP), 40,"(1 - trees) * (1 - houses) * (1 - sea)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
if (count _st == 0) then {_start = getmarkerpos ([] CALL NEARESTCAMP);};
_p1 = [(_start select 0) - 5,(_start select 1)+5,(_start select 2) + 0.3];
_p2 = [(_start select 0) - 5,(_start select 1)+5,(_start select 2) + 6];
_p3 = [(_start select 0) + 5,(_start select 1)+5,(_start select 2) + 0.3];
_p4 = [(_start select 0) + 5,(_start select 1)+5,(_start select 2) + 6];
_p5 = [(_start select 0) - 5,(_start select 1)-5,(_start select 2) + 0.3];
_p6 = [(_start select 0) - 5,(_start select 1)-5,(_start select 2) + 6];
_p7 = [(_start select 0) + 5,(_start select 1)-5,(_start select 2) + 0.3];
_p8 = [(_start select 0) + 5,(_start select 1)-5,(_start select 2) + 6];
while {lineIntersects [_p3, _p5] || lineIntersects [_p3, _p7] ||  lineIntersects [_p5, _p7] || lineIntersects [_p1, _p7] || lineIntersects [_p1, _p5] || lineIntersects [_p1, _p3] || lineIntersects [_p1, _p2] || lineIntersects [_p3, _p4] || lineIntersects [_p5, _p6] || lineIntersects [_p7, _p8]} do {
sleep 1;
_st = [getmarkerpos ([] CALL NEARESTCAMP), 40,"(1 - trees) * (1 - houses) * (1 - sea)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
if (count _st == 0) then {_start = getmarkerpos ([] CALL NEARESTCAMP);};
_p1 = [(_start select 0) - 5,(_start select 1)+5,(_start select 2) + 0.3];
_p2 = [(_start select 0) - 5,(_start select 1)+5,(_start select 2) + 6];
_p3 = [(_start select 0) + 5,(_start select 1)+5,(_start select 2) + 0.3];
_p4 = [(_start select 0) + 5,(_start select 1)+5,(_start select 2) + 6];
_p5 = [(_start select 0) - 5,(_start select 1)-5,(_start select 2) + 0.3];
_p6 = [(_start select 0) - 5,(_start select 1)-5,(_start select 2) + 6];
_p7 = [(_start select 0) + 5,(_start select 1)-5,(_start select 2) + 0.3];
_p8 = [(_start select 0) + 5,(_start select 1)-5,(_start select 2) + 6];
};
if (count _Pstart > 0) then {_start = + _Pstart;};
_tg1 = [_start, 0, "B_UGV_01_rcws_F", WEST] call SPAWNVEHICLE;
//createVehicleCrew (_tg1 select 0);
CARS set [count CARS, (_tg1 select 0)];AddIdVeh set [count AddIdVeh, (_tg1 select 0)];
} else {
(format ["%1 more prestige value needed to receive UGV Stomper RCWS", 100 - ([side player] CALL PrestigeS)]) SPAWN HINTSAOK;
};
};
case "Offroad FIA": {
_nul = ["B_G_Offroad_01_F",150] SPAWN FBuyVehicle;
};
case "Scout M3": {
_nul = ["LIB_US_Scout_m3",150] SPAWN FBuyVehicle;
};
case "GMC Tent": {
_nul = ["LIB_US_GMC_Tent",150] SPAWN FBuyVehicle;
};
case "Strider": {
_nul = ["I_MRAP_03_F",180] SPAWN FBuyVehicle;
};
case "Hunter": {
_nul = ["B_MRAP_01_F",180] SPAWN FBuyVehicle;
};
case "Empty Strider": {
_nul = ["I_MRAP_03_F",180] SPAWN FBuyVehicle;
};
case "Empty Strider HMG": {
_nul = ["I_MRAP_03_hmg_F",230] SPAWN FBuyVehicle;
};
case "Empty Strider GMG": {
_nul = ["I_MRAP_03_gmg_F",280] SPAWN FBuyVehicle;
};
case "Empty Hunter": {
_nul = ["B_MRAP_01_F",150] SPAWN FBuyVehicle;
};
case "Empty Hunter HMG": {
_nul = ["B_MRAP_01_hmg_F",200] SPAWN FBuyVehicle;
};
case "Empty Hunter GMG": {
_nul = ["B_MRAP_01_gmg_F",250] SPAWN FBuyVehicle;
};
case "Empty Gorgon": {
_nul = ["I_APC_Wheeled_03_cannon_F",350] SPAWN FBuyVehicle;
};
case "Empty Panther": {
_nul = ["B_APC_Tracked_01_rcws_F",400] SPAWN FBuyVehicle;
};
case "Empty Marshall": {
_nul = ["B_APC_Wheeled_01_cannon_F",350] SPAWN FBuyVehicle;
};
case "Empty Cheetah": {
_nul = ["B_APC_Tracked_01_AA_F",400] SPAWN FBuyVehicle;
};
case "Empty Slammer": {
_nul = ["B_MBT_01_cannon_F",600] SPAWN FBuyVehicle;
};
case "Empty Slammer UP": {
_nul = ["B_MBT_01_TUSK_F",630] SPAWN FBuyVehicle;
};
case "Empty Scorcher": {
_nul = ["B_MBT_01_arty_F",500] SPAWN FBuyVehicle;
};
case "Empty Sandstorm": {
_nul = ["B_MBT_01_mlrs_F",500] SPAWN FBuyVehicle;
};
case "Empty FV-720 Mora": {
_nul = ["I_APC_tracked_03_cannon_F",400] SPAWN FBuyVehicle;
};
case "Empty MBT-52 Kuma": {
_nul = ["I_MBT_03_cannon_F",500] SPAWN FBuyVehicle;
};


case "Mortar Team": {
if (([side player] CALL PrestigeS) >= 300) then {
_n = [side player,-300] SPAWN PrestigeUpdate;
[[-300, "Received Mortar Team",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
_st = [getmarkerpos ([] CALL NEARESTCAMP), 40,"(1 + meadow) * (1 - sea)",""] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
if (count _Pstart > 0) then {_start = + _Pstart;};
_tg1 = [_start, 0, "I_Mortar_01_F", WEST] call SPAWNVEHICLE;
(_tg1 select 0) setvariable ["REFUND","Mortar"];
(vehicle (leader (_tg1 select 2))) synchronizeObjectsAdd [mudo1]; mudo1 synchronizeObjectsAdd [(vehicle (leader (_tg1 select 2)))]; 
[(_tg1 select 2)] SPAWN {
_group = _this select 0;
_veh = (vehicle (leader _group)); 
waitUntil {sleep 5; !alive _veh || count units _group == 0};
CARS set [count CARS, _veh];AddIdVeh set [count AddIdVeh, _veh];
(vehicle (leader _group)) synchronizeObjectsRemove [mudo1]; mudo1 synchronizeObjectsRemove [(vehicle (leader _group))]; 
};
} else {
(format ["%1 more prestige value needed to receive mortar team", 300 - ([side player] CALL PrestigeS)]) SPAWN HINTSAOK;
};
};
case "Chopper Transport": {
if (([side player] CALL PrestigeS) >= 400) then {
_n = [side player,-400] SPAWN PrestigeUpdate;
[[-400, "Chopper Transport",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
_tg1 = [getmarkerpos "ChopperM", 0, "I_Heli_Transport_02_F", WEST] call SPAWNVEHICLE;

(vehicle (leader (_tg1 select 2))) synchronizeObjectsAdd [mudo2]; mudo2 synchronizeObjectsAdd [(vehicle (leader (_tg1 select 2)))]; 
(_tg1 select 2) allowfleeing 0;
(_tg1 select 2) setbehaviour "CARELESS";
[(_tg1 select 2)] SPAWN {
_group = _this select 0;
_veh = (vehicle (leader _group)); 
waitUntil {sleep 5; !alive _veh || count units _group == 0};
CARS set [count CARS, _veh];AddIdVeh set [count AddIdVeh, _veh];
(vehicle (leader _group)) synchronizeObjectsRemove [mudo2]; mudo2 synchronizeObjectsRemove [(vehicle (leader _group))]; 
};
} else {
(format ["%1 more prestige value needed to receive chopper transport", 400 - ([side player] CALL PrestigeS)]) SPAWN HINTSAOK;
};
};
case "Set SPLTY Medical": {
if (([side player] CALL PrestigeS) >= 30) then {
_n = [side player,-30] SPAWN PrestigeUpdate;
[[-30, "Set Specialty",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
//SaOkmissionNamespace setvariable [(([] CALL NEARESTVILLAGE)+"B"),"Medical",true];
[[(([] CALL NEARESTVILLAGE)+"B"),"Medical"],"SAOKVILSET",false,false] spawn BIS_fnc_MP;
} else {
(format ["%1 more prestige value needed to set specialty", 30 - ([side player] CALL PrestigeS)]) SPAWN HINTSAOK;
};
};
case "Set SPLTY AA-Team": {
if (([side player] CALL PrestigeS) >= 30) then {
_n = [side player,-30] SPAWN PrestigeUpdate;
[[-30, "Set Specialty",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
//SaOkmissionNamespace setvariable [(([] CALL NEARESTVILLAGE)+"B"),"AntiAir",true];
[[(([] CALL NEARESTVILLAGE)+"B"),"AntiAir"],"SAOKVILSET",false,false] spawn BIS_fnc_MP;
} else {
(format ["%1 more prestige value needed to set specialty", 30 - ([side player] CALL PrestigeS)]) SPAWN HINTSAOK;
};
};
case "Set SPLTY AT-Team": {
if (([side player] CALL PrestigeS) >= 30) then {
_n = [side player,-30] SPAWN PrestigeUpdate;
[[-30, "Set Specialty",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
//SaOkmissionNamespace setvariable [(([] CALL NEARESTVILLAGE)+"B"),"AntiTank",true];
[[(([] CALL NEARESTVILLAGE)+"B"),"AntiTank"],"SAOKVILSET",false,false] spawn BIS_fnc_MP;
} else {
(format ["%1 more prestige value needed to set specialty", 30 - ([side player] CALL PrestigeS)]) SPAWN HINTSAOK;
};
};
case "Set SPLTY MG-Team": {
if (([side player] CALL PrestigeS) >= 30) then {
_n = [side player,-30] SPAWN PrestigeUpdate;
[[-30, "Set Specialty",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
//SaOkmissionNamespace setvariable [(([] CALL NEARESTVILLAGE)+"B"),"MachineGunners",true];
[[(([] CALL NEARESTVILLAGE)+"B"),"MachineGunners"],"SAOKVILSET",false,false] spawn BIS_fnc_MP;
} else {
(format ["%1 more prestige value needed to set specialty", 30 - ([side player] CALL PrestigeS)]) SPAWN HINTSAOK;
};
};
case "Bribe": {
if (([side player] CALL PrestigeS) >= 400) then {
_n = [side player,-400] SPAWN PrestigeUpdate;
[[-400, "Bribed friendship",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
_str = (([getposATL player] CALL NEARESTVILLAGE) + "A"); 
[[_str,"Friendly"],"SAOKVILSET",false,false] spawn BIS_fnc_MP;
} else {
(format ["%1 more prestige value needed to Bribe", 400 - ([side player] CALL PrestigeS)]) SPAWN HINTSAOK;
};
};
case "Buy PickUp": {
if (([side player] CALL PrestigeS) >= 20) then {
_n = [side player,-20] SPAWN PrestigeUpdate;
[[-20, "Vehicle Cost",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
_st = [getposATL player, 40,"(1 - trees) * (1 - houses) * (1 - sea)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
_roads = (_start nearRoads 40);
if (count _roads > 0) then {_start = _roads call RETURNRANDOM;};
if (count _st == 0) then {_start = getmarkerpos ([] CALL NEARESTVILLAGE);};
_veh = createVehicle ["C_Offroad_01_F", _start, [], 0, "NONE"];
_veh setdir (random 360);
CARS set [count CARS, _veh];AddIdVeh set [count AddIdVeh, _veh];

[_veh] SPAWN {
private ["_t"];
_t = 0;
while {vehicle player distance (_this select 0) > 10 && _t < 100} do {
_t = _t + 1;
(_this select 0) say "AlarmCar";
sleep 5;
};
};

} else {
(format ["%1 more prestige value needed to buy vehicle", 20 - ([side player] CALL PrestigeS)]) SPAWN HINTSAOK;
};
};
case "Buy QuadBike": {
if (([side player] CALL PrestigeS) >= 20) then {
_n = [side player,-20] SPAWN PrestigeUpdate;
[[-20, "Vehicle Cost",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
_st = [getposATL player, 40,"(1 - trees) * (1 - houses) * (1 - sea)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
_roads = (_start nearRoads 40);
if (count _roads > 0) then {_start = _roads call RETURNRANDOM;};
if (count _st == 0) then {_start = getmarkerpos ([] CALL NEARESTVILLAGE);};
_veh = createVehicle ["C_Quadbike_01_F", _start, [], 0, "NONE"];
_veh setdir (random 360);
CARS set [count CARS, _veh];AddIdVeh set [count AddIdVeh, _veh];
[_veh] SPAWN {
private ["_t"];
_t = 0;
while {vehicle player distance (_this select 0) > 10 && _t < 100} do {
_t = _t + 1;
(_this select 0) say "AlarmCar";
sleep 5;
};
};

} else {
(format ["%1 more prestige value needed to buy vehicle", 20 - ([side player] CALL PrestigeS)]) SPAWN HINTSAOK;
};
};
case "Buy Hatchback": {
if (([side player] CALL PrestigeS) >= 20) then {
_n = [side player,-20] SPAWN PrestigeUpdate;
[[-20, "Vehicle Cost",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
_st = [getposATL player, 40,"(1 - trees) * (1 - houses) * (1 - sea)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
_roads = (_start nearRoads 40);
if (count _roads > 0) then {_start = _roads call RETURNRANDOM;};
if (count _st == 0) then {_start = getmarkerpos ([] CALL NEARESTVILLAGE);};
_veh = createVehicle ["C_Hatchback_01_F", _start, [], 0, "NONE"];
_veh setdir (random 360);
CARS set [count CARS, _veh];AddIdVeh set [count AddIdVeh, _veh];
[_veh] SPAWN {
private ["_t"];
_t = 0;
while {vehicle player distance (_this select 0) > 10 && _t < 100} do {
_t = _t + 1;
(_this select 0) say "AlarmCar";
sleep 5;
};
};

} else {
(format ["%1 more prestige value needed to buy vehicle", 20 - ([side player] CALL PrestigeS)]) SPAWN HINTSAOK;
};
};
case "Buy Sport Hatchback": {
if (([side player] CALL PrestigeS) >= 20) then {
_n = [side player,-20] SPAWN PrestigeUpdate;
[[-20, "Vehicle Cost",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
_st = [getposATL player, 40,"(1 - trees) * (1 - houses) * (1 - sea)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
_roads = (_start nearRoads 40);
if (count _roads > 0) then {_start = _roads call RETURNRANDOM;};
if (count _st == 0) then {_start = getmarkerpos ([] CALL NEARESTVILLAGE);};
_veh = createVehicle ["C_Hatchback_01_sport_F", _start, [], 0, "NONE"];
_veh setdir (random 360);
CARS set [count CARS, _veh];AddIdVeh set [count AddIdVeh, _veh];
[_veh] SPAWN {
private ["_t"];
_t = 0;
while {vehicle player distance (_this select 0) > 10 && _t < 100} do {
_t = _t + 1;
(_this select 0) say "AlarmCar";
sleep 5;
};
};

} else {
(format ["%1 more prestige value needed to buy vehicle", 20 - ([side player] CALL PrestigeS)]) SPAWN HINTSAOK;
};
};
case "Buy SUV": {
if (([side player] CALL PrestigeS) >= 20) then {
_n = [side player,-20] SPAWN PrestigeUpdate;
[[-20, "Vehicle Cost",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
_st = [getposATL player, 40,"(1 - trees) * (1 - houses) * (1 - sea)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
_roads = (_start nearRoads 40);
if (count _roads > 0) then {_start = _roads call RETURNRANDOM;};
if (count _st == 0) then {_start = getmarkerpos ([] CALL NEARESTVILLAGE);};
_veh = createVehicle ["C_SUV_01_F", _start, [], 0, "NONE"];
_veh setdir (random 360);
CARS set [count CARS, _veh];AddIdVeh set [count AddIdVeh, _veh];
[_veh] SPAWN {
private ["_t"];
_t = 0;
while {vehicle player distance (_this select 0) > 10 && _t < 100} do {
_t = _t + 1;
(_this select 0) say "AlarmCar";
sleep 5;
};
};

} else {
(format ["%1 more prestige value needed to buy vehicle", 20 - ([side player] CALL PrestigeS)]) SPAWN HINTSAOK;
};
};
case "Buy Truck": {
if (([side player] CALL PrestigeS) >= 20) then {
_n = [side player,-20] SPAWN PrestigeUpdate;
[[-20, "Vehicle Cost",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
_st = [getposATL player, 40,"(1 - trees) * (1 - houses) * (1 - sea)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
_roads = (_start nearRoads 40);
if (count _roads > 0) then {_start = _roads call RETURNRANDOM;};
if (count _st == 0) then {_start = getmarkerpos ([] CALL NEARESTVILLAGE);};
_veh = createVehicle ["C_Van_01_transport_F", _start, [], 0, "NONE"];
_veh setdir (random 360);
CARS set [count CARS, _veh];AddIdVeh set [count AddIdVeh, _veh];
[_veh] SPAWN {
private ["_t"];
_t = 0;
while {vehicle player distance (_this select 0) > 10 && _t < 100} do {
_t = _t + 1;
(_this select 0) say "AlarmCar";
sleep 5;
};
};
} else {
(format ["%1 more prestige value needed to buy vehicle", 20 - ([side player] CALL PrestigeS)]) SPAWN HINTSAOK;
};
};

case "Mine/Construction-Truck": {
if (([side player] CALL PrestigeS) >= 50) then {
_n = [side player,-50] SPAWN PrestigeUpdate;
[[-50, "Mine/Construction-Truck Cost",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
_st = [getmarkerpos ([] CALL NEARESTCAMP), 50,"(1 - trees) * (1 - houses) * (1 - sea)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
if (count _st == 0) then {_start = getmarkerpos ([] CALL NEARESTCAMP);};
_p1 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 0.5];
_p2 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 6];
_p3 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 0.5];
_p4 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 6];
_p5 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 0.5];
_p6 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 6];
_p7 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 0.5];
_p8 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 6];
while {lineIntersects [_p3, _p5] || lineIntersects [_p3, _p7] ||  lineIntersects [_p5, _p7] || lineIntersects [_p1, _p7] || lineIntersects [_p1, _p5] || lineIntersects [_p1, _p3] ||lineIntersects [_p1, _p2] || lineIntersects [_p3, _p4] || lineIntersects [_p5, _p6] || lineIntersects [_p7, _p8]} do {
sleep 1;
_st = [getmarkerpos ([] CALL NEARESTCAMP), 50,"(1 - trees) * (1 - houses) * (1 - sea)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
if (count _st == 0) then {_start = getmarkerpos ([] CALL NEARESTCAMP);};
_p1 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 0.5];
_p2 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 6];
_p3 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 0.5];
_p4 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 6];
_p5 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 0.5];
_p6 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 6];
_p7 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 0.5];
_p8 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 6];
};
if (count _Pstart > 0) then {_start = + _Pstart;};
_veh = createVehicle ["B_Truck_01_covered_F", _start, [], 0, "NONE"];
_veh setdir (random 360);
CARS set [count CARS, _veh];AddIdVeh set [count AddIdVeh, _veh];
_veh setvariable ["MineTruck",1];
} else {
(format ["%1 more prestige value needed to buy Mine/Construction-Truck", 50 - ([side player] CALL PrestigeS)]) SPAWN HINTSAOK;
};
};

case "Empty Commanche": {
_cost = "Empty Commanche" CALL SUPPORTCOST;
if (([side player] CALL PrestigeS) >= _cost) then {
_n = [side player,(-1*_cost)] SPAWN PrestigeUpdate;
[[-_cost, "Vehicle Cost",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
_st = [getmarkerpos ([] CALL NEARESTAIRFIELD), 80,"(1 - trees) * (1 - houses) * (1 - sea)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
if (count _st == 0) then {_start = getmarkerpos ([] CALL NEARESTAIRFIELD);};
_p1 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 0.5];
_p2 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 6];
_p3 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 0.5];
_p4 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 6];
_p5 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 0.5];
_p6 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 6];
_p7 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 0.5];
_p8 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 6];
while {lineIntersects [_p3, _p5] || lineIntersects [_p3, _p7] ||  lineIntersects [_p5, _p7] || lineIntersects [_p1, _p7] || lineIntersects [_p1, _p5] || lineIntersects [_p1, _p3] ||lineIntersects [_p1, _p2] || lineIntersects [_p3, _p4] || lineIntersects [_p5, _p6] || lineIntersects [_p7, _p8]} do {
sleep 1;
_st = [getmarkerpos ([] CALL NEARESTAIRFIELD), 80,"(1 - trees) * (1 - houses) * (1 - sea)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
if (count _st == 0) then {_start = getmarkerpos ([] CALL NEARESTAIRFIELD);};
_p1 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 0.5];
_p2 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 6];
_p3 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 0.5];
_p4 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 6];
_p5 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 0.5];
_p6 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 6];
_p7 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 0.5];
_p8 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 6];
};
if (count _Pstart > 0) then {_start = + _Pstart;};
_veh = createVehicle ["B_Heli_Attack_01_F", _start, [], 0, "NONE"];
_veh setdir (random 360);
CARS set [count CARS, _veh];AddIdVeh set [count AddIdVeh, _veh];
} else {
(format ["%1 more prestige value needed to buy", _cost - ([side player] CALL PrestigeS)]) SPAWN HINTSAOK;
};
};
case "Empty AH-9": {
_cost = "Empty AH-9" CALL SUPPORTCOST;
if (([side player] CALL PrestigeS) >= _cost) then {
_n = [side player,(-1*_cost)] SPAWN PrestigeUpdate;
[[-_cost, "Vehicle Cost",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
_st = [getmarkerpos ([] CALL NEARESTAIRFIELD), 80,"(1 - trees) * (1 - houses) * (1 - sea)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
if (count _st == 0) then {_start = getmarkerpos ([] CALL NEARESTAIRFIELD);};
_p1 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 0.5];
_p2 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 6];
_p3 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 0.5];
_p4 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 6];
_p5 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 0.5];
_p6 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 6];
_p7 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 0.5];
_p8 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 6];
while {lineIntersects [_p3, _p5] || lineIntersects [_p3, _p7] ||  lineIntersects [_p5, _p7] || lineIntersects [_p1, _p7] || lineIntersects [_p1, _p5] || lineIntersects [_p1, _p3] ||lineIntersects [_p1, _p2] || lineIntersects [_p3, _p4] || lineIntersects [_p5, _p6] || lineIntersects [_p7, _p8]} do {
sleep 1;
_st = [getmarkerpos ([] CALL NEARESTAIRFIELD), 80,"(1 - trees) * (1 - houses) * (1 - sea)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
if (count _st == 0) then {_start = getmarkerpos ([] CALL NEARESTAIRFIELD);};
_p1 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 0.5];
_p2 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 6];
_p3 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 0.5];
_p4 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 6];
_p5 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 0.5];
_p6 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 6];
_p7 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 0.5];
_p8 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 6];
};
if (count _Pstart > 0) then {_start = + _Pstart;};
_veh = createVehicle ["B_Heli_Light_01_armed_F", _start, [], 0, "NONE"];
_veh setdir (random 360);
CARS set [count CARS, _veh];AddIdVeh set [count AddIdVeh, _veh];
} else {
(format ["%1 more prestige value needed to buy", _cost - ([side player] CALL PrestigeS)]) SPAWN HINTSAOK;
};
};
case "Empty MH-9": {
_cost = "Empty MH-9" CALL SUPPORTCOST;
if (([side player] CALL PrestigeS) >= _cost) then {
_n = [side player,(-1*_cost)] SPAWN PrestigeUpdate;
[[-_cost, "Vehicle Cost",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
_st = [getmarkerpos ([] CALL NEARESTAIRFIELD), 80,"(1 - trees) * (1 - houses) * (1 - sea)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
if (count _st == 0) then {_start = getmarkerpos ([] CALL NEARESTAIRFIELD);};
_p1 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 0.5];
_p2 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 6];
_p3 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 0.5];
_p4 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 6];
_p5 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 0.5];
_p6 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 6];
_p7 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 0.5];
_p8 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 6];
while {lineIntersects [_p3, _p5] || lineIntersects [_p3, _p7] ||  lineIntersects [_p5, _p7] || lineIntersects [_p1, _p7] || lineIntersects [_p1, _p5] || lineIntersects [_p1, _p3] ||lineIntersects [_p1, _p2] || lineIntersects [_p3, _p4] || lineIntersects [_p5, _p6] || lineIntersects [_p7, _p8]} do {
sleep 1;
_st = [getmarkerpos ([] CALL NEARESTAIRFIELD), 80,"(1 - trees) * (1 - houses) * (1 - sea)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
if (count _st == 0) then {_start = getmarkerpos ([] CALL NEARESTAIRFIELD);};
_p1 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 0.5];
_p2 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 6];
_p3 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 0.5];
_p4 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 6];
_p5 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 0.5];
_p6 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 6];
_p7 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 0.5];
_p8 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 6];
};
if (count _Pstart > 0) then {_start = + _Pstart;};
_veh = createVehicle ["B_Heli_Light_01_F", _start, [], 0, "NONE"];
_veh setdir (random 360);
CARS set [count CARS, _veh];AddIdVeh set [count AddIdVeh, _veh];
} else {
(format ["%1 more prestige value needed to buy", _cost - ([side player] CALL PrestigeS)]) SPAWN HINTSAOK;
};
};
case "Empty MH-9 PMC": {
_cost = "Empty MH-9 PMC" CALL SUPPORTCOST;
if (([side player] CALL PrestigeS) >= _cost) then {
_n = [side player,(-1*_cost)] SPAWN PrestigeUpdate;
[[-_cost, "Vehicle Cost",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
_st = [getmarkerpos ([] CALL NEARESTAIRFIELD), 80,"(1 - trees) * (1 - houses) * (1 - sea)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
if (count _st == 0) then {_start = getmarkerpos ([] CALL NEARESTAIRFIELD);};
_p1 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 0.5];
_p2 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 6];
_p3 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 0.5];
_p4 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 6];
_p5 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 0.5];
_p6 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 6];
_p7 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 0.5];
_p8 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 6];
while {lineIntersects [_p3, _p5] || lineIntersects [_p3, _p7] ||  lineIntersects [_p5, _p7] || lineIntersects [_p1, _p7] || lineIntersects [_p1, _p5] || lineIntersects [_p1, _p3] ||lineIntersects [_p1, _p2] || lineIntersects [_p3, _p4] || lineIntersects [_p5, _p6] || lineIntersects [_p7, _p8]} do {
sleep 1;
_st = [getmarkerpos ([] CALL NEARESTAIRFIELD), 80,"(1 - trees) * (1 - houses) * (1 - sea)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
if (count _st == 0) then {_start = getmarkerpos ([] CALL NEARESTAIRFIELD);};
_p1 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 0.5];
_p2 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 6];
_p3 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 0.5];
_p4 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 6];
_p5 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 0.5];
_p6 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 6];
_p7 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 0.5];
_p8 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 6];
};
if (count _Pstart > 0) then {_start = + _Pstart;};
_veh = createVehicle ["PMC_MH9", _start, [], 0, "NONE"];
_veh setdir (random 360);
CARS set [count CARS, _veh];AddIdVeh set [count AddIdVeh, _veh];
} else {
(format ["%1 more prestige value needed to buy", _cost - ([side player] CALL PrestigeS)]) SPAWN HINTSAOK;
};
};
case "Empty CH-49 [CONS]": {
_cost = "Empty CH-49 [CONS]" CALL SUPPORTCOST;
if (([side player] CALL PrestigeS) >= _cost) then {
_n = [side player,(-1*_cost)] SPAWN PrestigeUpdate;
[[-_cost, "Vehicle Cost",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
_st = [getmarkerpos ([] CALL NEARESTAIRFIELD), 80,"(1 - trees) * (1 - houses) * (1 - sea)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
if (count _st == 0) then {_start = getmarkerpos ([] CALL NEARESTAIRFIELD);};
_p1 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 0.5];
_p2 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 6];
_p3 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 0.5];
_p4 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 6];
_p5 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 0.5];
_p6 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 6];
_p7 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 0.5];
_p8 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 6];
while {lineIntersects [_p3, _p5] || lineIntersects [_p3, _p7] ||  lineIntersects [_p5, _p7] || lineIntersects [_p1, _p7] || lineIntersects [_p1, _p5] || lineIntersects [_p1, _p3] ||lineIntersects [_p1, _p2] || lineIntersects [_p3, _p4] || lineIntersects [_p5, _p6] || lineIntersects [_p7, _p8]} do {
sleep 1;
_st = [getmarkerpos ([] CALL NEARESTAIRFIELD), 80,"(1 - trees) * (1 - houses) * (1 - sea)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
if (count _st == 0) then {_start = getmarkerpos ([] CALL NEARESTAIRFIELD);};
_p1 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 0.5];
_p2 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 6];
_p3 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 0.5];
_p4 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 6];
_p5 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 0.5];
_p6 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 6];
_p7 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 0.5];
_p8 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 6];
};
if (count _Pstart > 0) then {_start = + _Pstart;};
_veh = createVehicle ["I_Heli_Transport_02_F", _start, [], 0, "NONE"];
_veh setdir (random 360);
_veh setvariable ["MineTruck",1];
CARS set [count CARS, _veh];AddIdVeh set [count AddIdVeh, _veh];
} else {
(format ["%1 more prestige value needed to buy", _cost - ([side player] CALL PrestigeS)]) SPAWN HINTSAOK;
};
};
case "Empty UH-80": {
_cost = "Empty UH-80" CALL SUPPORTCOST;
if (([side player] CALL PrestigeS) >= _cost) then {
_n = [side player,(-1*_cost)] SPAWN PrestigeUpdate;
[[-_cost, "Vehicle Cost",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
_st = [getmarkerpos ([] CALL NEARESTAIRFIELD), 80,"(1 - trees) * (1 - houses) * (1 - sea)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
if (count _st == 0) then {_start = getmarkerpos ([] CALL NEARESTAIRFIELD);};
_p1 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 0.5];
_p2 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 6];
_p3 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 0.5];
_p4 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 6];
_p5 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 0.5];
_p6 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 6];
_p7 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 0.5];
_p8 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 6];
while {lineIntersects [_p3, _p5] || lineIntersects [_p3, _p7] ||  lineIntersects [_p5, _p7] || lineIntersects [_p1, _p7] || lineIntersects [_p1, _p5] || lineIntersects [_p1, _p3] ||lineIntersects [_p1, _p2] || lineIntersects [_p3, _p4] || lineIntersects [_p5, _p6] || lineIntersects [_p7, _p8]} do {
sleep 1;
_st = [getmarkerpos ([] CALL NEARESTAIRFIELD), 80,"(1 - trees) * (1 - houses) * (1 - sea)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
if (count _st == 0) then {_start = getmarkerpos ([] CALL NEARESTAIRFIELD);};
_p1 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 0.5];
_p2 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 6];
_p3 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 0.5];
_p4 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 6];
_p5 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 0.5];
_p6 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 6];
_p7 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 0.5];
_p8 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 6];
};
if (count _Pstart > 0) then {_start = + _Pstart;};
_veh = createVehicle ["B_Heli_Transport_01_F", _start, [], 0, "NONE"];
_veh setdir (random 360);
CARS set [count CARS, _veh];AddIdVeh set [count AddIdVeh, _veh];
} else {
(format ["%1 more prestige value needed to buy", _cost - ([side player] CALL PrestigeS)]) SPAWN HINTSAOK;
};
};
case "Empty UH-80 Camo": {
_cost = "Empty UH-80 Camo" CALL SUPPORTCOST;
if (([side player] CALL PrestigeS) >= _cost) then {
_n = [side player,(-1*_cost)] SPAWN PrestigeUpdate;
[[-_cost, "Vehicle Cost",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
_st = [getmarkerpos ([] CALL NEARESTAIRFIELD), 80,"(1 - trees) * (1 - houses) * (1 - sea)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
if (count _st == 0) then {_start = getmarkerpos ([] CALL NEARESTAIRFIELD);};
_p1 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 0.5];
_p2 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 6];
_p3 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 0.5];
_p4 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 6];
_p5 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 0.5];
_p6 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 6];
_p7 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 0.5];
_p8 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 6];
while {lineIntersects [_p3, _p5] || lineIntersects [_p3, _p7] ||  lineIntersects [_p5, _p7] || lineIntersects [_p1, _p7] || lineIntersects [_p1, _p5] || lineIntersects [_p1, _p3] ||lineIntersects [_p1, _p2] || lineIntersects [_p3, _p4] || lineIntersects [_p5, _p6] || lineIntersects [_p7, _p8]} do {
sleep 1;
_st = [getmarkerpos ([] CALL NEARESTAIRFIELD), 80,"(1 - trees) * (1 - houses) * (1 - sea)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
if (count _st == 0) then {_start = getmarkerpos ([] CALL NEARESTAIRFIELD);};
_p1 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 0.5];
_p2 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 6];
_p3 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 0.5];
_p4 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 6];
_p5 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 0.5];
_p6 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 6];
_p7 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 0.5];
_p8 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 6];
};
if (count _Pstart > 0) then {_start = + _Pstart;};
_veh = createVehicle ["B_Heli_Transport_01_camo_F", _start, [], 0, "NONE"];
_veh setdir (random 360);
CARS set [count CARS, _veh];AddIdVeh set [count AddIdVeh, _veh];
} else {
(format ["%1 more prestige value needed to buy", _cost - ([side player] CALL PrestigeS)]) SPAWN HINTSAOK;
};
};
case "Empty Buzzard AA": {
_cost = "Empty Buzzard AA" CALL SUPPORTCOST;
if (([side player] CALL PrestigeS) >= _cost) then {
_n = [side player,(-1*_cost)] SPAWN PrestigeUpdate;
[[-_cost, "Vehicle Cost",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
_st = [getmarkerpos ([] CALL NEARESTAIRFIELD), 80,"(1 - trees) * (1 - houses) * (1 - sea)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
if (count _st == 0) then {_start = getmarkerpos ([] CALL NEARESTAIRFIELD);};
_p1 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 0.5];
_p2 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 6];
_p3 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 0.5];
_p4 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 6];
_p5 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 0.5];
_p6 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 6];
_p7 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 0.5];
_p8 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 6];
while {lineIntersects [_p3, _p5] || lineIntersects [_p3, _p7] ||  lineIntersects [_p5, _p7] || lineIntersects [_p1, _p7] || lineIntersects [_p1, _p5] || lineIntersects [_p1, _p3] ||lineIntersects [_p1, _p2] || lineIntersects [_p3, _p4] || lineIntersects [_p5, _p6] || lineIntersects [_p7, _p8]} do {
sleep 1;
_st = [getmarkerpos ([] CALL NEARESTAIRFIELD), 80,"(1 - trees) * (1 - houses) * (1 - sea)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
if (count _st == 0) then {_start = getmarkerpos ([] CALL NEARESTAIRFIELD);};
_p1 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 0.5];
_p2 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 6];
_p3 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 0.5];
_p4 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 6];
_p5 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 0.5];
_p6 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 6];
_p7 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 0.5];
_p8 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 6];
};
if (count _Pstart > 0) then {_start = + _Pstart;};
_veh = createVehicle ["I_Plane_Fighter_03_AA_F", _start, [], 0, "NONE"];
_veh setdir ([_start, getposATL player] call BIS_fnc_dirTo);
CARS set [count CARS, _veh];AddIdVeh set [count AddIdVeh, _veh];
} else {
(format ["%1 more prestige value needed to buy", _cost - ([side player] CALL PrestigeS)]) SPAWN HINTSAOK;
};
};
case "Empty Buzzard CAS": {
_cost = "Empty Buzzard CAS" CALL SUPPORTCOST;
if (([side player] CALL PrestigeS) >= _cost) then {
_n = [side player,(-1*_cost)] SPAWN PrestigeUpdate;
[[-_cost, "Vehicle Cost",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
_st = [getmarkerpos ([] CALL NEARESTAIRFIELD), 80,"(1 - trees) * (1 - houses) * (1 - sea)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
if (count _st == 0) then {_start = getmarkerpos ([] CALL NEARESTAIRFIELD);};
_p1 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 0.5];
_p2 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 6];
_p3 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 0.5];
_p4 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 6];
_p5 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 0.5];
_p6 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 6];
_p7 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 0.5];
_p8 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 6];
while {lineIntersects [_p3, _p5] || lineIntersects [_p3, _p7] ||  lineIntersects [_p5, _p7] || lineIntersects [_p1, _p7] || lineIntersects [_p1, _p5] || lineIntersects [_p1, _p3] ||lineIntersects [_p1, _p2] || lineIntersects [_p3, _p4] || lineIntersects [_p5, _p6] || lineIntersects [_p7, _p8]} do {
sleep 1;
_st = [getmarkerpos ([] CALL NEARESTAIRFIELD), 80,"(1 - trees) * (1 - houses) * (1 - sea)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
if (count _st == 0) then {_start = getmarkerpos ([] CALL NEARESTAIRFIELD);};
_p1 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 0.5];
_p2 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 6];
_p3 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 0.5];
_p4 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 6];
_p5 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 0.5];
_p6 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 6];
_p7 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 0.5];
_p8 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 6];
};
if (count _Pstart > 0) then {_start = + _Pstart;};
_veh = createVehicle ["I_Plane_Fighter_03_CAS_F", _start, [], 0, "NONE"];
_veh setdir ([_start, getposATL player] call BIS_fnc_dirTo);
CARS set [count CARS, _veh];AddIdVeh set [count AddIdVeh, _veh];
} else {
(format ["%1 more prestige value needed to buy", _cost - ([side player] CALL PrestigeS)]) SPAWN HINTSAOK;
};
};
case "Empty F/A-18 E": {
_cost = "Empty F/A-18 E" CALL SUPPORTCOST;
if (([side player] CALL PrestigeS) >= _cost) then {
_n = [side player,(-1*_cost)] SPAWN PrestigeUpdate;
[[-_cost, "Vehicle Cost",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
_st = [getmarkerpos ([] CALL NEARESTAIRFIELD), 80,"(1 - trees) * (1 - houses) * (1 - sea)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
if (count _st == 0) then {_start = getmarkerpos ([] CALL NEARESTAIRFIELD);};
_p1 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 0.5];
_p2 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 6];
_p3 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 0.5];
_p4 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 6];
_p5 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 0.5];
_p6 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 6];
_p7 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 0.5];
_p8 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 6];
while {lineIntersects [_p3, _p5] || lineIntersects [_p3, _p7] ||  lineIntersects [_p5, _p7] || lineIntersects [_p1, _p7] || lineIntersects [_p1, _p5] || lineIntersects [_p1, _p3] ||lineIntersects [_p1, _p2] || lineIntersects [_p3, _p4] || lineIntersects [_p5, _p6] || lineIntersects [_p7, _p8]} do {
sleep 1;
_st = [getmarkerpos ([] CALL NEARESTAIRFIELD), 80,"(1 - trees) * (1 - houses) * (1 - sea)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
if (count _st == 0) then {_start = getmarkerpos ([] CALL NEARESTAIRFIELD);};
_p1 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 0.5];
_p2 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 6];
_p3 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 0.5];
_p4 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 6];
_p5 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 0.5];
_p6 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 6];
_p7 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 0.5];
_p8 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 6];
};
if (count _Pstart > 0) then {_start = + _Pstart;};
_veh = createVehicle ["JS_JC_FA18E", _start, [], 0, "NONE"];
_veh setdir (random 360);
CARS set [count CARS, _veh];AddIdVeh set [count AddIdVeh, _veh];
} else {
(format ["%1 more prestige value needed to buy", _cost - ([side player] CALL PrestigeS)]) SPAWN HINTSAOK;
};
};
case "Empty F/A-18 F": {
_cost = "Empty F/A-18 F" CALL SUPPORTCOST;
if (([side player] CALL PrestigeS) >= _cost) then {
_n = [side player,(-1*_cost)] SPAWN PrestigeUpdate;
[[-_cost, "Vehicle Cost",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
_st = [getmarkerpos ([] CALL NEARESTAIRFIELD), 80,"(1 - trees) * (1 - houses) * (1 - sea)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
if (count _st == 0) then {_start = getmarkerpos ([] CALL NEARESTAIRFIELD);};
_p1 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 0.5];
_p2 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 6];
_p3 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 0.5];
_p4 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 6];
_p5 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 0.5];
_p6 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 6];
_p7 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 0.5];
_p8 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 6];
while {lineIntersects [_p3, _p5] || lineIntersects [_p3, _p7] ||  lineIntersects [_p5, _p7] || lineIntersects [_p1, _p7] || lineIntersects [_p1, _p5] || lineIntersects [_p1, _p3] ||lineIntersects [_p1, _p2] || lineIntersects [_p3, _p4] || lineIntersects [_p5, _p6] || lineIntersects [_p7, _p8]} do {
sleep 1;
_st = [getmarkerpos ([] CALL NEARESTAIRFIELD), 80,"(1 - trees) * (1 - houses) * (1 - sea)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
if (count _st == 0) then {_start = getmarkerpos ([] CALL NEARESTAIRFIELD);};
_p1 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 0.5];
_p2 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 6];
_p3 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 0.5];
_p4 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 6];
_p5 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 0.5];
_p6 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 6];
_p7 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 0.5];
_p8 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 6];
};
if (count _Pstart > 0) then {_start = + _Pstart;};
_veh = createVehicle ["JS_JC_FA18F", _start, [], 0, "NONE"];
_veh setdir (random 360);
CARS set [count CARS, _veh];AddIdVeh set [count AddIdVeh, _veh];
} else {
(format ["%1 more prestige value needed to buy", _cost - ([side player] CALL PrestigeS)]) SPAWN HINTSAOK;
};
};

case "Empty WY-55 Hellcat": {
_cost = "Empty WY-55 Hellcat" CALL SUPPORTCOST;
if (([side player] CALL PrestigeS) >= _cost) then {
_n = [side player,(-1*_cost)] SPAWN PrestigeUpdate;
[[-_cost, "Vehicle Cost",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
_st = [getmarkerpos ([] CALL NEARESTAIRFIELD), 80,"(1 - trees) * (1 - houses) * (1 - sea)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
if (count _st == 0) then {_start = getmarkerpos ([] CALL NEARESTAIRFIELD);};
_p1 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 0.5];
_p2 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 6];
_p3 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 0.5];
_p4 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 6];
_p5 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 0.5];
_p6 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 6];
_p7 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 0.5];
_p8 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 6];
while {lineIntersects [_p3, _p5] || lineIntersects [_p3, _p7] ||  lineIntersects [_p5, _p7] || lineIntersects [_p1, _p7] || lineIntersects [_p1, _p5] || lineIntersects [_p1, _p3] ||lineIntersects [_p1, _p2] || lineIntersects [_p3, _p4] || lineIntersects [_p5, _p6] || lineIntersects [_p7, _p8]} do {
sleep 1;
_st = [getmarkerpos ([] CALL NEARESTAIRFIELD), 80,"(1 - trees) * (1 - houses) * (1 - sea)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
if (count _st == 0) then {_start = getmarkerpos ([] CALL NEARESTAIRFIELD);};
_p1 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 0.5];
_p2 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 6];
_p3 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 0.5];
_p4 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 6];
_p5 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 0.5];
_p6 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 6];
_p7 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 0.5];
_p8 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 6];
};
if (count _Pstart > 0) then {_start = + _Pstart;};
_veh = createVehicle ["I_Heli_light_03_unarmed_F", _start, [], 0, "NONE"];
_veh setdir (random 360);
CARS set [count CARS, _veh];AddIdVeh set [count AddIdVeh, _veh];
} else {
(format ["%1 more prestige value needed to buy", _cost - ([side player] CALL PrestigeS)]) SPAWN HINTSAOK;
};
};

case "Empty WY-55 Hellcat MG": {
_cost = "Empty WY-55 Hellcat MG" CALL SUPPORTCOST;
if (([side player] CALL PrestigeS) >= _cost) then {
_n = [side player,(-1*_cost)] SPAWN PrestigeUpdate;
[[-_cost, "Vehicle Cost",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
_st = [getmarkerpos ([] CALL NEARESTAIRFIELD), 80,"(1 - trees) * (1 - houses) * (1 - sea)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
if (count _st == 0) then {_start = getmarkerpos ([] CALL NEARESTAIRFIELD);};
_p1 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 0.5];
_p2 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 6];
_p3 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 0.5];
_p4 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 6];
_p5 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 0.5];
_p6 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 6];
_p7 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 0.5];
_p8 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 6];
while {lineIntersects [_p3, _p5] || lineIntersects [_p3, _p7] ||  lineIntersects [_p5, _p7] || lineIntersects [_p1, _p7] || lineIntersects [_p1, _p5] || lineIntersects [_p1, _p3] ||lineIntersects [_p1, _p2] || lineIntersects [_p3, _p4] || lineIntersects [_p5, _p6] || lineIntersects [_p7, _p8]} do {
sleep 1;
_st = [getmarkerpos ([] CALL NEARESTAIRFIELD), 80,"(1 - trees) * (1 - houses) * (1 - sea)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
if (count _st == 0) then {_start = getmarkerpos ([] CALL NEARESTAIRFIELD);};
_p1 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 0.5];
_p2 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 6];
_p3 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 0.5];
_p4 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 6];
_p5 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 0.5];
_p6 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 6];
_p7 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 0.5];
_p8 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 6];
};
if (count _Pstart > 0) then {_start = + _Pstart;};
_veh = createVehicle ["I_Heli_light_03_F", _start, [], 0, "NONE"];
_veh setdir (random 360);
CARS set [count CARS, _veh];AddIdVeh set [count AddIdVeh, _veh];
} else {
(format ["%1 more prestige value needed to buy", _cost - ([side player] CALL PrestigeS)]) SPAWN HINTSAOK;
};
};

case "Empty Repair HEMTT": {
_cost = "Empty Repair HEMTT" CALL SUPPORTCOST;
if (([side player] CALL PrestigeS) >= _cost) then {
_n = [side player,(-1*_cost)] SPAWN PrestigeUpdate;
[[-_cost, "Vehicle Cost",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
_st = [getmarkerpos ([] CALL NEARESTAIRFIELD), 80,"(1 - trees) * (1 - houses) * (1 - sea)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
if (count _st == 0) then {_start = getmarkerpos ([] CALL NEARESTAIRFIELD);};
_p1 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 0.5];
_p2 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 6];
_p3 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 0.5];
_p4 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 6];
_p5 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 0.5];
_p6 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 6];
_p7 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 0.5];
_p8 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 6];
while {lineIntersects [_p3, _p5] || lineIntersects [_p3, _p7] ||  lineIntersects [_p5, _p7] || lineIntersects [_p1, _p7] || lineIntersects [_p1, _p5] || lineIntersects [_p1, _p3] ||lineIntersects [_p1, _p2] || lineIntersects [_p3, _p4] || lineIntersects [_p5, _p6] || lineIntersects [_p7, _p8]} do {
sleep 1;
_st = [getmarkerpos ([] CALL NEARESTAIRFIELD), 80,"(1 - trees) * (1 - houses) * (1 - sea)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
if (count _st == 0) then {_start = getmarkerpos ([] CALL NEARESTAIRFIELD);};
_p1 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 0.5];
_p2 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 6];
_p3 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 0.5];
_p4 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 6];
_p5 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 0.5];
_p6 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 6];
_p7 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 0.5];
_p8 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 6];
};
if (count _Pstart > 0) then {_start = + _Pstart;};
_veh = createVehicle ["B_Truck_01_Repair_F", _start, [], 0, "NONE"];
_veh setdir (random 360);
CARS set [count CARS, _veh];AddIdVeh set [count AddIdVeh, _veh];
} else {
(format ["%1 more prestige value needed to buy", _cost - ([side player] CALL PrestigeS)]) SPAWN HINTSAOK;
};
};
case "Empty Fuel HEMTT": {
_cost = "Empty Fuel HEMTT" CALL SUPPORTCOST;
if (([side player] CALL PrestigeS) >= _cost) then {
_n = [side player,(-1*_cost)] SPAWN PrestigeUpdate;
[[-_cost, "Vehicle Cost",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
_st = [getmarkerpos ([] CALL NEARESTAIRFIELD), 80,"(1 - trees) * (1 - houses) * (1 - sea)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
if (count _st == 0) then {_start = getmarkerpos ([] CALL NEARESTAIRFIELD);};
_p1 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 0.5];
_p2 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 6];
_p3 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 0.5];
_p4 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 6];
_p5 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 0.5];
_p6 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 6];
_p7 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 0.5];
_p8 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 6];
while {lineIntersects [_p3, _p5] || lineIntersects [_p3, _p7] ||  lineIntersects [_p5, _p7] || lineIntersects [_p1, _p7] || lineIntersects [_p1, _p5] || lineIntersects [_p1, _p3] ||lineIntersects [_p1, _p2] || lineIntersects [_p3, _p4] || lineIntersects [_p5, _p6] || lineIntersects [_p7, _p8]} do {
sleep 1;
_st = [getmarkerpos ([] CALL NEARESTAIRFIELD), 80,"(1 - trees) * (1 - houses) * (1 - sea)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
if (count _st == 0) then {_start = getmarkerpos ([] CALL NEARESTAIRFIELD);};
_p1 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 0.5];
_p2 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 6];
_p3 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 0.5];
_p4 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 6];
_p5 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 0.5];
_p6 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 6];
_p7 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 0.5];
_p8 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 6];
};
if (count _Pstart > 0) then {_start = + _Pstart;};
_veh = createVehicle ["B_Truck_01_fuel_F", _start, [], 0, "NONE"];
_veh setdir (random 360);
CARS set [count CARS, _veh];AddIdVeh set [count AddIdVeh, _veh];
} else {
(format ["%1 more prestige value needed to buy", _cost - ([side player] CALL PrestigeS)]) SPAWN HINTSAOK;
};
};
case "Empty Rearm HEMTT": {
_cost = "Empty Rearm HEMTT" CALL SUPPORTCOST;
if (([side player] CALL PrestigeS) >= _cost) then {
_n = [side player,(-1*_cost)] SPAWN PrestigeUpdate;
[[-_cost, "Vehicle Cost",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
_st = [getmarkerpos ([] CALL NEARESTAIRFIELD), 80,"(1 - trees) * (1 - houses) * (1 - sea)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
if (count _st == 0) then {_start = getmarkerpos ([] CALL NEARESTAIRFIELD);};
_p1 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 0.5];
_p2 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 6];
_p3 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 0.5];
_p4 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 6];
_p5 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 0.5];
_p6 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 6];
_p7 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 0.5];
_p8 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 6];
while {lineIntersects [_p3, _p5] || lineIntersects [_p3, _p7] ||  lineIntersects [_p5, _p7] || lineIntersects [_p1, _p7] || lineIntersects [_p1, _p5] || lineIntersects [_p1, _p3] ||lineIntersects [_p1, _p2] || lineIntersects [_p3, _p4] || lineIntersects [_p5, _p6] || lineIntersects [_p7, _p8]} do {
sleep 1;
_st = [getmarkerpos ([] CALL NEARESTAIRFIELD), 80,"(1 - trees) * (1 - houses) * (1 - sea)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
if (count _st == 0) then {_start = getmarkerpos ([] CALL NEARESTAIRFIELD);};
_p1 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 0.5];
_p2 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 6];
_p3 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 0.5];
_p4 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 6];
_p5 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 0.5];
_p6 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 6];
_p7 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 0.5];
_p8 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 6];
};
if (count _Pstart > 0) then {_start = + _Pstart;};
_veh = createVehicle ["B_Truck_01_ammo_F", _start, [], 0, "NONE"];
_veh setdir (random 360);
CARS set [count CARS, _veh];AddIdVeh set [count AddIdVeh, _veh];
} else {
(format ["%1 more prestige value needed to buy", _cost - ([side player] CALL PrestigeS)]) SPAWN HINTSAOK;
};
};
case "Empty Medical HEMTT": {
_cost = "Empty Medical HEMTT" CALL SUPPORTCOST;
if (([side player] CALL PrestigeS) >= _cost) then {
_n = [side player,(-1*_cost)] SPAWN PrestigeUpdate;
[[-_cost, "Vehicle Cost",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
_st = [getmarkerpos ([] CALL NEARESTAIRFIELD), 80,"(1 - trees) * (1 - houses) * (1 - sea)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
if (count _st == 0) then {_start = getmarkerpos ([] CALL NEARESTAIRFIELD);};
_p1 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 0.5];
_p2 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 6];
_p3 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 0.5];
_p4 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 6];
_p5 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 0.5];
_p6 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 6];
_p7 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 0.5];
_p8 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 6];
while {lineIntersects [_p3, _p5] || lineIntersects [_p3, _p7] ||  lineIntersects [_p5, _p7] || lineIntersects [_p1, _p7] || lineIntersects [_p1, _p5] || lineIntersects [_p1, _p3] ||lineIntersects [_p1, _p2] || lineIntersects [_p3, _p4] || lineIntersects [_p5, _p6] || lineIntersects [_p7, _p8]} do {
sleep 1;
_st = [getmarkerpos ([] CALL NEARESTAIRFIELD), 80,"(1 - trees) * (1 - houses) * (1 - sea)",1] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
if (count _st == 0) then {_start = getmarkerpos ([] CALL NEARESTAIRFIELD);};
_p1 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 0.5];
_p2 = [(_start select 0) - 16,(_start select 1)+16,(_start select 2) + 6];
_p3 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 0.5];
_p4 = [(_start select 0) + 16,(_start select 1)+16,(_start select 2) + 6];
_p5 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 0.5];
_p6 = [(_start select 0) - 16,(_start select 1)-16,(_start select 2) + 6];
_p7 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 0.5];
_p8 = [(_start select 0) + 16,(_start select 1)-16,(_start select 2) + 6];
};
if (count _Pstart > 0) then {_start = + _Pstart;};
_veh = createVehicle ["B_Truck_01_medical_F", _start, [], 0, "NONE"];
_veh setdir (random 360);
CARS set [count CARS, _veh];AddIdVeh set [count AddIdVeh, _veh];
} else {
(format ["%1 more prestige value needed to buy", _cost - ([side player] CALL PrestigeS)]) SPAWN HINTSAOK;
};
};
case "Water Barrel": {
_cost = "Water Barrel" CALL SUPPORTCOST;
if (([side player] CALL PrestigeS) >= _cost) then {
_n = [side player,(-1*_cost)] SPAWN PrestigeUpdate;
[[-_cost, "Vehicle Cost",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
_st = [getposATL player, 10,"(1 + meadow) * (1 - sea)",""] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
if (count _Pstart > 0) then {_start = + _Pstart;};
_veh = createVehicle ["Land_BarrelWater_F", _start, [], 0, "NONE"];
_veh setdir (random 360);
//CARS set [count CARS, _veh];AddIdVeh set [count AddIdVeh, _veh];
} else {
(format ["%1 more prestige value needed to buy", _cost - ([side player] CALL PrestigeS)]) SPAWN HINTSAOK;
};
};

};




