1 = [{ 
    { 
        if (side _x == west) then { 
            _x disableAI "ALL";
        }; 
    } forEach allUnits; 
}, 20, []] call CBA_fnc_addPerFrameHandler;

2 = [{ 
    { 
        if (side _x == west) then { 
            _x enableAI "MOVE";
        }; 
    } forEach allUnits; 
}, 20, []] call CBA_fnc_addPerFrameHandler;