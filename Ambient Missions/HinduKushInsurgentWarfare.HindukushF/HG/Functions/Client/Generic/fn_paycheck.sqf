/*
    Author - HoverGuy
    © All Fucks Reserved
    Website - http://www.sunrise-production.com
*/

while{alive player} do
{
    systemChat format[(localize "STR_HG_PAYCHECK_NOTF"),(getNumber(getMissionConfig "CfgClient" >> "HG_MasterCfg" >> (rank player) >> "paycheckPeriod"))];
    uiSleep ((getNumber(getMissionConfig "CfgClient" >> "HG_MasterCfg" >> (rank player) >> "paycheckPeriod")) * 60);
	[(getNumber(getMissionConfig "CfgClient" >> "HG_MasterCfg" >> (rank player) >> "paycheck")),0] call HG_fnc_addOrSubCash;
	systemChat format[(localize "STR_HG_TIME_TO_PAY"),([(getNumber(getMissionConfig "CfgClient" >> "HG_MasterCfg" >> (rank player) >> "paycheck")),true] call HG_fnc_currencyToText)];
};