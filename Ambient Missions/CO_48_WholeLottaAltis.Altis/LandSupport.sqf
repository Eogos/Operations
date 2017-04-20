private ["_start","_tank","_tg1","_posPl","_tg1wp1","_price","_type","_tx","_ordercode","_ll","_pPos","_roads","_nul","_classes","_group","_wp1"];
_price = _this select 0;
_type = _this select 1;
_tank = "";
switch (_type) do {
case "AT-Team": {_tank = "AT-Team";};
case "AA-Team": {_tank = "AA-Team";};
case "INF-Team": {_tank = "INF-Team";};
case "PMC-Team": {_tank = "PMC-Team";};
case "Offroad MG": {_tank = "I_G_Offroad_01_armed_F";};
case "Hunter HMG": {_tank = "B_MRAP_01_hmg_F";};
case "Hunter GMG": {_tank = "B_MRAP_01_gmg_F";};
case "Strider HMG": {_tank = "I_MRAP_03_hmg_F";};
case "Strider GMG": {_tank = "I_MRAP_03_gmg_F";};
case "Marshall": {_tank = "B_APC_Wheeled_01_cannon_F";};
case "Panther": {_tank = "B_APC_Tracked_01_rcws_F";};
case "Gorgon": {_tank = "I_APC_Wheeled_03_cannon_F";};
case "Bobcat": {_tank = "B_APC_Tracked_01_CRV_F";};
case "Cheetah": {_tank = "B_APC_Tracked_01_AA_F";};
case "Slammer": {_tank = "B_MBT_01_cannon_F";};
case "Slammer UP": {_tank = "B_MBT_01_TUSK_F";};
case "Scorcher": {_tank = "B_MBT_01_arty_F";};
case "Sandstorm": {_tank = "B_MBT_01_mlrs_F";};
case "FV-720 Mora": {_tank = "I_APC_tracked_03_cannon_F";};
case "MBT-52 Kuma": {_tank = "I_MBT_03_cannon_F";};

};

if (([side player] CALL PrestigeS) >= _price) then {
player setvariable ["OwnRes",(player getvariable "OwnRes") - 1,true];
_n = [side player,(-1*_price)] SPAWN PrestigeUpdate;
"Cash" SPAWN SAOKPLAYSOUND;
_tx = ("Wolf to nearby units, we would need help of "+_type+" here. Anyone there? Over");
if !(_type in ["PMC-Team","INF-Team","AA-Team","AT-Team"]) then {
_tx = ("Wolf to Base. Is there any "+_type+"-teams nearby? We would need more force. Over");
};
[[leader player, _tx],"SAOKMULTISCHAT",nil,false] spawn BIS_fnc_MP;
[[-_price, "Support Call",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;

sleep 7;
if (_type in ["PMC-Team","INF-Team","AA-Team","AT-Team"]) then {
} else {
_tx = ("Understood, Wolf. I am sending "+_type+"-team to your way. They will be there shortly. Out");
[[[side player,"HQ"], _tx],"SAOKMULTISCHAT",nil,false] spawn BIS_fnc_MP;
};
_pPos = getposATL player; 
if !(_type in ["AT-Team","AA-Team","INF-Team","PMC-Team"]) then {
_start = [(_pPos select 0) + 700 - (random 1400),(_pPos select 1) + 700 - (random 1400),0];
_roads = (_start nearRoads 650);
if (count _roads > 0) then {_start = getposATL (_roads select 0);};  
_ll = 700;
while  {surfaceIsWater [_start select 0, _start select 1] || {{_start distance _x < 500} count VarBlackListF > 0} || {_start distance vehicle _x < 500} count ([] CALL AllPf) > 0} do {
sleep 1;
_ll = _ll + 200;
_pPos = getposATL player; 
_start = [(_pPos select 0) + _ll - (random _ll)*2,(_pPos select 1) + _ll - (random _ll)*2,0];
_roads = (_start nearRoads 650);
if (count _roads > 0) then {_start = getposATL (_roads select 0);};  
};

_tg1 = [_start, 0, _tank, side player] call SPAWNVEHICLE;
if !(_tank in ["B_MBT_01_arty_F","B_MBT_01_mlrs_F"]) then {
_posPl = [(_pPos select 0) + (random 200)-(random 200), (_pPos select 1)+ (random 200)-(random 200), 0];
_tg1wp1= (_tg1 select 2) addWaypoint [_posPl, 0]; 
_tg1wp1 setWaypointBehaviour "COMBAT";
_tg1wp1 setWaypointType "GUARD";
} else {(_tg1 select 2) allowfleeing 0;};
NAPAveh set [count NAPAveh,(_tg1 select 2)];
_nul = [(_tg1 select 2),"ColorRed"] SPAWN FUNKTIO_GM;
//_nul = [(_tg1 select 0), _posPl] SPAWN FUNKTIO_VS;
CARS set [count CARS,(_tg1 select 0)];
FriendlyVehicles set [count FriendlyVehicles,(_tg1 select 2)];
(_tg1 select 0) setvariable ["REFUND",_type];
if (_tank in ["B_MBT_01_arty_F","B_MBT_01_mlrs_F"]) then {
(vehicle (leader (_tg1 select 2))) synchronizeObjectsAdd [mudo1]; mudo1 synchronizeObjectsAdd [(vehicle (leader (_tg1 select 2)))]; 
(format ["Team leader can give fire missions for %1 via 0-8 channel. Also give waypoint via Ctrl+Space",_veh]) CALL HINTSAOK;
[(_tg1 select 2)] SPAWN {
_group = _this select 0;
_veh = (vehicle (leader _group)); 
waitUntil {sleep 5; !alive _veh || {count units _group == 0}};
CARS = CARS + [_veh];
(vehicle (leader _group)) synchronizeObjectsRemove [mudo1]; mudo1 synchronizeObjectsRemove [(vehicle (leader _group))]; 
};
};


sleep 60;
if ({alive _x} count units (_tg1 select 2) > 1) then {(_tg1 select 2) setgroupid [_type];
[[leader (_tg1 select 2), localize "STR_Sp1s1r6"],"SAOKMULTISCHAT",nil,false] spawn BIS_fnc_MP;
};
} else {
//INF TEAM
_start = getmarkerpos ([] CALL NEARESTVILLAGE);
_classes = ["I_G_Soldier_LAT_F","I_G_Soldier_LAT_F"];
if (_type == "PMC-Team") then {_classes = ["PMC_TL","PMC_SecurityCon_MXGL","PMC_SecurityCon_MX","PMC_Engineer","PMC_Medic","PMC_FieldSpecialist_LMG","PMC_Marksman","PMC_Bodyguard1"];};
if (_type == "AA-Team") then {_classes = ["B_soldier_AA_F","B_soldier_AA_F"];};
if (_type == "INF-Team") then {_classes = [FRIENDC2 call RETURNRANDOM,FRIENDC2 call RETURNRANDOM,FRIENDC2 call RETURNRANDOM,FRIENDC2 call RETURNRANDOM];};
_group = [_start, WEST, _classes,[],[],[0.9,1.0]] call SpawnGroupCustom;

if (_type == "AA-Team") then {
{_nul = [_x,[]] SPAWN ConvertToArmedCivilian;} foreach units _group;
};
FriendlyInf set [count FriendlyInf,_group];
_pPos = getposATL (vehicle player); 
_posPl = [(_pPos select 0) + (random 200)-(random 200), (_pPos select 1)+ (random 200)-(random 200), 0];
_wp1= _group addWaypoint [_posPl, 0]; 
_group setgroupid [_type]; 
[[leader _group, "Wolf, we are heading to help you shortly. ETA - few minutes. Out"],"SAOKMULTISCHAT",nil,false] spawn BIS_fnc_MP;
};
sleep 600 + (random 300);
//_trigger setTriggerActivation ["DELTA", "PRESENT", true];
//hint "Land Support is available again via radio channel - Delta";
} else {
(format ["%1 more prestige value needed to call land support",(_price - ([side player] CALL PrestigeS))]) SPAWN HINTSAOK;
};