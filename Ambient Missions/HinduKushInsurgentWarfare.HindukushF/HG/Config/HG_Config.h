#include "HG_Macros.h"
/*
    Author - HoverGuy
    © All Fucks Reserved
    Website - http://www.sunrise-production.com
	
	currencyType - STRING - Currency you want to use (ISO format)
	cashVariable - STRING - Custom cash variable you want to use instead of default one (setVariable'd on player and broadcasted)
	bankVariable - STRING - Custom bank variable you want to use instead of default one (setVariable'd on player and broadcasted)
	
	resetSavedMoney - BOOL - Useful for mission rotation, if it's set to true old saved money will be reset to startCash/startBank values whenever the server is restarted or mission changes
	enableHUD - BOOL - Enable money display in HUD?
	enablePaycheck - BOOL - Enable paycheck?
	enableKillReward - BOOL - Enable kill reward?
	enableTeamKillPenalty - BOOL - Works only if enableKillReward is set to true
	enableCrate - BOOL - Enable old stuff saving in crate when buying new clothes?
	enableGiveMoney - BOOL - Enable ability to give money to others?
	enableBuyToGarage - BOOL - Enable ability to automatically store vehicle in garage when bought? Set it to false if you don't use garage
	clearInventory - BOOL - Clear vehicle default inventory (FAKs etc...) when spawning (retrieving vehicle from garage and buying)?
	storeVehiclesOnDisconnect - BOOL - Store player vehicles when player disconnects?
	deleteBodyOnDisconnect - BOOL - Delete player body when player disconnects?
	resetGaragesOnServerStart - BOOL - Reset player garages when server starts?
	enablePlayerInventorySave - BOOL - Enable player gear saving? Disable this if you have a custom saving system
	enableVehicleInventorySave - BOOL - Enable vehicle gear saving? Disable this if you have a custom saving system
	enableXP - BOOL - Enable XP system?
	enableKillCount - BOOL - Enable kill count in HUD?
	enableTags - BOOL - Enable player tags?
	enableMarkers - BOOL - Enable group units position markers on map?
	enableATM - BOOL - Enable ability to use in game ATMs?
	enableWhitelist - BOOL - Enable or disable whitelisting, even if enabled admins can bypass it *ONLY WORKS WHEN SAVING METHOD IS SET TO EXTDB*
	
	whitelistSides - ARRAY OF STRINGS - If enableWhitelist is set to true, defines whitelisted sides, can only be "civilian"/"west"/"resistance"/"east" or mixed *HAS TO BE LOWERCASE*
	
	admins - ARRAY OF STRINGS - Admins PUIDs
	
	atmKey - INTEGER - Key to push when near to an ATM to open dialog, default is T (0x14 / 20), see https://community.bistudio.com/wiki/DIK_KeyCodes OR https://forums.bistudio.com/forums/topic/111590-keyboard-ui-number-codes/?do=findComment&comment=1848755
	lockUnlockKey - INTEGER - Key to push to lock/unlock owned vehicle, default is Y (0x15 / 44), see links above
	giveMoneyKey - INTEGER - Key to push to open give money dialog, default is H (0x23 / 35), see links above
	giveKeyKey - INTEGER - Key to push to open keys menu dialog, default is F (0x21 / 33), see links above
	adminKey - INTEGER - Key to push to open admin menu, default is Left Windows (0xDB / 219), see links above
	
	savingMethod - STRING - Use "Profile" for server profile or "extDB" for extDB3, if the latest make sure you have extDB3 setup correctly (see https://github.com/Ppgtjmad/SimpleShops/wiki/Database)
	extDBDatabase - STRING - If "extDB" is used as savingMethod, set the DB config to use (the one defined in @extDB3\extdb3-conf.ini file) *CASE SENSITIVE*
	extDBProtocol - STRING - If "extDB" is used as savingMethod, set the saving protocol used by extDB3 either "SQL" or "SQL_CUSTOM"
	extDBCustomFile - STRING - If "extDB" is used as savingMethod & extDBProtocol is "SQL_CUSTOM", set the custom file to use (located in @extDB3\sql_custom folder)
	
	class HG_MasterCfg
	{
		class Rank - Can be PRIVATE/CORPORAL/SERGEANT/LIEUTENANT/CAPTAIN/MAJOR/COLONEL
		{
			paycheck - INTEGER - Paycheck amount
			paycheckPeriod - INTEGER - Time (in minutes) between each paycheck iteration, only used if enablePaycheck is set to true
			startCash - INTEGER - Obvious...
			startBank - INTEGER - Obvious...
			killedReward - INTEGER - Money earned by killer, only used if enableKillReward is set to true
			tkPenaltyPlayer - INTEGER - Money taken when player of the same side is killed (team kill), only used if enableTeamKillPenalty is set to true
			tkPenaltyAI - INTEGER - Money taken when AI of the same side is killed (team kill), only used if enableTeamKillPenalty is set to true & AI is setup correctly (https://github.com/Ppgtjmad/SimpleShops/wiki/How-to-setup-kill-rewards)
			xpPenaltyPlayer - INTEGER - XP taken when player of the same side is killed (team kill), only used if enableXP & enableTeamKillPenalty is set to true
			xpPenaltyAI - INTEGER - XP taken when AI of the same side is killed (team kill), only used if enableXP & enableTeamKillPenalty is set to true & AI is setup correctly (https://github.com/Ppgtjmad/SimpleShops/wiki/How-to-setup-kill-rewards)
			xpReward - INTEGER - XP earned by killer, only used if enableXP & enableKillReward are set to true
			xpToLvlUp - INTEGER - XP required to rank up, last rank has to be 0, only used if enableXP is set to true
			iShopDiscount - INTEGER/FLOAT - Items shop discount in %, based on total price, 0 means no discount
			gShopDiscount - INTEGER/FLOAT - Gear shop discount in %, based on total price, 0 means no discount
			vShopDiscount - INTEGER/FLOAT - Vehicles shop discount in %, 0 means no discount
		};
	};
*/

/* MONEY */
currencyType = "USD";
cashVariable = "HG_Cash";
bankVariable = "HG_Bank";

/* SYSTEMS */
resetSavedMoney = false;
enableHUD = true;
enablePaycheck = true;
enableKillReward = true;
enableTeamKillPenalty = true;
enableCrate = true;
enableGiveMoney = true;
enableBuyToGarage = true;
clearInventory = true;
storeVehiclesOnDisconnect = true;
deleteBodyOnDisconnect = false;
resetGaragesOnServerStart = false;
enablePlayerInventorySave = true;
enableVehicleInventorySave = true;
enableXP = true;
enableKillCount = true;
enableTags = true;
enableMarkers = true;
enableATM = true;
enableWhitelist = true;

/* WHITELIST */
whitelistSides[] = {"resistance"};

/* ADMINS */
admins[] = {"_SP_PLAYER_","76561198046396805"};

/* KEYS */
atmKey = 0x14;
lockUnlockKey = 0x15;
giveMoneyKey = 0x23;
giveKeyKey = 0x21;
adminKey = 0xDB;

/* SAVING */
savingMethod = "Profile";
extDBDatabase = "HG";
extDBProtocol = "SQL_CUSTOM";
extDBCustomFile = "custom.ini";

/* MASTER CFG */
class HG_MasterCfg
{
	class PRIVATE
	{
		paycheck = 100;
		paycheckPeriod = 120;
		startCash = 500;
		startBank = 0;
		killedReward = 100;
		tkPenaltyPlayer = 2500;
		tkPenaltyAI = 1000;
		xpPenaltyPlayer = 250;
		xpPenaltyAI = 100;
		xpReward = 5;
		xpToLvlUp = 1000;
		iShopDiscount = 0;
		gShopDiscount = 0;
		vShopDiscount = 0;
	};
	class CORPORAL
	{
		paycheck = 500;
		paycheckPeriod = 120;
		startCash = 500;
		startBank = 0;
		killedReward = 100;
		tkPenaltyPlayer = 2500;
		tkPenaltyAI = 1000;
		xpPenaltyPlayer = 250;
		xpPenaltyAI = 100;
		xpReward = 5;
		xpToLvlUp = 1500;
		iShopDiscount = 0;
		gShopDiscount = 0;
		vShopDiscount = 0;
	};
	class SERGEANT
	{
		paycheck = 1000;
		paycheckPeriod = 120;
		startCash = 500;
		startBank = 0;
		killedReward = 100;
		tkPenaltyPlayer = 2500;
		tkPenaltyAI = 1000;
		xpPenaltyPlayer = 250;
		xpPenaltyAI = 100;
		xpReward = 5;
		xpToLvlUp = 2000;
		iShopDiscount = 0;
		gShopDiscount = 0;
		vShopDiscount = 0;
	};
	class LIEUTENANT
	{
		paycheck = 1500;
		paycheckPeriod = 120;
		startCash = 500;
		startBank = 0;
		killedReward = 100;
		tkPenaltyPlayer = 2500;
		tkPenaltyAI = 1000;
		xpPenaltyPlayer = 250;
		xpPenaltyAI = 100;
		xpReward = 5;
		xpToLvlUp = 2500;
		iShopDiscount = 0;
		gShopDiscount = 0;
		vShopDiscount = 0;
	};
	class CAPTAIN
	{
		paycheck = 2000;
		paycheckPeriod = 120;
		startCash = 500;
		startBank = 0;
		killedReward = 100;
		tkPenaltyPlayer = 2500;
		tkPenaltyAI = 1000;
		xpPenaltyPlayer = 250;
		xpPenaltyAI = 100;
		xpReward = 5;
		xpToLvlUp = 3000;
		iShopDiscount = 2;
		gShopDiscount = 2;
		vShopDiscount = 2;
	};
	class MAJOR
	{
		paycheck = 2500;
		paycheckPeriod = 120;
		startCash = 500;
		startBank = 0;
		killedReward = 100;
		tkPenaltyPlayer = 2500;
		tkPenaltyAI = 1000;
		xpPenaltyPlayer = 250;
		xpPenaltyAI = 100;
		xpReward = 5;
		xpToLvlUp = 3500;
		iShopDiscount = 4;
		gShopDiscount = 4;
		vShopDiscount = 4;
	};
	class COLONEL
	{
		paycheck = 3000;
		paycheckPeriod = 120;
		startCash = 500;
		startBank = 0;
		killedReward = 100;
		tkPenaltyPlayer = 2500;
		tkPenaltyAI = 1000;
		xpPenaltyPlayer = 250;
		xpPenaltyAI = 100;
		xpReward = 5;
		xpToLvlUp = 0;
		iShopDiscount = 6;
		gShopDiscount = 6;
		vShopDiscount = 6;
	};
};

////////// DO NOT MODIFY //////////
class HG_DealersCfg
{
	#include "HG_DealersCfg.h"
};

class HG_GaragesCfg
{
    #include "HG_GaragesCfg.h"
};

class HG_GearShopCfg
{
    #include "HG_GearShopCfg.h"
};

class HG_ItemsShopCfg
{
    #include "HG_ItemsShopCfg.h"
};

class HG_TradersCfg
{
	#include "HG_TradersCfg.h"
};

class HG_VehiclesShopCfg
{
    #include "HG_VehiclesShopCfg.h"
};
//////////
