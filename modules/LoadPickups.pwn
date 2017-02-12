#include <a_samp>
#include <streamer>
#include "../modules/colors.pwn"

stock LoadPickups()
{
	CreateDynamicPickup(1239, 23, 1777.3844,-1662.1129,14.4346, -1, -1,-1,100.0); //Uber /enter
	CreateDynamicPickup(1239, 23, 1494.3469,1303.9866,1093.2891, -1, -1,-1,100.0); //Uber /exit
	CreateDynamicPickup(1239, 23, 1494.0702,1308.1145,1093.2881, -1, -1, -1, 100.0); //Uber /uberregister
	Load3DTexts();
}

stock Load3DTexts()
{
	CreateDynamic3DTextLabel("{FFFFFF}Uber Headquerters\n type {FF0000}/enter",COLOR_YELLOW_DIALOG,1777.3844,-1662.1129,14.4346,3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 100.0); //Uber /enter
	CreateDynamic3DTextLabel("{FFFFFF}Uber Headquerters\n type {FF0000}/exit",COLOR_YELLOW_DIALOG,1494.3469,1303.9866,1093.2891,3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 100.0); //Uber /exit
	CreateDynamic3DTextLabel("{FFFFFF}Uber Registration\n type {FF0000}/uberregister",COLOR_YELLOW_DIALOG,1494.0702,1308.1145,1093.2881,3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 100.0); //Uber /uberregister
}