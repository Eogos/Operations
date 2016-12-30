if ((!isServer) && (player != player)) then {waitUntil {player == player};};

//titleText ["Storm Script DEMO", "BLACK FADED", 0.2];

setViewDistance 2000;

[] execVM "briefing.sqf";

// un-comment the script you want to launch

// Monsoon
null = [220,120,true] execvm "AL_storm\al_monsoon.sqf";

// Dust Storm
//null = [80,120,true,true] execvm "AL_storm\al_duststorm.sqf";

// TORNADO
//null = ["p1","p2"] execvm "AL_storm\al_tornado.sqf";