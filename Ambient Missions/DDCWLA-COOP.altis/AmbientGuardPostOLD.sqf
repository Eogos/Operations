private ["_c","_ffdd"];
//POW FUNCTIONS
SAOKHAVECELL = {
private ["_bol","_post"];
_bol = false;
_post = if (count _this == 0) then {[getposATL player,"ColorGreen"] CALL NEARESTGUARDPOST} else {_this select 0};
if (!isNil{_post getvariable "PowCells"} && {{(_x select 1) == ""} count (_post getvariable "PowCells") > 0}) then {_bol = true;};
_bol
};
SAOKNEARESTGPWITHPOWROOM = {
private ["_return","_okPosts"];
_okPosts = [];
{if (getmarkercolor (_x getvariable "Gmark") == "ColorGreen" && {[_x] CALL SAOKHAVECELL}) then {_okPosts set [count _okPosts, _x];};} foreach GuardPosts;
_okPosts = [_okPosts,[],{player distance _x},"ASCEND"] call BIS_fnc_sortBy;
_return = "";
if (count _okPosts > 0) then {_return = _okPosts select 0;};
_return
};

// ([getposATL player,"ColorGreen"] CALL NEARESTGUARDPOST) SPAWN SAOKFREEPOWS;
SAOKFREEPOWS = {
_post = _this;
if (!isNil{_post getvariable "PowCells"}) then {
if (_post in activatedPost) then {

_ar = (_post getvariable "PowCells");
{if (count _x > 3) then {(_x select 3) SPAWN {_p = getposATL _this; _this setpos [(_p select 0) + 10, _p select 1, 0];_this enableAI "MOVE"; _this setcaptive false;_nul = [_this,""] SPAWN FHideAndDelete;};};} foreach _ar;
_Nar = [];
{_Nar set [count _Nar, [_x select 0, ""]];} foreach _ar;
_post setvariable ["PowCells",_Nar,true];
} else {
_ar = (_post getvariable "PowCells");
_Nar = [];
{_Nar set [count _Nar, [_x select 0, ""]];} foreach _ar;
_post setvariable ["PowCells",_Nar,true];
};
};
};
//POW FUNCTIONS END

SAOKCONSSPAWNWEP = {
private ["_bthi","_v","_sidee","_classes","_obj","_crew","_typ","_group","_marker","_post","_oldD"];
_v = [];
_sidee = WEST;
_bthi = (_this select 0);
_typ = (_bthi select 0);
_post = (_this select 2);
_marker  = (_this select 1);
_classes = FRIENDC4 call RETURNRANDOM;
_v = [];
if (!isNil"IFENABLED") then {
if (_typ in ["B_HMG_01_A_F","I_HMG_01_A_F"]) then {_typ = "O_HMG_01_A_F";};
if (_typ in ["B_GMG_01_A_F","I_GMG_01_A_F"]) then {_typ = "O_GMG_01_A_F";};
if (_typ in ["I_HMG_01_high_F","I_GMG_01_high_F","I_static_AT_F","I_static_AA_F"]) then {_typ = "O_GMG_01_A_F";};
};
if (getmarkercolor _marker == "ColorRed") then {
_sidee = EAST;
_classes = ENEMYC1 call RETURNRANDOM;
if (_typ in ["LIB_Pak40"]) then {_typ = "LIB_Zis3";};
if (_typ in ["LIB_FlaK_38"]) then {_typ = "LIB_61k";};
if (_typ in ["B_HMG_01_A_F","I_HMG_01_A_F"]) then {_typ = "O_HMG_01_A_F";};
if (_typ in ["B_GMG_01_A_F","I_GMG_01_A_F"]) then {_typ = "O_GMG_01_A_F";};
if (_typ in ["B_APC_Tracked_01_AA_F"]) then {_typ = "O_APC_Tracked_02_AA_F";};
if (_typ in ["I_MBT_03_cannon_F"]) then {_typ = "O_MBT_02_cannon_F";};
if (_typ in ["I_MRAP_03_hmg_F"]) then {_typ = "O_MRAP_02_hmg_F";};
if (_typ in ["I_MRAP_03_gmg_F"]) then {_typ = "O_MRAP_02_gmg_F";};
if (_typ in ["I_APC_tracked_03_cannon_F"]) then {_typ = "O_APC_Wheeled_02_rcws_F";};
if (!isNil"RHSENABLED" || {!isNil"IFENABLED"}) then {
if (_typ in ["O_APC_Tracked_02_AA_F"]) then {_typ = (ARMEDAA select 1) call RETURNRANDOM;};
if (_typ in ["O_MBT_02_cannon_F"]) then {_typ = (ARMEDTANKS select 1) call RETURNRANDOM;};
if (_typ in ["O_MRAP_02_hmg_F"]) then {_typ = (ARMEDVEHICLES select 1) call RETURNRANDOM;};
if (_typ in ["O_MRAP_02_gmg_F"]) then {_typ = (ARMEDVEHICLES select 1) call RETURNRANDOM;};
if (_typ in ["O_APC_Wheeled_02_rcws_F"]) then {_typ = (ARMEDVEHICLES select 1) call RETURNRANDOM;};
};
} else {
if (!isNil"RHSENABLED" || {!isNil"IFENABLED"}) then {
if (_typ in ["B_APC_Tracked_01_AA_F"]) then {_typ = (ARMEDAA select 0) call RETURNRANDOM;};
if (_typ in ["I_MBT_03_cannon_F"]) then {_typ = (ARMEDTANKS select 0) call RETURNRANDOM;};
if (!isNil"RHSENABLED") then {
if (_typ in ["I_MRAP_03_hmg_F"]) then {_typ = ["rhsusf_m113_usarmy","rhsusf_m113d_usarmy"] call RETURNRANDOM;};
if (_typ in ["I_MRAP_03_gmg_F"]) then {_typ = ["rhsusf_m113_usarmy","rhsusf_m113d_usarmy"] call RETURNRANDOM;};
if (_typ in ["I_APC_tracked_03_cannon_F"]) then {_typ = ["RHS_M2A3_BUSKIII","RHS_M2A3_BUSKIII_wd","RHS_M2A3_BUSKI","RHS_M2A3_BUSKI_wd","RHS_M2A3","RHS_M2A3_wd","RHS_M2A2_BUSKI","RHS_M2A2_BUSKI_wd","RHS_M2A2","RHS_M2A2_wd"] call RETURNRANDOM;};
} else {
if (_typ in ["I_MRAP_03_hmg_F"]) then {_typ = ["Lib_Willys_MB","LIB_US_Willys_MB"] call RETURNRANDOM;};
if (_typ in ["I_MRAP_03_gmg_F"]) then {_typ = ["LIB_Scout_m3","Lib_SdKfz251_captured","LIB_US_Scout_m3","LIB_US_Scout_m3"] call RETURNRANDOM;};
if (_typ in ["I_APC_tracked_03_cannon_F"]) then {_typ = ((ARMEDTANKS select 2)+(ARMEDTANKS select 0)) call RETURNRANDOM;};

};
};
};
_obj = createVehicle [_typ, (_bthi select 1), [], 0, "NONE"]; 
_obj setvariable ["AmCrate",1];
_obj setpos (_bthi select 1);
_obj setdir (_bthi select 2);
_obj setvectorup (_bthi select 3);
if !((_bthi select 0) in ["O_GMG_01_A_F","O_HMG_01_A_F","B_GMG_01_A_F","B_HMG_01_A_F","I_HMG_01_A_F","I_GMG_01_A_F"]) then {
_group = [(_bthi select 1), _sidee, [_classes],[],[],[0.6,0.9]] call SpawnGroupCustom;
leader _group moveingunner _obj;
_group setbehaviour "COMBAT";
_group setformdir (_bthi select 2);
_v = [[leader _group],_obj];
if (_typ iskindof "LandVehicle") then {_obj lock true;};
} else {
createVehicleCrew _obj;
_crew = (crew _obj);
_v = [_crew,_obj];
};
if (isNil{_post getvariable "WeaponsNow"}) then {_post setvariable ["WeaponsNow",[[_v,(_bthi select 4)]],true];} else {_oldD = _post getvariable "WeaponsNow";_post setvariable ["WeaponsNow",(_oldD+[[_v,(_bthi select 4)]]),true];};
};

SAOKCONSADDO = {
private ["_post","_newdata"];
_post = _this select 0;
_newdata = _this select 1;
if (typeof (_newdata select 0) in ["Box_IND_Wps_F"]) then {
_nul = [(_newdata select 0),_post getvariable "CrateC"] SPAWN FLoadCrate;
(_newdata select 0) setvariable ["AmCrate",1,true];
(_newdata select 0) setvariable ["CCCrate",1,true];
};
if (typeof (_newdata select 0) in ["Land_BarGate_F"]) then {
	(_newdata select 0) allowdamage false;
	//ANIMATED BAR GATE
	_nul = (_newdata select 0) SPAWN {
	if (isNil"_this") exitWith {};
	while {!isNull _this} do {  
	waitUntil {sleep 1; isNull _this || {{{isPlayer _x} count crew _x > 0 || {(count crew _x > 0 && {side (driver _x) == EAST})}} count ((getposATL _this) nearEntities [["Car"],30]) > 0}};  
	_this animate ["Door_1_rot", 1];  
	waitUntil {sleep 1; isNull _this || {{{isPlayer _x} count crew _x > 0  ||{(count crew _x > 0 && {side (driver _x) == EAST})}} count ((getposATL _this) nearEntities [["Car"],30]) == 0}}; 
	_this animate ["Door_1_rot", 0];  
	};    
	};
	///////////////////
};
_vN = "ObjectsNow";
_id = _newdata select 1;
_nameA = toArray _id;
_f = [_nameA select 0, _nameA select 1];
_f = toString _f;
if (_f == "NS") then {_vN = "ObjectsNowS";};
if (isNil{_post getvariable _vN}) then {_post setvariable [_vN,[_newdata],true];} else {_oldD = _post getvariable _vN;_post setvariable [_vN,(_oldD+[_newdata]),true];};
};
SAOKCONSADDU = {
private ["_u","_f3","_post","_newdata","_junk","_marker","_sidee","_d","_postP"];
_f3 = {
private ["_post","_postP","_marker","_veh","_group","_Uc","_nul","_sidee","_rad","_ps"];
_post = _this select 0;
_postP = getposATL _post;
_marker = _this select 1;
_sidee = _this select 5;
_veh = "";
_Uc = (_this select 3);
if (getmarkercolor _marker == "ColorRed") then {_Uc = (_this select 4);};
_ps = [_postP,130,100,"(1 - sea)"] CALL SAOKSEEKPOS;
_rad = 100;
while {surfaceiswater _ps || {{_x distance _ps < 200 && {[(_ps CALL SAOKATLTOASL),_x] CALL FUNKTIO_LOSOBJ}} count ([] CALL AllPf) > 0}} do {_rad = _rad + 50;_ps = [_postP,_rad,100,"(1 - sea)"] CALL SAOKSEEKPOS;};
_group = [_ps, _sidee, [_Uc],[],[],[0.8,0.9]] call SpawnGroupCustom;
leader _group setvariable [(_this select 2),1,true];
if ((!("GreenHelp" in (SaOkmissionnamespace getvariable "Progress")) && {(getmarkercolor _marker == "ColorGreen")}) || {!isNil{_post getvariable "RES"}}) then {{_nul = [_x,[]] SPAWN ConvertToArmedCivilian;} foreach units _group;};
//if ({vehicle _x distance _postP < 450 && {isNil{_x getvariable "JustTeleported"}}} count ([] CALL AllPf) > 0) then {_n = [_group, "WEST", _postP,["B_G_Quadbike_01_F",2],_postP,""] SPAWN VehicleArrival;} else {_nul = [units _group,(nearestObjects [_postP, ["FirePlace_burning_F","Land_FirePlace_F"], 100]), [_postP, 100],[],_postP] SPAWN AICampBehaviour;};
[_veh,(units _group)]
};
_u = [];
_post = _this select 0;
_postP = getposATL _post;
_newdata = _this select 1;
_sidee = WEST;
_marker = _post getvariable "Gmark";
if (getmarkercolor _marker == "ColorRed") then {
_sidee = EAST;
};
_junk = if (isNil{_post getvariable "Junk"}) then {[]} else {_post getvariable "Junk"};
if (_newdata == "MG-Guard") then {
_a = [_post,_marker,"MG-Guard","I_Soldier_AR_F","O_Soldier_AR_F",_sidee];
if (!isNil"RHSENABLED") then {_a = [_post,_marker,"MG-Guard","rhsusf_army_ucp_machinegunner","rhs_msv_machinegunner",_sidee];};
if (!isNil"IFENABLED") then {_a = [_post,_marker,"MG-Guard","LIB_GER_mgunner","LIB_SOV_mgunner",_sidee];};
_d = _a CALL _f3;
if (typename (_d select 0) != "STRING") then {_junk pushBack (_d select 0);};
_junk = _junk + (_d select 1);
_u = _u + (_d select 1);
};
if (_newdata == "AA-Guard") then {
_a = [_post,_marker,"AA-Guard","I_Soldier_AA_F","O_Soldier_AA_F",_sidee];
if (!isNil"RHSENABLED") then {_a = [_post,_marker,"AA-Guard","rhsusf_army_ucp_aa","rhs_msv_aa",_sidee];};
if (!isNil"IFENABLED") then {_a = [_post,_marker,"AA-Guard","LIB_GER_mgunner","LIB_SOV_mgunner",_sidee];};
_d = _a CALL _f3;
if (typename (_d select 0) != "STRING") then {_junk pushBack (_d select 0);};
_junk = _junk + (_d select 1);
_u = _u + (_d select 1);
};
if (_newdata == "AT-Guard") then {
_a = [_post,_marker,"AT-Guard","I_Soldier_AT_F","O_Soldier_AT_F",_sidee];
if (!isNil"RHSENABLED") then {_a = [_post,_marker,"AT-Guard","rhsusf_army_ucp_javelin","rhs_msv_at",_sidee];};
if (!isNil"IFENABLED") then {_a = [_post,_marker,"AT-Guard","LIB_GER_AT_soldier","LIB_SOV_AT_grenadier",_sidee];};
_d = _a CALL _f3;
if (typename (_d select 0) != "STRING") then {_junk pushBack (_d select 0);};
_junk = _junk + (_d select 1);
_u = _u + (_d select 1);
};
if (_newdata == "Sniper-Guard") then {
_a = [_post,_marker,"Sniper-Guard","I_Sniper_F","O_Sniper_F",_sidee];
if (!isNil"RHSENABLED") then {_a = [_post,_marker,"Sniper-Guard","rhsusf_army_ucp_marksman","rhs_msv_marksman",_sidee];};
if (!isNil"IFENABLED") then {_a = [_post,_marker,"Sniper-Guard","LIB_GER_scout_sniper","LIB_SOV_LC_rifleman",_sidee];};
_d = _a CALL _f3;
if (typename (_d select 0) != "STRING") then {_junk pushBack (_d select 0);};
_junk = _junk + (_d select 1);
_u = _u + (_d select 1);
};
if (_newdata == "Medic-Guard") then {
_a = [_post,_marker,"Medic-Guard","I_medic_F","O_medic_F",_sidee];
if (!isNil"RHSENABLED") then {_a = [_post,_marker,"Medic-Guard","rhsusf_army_ucp_medic","rhs_msv_medic",_sidee];};
if (!isNil"IFENABLED") then {_a = [_post,_marker,"Medic-Guard","LIB_GER_medic","LIB_SOV_medic",_sidee];};
_d = _a CALL _f3;
if (typename (_d select 0) != "STRING") then {_junk pushBack (_d select 0);};
_junk = _junk + (_d select 1);
_u = _u + (_d select 1);
};
_post setvariable ["Junk",_junk,true];
_u
};
SAOKCONSADDW = {
private ["_post","_newdata","_obj","_group","_v","_crew"];
_post = _this select 0;
//[_class,getposATL _veh, direction _veh, (surfaceNormal (getposATL _veh)),_id]
_newdata = _this select 1;
_typ = (_newdata select 0);
_marker = _post getvariable "Gmark";
_sidee = WEST;
_classes = FRIENDC4 call RETURNRANDOM;
if (getmarkercolor _marker == "ColorRed") then {
_sidee = EAST;
_classes = ENEMYC1 call RETURNRANDOM;
if (_typ in ["B_HMG_01_A_F","I_HMG_01_A_F"]) then {_typ = "O_HMG_01_A_F";};
if (_typ in ["B_GMG_01_A_F","I_GMG_01_A_F"]) then {_typ = "O_GMG_01_A_F";};
if (_typ in ["B_APC_Tracked_01_AA_F"]) then {_typ = "O_APC_Tracked_02_AA_F";};
if (_typ in ["I_MBT_03_cannon_F"]) then {_typ = "O_MBT_02_cannon_F";};
if (_typ in ["I_MRAP_03_hmg_F"]) then {_typ = "O_MRAP_02_hmg_F";};
if (_typ in ["I_MRAP_03_gmg_F"]) then {_typ = "O_MRAP_02_gmg_F";};
if (_typ in ["I_APC_tracked_03_cannon_F"]) then {_typ = "O_APC_Wheeled_02_rcws_F";};
};
_obj = createVehicle [_typ, (_newdata select 1), [], 0, "NONE"]; 
_obj setvariable ["AmCrate",1,true];
_obj setpos (_newdata select 1);
_obj setdir (_newdata select 2);
_obj setvectorup (_newdata select 3);
_v = [];
if !((_newdata select 0) in ["O_GMG_01_A_F","O_HMG_01_A_F","B_GMG_01_A_F","B_HMG_01_A_F","I_HMG_01_A_F","I_GMG_01_A_F"]) then {
_group = [(_newdata select 1), _sidee, [_classes],[],[],[0.4,0.8]] call SpawnGroupCustom;
leader _group moveingunner _obj;
_group setformdir (_newdata select 2);
_v = [[leader _group],_obj];
if ((_newdata select 0) iskindof "LandVehicle") then {_obj lock true;};
} else {
createVehicleCrew _obj;
_crew = (crew _obj);
_v = [_crew,_obj];
};
if (isNil{_post getvariable "WeaponsNow"}) then {_post setvariable ["WeaponsNow",[[_v,(_newdata select 4)]],true];} else {_oldD = _post getvariable "WeaponsNow";_post setvariable ["WeaponsNow",(_oldD+[[_v,(_newdata select 4)]]),true];};
};

SAOKCONSREMO = {
private ["_post","_oldD","_countD","_newD","_object","_cost"];
_post = _this;
if !(isNil{_post getvariable "ObjectsNow"}) then {
_oldD = _post getvariable "ObjectsNow";
_countD = count _oldD - 1;
_object = ((_oldD select _countD) select 0);
_cost = (typeOf _object) CALL CONSCOST;
_n = [side player,_cost] SPAWN PrestigeUpdate;
[[_cost, "Returns",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
deletevehicle _object;
_newD = [_oldD,_countD] call BIS_fnc_removeIndex;
_post setvariable ["ObjectsNow",_newD,true];
_oldD = _post getvariable "StaticO";
_newD = [_oldD,_countD] call BIS_fnc_removeIndex;
_post setvariable ["StaticO",_newD,true];
};
};
SAOKCONSREMW = {
private ["_vehD","_post","_oldD","_countD","_newD","_object","_cost"];
_post = _this;
if !(isNil{_post getvariable "WeaponsNow"}) then {
_oldD = _post getvariable "WeaponsNow";
_countD = count _oldD - 1;
_vehD = (_oldD select _countD) select 0;
{deletevehicle _x;} foreach (_vehD select 0);
_object = _vehD select 1;
_cost = (typeOf _object) CALL CONSCOST;
_n = [side player,_cost] SPAWN PrestigeUpdate;
[[_cost, "Returns",side player],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
deletevehicle _object; 
_newD = [_oldD,_countD] call BIS_fnc_removeIndex;
_post setvariable ["WeaponsNow",_newD,true];
_oldD = _post getvariable "StaticW";
_newD = [_oldD,_countD] call BIS_fnc_removeIndex;
_post setvariable ["StaticW",_newD,true];
};
};

SAOKCONSONSPAWN = {
private ["_f1","_post","_marker"];
_f1 = {
private ["_obj","_nul","_thism","_pos"];
_thism = _this select 0;
_pos = _thism select 1;
_obj = createVehicle [(_thism select 0), _pos, [], 0, "CAN_COLLIDE"]; 
_wTm = _obj worldToModel _pos;
_obj setpos [(_pos select 0)+(_wTm select 0),(_pos select 1)+(_wTm select 1),0];
_obj setdir (_thism select 2);
if !((_thism select 0) in ["Land_BarGate_F","FirePlace_burning_F"]) then {[_obj,0] SPAWN VehLife;};
_obj setvectorup (_thism select 3);
if ((_thism select 0) in ["Box_IND_Wps_F"]) then {
_nul = [_obj,(_this select 1) getvariable "CrateC"] SPAWN FLoadCrate;
_obj setvariable ["AmCrate",1,true];
_obj setvariable ["CCCrate",1,true];
};
if ((_thism select 0) in ["Land_BarGate_F"]) then {
	_obj allowdamage false;
	//ANIMATED BAR GATE
	_nul = _obj SPAWN {
	if (isNil"_this") exitWith {};
	while {!isNull _this} do {  
	waitUntil {sleep 1; isNull _this || {{{isPlayer _x} count crew _x > 0 || {(count crew _x > 0 && {side (driver _x) == EAST})}} count ((getposATL _this) nearEntities [["Car"],30]) > 0}};  
	_this animate ["Door_1_rot", 1];  
	waitUntil {sleep 1; isNull _this || {{{isPlayer _x} count crew _x > 0   ||{(count crew _x > 0 && {side (driver _x) == EAST})}} count ((getposATL _this) nearEntities [["Car"],30]) == 0}}; 
	_this animate ["Door_1_rot", 0];  
	};  
	};
	///////////////////
};
_vN = "ObjectsNow";
if (count _this > 2) then {_vN = "ObjectsNowS";};
if (isNil{_post getvariable _vN}) then {_post setvariable [_vN,[[_obj,(_thism select 4)]],true];} else {_oldD = _post getvariable _vN;_post setvariable [_vN,(_oldD+[[_obj,(_thism select 4)]]),true];};
};
_post = _this;
_marker = _post getvariable "Gmark";
{
_d = [_x,_marker] CALL SAOKCONSSPAWNWEP;
} foreach (_post getvariable "StaticW");
{
if (!isNil{_post getvariable _x}) then {[_post,_x] CALL SAOKCONSADDU;};
} foreach ["MG-Team","AA-Team","AT-Team","Sniper-Team","Medic-Team"];
{
[_x,_post] CALL _f1;
} foreach (_post getvariable "StaticO");
{
[_x,_post,""] CALL _f1;
} foreach (_post getvariable "StaticOS");
if (!isNil{_post getvariable "PowCells"}) then {
{
_br = _x;
if (_x select 1 != "") then {
_ar = (_post getvariable "PowCells");
_ucc = [ENEMYC1,ENEMYC2] call RETURNRANDOM;
_classes = _ucc call RETURNRANDOM;
_group = [_x select 0, EAST, [_classes],[],[],[0.4,0.8]] call SpawnGroupCustom;
leader _group setpos (_x select 0);
leader _group setface (_x select 2);
_br set [3,leader _group];
_ar set [_foreachindex,_br];
_post setvariable ["PowCells",_ar,true];
leader _group setbehaviour "CARELESS";
leader _group setcaptive true;
leader _group disableAI "MOVE";
removeallweapons (leader _group);
(leader _group) setvariable ["PowMan",1,true];
removeHeadgear (leader _group);
removeVest (leader _group);
removeBackPack (leader _group);
removeUniform (leader _group);
removeAllAssignedItems (leader _group);
if (isNil{(_post getvariable "Junk")}) then {_post setvariable ["Junk",[(leader _group)],true];} else {_post setvariable ["Junk",(_post getvariable "Junk")+[(leader _group)],true];};
};
} foreach (_post getvariable "PowCells");
};
};

SAOKCONSCHANGESIDE = {
private ["_post","_marker","_ar"];
_post = _this;
_marker = _post getvariable "Gmark";
//REM ONLY VEH
if (!isNil{(_post getvariable "WeaponsNow")}) then {
{{if (alive _x && {!isPlayer _x}) then {deletevehicle _x;};} foreach crew ((_x select 0) select 1); deletevehicle ((_x select 0) select 1);} foreach (_post getvariable "WeaponsNow");
_post setvariable ["WeaponsNow",nil,true];
};
{
_d = [_x,_marker] CALL SAOKCONSSPAWNWEP;
} foreach (_post getvariable "StaticW");
if (!isNil{_post getvariable "Junk"}) then {{if (!((typeOf _x) iskindOf "Man")) then {deletevehicle _x;};} foreach (_post getvariable "Junk");};
_post setvariable ["Junk",[],true];
{
if (!isNil{_post getvariable _x}) then {[_post,_x] CALL SAOKCONSADDU;};
} foreach ["MG-Team","AA-Team","AT-Team","Sniper-Team","Medic-Team"];
if (getmarkercolor _marker == "ColorRed" && {!isNil{_post getvariable "PowCells"}}) then {
/*
_ar = (_post getvariable "PowCells");
{_ar set [_foreachIndex,[_x select 0,""]];} foreach _ar;
_post setvariable ["PowCells",_ar,true];
*/
_post SPAWN SAOKFREEPOWS;
};
};
//PLAYER FAR
SAOKCONSONDEL = {
private ["_post"];
_post = _this;
if (!isNil{_post getvariable "Junk"}) then {{deletevehicle _x;} foreach (_post getvariable "Junk");};
if (!isNil{(_post getvariable "WeaponsNow")}) then {
{{deletevehicle _x;} foreach ((_x select 0) select 0); deletevehicle ((_x select 0) select 1);} foreach (_post getvariable "WeaponsNow");
};
_post setvariable ["WeaponsNow",nil,true];
if (!isNil{(_post getvariable "ObjectsNow")}) then {
{deletevehicle (_x select 0);} foreach (_post getvariable "ObjectsNow");
};
_post setvariable ["ObjectsNow",nil,true];
if (!isNil{(_post getvariable "ObjectsNowS")}) then {
{deletevehicle (_x select 0);} foreach (_post getvariable "ObjectsNowS");
};
_post setvariable ["ObjectsNowS",nil,true];
};
SAOKCONSONDELPOST = {
private ["_post"];
_post = _this;
if (!isNil{_post getvariable "Junk"}) then {{deletevehicle _x;} foreach (_post getvariable "Junk");};
if (!isNil{(_post getvariable "WeaponsNow")}) then {
{{deletevehicle _x;} foreach ((_x select 0) select 0); deletevehicle ((_x select 0) select 1);} foreach (_post getvariable "WeaponsNow");
};
_post setvariable ["WeaponsNow",nil,true];
if (!isNil{(_post getvariable "ObjectsNow")}) then {
{deletevehicle (_x select 0);} foreach (_post getvariable "ObjectsNow");
};
_post setvariable ["ObjectsNow",nil,true];
if (!isNil{(_post getvariable "ObjectsNowS")}) then {
{deletevehicle (_x select 0);} foreach (_post getvariable "ObjectsNowS");
};
_post setvariable ["ObjectsNowS",nil,true];
_post setvariable ["StaticW",[],true];
_post setvariable ["StaticO",[],true];
_post setvariable ["StaticOS",[],true];
if (_post in GuardPosts) then {activatedPost = activatedPost - [_post];};
deletevehicle _post;
};

SAOKCONSRESETOBJ = {
private ["_f1","_post"];
_f1 = {
private ["_obj","_nul","_thism","_pos"];
_thism = _this select 0;
_pos = _thism select 1;
_obj = createVehicle [(_thism select 0), _pos, [], 0, "CAN_COLLIDE"]; 
_wTm = _obj worldToModel _pos;
_obj setpos [(_pos select 0)+(_wTm select 0),(_pos select 1)+(_wTm select 1),0];
_obj setdir (_thism select 2);
if !((_thism select 0) in ["Land_BarGate_F","FirePlace_burning_F"]) then {[_obj,0] SPAWN VehLife;};
_obj setvectorup (_thism select 3);
if ((_thism select 0) in ["Box_IND_Wps_F"]) then {
_nul = [_obj,(_this select 1) getvariable "CrateC"] SPAWN FLoadCrate;
_obj setvariable ["AmCrate",1,true];
_obj setvariable ["CCCrate",1,true];
};
if ((_thism select 0) in ["Land_BarGate_F"]) then {
	_obj allowdamage false;
	//ANIMATED BAR GATE
	_nul = _obj SPAWN {
	if (isNil"_this") exitWith {};
	while {!isNull _this} do {  
	waitUntil {sleep 1; isNull _this || {{{isPlayer _x} count crew _x > 0 || {(count crew _x > 0 && {side (driver _x) == EAST})}} count ((getposATL _this) nearEntities [["Car"],30]) > 0}};  
	_this animate ["Door_1_rot", 1];  
	waitUntil {sleep 1; isNull _this || {{{isPlayer _x} count crew _x > 0  ||{(count crew _x > 0 && {side (driver _x) == EAST})}} count ((getposATL _this) nearEntities [["Car"],30]) == 0}}; 
	_this animate ["Door_1_rot", 0];  
	};  
	};
	///////////////////
};
_vN = "ObjectsNow";
if (count _this > 2) then {_vN = "ObjectsNowS";};
if (isNil{_post getvariable _vN}) then {_post setvariable [_vN,[[_obj,(_thism select 4)]],true];} else {_oldD = _post getvariable _vN;_post setvariable [_vN,(_oldD+[[_obj,(_thism select 4)]]),true];};
};
_post = _this;
if (!isNil{(_post getvariable "ObjectsNow")}) then {
{deletevehicle (_x select 0);} foreach (_post getvariable "ObjectsNow");
};
_post setvariable ["ObjectsNow",nil,true];
if (!isNil{(_post getvariable "ObjectsNowS")}) then {
{deletevehicle (_x select 0);} foreach (_post getvariable "ObjectsNowS");
};
_post setvariable ["ObjectsNowS",nil,true];
{
[_x,_post] CALL _f1;
} foreach (_post getvariable "StaticO");
{
[_x,_post,""] CALL _f1;
} foreach (_post getvariable "StaticOS");
};

if (!isServer) exitWith {};
SAOKGPcondPlayerCaptured = {
private ["_bol","_post","_dd","_sidee"];
_bol = false;
_post = _this select 0;
_dd = _this select 1;
_sidee = _this select 2;
_units = [];
if (!isNil{_post getvariable "Junk"}) then {
{if ((typeof _x) isKindof "Man") then {_units pushback _x;};} foreach (_post getvariable "Junk");
};
if (random 1 < 0.1 && {{behaviour _x == "COMBAT"} count _units > 0}) then {
_u = [];
{if (alive _x && {isNil{_x getvariable "SaOkSurrendered"}}) then {_u pushback _x;};} foreach _units;
if (count _u > 0) then {
_u = _u call RETURNRANDOM;
if (side _u == EAST) then {
group _u SPAWN SAOKAISMOKEPURPLE;
} else {
group _u SPAWN SAOKAISMOKEBLUE;
};
};
};
if (!isNil{_post getvariable "WeaponsNow"}) then {
{{if ((typeof _x) isKindof "Man") then {_units pushback _x;};} foreach ((_x select 0) select 0);} foreach (_post getvariable "WeaponsNow");
};
_side = WEST;
_sideD = EAST;
if (getmarkercolor (_post getvariable "Gmark") == "ColorGreen") then {_side = EAST;_sideD = WEST;};

if ({alive _x && {isNil{_x getvariable "SaOkSurrendered"}}} count _units == 0 && {{_x distance _post < 50 && {((getposATL _x) select 2) < 3}} count ([_side] CALL AllPf) > 0} && {{_x distance _post < 50 && {((getposATL _x) select 2) < 3}} count ([_sideD] CALL AllPf) == 0}) then {
_bol = true;
};
_bol 
};
SAOKGPcondFar = {
private ["_bol","_post"];
_bol = false;
_post = _this;
_dis = (["Lb"] CALL DIS);
if ({_x distance _post < _dis} count ([] CALL AllPf) == 0) then {_bol = true;};
_bol 
};
//_POST
SAOKGPcondEnemyClose = {
private ["_bol","_post"];
_bol = false;
//_post = _this;
//if ((getmarkercolor (_post getvariable "Gmark") == "ColorGreen") && {{count crew _x > 0 && {side ((crew _x) select 0) == EAST} && {_x distance _post < 1000}} count vehicles > 0}) then {_bol = true;};
_bol 
};



_ffdd = {
private ["_y","_n"];
_y = _this;
if (!(_y in activatedPost) && {(!(_y CALL SAOKGPcondFar) || {_y CALL SAOKGPcondEnemyClose})} && {isNil{_y getvariable "NotReady"}}) then {
if (_y in GuardPosts) then {activatedPost pushback _y;};
_marker = _y getvariable "Gmark"; _marker setMarkerSize [0.8,0.8];
_y CALL SAOKCONSONSPAWN;
};
};

_ffaa = {
private ["_y","_n","_dd","_sidee","_marker"];
_dd = (["Lb"] CALL DIS);
_y = _this;
if (_y CALL SAOKGPcondFar && {!(_y CALL SAOKGPcondEnemyClose)} && {isNil{_y getvariable "KeepG"}}) then {
if (_y in GuardPosts) then {activatedPost = activatedPost - [_y];};
_y CALL SAOKCONSONDEL;
} else {
_sidee = WEST;
_marker = _y getvariable "Gmark";
if (getmarkercolor _marker == "ColorRed") then {
_sidee = EAST;
};
if ([_y,_dd,_sidee] CALL SAOKGPcondPlayerCaptured) then {
_tyy = "WEST";
if (_sidee == WEST) then {_tyy = "EAST";};
_n = [getposATL _y,_tyy,20] CALL GuardPostSide;
if (_tyy == "WEST" && {{vehicle _x distance _y < 200} count ([] CALL AllPf) > 0}) then {
[[_y],"SAOKMULTIL1",nil,false] spawn BIS_fnc_MP;
};
};
};
};



activatedPost = [];
while {true} do {
if ({isPlayer _x} count ([] CALL AllPf) == 0) then {
waitUntil {sleep 10; {isPlayer _x} count ([] CALL AllPf) > 0};
};
_c = count GuardPosts - 1;
if (_c > -1) then {
for "_i" from 0 to _c do {
private ["_xx"];
_xx = GuardPosts select _i;
_xx SPAWN _ffdd;
sleep 0.1;
};
};
sleep 0.5;
{if (isNil"_x" || {isNull _x}) then {activatedPost = [activatedPost,_foreachIndex] call BIS_fnc_removeIndex;};} foreach activatedPost;
sleep 0.5;
_copy = + activatedPost;
_c = count _copy - 1;
if (_c > -1) then {
for "_i" from 0 to _c do {
private ["_xx"];
_xx = _copy select _i;
if (!isNil"_xx" && {!isNull _xx}) then {
_xx SPAWN _ffaa;
};
sleep 0.1;
};
};
sleep 3;
};
