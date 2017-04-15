//[CIV,PLAYER] [[_civ,player],"SAOKSTOPAI",false,false] spawn BIS_fnc_MP;
//[[_civ,anim],"SAOKSMOVE",false,false] spawn BIS_fnc_MP;
SAOKSMOVE = {(_this select 0) switchMove (_this select 1);};
SAOKPMOVE = {(_this select 0) playMoveNow (_this select 1);};
SAOKAICAMPADDF = {
private ["_xPos"];
sleep (random 5);
_xPos = getposATL _this;
if !(isNil{_this getvariable "WaitGG"}) then {_xPos = _this getvariable "WaitGG"; waitUntil {sleep 6; isNull _this || {!alive _this} || {isNil{_this getvariable "WaitGG"}}};} else {
waitUntil {sleep 8; isNull _this || {!alive _this} || {vehicle _this == _this && {speed _this < 1}}};
_xPos = getposATL _this;
};
if (isNull _this || {!alive _this}) exitWith {};
_this setvariable ["CBFirePs",[]];
_this setvariable ["CBHouses",[_xPos, 100]];
_this setvariable ["CBgPoints",[]];
_this setvariable ["CBCpos",_xPos];
_this setvariable ["gPos",[0,0,0]];
_this setbehaviour "SAFE";
MIlunitsAICAMP pushBack _this;
};
SAOKMARKCOL = {
(_this select 0) setmarkercolor (_this select 1);
};
SAOKSTOPAI = {
dostop (_this select 0);
(_this select 0) dowatch (_this select 1); 
(_this select 0) dotarget (_this select 1);
[(_this select 0)] SPAWN {sleep 120;(_this select 0) dofollow (_this select 0);};
(_this select 0) disableAI "Move";
_this SPAWN {
waitUntil {sleep 5; isNull (_this select 0) || {(_this select 1) getvariable "CivC" != (_this select 0)}};
if !(isNull (_this select 0)) then {(_this select 0) enableAI "Move";};
};
};
SAOKCARLOCK = {(_this select 0) lock (_this select 1);};
SAOKCOLLISION = {
private ["_s","_b","_c","_a"];
_a = _this select 0;
_c = _this select 1;
_s = sizeOf (typeof _a);
_b = false;
if ({lineIntersects [ATLtoASL (_a modelToWorld [_x select 0,_x select 1,0]), ATLtoASL (_a modelToWorld [_x select 0,_x select 1,-2]), _a,_c]} count [[-_s,_s],[-_s,-_s],[_s,_s],[_s,-_s],[0,0]] > 0) then {_b = true;};
_b
};

SAOKTCOND = {
private ["_bol"];
_bol = false;
switch _this do {
//&& {CapturedAll > 2}
case "SAOKENDT": {_bol = [] call {count AmbientZones > 12 && {{getmarkercolor _x == "ColorRed"} count AmbientZones == 0}};};
case "maintasks\captureofficer.sqf": {_bol = [] call {count AmbientZones > 12 && {(({getmarkercolor _x == "ColorRed"} count AmbientZones) / (count AmbientZones)) < 0.2}};};
case "SAOKPIERT": {_bol = [] call {"ResHelp" in (SaOkmissionnamespace getvariable "Progress") && {{getmarkercolor _x == "ColorBlue"} count AmbientZones > 1}};};
case "SAOKFFT": {_bol = [] call {{getmarkercolor _x == "ColorBlue"} count AmbientZones > 2};};
};
_bol
};

SAOKFASTTMAPM = {
private ["_desP","_data","_ctrl","_myDisplay"];
disableserialization;
_myDisplay = findDisplay 1233;
_ctrl = _myDisplay displayCtrl 888;
_data = if (!isNil{SaOkmissionnamespace getvariable "FastData"}) then {SaOkmissionnamespace getvariable "FastData"} else {[]};
_desP = getposATL player;
{
if (_this == _x select 1) exitWith {_desP = _x select 0;};
} foreach _data;
_ctrl ctrlMapAnimAdd [2, 0.1, _desP];
ctrlMapAnimCommit _ctrl;
};

SAOKLOWERRELVIL = {
private ["_str","_nearest"];
_nearest = if (typename _this == "STRING") then {_this} else {[] CALL NEARESTVILLAGE}; 
_str = (_nearest + "A"); 
if !(_str CALL SAOKVILCON) then {
_str = (_nearest + "A"); 
[_str,"Angry"] SPAWN SAOKVILSET;
} else {
if (_str CALL SAOKVILRET == "Angry") then {
_str = (_nearest + "A"); 
[_str,"Hostile"] SPAWN SAOKVILSET;
} else {
_str = (_nearest + "A"); 
if (_str CALL SAOKVILRET != "Hostile") then {
[_str,"Angry"] SPAWN SAOKVILSET;
};
};
};
};
 
//CENTER RADIUS MINDISTANCE LANDTYPE _start = [(vehicle player),_d*0.5,200,"(1 + houses) * (1 - sea)"] CALL SAOKSEEKPOS;
SAOKSEEKPOS = {
private ["_start","_st","_ar","_max","_cen","_rad","_rad2","_blk"];
_cen = _this select 0;
_rad = if (count _this > 1 && {typename (_this select 1) == "SCALAR"}) then {_this select 1} else {1000};
_rad2 = if (count _this > 1 && {typename (_this select 1) == "SCALAR"}) then {_this select 1} else {1000};
_blk = if (count _this > 2 && {typename (_this select 2) == "SCALAR"}) then {_this select 2} else {10};
if (_rad > 1000 && {_rad - _blk >= 500}) then {_rad = 1000 + (random (_rad - 1000));_rad2 = 500;};
_start = [_cen,(_rad*0.5)+_blk] CALL SAOKSEARCHPOS;
_max = 0;
while {surfaceiswater _start && {_max < 5}} do {_start = [_cen,(_rad*0.5)+_blk] CALL SAOKSEARCHPOS;_max = _max + 1;};
_ar = [_start, ((_rad2*0.5) - (_blk*0.5)),_this select 3];
if (count _this > 4) then {_ar pushBack (_this select 4);};
_st = _ar CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
_start
};
SAOKSEEKPOSAR = {
private ["_start","_st","_ar","_max","_cen","_rad","_rad2","_blk"];
_cen = _this select 0;
_rad = if (count _this > 1 && {typename (_this select 1) == "SCALAR"}) then {_this select 1} else {1000};
_rad2 = if (count _this > 1 && {typename (_this select 1) == "SCALAR"}) then {_this select 1} else {1000};
_blk = if (count _this > 2 && {typename (_this select 2) == "SCALAR"}) then {_this select 2} else {10};
if (_rad > 1000 && {_rad - _blk >= 500}) then {_rad = 1000 + (random (_rad - 1000));_rad2 = 500;};
_start = [_cen,(_rad*0.5)+_blk] CALL SAOKSEARCHPOS;
_max = 0;
while {surfaceiswater _start && {_max < 5}} do {_start = [_cen,(_rad*0.5)+_blk] CALL SAOKSEARCHPOS;_max = _max + 1;};
_ar = [_start, ((_rad2*0.5) - (_blk*0.5)),_this select 3];
if (count _this > 4) then {_ar pushBack (_this select 4);};
_st = _ar CALL FUNKTIO_POS;
_st
};
//WATER
SAOKSEEKPOSW = {
private ["_start","_st","_ar","_max","_cen","_rad","_rad2","_blk"];
_cen = _this select 0;
_rad = _this select 1;
_rad2 = _this select 1;
_blk = _this select 2;
if (_rad > 1000 && {_rad - _blk >= 500}) then {_rad = 1000 + (random (_rad - 1000));_rad2 = 500;};
_start = [_cen,(_rad*0.5)+_blk] CALL SAOKSEARCHPOS;
_max = 0;
while {!surfaceiswater _start && {_max < 5}} do {_start = [_cen,(_rad*0.5)+_blk] CALL SAOKSEARCHPOS;_max = _max + 1;};
_ar = [_start, ((_rad2*0.5) - (_blk*0.5)),_this select 3];
if (count _this > 4) then {_ar pushBack (_this select 4);};
_st = _ar CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
_start
};





SAOKMONIVALINTA = {
private ["_pp","_p","_a","_ok","_myDisplay","_t","_ctr"];
disableserialization;
_ok = createDialog "ConversationDialog2"; 
_myDisplay = findDisplay 0232;
_ctr = (_myDisplay displayCtrl 888);
{
lbAdd [1500, _x];
} foreach _this;
lbSetCurSel [1500, 0];
_a = 0;
_t = 4;
_p = 0.02 / 4; 
//(format ["Answer in %1 seconds",_t]) SPAWN HINTSAOK;
_pp = 0;
while {dialog} do {_pp = _pp + _p; _a = (lbCurSel 1500);sleep 0.02;_t = _t - 0.02; _ctr progressSetPosition _pp; if (_t < 0.02) then {closeDialog 0;};};
//(format ["Time to Answer: %1sec",_t]) SPAWN HINTSAOK;
SAOKCHOSEN pushBack _a;
};

SAOKCUTSCENE = {
private ["_bol","_actors","_p","_c","_obj","_chemPos","_b","_ran","_foreachIndex"];
_actors = _this select 0;
_bol = false;
if ((_actors select 0) distance (getposATL player) < 5) then {_bol = true;};
_p = {
private ["_b"];
_b = false;
if (abs(PSHOT - time) > 20) then {_b = true;};
_b
};
if (!isNil"ARSE") then {
waitUntil {sleep 3; isNil"ARSE"};
};
setAccTime 1;
if (!isNil"SAOKCUT" || {!isNil{SaOkmissionnamespace getvariable "SaOkHealed"}} || {!isNil"MATKUSTA"} || {!([] CALL _p)} || {dialog} || {(getposATL vehicle player) select 2 > 2} || {surfaceiswater (getposATL (vehicle player))}) then {
waitUntil {sleep 1; isNil"SAOKCUT" && {isNil{SaOkmissionnamespace getvariable "SaOkHealed"}} && {isNil"MATKUSTA"} && {[] CALL _p} && {!dialog} && {(getposATL vehicle player) select 2 < 2} && {!(surfaceiswater (getposATL (vehicle player)))}};
};
SAOKCUT = true;
{_x CALL SAOKKBTOPIC;} foreach (_this select 1);
titlecut ["","black out",1];
if (_bol) then {_actors set [0,getposATL player];};
{if (typename _x == "OBJECT" && {isNull _x}) then {_actors set [_foreachIndex, player];};} foreach _actors;
if (count _actors > 1) then {
(_actors select 1) setunitpos "UP";
(_actors select 2) setunitpos "UP";
if (!isPlayer (_actors select 1)) then {(_actors select 1) disableAI "MOVE";};
if (!isPlayer (_actors select 2)) then {(_actors select 2) disableAI "MOVE";};
(_actors select 1) allowdamage false;
(_actors select 2) allowdamage false;
};
_p = (_actors select 0);
_chemPos = [(_p select 0)+4-(random 8),(_p select 1)+4-(random 8),0];
_ran = ["Chemlight_blue","Chemlight_green","Chemlight_yellow","Chemlight_red"] call RETURNRANDOM;
_obj = createVehicle [_ran,_chemPos, [], 0, "NONE"]; 
sleep 1;
0 SPAWN SAOKHALTCSAT;
if (count _actors > 1) then {
_c = _actors SPAWN SAOKSEARCHCINEMAPOS;
};
waitUntil {sleep 0.1; count _actors <= 1 || {scriptdone _c}};
player switchmove "";
sleep 1;
SAOKCHOSEN = [];
SAOKcamera = "camera" camcreate [0,0,0];
SAOKcamera cameraeffect ["internal", "back"];
showcinemaBorder false;
sleep 0.5;
player action ["WeaponOnBack", player];
_c = count (_this select 2) - 1;
for "_i" from 0 to _c do {
_c = (((_this select 2) select _i) select 0) SPAWN SAOKCAM;
if (_i == 0) then {
titlecut ["","black in",1];
sleep 1;
};
if (count ((_this select 2) select _i) > 1) then {(((_this select 2) select _i) select 1) SPAWN SAOKKBTELL;};
//MONIVALINTA
if (count (((_this select 2) select _i) select 0) > 3) then {
_b = ((((_this select 2) select _i) select 0) select 3) SPAWN SAOKMONIVALINTA;
while {!scriptdone _b} do {
sleep 0.1;
if (scriptdone _c) then {_c = (((_this select 2) select _i) select 0) SPAWN SAOKCAM;};
};
} else {
waitUntil {sleep 0.1;scriptdone _c};
};
};
titlecut ["","black out",1];
sleep 1;
titletext ["","PLAIN DOWN",7];
deletevehicle _obj;
SAOKcamera cameraeffect ["terminate", "back"];
camdestroy SAOKcamera;
titlecut ["","black in",1];
1 SPAWN SAOKHALTCSAT;
if (count _actors > 1) then {
(_actors select 1) allowdamage true;
(_actors select 2) allowdamage true;
if (!isPlayer (_actors select 1)) then {(_actors select 1) enableAI "MOVE";};
if (!isPlayer (_actors select 2)) then {(_actors select 2) enableAI "MOVE";};
(_actors select 1) setunitpos "AUTO";
(_actors select 2) setunitpos "AUTO";
};
sleep 2;
SAOKCUT = nil;
};

SAOKHALTCSAT = {
private ["_u"];
if (_this == 0) then {
_u = [];
if (!isNil{SaOkmissionnamespace getvariable "HaltedUs"}) then {_u = SaOkmissionnamespace getvariable "HaltedUs";};
{if (side _x == EAST && {!(typeof (vehicle _x) isKindof "Air")}) then {_u pushBack _x; _x enablesimulation false;vehicle _x enablesimulation false;};} foreach allUnits;
SaOkmissionnamespace setvariable ["HaltedUs",_u];
} else {
if (!isNil{SaOkmissionnamespace getvariable "HaltedUs"}) then {
{_x enablesimulation true;vehicle _x enablesimulation true;} foreach (SaOkmissionnamespace getvariable "HaltedUs");
SaOkmissionnamespace setvariable ["HaltedUs",nil];
};
};
};

SAOKSEARCHCINEMAPOS = {
private ["_f","_cen","_unit1","_unit2","_p1","_p2","_ok","_okM","_max","_dir","_SLp1","_SLp2","_di"];
_f = {
private ["_bol","_p1","_p2","_c"];
_bol = false; 
_c = _this;
_p1 = [(_c select 0) + 1,(_c select 1) + 1,(_c select 2)];
_p2 = [(_c select 0) - 1,(_c select 1) - 1,(_c select 2)];
if (lineIntersects [_p1,_p2]) then {_bol = true;};
_p1 = [(_c select 0) - 1,(_c select 1) + 1,(_c select 2)];
_p2 = [(_c select 0) + 1,(_c select 1) - 1,(_c select 2)];
if (lineIntersects [_p1, _p2]) then {_bol = true;};
_bol
};
_cen = _this select 0;
_unit1 = _this select 1;
_unit2 = _this select 2;
_ok = true;
_okM = 0;
_dir = random 180;
_p1 = [(_cen select 0)+ (sin _dir)*(1+random 2),(_cen select 1)+ (cos _dir)*(1+random 2),0.6];
_dir = (_dir + 60 + random 60);
_p2 = [(_cen select 0)+ (sin _dir)*(1+random 2),(_cen select 1)+ (cos _dir)*(1+random 2),0.6];
while {_ok && {_okM < 8}} do {
_okM = _okM + 1;
_dir = random 180;
_p1 = [(_cen select 0)+ (sin _dir)*(1+random 2),(_cen select 1)+ (cos _dir)*(1+random 2),0.6];
_dir = (_dir + 60 + random 60);
_p2 = [(_cen select 0)+ (sin _dir)*(1+random 2),(_cen select 1)+ (cos _dir)*(1+random 2),0.6];
_max = 0;
_SLp1 = _p1 CALL SAOKATLTOASL;
_SLp2 = _p2 CALL SAOKATLTOASL;
while {(lineIntersects [_SLp1, _SLp2] || {_SLp1 CALL _f} || {_SLp2 CALL _f} || {count (_p1 nearObjects ["Static",2]) > 0}|| {count (_p1 nearObjects ["FirePlace_burning_F",3]) > 0} || {count (_p2 nearObjects ["Static",2]) > 0}|| {count (_p2 nearObjects ["FirePlace_burning_F",3]) > 0}) && {_max < 9}} do {
_max = _max + 1;
_dir = random 180;
_p1 = [(_cen select 0)+ (sin _dir)*(1+random 2),(_cen select 1)+ (cos _dir)*(1+random 2),0.6];
_dir = (_dir + 60 + random 60);
_p2 = [(_cen select 0)+ (sin _dir)*(1+random 2),(_cen select 1)+ (cos _dir)*(1+random 2),0.6];
_SLp1 = _p1 CALL SAOKATLTOASL;
_SLp2 = _p2 CALL SAOKATLTOASL;
};
if (_max < 9) then {_ok = false;} else {_dir = random 180;_cen = [(_cen select 0)+ (sin _dir)*(5+random 5),(_cen select 1)+ (cos _dir)*(5+random 5),0];};
sleep 0.1;
};
_p1 set [2,0.3];
_p2 set [2,0.3];
_unit1 setpos _p1;
_unit2 setpos _p2;
_di = [_unit1,_unit2] call BIS_fnc_dirTo;
_di = _di - 15 + (random 30);
_unit1 setdir _di;
group _unit1 setformdir _di;
_di = [_unit2,_unit1] call BIS_fnc_dirTo;
_di = _di - 15 + (random 30);
_unit2 setdir _di;
group _unit2 setformdir _di;
};

SAOKLINECAMOK = {
private ["_f3","_bol","_f","_unit","_camP","_max","_VP","_dP","_a","_b","_c","_d","_e","_tar","_SLp1","_SLp2","_f2"];
_f = {
private ["_a","_b","_c","_bol","_di","_dis","_l","_p"];
_bol = false;
_a = _this select 0;
_b = _this select 1;
_c = _this select 2;
_di = [_b,_c] call BIS_fnc_dirTo;
_dis = _b distance _c;
_l = 0.1;
_p = [(_b select 0)+(sin _di)*_l, (_b select 1)+(cos _di)*_l, 0];
while {_l < _dis && {!_bol}} do {
_l = _l + 0.2;
_p = [(_b select 0)+(sin _di)*_l, (_b select 1)+(cos _di)*_l, 0];
if ({_x != _a} count (_p nearEntities [["Man"], 0.5]) > 0) then {_bol = true;};
};
_bol
};
//behind back check or too close
_f2 = {
private ["_u","_gg","_bol","_dU","_dirTo","_dirTo2","_abs","_abs2"];
_bol = false;
_u = + (getposATL (_this select 0));
_u set [2,0];
_gg = + (_this select 2);
_gg set [2,0];
if (_u distance _gg < 0.4) then {_bol = true;};
if (!_bol) then {
_dU = direction (_this select 0);
_dirTo = [(_this select 0), (_this select 1)] call BIS_fnc_dirTo;
_dirTo2 = [(_this select 0), (_this select 2)] call BIS_fnc_dirTo;
_abs = abs(_dirTo - _dU); 
_abs2 = abs(_dirTo2 - _dU); 
if (_abs >= 90 && {_abs <= 270} || {(_abs2 >= 90 && {_abs2 <= 270})}) then {_bol = true;};
};
_bol
};
_f3 = {
private ["_bol","_uEyeP","_cP","_dis","_h","_disT","_hT","_ang","_cT","_uEyePA","_cPA","_cTA"];
_bol = false;
_uEyeP = ASLtoATL (eyePos (_this select 0));
_uEyePA = (eyePos (_this select 0));
_cP = (_this select 1);
_cPA = ATLtoASL (_this select 1);
_cT = (_this select 2);
_cTA = ATLtoASL (_this select 2);
_dis = [_uEyeP select 0,_uEyeP select 1] distance [_cP select 0,_cP select 1];
_h = abs ((_uEyePA select 2)-(_cPA select 2));
_disT = [_cT select 0,_cT select 1] distance [_cP select 0,_cP select 1];
_hT = abs ((_cTA select 2)-(_cPA select 2));
_ang = asin (_hT/_disT);
if (((_cTA select 2) < (_cPA select 2) && {(_cPA select 2) < (_uEyePA select 2)}) || {((_cTA select 2) > (_cPA select 2) && {(_cPA select 2) > (_uEyePA select 2)})}) then {_ang = -1*_ang;};
if (asin (_h/_dis) > (38+_ang)) then {_bol = true;};
_bol
};

_bol = 0;
_max = 0;
_unit = _this select 0;
_VP = getposATL _unit;
_dP = direction _unit;
_a = _this select 1; 
_b = _this select 2;
_c = _this select 3;
_d = _this select 4;
_e = _this select 5;
_camP = [(_VP select 0)+(sin _dP)*([] CALL _a),(_VP select 1)+(cos _dP)*([] CALL _b),(_VP select 2) +([] CALL _c)];
_tar = [(_VP select 0) + (sin _dP)*([] CALL _d),_VP select 1,(_VP select 2) + ([] CALL _e)];
_SLp1 = _tar CALL SAOKATLTOASL;
_SLp2 = _camP CALL SAOKATLTOASL;
//|| {_camP distance _unit < ((_tar distance _unit)+0.2)}
while {(lineIntersects [_SLp1, _SLp2,_unit] || {[_unit, _tar, _camP] CALL _f} || {[_unit, _camP, _tar] CALL _f3} || {[_unit, _tar, _camP] CALL _f2}) && {_max < 15}} do {
_max = _max + 1;
_camP = [(_VP select 0)+(sin _dP)*([] CALL _a),(_VP select 1)+(cos _dP)*([] CALL _b),(_VP select 2) +([] CALL _c)];
_tar = [(_VP select 0) + (sin _dP)*([] CALL _d),_VP select 1,(_VP select 2) + ([] CALL _e)];
_SLp1 = _tar CALL SAOKATLTOASL;
_SLp2 = _camP CALL SAOKATLTOASL;
};
if !(_max < 15) then {
_bol = 2;
//if ([_unit, _camP, _tar] CALL _f3) then {"EYE NOT" SPAWN HINTSAOK;};
//"MAX" SPAWN HINTSAOK;
};
[_camP,_tar,_bol]
};

SAOKCAMS = {
private ["_bol","_unit","_dat","_cam","_r","_camP","_tar","_max"];
_unit = _this select 0;
_r = _this select 1;
_bol = 1;
_max = 0;
while {_bol != 0} do {
_max = _max + 1;
_cam = if (count _this > 2) then {_this select 2} else {(["CFACE","FACE","UPFACE","UMID","UCLOSE","UFAR"] call RETURNRANDOM)};
switch _cam do {
case "CFACE": {
//"CFACE" SPAWN HINTSAOK;
_dat = [_unit,{0.4 - random 0.8},{(0.4+random 0.1)},{1.5 + random 0.2},{0.05 - random 0.1},{1.6 + random 0.05}] CALL SAOKLINECAMOK;
_camP = _dat select 0;
_tar = _dat select 1;
_bol = _dat select 2;
if (_max > 5) then {_bol = 0;};
if (_bol == 0) then {
SAOKcamera camPrepareTarget _tar;
SAOKcamera camPreparePos _camP;
SAOKcamera camPrepareFOV 0.700;
SAOKcamera camCommitPrepared _r;
};
};
case "UPFACE": {
//"UPFACE" SPAWN HINTSAOK;
_dat = [_unit,{1 + random 0.5},{(0.8+random 0.5)},{1.8 + random 0.1},{0.2 - random 0.4},{1.3 + random 0.1}]  CALL SAOKLINECAMOK;
_camP = _dat select 0;
_tar = _dat select 1;
_bol = _dat select 2;
if (_max > 5) then {_bol = 0;};
if (_bol == 0) then {
SAOKcamera camPrepareTarget _tar;
SAOKcamera camPreparePos _camP;
SAOKcamera camPrepareFOV 0.700;
SAOKcamera camCommitPrepared _r;
};
};
case "FACE": {
//"FACE" SPAWN HINTSAOK;
_dat = [_unit,{1 + random 0.5},{(0.8+random 0.5)},{1.2 + random 0.2},{0.2 - random 0.4},{1.3 + random 0.1}]  CALL SAOKLINECAMOK;
_camP = _dat select 0;
_tar = _dat select 1;
_bol = _dat select 2;
if (_max > 5) then {_bol = 0;};
if (_bol == 0) then {
SAOKcamera camPrepareTarget _tar;
SAOKcamera camPreparePos _camP;
SAOKcamera camPrepareFOV 0.700;
SAOKcamera camCommitPrepared _r;
};
};
case "UFAR": {
//"UFAR" SPAWN HINTSAOK;
_dat = [_unit,{(1 + random 4)},{5-random 10},{0.4 + random 2.5},{0.6 - random 1.2},{1.1 + random 0.2}]  CALL SAOKLINECAMOK;
_camP = _dat select 0;
_tar = _dat select 1;
_bol = _dat select 2;
if (_max > 5) then {_bol = 0;};
if (_bol == 0) then {
SAOKcamera camPrepareTarget _tar;
SAOKcamera camPreparePos _camP;
SAOKcamera camPrepareFOV 0.700;
SAOKcamera camCommitPrepared _r;
};
};
case "UMID": {
//"UMID" SPAWN HINTSAOK;
_dat = [_unit,{(1 + random 4)},{4-random 8},{0.2 + random 1.5},{0.5 - random 1.0},{1.1 + random 0.2}]  CALL SAOKLINECAMOK;
_camP = _dat select 0;
_tar = _dat select 1;
_bol = _dat select 2;
if (_max > 5) then {_bol = 0;};
if (_bol == 0) then {
SAOKcamera camPrepareTarget _tar;
SAOKcamera camPreparePos _camP;
SAOKcamera camPrepareFOV 0.700;
SAOKcamera camCommitPrepared _r;
};
};
case "UCLOSE": {
//"UCLOSE" SPAWN HINTSAOK;
_dat = [_unit,{(1 + random 1)},{2-random 4},{1.2 + random 0.6},{0.3 - random 0.6},{1.1 + random 0.2}]  CALL SAOKLINECAMOK;
_camP = _dat select 0;
_tar = _dat select 1;
_bol = _dat select 2;
if (_max > 5) then {_bol = 0;};
if (_bol == 0) then {
SAOKcamera camPrepareTarget _tar;
SAOKcamera camPreparePos _camP;
SAOKcamera camPrepareFOV 0.700;
SAOKcamera camCommitPrepared _r;
};
};
};
};
};

SAOKCAM = {
private ["_time","_line","_unit","_timeS","_VP","_dP","_r","_c"];
_unit = if (typename (_this select 0) != "ARRAY") then {_this select 0} else {(_this select 0) select 0};
_line = if (typename (_this select 1) != "ARRAY") then {_this select 1} else {(_this select 1) select 0};
_time = if (count _this > 2) then {_this select 2} else {1+(count (toArray _line)*0.15)};
if (isNull _unit) then {_unit = player;};
_VP = getposATL _unit;
_dP = direction _unit;
_timeS = 12 + random 6;
_r = 0;
if (typename _line == "CODE") then {
titletext [((name _unit)+": "+([] CALL _line)),"PLAIN DOWN",7];
} else {
if (_line != "") then {titletext [((name _unit)+": "+_line),"PLAIN DOWN",7];} else {titletext ["","PLAIN DOWN",7];};
};
if (typename (_this select 0) == "ARRAY") then {
_c = [_unit,_r] SPAWN SAOKCAMS;
waitUntil {sleep 0.1;scriptdone _c};
} else {
if (typename (_this select 1) == "ARRAY") then {
_r = (1 + random 1);
_c = [_unit,_r] SPAWN SAOKCAMS;
waitUntil {sleep 0.1;scriptdone _c};
sleep _r;
};
};
_c = [_unit,_timeS] SPAWN SAOKCAMS;
waitUntil {sleep 0.1;scriptdone _c};
sleep (_time - _r);
};


SAOKRCOL = {
private ["_c"];
_c = "<t color='#FF9900'>";
switch _this do {
case "FAC": {
if (SaOK_factories > 0) then {
if (SaOK_power == 0 && {SaOK_pier == 0}) then {_c = "<t color='#CC0000'>";} else {
if (SaOK_factories <= SaOK_power*2 && {SaOK_factories <= SaOK_pier*4}) then {_c = "<t color='#00FF66'>";} else {_c = "<t color='#FF9900'>";};
};
};
};
case "POW": {
if (SaOK_factories > 0) then {
if (SaOK_power == 0) then {_c = "<t color='#CC0000'>";} else {
if (SaOK_factories <= SaOK_power*2) then {_c = "<t color='#00FF66'>";} else {_c = "<t color='#FF9900'>";};
};
};
};
case "PIE": {
if (SaOK_factories > 0) then {
if (SaOK_pier == 0) then {_c = "<t color='#CC0000'>";} else {
if (SaOK_factories <= SaOK_pier*4) then {_c = "<t color='#00FF66'>";} else {_c = "<t color='#FF9900'>";};
};
};
};
case "STO": {if (SaOK_stor > 0) then {_c = "<t color='#00FF66'>";};};
};
_c
};

SAOKCONSRATE = {
private ["_v","_m"];
_v = if (count _this > 0) then {_this select 0} else {((getposATL player) nearEntities [CONSVEHCLAS, 75])};
_m = 1;
if (typename _v == "ARRAY") then {
if (count _v > 0) then {
_v = [_v,[],{player distance _x},"ASCEND"] call BIS_fnc_sortBy;
_v = typeof (_v select 0);
} else {_v = "";};
};
if (_v != "") then {
switch _v do {
case "LIB_SdKfz_7": {_m = 1.2;};
case "LIB_opelblitz_open_y_camo": {_m = 1.0;};
case "LIB_opelblitz_tent_y_camo": {_m = 1.0;};
case "Lib_sdkfz251": {_m = 1.2;};
case "lib_us6_tent": {_m = 1.0;};
case "lib_us6_open": {_m = 1.0;};
case "lib_zis5v": {_m = 1.0;};
case "LIB_Scout_m3": {_m = 1.2;};
case "LIB_US_GMC_Tent": {_m = 1.0;};
case "LIB_US_GMC_Open": {_m = 1.0;};
case "LIB_US_Scout_m3": {_m = 1.1;};
case "Lib_SdKfz251_captured": {_m = 1.2;};
case "B_G_Van_01_transport_F": {_m = 0.9;};
case "I_MRAP_03_F": {_m = 1.3;};
case "I_MRAP_03_gmg_F": {_m = 1.6;};
case "I_MRAP_03_hmg_F": {_m = 1.6;};
case "B_Truck_01_Repair_F": {_m = 0.8;};
case "B_Truck_01_box_F": {_m = 0.6;};
case "B_Truck_01_transport_F": {_m = 0.9;};
case "B_Truck_01_covered_F": {_m = 0.9;};
case "B_MRAP_01_F": {_m = 1.3;};
case "B_MRAP_01_gmg_F": {_m = 1.6;};
case "B_MRAP_01_hmg_F": {_m = 1.6;};
case "B_APC_Wheeled_01_cannon_F": {_m = 1.4;};
case "I_APC_Wheeled_03_cannon_F": {_m = 1.4;};
case "B_APC_Tracked_01_rcws_F": {_m = 1.4;};
case "I_Heli_Transport_02_F": {_m = 1;};
};
};
_m
};

SAOKADDCSATGUARDPTOPOS = {
private ["_st","_start","_d","_nul"];
_st = [_this, 150,"(1 - sea) * (1 + meadow)* (1 - hills)",""] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
_d = 150;
while {!([_start,40] CALL SAOKISFLAT)} do {
_d = _d + 30;
_st = [_this, _d,"(1 - sea) * (1 + meadow)* (1 - hills)",""] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
sleep 1;
};
_nul = [_start,"",(15+random 25)] SPAWN CreateRoadBlock;
};

//LZ, SEA START,  JAKAUMA
SAOKCSATCHOPSUP = {
private ["_class","_pPos","_tg1","_posPl","_tg1wp1","_nul"];
_class = (AIRFIGTHER select 1)+(AIRARMCHOP select 1); 
_class = _class call RETURNRANDOM;	
_pPos = getposATL vehicle  (([] CALL AllPf) call RETURNRANDOM);
_tg1 = [[(_pPos select 0)+2500,(_pPos select 1)+2500,50], 0, _class, EAST] call SPAWNVEHICLE;
_posPl = [(_pPos select 0) + 100 -(random 200), (_pPos select 1)+ 100 -(random 200), 0];
_tg1wp1= (_tg1 select 2) addWaypoint [_posPl, 0]; 
[(_tg1 select 2), 1] setWaypointBehaviour "AWARE";
[(_tg1 select 2), 1] setWaypointType "GUARD";
_nul = [(_tg1 select 2), [1541.39,5059.05,0],200] SPAWN FUNKTIO_MAD;
};

SAOKCSATBOATINF = {
private ["_maa","_start","_LZ","_rad","_classes","_st","_tank","_cl","_landP","_params","_group"];
_start = _this select 0;
_LZ = _this select 1;
_rad = _this select 2;
_st = [_LZ, _rad,"(1 - sea)",""] CALL FUNKTIO_POS;    
_maa = (_st select 0) select 0;  
_LZ = [_LZ,_maa] CALL SAOKSEEKSHORE;  
_classes = []; 
_st = [_start, _rad,"(1 + sea)",""] CALL FUNKTIO_POS;    
_start = (_st select 0) select 0;  
_tank = ["O_Boat_Armed_01_hmg_F","O_Boat_Transport_01_F"] call RETURNRANDOM; 
_cl = [ENEMYC1,ENEMYC2,ENEMYC3] call RETURNRANDOM;
_classes pushBack (_cl call RETURNRANDOM);
_classes pushBack (_cl call RETURNRANDOM);
_classes pushBack (_cl call RETURNRANDOM);
_classes pushBack (_cl call RETURNRANDOM);
_st = [_LZ, 200,"(1 - sea)",""] CALL FUNKTIO_POS;    
_landP = (_st select 0) select 0;  
//[_start,"KIA","ColorWhite"] SPAWN SAOKCREATEMARKER;
//[_LZ,"KIA","ColorBlack"] SPAWN SAOKCREATEMARKER;
//[_landP,"KIA","ColorOrange"] SPAWN SAOKCREATEMARKER;
_params = [_start, _LZ, _landP, EAST, 0, _tank,_classes,[0.5,0.6],0,""];
_group = _params CALL FUNKTIO_LandTransportE;
_group
};

SAOKCORRECTSEASTART = {
private ["_max","_start2"];
_max = 0;
_start2 = [_this,1500,500] CALL SAOKSEARCHPOS; 
while {!surfaceisWater _start2 || {_start2 distance _this < 1000} || {[_start2,_this] CALL SAOKLANDBETWEEN}} do {
_start2 = [_this,1500,500] CALL SAOKSEARCHPOS; 
_max = _max + 1;
if (_max > 30) exitWith {};
};
if (!surfaceisWater _start2) then {_start2 = + _this;};
_start2
};

SAOKLANDBETWEEN = {
private ["_s","_e","_bol","_dir","_p","_Pos","_dis"];
_bol = false;
_s = _this select 0;
_e = _this select 1;
_dir = [_s, _e] call BIS_fnc_dirTo;
_dis = _s distance _e;
_p = 50;
while {_p < _dis} do {
_Pos = [(_s select 0)+(sin _dir)*_p,(_s select 1)+(cos _dir)*_p,0];
if (!surfaceisWater _Pos) exitWith {_bol = true;};
_p = _p + 50;
};
_bol
};

SAOKWATERBETWEEN = {
private ["_s","_e","_bol","_dir","_p","_Pos","_dis"];
_bol = false;
_s = _this select 0;
_e = _this select 1;
if (!isNil"_s" && {!isNil"_e"}) then {
_dir = [_s, _e] call BIS_fnc_dirTo;
_dis = _s distance _e;
_p = 50;
while {_p < _dis} do {
_Pos = [(_s select 0)+(sin _dir)*_p,(_s select 1)+(cos _dir)*_p,0];
if (surfaceisWater _Pos) exitWith {_bol = true;};
_p = _p + 50;
};
} else {_bol = true;};
_bol
};

//FOR MG BOAT
SAOKBOATSPEED = {
private ["_boat","_LZ"];
_boat = _this select 0;
_LZ = _this select 1;
waitUntil {sleep 3; isnull _boat || {_boat distance _LZ < 50}};
if (!isNull _boat) then {_boat forcespeed 3;};
sleep 10;
waitUntil {sleep 3; isnull _boat || {_boat distance _LZ > 30}};
if (!isNull _boat) then {_boat forcespeed -1;};
};

SAOKSEEKSHORE = {
private ["_start","_end","_dir","_range","_shorePos","_max","_dis"];
_start = _this select 0;
_end = if (count _this == 1) then {getmarkerpos "Fac4"} else {_this select 1};
_dir = [_start, _end] call BIS_fnc_dirTo;
_range = 0;
_shorePos = [(_start select 0)+(sin _dir)*_range,(_start select 1)+(cos _dir)*_range,0];
_max = 0;
_dis = _start distance _end;
if (_dis > 1000) then {
while {surfaceisWater _shorePos && {_max < 20}} do {
_max = _max + 1;
_range = _range + 1000;
_shorePos = [(_start select 0)+(sin _dir)*_range,(_start select 1)+(cos _dir)*_range,0];
};
};
if (_dis > 250) then {
_max = 0;
while {!surfaceisWater _shorePos && {_max < 4}} do {
_max = _max + 1;
_range = _range - 250;
_shorePos = [(_start select 0)+(sin _dir)*_range,(_start select 1)+(cos _dir)*_range,0];
};
};
if (_dis > 75) then {
_max = 0;
while {surfaceisWater _shorePos && {_max < 4}} do {
_max = _max + 1;
_range = _range + 75;
_shorePos = [(_start select 0)+(sin _dir)*_range,(_start select 1)+(cos _dir)*_range,0];
};
};
_max = 0;
while {!surfaceisWater _shorePos && {_max < 4}} do {
_max = _max + 1;
_range = _range - 30;
_shorePos = [(_start select 0)+(sin _dir)*_range,(_start select 1)+(cos _dir)*_range,0];
};
_max = 0;
while {surfaceisWater _shorePos && {_max < 4}} do {
_max = _max + 1;
_range = _range + 10;
_shorePos = [(_start select 0)+(sin _dir)*_range,(_start select 1)+(cos _dir)*_range,0];
};
_max = 0;
while {!surfaceisWater _shorePos && {_max < 4}} do {
_max = _max + 1;
_range = _range - 3;
_shorePos = [(_start select 0)+(sin _dir)*_range,(_start select 1)+(cos _dir)*_range,0];
};
_range = _range - 15;
_shorePos = [(_start select 0)+(sin _dir)*_range,(_start select 1)+(cos _dir)*_range,0];
_shorePos;
};

SAOKADDUNIFORM = {
(_this select 0) forceAddUniform (_this select 1);
};

SAOKSEARCHPOS = {
private ["_pos","_cenP","_rad","_xx","_yy","_ar","_max","_arr"];
_cenP = if (typename (_this select 0) == "ARRAY") then {(_this select 0)} else {
if (typename (_this select 0) == "STRING") then {getmarkerpos (_this select 0)} else {
getposATL (_this select 0)
}
};
_rad = _this select 1;
_ar = [];
if (count _this > 2) then {_rad = _rad - (random(_this select 2)); _ar = [(_this select 2)];};
_xx = random _rad;
_yy = _rad - _xx;
if (random 1 < 0.5) then {_xx = _xx*(-1)};
if (random 1 < 0.5) then {_yy = _yy*(-1)};
_pos = [(_cenP select 0) + _xx,(_cenP select 1) + _yy,0];
if (count _this > 3) then {
_arr = [_cenP,_this select 1]+_ar;
_max = 0;
if (_this select 3 == "SEA") then {while {!surfaceisWater _pos && {_max < 7}} do {_pos = (_arr+["SEA"]) CALL SAOKSEARCHPOS;_max = _max + 1;};};
if (_this select 3 == "LAND") then {while {surfaceisWater _pos && {_max < 7}} do {_pos = (_arr+["LAND"]) CALL SAOKSEARCHPOS;_max = _max + 1;};};
}; 
_pos
};

SAOKYELLTOSURRENDER = {
private ["_moreM","_suprised","_barreled","_voice","_units","_ranTe"];
if (vehicle player != player || {currentWeapon player == ""}) exitWith {};
_moreM = {
private ["_bol","_gxx"];
_bol = false;
_gxx = getposATL _this;
if (count (units group _this) < 3 && {{side _x == EAST} count (_gxx nearEntities [["Man"],100]) < 3} && {{side _x != EAST && {side _x != CIVILIAN}} count (_gxx nearEntities [["Man"],300]) > 2}) then {
_bol = true;
};
_bol
};
_suprised = {
private ["_bol"];
_bol = false;
if (_this distance player < 10 && {([_this, player] CALL FUNKTIO_LOS)} && {!([player, _this] CALL FUNKTIO_LOS)}) then {_bol = true;};
_bol
};

_barreled = {
private ["_bol"];
_bol = false;
if (!isNil{_this getvariable "Barreled"} && {(_this getvariable "Barreled") > time}) then {_bol = true;};
_bol
};

_voice = ["JinN17","JinN18","JinN19","JinN20","JinN21","JinN22","JinN23","JinN24"] call RETURNRANDOM;
[player,player, "PlaV", _voice] SPAWN SAOKKBTELL;
if !(isClass(configFile >> "cfgSounds" >> "Civ1")) then {
_ranTe = ["Drop Your Weapon!","Hands Up!","Surrender!","Drop it!","Hold Still!"] call RETURNRANDOM;
titletext [((name player)+": "+_ranTe),"PLAIN DOWN",1];
};
_units = [];
{if (player distance _x < 20) then {_units pushBack _x;};} foreach UNITSTOSUR;
{if (side _x == EAST && {!isPlayer _x} && {vehicle _x == _x} && {isNil{_x getvariable "CantSur"}} && {isNil{_x getvariable "SaOkSurrendered"}} && {isNil{_x getvariable "PowMan"}}) then {_units pushBack _x;};} foreach ((getposATL player) nearEntities [["Man"],30]);
{
if (!isPlayer _x || {_x CALL _moreM} || {_x CALL _suprised} || {_x CALL _suprised} || {damage _x > 0.5} || {_x in UNITSTOSUR}) then {
_x SPAWN SAOKUNITSURRE;
};
} foreach _units;

};

SAOKUNITSURRE = {
private ["_unit","_g","_nul"];
_unit = _this;
if (alive _unit) then {
_g = creategroup EAST;	
[_unit] join _g;
_unit setcaptive true;
_unit stop true;
_unit setunitpos "UP";
removeAllWeapons _unit;	
sleep 1;
};
if (alive _unit) then {
//_unit playMoveNow "AmovPercMstpSnonWnonDnon_AmovPercMstpSsurWnonDnon";
[[_unit,"AmovPercMstpSnonWnonDnon_AmovPercMstpSsurWnonDnon"],"SAOKPMOVE",nil,false] spawn BIS_fnc_MP;
};
if (alive _unit) then {_nul = [_unit] SPAWN FUNKTIO_POISTANTAUTUNUT;_unit setvariable ["SaOkSurrendered",1,true];};
};

SAOKRESETVEHICLE = {
private ["_pGcamp","_car","_class","_cost","_dir","_pos","_id","_mi","_new","_nul"];
if (count (nearestObjects [getposATL player, ["Land_Cargo_House_V1_F"], 20]) == 0) exitWith {};
_pGcamp = [getposATL player,"ColorGreen"] CALL NEARESTGUARDPOST;
if (_pGcamp distance player > 70) exitWith {};
_car = cursorTarget;
if ({typeof _car iskindof _x} count ["Car","Air","Tank","LandVehicle"] == 0 || {count crew _car > 0} || {!alive _car}) exitWith {};
_class = typeof _car;
_cost = 100;
if (_cost > ([side player] CALL PrestigeS)) exitWith {("Cant afford to repair/arm/fuel the vehicle: "+format ["%1 more prestige needed",(_cost-([side player] CALL PrestigeS))]) SPAWN HINTSAOK;};
_dir = direction _car;
_pos = getposATL _car;
_id = _car getvariable "VehID";
_mi = _car getvariable "Minetruck";
deletevehicle _car;
_new = createVehicle [_class,_pos, [], 0, "NONE"];
_new setpos _pos;
_new setdir _dir;
if (!isNil{_id}) then {_new setvariable ["VehID",_id,true];};
if (!isNil{_mi}) then {_new setvariable ["Minetruck",1];};
_n = [side player,-_cost] SPAWN PrestigeUpdate;
[[-_cost, "Vehicle Rearmed/fueled/fixed"],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
};

SAOKISFLAT = {
private ["_bol","_pos","_rad","_h"];
_pos = _this select 0;
_rad = _this select 1;
_bol = false;
_h = getTerrainHeightASL _pos;
if ({abs ((getTerrainHeightASL [(_pos select 0)+(sin _x)*_rad,(_pos select 1)+(cos _x)*_rad,0]) - _h) > 1.5} count [0,45,90,135,180,225,270,315] == 0) then {_bol = true};
_rad = _rad - 15;
while {!_bol && {_rad > 20}} do {
if ({abs ((getTerrainHeightASL [(_pos select 0)+(sin _x)*_rad,(_pos select 1)+(cos _x)*_rad,0]) - _h) > 1.5} count [0,45,90,135,180,225,270,315] == 0) then {_bol = true};
_rad = _rad - 15;
};
_bol
};

SAOKREINFCUT = {
private ["_bol"];
_bol = false;
if (!isnil{SaOkmissionnamespace getvariable "CSATReInfCut"} && {SaOkmissionnamespace getvariable "CSATReInfCut" > time}) then {_bol = true;};
_bol
};

SAOKREINFCUTADD = {
private ["_tim"];
_tim = _this;
if (!isnil{SaOkmissionnamespace getvariable "CSATReInfCut"} && {SaOkmissionnamespace getvariable "CSATReInfCut" > (time + _tim)}) exitWith {};
SaOkmissionnamespace setvariable ["CSATReInfCut",(time+_tim)];
_tim = floor (_tim / 60);
("CSAT reinforcements calls and their other communication have been cut for "+format ["%1 minutes",_tim]) SPAWN HINTSAOK;
};

//TO CUT CSAT REINF FOR 10MINS //pos,type, color, opt dir, opt text, opt time, opt size
SAOKMILANTENNA = {
private ["_posT","_pos","_unAcPos","_obj","_tim","_nul","_range","_mar1","_mar2","_rclas","_start"];
waitUntil {sleep 10; count ([] CALL AllPf) > 0};
_start = [(vehicle (([] CALL AllPf) call RETURNRANDOM)),1500,700,"(1 - houses) * (1 - sea)"] CALL SAOKSEEKPOS;
_pos = + _start;
_posT = + _start;
while {surfaceiswater _start || {(getmarkercolor ([] CALL NEARESTCAMP)) == "ColorBlue"} || {!([_start,15] call SAOKISFLAT)}} do {
sleep 10;
_start = [(vehicle (([] CALL AllPf) call RETURNRANDOM)),1500,700,"(1 - houses) * (1 - sea)"] CALL SAOKSEEKPOS;
_pos = + _start;
_posT = + _start;
};
_range = 400 * DIFLEVEL;
_unAcPos = [(_pos select 0)+_range-(random _range*2),(_pos select 1)+_range-(random _range*2),0];
if (surfaceiswater _unAcPos) exitWith {(getposATL vehicle (vehicle (([] CALL AllPf) call RETURNRANDOM))) SPAWN SAOKMILANTENNA;};
_mar1 = [[_unAcPos],"Cross","ColorRed",(_range*2),600,0.27,""] CALL SAOKCREATEMARKERA;
_mar2 = [[_unAcPos],"loc_Transmitter","ColorRed",0,"",600,1.0,""] CALL SAOKCREATEMARKER;
_rclas = ["Land_Communication_F","Land_TTowerSmall_2_F","Land_TTowerSmall_1_F","Land_TTowerBig_1_F","Land_TTowerBig_2_F"]call RETURNRANDOM;
_obj = createVehicle [_rclas ,_posT, [], 0, "NONE"]; 
_obj setvectorup [0,0,1];
waitUntil {sleep 5; !alive _obj || {{_x distance _obj < 40} count ([] CALL AllPf) > 0} || {{_x distance _obj < 2000} count ([] CALL AllPf) == 0}};
if ({_x distance _obj < 40} count ([] CALL AllPf) > 0) then {"Destroying antenna may require 2-4 explosives" SPAWN HINTSAOK;};
waitUntil {sleep 5; !alive _obj || {{_x distance _obj < 2000} count ([] CALL AllPf) == 0}};
if !(alive _obj) then {
_n = [WEST,200] SPAWN PrestigeUpdate;
[[200, "Destroyed Antenna"],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
_tim = (500 + (random 100)) / DIFLEVEL;
_tim SPAWN SAOKREINFCUTADD;
};
{if (_x != "") then {deletemarker _x;};} foreach [_mar1,_mar2];
waitUntil {sleep 5; {_x distance _obj < 2000} count ([] CALL AllPf) == 0};
deletevehicle _obj;
sleep (random 600);
waitUntil {sleep 10; {(getmarkerpos (["ColorRed",getposATL _x] CALL NEARESTCAMP)) distance vehicle _x < 6000} count ([] CALL AllPf) > 0};
(getposATL vehicle (([] CALL AllPf) call RETURNRANDOM)) SPAWN SAOKMILANTENNA;
};

SAOKBSIZEAR = [];
SAOKBSIZE = {
private ["_size","_obj","_bBox","_p1","_p2","_maxWidth","_maxLength"];
_size = 0;
{if (_this == _x select 0) exitWith {if (_x select 1 < _x select 2) then {_size = _x select 2;} else {_size = _x select 1;};};} foreach SAOKBSIZEAR;
if (_size == 0) then {
_obj = createVehicle [_this, [100,100,1000], [], 0, "NONE"];
_bBox = boundingBoxReal _obj;
_p1 = _bBox select 0;
_p2 = _bBox select 1;
_maxWidth = abs ((_p2 select 0) - (_p1 select 0));
_maxLength = abs ((_p2 select 1) - (_p1 select 1));
SAOKBSIZEAR pushBack [_this,_maxWidth,_maxLength];
deletevehicle _obj;
if (_maxWidth < _maxLength) then {_size = _maxLength;} else {_size = _maxWidth;};
};
_size
};

DESFUNC1 = {if(_this == 1) then {AutoReplac=nil;} else {AutoReplac=true;};};
DESFUNC2 = {if(_this != 1) then {TeamStay=nil;} else {TeamStay=true;};};
HINTSAOK = {
private ["_disp"];
73 cutRsc ["MyRscTitle9","PLAIN"];
disableSerialization;
_disp = uiNamespace getVariable "d9_MyRscTitle";
//6666FF
if (typename _this == "STRING") then {
(_disp displayCtrl 309) ctrlSetStructuredText parseText ("<t color='#FF6600'>"+_this+"</t>");
} else {
if (side player == (_this select 1)) then {
(_disp displayCtrl 309) ctrlSetStructuredText parseText ("<t color='#FF6600'>"+(_this select 0)+"</t>");
};
};
};
HINTWEPSAOK = {
private ["_disp","_n","_text"];
73 cutRsc ["MyRscTitle9","PLAIN"];
disableSerialization;
_disp = uiNamespace getVariable "d9_MyRscTitle";
//6666FF
_text = "<t color='#FF6600'>"+(_this select 0)+"</t>" +"<br/>";
_n = 0;
{
_n = _n + 1;_text = _text + format ["<img size='2.5' image='%1'/>",(getText(configfile >> "CfgWeapons" >> _x >> "picture"))];
 if (_n > 5) then {_n = 0;_text = _text +"<br/>";};
} foreach (_this select 1);
{
_n = _n + 1;_text = _text + format ["<img size='2.5' image='%1'/>",(getText(configfile >> "CfgVehicles" >> _x >> "picture"))];
 if (_n > 5) then {_n = 0;_text = _text +"<br/>";};
} foreach (_this select 3);
{
_n = _n + 1;_text = _text + format ["<img size='2.5' image='%1'/>",(getText(configfile >> "CfgWeapons" >> _x >> "picture"))];
 if (_n > 5) then {_n = 0;_text = _text +"<br/>";};
} foreach (_this select 4);
{
_n = _n + 1;_text = _text + format ["<img size='1.5' image='%1'/>",(getText(configfile >> "CfgMagazines" >> _x >> "picture"))];
 if (_n > 15) then {_n = 0;_text = _text +"<br/>";};
} foreach (_this select 2);
{
_n = _n + 1;_text = _text + format ["<img size='1.5' image='%1'/>",(getText(configfile >> "CfgWeapons" >> _x >> "picture"))];
 if (_n > 15) then {_n = 0;_text = _text +"<br/>";};
} foreach (_this select 5);

 _text = _text + "<br/><t size='0.8'>COLLECTED GEAR CAN BE EQUIPED THROUGH SHIFT+1 -> CUSTOMIZE GEAR</t>";
(_disp displayCtrl 309) ctrlSetStructuredText parseText _text;
};

SAOKSAY3D = {
if (isClass(configFile >> "cfgSounds" >> (_this select 1))) then {(_this select 0) say3d (_this select 1);};
};
SAOKPLAYSOUND = {
if (typename _this == "ARRAY") then {if (isClass(configFile >> "cfgSounds" >> (_this select 0))) then {playsound (_this select 0);};} else {
if (isClass(configFile >> "cfgSounds" >> _this)) then {playsound _this;} else {
//if (_this == "Cash") then {"Purchase Made" SPAWN HINTSAOK;};
};
};
};
SAOKKBTOPIC = {if (isClass(configFile >> "cfgSounds" >> "Civ1")) then {(_this select 0) kbAddTopic [(_this select 1), (_this select 2), ""];};};
SAOKKBTELL = {if (isClass(configFile >> "cfgSounds" >> "Civ1")) then {(_this select 0) kbTell [(_this select 1), (_this select 2), (_this select 3)];};};


SAOKTANKBOMB = {
sleep 5;
if (isNull _this) exitWith {};
_this addEventHandler ["Hit",{
private ["_r"];
if (random 1 < 0.2) then {
_r = ["R_230mm_HE",25];
_BOM = createVehicle [_r select 0,getposATL (_this select 0), [], 0, "NONE"];
_BOM setdamage 1;
(_this select 0) setVelocity [20- (random 40), 20- (random 40), 5+(random 5)];
{if (!isPlayer _x) then {_x SPAWN SAOKFLYDIE;};sleep 0.01;} foreach ((getposATL (_this select 0)) nearEntities [["Man"],_r select 1]);
};
}
]; 
};
SAOKBARRELBOMBS = {
sleep 5;
if (isNull _this) exitWith {};
_this addEventHandler ["Hit",{
private ["_r","_n","_BOM"];
_n = if (!isNil{(_this select 0) getvariable "BarrelHits"}) then {(((_this select 0) getvariable "BarrelHits") + 1)} else {1};
(_this select 0) setvariable ["BarrelHits",_n];
if (_n > 2 && {random 1 < 0.4}) then {
_r = [["R_60mm_HE",10],["R_80mm_HE",15]] call RETURNRANDOM;
_BOM = createVehicle [_r select 0,getposATL (_this select 0), [], 0, "NONE"];
(_this select 0) setVelocity [20- (random 40), 20- (random 40), 5+(random 5)];
{if (!isPlayer _x) then {_x SPAWN SAOKFLYDIE;};} foreach ((getposATL (_this select 0)) nearEntities [["Man"],_r select 1]);
{_x setvariable ["Barreled",(time + 10)];} foreach ((getposATL (_this select 0)) nearEntities [["Man"],(_r select 1)+15]);
};
}
]; 
};
SAOKFLYDIE = {_this setdamage 1;_this setVelocity [20- (random 40), 20- (random 40), 20+(random 20)];};

SAOKRELTOCOLOR = {

private ["_return"];
_return = "ColorCiv";
switch (_this) do {
case "Hostile": {_return = "ColorRed";};
case "Angry": {_return = "ColorOrange";};
case "Neutral": {_return = "ColorYellow";};
case "Friendly": {_return = "ColorGreen";};
};
_return
};

//[_start, getposATL _obj] call BIS_fnc_dirTo
//pos,type, color, opt dir, opt text, opt time, opt size, opt called [getposATL _uhri,"hd_warning","ColorPurple"] SPAWN SAOKCREATEMARKER;
SAOKCREATEMARKER = {
private ["_pos","_si","_d","_t","_AAdistance","_mar","_mar2"];
_AAdistance = DIFLEVEL * 4000;
if (count (_this select 0) == 1 && {{getmarkercolor _x == "ColorRed" && {getmarkerpos _x distance ((_this select 0) select 0) < _AAdistance}} count AAsM > 0} && {!("RadarS" in ([] CALL SAOKRETURNPROG))} && {!("Radar" in ([] CALL SAOKRETURNPROG))}) exitWith {if (count _this > 7) then {""};};
NUMM=NUMM+1;
_pos = _this select 0;
if (count (_this select 0) == 1) then {_pos = ((_this select 0) select 0);};
_mar = format ["Marker%1",NUMM];
_mar2 = createMarker [_mar,_pos];
_mar2 setMarkerShape "ICON";
_mar2 setMarkerType (_this select 1);
_mar2 setMarkerAlpha 0.45;
_si = 0.6;
if (count _this > 6) then {_si = (_this select 6);};
_mar2 setMarkerSize [_si,_si];
if ((_this select 2) == "STRING") then {_mar2 setMarkerColor (_this select 2);} else {_mar2 setMarkerColor "ColorPink";};
_d = 0;
if (count _this > 3 && {typename (_this select 3) == "SCALAR"}) then {_d = (_this select 3);};
_mar2 setMarkerDir _d;
_t = "";
if (count _this > 4) then {_t = (_this select 4);};
_mar2 setMarkerText _t;
_t = 180;
if (count _this > 5) then {_t = (_this select 5);};
if !(count _this > 7) then {
[_t,_mar2] SPAWN {sleep (_this select 0);deletemarker (_this select 1);};
} else {_mar2};
};

SAOKSTADDMAR = {
private ["_mar","_mar2","_ran"];
NUMM=NUMM+1;
_mar = format ["CityM%1",NUMM];
_mar2 = createMarker [_mar,_this];
_mar2 setMarkerShape "ELLIPSE";
//_mar2 setMarkerType "Empty";
_mar2 setMarkerAlpha 0.35;
_mar2 setMarkerBrush "BDiagonal";
_mar2 setMarkerSize [100,100];
_mar2 setMarkerText "";
_ran = ["None","Medical","AntiAir","AntiTank","MachineGunners"]call RETURNRANDOM;
[(_mar+"B"),_ran] SPAWN SAOKVILSET;
[(_mar+"A"),"Friendly"] SPAWN SAOKVILSET;
_mar2 setMarkerColor ("Friendly" CALL SAOKRELTOCOLOR);
waitUntil {sleep 0.1; !isnil"AmbientCiv" && {!isnil"AmbientCivN"}};
AmbientCiv pushBack _mar;
AmbientCivN pushBack _mar;
};

SAOKCREATESTPOINT = {
private ["_c","_mar","_mar2","_pos","_type","_p","_vil"];
_pos = _this select 0;
_type = _this select 1;
switch _type do {
case "Fac": {
_c = count FacMarkers;
_mar = format ["Fac%1",(_c+1)];
_mar2 = createMarker [_mar,_pos];
_mar2 setMarkerShape "ICON";
_mar2 setMarkerType "u_installation";
//_mar2 setMarkerAlpha 0.45;
_mar2 setMarkerSize [0.7,0.7];
_mar2 setMarkerColor "ColorYellow";
if (count _this < 3) then {FacOwnP pushBack _pos;};
FacMarkers pushBack _mar2;
_p = getmarkerpos _mar2;
_vil = createLocation ["NameLocal", [(_p select 0), (_p select 1)-3, 0], 100, 100];
_vil setText "factory";
if (count _this < 3) then {FACTORYLOCATIONS pushBack _vil;};
_p SPAWN SAOKSTADDMAR;
};
case "Sto": {
_c = count StoMarkers;
_mar = format ["Storage%1",(_c+1)];
_mar2 = createMarker [_mar,_pos];
_mar2 setMarkerShape "ICON";
_mar2 setMarkerType "n_service";
//_mar2 setMarkerAlpha 0.45;
_mar2 setMarkerSize [0.7,0.7];
_mar2 setMarkerColor "ColorYellow";
if (count _this < 3) then {StoOwnP pushBack _pos;};
StoMarkers pushBack _mar2;
_p = getmarkerpos _mar2;
_vil = createLocation ["NameLocal", [(_p select 0), (_p select 1)-3, 0], 100, 100];
_vil setText "storage";
_p SPAWN SAOKSTADDMAR;
};
};
};

SAOKRETURNPROG = {
private ["_Ar"];
_Ar = [];
if (!isNil{(SaOkmissionnamespace getvariable "Progress")}) then {_Ar = SaOkmissionnamespace getvariable "Progress";};
_Ar
};



//pos, brush, color, size, opt time, opt alpha,opt called
SAOKCREATEMARKERA = {

private ["_pos","_ap","_t","_AAdistance","_mar","_mar2"];
_AAdistance = DIFLEVEL * 4000;
if (count (_this select 0) == 1 && {{getmarkercolor _x == "ColorRed" && {getmarkerpos _x distance ((_this select 0) select 0) < _AAdistance}} count AAsM > 0} && {!("RadarS" in ([] CALL SAOKRETURNPROG))} && {!("Radar" in ([] CALL SAOKRETURNPROG))}) exitWith {if (count _this > 6) then {""};};
_pos = _this select 0;
if (count (_this select 0) == 1) then {_pos = ((_this select 0) select 0);};
NUMM=NUMM+1;
_mar = format ["Markera%1",NUMM];
_mar2 = createMarker [_mar,_pos];
_mar2 setMarkerShape "ELLIPSE";
_mar2 setMarkerBrush (_this select 1);
_ap = 0.37;
if (count _this > 5) then {_ap = (_this select 5);};
_mar2 setMarkerAlpha _ap;
_mar2 setMarkerSize [(_this select 3),(_this select 3)];
_mar2 setMarkerColor (_this select 2);
_mar2 setMarkerDir 0;
_t = 180;
if (count _this > 4) then {_t = (_this select 4);};
if !(count _this > 6) then {
[_t,_mar2] SPAWN {sleep (_this select 0);deletemarker (_this select 1);};
} else {_mar2};
};

//AI GROUP THROW SMOKE WHEN IN DANGER
SAOKAIFIRE = {

private ["_c"];
_c = 10;
for "_i" from 0 to _c do {
_this forceWeaponFire [primaryweapon _this, "FullAuto"];
sleep 0.2;
};
};
SAOKAIGSMOKE = {
private ["_leader"];
_leader = leader _this;
waituntil {sleep 4; isNull _leader || {behaviour _leader == "COMBAT"} || {!(alive _leader)}}; 
if (!isNull _leader && {alive _leader}) then {
_leader addmagazine "SmokeShell";
sleep 2;
_leader forceWeaponFire ["SmokeShellMuzzle","SmokeShellMuzzle"];
};
waituntil {sleep 10; isNull _leader || {behaviour _leader != "COMBAT"} || {!(alive _leader)}}; 
if (!isNull _leader && {alive _leader}) then {(group _leader) SPAWN SAOKAIGSMOKE;};
};

SAOKAISMOKEGREEN = {
private ["_leader"];
_leader = leader _this;
sleep (random 15);
_leader addmagazine "SmokeShellGreen";
sleep 2;
_leader forceWeaponFire ["SmokeShellGreenMuzzle","SmokeShellGreenMuzzle"];
};

SAOKAISMOKEPURPLE = {
private ["_leader"];
_leader = leader _this;
_leader addmagazine "SmokeShellPurple";
sleep 2;
_leader forceWeaponFire ["SmokeShellPurpleMuzzle","SmokeShellPurpleMuzzle"];
};

SAOKAISMOKEBLUE = {
private ["_leader"];
_leader = leader _this;
_leader addmagazine "SmokeShellBlue";
sleep 2;
_leader forceWeaponFire ["SmokeShellBlueMuzzle","SmokeShellBlueMuzzle"];
};

//AICAMPBEHAVIOUR
SAOKAICAMPf1 = {
if (!isNil{_this getvariable "N"}) then {
if (isNil {(_this getvariable "N") getvariable "Busy"} || {isNull (_this getvariable "N")}|| {! alive (_this getvariable "N")}) then {
_this setvariable ["N",nil]; 
};
};
if (!isNil{_this getvariable "E"}) then {
if (isNil {(_this getvariable "E") getvariable "Busy"} || {isNull (_this getvariable "E")}|| {!alive (_this getvariable "E")}) then {
_this setvariable ["E",nil]; 
};
};
if (!isNil{_this getvariable "S"}) then {
if (isNil {(_this getvariable "S") getvariable "Busy"} || {isNull (_this getvariable "S")}|| {!alive (_this getvariable "S")}) then {
_this setvariable ["S",nil]; 
};
};
if (!isNil{_this getvariable "W"}) then {
if (isNil {(_this getvariable "W") getvariable "Busy"} || {isNull (_this getvariable "W")}|| {!alive (_this getvariable "W")}) then {
_this setvariable ["W",nil]; 
};
};
};

SAOKAICAMPf2 = {
private ["_xPos","_fP","_unit","_IlmSuunta"];
_fP = _this select 0;
_unit = _this select 1;
_IlmSuunta = _this select 2;

_fP setvariable [_IlmSuunta,"Taken"]; 
_unit setvariable ["Busy",true];
_xPos = getposATL _fP; 
_unit domove [(_xPos select 0) + 2,(_xPos select 1), 0];
waitUntil {sleep 3; isNull _unit || {unitReady _unit}};
if (!isNull _unit) then {
group _unit setformdir ([_unit, _fP] call BIS_fnc_dirTo);
_unit action ["SitDown",_unit];
sleep (15+(random 60));
if (!isNull _unit && !isNull _fP) then {
_unit setvariable ["Busy",nil];
_fP setvariable [_IlmSuunta,nil]; 
};
};
};

SAOKAICAMPf3 = {
private ["_pos","_building","_sHou","_pO","_houses","_c","_waypoints"];
_c = 0;
_houses = ((_this select 0) getvariable "CBHouses");
if (isNil"_houses") exitWith {};
_pO = _houses select 0;
_sHou = [(_pO select 0)+ (_houses select 1) - (random (_houses select 1))*2, (_pO select 1)+(_houses select 1) - (random (_houses select 1))*2, 0];
_building = nearestBuilding _sHou;
_waypoints = _building call SAOKBUILDINGPOS;
if (count _waypoints > 0 && {getposATL _building distance _pO < (_houses select 1)}) then {
_pos = _building buildingPos (_waypoints call RETURNRANDOM);
if ({!isNull _x && {!isNil {_x getvariable "gPos"}} && {(_x getvariable "gPos") distance _pos < 2}} count (_this select 2) == 0 && {_pos CALL IGPOS}) then {
(_this select 1) setvariable ["gPos",_pos];
(_this select 1) setvariable ["Busy",true];
(_this select 1) domove _pos;
waitUntil {sleep 3; isNull (_this select 1) || {unitReady (_this select 1)}};
sleep (15+(random 60));
if (!isNull (_this select 1)) then {
(_this select 1) setvariable ["Busy",nil];
(_this select 1) setvariable ["gPos",[0,0,0]];
};
};
};
};

SAOKAICAMPf4 = {
private ["_pos","_CBg"];
_CBg = ((_this select 0) getvariable "CBgPoints");
_pos = if (!isNil"_CBg" && {typename _CBg == "ARRAY"} && {count _CBg > 0}) then {_CBg call RETURNRANDOM} else {
[(getposATL (_this select 0) select 0)+ 25 - (random 50),(getposATL (_this select 0) select 1)+25 - (random 50),0]
};
if ({!isNull (_this select 0) && {!isNil {(_this select 0) getvariable "gPos"}} && {((_this select 0) getvariable "gPos") distance _pos < 2}} count (_this select 2) == 0) then {
if (isNil"_pos" || {typename _pos != "ARRAY"} || {surfaceiswater _pos}) exitWith {};
(_this select 1) setvariable ["gPos",_pos];
(_this select 1) setvariable ["Busy",true];
(_this select 1) domove _pos;
waitUntil {sleep 3; isNull (_this select 1) || {unitReady (_this select 1)}};
sleep (15+(random 60));
if (!isNull (_this select 1)) then {
(_this select 1) setvariable ["Busy",nil];
(_this select 1) setvariable ["gPos",[0,0,0]];
};
};
};
///////////////
/*
SAOKSLINGVEH = {
private ["_mass","_pPos","_start","_sP","_r","_r2","_r3","_r4","_rops","_type","_v","_d","_h","_di","_class","_tg1","_posPl","_tg1wp1","_bbr","_p2","_nul","_pos","_veh","_aika","_rrr","_pPP","_a"];
_type = _this select 0;
_pPP = getposATL vehicle (([] CALL AllPf) call RETURNRANDOM);
_pPos = if (count _this > 1) then {_this select 1} else {_pPP};
_v = createVehicle [_type, [_pPP select 0,_pPP select 1,100], [], 0, "FLY"];
_v allowdamage false;
_mass = 0;
if (getmass _v > 2000) then {_mass = getmass _v;_v setMass [2000,1];};
_d = (["A"] CALL DIS)*2;
_h = 150;
_start = [(_pPos select 0) + _d - (random _d)*2,(_pPos select 1) + _d - (random _d)*2,_h];
while {{_start distance vehicle _x < 1500} count ([] CALL AllPf) > 0} do {
sleep 0.1;
_pPos = getposATL (vehicle (([] CALL AllPf) call RETURNRANDOM)); 
_start = [(_pPos select 0) + _d - (random _d)*2,(_pPos select 1) + _d - (random _d)*2,_h];
};
sleep 1;
_di= [_start, _pPos] call BIS_fnc_dirTo;
_class = ["B_Heli_Transport_03_F","B_Heli_Transport_03_unarmed_F"] call RETURNRANDOM;
_tg1 = [_start, _di, _class, WEST,""] call SPAWNVEHICLE;
(_tg1 select 2) allowfleeing 0;
CantCommand set [count CantCommand,_tg1 select 2];
(_tg1 select 0) allowdamage false;
_v setpos [_start select 0,_start select 1,(_start select 2) - 35];
_bbr = boundingBoxReal _v;
_p2 = _bbr select 1;
_p2 set [0, ((_p2 select 0) * 0.2)];
_p2 set [1, ((_p2 select 1) * 0.2)];
_p2 set [2, -((_p2 select 2) * 0.2)];
_sP = [0,0,0];
_rops = [];
if ((getText (configfile >> "CfgVehicles" >> _class >> "slingLoadMemoryPoint")) != "") then {_sP = (getText (configfile >> "CfgVehicles" >> _class >> "slingLoadMemoryPoint"));};
if (count (getArray (configfile >> "CfgVehicles" >> (typeof _v) >> "slingLoadCargoMemoryPoints")) == 0) then {
_r = ropeCreate [(_tg1 select 0),_sP,_v,[_p2 select 0,_p2 select 1,_p2 select 2],7];
_r2 = ropeCreate [(_tg1 select 0),_sP,_v,[_p2 select 0,-(_p2 select 1),_p2 select 2],7];
_r3 = ropeCreate [(_tg1 select 0),_sP,_v,[-(_p2 select 0),-(_p2 select 1),_p2 select 2],7];
_r4 = ropeCreate [(_tg1 select 0),_sP,_v,[-(_p2 select 0),_p2 select 1,_p2 select 2],7];
_rops = [_r,_r2,_r3,_r4];
} else {
{
_r = ropeCreate [(_tg1 select 0),_sP,_v,_x,7];
_rops pushback _r;
} foreach (getArray (configfile >> "CfgVehicles" >> (typeof _v) >> "slingLoadCargoMemoryPoints"));
};
_posPl = [(_pPos select 0) + 50 -(random 100), (_pPos select 1)+ 50 -(random 100), _h];
_tg1wp1= (_tg1 select 2) addWaypoint [_posPl, 0]; 
[(_tg1 select 2), 1] setWaypointBehaviour "CARELESS";
{_x setcaptive true;_x allowfleeing 0;} foreach units (_tg1 select 2);
(_tg1 select 0) flyinheight _h;
sleep 15;
waitUntil {sleep 2; !alive (_tg1 select 0) || {(_tg1 select 0) distance _posPl < 30} || {speed (_tg1 select 0) < 4} || {getposATL (_tg1 select 0) select 2 < 4}};
_nul = [(_tg1 select 2), (getmarkerpos "WestChopStart"),1] SPAWN FUNKTIO_MAD;
{ropeDestroy _x;} foreach _rops;
if (_mass > 0) then {
_v setMass [_mass,3];
};
_a = time + 10;
waitUntil {sleep 0.1; _a < time || {_v distance (_tg1 select 0) > 30}};
_pos = getposATL _v;
(_tg1 select 0) allowdamage true;
_v allowdamage true;
if (_pos select 2 < 2) exitWith {};
_veh = createVehicle ["B_Parachute_02_F", [_pos select 0,_pos select 1,((_pos select 2) + 10)], [], 0, "NONE"];
_veh setvelocity (velocity _v);
_rrr = [0,0,0];
if (_type iskindof "ReammoBox_F") then {_rrr = [0,0,-1];};
_v attachTo [_veh,_rrr];
_v setvariable ["AmCrate",1,true];
if (_class iskindof "LandVehicle") then {AddIdVeh pushBack _v;};
[_v] SPAWN {
private ["_maxTime","_smoke","_v"];
_v = _this select 0;
sleep 5;
_maxTime = 14;
while {!isNil"_v" && {!isNull _v} && {{vehicle _x distance _v < 15} count ([] CALL AllPf) == 0} && {_maxTime > 0}} do {
_smoke = createVehicle ["SmokeShellOrange", (getposATL _v), [], 0, "NONE"];
_smoke attachTo [_v, [0,0,0.2]];
sleep 19;
_maxTime = _maxTime - 1;
if (!isNull _smoke) then {deletevehicle _smoke;};
};
};

if (daytime < 5 || {daytime > 21}) then {
[_v] SPAWN {
private ["_exp","_v"];
_v = _this select 0;
sleep 5;
waitUntil {sleep 5;isNil"_v" || {isNull _v} || {(getposATL _v) select 2 < 1.5}};
if (!isNil"_v" && {!isNull _v}) then {
_exp = createVehicle ["Chemlight_blue", (getposATL _v), [], 0, "NONE"];
sleep 600;
if (!isNil"_exp") then {deletevehicle _exp;};
};
};
};
sleep 5;
_aika = time + 90;
waitUntil {sleep 0.2;([_v,_veh] call SAOKCOLLISION) || {(getposATL _v select 2) < 2} || {(getposASL _v select 2) < 2} || {_aika < time}};
detach _v;
sleep 1;
deletevehicle _veh;
if (_class isKindOf "Car") then {
sleep 1200;
if (!isNull _v) then  {
waitUntil {sleep 30; {vehicle _x distance _v < 700} count ([] CALL AllPf) == 0};
};
if (!isNull _v) then {
_v setvariable ["AmCrate",nil,true];
};
};
};
*/