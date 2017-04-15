
private ["_text","_ok","_myDisplay"];
disableserialization;
_ok = createDialog "PlayerRightsDialog"; 
_myDisplay = findDisplay 4521;
{
if (isPlayer _x) then {
lbAdd [1500, name _x];
};
} foreach units group player - [player];
SELEunit = player;
while {dialog} do {
	{if (name _x == (lbText [1500, (lbCurSel 1500)])) exitwith {SELEunit = _x;};} foreach units group player;
	_text = "";
	{if !(isNil{SELEunit getvariable _x}) then {_text = _text + _x + "<br/>";};} foreach ["Civ Speak","Construct","Support","Shops"];
	(_myDisplay displayCtrl 1100) ctrlSetStructuredText parseText _text;
	sleep 0.1;
};