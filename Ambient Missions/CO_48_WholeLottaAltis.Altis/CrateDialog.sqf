TruckCode = {
private ["_now2","_now","_ran","_nums","_truck","_crate","_t","_td","_pos"];
_crate = _this select 0;
_truck = _this select 1;
_td = (typeof _truck) call SAOKTRUCKD;
_nums = [];
_t = 1;
while {count _td >= _t} do {_nums set [count _nums, _t]; _t = _t + 1;};
if (!isNil{_truck getvariable "Crates"}) then {{_nums = _nums - [_x];} foreach (_truck getvariable "Crates");} else {_truck setvariable ["Crates",[],true];};
_ran = _nums call RETURNRANDOM;
_now = _truck getvariable "Crates";
_pos = _td select (_ran - 1);
_truck setvariable ["Crates",_now+[_ran],true];
_crate setvariable ["AUTOSSA",_ran,true];
_now2 = _truck getvariable "Crates";
if (count _now2 > (count _td - 1)) then {_truck setvariable ["CrateFull",1,true];(format ["%1 is full now",getText (configfile >> "CfgVehicles" >> (typeof _truck) >> "displayName")]) SPAWN HINTSAOK;};
if (isNil{_truck getvariable "CrateOBJs"}) then {_truck setvariable ["CrateOBJs",[_crate],true];} else {_truck setvariable ["CrateOBJs",((_truck getvariable "CrateOBJs")+[_crate]),true];};
_crate attachTo [_truck,_pos];
if (isNil{_truck getvariable "Trasher"}) then {
_truck setvariable ["Trasher",1,true];
_truck addEventHandler ["hit",{(_this select 0) SPAWN FTrashCan2;}];
};
};
TruckCode2 = {
private ["_pos","_truck","_crate","_pP"];
_crate = _this select 0;
_truck = _this select 1;
_crate allowdamage false;
detach _crate; 
_pP = getposATL player;
_pos = [(_pP select 0)+7-(random 14),(_pP select 1)+7-(random 14),0];
while {_pos distance _truck < 6} do {_pos = [(_pP select 0)+7-(random 14),(_pP select 1)+7-(random 14),0];};
_crate setpos _pos;
_truck setvariable ["CrateOBJs",(_truck getvariable "CrateOBJs")-[_crate],true];
_truck setvariable ["Crates",(_truck getvariable "Crates")-[_crate getvariable "AUTOSSA"],true];
_truck setvariable ["CrateFull",nil,true];
_crate setvariable ["AUTOSSA",nil,true];
_crate setvariable ["Truck", nil,true];
sleep 4;
_crate allowdamage true;
};

//"ReammoBox_F"
FCrateDialog = {
private ["_truck","_num","_text","_ok","_myDisplay","_crates"];
sleep (random 0.05);
_crates = ((getposATL player) nearEntities [["ReammoBox_F","Land_BarrelWater_F"], 20]);
_truck = ((getposATL player) nearEntities [SAOKCRTRUCKS, 22]);
if (!dialog && {count _crates > 0} && {{alive _x} count _truck > 0}) then {
SaOkmissionnamespace setvariable ["TruckCrates",_crates,true];
disableserialization;
_ok = createDialog "CrateDialog"; 
_myDisplay = findDisplay 1433;
"ITEM DRAGING OR DOUBLECLICKING CAN BE USED" SPAWN SAOKBOXHINT;
{if !(alive _x) then {_truck = _truck - [_x];};} foreach _truck;
_truck = [_truck,[],{player distance _x},"ASCEND"] call BIS_fnc_sortBy;
_truck = _truck select 0;
SaOkmissionnamespace setvariable ["Truck",_truck,true];
_num = 0;

{
_num = _num + 1;
_text = (format ["%1. ",_num] + (getText (configfile >> "CfgVehicles" >> (typeof _x) >> "displayName")));
_x setvariable ["IDCrate",_text,true];
if (isNil{_x getvariable "AUTOSSA"}) then {
lbAdd [1500, _text];
} else {
lbAdd [1501, _text];
};
} foreach _crates;
waitUntil {sleep 0.1;!dialog};
{
_x setvariable ["IDCrate",nil,true];
} foreach _crates;
SaOkmissionnamespace setvariable ["TruckCrates",nil,true];
SaOkmissionnamespace setvariable ["Truck",nil,true];
};
if (count _crates == 0 || {{alive _x} count ((getposATL player) nearEntities [SAOKCRTRUCKS, 22]) == 0}) then {[] SPAWN SAOKNOCTRUCK;};
};

SAOKTRUCKADD = {
private ["_nul","_truck","_cur"];
_truck = SaOkmissionnamespace getvariable "Truck";
_cur = if (typename _this != "ARRAY") then {if (typename _this != "STRING") then {lbText [1500,_this]} else {_this}} else {(lbText [1500, (lbCurSel 1500)])};
{
if (_cur == (_x getvariable "IDCrate") && {isNil{_truck getvariable "CrateFull"}}) then {
_x setvariable ["Truck", _truck,true];
lbAdd [1501, _cur];
_n = lbSize 1500 - 1;
while {_cur != lbText [1500, _n] && {_n >= 0}} do {_n = _n - 1;};
lbDelete [1500, _n];
_nul = [_x,_truck] SPAWN TruckCode;};
} foreach (SaOkmissionnamespace getvariable "TruckCrates");
};

SAOKTRUCKREM = {
private ["_truck","_nul","_cur"];
//_cur = if (typename _this != "ARRAY") then {lbText [1501,_this]} else {(lbText [1501, (lbCurSel 1501)])};
_cur = if (typename _this != "ARRAY") then {if (typename _this != "STRING") then {lbText [1501,_this]} else {_this}} else {(lbText [1501, (lbCurSel 1501)])};
{
if (_cur == _x getvariable "IDCrate") then {
_truck = _x getvariable "Truck";
lbAdd [1500, _cur];
_n = lbSize 1501 - 1;
while {_cur != lbText [1501, _n] && {_n >= 0}} do {_n = _n - 1;};
lbDelete [1501, _n];
_nul = [_x,_truck] SPAWN TruckCode2;
};
} foreach (SaOkmissionnamespace getvariable "TruckCrates");
};

SAOKCRTRUCKS = ["LIB_opelblitz_tent_y_camo","LIB_opelblitz_open_y_camo","LIB_US_GMC_Open","LIB_US_GMC_Tent","O_Truck_02_transport_F","I_Truck_02_covered_F","O_Truck_02_covered_F","I_Truck_02_transport_F","O_Truck_03_covered_F","O_Truck_03_transport_F","B_G_Offroad_01_F","C_Offroad_01_F","B_Truck_01_covered_F","B_Truck_01_transport_F","B_G_Van_01_transport_F","C_Van_01_transport_F","I_G_Van_01_transport_F"];

SAOKTRUCKD = {
private ["_p"];
_p = [];
switch _this do {
case "LIB_US_GMC_Tent": {_p = [[0,-0.5,-0.4],[0,-1.2,-0.4],[0,-1.9,-0.4],[0,-2.7,-0.4]];};
case "LIB_US_GMC_Open": {_p = [[0,-0.5,-0.4],[0,-1.2,-0.4],[0,-1.9,-0.4],[0,-2.7,-0.4]];};
case "LIB_opelblitz_open_y_camo": {_p = [[0,-0.5,-0.4],[0,-1.2,-0.4],[0,-1.9,-0.4],[0,-2.7,-0.4]];};
case "LIB_opelblitz_tent_y_camo": {_p = [[0,-0.5,-0.4],[0,-1.2,-0.4],[0,-1.9,-0.4],[0,-2.7,-0.4]];};
case "I_Truck_02_transport_F": {_p = [[0,-0.5,-0.4],[0,-1.2,-0.4],[0,-1.9,-0.4],[0,-2.7,-0.4]];};
case "I_Truck_02_covered_F": {_p = [[0,-0.5,-0.4],[0,-1.2,-0.4],[0,-1.9,-0.4],[0,-2.7,-0.4]];};
case "O_Truck_02_transport_F": {_p = [[0,-0.5,-0.4],[0,-1.2,-0.4],[0,-1.9,-0.4],[0,-2.7,-0.4]];};
case "O_Truck_02_covered_F": {_p = [[0,-0.5,-0.4],[0,-1.2,-0.4],[0,-1.9,-0.4],[0,-2.7,-0.4]];};
case "C_Offroad_01_F": {_p = [[0,-1.2,-0.6],[0,-1.9,-0.6]];};
case "B_G_Offroad_01_F": {_p = [[0,-1.2,-0.6],[0,-1.9,-0.6]];};
case "O_Truck_03_covered_F": {_p = [[0,-1.2,-0.4],[0,-1.9,-0.4],[0,-2.7,-0.4],[0,-3.3,-0.4],[0,-4.0,-0.4]];};
case "O_Truck_03_transport_F": {_p = [[0,-1.2,-0.4],[0,-1.9,-0.4],[0,-2.7,-0.4],[0,-3.3,-0.4],[0,-4.0,-0.4]];};
case "B_Truck_01_covered_F": {_p = [[0,-1.2,-0.4],[0,-1.9,-0.4],[0,-2.7,-0.4],[0,-3.3,-0.4],[0,-4.0,-0.4]];};
case "B_Truck_01_transport_F": {_p = [[0,-1.2,-0.4],[0,-1.9,-0.4],[0,-2.7,-0.4],[0,-3.3,-0.4],[0,-4.0,-0.4]];};
case "B_G_Van_01_transport_F": {_p = [[0,-1.2,-0.4],[0,-1.9,-0.4],[0,-2.7,-0.4]];};
case "C_Van_01_transport_F": {_p = [[0,-1.2,-0.4],[0,-1.9,-0.4],[0,-2.7,-0.4]];};
case "I_G_Van_01_transport_F": {_p = [[0,-1.2,-0.4],[0,-1.9,-0.4],[0,-2.7,-0.4]];};
};
_p
};

SAOKNOCTRUCK = {
"There is no crate or truck nearby inside 20m radius" SPAWN HINTSAOK;
_t = "VEHICLES WITH CRATE CARRYING ABILITY / MAX CRATES:"+ "<br/>";
{
if (isclass(configfile >> "CfgVehicles" >> _x)) then {
_t = _t + (getText (configfile >> "CfgVehicles" >> _x >> "displayName"))+ " |"+format ["%1",(count (_x CALL SAOKTRUCKD))]+"<br/>";
};
} foreach SAOKCRTRUCKS;
[_t] SPAWN SAOKBOXHINT;
};
