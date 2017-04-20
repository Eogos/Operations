        private ["_unit"];
		
		_unit = _this select 0;
		if !(group _unit in DONTDELGROUPS) then {
		if (vehicle _unit != _unit) then {unassignvehicle _unit;_unit action ["Eject", vehicle _unit];};
		if (typeof _unit iskindof "SoldierEB") then {[_unit] SPAWN FENEMYCASULTIE;};
		waituntil {sleep 3;vehicle _unit == _unit};
        _unit removeAllMPEventHandlers "mpkilled";
        _unit removeAllMPEventHandlers "mphit";
        _unit removeAllMPEventHandlers "mprespawn";
        _unit removeAllEventHandlers "FiredNear";
        _unit removeAllEventHandlers "HandleDamage";
        _unit removeAllEventHandlers "Killed";
        _unit removeAllEventHandlers "Fired";
        _unit removeAllEventHandlers "Local";
        //clearVehicleInit _unit;
        deleteVehicle _unit;
		};
