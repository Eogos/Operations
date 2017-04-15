private ["_car","_st","_start"];
_car = _this select 0;
sleep 10;
_t = 0;
while {vectorUp _car select 2 < 0.87 && {_t < 10}} do {
_t = _t + 1;
_st = [_car, 40,"(1 - sea)"] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
while {isOnRoad _start} do {
_st = [_car, 40,"(1 - sea)"] CALL FUNKTIO_POS;
_start = (_st select 0) select 0;
};
_car setpos _start;
sleep 10;
};