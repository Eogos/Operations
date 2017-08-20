// If respawn tickets were disabled, remove the initial ticket for each of the players
if (missionNamespace getVariable "BIS_respawnTickets" == 0) then {[(_this select 0),-1] call BIS_fnc_respawnTickets};

// Delete the dead body if all players are far away
_null = (_this select 1) execVM "Scripts\BuryCorpse.sqf";
