CurTaskS = CurTaskS + ["MainTasks\Task1_ConvertResistance.sqf"];

_sc = [] execVM "Cutscenes\CutM1_Chat.sqf";
waitUntil {sleep 3; scriptdone _sc};
sleep 2;
_st2 = [getposATL player, 3200,"(1 - sea) * (1 + meadow)* (1 - hills)",""] CALL FUNKTIO_POS;
_start2 = (_st2 select 0) select 0;
_size = 3200;
while {player distance _start2 < 900 || {!([_start2,20] CALL SAOKISFLAT)}} do {
sleep 1;
_st2 = [getposATL player, _size,"(1 - sea) * (1 + meadow)* (1 - hills)",""] CALL FUNKTIO_POS;
_start2 = (_st2 select 0) select 0;
_size = _size + 50;
};

[
player, // Task owner(s)
"taskMT1", // Task ID (used when setting task state, destination or description later)
["We will not get resistance to fight for us as long their current leader Fox Crow have the command. Most of the resistance groups are only following him to stay alive. If we manage to kill Fox Crow, a new leader will be chosen who will be most likely the POW we just saved. We would get much of the local groups to our side", "Kill Fox Crow", "Kill Fox Crow"], // Task description
objNull, // Task destination
true // true to set task as current upon creation
] call BIS_fnc_taskCreate;

_st2 = [_start2, 200,"(1 - sea) * (1 + meadow)",300] CALL FUNKTIO_POS;
_start3 = (_st2 select 0) select 0;
_n = [_start3, "ColorRed",["O_G_Offroad_01_armed_F","O_G_Offroad_01_armed_F"]] CALL AddVehicleZone;
_st2 = [_start2, 200,"(1 - sea) * (1 + meadow)",300] CALL FUNKTIO_POS;
_start3 = (_st2 select 0) select 0;
_n = [_start3, "ColorRed",["O_G_Offroad_01_armed_F","O_G_Offroad_01_armed_F"]] CALL AddVehicleZone;

_nul = [_start2,"RES",25] SPAWN CreateRoadBlock;
_group = [_start2, EAST, ["O_G_officer_F"],[],[],[0.4,0.8]] call SpawnGroupCustom;
_nul = [units _group,nearestObjects [(leader _group), ["FirePlace_burning_F","Land_FirePlace_F"], 100], [getposATL (leader _group),100],[]] SPAWN AICampBehaviour;
_crowKing = leader _group;
_crowKing setvariable ["CantSur",1];
DONTDELGROUPS = DONTDELGROUPS + [_group];
NUMM = NUMM + 1;
//icon = "\a3\Ui_F_Curator\Data\CfgMarkers\kia_ca.paa";
_someId = format ["IDSAOK%1",NUMM];
[_someId, "onEachFrame", {
	if (isNil"IC3D") exitWith {};
	drawIcon3D ["\a3\Ui_F_Curator\Data\CfgMarkers\kia_ca.paa", ICONCOLORRED, _this, 0.8, 0.8, 0, (format ["Kill Fox Crow: %1m",round (_this distance player)]), 1, 0.02, "TahomaB"];
}, _crowKing] call BIS_fnc_addStackedEventHandler;
_mar = format ["MainTaskM%1",NUMM];
NUMM=NUMM+1;
_marker = [_mar,getposATL _crowKing, "mil_destroy", [0.8,0.8], "ColorRed", "Find and Kill Fox Crow"] CALL FUNKTIO_CREATEMARKER;

_size = 1200;
_st2 = [_start2, 1200,"(1 - sea) * (1 + trees)* (1 - hills)",""] CALL FUNKTIO_POS;
_start4 = (_st2 select 0) select 0;
while {_start4 distance _start2 < 300} do {
sleep 1;
_st2 = [_start2, _size,"(1 - sea) * (1 + trees)* (1 - hills)",""] CALL FUNKTIO_POS;
_start4 = (_st2 select 0) select 0;
_size = _size + 50;
};
_mar2 = format ["MainTaskM%1",NUMM];
NUMM=NUMM+1;
_marker = [_mar2,_start4, "mil_flag", [0.5,0.5], "ColorGreen", "Crate with Sniper-Rifle"] CALL FUNKTIO_CREATEMARKER;
_obj = createVehicle ["Box_IND_Wps_F",_start4, [], 0, "NONE"]; 
_obj setvariable ["AmCrate",1];
_obj setdir (random 360);
clearWeaponCargo _obj;
clearMagazineCargo _obj;
clearBackPackCargo _obj;
clearItemCargo _obj;
_obj addweaponcargo ["srifle_LRR_SOS_F",1];
_obj addmagazinecargo ["7Rnd_408_Mag",7];
_obj additemcargo ["optic_SOS",1];
sleep 5;
titletext [((name player)+": We should probably check the crate that Acacius mentioned. Got the location marked on map"),"PLAIN DOWN",7];
waitUntil {sleep 10; !alive _crowKing};
_obj setvariable ["AmCrate",nil];
deletemarker _mar;
deletemarker _mar2;
_nul = ["taskMT1","SUCCEEDED"] call BIS_fnc_taskSetState;
[_someId, "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
CurTaskS = CurTaskS - ["MainTasks\Task1_ConvertResistance.sqf"];
sleep 10;
_nul = [] execVM "Cutscenes\MeetResContact.sqf";