private ["_civ"];
_civ = _this select 0;
CIVIGNORE set [count CIVIGNORE,_civ];
sleep 120;
CIVIGNORE = CIVIGNORE - [_civ];

