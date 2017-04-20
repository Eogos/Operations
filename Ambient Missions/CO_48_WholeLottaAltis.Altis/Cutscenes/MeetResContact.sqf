/*
titlecut ["","black out",2];
sleep 2;
_camera = "camera" camcreate [0,0,0];
_camera cameraeffect ["internal", "back"];
showcinemaBorder false;
if (!isNil{(leader (([] CALL AllPf) call RETURNRANDOM)) getvariable "LastVeh"} &&!isNull ((leader (([] CALL AllPf) call RETURNRANDOM)) getvariable "LastVeh") && alive ((leader (([] CALL AllPf) call RETURNRANDOM)) getvariable "LastVeh")) then {((leader (([] CALL AllPf) call RETURNRANDOM)) getvariable "LastVeh") setpos getposATL Respad_1;((leader (([] CALL AllPf) call RETURNRANDOM)) getvariable "LastVeh") setdir (direction Respad_1);};
{_x allowdamage false; _x setpos getposATL Respad2_1;} foreach ([] CALL AllPf);
sleep 2;
titlecut ["","black in",5];
_actor1 = [WEST,"I_G_Soldier_GL_F",100,[16518.9,20677.6,4],objNull] CALL FUNKTIO_SPAWNACTOR;
_actor2 = [WEST,typeof (leader (([] CALL AllPf) call RETURNRANDOM)),270,[16524,20676.7,3.5],(leader (([] CALL AllPf) call RETURNRANDOM))] CALL FUNKTIO_SPAWNACTOR;
//actor1 setidentity "Marek_Vitek";
//HOUSE P
_camera camPrepareTarget [95979.22,-33788.55,-26826.02];
_camera camPreparePos [16524.47,20678.72,5.46];
_camera camPrepareFOV 0.700;
_camera camCommitPrepared 0;
_camera camPrepareTarget [80712.34,-53831.95,-18099.91];
_camera camPreparePos [16522.95,20677.89,4.69];
_camera camPrepareFOV 0.700;
_camera camCommitPrepared 10;
sleep 4;
titletext ["PLAYER: What is this place, are you the leader of resistance?","PLAIN DOWN",7];
sleep 6;
//RES
_camera camPrepareTarget [96742.52,80277.88,3439.82];
_camera camPreparePos [16518.30,20676.63,4.34];
_camera camPrepareFOV 0.700;
_camera camCommitPrepared 0;
_camera camPrepareTarget [33924.45,118347.34,12555.48];
_camera camPreparePos [16519.12,20676.07,4.10];
_camera camPrepareFOV 0.700;
_camera camCommitPrepared 7;
titletext ["RESISTANCE SOLDIER: I am not, first I need to be sure that we can trust you and you are worth of our time","PLAIN DOWN",7];
sleep 7;
_camera camPrepareTarget [-77907.34,-10712.31,-9847.89];
_camera camPreparePos [16525.08,20677.48,4.67];
_camera camPrepareFOV 0.700;
_camera camCommitPrepared 0;
_camera camPrepareTarget [-81471.05,3369.65,-9847.90];
_camera camPreparePos [16525.13,20677.26,4.82];
_camera camPrepareFOV 0.414;
_camera camCommitPrepared 0;
titletext ["RESISTANCE SOLDIER: I will arrange a meeting for you, with our leader, if you do something for us first","PLAIN DOWN",7];
sleep 7;
_camera camPrepareTarget [-37780.95,104067.27,-9847.95];
_camera camPreparePos [16519.86,20676.64,4.65];
_camera camPrepareFOV 0.414;
_camera camCommitPrepared 0;
_camera camPrepareTarget [-70509.41,-27577.01,-9848.03];
_camera camPreparePos [16520.58,20678.33,4.65];
_camera camPrepareFOV 0.414;
_camera camCommitPrepared 7;
titletext ["RESISTANCE SOLDIER: You will need capture one persian camp for our use, not far from here","PLAIN DOWN",7];
sleep 7;
_camera camPrepareTarget [75982.45,100748.39,-7262.19];
_camera camPreparePos [16522.89,20675.85,4.56];
_camera camPrepareFOV 0.609;
_camera camCommitPrepared 0;
_camera camPrepareTarget [69707.28,105047.19,-7262.21];
_camera camPreparePos [16523.01,20675.78,4.56];
_camera camPrepareFOV 0.609;
_camera camCommitPrepared 7;
titletext ["PLAYER: Thats fine. Show us the target on map and lets get going","PLAIN DOWN",7];
sleep 4;
titlecut ["","black out",3];
sleep 3;
_camera cameraeffect ["terminate", "back"];
camdestroy _camera;
titletext ["","PLAIN DOWN",7];
{_x allowdamage true;} foreach ([] CALL AllPf);
deletevehicle _actor1;
deletevehicle _actor2;
titlecut ["","black in",2];
*/
_nul = [] execVM "MainTasks\Resistance2.sqf";




