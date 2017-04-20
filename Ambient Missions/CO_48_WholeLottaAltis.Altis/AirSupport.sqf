private ["_tg1","_posPl","_tg1wp1","_price","_type","_d","_h","_class","_pPos","_start","_nul","_di"];
_price = _this select 0;
_type = _this select 1;
_class = "";
_h = 50;
switch (_type) do {
case "Greyhawk UAV": {_class = "B_UAV_02_CAS_F";_h = 280;};
case "Blackfoot": {_class = "B_Heli_Attack_01_F";};
case "Littlebird": {_class = "B_Heli_Light_01_armed_F";};
case "Buzzard AA": {_class = "I_Plane_Fighter_03_AA_F";_h = 280;};
case "Buzzard CAS": {_class = "I_Plane_Fighter_03_CAS_F";_h = 280;};
case "F/A-18 E": {_class = "JS_JC_FA18E";_h = 380;};
case "F/A-18 F": {_class = "JS_JC_FA18F";_h = 380;};
case "WY-55 Hellcat MG": {_class = "I_Heli_light_03_F";};
case "A-164 Wipeout": {_class = "B_Plane_CAS_01_F";_h = 380;};
};
if (_class == "") then {
{if (getText (configfile >> "CfgVehicles" >> _x >> "displayName") == _type) exitWith {_class = _x;};} foreach (AIRARMCHOP select 0) + (AIRFIGTHER select 0) + (AIRARMCHOP select 2) + (AIRFIGTHER select 2);
};

if (([side player] CALL PrestigeS) >= _price) then {
player setvariable ["OwnRes",(player getvariable "OwnRes") - 1,true];
_n = [side player,(-1*_price)] SPAWN PrestigeUpdate;
"Cash" SPAWN SAOKPLAYSOUND;
[[-_price, "Support Call",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
[[leader player, (localize "STR_Sp1s1r1")],"SAOKMULTISCHAT",nil,false] spawn BIS_fnc_MP;
sleep 7;
_tx = ("Roger that, Wolf. "+_type+" is heading to your way. ETA less than two minutes. Out");
[[[side player,"HQ"], _tx],"SAOKMULTISCHAT",nil,false] spawn BIS_fnc_MP;
_pPos = getposATL player; 
_start = [(_pPos select 0) + 1700 - (random 3400),(_pPos select 1) + 1700 - (random 3400),_h];
while  {_start distance vehicle player < 1500} do {
sleep 3;
_pPos = getposATL player; 
_start = [(_pPos select 0) + 1700 - (random 3400),(_pPos select 1) + 1700 - (random 3400),_h];
};
_di= [_start, _pPos] call BIS_fnc_dirTo;

_tg1 = [_start, _di, _class, side player] call SPAWNVEHICLE;
CantCommand set [count CantCommand,_tg1 select 2];
_posPl = [(_pPos select 0) + 100 -(random 200), (_pPos select 1)+ 100 -(random 200), 0];
_tg1wp1= (_tg1 select 2) addWaypoint [_posPl, 0]; 
[(_tg1 select 2), 1] setWaypointBehaviour "AWARE";
[(_tg1 select 2), 1] setWaypointType "GUARD";
(_tg1 select 0) setvariable ["REFUND",_type,true];
_nul = [(_tg1 select 2), (getmarkerpos "WestChopStart"),400] SPAWN FUNKTIO_MAD;

(_tg1 select 2) setgroupid ["Eagle"];
sleep 60;
if ({alive _x} count units (_tg1 select 2) > 1) then {(_tg1 select 2) setgroupid [_type];
[[leader (_tg1 select 2), localize "STR_Sp1s1r3"],"SAOKMULTISCHAT",nil,false] spawn BIS_fnc_MP;
};
sleep 340;
if ({alive _x} count units (_tg1 select 2) > 1) then {
[[leader (_tg1 select 2), localize "STR_Sp1s1r4"],"SAOKMULTISCHAT",nil,false] spawn BIS_fnc_MP;
};
sleep 600 + (random 300);
//_trigger setTriggerActivation ["CHARLIE", "PRESENT", true];
//hint "Air Support is available again via radio channel - Charlie";
} else {
[[(format ["%1 more prestige value needed to call air support", _veh]),side player],"HINTSAOK",nil,false] spawn BIS_fnc_MP;
};