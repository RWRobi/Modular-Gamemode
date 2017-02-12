#include <a_samp>
#include <a_mysql>
#include "../modules/variables.pwn"
#include "../modules/resetvariables.pwn"
#include "../modules/Register.pwn"
#include "../modules/Login.pwn"
#include "../modules/LoadPickups.pwn"
#include "../modules/colors.pwn"
#include "../modules/commands.pwn"
#include <zcmd>

main()
{
	print("\n----------------------------------");
	print(" B R I G A D A   S C R I P T E R I L O R!");
	print("----------------------------------\n");
}

public OnGameModeInit()
{
	SQL = mysql_connect("localhost", "root", "samp", "");
	mysql_log(LOG_ERROR | LOG_WARNING);
	if(mysql_errno(SQL) != 0) { printf("Database connection problem"); } else { printf("Database connection successfully"); }
	DisableInteriorEnterExits();
	AllowInteriorWeapons(1);
	UsePlayerPedAnims();
	SetGameModeText("FKPL Gamemode");
	AddPlayerClass(250, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	LoadPickups();
	return 1;
}

public OnGameModeExit()
{
	mysql_close(SQL);
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);
	CheckAccount(playerid);
	return 1;
}

public OnPlayerConnect(playerid)
{
	ResetPlayerVariables(playerid);
	return 1;
}
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case DIALOG_REGISTER_LANGUAGE:
		{
			if(response) { PlayerInfo[playerid][pLanguage] = 0; }
			if(!response) { PlayerInfo[playerid][pLanguage] = 1; }
			new eninfo[256],roinfo[256],name[MAX_PLAYER_NAME+1];
			GetPlayerName(playerid, name, sizeof(name));
			format(eninfo, sizeof(eninfo), "Hi %s, you don't have an account.\nPlease enter a strong password for your account.",name);
			format(roinfo, sizeof(roinfo), "Stimate %s, nu ai un cont inregistrat.\nTe rugam sa introduci o parola puternica pentru contul tau.",name);
			ShowPD(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "Account register", "Inregistrare cont", eninfo, roinfo, "Register", "Inregistrare", "Cancel", "Anuleaza");
		}
		case DIALOG_REGISTER:
		{
			if(!response) return Kick(playerid);
			new name[MAX_PLAYER_NAME+1];
			GetPlayerName(playerid, name, sizeof(name));
			if(LRAttempts[playerid] == 3) return Kick(playerid);
			if(isnull(inputtext) || strlen(inputtext) < 3)
			{
				new eninfo[256],roinfo[256];
				format(eninfo, sizeof(eninfo), "Hi %s, you don't have an account.\nPlease enter a strong password for your account.",name);
				format(roinfo, sizeof(roinfo), "Stimate %s, nu ai un cont inregistrat.\nTe rugam sa introduci o parola puternica pentru contul tau.",name);
				ShowPD(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "Account register", "Inregistrare cont", eninfo, roinfo, "Register", "Inregistrare", "Cancel", "Anuleaza");
				format(eninfo, sizeof(eninfo), "Password must contain minimum 3 characters, %d/3 attempts.", LRAttempts[playerid]+1);
				format(roinfo, sizeof(roinfo), "Parola ta trebuie sa contina minim 3 caractere, %d/3 incercari.", LRAttempts[playerid]+1);
				SM(playerid, -1, eninfo, roinfo);
				LRAttempts[playerid]++;
			}
			else
			{
				new sqlinsert[512];
				new password[128];
				mysql_escape_string(inputtext, password);
				mysql_format(SQL,sqlinsert,sizeof(sqlinsert),"INSERT INTO `users` (`name`,`password`,`Language`) VALUES ('%s','%s','%d')",name,password,PlayerInfo[playerid][pLanguage]);
				mysql_tquery(SQL,sqlinsert,"","");
				SM(playerid, -1, "Your account is now registered.", "Contul tau este acum inregistrat.");
				new eninfo[256],roinfo[256];
				format(eninfo, sizeof(eninfo), "Hi %s, this account is registered.\nPlease enter your choosen password.",name);
				format(roinfo, sizeof(roinfo), "Stimate %s, acest cont este inregistrat.\nTe rugam sa introduci parola aleasa de tine.",name);
				ShowPD(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Login", "Autentificare", eninfo, roinfo, "Login", "Autentificare", "Cancel", "Anuleaza");
				format(PlayerPassword[playerid], 128, password);
			}
		}
		case DIALOG_LOGIN:
		{
			if(!response) return Kick(playerid);
			new name[MAX_PLAYER_NAME+1];
			GetPlayerName(playerid, name, sizeof(name));
			if(LRAttempts[playerid] == 3) return Kick(playerid);
			new succes = 0;
			if(strcmp(inputtext, PlayerPassword[playerid], true) == 0) { succes = 1; }
			if(isnull(inputtext) || succes == 0)
			{
				new eninfo[256],roinfo[256];
				format(eninfo, sizeof(eninfo), "Hi %s, this account is registered.\nPlease enter your choosen password.",name);
				format(roinfo, sizeof(roinfo), "Stimate %s, acest cont este inregistrat.\nTe rugam sa introduci parola aleasa de tine.",name);
				ShowPD(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Login", "Autentificare", eninfo, roinfo, "Login", "Autentificare", "Cancel", "Anuleaza");
				format(eninfo, sizeof(eninfo), "Password is incorrect, %d/3 attempts.", LRAttempts[playerid]+1);
				format(roinfo, sizeof(roinfo), "Parola incorecta, %d/3 incercari.", LRAttempts[playerid]+1);
				SM(playerid, -1, eninfo, roinfo);
				LRAttempts[playerid]++;
			}
			if(succes == 1)
			{
				LoadAccount(playerid);
			}
		}
	}
	return 1;
}
public OnPlayerDisconnect(playerid, reason)
{
	ResetPlayerVariables(playerid);
	return 1;
}

public OnPlayerSpawn(playerid)
{
	if(PlayerLogged[playerid] == false)
		return Kick(playerid);
	SetPlayerPos(playerid, 1762.2994,-1672.4009,13.5607);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}

public OnPlayerCommandReceived(playerid, cmdtext[])
{
	if(PlayerLogged[playerid] == false)
	{
		SendClientMessage(playerid, COLOR_WHITE, "{FFFFCC}Error: You aren't logged in!");
		return 0;
	}
	return 1;
}

public OnPlayerCommandPerformed(playerid, cmdtext[], success)
{
	if(!success)
	{
		SendClientMessage(playerid, COLOR_WHITE, "{FFFFCC}Error: That command isn't recognized.");
	}
	else
	{
		printf("Player %s %s", PlayerInfo[playerid][pName], cmdtext);
		return 1;
	}
	return 1;
}

