private ["_start","_tank","_tg1","_tg1wp1","_price","_type","_pPos","_roads","_tx","_ordercode"];
_price = _this select 0;
_type = _this select 1;
_tank = "";
switch (_type) do {
case "Rearm HEMTT": {_tank = "B_Truck_01_ammo_F";};
case "Fuel HEMTT": {_tank = "B_Truck_01_fuel_F";};
case "Medical HEMTT": {_tank = "B_Truck_01_medical_F";};
case "Repair HEMTT": {_tank = "B_Truck_01_Repair_F";};
};

if (([side player] CALL PrestigeS) >= _price) then {
_n = [side player,(-1*_price)] SPAWN PrestigeUpdate;
"Cash" SPAWN SAOKPLAYSOUND;
_tx = ("Wolf to Base, we would need supplies. Any "+_type+" nearby? Over");
[[-_price, "Support Call",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
[[leader player, _tx],"SAOKMULTISCHAT",nil,false] spawn BIS_fnc_MP;
sleep 7;
_tx = ("Roger that, Wolf. Enabling comms to nearby "+_type+"-team. Contact them via radio channel 5-1. Out");
[[[side player,"HQ"], _tx],"SAOKMULTISCHAT",nil,false] spawn BIS_fnc_MP;
"You can call now the support via 5-1 channel" SPAWN HINTSAOK;
_pPos = getposATL (vehicle player); 
_start = [(_pPos select 0) + 500 - (random 1000),(_pPos select 1) + 500 - (random 1000),0];
_roads = (_start nearRoads 450);
if (count _roads > 0) then {_start = getposATL (_roads select 0);}; 
while  {surfaceIsWater [_start select 0, _start select 1] || {_start distance _x < 500} count VarBlackListF > 0} do {
sleep 1;
_pPos = getposATL (vehicle player); 
_start = [(_pPos select 0) + 500 - (random 1000),(_pPos select 1) + 500 - (random 1000),0];
_roads = (_start nearRoads 450);
if (count _roads > 0) then {_start = getposATL (_roads select 0);}; 
};

_tg1 = [_start, 0, _tank, side player] call SPAWNVEHICLE;
_tg1wp1= (_tg1 select 2) addWaypoint [getposATL (_tg1 select 0), 0]; 
[(_tg1 select 2), 1] setWaypointBehaviour "CARELESS";
[(_tg1 select 2), 1] setWaypointType "SUPPORT";
(_tg1 select 2) allowfleeing 0;
CARS set [count CARS,(_tg1 select 0)];
(_tg1 select 0) setvariable ["REFUND",_type];
} else {
(format ["%1 more prestige value needed to call support",(_price - ([side player] CALL PrestigeS))]) SPAWN HINTSAOK;
};