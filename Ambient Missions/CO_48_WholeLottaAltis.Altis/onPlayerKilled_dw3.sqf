// uses basic "Killed" EH, same possibility is "MPkilled" (server-side) //"HitPart" can provide quite interesting info too if needed
private ["_dw_curr_wpn","_dw_killer","_dw_killer_distance","_dw_killer_skill","_dw_killer_skill_array","_dw_killer_combatmode","_dw_killer_behaviour","_dw_killer_actualWeapon","_dw_killer_zeroing","_dw_killer_vision","_dw_killer_precision","_dw_killer_weaponstate","_dw_killer_weaponsItems","_dw_killer_weaponAccessories","_dw_killer_unitPos","_dw_killer_health","_dw_killer_fatigue","_dw_killer_moral","_dw_victim","_victim_unitPos","_dw_victim_unitPos","_dw_killer_canFire","_dw_killer_fleeing","_dw_killer_handshit","_dw_killer_gethitPointDamage_head","_dw_killer_gethitPointDamage_hands","_dw_rank_killer","_dw_rankID_killer","_dw_killer_simulationEnabled","_dw_killer_speed","_dw_killer_stance","_dw_killer_unitRecoilCoefficient","_dw_assignedTarget","_dw_wind"];
_dw_victim = _this select 0;
_dw_killer = _this select 1;

if (!(isPlayer _dw_killer) && {alive _dw_killer} && { ((_dw_killer isKindOf "Man") OR (_dw_killer isKindOf "AllVehicles")) } ) then {
	
_dw_killer_isTypeOf = typeOf _dw_killer; 
	
_dw_curr_wpn = (currentWeapon _dw_killer);
	
_dw_killer_skill = skill _dw_killer; //1
_dw_killer_skill_array = []; //2
_dw_killer_skill_array = [
_dw_killer skillFinal "aimingAccuracy",
_dw_killer skillFinal "aimingShake",
_dw_killer skillFinal "aimingSpeed",
_dw_killer skillFinal "endurance",
_dw_killer skillFinal "spotDistance",
_dw_killer skillFinal "spotTime",
_dw_killer skillFinal "courage",
_dw_killer skillFinal "reloadSpeed",
_dw_killer skillFinal "commanding",
_dw_killer skillFinal "general"
];

_dw_killer_combatMode = combatMode _dw_killer; //3
_dw_killer_behaviour = behaviour _dw_killer; //4

_dw_killer_actualWeapon = ""; //5
if (_dw_curr_wpn == primaryWeapon _dw_killer) then { _dw_killer_actualWeapon = "primaryWeapon"; }
else 
		{
			if (_dw_curr_wpn == secondaryWeapon _dw_killer)	then { _dw_killer_actualWeapon = "secondaryyWeapon"; } else
			{ 
			if (_dw_curr_wpn == handgunWeapon _dw_killer)	then { _dw_killer_actualWeapon = "handgunWeapon"; }
			};
		};

_dw_killer_vision = currentVisionMode _dw_killer; //6
_dw_killer_zeroing = currentZeroing _dw_killer; //7
_dw_killer_precision = precision _dw_killer; //17

// _dw_killer_weapon = _dw_curr_wpn; //_dw_killer_weapon = currentMuzzle _dw_killer;
// _dw_killer_magazine = currentMagazineDetail _dw_killer;
// _dw_killer_WeaponMode = currentWeaponMode _dw_killer;
_dw_killer_weaponstate = [];

// is there even way to tell by single command if the actually selected weapon is primary or secondary or handgun ?
// _dw_killer_weaponItemsPrimary = primaryWeaponItems _dw_killer;
// _dw_killer_weaponItemsSecondary = secondaryWeaponItems _dw_killer;
// _dw_killer_weaponItemsHandgun = handgunItems _dw_killer;

_dw_killer_weaponsItems = [];
_dw_killer_weaponsItems = weaponsItems _dw_killer; //9 //weapons are listed in the order they were taken by the unit, with the most recent at the bottom of the array 
_dw_killer_weaponAccessories = [];

_dw_killer_unitPos = "";
_dw_killer_unitPos = unitPos _dw_killer; //10 //Unit pos set by setUnitPosWeak is not returned for remote (non-local) units.

_dw_killer_health = damage _dw_killer; //11
_dw_killer_fatigue = getFatigue _dw_killer; //12
_dw_killer_moral = morale _dw_killer; //13

_dw_killer_distance = _dw_victim distance _dw_killer; //14

// _dw_killer_weaponLowered = weaponLowered _dw_killer; //only if there is suspected state issue
// _dw_killer_animationState = animationState _dw_killer; // only if there is need to know anim states //only returns accurate results when the target unit is within sight of the client. When executed on a dedicated server, the returned value is accurate.
// _dw_victim_animationState = animationState _dw_victim; // only if there is need to know anim states 

_dw_victim_unitPos = "";
_dw_victim_unitPos = unitPos _dw_victim; //15

_dw_killer_canFire = canFire _dw_killer; //18
_dw_killer_fleeing = fleeing _dw_killer; //19

_dw_killer_gethitPointDamage_head=0;
_dw_killer_gethitPointDamage_hands=0;

_dw_killer_fatigue=0;
_dw_killer_handshit=0;

if (_dw_killer isKindOf "Man") then {
	
_dw_killer_weaponAccessories = _dw_killer weaponAccessories (_dw_curr_wpn); //16

_dw_killer_fatigue = getFatigue _dw_killer; //12

_dw_killer_weaponstate =  weaponState _dw_killer; //8 //[WeaponName, MuzzleName, ModeName, MagazineName, AmmoCount] 

_dw_killer_handshit = handshit _dw_killer; //20 //do we have similar situation for head injury ?

_dw_killer_gethitPointDamage_head = _dw_killer getHitPointDamage "HitHead"; //21

_dw_killer_gethitPointDamage_hands = _dw_killer getHitPointDamage "HitHands"; //22

//_dw_killer_gethitPointDamage_head = _dw_killer getHitPointDamage "HitBody"; //21
//_dw_killer_gethitPointDamage_hands = _dw_killer getHitPointDamage "HitLegs"; //22
};

_dw_rank_killer = "";
_dw_rank_killer = rank (_dw_killer); //23

_dw_rankID_killer = rankID (_dw_killer); //24 //shall be same as rank just as number

_dw_killer_simulationEnabled = simulationEnabled _dw_killer; //25

_dw_killer_speed = speedMode _dw_killer; //26

_dw_killer_stance = stance _dw_killer; //27

_dw_killer_unitRecoilCoefficient = unitRecoilCoefficient _dw_killer; //28

// unitReady
_dw_assignedTarget = assignedTarget _dw_killer; //29 //prolly works only with vehicles

// would be worth analyze wind, especially in relation if AI shall be affected
// wind, windir, windstr	
_dw_wind = [windDir,windStr,wind]; //30

diag_log format ["Dw_debug1: _dw_killer=%1, _dw_killer_distance=%2, _dw_killer_skill=%3, _dw_killer_skill_array=%4, _dw_killer_combatmode=%5, _dw_killer_behaviour=%6",_dw_killer,_dw_killer_distance,_dw_killer_skill,_dw_killer_skill_array,_dw_killer_combatmode,_dw_killer_behaviour];
diag_log format ["Dw_debug2: _dw_killer=%1, _dw_killer_actualWeapon=%2, _dw_killer_zeroing=%3, _dw_killer_vision=%4, _dw_killer_precision=%5, _dw_killer_isTypeOf=%6",_dw_killer,_dw_killer_actualWeapon,_dw_killer_zeroing,_dw_killer_vision,_dw_killer_precision,_dw_killer_isTypeOf];
diag_log format ["Dw_debug3: _dw_killer=%1, _dw_killer_weaponstate=%2, _dw_killer_weaponsItems=%3, _dw_killer_weaponAccessories=%4",_dw_killer,_dw_killer_weaponstate,_dw_killer_weaponsItems,_dw_killer_weaponAccessories];
diag_log format ["Dw_debug4: _dw_killer=%1, _dw_killer_unitPos=%2, _dw_killer_health=%3, _dw_killer_fatigue=%4, _dw_killer_moral=%5",_dw_killer,_dw_killer_unitPos,_dw_killer_health,_dw_killer_fatigue,_dw_killer_moral];
diag_log format ["Dw_debug5: _dw_victim=%1, _dw_victim_unitPos=%2, _dw_assignedTarget=%3, %4=_dw_wind",_dw_victim,_dw_victim_unitPos,_dw_assignedTarget,_dw_wind];
diag_log format ["Dw_debug6: _dw_killer=%1, _dw_victim_unitPos=%2, _dw_killer_canFire=%3, _dw_killer_fleeing=%4, _dw_killer_handshit=%5, _dw_killer_gethitPointDamage_head=%6, _dw_killer_gethitPointDamage_hands=%7",_dw_killer,_dw_victim_unitPos,_dw_killer_canFire,_dw_killer_fleeing,_dw_killer_handshit,_dw_killer_gethitPointDamage_head,_dw_killer_gethitPointDamage_hands];
diag_log format ["Dw_debug7: _dw_killer=%1, _dw_rank_killer=%2, _dw_rankID_killer=%3, _dw_killer_simulationEnabled=%4, _dw_killer_speed=%5, _dw_killer_stance=%6, _dw_killer_unitRecoilCoefficient=%7",_dw_killer,_dw_rank_killer,_dw_rankID_killer,_dw_killer_simulationEnabled,_dw_killer_speed,_dw_killer_stance,_dw_killer_unitRecoilCoefficient];
};