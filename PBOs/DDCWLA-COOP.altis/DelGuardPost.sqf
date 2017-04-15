private ["_post","_player","_costT","_nul"];
_post = _this select 0;
_player = _this select 1;
if (!isNil{_post getvariable "GCreator"} && {(_post getvariable "GCreator") == name _player}) then {
_costT = 0;
{
_costT = _costT + ((_x select 0) CALL CONSCOST);
} foreach (_post getvariable "StaticO");
{
_costT = _costT + ((_x select 0) CALL CONSCOST);
} foreach (_post getvariable "StaticOS");
{
_costT = _costT + ((_x select 0) CALL CONSCOST);
} foreach (_post getvariable "StaticW");
_n = [side _player,_costT] SPAWN PrestigeUpdate;
[[_costT, "Returns",side _player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
deletemarker (_post getvariable "Gmark");
GuardPosts = GuardPosts - [_post];
publicVariable "GuardPosts";
_post CALL SAOKCONSONDELPOST;
};
 