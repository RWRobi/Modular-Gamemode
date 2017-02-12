#include <a_samp>
#include <a_mysql>
#include "../modules/variables.pwn"
#include "../modules/new_functions.pwn"

#define DIALOG_REGISTER_LANGUAGE 0
#define DIALOG_REGISTER 1
#define DIALOG_LOGIN 2
new SQLString[512];
stock CheckAccount(playerid)
{
    new name[MAX_PLAYER_NAME+1];
    GetPlayerName(playerid, name, sizeof(name));
    new noregistered = 0;
    mysql_format(SQL, SQLString, sizeof(SQLString), "SELECT * FROM `users` WHERE `name`='%s'",name);
    new Cache: select = mysql_query(SQL, SQLString);
    noregistered = cache_get_row_count();
    if(noregistered > 0)
    {
        new str[256];
        cache_get_field_content(0, "password",str); 
		format(PlayerPassword[playerid], 256, str);
    }
    cache_delete(select);
    new eninfo[256],roinfo[256];
    if(noregistered < 1)
    {
        ShowPlayerDialog(playerid, DIALOG_REGISTER_LANGUAGE, DIALOG_STYLE_MSGBOX, "Select Language", "Please select your language.\nTe rugam sa selectezi limba ta de vorbire.", "English", "Romana");
    }
    if(noregistered > 0)
    {
        format(eninfo, sizeof(eninfo), "Hi %s, this account is registered.\nPlease enter your choosen password.",name);
        format(roinfo, sizeof(roinfo), "Stimate %s, acest cont este inregistrat.\nTe rugam sa introduci parola aleasa de tine.",name);
        ShowPD(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Login", "Autentificare", eninfo, roinfo, "Login", "Autentificare", "Cancel", "Anuleaza");
    }
    return 1;
}