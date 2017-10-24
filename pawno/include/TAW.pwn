// This is a comment
// uncomment the line below if you want to write a filterscript
//#define FILTERSCRIPT

#include <a_samp>
#include <zcmd>
#include <streamer>
#include <mtamap>
#include <IsPlayerNearPlayer>
#include <Dudb>
#include <float>
#pragma tabsize 0
#pragma unused ret_memcpy
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_RED 0xAA3333AA
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_PINK 0xFF66FFAA
#define COLOR_BLUE 0x0000BBAA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_DARKRED 0x660000AA
#define COLOR_ORANGE 0xFF9900AA
#define COLOR_BRIGHTRED 0xFF0000AA
#define COLOR_INDIGO 0x4B00B0AA
#define COLOR_VIOLET 0x9955DEEE
#define COLOR_LIGHTRED 0xFF99AADD
#define COLOR_SEAGREEN 0x00EEADDF
#define COLOR_GRAYWHITE 0xEEEEFFC4
#define COLOR_LIGHTNEUTRALBLUE 0xabcdef66
#define COLOR_GREENISHGOLD 0xCCFFDD56
#define COLOR_LIGHTBLUEGREEN 0x0FFDD349
#define COLOR_NEUTRALBLUE 0xABCDEF01
#define COLOR_LIGHTCYAN 0xAAFFCC33
#define COLOR_LEMON 0xDDDD2357
#define COLOR_MEDIUMBLUE 0x63AFF00A
#define COLOR_NEUTRAL 0xABCDEF97
#define COLOR_BLACK 0x00000000
#define COLOR_NEUTRALGREEN 0x81CFAB00
#define COLOR_DARKGREEN 0x12900BBF
#define COLOR_LIGHTGREEN 0x24FF0AB9
#define COLOR_DARKBLUE 0x300FFAAB
#define COLOR_BLUEGREEN 0x46BBAA00
#define COLOR_PINK 0xFF66FFAA
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_DARKRED 0x660000AA
#define COLOR_ORANGE 0xFF9900AA
#define COLOR_PURPLE 0x800080AA
#define COLOR_GRAD1 0xB4B5B7FF
#define COLOR_GRAD2 0xBFC0C2FF
#define COLOR_RED1 0xFF0000AA
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_BROWN 0x993300AA
#define COLOR_CYAN 0x99FFFFAA
#define COLOR_TAN 0xFFFFCCAA
#define COLOR_PINK 0xFF66FFAA
#define COLOR_KHAKI 0x999900AA
#define COLOR_LIME 0x99FF00AA
#define COLOR_SYSTEM 0xEFEFF7AA
#define COLOR_GRAD2 0xBFC0C2FF
#define COLOR_GRAD4 0xD8D8D8FF
#define COLOR_GRAD6 0xF0F0F0FF
#define COLOR_GRAD2 0xBFC0C2FF
#define COLOR_GRAD3 0xCBCCCEFF
#define COLOR_GRAD5 0xE3E3E3FF
#define COLOR_GRAD1 0xB4B5B7FF

new gPlayerClass[MAX_PLAYERS];
new gTeam[MAX_PLAYERS];
new PickedClass[MAX_PLAYERS] = 0;
#define MEC 1
#define USMC 2
#define USMC_COLOUR 0x0000BBAA
#define MEC_COLOUR 0xFF9900AA
//Middle Eastern Coalition
#define AS_CLASS 1
#define MEDIC_CLASS 2
#define SNIPER_CLASS 3
#define ANTI_CLASS 4
#define ENGINEER_CLASS 5
#define TEAM_NONE       6 //Ignore if you already got team defines
#define invisible 0xFFFFFF00
//Colors
#define COLOR_USMC 0x0000BBAA
#define COLOR_MEC 0xFF9900AA
#define crash 0
#define bigear 1
#define otm 2
#define qry 3
#define oil 4
#define qa 5
#define dam 6
#define ct 7
new KillerID[MAX_PLAYERS];
new bool: PlayerDied[MAX_PLAYERS];
new tCP[30];
new UnderAttack[30] = 0;
new CP[30];
new Zone[30];
new Captured[MAX_PLAYERS][30];
new timer[MAX_PLAYERS][30];
new CountVar[MAX_PLAYERS][30];

new Died[MAX_PLAYERS], KilledBy[MAX_PLAYERS];
new Text:CountText[MAX_PLAYERS];
new IsPlayerCapturing[MAX_PLAYERS][30];
#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Blank Filterscript by your name here");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

#else

main()
{
	print("\n----------------------------------");
	print(" Battlefield Of Triangle War ");
	print("----------------------------------\n");
}

#endif
	new GZ_ZONE1;
	new GZ_ZONE2;

public OnGameModeInit()
{
	#include <wot>

	// Don't use these lines if it's a filterscript
	//SetGameModeText("BF2-SAMP OCS");
	AddPlayerClass(217,-540.1771,2582.8931,53.4141,286.3332,0,0,0,0,0,0); //MEC
	AddPlayerClass(287,83.7808,35.2018,0.6094,118.9501,0,0,0,0,0,0); // soldier USMC
//	SetTimer("hostname",5000,1);//<<< You can change the ammount of time the hostname stays till it changes(1000 = 1 second)
    SetGameModeText("Conquest-TDM");
GZ_ZONE1 = GangZoneCreate(-109.375,-132.8125,398.4375,531.25);

	GZ_ZONE2 = GangZoneCreate(-632.8125,2378.90625,515.625,2664.0625);

	
    UsePlayerPedAnims();
	EnableStuntBonusForAll(0);


	
	//
tCP[crash] = TEAM_NONE;    
UnderAttack[crash] = 0;    
Zone[crash] = GangZoneCreate(-62.5000000000005,1308.59375,62.5,1421.875);
CP[crash] = CreateDynamicCP(-8.4285,1392.1359,9.1719,4, -1, -1, -1, 100.0);

//
tCP[bigear] = TEAM_NONE;
UnderAttack[bigear] = 0;
Zone[bigear] = GangZoneCreate(-451.171875,1297.8515625,-149.4140625,1658.203125);
CP[bigear] = CreateDynamicCP(-766.5881,1602.8511,27.1172,4, -1, -1, -1, 100.0);

tCP[otm] = TEAM_NONE;
UnderAttack[otm] = 0;
Zone[otm] = GangZoneCreate(-914.0625,1374.0234375,-559.5703125,1631.8359375);
CP[otm] = CreateDynamicCP(-313.3014,1539.5867,75.5625,4, -1, -1, -1, 100.0);

tCP[qry] = TEAM_NONE;
UnderAttack[qry] = 0;
Zone[qry] = GangZoneCreate(380.859375,682.6171875,922.8515625,1028.3203125);
CP[qry] = CreateDynamicCP(602.5327,884.1660,-43.3971,4, -1, -1, -1, 100.0);

tCP[oil] = TEAM_NONE;
UnderAttack[oil] = 0;
Zone[oil] = GangZoneCreate(90.8203125,1341.796875,290.0390625,1491.2109375);
CP[oil] = CreateDynamicCP(217.8039,1404.9268,10.5859,4, -1, -1, -1, 100.0);

tCP[qa] = TEAM_NONE;
UnderAttack[qa] = 0;
Zone[qa] = GangZoneCreate(-79.1015625,1470.703125,84.9609375,1558.59375);
CP[qa] = CreateDynamicCP(23.7605,1519.6274,12.7560,4, -1, -1, -1, 100.0);

tCP[dam] = TEAM_NONE;
UnderAttack[dam] = 0;
Zone[dam] = GangZoneCreate(-943.359375,1968.75,-568.359375,2144.53125);
CP[dam] = CreateDynamicCP(-894.7407,1992.7888,60.8965,4, -1, -1, -1, 100.0);

tCP[ct] = TEAM_NONE;
UnderAttack[ct] = 0;
Zone[ct] = GangZoneCreate(506.8359375,1608.3984375,738.28125,1778.3203125);
CP[ct] = CreateDynamicCP(653.5560,1726.4774,6.9922,4, -1, -1, -1, 100.0);

	return 1;
}
//

//

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerTeamFromClass(playerid, classid);

    
	return 1;
}
forward SetPlayerTeamFromClass(playerid, classid);
SetPlayerTeamFromClass(playerid, classid)
{
	if(classid == 0)
	{
	gTeam[playerid] = MEC;

	GameTextForPlayer(playerid,"~g~Middle-Eastern-Coalition",1000,3);
	SetPlayerPos(playerid, 219.4065,1822.6654,7.5236);
	SetPlayerFacingAngle(playerid,268.9849);
	SetPlayerCameraPos(playerid, 226.4905,1822.8358,7.4141);
	SetPlayerCameraLookAt(playerid, 222.4905,1822.8358,7.4141);
	GivePlayerWeapon(playerid,30,1);
	ApplyAnimation(playerid, "SHOP", "SHP_Gun_Aim", 4.0, 0, 1, 1, 1, -1);
	
	}
	if(classid == 1)
	{
	gTeam[playerid] = USMC;
	GameTextForPlayer(playerid,"~b~United-States-Marine-Cops",1000,3);
	SetPlayerPos(playerid, 219.4065,1822.6654,7.5236);
	SetPlayerFacingAngle(playerid,268.9849);
	SetPlayerCameraPos(playerid, 226.4905,1822.8358,7.4141);
	SetPlayerCameraLookAt(playerid, 222.4905,1822.8358,7.4141);
	GivePlayerWeapon(playerid,31,1);
	ApplyAnimation(playerid, "SHOP", "SHP_Gun_Aim", 4.0, 0, 1, 1, 1, -1);
	
	}
}
forward SetPlayerToTeamColour(playerid);
SetPlayerToTeamColour(playerid)
{
	if(gTeam[playerid] == MEC)
	{
	    SetPlayerColor(playerid,COLOR_ORANGE);
	}
	if(gTeam[playerid] == USMC)
	{
	    SetPlayerColor(playerid,COLOR_BLUE);
	}
}

public OnPlayerConnect(playerid)
{
	#include <wotremove>
	GameTextForPlayer(playerid,"~y~Welcome~p~-to-~r~BattleField ~g~of~y~|~w~Triangle",2000,1);
	SendClientMessage(playerid,COLOR_GREEN,"Please Register/Login");
	GangZoneShowForPlayer(playerid,GZ_ZONE1, 0x0000FFAA);
GangZoneShowForPlayer(playerid,GZ_ZONE2, 0xFF8000AA);
	//
SetPlayerMapIcon(playerid, 2, -8.4285,1392.1359,9.1719, 19, MAPICON_GLOBAL);    
SetPlayerMapIcon(playerid, 3, -313.3014,1539.5867,75.5625, 19, MAPICON_GLOBAL);
SetPlayerMapIcon(playerid, 4, -766.5881,1602.8511,27.1172, 19, MAPICON_GLOBAL);
SetPlayerMapIcon(playerid, 5, 602.5327,884.1660,-43.3971, 19, MAPICON_GLOBAL);
SetPlayerMapIcon(playerid, 6, 217.8039,1404.9268,10.5859, 19, MAPICON_GLOBAL);
SetPlayerMapIcon(playerid, 7, 23.7605,1519.6274,12.7560, 19, MAPICON_GLOBAL);
SetPlayerMapIcon(playerid, 8, -894.7407,1992.7888,60.8965, 19, MAPICON_GLOBAL);
SetPlayerMapIcon(playerid, 9, 653.5560,1726.4774,6.9922, 19, MAPICON_GLOBAL);
//GangZoneShowForAll(Zone[crash], 0x00000043);
//IsPlayerCapturing[playerid][crash] = 0;
//CountVar[playerid][crash] = 25;
if(tCP[crash] == TEAM_NONE) GangZoneShowForPlayer(playerid,Zone[crash], -66);    
else if(tCP[crash] == MEC) GangZoneShowForPlayer(playerid,Zone[crash],COLOR_MEC);    
else if(tCP[crash] == USMC) GangZoneShowForPlayer(playerid,Zone[crash], COLOR_USMC);
//
if(tCP[bigear] == TEAM_NONE) GangZoneShowForPlayer(playerid,Zone[bigear], -66);
else if(tCP[bigear] == MEC) GangZoneShowForPlayer(playerid,Zone[bigear],COLOR_MEC);
else if(tCP[bigear] == USMC) GangZoneShowForPlayer(playerid,Zone[bigear], COLOR_USMC);
//
//
if(tCP[otm] == TEAM_NONE) GangZoneShowForPlayer(playerid,Zone[otm], -66);
else if(tCP[otm] == MEC) GangZoneShowForPlayer(playerid,Zone[otm],COLOR_MEC);
else if(tCP[otm] == USMC) GangZoneShowForPlayer(playerid,Zone[otm], COLOR_USMC);
//
//
if(tCP[qry] == TEAM_NONE) GangZoneShowForPlayer(playerid,Zone[qry], -66);
else if(tCP[qry] == MEC) GangZoneShowForPlayer(playerid,Zone[qry],COLOR_MEC);
else if(tCP[qry] == USMC) GangZoneShowForPlayer(playerid,Zone[qry], COLOR_USMC);
//
if(tCP[oil] == TEAM_NONE) GangZoneShowForPlayer(playerid,Zone[oil], -66);
else if(tCP[oil] == MEC) GangZoneShowForPlayer(playerid,Zone[oil],COLOR_MEC);
else if(tCP[oil] == USMC) GangZoneShowForPlayer(playerid,Zone[oil], COLOR_USMC);
//
//
if(tCP[qa] == TEAM_NONE) GangZoneShowForPlayer(playerid,Zone[qa], -66);
else if(tCP[qa] == MEC) GangZoneShowForPlayer(playerid,Zone[qa],COLOR_MEC);
else if(tCP[qa] == USMC) GangZoneShowForPlayer(playerid,Zone[qa], COLOR_USMC);
//
//
if(tCP[dam] == TEAM_NONE) GangZoneShowForPlayer(playerid,Zone[dam], -66);
else if(tCP[dam] == MEC) GangZoneShowForPlayer(playerid,Zone[dam],COLOR_MEC);
else if(tCP[dam] == USMC) GangZoneShowForPlayer(playerid,Zone[dam], COLOR_USMC);
//
//
if(tCP[ct] == TEAM_NONE) GangZoneShowForPlayer(playerid,Zone[ct], -66);
else if(tCP[ct] == MEC) GangZoneShowForPlayer(playerid,Zone[ct],COLOR_MEC);
else if(tCP[ct] == USMC) GangZoneShowForPlayer(playerid,Zone[ct], COLOR_USMC);
//
Died[playerid] = -1;    
KilledBy[playerid] = -1;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{

if(Captured[playerid][crash] == 0 && IsPlayerCapturing[playerid][crash] == 1)    
{    
	Leavingcrash(playerid);    
}
if(Captured[playerid][bigear] == 0 && IsPlayerCapturing[playerid][bigear] == 1)
{
	Leavingbigear(playerid);
}
if(Captured[playerid][otm] == 0 && IsPlayerCapturing[playerid][otm] == 1)
{
	Leavingotm(playerid);
}
if(Captured[playerid][qry] == 0 && IsPlayerCapturing[playerid][qry] == 1)
{
	Leavingqry(playerid);
}
if(Captured[playerid][oil] == 0 && IsPlayerCapturing[playerid][oil] == 1)
{
	Leavingoil(playerid);
}
if(Captured[playerid][qa] == 0 && IsPlayerCapturing[playerid][qa] == 1)
{
	Leavingqa(playerid);
}
if(Captured[playerid][dam] == 0 && IsPlayerCapturing[playerid][dam] == 1)
{
	Leavingdam(playerid);
}
if(Captured[playerid][ct] == 0 && IsPlayerCapturing[playerid][ct] == 1)
{
	Leavingct(playerid);
}
GangZoneDestroy(GZ_ZONE1);
GangZoneDestroy(GZ_ZONE2);
Died[playerid] = 0;    
KilledBy[playerid] = 0;
return 1;
}


public OnPlayerSpawn(playerid)
{
          

    SetPlayerToTeamColour(playerid);

    SetPlayerHealth(playerid, 1000000.0);
    if(PickedClass[playerid] == 1)
    {
    SendClientMessage(playerid, COLOR_GREY, "[SERVER]:You have 5 seconds of Anti-Spawnkill protection");
    SetPlayerChatBubble(playerid, "[SERVER]:Anti-Spawnkill protected player", 0xFF0000AA, 100.0, 10000);
    SetTimerEx("AntiSpawnkill",5000,0,"i",playerid);
    }

    //
    SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL, 999);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL_SILENCED, 999);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_DESERT_EAGLE, 999);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_SHOTGUN, 999);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_SAWNOFF_SHOTGUN, 999);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_SPAS12_SHOTGUN, 999);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_MICRO_UZI,999);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_MP5,999);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_AK47,999);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_M4,999);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_SNIPERRIFLE,999);
//
	if(gTeam[playerid] == MEC)
	{
	SetPlayerTeam(playerid,0);
    if(gPlayerClass[playerid] == AS_CLASS)
    {
	GivePlayerWeapon(playerid,30,560);
	GivePlayerWeapon(playerid,22,50);
	GivePlayerWeapon(playerid,4,1);
	GivePlayerWeapon(playerid,39,5);
	GivePlayerWeapon(playerid,40,1);

    }
    if(gPlayerClass[playerid] == MEDIC_CLASS)
    {
	GivePlayerWeapon(playerid,28,400);
	GivePlayerWeapon(playerid,24,50);
	GivePlayerWeapon(playerid,4,1);
	GivePlayerWeapon(playerid,26,30);
	SendClientMessage(playerid, COLOR_GREEN,"You Can Drop Health by /dheal");

    }
    if(gPlayerClass[playerid] == SNIPER_CLASS)
    {
	GivePlayerWeapon(playerid,34,160);
	GivePlayerWeapon(playerid,23,50);
	GivePlayerWeapon(playerid,4,1);
	GivePlayerWeapon(playerid,41,60);
	SendClientMessage(playerid, COLOR_GREEN,"You Can stealth by /(un)stealth");
    }
    if(gPlayerClass[playerid] == ANTI_CLASS)
    {
	GivePlayerWeapon(playerid,32,450);
	GivePlayerWeapon(playerid,22,50);
	GivePlayerWeapon(playerid,4,1);
	GivePlayerWeapon(playerid,39,10);
	GivePlayerWeapon(playerid,40,1);

    }
    if(gPlayerClass[playerid] == ENGINEER_CLASS)
    {
	GivePlayerWeapon(playerid,27,400);
	GivePlayerWeapon(playerid,24,50);
	GivePlayerWeapon(playerid,4,1);
	GivePlayerWeapon(playerid,36,10);

    }
    }
    if(gTeam[playerid] == USMC)
	{
		SetPlayerTeam(playerid,1);
    if(gPlayerClass[playerid] == AS_CLASS)
    {
	GivePlayerWeapon(playerid,31,560);
	GivePlayerWeapon(playerid,22,50);
	GivePlayerWeapon(playerid,4,1);
	GivePlayerWeapon(playerid,39,5);
	GivePlayerWeapon(playerid,40,1);

    }
    if(gPlayerClass[playerid] == MEDIC_CLASS)
    {
	GivePlayerWeapon(playerid,29,400);
	GivePlayerWeapon(playerid,24,50);
	GivePlayerWeapon(playerid,4,1);
	GivePlayerWeapon(playerid,26,30);

    }
    if(gPlayerClass[playerid] == SNIPER_CLASS)
    {
	GivePlayerWeapon(playerid,34,160);
	GivePlayerWeapon(playerid,23,50);
	GivePlayerWeapon(playerid,4,1);
	GivePlayerWeapon(playerid,42,60);
    }
    if(gPlayerClass[playerid] == ANTI_CLASS)
    {
	GivePlayerWeapon(playerid,32,450);
	GivePlayerWeapon(playerid,22,50);
	GivePlayerWeapon(playerid,4,1);
	GivePlayerWeapon(playerid,39,10);
	GivePlayerWeapon(playerid,40,1);

    }
    if(gPlayerClass[playerid] == ENGINEER_CLASS)
	{
	GivePlayerWeapon(playerid,29,400);
	GivePlayerWeapon(playerid,24,50);
	GivePlayerWeapon(playerid,4,1);
	GivePlayerWeapon(playerid,36,10);

    }
}




	return 1;
}

new pickup_Health;
forward AntiSpawnkill(playerid);
public AntiSpawnkill(playerid)
{
    SetPlayerHealth(playerid, 100.0);
    SendClientMessage(playerid, COLOR_RED, "[SERVER]:Anti-Spawnkill protection over, you are on your own now");
    return 1;
}
forward spawn(playerid);
public spawn (playerid)
{
	SpawnPlayer(playerid);
return 1;
}
public OnPlayerDeath(playerid, killerid, reason)
{
	

    SendDeathMessage(killerid, playerid, reason);
 	GameTextForPlayer(playerid,"~r~You Were Killed ~g~Respawning ~y~..",5000,3);
   //SetTimerEx("spawn",800,0,"i",playerid);
	
if(Captured[playerid][crash] == 0 && IsPlayerCapturing[playerid][crash] == 1)        
{        
	Leavingcrash(playerid);        
	}
if(Captured[playerid][bigear] == 0 && IsPlayerCapturing[playerid][bigear] == 1)
{
	Leavingbigear(playerid);
	}
   if(Captured[playerid][otm] == 0 && IsPlayerCapturing[playerid][otm] == 1)
{
	Leavingotm(playerid);
	}
	 if(Captured[playerid][qry] == 0 && IsPlayerCapturing[playerid][qry] == 1)
{
	Leavingqry(playerid);
	}
	if(Captured[playerid][oil] == 0 && IsPlayerCapturing[playerid][oil] == 1)
{
	Leavingoil(playerid);
	}
	if(Captured[playerid][qa] == 0 && IsPlayerCapturing[playerid][qa] == 1)
{
	Leavingqa(playerid);
	}
		if(Captured[playerid][dam] == 0 && IsPlayerCapturing[playerid][dam] == 1)
{
	Leavingdam(playerid);
	}
	if(Captured[playerid][ct] == 0 && IsPlayerCapturing[playerid][ct] == 1)
{
	Leavingct(playerid);
	}
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

public OnPlayerCommandText(playerid, cmdtext[])
{

	return 0;
}
CMD:stealth(playerid, params[])
{
	if(gPlayerClass[playerid] == SNIPER_CLASS)
	{
		 for(new i = 0; i < MAX_PLAYERS; i++) ShowPlayerNameTagForPlayer(playerid, i, false);
    GameTextForPlayer(playerid, "~W~Nametags ~R~off", 5000, 5);
for(new i=0; i<MAX_PLAYERS; i++)
{
if(gTeam[playerid] !=gTeam[i])
{
   SetPlayerMarkerForPlayer(playerid, i, GetPlayerColor(playerid) & invisible);
}
}
	}
return 1;
}
CMD:unstealth(playerid, params[])
{
	if(gPlayerClass[playerid] == SNIPER_CLASS)
	{
		 for(new i = 0; i < MAX_PLAYERS; i++) ShowPlayerNameTagForPlayer(playerid, i, true);
    GameTextForPlayer(playerid, "~W~Nametags ~R~on", 5000, 5);
    for(new i=0; i<MAX_PLAYERS; i++)
{

   SetPlayerMarkerForPlayer(playerid, i, GetPlayerColor(playerid));

}
	}
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

public OnPlayerEnterCheckpoint(playerid) // If the player enters a particluar checkpoint
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
  ClearAnimations(playerid);
	menuload(playerid);
	return 1;
}
forward menuload(playerid);
public menuload(playerid)
{
ShowPlayerDialog(playerid, 1, DIALOG_STYLE_LIST, "Select-Classes", "Assault\nMedic\nSniper\nAnti-Vehicle\nEngineer", "Select", "Cancel");
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
	if(pickupid == pickup_Health)
    {
		
       
    

		
			 SetPlayerHealth(playerid, 100.0);
			DestroyPickup(pickup_Health);
		
		
		
	}
    

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
CMD:dheal(playerid, params[])
{
if(gPlayerClass[playerid] == MEDIC_CLASS)
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
 	pickup_Health = CreatePickup(1240, 8, x-3, y, z, GetPlayerVirtualWorld(playerid));


}
return 1;
}
CMD:kill(playerid, params[])
{
	SetPlayerHealth(playerid,0);
return 1;
}


public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
/*
	for(new i=0; i<MAX_PLAYERS; i++)
{
if(gTeam[playerid] == MEC)
{
   SetPlayerMarkerForPlayer(playerid, i, GetPlayerColor(playerid) & invisible);
}
else if(gTeam[playerid] == USMC)
{
   SetPlayerMarkerForPlayer(playerid, i, GetPlayerColor(playerid) & invisible);
}
}*/
for(new i=0; i<MAX_PLAYERS; i++)
{
	if(IsPlayerNearPlayer(playerid,i,3))
	{
		if(gTeam[i] == gTeam[playerid] && gPlayerClass[playerid] == MEDIC_CLASS)
		{
		    if(gPlayerClass[i] != MEDIC_CLASS)
		    {
			SetPlayerHealth(i, 100.0);
			GameTextForPlayer(i,"~g~You neared Medic ~p~You got heal ~r~from ~y~Medic ",3000,3);
			}
		}
	}
}
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
CMD:cclass(playerid, params[])

		{

        ShowPlayerDialog(playerid, 1, DIALOG_STYLE_LIST, "Classes", "Assault\nMedic\nSniper\nAnti-Vehicle\nEngineer", "Select", "Cancel");
        SetPlayerHealth(playerid,0);
		return 1;

		}
		
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == 1)
			{
			    if(response)
			    	{
                        SendClientMessage(playerid, COLOR_WHITE, "You Selected as Assault Unit");
                        SendClientMessage(playerid, COLOR_WHITE, "You can change class by /cclass");
                        gPlayerClass[playerid] = AS_CLASS;
                        PickedClass[playerid] = 1;
        				SetPlayerVirtualWorld(playerid, 0);
        				TogglePlayerControllable(playerid, 1);
        				SpawnPlayer(playerid);
						}


                if(listitem == 1)//sniper DONE
			        {

                        SendClientMessage(playerid, COLOR_WHITE, "You Selected as Medic Unit");
                        SendClientMessage(playerid, COLOR_WHITE, "You can change class by /cclass");
                        gPlayerClass[playerid] = MEDIC_CLASS;
                        PickedClass[playerid] = 1;
        				SetPlayerVirtualWorld(playerid, 0);
        				TogglePlayerControllable(playerid, 1);
                       	SpawnPlayer(playerid);
					}
				if(listitem == 2)//sniper DONE
			        {

                        SendClientMessage(playerid, COLOR_WHITE, "You Selected as Sniper Unit");
                        SendClientMessage(playerid, COLOR_WHITE, "You can change class by /cclass");
                        SendClientMessage(playerid, COLOR_WHITE, "You can stealth and unsteath by (un)stealth");
                        gPlayerClass[playerid] = SNIPER_CLASS;
                        PickedClass[playerid] = 1;
        				SetPlayerVirtualWorld(playerid, 0);
        				TogglePlayerControllable(playerid, 1);
						SpawnPlayer(playerid);
					}
				if(listitem == 3)//sniper DONE
			        {

                        SendClientMessage(playerid, COLOR_WHITE, "You Selected as Anti-Vehicle Unit");
                        SendClientMessage(playerid, COLOR_WHITE, "You can change class by /cclass");
                        gPlayerClass[playerid] = ANTI_CLASS;
                        PickedClass[playerid] = 1;
        				SetPlayerVirtualWorld(playerid, 0);
        				TogglePlayerControllable(playerid, 1);
                        SpawnPlayer(playerid);
					}
				if(listitem == 4)//sniper DONE
			        {

                        SendClientMessage(playerid, COLOR_WHITE, "You Selected as Engineer Unit");
                        SendClientMessage(playerid, COLOR_WHITE, "You can change class by /cclass");
                        gPlayerClass[playerid] = ENGINEER_CLASS;
                        PickedClass[playerid] = 1;
        				SetPlayerVirtualWorld(playerid, 0);
        				TogglePlayerControllable(playerid, 1);
                        SpawnPlayer(playerid);
					}
                       
			}
				
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}
forward OnPlayerEnterDynamicCP(playerid, checkpointid);
public OnPlayerEnterDynamicCP(playerid, checkpointid)
{    
	if(checkpointid == CP[crash])    
	{        
		if(UnderAttack[crash] == 0)        
		{            
			if(tCP[crash] != gTeam[playerid])            
			{       CountVar[playerid][crash] = 25;                
					Activecrash(playerid);            
			} else return SendClientMessage(playerid, COLOR_RED,"*This zone is already captured by your team!");        
		} else return CaptureZoneMessage(playerid, 2);    
	}
	if(checkpointid == CP[bigear])
	{
		if(UnderAttack[bigear] == 0)
		{
			if(tCP[bigear] != gTeam[playerid])
			{       CountVar[playerid][bigear] = 25;
					Activebigear(playerid);
			} else return SendClientMessage(playerid, COLOR_RED,"*This zone is already captured by your team!");
		} else return CaptureZoneMessage(playerid, 2);
	}
	if(checkpointid == CP[otm])
	{
		if(UnderAttack[otm] == 0)
		{
			if(tCP[otm] != gTeam[playerid])
			{       CountVar[playerid][otm] = 25;
					Activeotm(playerid);
			} else return SendClientMessage(playerid, COLOR_RED,"*This zone is already captured by your team!");
		} else return CaptureZoneMessage(playerid, 2);
	}
	if(checkpointid == CP[qry])
	{
		if(UnderAttack[qry] == 0)
		{
			if(tCP[qry] != gTeam[playerid])
			{       CountVar[playerid][qry] = 25;
					Activeqry(playerid);
			} else return SendClientMessage(playerid, COLOR_RED,"*This zone is already captured by your team!");
		} else return CaptureZoneMessage(playerid, 2);
	}
	if(checkpointid == CP[oil])
	{
		if(UnderAttack[oil] == 0)
		{
			if(tCP[oil] != gTeam[playerid])
			{       CountVar[playerid][oil] = 25;
					Activeoil(playerid);
			} else return SendClientMessage(playerid, COLOR_RED,"*This zone is already captured by your team!");
		} else return CaptureZoneMessage(playerid, 2);
	}
	if(checkpointid == CP[qa])
	{
		if(UnderAttack[qa] == 0)
		{
			if(tCP[qa] != gTeam[playerid])
			{       CountVar[playerid][qa] = 25;
					Activeqa(playerid);
			} else return SendClientMessage(playerid, COLOR_RED,"*This zone is already captured by your team!");
		} else return CaptureZoneMessage(playerid, 2);
	}
		if(checkpointid == CP[dam])
	{
		if(UnderAttack[dam] == 0)
		{
			if(tCP[dam] != gTeam[playerid])
			{       CountVar[playerid][dam] = 25;
					Activedam(playerid);
			} else return SendClientMessage(playerid, COLOR_RED,"*This zone is already captured by your team!");
		} else return CaptureZoneMessage(playerid, 2);
	}
	if(checkpointid == CP[ct])
	{
		if(UnderAttack[ct] == 0)
		{
			if(tCP[ct] != gTeam[playerid])
			{       CountVar[playerid][ct] = 25;
					Activect(playerid);
			} else return SendClientMessage(playerid, COLOR_RED,"*This zone is already captured by your team!");
		} else return CaptureZoneMessage(playerid, 2);
	}
return 1;
}
forward OnPlayerLeaveDynamicCP(playerid, checkpointid);
public OnPlayerLeaveDynamicCP(playerid, checkpointid)
{    
	if(checkpointid == CP[crash] && Captured[playerid][crash] == 0 && IsPlayerCapturing[playerid][crash] == 1 && !IsPlayerInDynamicCP(playerid, CP[crash]))    
	{        
		Leavingcrash(playerid);    
	}
	if(checkpointid == CP[bigear] && Captured[playerid][bigear] == 0 && IsPlayerCapturing[playerid][bigear] == 1 && !IsPlayerInDynamicCP(playerid, CP[bigear]))
	{
		Leavingbigear(playerid);
	}
	if(checkpointid == CP[otm] && Captured[playerid][otm] == 0 && IsPlayerCapturing[playerid][otm] == 1 && !IsPlayerInDynamicCP(playerid, CP[otm]))
	{
		Leavingotm(playerid);
	}
	if(checkpointid == CP[qry] && Captured[playerid][qry] == 0 && IsPlayerCapturing[playerid][qry] == 1 && !IsPlayerInDynamicCP(playerid, CP[qry]))
	{
		Leavingqry(playerid);
	}
	if(checkpointid == CP[oil] && Captured[playerid][oil] == 0 && IsPlayerCapturing[playerid][oil] == 1 && !IsPlayerInDynamicCP(playerid, CP[oil]))
	{
		Leavingoil(playerid);
	}
	if(checkpointid == CP[qa] && Captured[playerid][qa] == 0 && IsPlayerCapturing[playerid][qa] == 1 && !IsPlayerInDynamicCP(playerid, CP[qa]))
	{
		Leavingqa(playerid);
	}
	if(checkpointid == CP[dam] && Captured[playerid][dam] == 0 && IsPlayerCapturing[playerid][dam] == 1 && !IsPlayerInDynamicCP(playerid, CP[dam]))
	{
		Leavingdam(playerid);
	}
	if(checkpointid == CP[ct] && Captured[playerid][ct] == 0 && IsPlayerCapturing[playerid][ct] == 1 && !IsPlayerInDynamicCP(playerid, CP[ct]))
	{
		Leavingct(playerid);
	}

}
stock CaptureZoneMessage(playerid, messageid)
{    
	switch(messageid)    
	{       
		case 1:       
		{           
			SendClientMessage(playerid, COLOR_RED,"You cannot capture while in a vehicle!");       
		}       
		case 2:       
		{           
			SendClientMessage(playerid, COLOR_RED,"This zone is already being taken over!");       
		}    
	}    
		return 1;
}
stock Activecrash(playerid)
{        
	if(UnderAttack[crash] == 0)        
	{            
		if(!IsPlayerInAnyVehicle(playerid))            
		{                UnderAttack[crash] = 1;                
		timer[playerid][crash] = SetTimerEx("crashTimer", 25000, false,"i",playerid);                
		Captured[playerid][crash] = 0;                
		SendClientMessage(playerid, 0xFFFFFFFF,"| Stay in this checkpoint for 25 seconds to capture it! |");                
		if(gTeam[playerid] == MEC)                
		{                  
			GangZoneFlashForAll(Zone[crash], COLOR_MEC);                
		}                
		else if(gTeam[playerid] == USMC)                
		{                  
			GangZoneFlashForAll(Zone[crash], COLOR_USMC);                
		}                //------Message-----                
		if(tCP[crash] == MEC)                
		{                  
			SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by MEC!");                  
			SendClientMessageToAll(COLOR_GREY,"*Capture Zone is under attack!");                
		}                
		else if(tCP[crash] == USMC)                
		{                  
			SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by USMC!");                  
			SendClientMessageToAll(COLOR_GREY,"*Capture Zone is under attack!");                
		}                
		else if(tCP[crash] == TEAM_NONE)                
		{                  
			SendClientMessage(playerid, COLOR_WHITE,"This flag is not controlled by any team!");                
		}                //---------loop-------//                
		for(new i = 0; i < MAX_PLAYERS; i ++)                
		{                   
			IsPlayerCapturing[i][crash] = 1;                
		}            
	}            
	else return CaptureZoneMessage(playerid, 1);        
}        
else return CaptureZoneMessage(playerid, 2);        
return 1;
}
stock Activebigear(playerid)
{
	if(UnderAttack[bigear] == 0)
	{
		if(!IsPlayerInAnyVehicle(playerid))
		{                UnderAttack[bigear] = 1;
		timer[playerid][bigear] = SetTimerEx("bigearTimer", 25000, false,"i",playerid);
		Captured[playerid][bigear] = 0;
		SendClientMessage(playerid, 0xFFFFFFFF,"| Stay in this checkpoint for 25 seconds to capture it! |");
		if(gTeam[playerid] == MEC)
		{
			GangZoneFlashForAll(Zone[bigear], COLOR_MEC);
		}
		else if(gTeam[playerid] == USMC)
		{
			GangZoneFlashForAll(Zone[bigear], COLOR_USMC);
		}                //------Message-----
		if(tCP[bigear] == MEC)
		{
			SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by MEC!");
			SendClientMessageToAll(COLOR_GREY,"*Capture Zone is under attack!");
		}
		else if(tCP[bigear] == USMC)
		{
			SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by USMC!");
			SendClientMessageToAll(COLOR_GREY,"*Capture Zone is under attack!");
		}
		else if(tCP[bigear] == TEAM_NONE)
		{
			SendClientMessage(playerid, COLOR_WHITE,"This flag is not controlled by any team!");
		}                //---------loop-------//
		for(new i = 0; i < MAX_PLAYERS; i ++)
		{
			IsPlayerCapturing[i][bigear] = 1;
		}
	}
	else return CaptureZoneMessage(playerid, 1);
}
else return CaptureZoneMessage(playerid, 2);
return 1;
}
stock Activeotm(playerid)
{
	if(UnderAttack[otm] == 0)
	{
		if(!IsPlayerInAnyVehicle(playerid))
		{                UnderAttack[otm] = 1;
		timer[playerid][otm] = SetTimerEx("otmTimer", 25000, false,"i",playerid);
		Captured[playerid][otm] = 0;
		SendClientMessage(playerid, 0xFFFFFFFF,"| Stay in this checkpoint for 25 seconds to capture it! |");
		if(gTeam[playerid] == MEC)
		{
			GangZoneFlashForAll(Zone[otm], COLOR_MEC);
		}
		else if(gTeam[playerid] == USMC)
		{
			GangZoneFlashForAll(Zone[otm], COLOR_USMC);
		}                //------Message-----
		if(tCP[otm] == MEC)
		{
			SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by MEC!");
			SendClientMessageToAll(COLOR_GREY,"*Capture Zone is under attack!");
		}
		else if(tCP[otm] == USMC)
		{
			SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by USMC!");
			SendClientMessageToAll(COLOR_GREY,"*Capture Zone is under attack!");
		}
		else if(tCP[otm] == TEAM_NONE)
		{
			SendClientMessage(playerid, COLOR_WHITE,"This flag is not controlled by any team!");
		}                //---------loop-------//
		for(new i = 0; i < MAX_PLAYERS; i ++)
		{
			IsPlayerCapturing[i][otm] = 1;
		}
	}
	else return CaptureZoneMessage(playerid, 1);
}
else return CaptureZoneMessage(playerid, 2);
return 1;
}
stock Activeqry(playerid)
{
	if(UnderAttack[qry] == 0)
	{
		if(!IsPlayerInAnyVehicle(playerid))
		{                UnderAttack[qry] = 1;
		timer[playerid][qry] = SetTimerEx("qryTimer", 25000, false,"i",playerid);
		Captured[playerid][qry] = 0;
		SendClientMessage(playerid, 0xFFFFFFFF,"| Stay in this checkpoint for 25 seconds to capture it! |");
		if(gTeam[playerid] == MEC)
		{
			GangZoneFlashForAll(Zone[qry], COLOR_MEC);
		}
		else if(gTeam[playerid] == USMC)
		{
			GangZoneFlashForAll(Zone[qry], COLOR_USMC);
		}                //------Message-----
		if(tCP[qry] == MEC)
		{
			SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by MEC!");
			SendClientMessageToAll(COLOR_GREY,"*Capture Zone is under attack!");
		}
		else if(tCP[qry] == USMC)
		{
			SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by USMC!");
			SendClientMessageToAll(COLOR_GREY,"*Capture Zone is under attack!");
		}
		else if(tCP[qry] == TEAM_NONE)
		{
			SendClientMessage(playerid, COLOR_WHITE,"This flag is not controlled by any team!");
		}                //---------loop-------//
		for(new i = 0; i < MAX_PLAYERS; i ++)
		{
			IsPlayerCapturing[i][qry] = 1;
		}
	}
	else return CaptureZoneMessage(playerid, 1);
}
else return CaptureZoneMessage(playerid, 2);
return 1;
}
stock Activeoil(playerid)
{
	if(UnderAttack[oil] == 0)
	{
		if(!IsPlayerInAnyVehicle(playerid))
		{                UnderAttack[oil] = 1;
		timer[playerid][oil] = SetTimerEx("oilTimer", 25000, false,"i",playerid);
		Captured[playerid][oil] = 0;
		SendClientMessage(playerid, 0xFFFFFFFF,"| Stay in this checkpoint for 25 seconds to capture it! |");
		if(gTeam[playerid] == MEC)
		{
			GangZoneFlashForAll(Zone[oil], COLOR_MEC);
		}
		else if(gTeam[playerid] == USMC)
		{
			GangZoneFlashForAll(Zone[oil], COLOR_USMC);
		}                //------Message-----
		if(tCP[oil] == MEC)
		{
			SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by MEC!");
			SendClientMessageToAll(COLOR_GREY,"*Capture Zone is under attack!");
		}
		else if(tCP[oil] == USMC)
		{
			SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by USMC!");
			SendClientMessageToAll(COLOR_GREY,"*Capture Zone is under attack!");
		}
		else if(tCP[oil] == TEAM_NONE)
		{
			SendClientMessage(playerid, COLOR_WHITE,"This flag is not controlled by any team!");
		}                //---------loop-------//
		for(new i = 0; i < MAX_PLAYERS; i ++)
		{
			IsPlayerCapturing[i][oil] = 1;
		}
	}
	else return CaptureZoneMessage(playerid, 1);
}
else return CaptureZoneMessage(playerid, 2);
return 1;
}
stock Activeqa(playerid)
{
	if(UnderAttack[qa] == 0)
	{
		if(!IsPlayerInAnyVehicle(playerid))
		{                UnderAttack[qa] = 1;
		timer[playerid][qa] = SetTimerEx("oilTimer", 25000, false,"i",playerid);
		Captured[playerid][qa] = 0;
		SendClientMessage(playerid, 0xFFFFFFFF,"| Stay in this checkpoint for 25 seconds to capture it! |");
		if(gTeam[playerid] == MEC)
		{
			GangZoneFlashForAll(Zone[qa], COLOR_MEC);
		}
		else if(gTeam[playerid] == USMC)
		{
			GangZoneFlashForAll(Zone[qa], COLOR_USMC);
		}                //------Message-----
		if(tCP[qa] == MEC)
		{
			SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by MEC!");
			SendClientMessageToAll(COLOR_GREY,"*Capture Zone is under attack!");
		}
		else if(tCP[qa] == USMC)
		{
			SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by USMC!");
			SendClientMessageToAll(COLOR_GREY,"*Capture Zone is under attack!");
		}
		else if(tCP[qa] == TEAM_NONE)
		{
			SendClientMessage(playerid, COLOR_WHITE,"This flag is not controlled by any team!");
		}                //---------loop-------//
		for(new i = 0; i < MAX_PLAYERS; i ++)
		{
			IsPlayerCapturing[i][qa] = 1;
		}
	}
	else return CaptureZoneMessage(playerid, 1);
}
else return CaptureZoneMessage(playerid, 2);
return 1;
}
stock Activedam(playerid)
{
	if(UnderAttack[dam] == 0)
	{
		if(!IsPlayerInAnyVehicle(playerid))
		{                UnderAttack[dam] = 1;
		timer[playerid][dam] = SetTimerEx("damTimer", 25000, false,"i",playerid);
		Captured[playerid][dam] = 0;
		SendClientMessage(playerid, 0xFFFFFFFF,"| Stay in this checkpoint for 25 seconds to capture it! |");
		if(gTeam[playerid] == MEC)
		{
			GangZoneFlashForAll(Zone[dam], COLOR_MEC);
		}
		else if(gTeam[playerid] == USMC)
		{
			GangZoneFlashForAll(Zone[dam], COLOR_USMC);
		}                //------Message-----
		if(tCP[qa] == MEC)
		{
			SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by MEC!");
			SendClientMessageToAll(COLOR_GREY,"*Capture Zone is under attack!");
		}
		else if(tCP[dam] == USMC)
		{
			SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by USMC!");
			SendClientMessageToAll(COLOR_GREY,"*Capture Zone is under attack!");
		}
		else if(tCP[dam] == TEAM_NONE)
		{
			SendClientMessage(playerid, COLOR_WHITE,"This flag is not controlled by any team!");
		}                //---------loop-------//
		for(new i = 0; i < MAX_PLAYERS; i ++)
		{
			IsPlayerCapturing[i][dam] = 1;
		}
	}
	else return CaptureZoneMessage(playerid, 1);
}
else return CaptureZoneMessage(playerid, 2);
return 1;
}
stock Activect(playerid)
{
	if(UnderAttack[ct] == 0)
	{
		if(!IsPlayerInAnyVehicle(playerid))
		{                UnderAttack[ct] = 1;
		timer[playerid][dam] = SetTimerEx("ctTimer", 25000, false,"i",playerid);
		Captured[playerid][ct] = 0;
		SendClientMessage(playerid, 0xFFFFFFFF,"| Stay in this checkpoint for 25 seconds to capture it! |");
		if(gTeam[playerid] == MEC)
		{
			GangZoneFlashForAll(Zone[ct], COLOR_MEC);
		}
		else if(gTeam[playerid] == USMC)
		{
			GangZoneFlashForAll(Zone[ct], COLOR_USMC);
		}                //------Message-----
		if(tCP[qa] == MEC)
		{
			SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by MEC!");
			SendClientMessageToAll(COLOR_GREY,"*Capture Zone is under attack!");
		}
		else if(tCP[dam] == USMC)
		{
			SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by USMC!");
			SendClientMessageToAll(COLOR_GREY,"*Capture Zone is under attack!");
		}
		else if(tCP[dam] == TEAM_NONE)
		{
			SendClientMessage(playerid, COLOR_WHITE,"This flag is not controlled by any team!");
		}                //---------loop-------//
		for(new i = 0; i < MAX_PLAYERS; i ++)
		{
			IsPlayerCapturing[i][ct] = 1;
		}
	}
	else return CaptureZoneMessage(playerid, 1);
}
else return CaptureZoneMessage(playerid, 2);
return 1;
}
stock crashCaptured(playerid)
{    
	Captured[playerid][crash] = 1;    
	UnderAttack[crash] = 0;    
	KillTimer(timer[playerid][crash]);    
	CountVar[playerid][crash] = 25;    
	GivePlayerScore(playerid, 5);    
	GivePlayerMoney(playerid, 1500);
	SendClientMessage(playerid, COLOR_GREEN,"Congratulations! You have captured the area! You received +5 scores and +$1500 cash!");    //==========================================================================
	for(new i = 0; i < MAX_PLAYERS; i++)    
	{       
		IsPlayerCapturing[i][crash] = 0;       
		if(gTeam[i] == gTeam[playerid])       
		{           
			SendClientMessage(i, 0xFFFFFFFF,"*Your team has captured the area! You received +1 score for it!");           
			GivePlayerScore(i, 1);       
			}    
		}    //==========================================================================    
	tCP[crash] = gTeam[playerid];    
	GangZoneStopFlashForAll(Zone[crash]);    //==========================================================================    
	if(gTeam[playerid] == USMC)    
	{       
		GangZoneShowForAll(Zone[crash], COLOR_USMC);    
	}    
	else if(gTeam[playerid] == MEC)    
	{    
		GangZoneShowForAll(Zone[crash], COLOR_MEC);    
	}    //==========================================================================    
	new str[128];    
	format(str, sizeof(str),"%s has captured the capture zone!", GetName(playerid));    
	SendClientMessageToAll(COLOR_ORANGE, str);    
	return 1;
}
stock bigearCaptured(playerid)
{
	Captured[playerid][bigear] = 1;
	UnderAttack[bigear] = 0;
	KillTimer(timer[playerid][bigear]);
	CountVar[playerid][bigear] = 25;
	GivePlayerScore(playerid, 5);
	GivePlayerMoney(playerid, 1500);
	SendClientMessage(playerid, COLOR_GREEN,"Congratulations! You have captured the area! You received +5 scores and +$1500 cash!");    //==========================================================================
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		IsPlayerCapturing[i][bigear] = 0;
		if(gTeam[i] == gTeam[playerid])
		{
			SendClientMessage(i, 0xFFFFFFFF,"*Your team has captured the area! You received +1 score for it!");
			GivePlayerScore(i, 1);
			}
		}    //==========================================================================
	tCP[bigear] = gTeam[playerid];
	GangZoneStopFlashForAll(Zone[bigear]);    //==========================================================================
	if(gTeam[playerid] == USMC)
	{
		GangZoneShowForAll(Zone[bigear], COLOR_USMC);
	}
	else if(gTeam[playerid] == MEC)
	{
		GangZoneShowForAll(Zone[bigear], COLOR_MEC);
	}    //==========================================================================
	new str[128];
	format(str, sizeof(str),"%s has captured the capture zone!", GetName(playerid));
	SendClientMessageToAll(COLOR_ORANGE, str);
	return 1;
}
stock otmCaptured(playerid)
{
	Captured[playerid][otm] = 1;
	UnderAttack[otm] = 0;
	KillTimer(timer[playerid][otm]);
	CountVar[playerid][otm] = 25;
	GivePlayerScore(playerid, 5);
	GivePlayerMoney(playerid, 1500);
	SendClientMessage(playerid, COLOR_GREEN,"Congratulations! You have captured the area! You received +5 scores and +$1500 cash!");    //==========================================================================
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		IsPlayerCapturing[i][otm] = 0;
		if(gTeam[i] == gTeam[playerid])
		{
			SendClientMessage(i, 0xFFFFFFFF,"*Your team has captured the area! You received +1 score for it!");
			GivePlayerScore(i, 1);
			}
		}    //==========================================================================
	tCP[otm] = gTeam[playerid];
	GangZoneStopFlashForAll(Zone[otm]);    //==========================================================================
	if(gTeam[playerid] == USMC)
	{
		GangZoneShowForAll(Zone[otm], COLOR_USMC);
	}
	else if(gTeam[playerid] == MEC)
	{
		GangZoneShowForAll(Zone[otm], COLOR_MEC);
	}    //==========================================================================
	new str[128];
	format(str, sizeof(str),"%s has captured the capture zone!", GetName(playerid));
	SendClientMessageToAll(COLOR_ORANGE, str);
	return 1;
}
stock qryCaptured(playerid)
{
	Captured[playerid][qry] = 1;
	UnderAttack[qry] = 0;
	KillTimer(timer[playerid][qry]);
	CountVar[playerid][qry] = 25;
	GivePlayerScore(playerid, 5);
	GivePlayerMoney(playerid, 1500);
	SendClientMessage(playerid, COLOR_GREEN,"Congratulations! You have captured the area! You received +5 scores and +$1500 cash!");    //==========================================================================
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		IsPlayerCapturing[i][qry] = 0;
		if(gTeam[i] == gTeam[playerid])
		{
			SendClientMessage(i, 0xFFFFFFFF,"*Your team has captured the area! You received +1 score for it!");
			GivePlayerScore(i, 1);
			}
		}    //==========================================================================
	tCP[qry] = gTeam[playerid];
	GangZoneStopFlashForAll(Zone[qry]);    //==========================================================================
	if(gTeam[playerid] == USMC)
	{
		GangZoneShowForAll(Zone[qry], COLOR_USMC);
	}
	else if(gTeam[playerid] == MEC)
	{
		GangZoneShowForAll(Zone[qry], COLOR_MEC);
	}    //==========================================================================
	new str[128];
	format(str, sizeof(str),"%s has captured the capture zone!", GetName(playerid));
	SendClientMessageToAll(COLOR_ORANGE, str);
	return 1;
}
stock oilCaptured(playerid)
{
	Captured[playerid][oil] = 1;
	UnderAttack[oil] = 0;
	KillTimer(timer[playerid][oil]);
	CountVar[playerid][oil] = 25;
	GivePlayerScore(playerid, 5);
	GivePlayerMoney(playerid, 1500);
	SendClientMessage(playerid, COLOR_GREEN,"Congratulations! You have captured the area! You received +5 scores and +$1500 cash!");    //==========================================================================
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		IsPlayerCapturing[i][oil] = 0;
		if(gTeam[i] == gTeam[playerid])
		{
			SendClientMessage(i, 0xFFFFFFFF,"*Your team has captured the area! You received +1 score for it!");
			GivePlayerScore(i, 1);
			}
		}    //==========================================================================
	tCP[oil] = gTeam[playerid];
	GangZoneStopFlashForAll(Zone[oil]);    //==========================================================================
	if(gTeam[playerid] == USMC)
	{
		GangZoneShowForAll(Zone[oil], COLOR_USMC);
	}
	else if(gTeam[playerid] == MEC)
	{
		GangZoneShowForAll(Zone[oil], COLOR_MEC);
	}    //==========================================================================
	new str[128];
	format(str, sizeof(str),"%s has captured the capture zone!", GetName(playerid));
	SendClientMessageToAll(COLOR_ORANGE, str);
	return 1;
}
stock qaCaptured(playerid)
{
	Captured[playerid][qa] = 1;
	UnderAttack[qa] = 0;
	KillTimer(timer[playerid][qa]);
	CountVar[playerid][qa] = 25;
	GivePlayerScore(playerid, 5);
	GivePlayerMoney(playerid, 1500);
	SendClientMessage(playerid, COLOR_GREEN,"Congratulations! You have captured the area! You received +5 scores and +$1500 cash!");    //==========================================================================
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		IsPlayerCapturing[i][qa] = 0;
		if(gTeam[i] == gTeam[playerid])
		{
			SendClientMessage(i, 0xFFFFFFFF,"*Your team has captured the area! You received +1 score for it!");
			GivePlayerScore(i, 1);
			}
		}    //==========================================================================
	tCP[qa] = gTeam[playerid];
	GangZoneStopFlashForAll(Zone[qa]);    //==========================================================================
	if(gTeam[playerid] == USMC)
	{
		GangZoneShowForAll(Zone[qa], COLOR_USMC);
	}
	else if(gTeam[playerid] == MEC)
	{
		GangZoneShowForAll(Zone[qa], COLOR_MEC);
	}    //==========================================================================
	new str[128];
	format(str, sizeof(str),"%s has captured the capture zone!", GetName(playerid));
	SendClientMessageToAll(COLOR_ORANGE, str);
	return 1;
}
stock damCaptured(playerid)
{
	Captured[playerid][dam] = 1;
	UnderAttack[dam] = 0;
	KillTimer(timer[playerid][dam]);
	CountVar[playerid][dam] = 25;
	GivePlayerScore(playerid, 5);
	GivePlayerMoney(playerid, 1500);
	SendClientMessage(playerid, COLOR_GREEN,"Congratulations! You have captured the area! You received +5 scores and +$1500 cash!");    //==========================================================================
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		IsPlayerCapturing[i][oil] = 0;
		if(gTeam[i] == gTeam[playerid])
		{
			SendClientMessage(i, 0xFFFFFFFF,"*Your team has captured the area! You received +1 score for it!");
			GivePlayerScore(i, 1);
			}
		}    //==========================================================================
	tCP[dam] = gTeam[playerid];
	GangZoneStopFlashForAll(Zone[dam]);    //==========================================================================
	if(gTeam[playerid] == USMC)
	{
		GangZoneShowForAll(Zone[dam], COLOR_USMC);
	}
	else if(gTeam[playerid] == MEC)
	{
		GangZoneShowForAll(Zone[dam], COLOR_MEC);
	}    //==========================================================================
	new str[128];
	format(str, sizeof(str),"%s has captured the capture zone!", GetName(playerid));
	SendClientMessageToAll(COLOR_ORANGE, str);
	return 1;
}
stock ctCaptured(playerid)
{
	Captured[playerid][ct] = 1;
	UnderAttack[ct] = 0;
	KillTimer(timer[playerid][ct]);
	CountVar[playerid][ct] = 25;
	GivePlayerScore(playerid, 5);
	GivePlayerMoney(playerid, 1500);
	SendClientMessage(playerid, COLOR_GREEN,"Congratulations! You have captured the area! You received +5 scores and +$1500 cash!");    //==========================================================================
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		IsPlayerCapturing[i][ct] = 0;
		if(gTeam[i] == gTeam[playerid])
		{
			SendClientMessage(i, 0xFFFFFFFF,"*Your team has captured the area! You received +1 score for it!");
			GivePlayerScore(i, 1);
			}
		}    //==========================================================================
	tCP[ct] = gTeam[playerid];
	GangZoneStopFlashForAll(Zone[ct]);    //==========================================================================
	if(gTeam[playerid] == USMC)
	{
		GangZoneShowForAll(Zone[ct], COLOR_USMC);
	}
	else if(gTeam[playerid] == MEC)
	{
		GangZoneShowForAll(Zone[ct], COLOR_MEC);
	}    //==========================================================================
	new str[128];
	format(str, sizeof(str),"%s has captured the capture zone!", GetName(playerid));
	SendClientMessageToAll(COLOR_ORANGE, str);
	return 1;
}
stock Leavingcrash(playerid)
{    
	Captured[playerid][crash] = 0;    
	UnderAttack[crash] = 0;    
	KillTimer(timer[playerid][crash]);    
	CountVar[playerid][crash] = 25;    
	GangZoneStopFlashForAll(Zone[crash]);    
	for(new i = 0; i < MAX_PLAYERS; i++)    
	{       
		IsPlayerCapturing[i][crash] = 0;    
	}    
	SendClientMessage(playerid, COLOR_RED,"*You have failed to capture this zone!");    
	return 1;
}
stock Leavingbigear(playerid)
{
	Captured[playerid][bigear] = 0;
	UnderAttack[bigear] = 0;
	KillTimer(timer[playerid][bigear]);
	CountVar[playerid][bigear] = 25;
	GangZoneStopFlashForAll(Zone[bigear]);
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		IsPlayerCapturing[i][bigear] = 0;
	}
	SendClientMessage(playerid, COLOR_RED,"*You have failed to capture this zone!");
	return 1;
}
stock Leavingotm(playerid)
{
	Captured[playerid][otm] = 0;
	UnderAttack[otm] = 0;
	KillTimer(timer[playerid][otm]);
	CountVar[playerid][otm] = 25;
	GangZoneStopFlashForAll(Zone[otm]);
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		IsPlayerCapturing[i][otm] = 0;
	}
	SendClientMessage(playerid, COLOR_RED,"*You have failed to capture this zone!");
	return 1;
}
stock Leavingqry(playerid)
{
	Captured[playerid][qry] = 0;
	UnderAttack[qry] = 0;
	KillTimer(timer[playerid][qry]);
	CountVar[playerid][qry] = 25;
	GangZoneStopFlashForAll(Zone[qry]);
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		IsPlayerCapturing[i][qry] = 0;
	}
	SendClientMessage(playerid, COLOR_RED,"*You have failed to capture this zone!");
	return 1;
}
stock Leavingoil(playerid)
{
	Captured[playerid][oil] = 0;
	UnderAttack[oil] = 0;
	KillTimer(timer[playerid][oil]);
	CountVar[playerid][oil] = 25;
	GangZoneStopFlashForAll(Zone[oil]);
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		IsPlayerCapturing[i][oil] = 0;
	}
	SendClientMessage(playerid, COLOR_RED,"*You have failed to capture this zone!");
	return 1;
}
stock Leavingqa(playerid)
{
	Captured[playerid][qa] = 0;
	UnderAttack[qa] = 0;
	KillTimer(timer[playerid][qa]);
	CountVar[playerid][qa] = 25;
	GangZoneStopFlashForAll(Zone[qa]);
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		IsPlayerCapturing[i][qa] = 0;
	}
	SendClientMessage(playerid, COLOR_RED,"*You have failed to capture this zone!");
	return 1;
}
stock Leavingdam(playerid)
{
	Captured[playerid][dam] = 0;
	UnderAttack[dam] = 0;
	KillTimer(timer[playerid][dam]);
	CountVar[playerid][dam] = 25;
	GangZoneStopFlashForAll(Zone[dam]);
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		IsPlayerCapturing[i][dam] = 0;
	}
	SendClientMessage(playerid, COLOR_RED,"*You have failed to capture this zone!");
	return 1;
}
stock Leavingct(playerid)
{
	Captured[playerid][ct] = 0;
	UnderAttack[ct] = 0;
	KillTimer(timer[playerid][ct]);
	CountVar[playerid][ct] = 25;
	GangZoneStopFlashForAll(Zone[ct]);
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		IsPlayerCapturing[i][ct] = 0;
	}
	SendClientMessage(playerid, COLOR_RED,"*You have failed to capture this zone!");
	return 1;
}
forward crashTimer(playerid);
public crashTimer(playerid)
{    
	crashCaptured(playerid);    
return 1;
}
forward bigearTimer(playerid);
public bigearTimer(playerid)
{
	bigearCaptured(playerid);
return 1;
}
forward otmTimer(playerid);
public otmTimer(playerid)
{
	otmCaptured(playerid);
return 1;
}
forward qryTimer(playerid);
public qryTimer(playerid)
{
	qryCaptured(playerid);
return 1;
}
forward oilTimer(playerid);
public oilTimer(playerid)
{
	oilCaptured(playerid);
return 1;
}
forward qaTimer(playerid);
public qaTimer(playerid)
{
	qaCaptured(playerid);
return 1;
}
forward damTimer(playerid);
public damTimer(playerid)
{
	damCaptured(playerid);
return 1;
}
forward ctTimer(playerid);
public ctTimer(playerid)
{
	ctCaptured(playerid);
return 1;
}
stock GetName(playerid)
{ 
	new pnameid[24]; 
	GetPlayerName(playerid,pnameid,24); 
	return pnameid;
}
stock GivePlayerScore(playerid, score) // creating our stock
{
	SetPlayerScore(playerid, GetPlayerScore(playerid) + score); // we're defining it as it will SetPlayerScore, since it's not known like GivePlayerMoney, there is just SetPlayerScore for the scores.
	return 1;
}
