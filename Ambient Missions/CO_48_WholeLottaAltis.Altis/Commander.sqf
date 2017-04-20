private ["_lead","_gs","_l","_le","_y"];
_lead = [];
_gs = [];
{
if (leader _x == _x && {isPlayer _x}) then {
_lead = _lead + [_x];
_gs = _gs + [group _x];
} else {
if (isPlayer _x) then {
_y = _x;
{_y hcRemoveGroup _x;} foreach (hcAllGroups _y);
};
};
} foreach ([] CALL AllPf);
sleep 1;
{
_l = leader _x;
_le = _lead call RETURNRANDOM;
if(typeName _le == "ARRAY") exitWith {};
if (!(_x in CantCommand) && {count units _x > 1} && {(getposATL (vehicle (leader _x)) select 2) < 2}) then {
{
if ((_x distance _l < _le distance _l) && {((side _l == side _x) || {(side _x == WEST && {side _l == independent})})}) then {_le = _x;};
} foreach _lead;
if (((side _l == side _le) || {(side _le == WEST && {side _l == independent})}) && {!(_x in (hcAllGroups _le))}) then {
_le hcsetgroup [_x,""];
};
};
} foreach (AllGroups - _gs);
sleep 1;
{
_gg = _x;
{if (isNull _x || {_x in CantCommand} || {typeof (vehicle leader _x) iskindof "Air"} || {count units _x == 0}) then {_gg hcRemoveGroup _x;};} foreach (hcAllGroups _x);
} foreach ([] CALL AllPf)


