private ["_c","_mNs","_uhri","_nearest","_str","_villages"];
_uhri = _this select 0;
[getposATL _uhri,"KIA","ColorRed"] SPAWN SAOKCREATEMARKER;
if (random 1 < 0.2) then {
_nearest = [_uhri] CALL NEARESTVILLAGE; 
_str = (_nearest + "A"); 
_str CALL SAOKIMPREL;
//SOME VILLAGES MAY HEARD OF IT
_villages = [_nearest];
_nearest = [_uhri,[_nearest]] CALL NEARESTVILLAGE; 
_villages set [count _villages,_nearest];
_c = count _villages - 1;
for "_i" from 0 to _c do {
private ["_xx"];
_xx = _villages select _i;
if (random 1 < 0.5) then {
_str = (_xx + "A"); 
_str CALL SAOKIMPREL;
};
sleep 0.1;
};
};
