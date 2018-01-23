
null=[object_anomaly,tracking_distance,electric_sparks,damage_range,effect_on_AI] execvm "AL_twins\sparky.sqf"

/*
object_anomaly 		- string, object name you want to work as anomaly, use this as value if you run the script from the init field of the object
tracking_distance	- number, maximum distance between within which a player must be in order to be chased by anomaly
electric_sparks		- boolean, true if you want to enable the sparks, false if otherwise
damage_range		- number, minimum distance from anomaly a player must be to take damage
effect_on_AI		- boolean, true if you want AI to take damage when is in proximity of the anomaly


Example:

null=[this,800,true,70,true] execvm "AL_twins\sparky.sqf"