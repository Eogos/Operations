private ["_ied","_m"];
//["IEDLandBig_F","IEDLandSmall_F","IEDUrbanBig_F","IEDUrbanSmall_F"] "SatchelCharge_Remote_Ammo_Scripted"
//_m = ["IEDLandBig_F","IEDLandSmall_F","IEDUrbanBig_F","IEDUrbanSmall_F"] call RETURNRANDOM; 
//_m = ["IEDLandBig_Remote_Ammo","IEDLandSmall_Remote_Ammo","IEDUrbanBig_Remote_Ammo","IEDUrbanSmall_Remote_Ammo"] call RETURNRANDOM; 
_pos = _this select 0;
_owner = _this select 1;
_dis = _this select 2;
if (isNil"_pos" || {isNil"_owner"} || {isNil"_dis"}) exitWith {};
_tar = [WEST,CIVILIAN];
if (_owner == "EAST") then {_tar = [EAST,CIVILIAN];};
_m = ["SatchelCharge_Remote_Ammo_Scripted","DemoCharge_Remote_Ammo_Scripted","ClaymoreDirectionalMine_Remote_Ammo_Scripted"]call RETURNRANDOM;
_ied = createVehicle [_m, _pos, [], 0, "NONE"];
waitUntil {sleep 2; isNull _ied || {{vehicle _x distance _ied < _dis} count ([] CALL AllPf) == 0} || {!alive _ied} || {{_x distance _ied < 5 && {!(side _x in _tar)}} count (_pos nearEntities ["Man",7]) > 0}};
if (!alive _ied || {{_x distance _ied < 5 && {!(side _x in _tar)}} count (_pos nearEntities ["Man",7]) > 0}) then {_ied setdamage 1;} else {deletevehicle _ied;};

