#include <a_samp>
#include "../modules/playervariables.pwn"
new SQLStringg[512];
stock LoadAccount(playerid)
{
    new name[MAX_PLAYER_NAME+1],rezultat[256];
    GetPlayerName(playerid, name, sizeof(name));
    mysql_format(SQL, SQLStringg, sizeof(SQLStringg), "SELECT * FROM `users` WHERE `name`='%s'",name);
    new Cache: loadaccount = mysql_query(SQL, SQLStringg);
   
	PlayerInfo[playerid][pSQLID] = cache_get_field_content_int(0, "ID");
	PlayerInfo[playerid][pLanguage] = cache_get_field_content_int(0, "Language");
	cache_get_field_content(0, "name", rezultat); format(PlayerInfo[playerid][pName], MAX_PLAYER_NAME+1, rezultat);
	PlayerInfo[playerid][pUberActive] = cache_get_field_content_int(0, "UberDriver");
	cache_delete(loadaccount);
	PlayerLogged[playerid] = true;
	SpawnPlayer(playerid);
    
    return 1;
}
