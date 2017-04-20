


private ["_ok"];
if (!dialog) then {


_ok = createDialog "VillageDialog"; 
lbAdd [1500, "Set SPLTY Medical"];
lbAdd [1500, "Set SPLTY AA-Team"];
lbAdd [1500, "Set SPLTY AT-Team"];
lbAdd [1500, "Set SPLTY MG-Team"];
lbAdd [1500, "Bribe"];
lbAdd [1500, "Buy PickUp"];
lbAdd [1500, "Buy QuadBike"];
lbAdd [1500, "Buy Hatchback"];
lbAdd [1500, "Buy Sport Hatchback"];
lbAdd [1500, "Buy SUV"];
lbAdd [1500, "Buy Truck"];
lbSetCurSel [1500, 0];
if (side player == EAST) then {
ctrlEnable [1603, false];
};
waitUntil {!dialog};





};
