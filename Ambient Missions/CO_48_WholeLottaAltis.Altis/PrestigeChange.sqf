private ["_change","_cause","_msg","_ordercode"];
_change = if (!isNil{_this select 0}) then {_this select 0} else {0};
_cause = _this select 1;
_msg = if (_change > 0) then {"<t color='#33FF33'>"+"+"} else {"<t color='#FF0033'>"+"-"};
_msg = _msg + (format ["%1",_change]);
_msg = _msg + " ["+ _cause + "]</t>";
_side = WEST;
if (count _this > 2) then {_side = _this select 2;};
if (side player != _side) exitWith {};
20 cutRsc ["MyRscTitle5","PLAIN"];
disableSerialization;
_disp = uiNamespace getVariable "d5_MyRscTitle";
(_disp displayCtrl 305) ctrlSetStructuredText parseText _msg;

		