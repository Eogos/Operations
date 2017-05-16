class PlayerRightsDialog {
    idd = 4521;
    movingEnable = false;
    objects[] = {};
    class controlsBackground {};
    class controls {

////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Santeri, v1.063, #Maligu)
////////////////////////////////////////////////////////

class RscFrame_1800: RscFrame
{
	idc = 1800;
	text = "Rights"; //--- ToDo: Localize;
	x = 5.14 * GUI_GRID_W + GUI_GRID_X;
	y = 5.31 * GUI_GRID_H + GUI_GRID_Y;
	w = 20.5 * GUI_GRID_W;
	h = 9.5 * GUI_GRID_H;
};
class RscListbox_1500: RscListbox
{
	idc = 1500;
	x = 5.5 * GUI_GRID_W + GUI_GRID_X;
	y = 7 * GUI_GRID_H + GUI_GRID_Y;
	w = 6 * GUI_GRID_W;
	h = 7.5 * GUI_GRID_H;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 35) * 1)";
};
class RscText_1000: RscText
{
	idc = 1000;
	text = "Cur Rights"; //--- ToDo: Localize;
	x = 12.5 * GUI_GRID_W + GUI_GRID_X;
	y = 5.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 5.5 * GUI_GRID_W;
	h = 1.5 * GUI_GRID_H;
	
};
class RscText_1001: RscText
{
	idc = 1001;
	text = "Add"; //--- ToDo: Localize;
	x = 20.5 * GUI_GRID_W + GUI_GRID_X;
	y = 5.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 5.5 * GUI_GRID_W;
	h = 1.5 * GUI_GRID_H;
	
};
class RscButton_1600: RscButton
{
	idc = 1600;
	text = "Shops"; //--- ToDo: Localize;
	x = 20.5 * GUI_GRID_W + GUI_GRID_X;
	y = 7 * GUI_GRID_H + GUI_GRID_Y;
	w = 4.5 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
	action = "SELEunit setvariable [""Shops"",true,true];";
};
class RscButton_1601: RscButton
{
	idc = 1601;
	text = "Support"; //--- ToDo: Localize;
	x = 20.5 * GUI_GRID_W + GUI_GRID_X;
	y = 8.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 4.5 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
	action = "SELEunit setvariable [""Support"",true,true];";
};
class RscButton_1602: RscButton
{
	idc = 1602;
	text = "Construct"; //--- ToDo: Localize;
	x = 20.5 * GUI_GRID_W + GUI_GRID_X;
	y = 10 * GUI_GRID_H + GUI_GRID_Y;
	w = 4.5 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
	action = "SELEunit setvariable [""Construct"",true,true];";
};
class RscButton_1603: RscButton
{
	idc = 1603;
	text = "Civ Speak"; //--- ToDo: Localize;
	x = 20.5 * GUI_GRID_W + GUI_GRID_X;
	y = 11.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 4.5 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
	action = "SELEunit setvariable [""Civ Speak"",true,true];";
};
class RscButton_1604: RscButton
{
	idc = 1604;
	text = "Remove All"; //--- ToDo: Localize;
	x = 20 * GUI_GRID_W + GUI_GRID_X;
	y = 13 * GUI_GRID_H + GUI_GRID_Y;
	w = 5 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
	action = "{SELEunit setvariable [_x,nil,true];} foreach [""Civ Speak"",""Construct"",""Support"",""Shops""];";
};
class RscStructuredText_1100: RscStructuredText
{
	idc = 1100;
	x = 12.5 * GUI_GRID_W + GUI_GRID_X;
	y = 7 * GUI_GRID_H + GUI_GRID_Y;
	w = 7 * GUI_GRID_W;
	h = 6 * GUI_GRID_H;
};
class RscText_1002: RscText
{
	idc = 1002;
	text = "Player"; //--- ToDo: Localize;
	x = 5.5 * GUI_GRID_W + GUI_GRID_X;
	y = 5.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 5.5 * GUI_GRID_W;
	h = 1.5 * GUI_GRID_H;
	
};
class RscButton_1605: RscButton
{
	idc = 1605;
	text = "Exit"; //--- ToDo: Localize;
	x = 13 * GUI_GRID_W + GUI_GRID_X;
	y = 13.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 5 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
	action = "closeDialog 0";
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////

};
};
