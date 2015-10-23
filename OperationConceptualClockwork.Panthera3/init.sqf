//////////////////////////////////////////////////////////////////
// Function file for Armed Assault
// Created by: Schwerer Konigstiger
//////////////////////////////////////////////////////////////////



[] execVM "minedetector\minedetector.sqf";

[] execVM "minemarker\mm.sqf";

[] execVM "interiorlights\IntLight.sqf";

[] execVM "R3F_LOG\init.sqf";

[] [factory, "spawn_pos"] execVM "R3F_LOG\USER_FUNCT\do_not_lose_it.sqf";

// Code for convoy defend script
//pos is the MARKER for convoy movement, while c is the name for the vehicle in the editor
//if (isServer) then {
//	[["r","r1","r2","r3","r4","r5","r6","r7","r8","r9","r10","r11","r12","r13","r14","r15","r16","r17","r18"],[c1,c2,c3,c4],true] execVM "convoyDefend\convoyDefend_init.sqf";
//};
