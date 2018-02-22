// by ALIAS
// nul = [this] execVM "AL_gravity\gravity.sqf";
// Gravity generator

if (!hasInterface) exitWith {};

private ["_al_gravity","_ele","_raza","_halo","_gravi","_ref","_li1"];

_al_gravity = _this select 0;
_gravi = true;

[_gravi,_al_gravity] spawn {
_gravi_sound = _this select 0;
_al_gravity_emiter = _this select 1;
while {alive _al_gravity_emiter} do {
	// gravity say3d "vum";
	//[[_al_gravity_emiter,"vum"], "say3d", true] call BIS_fnc_MP;
	[_al_gravity_emiter,["vum",2000]] remoteExec ["say3d"];
	sleep 11;
};
};

// electric

_ele = "#particlesource" createVehicleLocal (getpos _al_gravity);
_ele setParticleCircle [0, [0, 0, 0]];
_ele setParticleRandom [0, [0.25, 0.25, 0], [0.175, 0.175, 0], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
_ele setParticleParams [["\A3\data_f\blesk1", 1, 0, 1], "", "SpaceObject", 1, 0.5, [0, 0, 0], [0, 0, 0.75], 0.3, 10, 7.9, 0.075, [0.1, 0.1, 0.1], [[0.1, 0.1, 0.1, 1], [0.25, 0.25, 0.25, 0.5], [0.5, 0.5, 0.5, 0]], [0.08], 1, 0, "", "", _al_gravity];
_ele setDropInterval 0.05;

// raza

_raza = "#particlesource" createVehicleLocal (getpos _al_gravity);
_raza setParticleCircle [1, [0, 0, 0]];
_raza setParticleRandom [0, [0.25, 0.25, 0], [0.175, 0.175, 0], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
_raza setParticleParams [["\A3\data_f\kouleSvetlo", 1, 0, 1], "", "Billboard", 1, 17, [0, 0, 0], [0, 0, 17], 0, 9, 9, 0, [5, 5, 5], [[1, 0.1, 0.1, 1], [1, 0.25, 0.25, 1], [1, 0.5, 0.5, 0]], [0.08], 1, 0, "", "", _al_gravity];
_raza setDropInterval 0.002;

// halo

_halo = "#particlesource" createVehicleLocal (getpos _al_gravity);
_halo setParticleCircle [2, [0, 0, 0]];
_halo setParticleRandom [15, [0.25, 0.25, 0], [0.175, 0.175, 0], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
_halo setParticleParams [["\A3\data_f\laserBeam", 1, 0, 1], "", "SpaceObject", 1, 15, [0, 0, 0], [0, 0, 11], 3, 10, 7.9, 0, [1, 1, 1], [[1, 1, 1, 1], [1, 1, 1, 1], [0.5, 0.5, 0.5, 0]], [0.08], 1, 0, "", "", _al_gravity];
_halo setDropInterval 0.01;

_ref = "#particlesource" createVehicleLocal (getpos _al_gravity);
_ref setParticleCircle [20, [0, 0, 0]];
_ref setParticleRandom [60, [0.25, 0.25, 0], [0, 0, 0], 5, 0.25, [0, 0, 0, 0.5], 0, 0];
_ref setParticleParams [["\A3\data_f\ParticleEffects\Universal\Refract.p3d", 1, 0, 1], "", "Billboard", 1, 60, [0, 0, 0], [0, 0, 0], 5, 9.7, 7.9, 0, [20, 20, 20], [[1, 1, 1, 1], [1, 1, 1, 0.5], [1, 1, 1, 1]], [0.08], 1, 0, "", "", _al_gravity];
_ref setDropInterval 0.5;


// lumina
	_li1 = "#lightpoint" createVehicle [(getpos _al_gravity select 0)+5,(getpos _al_gravity select 1)+5,(getpos _al_gravity select 2)+ 20];
	
	_li1 setLightBrightness 15;
	_li1 setLightAmbient[1,0.6,0.2];
	_li1 setLightColor[1,0,0];
	_li1 lightAttachObject [_al_gravity, [5,5,0]];	
		
	sleep 1;

while {alive _al_gravity} do {
	
	_i= 10+random 55;
	
//	_lum= [
		while {_i>10} do {
		_li1 setLightBrightness _i;
		_i = _i-0.2;
		sleep 0.1;
		};	
//	];
	
//	waituntil {scriptdone _lum};
	sleep random 4;
};

deleteVehicle _ele;
deleteVehicle _raza;
deleteVehicle _halo;
deleteVehicle _ref;
deleteVehicle _li1;

sleep 120;

deleteVehicle _al_gravity;