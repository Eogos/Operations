sleep 15;
while {true} do {
sleep (300+(random 700));
VarPG = [3,4,5] call RETURNRANDOM;
if (DIFLEVEL < 1) then {VarPG = [2,3,4] call RETURNRANDOM;};
//VarArty = (random 0.7);
EVEHMAX = [2,3] call RETURNRANDOM;
if (DIFLEVEL < 1) then {EVEHMAX = [1,2] call RETURNRANDOM;};
FVEHMAX = [0,1] call RETURNRANDOM;
FINFMAX = [0,1] call RETURNRANDOM;
if (DIFLEVEL < 1) then {FINFMAX = [0,1] call RETURNRANDOM;};
VarReUnits = 3 + (random 4);
VarReEnemies = 5 + (random 14);
VarTRChop = [true,true,false,false] call RETURNRANDOM;
VarAIR = [true,true,false,false] call RETURNRANDOM;
VarAIRF = [true,true,false,false] call RETURNRANDOM;

[[],"SAOKMULTIPLAYERN",nil,false] spawn BIS_fnc_MP;
};
