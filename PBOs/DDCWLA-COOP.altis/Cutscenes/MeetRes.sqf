/*
titlecut ["","black out",2];
sleep 2;
_camera = "camera" camcreate [0,0,0];
_camera cameraeffect ["internal", "back"];
showcinemaBorder false;
if (!isNil{(leader (([WEST] CALL AllPf) call RETURNRANDOM)) getvariable "LastVeh"} &&!isNull ((leader (([WEST] CALL AllPf) call RETURNRANDOM)) getvariable "LastVeh") && alive ((leader (([WEST] CALL AllPf) call RETURNRANDOM)) getvariable "LastVeh")) then {((leader (([WEST] CALL AllPf) call RETURNRANDOM)) getvariable "LastVeh") setpos getposATL Respad;((leader (([WEST] CALL AllPf) call RETURNRANDOM)) getvariable "LastVeh") setdir (direction Respad);};
{_x allowdamage false; _x setpos getposATL Respad2;} foreach ([WEST] CALL AllPf);
titlecut ["","black in",5];
_actor1 = [WEST,"I_G_officer_F",133,[9534.62,15084,0],objNull] CALL FUNKTIO_SPAWNACTOR;
_actor2 = [WEST,typeof (leader (([WEST] CALL AllPf) call RETURNRANDOM)),310,[9536.89,15081.6,0],(leader (([WEST] CALL AllPf) call RETURNRANDOM))] CALL FUNKTIO_SPAWNACTOR;
//actor1 setidentity "Marek_Vitek";
//CAR
_camera camPrepareTarget [-19329.55,110817.25,-1356.24];
_camera camPreparePos [9502.54,15075.28,1.63];
_camera camPrepareFOV 0.740;
_camera camCommitPrepared 0;
_camera camPrepareTarget [45371.84,108193.30,-6394.95];
_camera camPreparePos [9501.05,15076.02,1.85];
_camera camPrepareFOV 0.740;
_camera camCommitPrepared 4;
sleep 4;
_camera camPrepareTarget [109058.22,23712.15,-3399.14];
_camera camPreparePos [9493.65,15081.03,4.19];
_camera camPrepareFOV 0.740;
_camera camCommitPrepared 0;
_camera camPrepareTarget [108735.50,10961.90,-11543.69];
_camera camPreparePos [9505.26,15088.46,11.95];
_camera camPrepareFOV 0.740;
_camera camCommitPrepared 5;
sleep 5;
_camera camPrepareTarget [103101.98,8509.92,34785.06];
_camera camPreparePos [9530.23,15089.24,1.87];
_camera camPrepareFOV 0.740;
_camera camCommitPrepared 0;
_camera camPrepareTarget [92526.26,-40655.20,-1952.37];
_camera camPreparePos [9532.65,15087.05,1.85];
_camera camPrepareFOV 0.740;
_camera camCommitPrepared 5;
sleep 5;
//RE OFF
_camera camPrepareTarget [25895.01,113484.60,-6902.51];
_camera camPreparePos [9534.38,15082.92,1.49];
_camera camPrepareFOV 0.449;
_camera camCommitPrepared 0;
_camera camPrepareTarget [34094.55,111764.68,-6902.51];
_camera camPreparePos [9534.38,15082.92,1.49];
_camera camPrepareFOV 0.449;
_camera camCommitPrepared 7;
titletext ["RESISTANCE LEADER: You need our help? You get it, but there is no room for errors","PLAIN DOWN",7];
sleep 7;
//PL
_camera camPrepareTarget [-1220.20,114326.31,-5745.34];
_camera camPreparePos [9536.71,15080.23,1.48];
_camera camPrepareFOV 0.449;
_camera camCommitPrepared 0;
_camera camPrepareTarget [-1220.20,114326.31,-5745.34];
_camera camPreparePos [9536.69,15080.39,1.48];
_camera camPrepareFOV 0.449;
_camera camCommitPrepared 6;
titletext ["PLAYER: What have happened to greek army? Where are they hiding?","PLAIN DOWN",7];
sleep 6;
//RE OFF
_camera camPrepareTarget [-83111.70,-18492.75,-16866.30];
_camera camPreparePos [9536.68,15084.69,1.50];
_camera camPrepareFOV 0.449;
_camera camCommitPrepared 0;
_camera camPrepareTarget [-87698.79,-928.57,-16866.30];
_camera camPreparePos [9536.85,15083.97,1.50];
_camera camPrepareFOV 0.449;
_camera camCommitPrepared 7;
titletext ["RESISTANCE LEADER: Army only have few recon posts left here. We need to open gates for them to have foot back on Altis","PLAIN DOWN",7];
sleep 7;
_camera camPrepareTarget [36654.34,110643.16,11644.25];
_camera camPreparePos [9534.18,15082.39,1.08];
_camera camPrepareFOV 0.449;
_camera camCommitPrepared 0;
_camera camPrepareTarget [36654.34,110643.16,11644.23];
_camera camPreparePos [9534.10,15082.41,1.08];
_camera camPrepareFOV 0.449;
_camera camCommitPrepared 7;
titletext ["RESISTANCE LEADER: That means we need to take down persian radar and anti-air near Ammolofi Bay and block roads for reinforcements","PLAIN DOWN",7];
sleep 7;
//PL
_camera camPrepareTarget [105357.59,-12299.87,8381.30];
_camera camPreparePos [9534.34,15082.35,0.86];
_camera camPrepareFOV 0.449;
_camera camCommitPrepared 0;
_camera camPrepareTarget [103816.16,-17210.38,8381.33];
_camera camPreparePos [9534.41,15082.56,0.86];
_camera camPrepareFOV 0.449;
_camera camCommitPrepared 6;
titletext ["PLAYER: The best to get started then. We will recon the area and see what can be done","PLAIN DOWN",7];
sleep 3;
titlecut ["","black out",3];
sleep 3;
titletext ["","PLAIN DOWN",7];
_camera cameraeffect ["terminate", "back"];
camdestroy _camera;
{_x allowdamage true;} foreach ([WEST] CALL AllPf);
deletevehicle _actor1;
deletevehicle _actor2;
titlecut ["","black in",2];
*/
_nul = [] execVM "MainTasks\Resistance1.sqf";





