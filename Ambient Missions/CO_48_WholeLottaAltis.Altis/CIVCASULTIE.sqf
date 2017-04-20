private ["_c","_mNs","_uhri","_killer","_nearest","_str","_villages","_nul"];
_uhri = _this select 0;
_killer = _this select 1;
[getposATL _uhri,"KIA","ColorCiv"] SPAWN SAOKCREATEMARKER;
if (isNil"_killer") exitWith {};
if (isPlayer _killer) then {
if (isNil{_killer getvariable "CKills"}) then {_killer setvariable ["CKills",1,true];} else {_killer setvariable ["CKills",(_killer getvariable "CKills")+1,true];};
};
if (side _killer == WEST) then {
_nearest = [] CALL NEARESTVILLAGE; 
_nearest CALL SAOKLOWERRELVIL;
//SOME VILLAGES MAY HEARD OF IT
_villages = [_nearest];
_nearest = [_uhri,[_nearest]] CALL NEARESTVILLAGE; 
_villages set [count _villages,_nearest];
_c = count _villages - 1;
for "_i" from 0 to _c do {
private ["_xx"];
_xx = _villages select _i;
if (random 1 < 0.5) then {
_xx CALL SAOKLOWERRELVIL;
};
sleep 0.1;
};
};