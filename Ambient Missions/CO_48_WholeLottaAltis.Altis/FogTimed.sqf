private ["_time", "_pos", "_ps"];
_pos = getposATL (_this select 0);
_time = _this select 1;
//_obj = vehicle player;
//_pos = getposATL _pos;
_ps = "#particlesource" createVehicleLocal _pos;  
_ps setParticleParams [["\Ca\Data\ParticleEffects\Universal\universal.p3d", 16, 12, 13, 0], "", "Billboard", 1, 10, [0, 0, -6], [0, 0, 0], 1, 1.275, 1, 0, [4], [[1, 1, 1, 0], [1, 1, 1, 0.04], [1, 1, 1, 0]], [1000], 1, 0, "", "", nul];
_ps setParticleRandom [3, [40, 40, 0], [0, 0, 0], 2, 0.5, [0, 0, 0, 0.1], 0, 0];
_ps setParticleCircle [0.1, [0, 0, 0]];
_ps setDropInterval 0.01;
//_obj = vehicle player;
while {_time > 0} do {
	_pos = getposATL (_this select 0);
	//_snow setpos _pos;
    _ps setpos _pos;
    sleep 1;
	_time = _time - 1;
};
deletevehicle _ps;





