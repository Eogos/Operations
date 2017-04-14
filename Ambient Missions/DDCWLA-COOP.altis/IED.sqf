private ["_ied","_m"];
//["IEDLandBig_F","IEDLandSmall_F","IEDUrbanBig_F","IEDUrbanSmall_F"] "SatchelCharge_Remote_Ammo_Scripted"
//_m = ["IEDLandBig_F","IEDLandSmall_F","IEDUrbanBig_F","IEDUrbanSmall_F"] call RETURNRANDOM; 
_m = ["IEDLandBig_Remote_Ammo","IEDLandSmall_Remote_Ammo","IEDUrbanBig_Remote_Ammo","IEDUrbanSmall_Remote_Ammo"] call RETURNRANDOM; 
//_m = ["SatchelCharge_Remote_Ammo_Scripted","DemoCharge_Remote_Ammo_Scripted","ClaymoreDirectionalMine_Remote_Ammo_Scripted"]call RETURNRANDOM;
_ied = createVehicle [_m, _this, [], 0, "NONE"];
IEDNUM = IEDNUM + 1;
waitUntil {sleep 2; isNull _ied || {{vehicle _x distance _ied < 500} count ([] CALL AllPf) == 0} || {!alive _ied} || {{vehicle _x distance _ied < 5} count ([] CALL AllPf) > 0}};
if (!alive _ied || {{vehicle _x distance _ied < 5} count ([] CALL AllPf) > 0}) then {_ied setdamage 1;} else {deletevehicle _ied;};
waitUntil {sleep 5; isNull _ied || {{vehicle _x distance _this < 300} count ([] CALL AllPf) == 0}};
IEDNUM = IEDNUM - 1;

