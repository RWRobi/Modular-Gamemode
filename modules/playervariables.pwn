#include <a_samp>
// Player - Variables
new bool:PlayerLogged[MAX_PLAYERS];
new LRAttempts[MAX_PLAYERS];
new PlayerPassword[MAX_PLAYERS][128];
// Player - Enum
enum PInfo
{
	pSQLID,
	pName[32],
	pLanguage,
	pUberActive,
}
new PlayerInfo[MAX_PLAYERS][PInfo];
