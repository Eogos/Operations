private ["_hours","_ordercode","_ok"];

if (!dialog) then {
_ok = createDialog "RestingDialog"; 
lbAdd [1500, "Do Nothing"];
lbAdd [1500, "One Hour"];
lbAdd [1500, "Two Hours"];
lbAdd [1500, "Four Hours"];
lbAdd [1500, "Eight Hours"];
lbAdd [1500, "Eleven Hours"];
lbSetCurSel [1500, 0];
_hours = 0;
while {dialog} do {
	if ((lbCurSel 1500) == 0) then {_hours = 0;};
	if ((lbCurSel 1500) == 1) then {_hours = 1;};
	if ((lbCurSel 1500) == 2) then {_hours = 2;};
	if ((lbCurSel 1500) == 3) then {_hours = 4;};
	if ((lbCurSel 1500) == 4) then {_hours = 8;};
	if ((lbCurSel 1500) == 5) then {_hours = 11;};
sleep 0.1;
};

if (_hours > 0) then {
titlecut ["","black out",2];
{_x allowdamage false;} foreach ([] CALL AllPf);
sleep 2;
//skiptime _hours;
sleep 2;
titlecut ["","black in",2];
JipDate = date;
publicVariable "JipDate";
//setDate [(date select 0), (date select 1), (date select 2), (date select 3), (date select 4)];
sleep 3;
{_x allowdamage true;} foreach ([] CALL AllPf);
};

};

