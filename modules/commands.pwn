#include <a_samp>
#include <zcmd>

#define PlayerToPoint(%0,%1,%2,%3,%4) IsPlayerInRangeOfPoint(%1,%0,%2,%3,%4)

CMD:enter(playerid, params[])
{
	if (PlayerToPoint(2.0, playerid, 1777.3844,-1662.1129,14.4346))
	{//Uber Headquarter
		SetPlayerPos(playerid, 1494.325195,1304.942871,1093.289062);
		SetPlayerInterior(playerid, 3);
	}
	return 1;
}

CMD:exit(playerid, params[])
{
	if (PlayerToPoint(2.0, playerid, 1494.325195,1304.942871,1093.289062))
	{//Uber Headquarter
		SetPlayerPos(playerid, 1777.3844,-1662.1129,14.4346);
		SetPlayerInterior(playerid, 0);
	}
	return 1;
}