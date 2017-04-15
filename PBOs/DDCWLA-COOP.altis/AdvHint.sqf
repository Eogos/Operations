//////////////////////////////////////////////////////////////////
// Function file for Armed Assault
// Created by: TODO: Author Name
//////////////////////////////////////////////////////////////////


private ["_xx","_y"];
_xx = _this select 0;
_y = _this select 1;

BIS_AdvHints_THeader =  _xx;
BIS_AdvHints_TInfo =  _y;
BIS_AdvHints_TAction = "";
BIS_AdvHints_TBinds = "";
BIS_AdvHints_Text = call BIS_AdvHints_formatText;
BIS_AdvHints_Duration = 12;
BIS_AdvHints_Seamless = true;
BIS_AdvHints_Silent = true;
call BIS_AdvHints_showHint;