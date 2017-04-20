private ["_type","_pos","_money","_nr"];
_type = _this select 0;
_pos = _this select 1;
_money = _this select 2;
_player = _this select 3;

if (_type in ["Passage","Factory","Pier","Storage","Power Plant"]) then {
_nr = {
private ["_m","_player"];
_m = (_this select 0) select 0;
_player = _this select 1;
{if (getmarkercolor _x == "ColorYellow" && {(getmarkerpos _x distance _player < getmarkerpos _m distance _player || {getmarkercolor _m != "ColorYellow" && {getmarkercolor _x == "ColorYellow"}})}) then {_m = _x;};} foreach (_this select 0);
_m 
};
_ar = + FacMarkers;
switch (_type) do {
case "Passage": {_ar = + PierMarkers;};
case "Pier": {_ar = + PierMarkers;};
case "Storage": {_ar = + StoMarkers;};
case "Power Plant": {_ar = + PowMarkers;};
};
_m = [_ar,_player] call _nr;
sleep (random 1);
if (getmarkercolor _m == "ColorYellow") then {
_m setmarkercolor "ColorPink";
[[("Civilians are now operating "+_type+" for you. You can still capture the pink colored "+_type+" to get bigger effect on timed prestige"),WEST],"HINTSAOK",nil,false] spawn BIS_fnc_MP;
[[_m,"ColorPink"],"SAOKMARKCOL",nil,false] spawn BIS_fnc_MP;
} else {
_n = [WEST,_money] SPAWN PrestigeUpdate;
[[_money, "Civilians helped"],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
};
};

if (_type in ["Men"] && {!isNull _player} && {alive player}) then {
_group = [(getposATL vehicle _player), WEST, [FRIENDC4 call RETURNRANDOM,FRIENDC4 call RETURNRANDOM,FRIENDC4 call RETURNRANDOM,FRIENDC4 call RETURNRANDOM],[],[],[0.8,0.9]] call SpawnGroupCustom;
_n = [_group,WEST,(getposATL (vehicle _player))] SPAWN VehicleArrival;
{_x setcaptive true; _x setbehaviour "CARELESS";} foreach units _group;
leader _group sidechat "Wolf, we heard you helped civilians in trouble. I am sending some soldiers to aid your team, will be there shortly. Out";
sleep 3;
waitUntil {sleep 3; {isNull _x || {!alive _x} || {vehicle _x == _x}} count units _group > 0};
{_x setcaptive false; _x setbehaviour "AWARE";} foreach units _group;
{
[_x] joinsilent _player;
_x setSkill ["aimingaccuracy", 0.30 + (random 0.4)];
_x setSkill ["aimingShake", 0.30 + (random 0.4)];
_x setSkill ["aimingSpeed", 0.30 + (random 0.4)];
_x setSkill ["spotDistance", 0.20 + (random 0.4)];
_x setSkill ["spotTime", 0.35 + (random 0.35)];
_x setSkill ["endurance", 0.35 + (random 0.35)];
_x setSkill ["courage", 0.35 + (random 0.35)];
_x setSkill ["reloadSpeed", 0.35 + (random 0.35)];
_x setSkill ["commanding", 0.15 + (random 0.35)];
_x setSkill ["general", 0.35 + (random 0.35)];
} foreach units _group;
};

if (isNil"_type" || {_type == "Money"} || {isNull _player} || {!alive player}) then {
_n = [WEST,_money] SPAWN PrestigeUpdate;
[[_money, "Civilians helped"],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
};