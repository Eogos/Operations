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
class RscCheckbox_2500: RscCheckbox
{
	idc = 2500;
	text = "Island"; //--- ToDo: Localize;
	x = 11* GUI_GRID_W + GUI_GRID_X;
	y = 13 * GUI_GRID_H + GUI_GRID_Y;
	w = 7.5 * GUI_GRID_W;
	h = 0.8 * GUI_GRID_H;
	strings[] = 
	{
		"QUICK INSERTION"
	};
	checked_strings[] = 
	{
		"ISLAND INSERTION"
	};
	onCheckBoxesSelChanged = "if(_this select 2 == 1) then {player setvariable [""InsertionT"",true];} else {player setvariable [""InsertionT"",false];};";

};
class RscPicture_1266: RscPicture
{
	idc = 1266;
	//text = "#(argb,8,8,3)color(1,1,1,1)";
	colorText[] = {1, 1, 1, 0.4};
	text="WLA.paa";
	x = safeZoneX + safeZoneW - ((1+safeZoneH)/(2.8181))*0.8; 
	y = safeZoneY + safeZoneH - ((1+safeZoneH)/(2.8181))*0.4;
	h = ((1+safeZoneH)/(2.8181))*0.4;
	w = ((1+safeZoneH)/(2.8181))*0.8;  
};	
class RscFrame_1800: RscFrame
{
	idc = 1800;
	text = "WLA Menu"; //--- ToDo: Localize;
	x = 10.64 * GUI_GRID_W + GUI_GRID_X;
	y = 4.92 * GUI_GRID_H + GUI_GRID_Y;
	w = 30 * GUI_GRID_W;
	h = 15 * GUI_GRID_H;
};
class RscButton_1601: RscButton
{
	idc = 1601;
	text = "Mil Center"; //--- ToDo: Localize;
	x = 11 * GUI_GRID_W + GUI_GRID_X;
	y = 6 * GUI_GRID_H + GUI_GRID_Y;
	w = 5 * GUI_GRID_W;
	h = 1.5 * GUI_GRID_H;
	action = "closeDialog 0;_nul = [] SPAWN KAUPPA;";
};
class RscButton_1600: RscButton
{
	idc = 1600;
	text = "Local Shop"; //--- ToDo: Localize;
	x = 16.5 * GUI_GRID_W + GUI_GRID_X;
	y = 6 * GUI_GRID_H + GUI_GRID_Y;
	w = 5 * GUI_GRID_W;
	h = 1.5 * GUI_GRID_H;
	action = "closeDialog 0;if (player CALL NEARESTLOCATIONNAME != ""factory"") then {_nul = [] SPAWN KAUPPAVILLAGE;} else {_n = [] SPAWN SAOKFACDIA;};";
};
class RscButton_1605: RscButton
{
	idc = 1605;
	text = "Call Support"; //--- ToDo: Localize;
	x = 11 * GUI_GRID_W + GUI_GRID_X;
	y = 8 * GUI_GRID_H + GUI_GRID_Y;
	w = 10.5 * GUI_GRID_W;
	h = 2 * GUI_GRID_H;
	action = "closeDialog 0;_nul = [] SPAWN FUNK_SupportDialog;";
};
	class RscButton_1607: RscButton
{
	idc = 1607;
	text = "ARSENAL"; //--- ToDo: Localize;
	x = 11 * GUI_GRID_W + GUI_GRID_X;
	y = 10.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 10.5 * GUI_GRID_W;
	h = 2 * GUI_GRID_H;
	action = "player setvariable [""OwnRes"",(player getvariable ""OwnRes"") - 1,true];closeDialog 0;[""Open"",true] SPAWN BIS_fnc_arsenal;";
};
/*
class RscButton_1608: RscButton
{
	idc = 1608;
	text = "Orders/Other Menu"; //--- ToDo: Localize;
	x = 11 * GUI_GRID_W + GUI_GRID_X;
	y = 13 * GUI_GRID_H + GUI_GRID_Y;
	w = 10.5 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
	action = "closeDialog 0;_n = [] SPAWN F_OrdersDialog;";
};
*/
class RscButton_1602: RscButton
{
	idc = 1602;
	text = "Fast Travel"; //--- ToDo: Localize; _nul = (groupSelectedUnits player) SPAWN FUNK_WaitTime;
	x = 11 * GUI_GRID_W + GUI_GRID_X;
	y = 14.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 5 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
	action = "closeDialog 0;_n = [] SPAWN F_FastTravelDialog;";
};

class RscButton_1603: RscButton
{
	idc = 1603;
	text = "Plr Rights"; //--- ToDo: Localize;
	x = 16.5 * GUI_GRID_W + GUI_GRID_X;
	y = 14.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 5 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
	action = "closeDialog 0;_nul = [] SPAWN FUNK_PlayerRightsDialog;";
};

class RscButton_1604: RscButton
{
	idc = 1604;
	text = "Savegame"; //--- ToDo: Localize;
	x = 11 * GUI_GRID_W + GUI_GRID_X;
	y = 16.2 * GUI_GRID_H + GUI_GRID_Y;
	w = 10.5 * GUI_GRID_W;
	h = 2 * GUI_GRID_H;
	action = "closeDialog 0;[[],""FSaOkSave"",false,false,false] spawn BIS_fnc_MP;";
};
class RscButton_1606: RscButton
{
	idc = 1606;
	text = "Exit"; //--- ToDo: Localize;
	x = 18 * GUI_GRID_W + GUI_GRID_X;
	y = 18.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 3.5 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
	action = "closeDialog 0";
};	
class RscButton_1609: RscButton
{
	idc = 1609;
	text = "Mods"; //--- ToDo: Localize; serverCommandAvailable "#kick"
	x = 15.2 * GUI_GRID_W + GUI_GRID_X;
	y = 18.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 2.3 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
	action = "closeDialog 0;_nul = [] SPAWN SAOKADDONMAIN;";
};	
class RscButton_1610: RscButton
{
	idc = 1610;
	text = "Options"; //--- ToDo: Localize;
	x = 11 * GUI_GRID_W + GUI_GRID_X;
	y = 18.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 3.7 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
	action = "closeDialog 0;_nul = [] SPAWN SAOKWLAOPTIONS;";
};
class IGUIBack_2200: IGUIBack
{
	idc = 2200;
	x = 22 * GUI_GRID_W + GUI_GRID_X;
	y = 6 * GUI_GRID_H + GUI_GRID_Y;
	w = 18.5 * GUI_GRID_W;
	h = 13.5 * GUI_GRID_H;
};
class RscStructuredText_1100: RscStructuredText
{
	idc = 1100;
	x = 22 * GUI_GRID_W + GUI_GRID_X;
	y = 6 * GUI_GRID_H + GUI_GRID_Y;
	w = 18.5 * GUI_GRID_W;
	h = 13.5 * GUI_GRID_H;
	size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.95)";
};
class RscListbox_1501: _CT_COMBO
{
	idc = 1501;
	x = 23 * GUI_GRID_W + GUI_GRID_X;
	y = 5 * GUI_GRID_H + GUI_GRID_Y;
	w = 9 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 35) * 1.2)";
	onLBSelChanged = "(lbText [1501,(lbCurSel 1501)]) CALL SAOKWLATEXT;";
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

