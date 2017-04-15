private ["_mar","_mar2"];
waitUntil {sleep 1; !isNil"StartMission"};
sleep 15;
if (!isNil"SAOKRESUME" && {count AmbientCiv > 0}) exitWith {PAIKKAMARKERIT = 1;};
AmbientCiv = [];
{
_mar = format ["CityM%1",NUMM];
NUMM=NUMM+1;
_mar2 = createMarker [_mar,position _x];
_mar2 setMarkerShape "ELLIPSE";
//_mar2 setMarkerType "Empty";
_mar2 setMarkerAlpha 0.35;
_mar2 setMarkerBrush "FDiagonal";
_mar2 setMarkerSize (size _x);
_mar2 setMarkerDir (direction _x);
_mar2 setMarkerText "";
_ran = ["None","Medical","AntiAir","AntiTank","MachineGunners"]call RETURNRANDOM;
[(_mar+"B"),_ran] SPAWN SAOKVILSET;
_ran = ["Hostile","Hostile","Angry","Friendly","Neutral","Neutral"]call RETURNRANDOM;
[(_mar+"A"),_ran] SPAWN SAOKVILSET;
_mar2 setMarkerColor (_ran CALL SAOKRELTOCOLOR);
AmbientCiv set [count AmbientCiv,_mar];
} foreach (nearestLocations [getPosATL dataStorageS, ["NameVillage","NameCity","NameCityCapital"], 20000]); 
{
if !(text _x in ["military","airbase","Terminal","AAC airfield"]) then {
_mar = format ["CityM%1",NUMM];
NUMM=NUMM+1;
_mar2 = createMarker [_mar,position _x];
_mar2 setMarkerShape "ELLIPSE";
//_mar2 setMarkerType "Empty";
_mar2 setMarkerAlpha 0.35;
_mar2 setMarkerBrush "BDiagonal";
_mar2 setMarkerSize (size _x);
_mar2 setMarkerDir (direction _x);
_mar2 setMarkerText "";
_ran = ["None","Medical","AntiAir","AntiTank","MachineGunners"]call RETURNRANDOM;
[(_mar+"B"),_ran] SPAWN SAOKVILSET;
_ran = ["Hostile","Hostile","Angry","Friendly","Neutral","Neutral"]call RETURNRANDOM;
[(_mar+"A"),_ran] SPAWN SAOKVILSET;
_mar2 setMarkerColor (_ran CALL SAOKRELTOCOLOR);
AmbientCiv set [count AmbientCiv,_mar];
};
} foreach (nearestLocations [getPosATL dataStorageS, ["NameLocal"], 20000]); 

AmbientCivN = + AmbientCiv; 
[] CALL SAOKVILAD;
PAIKKAMARKERIT = 1;
publicvariable "AmbientCivN";
publicvariable "AmbientCiv";
