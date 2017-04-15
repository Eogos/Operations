private ["_usedmag", "_g","_isForest","_ran","_uni"];
_usedmag = _this select 0;
_usedmuz = _this select 1;
_uni = player;
if (_usedmag == "UGL_FlareGreen_F" || {_usedmag == "FlareGreen_F"} || {_usedmag == "3Rnd_UGL_FlareGreen_F"}) then {
_nul = [] SPAWN {
player setvariable ["Flare",1,true];
sleep 300;
player setvariable ["Flare",nil,true];
};
};

if (_usedmag == "SmokeShell" || {_usedmag == "1Rnd_SmokeYellow_M203"} || {_usedmag == "SmokeShellYellow"} || {_usedmag == "SmokeShellPink"}  || {_usedmag == "SmokeShellOrange"} || {_usedmag == "SmokeShellGreen"} || {_usedmag == "SmokeShellRed"} ) then {
_nul = [player] SPAWN FSmokeAr;
_g = + CAMPUNITS; 
sleep 2;
_isForest = if (surfaceType getposATL _uni == "#CRForest1" || {surfaceType getposATL _uni == "#CRForest2"}) then {true} else {false};
if (!_isForest) then {
{if (leader _x distance vehicle _uni < 700 && (_usedmag == "SmokeShellYellow" || _usedmag == "1Rnd_SmokeYellow_M203" || random 1 < 0.5)) then {_x move [(getposATL _uni select 0)+(random 100)-(random 100),(getposATL _uni select 1)+(random 100)-(random 100),0];} else {if (leader _x distance vehicle _uni < 1000 && random 1 < 0.5 && (_usedmag == "SmokeShellYellow" || _usedmag == "1Rnd_SmokeYellow_M203"|| random 1 < 0.5)) then {_x move [(getposATL _uni select 0)+(random 100)-(random 100),(getposATL _uni select 1)+(random 100)-(random 100),0];};};} foreach FriendlyVehicles + FriendlyInf;
{
if (_x distance vehicle _uni < 700 && (_usedmag == "SmokeShellYellow" || _usedmag == "1Rnd_SmokeYellow_M203" || random 1 < 0.5)) then {
if (isNil{_x getvariable "Called"}) then {_x setvariable ["Called",true];};
_x forcespeed -1;unassignvehicle _x; group _x move [(getposATL _uni select 0)+(random 100)-(random 100),(getposATL _uni select 1)+(random 100)-(random 100),0];_nul = [group _x,"ColorYellow"] SPAWN FUNKTIO_GM;
} else {
if (_x distance vehicle _uni < 1000 && random 1 < 0.5 && (_usedmag == "SmokeShellYellow" || _usedmag == "1Rnd_SmokeYellow_M203" || random 1 < 0.5)) then {
if (isNil{_x getvariable "Called"}) then {_x setvariable ["Called",true];};
_x forcespeed -1;unassignvehicle _x; group _x move [(getposATL _uni select 0)+(random 100)-(random 100),(getposATL _uni select 1)+(random 100)-(random 100),0];_nul = [group _x,"ColorYellow"] SPAWN FUNKTIO_GM;
};
};
} foreach _g;
};
};
if (daytime < 4.7 || {daytime > 19.5}) then {
if (_usedmag == "FlareYellow_M203" || _usedmag == "FlareRed_M203" || _usedmag == "FlareGreen_M203"|| _usedmag == "FlareWhite_M203" || _usedmag == "FlareWhite_GP25"|| _usedmag == "FlareGreen_GP25"|| _usedmag == "FlareRed_GP25"|| _usedmag == "FlareYellow_GP25") then {
_isForest = if (surfaceType getposATL _uni == "#CRForest1" || surfaceType getposATL _uni == "#CRForest2" ) then {true} else {false};
_ran = if (_isForest) then {250} else {50};
_g = + CAMPUNITS; 
if (_usedmag == "FlareRed_M203" || _usedmag == "FlareYellow_M203" || _usedmag == "FlareYellow_GP25") then {

{if ((getposATL _uni) distance _x < 1000) then {if (isNil{_x getvariable "Called"}) then {_x setvariable ["Called",true];};_x forcespeed -1;unassignvehicle _x; group _x move [(getposATL _uni select 0)+(random _ran)-(random _ran),(getposATL _uni select 1)+(random _ran)-(random _ran),0];_nul = [group _x,"ColorYellow"] SPAWN FUNKTIO_GM;};} foreach _g;
_rr = if (_isForest) then {[]} else {FriendlyVehicles};
{if (leader _x distance vehicle _uni < 1000) then {_x move [(getposATL _uni select 0)+(random _ran)-(random _ran),(getposATL _uni select 1)+(random _ran)-(random _ran),0];};} foreach _rr + FriendlyInf;
} else {
{if ((getposATL _uni) distance _x < 600 && (random 1 < 0.5)) then {if (isNil{_x getvariable "Called"}) then {_x setvariable ["Called",true];};_x forcespeed -1;unassignvehicle _x; group _x move [(getposATL _uni select 0)+(random _ran)-(random _ran),(getposATL _uni select 1)+(random _ran)-(random _ran),0];_nul = [group _x,"ColorYellow"] SPAWN FUNKTIO_GM;};} foreach _g;
_rr = if (_isForest) then {[]} else {FriendlyVehicles};
{if (leader _x distance vehicle _uni < 600 && (random 1 < 0.5)) then {_x move [(getposATL _uni select 0)+(random _ran)-(random _ran),(getposATL _uni select 1)+(random _ran)-(random _ran),0];};} foreach _rr + FriendlyInf;
};
};
};





//thank ruebe for surfaceType


