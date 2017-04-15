private ["_player","_hitwhere","_damage","_source"];
_damage = 0;
if (isNil{player getvariable "SaOkHealed"}) then {
_player = _this select 0;
_hitwhere = _this select 1;
_damage = _this select 2;
_source = _this select 3;
_n = 0;
//["BIS_fnc_setObjectVar_object1","<NULL-object>"]
if ((str _source) in ["BIS_fnc_setObjectVar_object1","<NULL-object>"]) then {
_damage = damage player + 0.1;
[] SPAWN BIS_fnc_damagePulsing;
[(3+random 10)] SPAWN BIS_fnc_bloodEffect;
[player,_damage] SPAWN BIS_fnc_dirtEffect;
if ((damage player + _damage) >= 0.9) then {
_damage = damage player; 
};
} else {
_n = 1;
_damage = damage player + (_damage * PLSTREGHT);
if (_damage * PLSTREGHT < 0.1) then {_damage = damage player + 0.1;};
if ((damage player + _damage) >= 0.9) then {
_n = 2;
_damage = 0; 
player SPAWN FPlayerDamage;
if (rating player < 0) then {
player addrating ((abs (rating player))+2500); 
(group player) selectLeader player;
};
};
};
/*
_ar = velocityModelSpace _source;
_num = (_ar select 0)^2+(_ar select 1)^2+(_ar select 2)^2;
_num = _num ^ 0.5;
hint format ["D%1 DP%2 MODE%3 SOURCE%4",_damage, damage player,_n,speed _source];
*/
};
_damage