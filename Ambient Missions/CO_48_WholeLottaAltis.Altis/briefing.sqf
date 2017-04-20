// tasks
[
WEST, // Task owner(s)
"task0", // Task ID (used when setting task state, destination or description later)
["Our main target is to find and capture all persian held, red flag marked, camps to free Altis. To make it easier, enable factories to work for us and gather any items you can find from houses. You can use that prestige get more vehicles and forces to fight for us. Good Luck.<br/><br/><img image='house.jpg' width='346' height='233'/>", "Liberate Altis", "Liberate Altis"], // Task description
//[7000,7000,0], // Task destination
true // true to set task as current upon creation
] call BIS_fnc_taskCreate;

if (side player == WEST) then {
[
player, // Task owner(s)
"task1", // Task ID (used when setting task state, destination or description later)
["Once landing safely and finding safe spot, create camp for your team to rest with at least one tent. You can find supplies from the truck that is dropped for you. (Press Shift+C when near the truck). Once building a camp you will receive additional gear drops", "Construct Basecamp", "Construct Basecamp"], // Task description
//position myNuke1, // Task destination
true // true to set task as current upon creation
] call BIS_fnc_taskCreate;

if (leader player == player) then {
[] SPAWN {
waitUntil {sleep 4;!isNil{([(getposATL player)] CALL RETURNGUARDPOST) getvariable "CampV"}};
_nul = ["task1","SUCCEEDED"] call BIS_fnc_taskSetState;
"You are receiving gear drops from sky. You can use truck to move the crates" SPAWN HINTSAOK;
_pos = [(getposATL player select 0)+50-(random 100),(getposATL player select 1)+50-(random 100),0];
while {surfaceIsWater _pos} do {sleep 5;_pos = [(getposATL player select 0)+50-(random 100),(getposATL player select 1)+50-(random 100),0];};
_nul = [_pos,"",1,"Box_NATO_Wps_F"] SPAWN FSupportDrop;
};
};
};

[
WEST, // Task owner(s)
"task2", // Task ID (used when setting task state, destination or description later)
["You will not survive alone. Start looking for local armed groups to work with. Ask locals what they know (Shift+Y near the civilian)<br/><br/><img image='rela.jpg' width='343' height='232'/>", "Speak with Civilian", "Speak with Civilian"], // Task description
// Task destination
true // true to set task as current upon creation
] call BIS_fnc_taskCreate;

[
EAST, // Task owner(s)
"task1E", // Task ID (used when setting task state, destination or description later)
["NATO is here to prevent our right. Your task is to cause local trouble, construct guardposts and strike locally. (MORE TASKS/FEATURES FOR EAST SIDE COMING SOON)", "Give NATO some trouble", "Give NATO some trouble"], // Task description
//position myNuke1, // Task destination
true // true to set task as current upon creation
] call BIS_fnc_taskCreate;

//BIS_fnc_taskSetDestination

//task1 = player createSimpleTask ["Find the Journal"];
//task1 setSimpleTaskDescription ["Primary task is to find and destroy the missing journal. The location of the journal can be found out by co-operating with the locals, NAPA and CDF forces", "Find the Journal", "Find the Journal"];

// diary entries
//_log_arty = player createDiaryRecord ["Diary", ["Known Issues","When resuming mission, custom key dialogs will only work after ~30seconds"]];
_log_arty = player createDiaryRecord ["Diary", ["Support In MANW","Mission is taking part in official Make Arma Not War competition in both SP and MP categories. If enjoying the consept, consider supporting this COOP version in makearmanotwar.com, and remember to check the SP version"]];
_log_arty = player createDiaryRecord ["Diary", ["How to Call Air-strikes/Artillery","These options are available via 0-8-X. To hit a moving target by air-strike, you need to follow it with laser-marker on. For static targets, you dont need lasermarker. Pointing a map location or a position in 3D mode is enough. Always point first then use the call.<br/><br/><img image='plane.jpg' width='400' height='263'/>"]];
//_log_Minefield = player createDiaryRecord ["Diary", ["How to Change HC Group Behaviour","On default, High Command groups can issue attack commands to the soldiers in group. To order HC groups to keep their team members close together, Press 0-0-7. To cancel the order press it again. Created HC groups automatically follow the latest order"]];
_log_deleteunit = player createDiaryRecord ["Diary", ["Custom Keys","Construction View: Shift + C<br/>Camp Purchase Screen: SHIFT + 1<br/>VillagePurchase Screen: SHIFT + 1<br/>Talk To Civilians: SHIFT + Y<br/>Flip/Unstuck Empty Vehicle - Shift + 4<br/>Player Rights: SHIFT + 1<br/>Support Call Menu: SHIFT + 1<br/>Fast Travel: SHIFT + 1<br/>Steal Car/Take Objects: Y<br/>Load Crates to Truck: SHIFT + 9<br/>VAS: SHIFT + 1 (when near friendly camp)"]];
//_log_Group = player createDiaryRecord ["Diary", ["How to Manage High Command Groups","You are able to create High Command group(s) of selected units via 0-0-2. Note that you need do be in command view (numpad Del) to do it. To return High Command group(s) to your group, select them via Crtl-Space and press 0-0-3"]];
_log_construction = player createDiaryRecord ["Diary", ["Instructions for Construction Truck","(FOR TEAM-LEADER) You can build defences with Minefield/Construction-truck.<br/><br/>Notes: <br/>- Purchase Minefield/Construction-truck from captured Camp<br/>- Make sure the truck is under 50m away from you and press Shift + C to enter construction view<br/>- Before creating an object, with buy button, you can rotate it, and move it 2 seconds at time with a move button<br/>- Once you build any fortress, its also possible to add AI Teams to guard the post. These appear automatically, you cant set their position or direction<br/>- There needs to be around 30m distance between guardposts to be allowed to add more AI teams<br/><br/><img image='cons.jpg' width='373' height='219'/>"]];
//_log_chopperT = player createDiaryRecord ["Diary", ["Chopper Transport","You can call chopper pick up anytime by pressing 0-0-9. Once the chopper is approaching it will land closer if you use smoke-grenade. You are only allowed to give waypoints for the chopper once you are in the chopper and all your team-members are in any vehicle. For some cases, you may need to use team-member deleting functions 0-0-8"]];
//_log_medicpacks = player createDiaryRecord ["Diary", ["Medic Packs","You can carry 8 medic-packs at a time and use them by pressing 0-0-0. To resupply, rest at fireplace in US camp"]];
_log_Commanding = player createDiaryRecord ["Diary", ["Commanding","(FOR TEAM-LEADER) Optional: You have able to command nearby friendly western groups that have more than 1 team-member that haven't assigned to defend any location. Enter the commanding UI via Ctrl+Space, exit it with the same combination"]];
//_log_russians = player createDiaryRecord ["Diary", ["Car Bombers","Ugly but true, any civilian car that you may face, could have bomb in it. Avoid getting close of the civilian cars as good you can"]];
if(isNil"DisableUAV") then {
_log_rest = player createDiaryRecord ["Diary", ["UAV's and UGV's","You can use AR-2 Darter, UGV Stomper, UGV Stomper RCWS and MQ4A Greyhawk help when purchasing those from captured camp menu. Most of the camps have UAV terminal in one of the camp crates. See field manual for guide"]];
};
_log_rest = player createDiaryRecord ["Diary", ["Prestige Value","Prestige value can be used to receive additional support inc. air/land support, gear drop, vehicle drop, better reinforcements. Airfields, captured camps, villages are source for more assets<br/><br/><img image='airfield.jpg' width='400' height='240'/>"]];
_log_rest = player createDiaryRecord ["Diary", ["Village Relationship","Villages provide armed support with specialty if relationship have reached friendly locally. You can improve this by commiting tasks for civilians or by killing nearby enemies. Civilian casulties will lower the relationship causing conflicts at the end. Rumors spread randomly between villages - bad news faster than good news. If village specialty is medical, village is friendly and medic is alive, you can call the village medic to come aid you by pressing 5-1-1. Its better to be near the village to ensure medic's safety<br/><br/><img image='rela.jpg' width='347' height='233'/><br/><br/>"]];
_log_rest = player createDiaryRecord ["Diary", ["Fast Traveling","Its possible to quicktravel to any friendly camp, guardpost or team-mate via Shift + 1"]];
_log_rest = player createDiaryRecord ["Diary", ["Crates as Truck Cargo","You are able to load crates to trucks (currently similar to the truck given during insertion, you can get new ones from villages). Move truck near the crate(s) and press SHIFT + 9 to get options to unload and load wanted crates"]];
//_log_rest = player createDiaryRecord ["Diary", ["Resting","(FOR TEAM-LEADER) You are able to skip time near captured camp, and created guardpost with tent, by clicking Shift + 3. Tired team-mates will get rested too<br/><br/><img image='rest.jpg' width='345' height='211'/>"]];
_log_rest = player createDiaryRecord ["Diary", ["Player Rights","(FOR TEAM-LEADER) Team-leader is able to grand rights for wanted players to have ability to use various custom key functions, by pressing Shift + 3"]];
_log_rest = player createDiaryRecord ["Diary", ["Map Commander","(FOR TEAM-LEADER) You are able to give orders for icon marked friendly teams seen on map by left clicking the icon and after that giving waypoint by click on map again with alt pressed down. Greek land teams need to stay near camp, later NATO teams are more free to move. FEATURE IS EARLY WORK IN PROGRESS"]];
_log_rest = player createDiaryRecord ["Diary", ["Support","(FOR TEAM-LEADER) Air, Land and Gear support can be called by pressing SHIFT + 1. Nearby friendlies may also come to help you if you throw smoke<br/><br/><img image='Support.jpg' width='384' height='234'/>"]];
_log_rest = player createDiaryRecord ["Diary", ["Timed Prestige Bonuses","To build guardposts, purchase support and other assests you need prestige. You need to capture factories, one powerplant and one pier to get full timed prestige bonus. If you hold storage area, you will get also 20% bonus. To capture area, you need to create guardpost near it with at least one guard team or static weapon. You can also get prestige from picked objects (Y) and certain completed tasks <br/><br/><img image='factory.jpg' width='400' height='254'/>"]];
if (side player == WEST) then {
_log_area = player createDiaryRecord ["Diary", ["Area Information","There are civilians living on the island. They share the villages with resistance soldiers, do your best to protect the locals without compromising the operation<br/><br/><img image='rela.jpg' width='384' height='236'/>"]];
_log_situation = player createDiaryRecord ["Diary", ["Situation","Situation on Altis is unclear, the last reports indicate Persian invasion. Greek have been unwilling to give us any intel yet, but is believed to prepare assault on the island to protect his army installations on the island. Our teams will be sent there to find our greek army friends or local resistance, prepare us to work together and report back to us. Time shows how your days pass there. Good luck!<br/><br/><img image='Situ.jpg' width='384' height='234'/>"]];
_log_briefing = player createDiaryRecord ["Diary", ["Briefing","Your team is dropped to unknown location on Altis. Get your men together, gather resources from houses, enable factories, piers and power plants. Use the gathered/received resources to build guardposts to protect our camps and important locations. Finally liberate the Altis by finding and capturing all flag marked persian camps<br/><br/><img image='house.jpg' width='346' height='233'/>"]];
} else {
_log_situation = player createDiaryRecord ["Diary", ["Situation","NATO is teaming with Greeks and trying to stop us taking the island. We need to teach them a lesson<br/><br/><img image='Situ.jpg' width='384' height='234'/>"]];
_log_briefing = player createDiaryRecord ["Diary", ["Briefing","Your team starts at unknown location on Altis. Get your men together, gather resources from houses and enable factories. Use the gathered/received resources to build guardposts to protect our camps and important locations. Lets drive those NATO guys back to sea (MORE FEATURES COMING SOON FOR PERSIAN SIDE)<br/><br/><img image='Situ.jpg' width='346' height='233'/>"]];
};
//<marker name='USBM1'>our camp</marker>

