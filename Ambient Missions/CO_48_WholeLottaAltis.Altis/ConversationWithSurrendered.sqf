
private ["_civ","_list","_toChoose","_nearest","_relat","_line","_v","_head","_nul","_tasks","_picked","_Eveh","_lead","_Einf","_n","_unts"];
sleep (random 0.05);
if (side player != WEST) exitWith {};
if (isNil"PUHUMASSA" && !dialog) then {
PUHUMASSA = true;
_unts = ((getposATL player) nearEntities [["Man"],7]);
_civ = player;
{if (!isPlayer _x && {_x distance player < 7} && {alive _x} && {leader _x != player} && {!isNil{(_x getvariable "SaOkSurrendered")}}) exitWith {if (!(_x in CIVIGNORE)) then {[_x] SPAWN FUNKTIO_IGNORETIMED;}; _civ = _x; dostop _x;_x dowatch player; _list = _x; [_x] SPAWN {(_this select 0) setvariable ["Talki",1,true];sleep 120;(_this select 0) dofollow (_this select 0);(_this select 0) setvariable ["Talki",nil,true];};};} foreach _unts; 
if (!isPlayer _civ) then {
[_civ, "ZafV", "ZafVoices\sounds.bikb", ""]CALL SAOKKBTOPIC;
player setvariable ["CivC",_civ,true];
[[_civ,player],"SAOKSTOPAI",false,false] spawn BIS_fnc_MP;
};
_u = [];
{if ([_x, player] CALL FUNKTIO_LOS) then {_u set [count _u,_x];};} foreach _unts;
if (count _u > 0) then {
_ppp = _u call RETURNRANDOM;
{if (_x distance player < _ppp distance player) then {_ppp = _x;};} foreach _u;
_unts = + [_ppp];
};
_line = ["*Staring at you*"] call RETURNRANDOM;
_head = _line;
_toChoose = ["Who do we have here? You did a vise thing to surrender"];
if (!isNil{_civ getvariable "Chatted"}) then {
[_civ, player, "ZafV", "Pow1"] SPAWN SAOKKBTELL;
_head = "Leave me alone";
_toChoose = ["..."];
};
_postOK = ([] CALL SAOKNEARESTGPWITHPOWROOM);
if (typename _postOK != "STRING") then {_toChoose set [count _toChoose, "Lets move you to POW cell"];};
_nul = [_head, _toChoose,"",[["JinN20","JinN21","JinN22","JinN23","JinN24"],["JinN26","JinN27","JinN28","JinN29"]],player] SPAWN FConversationDialogSol;
waitUntil {sleep 0.5; scriptdone _nul};
if (isNil"LineSelected") exitWith {PUHUMASSA = nil;};
if (LineSelected == 0) then {
if (!isNil{_civ getvariable "Chatted"}) exitWith {PUHUMASSA = nil;};
_nearest = [] CALL NEARESTVILLAGE; 
_relat = (_nearest + "A") CALL SAOKVILRET;
_line = ["Leave me alone","You stink","Dont kill me, I have family","Please, I was forced to fight on this side","*spits*"];
_c = floor (random (count _line - 1));
_head = _line select _c;
_pa = "Pow";
_c = _c + 1;
_pa = _pa + (format["%1",_c]);
_toChoose = ["Tell me what you know","Any last words?","Wait here"];
_nul = [_head, _toChoose,"",[["JinN30","JinN31"],["JinN34","JinN35","JinN43","JinN44","JinN45"],["JinN25"]]] SPAWN FConversationDialogSur;
[_civ, player, "ZafV", _pa] SPAWN {
sleep 3;
_this SPAWN SAOKKBTELL;
};
};
if (LineSelected == 1) exitWith {
_post = _postOK;
_ar = (_post getvariable "PowCells");
{
if ((_x select 1) == "") exitWith {
if (_post in activatedPost) then {
_ar set [_foreachIndex, [(_x select 0), "Taken", face _civ,_civ]];_post setvariable ["PowCells",_ar,true];
_civ setpos (_x select 0);
_civ setvariable ["SaOkSurrendered",nil,true];
_civ disableAI "MOVE";
removeallweapons _civ;
_civ setvariable ["PowMan",1,true];
removeHeadgear _civ;
removeVest _civ;
removeBackPack _civ;
removeUniform _civ;
removeAllAssignedItems _civ;
if (isNil{(_post getvariable "Junk")}) then {_post setvariable ["Junk",[_civ],true];} else {_post setvariable ["Junk",(_post getvariable "Junk")+[_civ],true];};
} else {
_ar set [_foreachIndex, [(_x select 0), "Taken", face _civ]];_post setvariable ["PowCells",_ar,true];
deletevehicle _civ;
};
};
} foreach (_post getvariable "PowCells");
};
waitUntil {sleep 0.5; scriptdone _nul};
if (isNil"LineSelected") exitWith {PUHUMASSA = nil;};
if (LineSelected in [0,1]) then {
_civ setvariable ["Chatted",1,true];
_tasks = [] CALL POWINFO;
_picked = _tasks call RETURNRANDOM;
_nul = [_picked] execVM _picked;
}; 


};
PUHUMASSA = nil;