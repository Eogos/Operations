private ["_type","_st","_crowList","_end","_flockCount"];
_st = _this select 0;
_flockCount = _this select 1;
_crowList = [];
_type = ["Kestrel_Random_F","SeaGull","Kestrel_Random_F","SeaGull","Kestrel_Random_F","SeaGull"] call RETURNRANDOM; 
_end = [random 30000,random 30000,10+random 30];
while {vehicle player distance _end < 2000} do {sleep 0.1;_end = [random 30000,random 30000,10+random 30];};
//_type = "SeaGull";
for "_i" from 1 to _flockCount do {


	_crow = _type camcreate [
		(_st select 0) - 5 + (random 10),
		(_st select 1) - 5 + (random 10),
		0
	];
	_crow setDir (random 360);
	[_crow,_st, _end] SPAWN {
	private ["_crow","_st","_end","_dis","_wp","_time","_crowList"];
	_crow = _this select 0;
	_st = _this select 1;
	_end = _this select 2;
	_wp = [
	(_st select 0) - 10 + (random 20),
	(_st select 1) - 10 + (random 20),
	20 + random 10
	];
	_dis = _crow distance _wp;
	_time = (_dis);
	_crow camsetpos _wp;
	_crow camcommit _time;
	sleep (1+(random 2));
	_wp = [
	(_end select 0) - 10 + (random 20),
	(_end select 1) - 10 + (random 20),
	(_end select 2) + random 10
	];
	_dis = _crow distance _wp;
	_time = (_dis);
	_crow camsetpos _wp;
	_crow camcommit _time;
	};
	_crowList = _crowList + [_crow];
};


sleep 60;
{if (!isnull _x) then {deletevehicle _x;};} foreach _crowList;