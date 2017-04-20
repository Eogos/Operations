////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Santeri, v1.062, #Pileko)
////////////////////////////////////////////////////////

class WLaDialog {
    idd = 32144;
    movingEnable = false;
    objects[] = {};
    class controlsBackground {};
    class controls {
	
	////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Santeri, v1.062, #Pucufa)
////////////////////////////////////////////////////////

////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Santeri, v1.062, #Ficery)
////////////////////////////////////////////////////////

////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Santeri, v1.063, #Zinupe)
////////////////////////////////////////////////////////

class RscFrame_1800: RscFrame
{
	idc = 1800;
	text = "WLA Menu"; //--- ToDo: Localize;
	x = 10.64 * GUI_GRID_W + GUI_GRID_X;
	y = 4.92 * GUI_GRID_H + GUI_GRID_Y;
	w = 12 * GUI_GRID_W;
	h = 15 * GUI_GRID_H;
};
class RscButton_1601: RscButton
{
	idc = 1601;
	text = "Mil Shop"; //--- ToDo: Localize;
	x = 11.5 * GUI_GRID_W + GUI_GRID_X;
	y = 6 * GUI_GRID_H + GUI_GRID_Y;
	w = 4.5 * GUI_GRID_W;
	h = 1.5 * GUI_GRID_H;
	action = "closeDialog 0;_nul = [] SPAWN KAUPPA;";
};
class RscButton_1602: RscButton
{
	idc = 1602;
	text = "Wait Time"; //--- ToDo: Localize; _nul = (groupSelectedUnits player) SPAWN FUNK_WaitTime;
	x = 12 * GUI_GRID_W + GUI_GRID_X;
	y = 12.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 4.5 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
	action = "closeDialog 0;_nul = [] SPAWN FUNK_WaitTime;";
};
class RscButton_1603: RscButton
{
	idc = 1603;
	text = "Fast Travel"; //--- ToDo: Localize;
	x = 17 * GUI_GRID_W + GUI_GRID_X;
	y = 12.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 4.5 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
	action = "closeDialog 0;_n = [] SPAWN FastTravelDialog;  ";
};
class RscButton_1608: RscButton
{
	idc = 1608;
	text = "Orders/Other Menu"; //--- ToDo: Localize;
	x = 12 * GUI_GRID_W + GUI_GRID_X;
	y = 11 * GUI_GRID_H + GUI_GRID_Y;
	w = 9.5 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
	action = "closeDialog 0;_n = [] SPAWN F_OrdersDialog;";
};
class RscButton_1604: RscButton
{
	idc = 1604;
	text = "Savegame"; //--- ToDo: Localize;
	x = 17.9 * GUI_GRID_W + GUI_GRID_X;
	y = 16 * GUI_GRID_H + GUI_GRID_Y;
	w = 3.7 * GUI_GRID_W;
	h = 1.5 * GUI_GRID_H;
	action = "savegame;[[],""FSaOkSave"",false,false] spawn BIS_fnc_MP;";
};
class RscButton_1600: RscButton
{
	idc = 1600;
	text = "Local Shop"; //--- ToDo: Localize;
	x = 17.5 * GUI_GRID_W + GUI_GRID_X;
	y = 6 * GUI_GRID_H + GUI_GRID_Y;
	w = 4.5 * GUI_GRID_W;
	h = 1.5 * GUI_GRID_H;
	action = "closeDialog 0;if (player CALL NEARESTLOCATIONNAME != ""factory"") then {_nul = [] SPAWN KAUPPAVILLAGE;} else {_n = [] SPAWN SAOKFACDIA;};";
};
class RscButton_1605: RscButton
{
	idc = 1605;
	text = "Call Support"; //--- ToDo: Localize;
	x = 12.5 * GUI_GRID_W + GUI_GRID_X;
	y = 8.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 8.5 * GUI_GRID_W;
	h = 2 * GUI_GRID_H;
	action = "closeDialog 0;_nul = [] SPAWN FUNK_SupportDialog;";
};
class RscButton_1606: RscButton
{
	idc = 1606;
	text = "Exit"; //--- ToDo: Localize;
	x = 18 * GUI_GRID_W + GUI_GRID_X;
	y = 18 * GUI_GRID_H + GUI_GRID_Y;
	w = 3.5 * GUI_GRID_W;
	h = 1.5 * GUI_GRID_H;
	action = "closeDialog 0";
};	
class RscButton_1609: RscButton
{
	idc = 1609;
	text = "Mods"; //--- ToDo: Localize;
	x = 15 * GUI_GRID_W + GUI_GRID_X;
	y = 18.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 2.5 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
	action = "closeDialog 0;_nul = [] SPAWN SAOKADDONMAIN;";
};	
	class RscButton_1607: RscButton
{
	idc = 1607;
	text = "GEAR"; //--- ToDo: Localize;
	x = 18 * GUI_GRID_W + GUI_GRID_X;
	y = 14 * GUI_GRID_H + GUI_GRID_Y;
	w = 3.5 * GUI_GRID_W;
	h = 1.5 * GUI_GRID_H;
	action = "closeDialog 0;_nul = [] SPAWN VASunitselection;";
};
class RscStructuredText_1100: RscStructuredText
{
	idc = 1100;
	x = 11.0 * GUI_GRID_W + GUI_GRID_X;
	y = 14 * GUI_GRID_H + GUI_GRID_Y;
	w = 6.5 * GUI_GRID_W;
	h = 5.5 * GUI_GRID_H;
	size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////

////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////

////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////

};
};

