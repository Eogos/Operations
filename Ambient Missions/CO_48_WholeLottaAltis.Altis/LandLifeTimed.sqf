private ["_units","_Ppos","_start","_ran","_animal","_HowL","_wanted","_ARE"];
sleep 3;
_units = [];
_wanted = _this select 0;
_Ppos = _this select 1;
_ARE = _this select 2;
_HowL = _this select 3;
_ran = _this select 4;
while {count _units < _wanted} do {


_start = [(_Ppos select 0) - (_ARE*0.5)  + random _ARE, (_Ppos select 1) - (_ARE*0.5) + random _ARE, 0];
while {surfaceIsWater _start} do {sleep 0.1;_start = [(_Ppos select 0) - (_ARE*0.5)  + random _ARE, (_Ppos select 1) - (_ARE*0.5) + random _ARE, 0];}; 
//_ran = ["Turtle_F","Turtle_F","Tuna_F","Mullet_F","Mackerel_F","Fish_Base_F","CatShark_F"] call RETURNRANDOM; 
// "BuoyBig","BuoySmall"
_animal = createAgent [_ran, _start, [], 0, "NONE"]; 
_animal setpos _start;
_animal setdir (random 360);
_units set [count _units,_animal];

};
sleep _HowL;
{deletevehicle _x;} foreach _units;