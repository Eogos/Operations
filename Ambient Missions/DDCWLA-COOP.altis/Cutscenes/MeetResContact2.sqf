/*
titlecut ["","black out",2];
sleep 2;
_camera = "camera" camcreate [0,0,0];
_camera cameraeffect ["internal", "back"];
showcinemaBorder false;
if (!isNil{(leader (([] CALL AllPf) call RETURNRANDOM)) getvariable "LastVeh"} &&!isNull ((leader (([] CALL AllPf) call RETURNRANDOM)) getvariable "LastVeh") && alive ((leader (([] CALL AllPf) call RETURNRANDOM)) getvariable "LastVeh")) then {((leader (([] CALL AllPf) call RETURNRANDOM)) getvariable "LastVeh") setpos getposATL Respad_2;((leader (([] CALL AllPf) call RETURNRANDOM)) getvariable "LastVeh") setdir (direction Respad_2);};
{_x allowdamage false; _x setpos getposATL Respad2_2;} foreach ([] CALL AllPf);
sleep 2;
titlecut ["","black in",5];
_actor1 = [WEST,"I_G_Soldier_GL_F",180,[16628,19020.2,0],objNull] CALL FUNKTIO_SPAWNACTOR;
_actor2 = [WEST,typeof (leader (([] CALL AllPf) call RETURNRANDOM)),0,[16628.5,19015.2,0],(leader (([] CALL AllPf) call RETURNRANDOM))] CALL FUNKTIO_SPAWNACTOR;
//actor1 setidentity "Marek_Vitek";
//HOUSE P
_camera camPrepareTarget [-79312.95,22867.52,27965.04];
_camera camPreparePos [16630.28,19015.81,0.54];
_camera camPrepareFOV 0.700;
_camera camCommitPrepared 0;
_camera camPrepareTarget [-78697.08,30542.21,27965.39];
_camera camPreparePos [16629.18,19015.37,1.38];
_camera camPrepareFOV 0.700;
_camera camCommitPrepared 7;
titletext ["PLAYER: How it looks, did we capture the right camp for you?","PLAIN DOWN",7];
sleep 7;
_camera camPrepareTarget [-13617.09,114257.10,-3704.72];
_camera camPreparePos [16628.99,19014.36,1.59];
_camera camPrepareFOV 0.311;
_camera camCommitPrepared 0;
_camera camPrepareTarget [-9476.48,114199.88,-16031.71];
_camera camPreparePos [16629.03,19014.24,1.77];
_camera camPrepareFOV 0.311;
_camera camCommitPrepared 7;
titletext ["RESISTANCE SOLDIER: Great job, our leader want to meet you already in 2 hours. I show you the way","PLAIN DOWN",7];
sleep 4;
titlecut ["","black out",3];
sleep 3;
titletext ["","PLAIN DOWN",7];
_camera cameraeffect ["terminate", "back"];
camdestroy _camera;
{_x allowdamage true;} foreach ([] CALL AllPf);
deletevehicle _actor1;
deletevehicle _actor2;
titlecut ["","black in",2];
*/
_nul = [] execVM "Cutscenes\MeetRes.sqf";




