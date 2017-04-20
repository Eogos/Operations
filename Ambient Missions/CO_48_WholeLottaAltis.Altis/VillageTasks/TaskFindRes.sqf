//CONVERSATION
_head = "I see you are here to help. There is one man sitting in holding cell. He might be able to help you - I mark it in your map, watch out for persians";
_toChoose = ["Thank you, civilian"];
_nul = [_head, _toChoose] SPAWN FConversationDialog;
waitUntil {sleep 0.5; scriptdone _nul};

[player,"TaskFindRes",false,false] spawn BIS_fnc_MP;