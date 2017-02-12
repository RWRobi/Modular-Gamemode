#include <a_samp>
#include "../modules/playervariables.pwn"


stock ShowPD(playerid, dialogid, style, entitle[],rotitle[], eninfo[],roinfo[],enbutton1[],robutton1[],enbutton2[],robutton2[])
{
	if(PlayerInfo[playerid][pLanguage] == 0) // EN
	{
		ShowPlayerDialog(playerid, dialogid, style, entitle,eninfo,enbutton1,enbutton2);
	}
	if(PlayerInfo[playerid][pLanguage] == 1) // RO
	{
		ShowPlayerDialog(playerid, dialogid, style, rotitle,roinfo,robutton1,robutton2);
	}
	return 1;
}
stock SM(playerid, color, entext[], rotext[])
{
	if(PlayerInfo[playerid][pLanguage] == 0) // EN
	{
		SendClientMessage(playerid, color, entext);
	}
	if(PlayerInfo[playerid][pLanguage] == 1) // RO
	{
		SendClientMessage(playerid, color, rotext);
	}
	return 1;
}
#if !defined isnull
	#define isnull(%1) \
				((!(%1[0])) || (((%1[0]) == '\1') && (!(%1[1]))))
#endif