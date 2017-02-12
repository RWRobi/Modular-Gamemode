#include <a_samp>
#include "../modules/playervariables.pwn"
stock ResetPlayerVariables(playerid)
{
	PlayerLogged[playerid] = false;
	LRAttempts[playerid] = 0;
	PlayerPassword[playerid] = "";
	return 1;
}