class MovieMakerEditor
{
	class controls
	{
		class MyFirstRscText : RscText
		{
			w = "(1020 / 1920) * SafeZoneW";
			h = "(570 / 1080) * SafeZoneH";
			text = "";
			colorBackground[] = {0.1, 0.1, 0.1, 0.5};
			x = "SafeZoneX + (90 / 1920) * SafeZoneW";
			y = "SafeZoneY + (60 / 1080) * SafeZoneH";
		};
		class MyRscButton : RscButton
		{
			x = "SafeZoneX + (338.000000000001 / 1920) * SafeZoneW";
			y = "SafeZoneY + (82.04 / 1080) * SafeZoneH";
			text = "Add Shot +";
			w = "(79 / 1920) * SafeZoneW";
			h = "(31 / 1080) * SafeZoneH";
		};
		class MyRscCombo : RscCombo
		{
			x = "SafeZoneX + (446.000000000001 / 1920) * SafeZoneW";
			y = "SafeZoneY + (122.04 / 1080) * SafeZoneH";
			text = "Select screen effect for current shot";
			w = "(285 / 1920) * SafeZoneW";
			h = "(20 / 1080) * SafeZoneH";
		};
		class MyRscListBox : RscListBox
		{
			x = "SafeZoneX + (109 / 1920) * SafeZoneW";
			y = "SafeZoneY + (118.04 / 1080) * SafeZoneH";
			w = "(300 / 1920) * SafeZoneW";
			h = "(350 / 1080) * SafeZoneH";
			text = "";
			onLoad = "comment ""<{0} ctrlShow {1};>"";(_this select 0) ctrlShow true;comment ""</{0} ctrlShow {1};>"";";
			font = "TahomaB";
		};
		class MyRscButton1 : RscButton
		{
			x = "SafeZoneX + (327.999999999999 / 1920) * SafeZoneW";
			y = "SafeZoneY + (469.04 / 1080) * SafeZoneH";
			text = "Delete Shot -";
			w = "(79 / 1920) * SafeZoneW";
			h = "(31 / 1080) * SafeZoneH";
		};
		class MyRscButton2 : RscButton
		{
			x = "SafeZoneX + (773 / 1920) * SafeZoneW";
			y = "SafeZoneY + (566.04 / 1080) * SafeZoneH";
			text = "Generate SQF and Copy to Clipboard";
			sizeEx = 0.05;
			w = "(318.999999999999 / 1920) * SafeZoneW";
			h = "(46 / 1080) * SafeZoneH";
		};
		class MyRscText : RscText
		{
			x = "SafeZoneX + (450 / 1920) * SafeZoneW";
			y = "SafeZoneY + (106.04 / 1080) * SafeZoneH";
			text = "Select Screen Effect";
			w = "(124 / 1920) * SafeZoneW";
			h = "(16 / 1080) * SafeZoneH";
		};
		class MyRscText1 : RscText
		{
			x = "SafeZoneX + (453 / 1920) * SafeZoneW";
			y = "SafeZoneY + (155.04 / 1080) * SafeZoneH";
			text = "Select Tranzition Effect";
			w = "(154 / 1920) * SafeZoneW";
			h = "(16 / 1080) * SafeZoneH";
		};
		class MyRscCombo1 : RscCombo
		{
			x = "SafeZoneX + (446.000000000001 / 1920) * SafeZoneW";
			y = "SafeZoneY + (180 / 1080) * SafeZoneH";
			w = "(285 / 1920) * SafeZoneW";
			h = "(20 / 1080) * SafeZoneH";
		};
		class MyRscPicture : RscPicture
		{
			x = "SafeZoneX + (977 / 1920) * SafeZoneW";
			y = "SafeZoneY + (74.04 / 1080) * SafeZoneH";
		};
		class MyRscEdit : RscEdit
		{
			x = "SafeZoneX + (441 / 1920) * SafeZoneW";
			y = "SafeZoneY + (221.04 / 1080) * SafeZoneH";
			w = "(274 / 1920) * SafeZoneW";
			h = "(31 / 1080) * SafeZoneH";
			canModify = 1;
			text = "Insert Sound Name";
		};
		class MyRscEdit1 : RscEdit
		{
			x = "SafeZoneX + (441 / 1920) * SafeZoneW";
			y = "SafeZoneY + (292.04 / 1080) * SafeZoneH";
			w = "(79 / 1920) * SafeZoneW";
			h = "(31 / 1080) * SafeZoneH";
		};
		class MyRscText2 : RscText
		{
			x = "SafeZoneX + (443 / 1920) * SafeZoneW";
			y = "SafeZoneY + (271.04 / 1080) * SafeZoneH";
			text = "Input Duration for Camera shot";
			w = "(184 / 1920) * SafeZoneW";
			h = "(16 / 1080) * SafeZoneH";
		};
		class MyRscText3 : RscText
		{
			x = "SafeZoneX + (438 / 1920) * SafeZoneW";
			y = "SafeZoneY + (358.04 / 1080) * SafeZoneH";
			text = "On Screen Text";
			w = "(124 / 1920) * SafeZoneW";
			h = "(16 / 1080) * SafeZoneH";
		};
		class MyRscEdit2 : RscEdit
		{
			x = "SafeZoneX + (443.000000000001 / 1920) * SafeZoneW";
			y = "SafeZoneY + (456.04 / 1080) * SafeZoneH";
			canModify = 1;
			text = "";
			w = "(64 / 1920) * SafeZoneW";
			h = "(31 / 1080) * SafeZoneH";
			onLoad = "comment ""<{0} ctrlShow {1};>"";(_this select 0) ctrlShow true;comment ""</{0} ctrlShow {1};>"";comment ""<{0} ctrlEnable {1};>"";(_this select 0) ctrlEnable true;comment ""</{0} ctrlEnable {1};>"";";
		};
		class MyRscEdit3 : RscEdit
		{
			x = "SafeZoneX + (437 / 1920) * SafeZoneW";
			y = "SafeZoneY + (382.04 / 1080) * SafeZoneH";
			w = "(454 / 1920) * SafeZoneW";
			h = "(46 / 1080) * SafeZoneH";
		};
		class MyRscText4 : RscText
		{
			x = "SafeZoneX + (439 / 1920) * SafeZoneW";
			y = "SafeZoneY + (442.04 / 1080) * SafeZoneH";
			text = "Font size";
		};
		class MyRscText5 : RscText
		{
			x = "SafeZoneX + (519.999999999999 / 1920) * SafeZoneW";
			y = "SafeZoneY + (446.04 / 1080) * SafeZoneH";
			text = "Text color";
		};
		class MyRscEdit4 : RscEdit
		{
			x = "SafeZoneX + (526 / 1920) * SafeZoneW";
			y = "SafeZoneY + (463.04 / 1080) * SafeZoneH";
			w = "(64 / 1920) * SafeZoneW";
			h = "(31 / 1080) * SafeZoneH";
			canModify = 1;
			onLoad = "comment ""<{0} ctrlShow {1};>"";(_this select 0) ctrlShow true;comment ""</{0} ctrlShow {1};>"";comment ""<{0} ctrlEnable {1};>"";(_this select 0) ctrlEnable true;comment ""</{0} ctrlEnable {1};>"";";
		};
		class MyRscText6 : RscText
		{
			x = "SafeZoneX + (629 / 1920) * SafeZoneW";
			y = "SafeZoneY + (452.04 / 1080) * SafeZoneH";
			text = "Text Position on Screen";
			w = "(139 / 1920) * SafeZoneW";
			h = "(16 / 1080) * SafeZoneH";
		};
		class MyRscCombo2 : RscCombo
		{
			x = "SafeZoneX + (629 / 1920) * SafeZoneW";
			y = "SafeZoneY + (477.04 / 1080) * SafeZoneH";
			w = "(210 / 1920) * SafeZoneW";
			h = "(20 / 1080) * SafeZoneH";
		};
		class MyRscButton3 : RscButton
		{
			x = "SafeZoneX + (110 / 1920) * SafeZoneW";
			y = "SafeZoneY + (576.04 / 1080) * SafeZoneH";
			text = "Test Movie";
			w = "(169 / 1920) * SafeZoneW";
			h = "(31 / 1080) * SafeZoneH";
			sizeEx = 0.05;
		};
		class MyRscButton4 : RscButton
		{
			x = "SafeZoneX + (351 / 1920) * SafeZoneW";
			y = "SafeZoneY + (583.04 / 1080) * SafeZoneH";
			text = "Test Shot";
			sizeEx = 0.05;
			w = "(109 / 1920) * SafeZoneW";
			h = "(31 / 1080) * SafeZoneH";
		};
	};
};