if (isServer) then {
//WEATHER
private ["_a1","_a2","_a3"];
while {true} do {
_ocast = (random 1);
600 setOvercast _ocast;
_a1 = [0.1,0.3,0.4] call RETURNRANDOM;
_a2 = [0.005,0.01,0.01,0.015] call RETURNRANDOM;
_a3 = [10,40,80,100] call RETURNRANDOM;
(100 + (random 200)) setFog [random _a1,0.005 + random _a2,random _a3];
sleep 100;
if (overcast > 0.7) then {10 setRain (random 1)};
sleep 100;
if (overcast > 0.7) then {10 setRain (random 1)};
sleep 100;
if (overcast > 0.7) then {10 setRain (random 1)};
sleep 100;
if (overcast > 0.7) then {10 setRain (random 1)};
sleep 100;
if (overcast > 0.7) then {10 setRain (random 1)};
sleep 100;
if (overcast > 0.7) then {10 setRain (random 1)};
};
};