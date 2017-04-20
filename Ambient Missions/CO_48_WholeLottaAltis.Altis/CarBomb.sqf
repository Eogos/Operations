private ["_car","_exp"];
if (isNil"VarDisableArty") then {
_car = _this select 0;
waituntil {sleep 3; isNull _car || count ((getposATL _car) nearEntities [["SoldierWB","SoldierGB"],40]) > 0 || {{typeof _x iskindof "SoldierWB" || typeof _x iskindof "SoldierGB"} count crew _x > 0} count ((getposATL _car) nearEntities [["Car"],20]) > 0 };
if (!isNull _car) then {if ({alive _x} count crew _car > 0) then {
if (random 1 > 0.8) then {
_exp = "M_Strela_AA" createvehicle getposATL _car;
sleep 0.1;
_exp = "M_Strela_AA" createvehicle getposATL _car;
} else {
_exp = "Bo_GBU12_LGB" createvehicle getposATL _car;
};
};
};
};