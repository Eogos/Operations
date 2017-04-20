private ["_hcGroups","_pos"];

_hcGroups = [];
{
if ({!isNil{_x getvariable "FromP"}}count units _x > 0) then {
_hcGroups = _hcGroups + [_x];
};
} foreach hcAllGroups (leader (([] CALL AllPf)call RETURNRANDOM));
{
_x SPAWN {
_posP = getposATL vehicle (leader (([] CALL AllPf)call RETURNRANDOM));
_pos = [(_posP select 0)+100-(random 200),(_posP select 1)+100-(random 200),0];
while {surfaceIsWater _pos} do {
sleep 0.5;
_posP = getposATL vehicle (leader (([] CALL AllPf)call RETURNRANDOM));
_pos = [(_posP select 0)+300-(random 600),(_posP select 1)+300-(random 600),0];
};
{_x setpos [(_pos select 0)+10-(random 20),(_pos select 1)+10-(random 20),0];} foreach units _this;
};
} foreach _hcGroups;