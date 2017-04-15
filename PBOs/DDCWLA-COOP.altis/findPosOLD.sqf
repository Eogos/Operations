

private ["_position","_radius","_expression","_precision","_sourcesCount","_pos","_pos2","_bestplace"];

_position = _this select 0;
_radius = _this select 1;
_expression = _this select 2;
_precision = 7;
_sourcesCount = 1;
_bestplace = selectBestPlaces [_position,_radius,_expression,_precision,_sourcesCount];
while {count _bestplace == 0} do {
_radius = _radius + 100;
_bestplace = selectBestPlaces [_position,_radius,_expression,_precision,_sourcesCount];
};
while {isOnRoad ((_bestplace select 0) select 0)} do {
_pos = ((_bestplace select 0) select 0);
_pos2 = [(_pos select 0) + 15 - (random 30), (_pos select 1) + 15 - (random 30),0];
_bestplace = [[_pos2]];
};

_bestplace