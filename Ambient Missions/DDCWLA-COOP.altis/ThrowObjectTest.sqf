private ["_pos"];
while {true} do {
_pos = _this select 0;
_veh = createVehicle ["O_APC_Wheeled_02_rcws_F", [_pos select 0,_pos select 1,20], [], 0, "FLY"];
_veh setpos [_pos select 0,_pos select 1,20];
_veh setvelocity [random 20,random 20,random 20];

[_veh] SPAWN {
sleep 0.1;
_y = random 1;
_x = random 1;
_z = random 1;
_xS = random 0.1;
_yS = random 0.1;
_zS = random 0.1;
_yU = 1;
_xU = 1;
_zU = 1;
while {getposATL (_this select 0) select 2 > 1} do {
(_this select 0) setvectorUp [_y, _x, _z];
sleep 0.01;
if (_yU == 1) then {_y = _y + _yS;} else {_y = _y - _yS;};
if (_xU == 1) then {_x = _x + _xS;} else {_x = _x - _xS;};
if (_zU == 1) then {_z = _z + _zS;} else {_z = _z - _zS;};
if (_y > 1) then {_yU = -1;};
if (_x > 1) then {_xU = -1;};
if (_z > 1) then {_zU = -1;};
if (_y < -1) then {_yU = 1;};
if (_x < -1) then {_xU = 1;};
if (_z < -1) then {_zU = 1;};
};
}; 
sleep 10.05;
[_veh] SPAWN {sleep 15; deletevehicle (_this select 0);};
};
