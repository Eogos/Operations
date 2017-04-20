private ["_usedmag", "_g","_isForest","_ran","_uni"];
_usedmag = _this select 0;
_usedmuz = _this select 1;
_uni = _this select 2;
if (_usedmuz == "SmokeShellMuzzle" || _usedmuz == "GL_3GL_F" || _usedmuz == "M203Muzzle") then {
if (_usedmag == "UGL_FlareGreen_F") then {
_nul = [] SPAWN {
player setvariable ["Flare",1];
sleep 300;
player setvariable ["Flare",nil];
};
};
_nul = [_uni] SPAWN FSmokeAr;
if (_usedmag == "1Rnd_SmokeYellow_M203" || _usedmag == "SmokeShellYellow" || _usedmag == "SmokeShellPink"  || _usedmag == "SmokeShellOrange" || _usedmag == "SmokeShellGreen" || _usedmag == "SmokeShellRed" ||  _usedmag == "SmokeShell") then {
//_g = + CAMPUNITS; 
sleep 2;
_isForest = if (surfaceType position _uni == "#CRForest1" || surfaceType position _uni == "#CRForest2" ) then {true} else {false};
if (!_isForest) then {
[[_uni,_usedmag],"SAOKMULTISMOKESIG",false,false] spawn BIS_fnc_MP;

[[_uni,_usedmag],"SAOKMULTISMOKESIG2",false,false] spawn BIS_fnc_MP;
};
};

if (daytime < 4.7 || daytime > 19.5) then {
[[_uni,_usedmag],"SAOKMULTISMOKESIG3",false,false] spawn BIS_fnc_MP;
};
};




//thank ruebe for surfaceType


