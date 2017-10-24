// This is a comment
// uncomment the line below if you want to write a filterscript
//#define FILTERSCRIPT

#include <a_samp>

#include <zcmd>
#include <streamer>
#include <sscanf2>
#include <TDgroup>
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
new bool:sdeath[MAX_PLAYERS];
new tempmoney[MAX_PLAYERS];
new gPlayerClass[MAX_PLAYERS];
new gTeam[MAX_PLAYERS];
new PickedClass[MAX_PLAYERS] = 0;
#define UK 1
#define SPAIN 2
#define GERMAN 3
#define GERMAN_COLOUR 0x80FF005D
#define SPAIN_COLOUR 0xFF00005D
#define UK_COLOUR 0x0000FF5D
//Middle Eastern Coalition
#define ASSAULT_CLASS 1
#define SNIPER_CLASS 2
#define SUPPORT_CLASS 4
#define ENGINEER_CLASS 3
#define TEAM_NONE       6 //Ignore if you already got team defines
#define invisible 0xFFFFFF00
//Colors
#define COLOR_SPAIN 0xFF00005D
#define COLOR_UK 0x0000FF5D
#define COLOR_GERMAN 0x80FF005D
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
new CountVar[MAX_PLAYERS][25];

new Died[MAX_PLAYERS], KilledBy[MAX_PLAYERS];
new Text:CountText[MAX_PLAYERS];
new IsPlayerCapturing[MAX_PLAYERS][30];
//
new Float:RandomSpawnsSpain[][]=
{
	{-207.7996,2673.1997,62.5989,94.0194},
	{-255.0912,2765.1052,62.4325,179.6207}
};
new Float:RandomSpawnsUK[][]=
{
	{-87.5639,1222.5226,19.7422,176.7168},
	{-202.7213,1161.5939,19.7422,269.5345}
};
new Float:RandomSpawnsGerman[][]=
{
	{697.0424,1840.3873,5.5318,88.4832},
	{638.2048,1685.9878,6.9922,28.6255}
};/////
/////
/////

////
////
new Text:TDClassChooser; //When Player Chooses class [HEADING]
new Text:TDClassChooserBOX; //Box for it
new Text:TDClassChooserAssault[MAX_PLAYERS]; //Assault Selected
new Text:TDClassChooserSupport[MAX_PLAYERS];
new Text:TDClassChooserSniper[MAX_PLAYERS];
new Text:TDClassChooserEngineer[MAX_PLAYERS];
new Text:TDClassChooserChoosen[MAX_PLAYERS]; //The >  < in class chossing
new Text:TD_HowToSpawn; //Press shift to go up and space to down....
new TDGroupClassChooser[MAX_PLAYERS];
new type[MAX_PLAYERS];
new Class_pickup[MAX_PLAYERS][3];
#define SCM SendClientMessage
#define PRESSED(%0) \
(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
////
////
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
	new GZ_ZONE3;
public OnGameModeInit()
{
//
//

 AddStaticVehicle(520,1650.1279,-965.3316,63.4298,328.6633,0,0); // Hydra_1
 AddStaticVehicle(425,1657.9375,-965.7026,63.4109,13.6602,0,0); // hydra_2
//
//
	#include <wot>

	// Don't use these lines if it's a filterscript
	//SetGameModeText("BF2-SAMP OCS");
	AddPlayerClass(285,83.7808,35.2018,0.6094,118.9501,0,0,0,0,0,0); // soldier UK
	AddPlayerClass(286,83.7808,35.2018,0.6094,118.9501,0,0,0,0,0,0); // soldier  SPAIN
	AddPlayerClass(287,83.7808,35.2018,0.6094,118.9501,0,0,0,0,0,0); // soldier German
//	SetTimer("hostname",5000,1);//<<< You can change the ammount of time the hostname stays till it changes(1000 = 1 second)
    SetGameModeText("Conquest-TDM");
GZ_ZONE1 = GangZoneCreate(-363.28125,972.65625,158.203125,1248.046875);


	GZ_ZONE2 = GangZoneCreate(-462.890625,2560.546875,-52.734375,2806.640625);
GZ_ZONE3 = GangZoneCreate(515.625,1623.046875,738.28125,2015.625);


	
    UsePlayerPedAnims();
	EnableStuntBonusForAll(0);


	
	//
tCP[crash] = TEAM_NONE;    
UnderAttack[crash] = 0;    
Zone[crash] = GangZoneCreate(35.15625,2390.625,457.03125,2607.421875);
CP[crash] = CreateDynamicCP(414.5120,2533.0212,19.1484,4, -1, -1, -1, 100.0);

//
tCP[bigear] = TEAM_NONE;
UnderAttack[bigear] = 0;
Zone[bigear] = GangZoneCreate(-451.171875,1297.8515625,-149.4140625,1658.203125);
CP[bigear] = CreateDynamicCP(-294.4886,1532.0479,75.3594,4, -1, -1, -1, 100.0);

tCP[otm] = TEAM_NONE;
UnderAttack[otm] = 0;
Zone[otm] = GangZoneCreate(-17.578125,1675.78125,433.59375,2126.953125);
CP[otm] = CreateDynamicCP(205.1500,1860.6399,13.1406,4, -1, -1, -1, 100.0);


tCP[oil] = TEAM_NONE;
UnderAttack[oil] = 0;
Zone[oil] = GangZoneCreate(451.171875,1113.28125,720.703125,1289.0625);

CP[oil] = CreateDynamicCP(603.7394,1244.3452,11.7188,4, -1, -1, -1, 100.0);


tCP[ct] = TEAM_NONE;
UnderAttack[ct] = 0;
Zone[ct] = GangZoneCreate(-503.90625,2144.53125,-310.546875,2279.296875);
CP[ct] = CreateDynamicCP(-378.6023,2242.1914,42.6185,4, -1, -1, -1, 100.0);
//
//
//
//

///
//
//
//
//
//
//
//
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
    type[playerid]=-1;
   // gTeam[playerid] = TEAM_NONE;
    Died[playerid] = -1;
	KilledBy[playerid] = -1;
	return 1;
}
forward SetPlayerTeamFromClass(playerid, classid);
SetPlayerTeamFromClass(playerid, classid)
{

	if(classid == 0)
	{
	gTeam[playerid] = UK;
	PlayerPlaySound(playerid, 1132, 0.0, 0.0, 0.0);
	GameTextForPlayer(playerid,"~b~British United Kingdom",1000,3);
	SetPlayerPos(playerid, 219.4065,1822.6654,7.5236);
	SetPlayerFacingAngle(playerid,268.9849);
	SetPlayerCameraPos(playerid, 226.4905,1822.8358,7.4141);
	SetPlayerCameraLookAt(playerid, 222.4905,1822.8358,7.4141);
	GivePlayerWeapon(playerid,30,1);
	ApplyAnimation(playerid, "SHOP", "SHP_Gun_Aim", 4.0, 0, 1, 1, 1, -1);
	SetPlayerTeam(playerid,0);
	}
	if(classid == 1)
	{
	gTeam[playerid] = SPAIN;
	PlayerPlaySound(playerid, 1132, 0.0, 0.0, 0.0);
	GameTextForPlayer(playerid,"~r~Kingdom of Spain",1000,3);
	SetPlayerPos(playerid, 219.4065,1822.6654,7.5236);
	SetPlayerFacingAngle(playerid,268.9849);
	SetPlayerCameraPos(playerid, 226.4905,1822.8358,7.4141);
	SetPlayerCameraLookAt(playerid, 222.4905,1822.8358,7.4141);
	GivePlayerWeapon(playerid,31,1);
	ApplyAnimation(playerid, "SHOP", "SHP_Gun_Aim", 4.0, 0, 1, 1, 1, -1);
    SetPlayerTeam(playerid,1);
	}
	if(classid == 2)
	{
	gTeam[playerid] = GERMAN;
	PlayerPlaySound(playerid, 1132, 0.0, 0.0, 0.0);
	GameTextForPlayer(playerid,"~g~Germany Factor",1000,3);
	SetPlayerPos(playerid, 219.4065,1822.6654,7.5236);
	SetPlayerFacingAngle(playerid,268.9849);
	SetPlayerCameraPos(playerid, 226.4905,1822.8358,7.4141);
	SetPlayerCameraLookAt(playerid, 222.4905,1822.8358,7.4141);
	GivePlayerWeapon(playerid,31,1);
	ApplyAnimation(playerid, "SHOP", "SHP_Gun_Aim", 4.0, 0, 1, 1, 1, -1);
    SetPlayerTeam(playerid,2);
	}
}


public OnPlayerConnect(playerid)
{
//
//
//

 PlayAudioStreamForPlayer(playerid,"http://k003.kiwi6.com/hotlink/yhc86kg568/Nicky_Romero_-_Toulouse_Headhunterz_Remix_HQ_Original_mp3_mp3_.mp3");
SetPlayerMapIcon(playerid, 2, 603.7394,1244.3452,11.7188, 19, MAPICON_GLOBAL);
SetPlayerMapIcon(playerid, 3, 205.1500,1860.6399,13.1406, 19, MAPICON_GLOBAL);
SetPlayerMapIcon(playerid, 4, 414.5120,2533.0212,19.1484,19, MAPICON_GLOBAL);
SetPlayerMapIcon(playerid, 5, -378.6023,2242.1914,42.6185, 19, MAPICON_GLOBAL);
SetPlayerMapIcon(playerid, 6, -295.0490,1531.0076,75.3594, 19, MAPICON_GLOBAL);
//
//
//
//
	
	#include <wotremove>
	GameTextForPlayer(playerid,"~y~Welcome~n~~p~-to-~n~~r~BattleField ~g~of~y~|~w~Triangle",2000,1);
	SendClientMessage(playerid,COLOR_GREEN,"Please Register/Login");

	//
sdeath[playerid]=false;

//GangZoneShowForAll(Zone[crash], 0x00000043);
//IsPlayerCapturing[playerid][crash] = 0;
//CountVar[playerid][crash] = 25;
if(tCP[crash] == TEAM_NONE) GangZoneShowForPlayer(playerid,Zone[crash], -66);    
else if(tCP[crash] == UK) GangZoneShowForPlayer(playerid,Zone[crash],COLOR_UK);
else if(tCP[crash] == SPAIN) GangZoneShowForPlayer(playerid,Zone[crash], COLOR_SPAIN);
else if(tCP[crash] == GERMAN) GangZoneShowForPlayer(playerid,Zone[crash], COLOR_GERMAN);
//
if(tCP[bigear] == TEAM_NONE) GangZoneShowForPlayer(playerid,Zone[bigear], -66);
else if(tCP[bigear] == UK) GangZoneShowForPlayer(playerid,Zone[bigear],COLOR_UK);
else if(tCP[bigear] == SPAIN) GangZoneShowForPlayer(playerid,Zone[bigear], COLOR_SPAIN);
else if(tCP[bigear] == GERMAN) GangZoneShowForPlayer(playerid,Zone[bigear], COLOR_GERMAN);
//
//
if(tCP[otm] == TEAM_NONE) GangZoneShowForPlayer(playerid,Zone[otm], -66);
else if(tCP[otm] == UK) GangZoneShowForPlayer(playerid,Zone[otm],COLOR_UK);
else if(tCP[otm] == SPAIN) GangZoneShowForPlayer(playerid,Zone[otm], COLOR_SPAIN);
else if(tCP[otm] == GERMAN) GangZoneShowForPlayer(playerid,Zone[otm], COLOR_GERMAN);
//
//
if(tCP[oil] == TEAM_NONE) GangZoneShowForPlayer(playerid,Zone[oil], -66);
else if(tCP[oil] == UK) GangZoneShowForPlayer(playerid,Zone[oil],COLOR_UK);
else if(tCP[oil] == SPAIN) GangZoneShowForPlayer(playerid,Zone[oil], COLOR_SPAIN);
else if(tCP[oil] == GERMAN) GangZoneShowForPlayer(playerid,Zone[oil], COLOR_GERMAN);
//
//
if(tCP[ct] == TEAM_NONE) GangZoneShowForPlayer(playerid,Zone[ct], -66);
else if(tCP[ct] == UK) GangZoneShowForPlayer(playerid,Zone[ct],COLOR_UK);
else if(tCP[ct] == SPAIN) GangZoneShowForPlayer(playerid,Zone[ct], COLOR_SPAIN);
else if(tCP[crash] == GERMAN) GangZoneShowForPlayer(playerid,Zone[ct], COLOR_GERMAN);
//ct
Died[playerid] = -1;    
KilledBy[playerid] = -1;
type[playerid] = -1;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
SetPVarInt(playerid, "typestatus", 0);

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
if(Captured[playerid][oil] == 0 && IsPlayerCapturing[playerid][oil] == 1)
{
	Leavingoil(playerid);
}
if(Captured[playerid][ct] == 0 && IsPlayerCapturing[playerid][ct] == 1)
{
	Leavingct(playerid);
}
GangZoneDestroy(GZ_ZONE1);
GangZoneDestroy(GZ_ZONE2);
GangZoneDestroy(GZ_ZONE3);
Died[playerid] = 0;    
KilledBy[playerid] = 0;
return 1;
}
forward givecashs(playerid);
public givecashs(playerid)
{
    SetPlayerMoney(playerid,tempmoney[playerid]);
    sdeath[playerid]=false;
	return 1;
}

public OnPlayerSpawn(playerid)
{


if(sdeath[playerid]==true)
{
SetTimerEx("givecashs",4000,false,"i",playerid);
}
if(GetPlayerTeam(playerid)==0)
{
    new Random = random(sizeof(RandomSpawnsUK));
	SetPlayerPos(playerid, RandomSpawnsUK[Random][0], RandomSpawnsUK[Random][1], RandomSpawnsUK[Random][2]);
	SetPlayerFacingAngle(playerid, RandomSpawnsUK[Random][3]);
	SetPlayerSkin(playerid,285);
	SetPlayerColor(playerid,COLOR_UK);
//UK
}
else if(GetPlayerTeam(playerid)==1)
{
    new Random = random(sizeof(RandomSpawnsSpain));
	SetPlayerPos(playerid, RandomSpawnsSpain[Random][0], RandomSpawnsSpain[Random][1], RandomSpawnsSpain[Random][2]);
	SetPlayerFacingAngle(playerid, RandomSpawnsSpain[Random][3]);
		SetPlayerSkin(playerid,286);
		 SetPlayerColor(playerid,COLOR_SPAIN);
//SPAIN
}
else if(GetPlayerTeam(playerid)==2)
{
	new Random = random(sizeof(RandomSpawnsGerman));
	SetPlayerPos(playerid, RandomSpawnsGerman[Random][0], RandomSpawnsGerman[Random][1], RandomSpawnsGerman[Random][2]);
	SetPlayerFacingAngle(playerid, RandomSpawnsGerman[Random][3]);
		SetPlayerSkin(playerid,287);
		SetPlayerColor(playerid,COLOR_GERMAN);
//GERMAN
}

///
  
    TogglePlayerControllable(playerid,0);
    SetPlayerHealth(playerid, 1000000.0);

    SendClientMessage(playerid, COLOR_GREY, "[SERVER]:You have 10 seconds of Anti-Spawnkill protection");
    SetPlayerChatBubble(playerid, "[SERVER]:Anti-Spawnkill protected player", 0xFF0000AA, 100.0, 10000);
    SetTimerEx("AntiSpawnkill",15000,0,"i",playerid);
     SetTimerEx("Load",3000,0,"i",playerid);
	GameTextForPlayer(playerid,"~r~Loading ~n~~g~World ~n~~y~Object",2500,3);
    GangZoneShowForPlayer(playerid,GZ_ZONE1, 0x0000FFAA);
	GangZoneShowForPlayer(playerid,GZ_ZONE2, 0xFF00005D);
	GangZoneShowForPlayer(playerid,GZ_ZONE3, 0x80FF005D);
 //	 SetPlayerToTeamColour(playerid);
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


    if(gPlayerClass[playerid] == ASSAULT_CLASS)
    {
	GivePlayerWeapon(playerid,31,800);
	GivePlayerWeapon(playerid,32,800);
	GivePlayerWeapon(playerid,22,800);
	GivePlayerWeapon(playerid,4,1);
	GivePlayerWeapon(playerid,33,80);
	GivePlayerWeapon(playerid,45,1);
    GivePlayerWeapon(playerid,16,5);
    SendClientMessage(playerid, COLOR_GREEN,"You Can Heal Player by /theal");

    }
    else if(gPlayerClass[playerid] == SUPPORT_CLASS)
    {
	GivePlayerWeapon(playerid,30,1500);
	GivePlayerWeapon(playerid,39,10);
	GivePlayerWeapon(playerid,40,10);
	GivePlayerWeapon(playerid,27,1500);
	GivePlayerWeapon(playerid,39,10);
	GivePlayerWeapon(playerid,29,1500);
	SendClientMessage(playerid, COLOR_GREEN,"You Can Give Ammo Player by /sp and Get A C4 Bomber ! ");
    SendClientMessage(playerid, COLOR_GREEN,"Your Ammo is Enough to Killed all Player In server !");

    }
    else if(gPlayerClass[playerid] == SNIPER_CLASS)
    {
	GivePlayerWeapon(playerid,34,800);
	GivePlayerWeapon(playerid,23,800);
	GivePlayerWeapon(playerid,4,1);
	GivePlayerWeapon(playerid,41,800);
	GivePlayerWeapon(playerid,29,800);
	GivePlayerWeapon(playerid,25,800);
	SendClientMessage(playerid, COLOR_GREEN,"You Can stealth by /(un)stealth");
    }

    else if(gPlayerClass[playerid] == ENGINEER_CLASS)
    {
	GivePlayerWeapon(playerid,29,800);
	GivePlayerWeapon(playerid,24,800);
	GivePlayerWeapon(playerid,4,1);
	GivePlayerWeapon(playerid,36,15);
	GivePlayerWeapon(playerid,26,800);
    GivePlayerWeapon(playerid,30,800);
   	SendClientMessage(playerid, COLOR_GREEN,"You Can use Your Heat Launcher clear thos enemy vehicle out !");
    }





for(new i=0;i<MAX_GROUPS;++i) tdenum[i][count] = -1;
TDClassChooser = TextDrawCreate(91.000000, 149.000000, "~g~Class ~r~Choosing");
TextDrawAlignment(TDClassChooser, 2);
TextDrawBackgroundColor(TDClassChooser, 255);
TextDrawFont(TDClassChooser, 2);
TextDrawLetterSize(TDClassChooser, 0.270000, 2.000000);
TextDrawColor(TDClassChooser, -16776961);
TextDrawSetOutline(TDClassChooser, 1);
TextDrawSetProportional(TDClassChooser, 1);
TextDrawUseBox(TDClassChooser, 1);
TextDrawBoxColor(TDClassChooser, 255);
TextDrawTextSize(TDClassChooser, 179.000000, 121.000000);
TDClassChooserBOX = TextDrawCreate(32.000000, 173.000000, "~n~~n~~n~~n~~n~~n~~n~");
TextDrawBackgroundColor(TDClassChooserBOX, 255);
TextDrawFont(TDClassChooserBOX, 1);
TextDrawLetterSize(TDClassChooserBOX, 0.500000, 1.000000);
TextDrawColor(TDClassChooserBOX, -1);
TextDrawSetOutline(TDClassChooserBOX, 0);
TextDrawSetProportional(TDClassChooserBOX, 1);
TextDrawSetShadow(TDClassChooserBOX, 1);
TextDrawUseBox(TDClassChooserBOX, 1);
TextDrawBoxColor(TDClassChooserBOX, 125);
TextDrawTextSize(TDClassChooserBOX, 150.000000, 109.000000);
TD_HowToSpawn                   =TextDrawCreate( 66.000000, 293.000000, "Press ~g~SHIFT ~w~ to go ~g~UP~n~~r~SPACE~w~ to go ~r~DOWN~n~~b~ENTER TO SPAWN");
TextDrawAlignment           ( TD_HowToSpawn, 2);
TextDrawBackgroundColor ( TD_HowToSpawn, 255);
TextDrawFont                ( TD_HowToSpawn, 1);
TextDrawLetterSize      ( TD_HowToSpawn, 0.300000, 1.300000);
TextDrawColor               ( TD_HowToSpawn, -1);
TextDrawSetOutline      ( TD_HowToSpawn, 1);
 TextDrawSetProportional ( TD_HowToSpawn, 1);
 //
 TDClassChooserAssault[playerid] = TextDrawCreate(55.000000, 174.000000, "~g~Assault");
 TextDrawBackgroundColor(TDClassChooserAssault[playerid], 255);
 TextDrawFont(TDClassChooserAssault[playerid], 2);
 TextDrawLetterSize(TDClassChooserAssault[playerid], 0.239999, 1.299999);
 TextDrawColor(TDClassChooserAssault[playerid], -1);
 TextDrawSetOutline(TDClassChooserAssault[playerid], 1);
 TextDrawSetProportional(TDClassChooserAssault[playerid], 1);
 TDClassChooserSupport[playerid] = TextDrawCreate(56.000000, 188.000000, "Support");
 TextDrawBackgroundColor(TDClassChooserSupport[playerid], 255);
  TextDrawFont(TDClassChooserSupport[playerid], 2);
  TextDrawLetterSize(TDClassChooserSupport[playerid], 0.239999, 1.299999);
TextDrawColor(TDClassChooserSupport[playerid], -1);
  TextDrawSetOutline(TDClassChooserSupport[playerid], 1);
  TextDrawSetProportional(TDClassChooserSupport[playerid], 1);
   TDClassChooserSniper[playerid] = TextDrawCreate(66.000000, 202.000000, "Sniper");
   TextDrawBackgroundColor(TDClassChooserSniper[playerid], 255);
   TextDrawFont(TDClassChooserSniper[playerid], 2);
   TextDrawLetterSize(TDClassChooserSniper[playerid], 0.239999, 1.299999);
   TextDrawColor(TDClassChooserSniper[playerid], -1);
   TextDrawSetOutline(TDClassChooserSniper[playerid], 1);
   TextDrawSetProportional(TDClassChooserSniper[playerid], 1);
   TDClassChooserEngineer[playerid] = TextDrawCreate(65.000000, 218.000000, "Engineer");
   TextDrawBackgroundColor(TDClassChooserEngineer[playerid], 255);
   TextDrawFont(TDClassChooserEngineer[playerid], 2);
   TextDrawLetterSize(TDClassChooserEngineer[playerid], 0.239999, 1.299999);
   TextDrawColor(TDClassChooserEngineer[playerid], -1);
   TextDrawSetOutline(TDClassChooserEngineer[playerid], 1);
   TextDrawSetProportional(TDClassChooserEngineer[playerid], 1);
   TDClassChooserChoosen[playerid] = TextDrawCreate(38.000000, 175.000000, "~r~>         <");
   TextDrawBackgroundColor(TDClassChooserChoosen[playerid], 255);
   TextDrawFont(TDClassChooserChoosen[playerid], 1);
   TextDrawLetterSize(TDClassChooserChoosen[playerid], 0.500000, 1.000000);
   TextDrawColor(TDClassChooserChoosen[playerid], 9830550);
   TextDrawSetOutline(TDClassChooserChoosen[playerid], 1);
   TextDrawSetProportional(TDClassChooserChoosen[playerid], 1);
   TDGroupClassChooser[playerid] = CreateTDGroup(TDClassChooser,TDClassChooserBOX,TDClassChooserAssault[playerid],TDClassChooserSupport[playerid],TDClassChooserSniper[playerid],TDClassChooserEngineer[playerid],TDClassChooserChoosen[playerid],TD_HowToSpawn);
//
//
        //SetSpawnInfo(playerid,0,0,0,0,0,0,0,0,0,0,0,0);
	if(type[playerid]==-1)
{
//
///
//
    SetPVarInt(playerid, "typestatus", 0);
	SetPlayerVirtualWorld(playerid,playerid);//Puts player in a virtual world
	ShowEngineerClass(playerid);//Stock we are just going to create
	return 0;
}
//SCM(playerid,-1,"[SYSTEM]: spawned");
///
///
//

	return 1;
}//
forward Load(playerid);
public Load(playerid)
{
	TogglePlayerControllable(playerid,1);
	GameTextForPlayer(playerid,"~r~World Object ~g~Loaded",1200,3);
	return 1;
}
//
stock ShowEngineerClass(playerid)
{
//Since, at starting layer has choosen Assault as class, so we need to create pickup here.//___PICKUP____
Class_pickup[playerid][0] = CreatePickup(356,1,1654.3134,-955.5966,62.6696,playerid);
Class_pickup[playerid][1] = CreatePickup(348,1,1656.3134,-955.5966,62.6696,playerid);
Class_pickup[playerid][2] = CreatePickup(342,1,1658.3134,-955.5966,62.6696,playerid);
//__TextDraw__
TDGroupShowForPlayer(playerid,TDGroupClassChooser[playerid]);//Replace by TextDrawShowForPlayer if not using the include.
//__PLATYER AND CAMERA__
TogglePlayerControllable(playerid,false);
SetPlayerInterior(playerid,0);
SetPlayerPos(playerid,1652.3134,-955.5966,62.6696);
SetPlayerFacingAngle(playerid,355.7387);
SetPlayerCameraPos(playerid,1655.4005,-950.2772,62.5974);
SetPlayerCameraLookAt(playerid,1654.3134,-961.5966,62.6696);
SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE3);
//SetPlayerSkin(playerid,287);
SetPVarInt(playerid,"AT",0);}
//
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
	
    sdeath[playerid]=true;
    tempmoney[playerid]=GetPlayerMoney(playerid);
    ResetPlayerMoney(playerid);
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
	if(Captured[playerid][oil] == 0 && IsPlayerCapturing[playerid][oil] == 1)
{
	Leavingoil(playerid);
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
   if(GetPlayerTeam(playerid)== 0)
   {
    gTeam[playerid] = UK;
	}
	else if(GetPlayerTeam(playerid)== 1)
   {
    gTeam[playerid] = SPAIN;
	}
else 	if(GetPlayerTeam(playerid)== 2)
   {
    gTeam[playerid] = GERMAN;
	}
  ClearAnimations(playerid);
//	menuload(playerid);
	return 1;
}/*
forward menuload(playerid);
public menuload(playerid)
{
ShowPlayerDialog(playerid, 1, DIALOG_STYLE_LIST, "Select-Classes", "Assault\nMedic\nSniper\nAnti-Vehicle\nEngineer", "Select", "Cancel");
return 1;
}*/
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
/*
	if(pickupid == pickup_Health)
    {
		
       
    

		
			 SetPlayerHealth(playerid, 100.0);
			DestroyPickup(pickup_Health);
		
		
		
	}
    */

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
    if(type[playerid]==-1)
	{
		new at = GetPVarInt(playerid,"AT");
		new bool:create = false;
		if(PRESSED(KEY_SPRINT))
		{
			create = true;
			for(new i=0;i<3;++i) DestroyPickup(Class_pickup[playerid][i]);
			if(at==3) at=-1;
			++at;
		}
		else if(PRESSED(KEY_JUMP))
	 	{
		 	create = true;
			 for(new i=0;i<3;++i) DestroyPickup(Class_pickup[playerid][i]);
			 if(at==0) at=4;
			 --at;
	 	}
		 else if(PRESSED(KEY_SECONDARY_ATTACK))
	 	{
		 	type[playerid] = at + 1;
			 new str[50];
			 switch(at)
			 {
			 	case 0:
				 {
				 	format(str,sizeof(str),"[SYSTEM]: You spawned as Assault Class");
					 //SetSpawnInfo(playerid,0,GetPlayerSkin(playerid),1958,95,0,0,1,6,27,300,32,010);
					 gPlayerClass[playerid] = ASSAULT_CLASS;
					 
				 }
			 	case 1:
				 {
				 	format(str,sizeof(str),"[SYSTEM]: You spawned as Support Class");
				 	gPlayerClass[playerid] = SUPPORT_CLASS;
				 
				 }
			  	case 2:
			  	{
				  	format(str,sizeof(str),"[SYSTEM]: You spawned as Sniper Class");
				  	gPlayerClass[playerid] = SNIPER_CLASS;
				 
			  	}
			  	case 3:
			  	{
				  	format(str,sizeof(str),"[SYSTEM]: You spawned as Engineer Class");
				  	gPlayerClass[playerid] = ENGINEER_CLASS;
				  
			  	}
		  }
		  TDGroupHideForPlayer(playerid,TDGroupClassChooser[playerid]);
		  SCM(playerid,-1,str);
		  TogglePlayerControllable(playerid,false);
		  ClearAnimations(playerid,1);
		   StopAudioStreamForPlayer(playerid);
		   SetPVarInt(playerid, "typestatus", 1);
		  	SpawnPlayer(playerid);

		  return 1;
	  }
	  switch(at)
	   {
	    case 0:
		{
		TextDrawSetString(TDClassChooserAssault[playerid],"~g~Assault");//Assault is green , rest white
		TextDrawSetString(TDClassChooserSupport[playerid],"~w~Support");
		TextDrawSetString(TDClassChooserSniper[playerid],"~w~Sniper");
		TextDrawSetString(TDClassChooserEngineer[playerid],"~w~Engineer");
		TextDrawDestroy(TDClassChooserChoosen[playerid]);
		TDClassChooserChoosen[playerid] = TextDrawCreate(38.000000, 174.000000, "~g~>         <");//Change location.
		if (create == true)
		{
		Class_pickup[playerid][0] = CreatePickup(356,1,1654.3134,-955.5966,62.6696,playerid);//M4 ASSAULT RIFLE
		Class_pickup[playerid][1] = CreatePickup(348,1,1656.3134,-955.5966,62.6696,playerid);//Desert EAGLE
		Class_pickup[playerid][2] = CreatePickup(342,1,1658.3134,-955.5966,62.6696,playerid);//Grenade
		}
		//SetPlayerSkin(playerid,287);
		}
		 case 1:
		 {
		 TextDrawSetString(TDClassChooserSupport[playerid],"~g~Support");//Supprter is green , rest white
		 TextDrawSetString(TDClassChooserAssault[playerid],"~w~Assault");
		 TextDrawSetString(TDClassChooserSniper[playerid],"~w~Sniper");
		 TextDrawSetString(TDClassChooserEngineer[playerid],"~w~Engineer");
		 TextDrawDestroy(TDClassChooserChoosen[playerid]);
		 TDClassChooserChoosen[playerid] = TextDrawCreate(38.000000, 188.000000, "~g~>         <");
		 if (create == true)
		 {
		 Class_pickup[playerid][0] = CreatePickup(356,1,1654.3134,-955.5966,62.6696,playerid);//Combat Shotgun
		 Class_pickup[playerid][1] = CreatePickup(353,1,1656.3134,-955.5966,62.6696,playerid);//Rocket Launcher
		 Class_pickup[playerid][2] = CreatePickup(342,1,1658.3134,-955.5966,62.6696,playerid);//Grenade
		 }
		 //SetPlayerSkin(playerid,282);
		 }
		 case 2:
		 {
		 TextDrawSetString(TDClassChooserSniper[playerid],"~g~Sniper");//Sniper is green , rest white
		 TextDrawSetString(TDClassChooserAssault[playerid],"~w~Assault");
		  TextDrawSetString(TDClassChooserSupport[playerid],"~w~Support");
		  TextDrawSetString(TDClassChooserEngineer[playerid],"~w~Engineer");
		  TextDrawDestroy(TDClassChooserChoosen[playerid]);
		   TDClassChooserChoosen[playerid] = TextDrawCreate(38.000000, 202.000000, "~g~>         <");
		    if (create == true)
			{
			Class_pickup[playerid][0] = CreatePickup(358,1,1654.3134,-955.5966,62.6696,playerid);//Sniper
			Class_pickup[playerid][1] = CreatePickup(347,1,1656.3134,-955.5966,62.6696,playerid);//MP5
			Class_pickup[playerid][2] = CreatePickup(342,1,1658.3134,-955.5966,62.6696,playerid);//Grenade
			}
			//SetPlayerSkin(playerid,285);
			}
			case 3:
			{
			TextDrawSetString(TDClassChooserEngineer[playerid],"~g~Engineer");//Engineer is green , rest white
			TextDrawSetString(TDClassChooserAssault[playerid],"~w~Assault");
			TextDrawSetString(TDClassChooserSupport[playerid],"~w~Support");
			TextDrawSetString(TDClassChooserSniper[playerid],"~w~Sniper");
			TextDrawDestroy(TDClassChooserChoosen[playerid]);
			TDClassChooserChoosen[playerid] = TextDrawCreate(38.000000, 218.000000, "~g~>         <");
			if (create == true)
			{
			Class_pickup[playerid][0] = CreatePickup(356,1,1654.3134,-955.5966,62.6696,playerid);
			Class_pickup[playerid][1] = CreatePickup(360,1,1656.3134,-955.5966,62.6696,playerid);
			Class_pickup[playerid][2] = CreatePickup(342,1,1658.3134,-955.5966,62.6696,playerid);//Grenade
			}
			////SetPlayerSkin(playerid,163);
			}
			}
			SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE3);
			TextDrawBackgroundColor(TDClassChooserChoosen[playerid], 255);
			 TextDrawFont(TDClassChooserChoosen[playerid], 1);
			 TextDrawLetterSize(TDClassChooserChoosen[playerid], 0.500000, 1.000000);
			 TextDrawColor(TDClassChooserChoosen[playerid], 9830550);
			 TextDrawSetOutline(TDClassChooserChoosen[playerid], 1);
			 TextDrawSetProportional(TDClassChooserChoosen[playerid], 1);
			 TextDrawShowForPlayer(playerid,TDClassChooserChoosen[playerid]);
			 SetPVarInt(playerid,"AT",at);
			 return 1;
		 }
	return 1;
}/*
forward IsPlayerNearPlayer(playerid, n_playerid, Float:radius);
IsPlayerNearPlayer(playerid, n_playerid, Float:radius)
{
	new Float:npx, Float:npy, Float:npz;
	GetPlayerPos(n_playerid, npx, npy, npz);
	if(IsPlayerInRangeOfPoint(playerid, radius, npx, npy, npz))
	{
		return true;
	}
	else
	{
		return false;
	}
}*/
CMD:sp(playerid, params[])
{

if(gPlayerClass[playerid] == SUPPORT_CLASS)
{
	new pname[30];
	new string[64];
	new string2[64];
	new string3[64];
	new targetid;
	new tname[30];
    GetPlayerName(playerid,pname, sizeof(pname));
    GetPlayerName(playerid,tname, sizeof(tname));
    if(sscanf(params, "u", targetid)) return
		 SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /sp [playerid]") &&
		 SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will Give Ammo for Support Players");
		else if(targetid == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player is not connected!");
		else if(gTeam[playerid] != gTeam[targetid]) SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:You Can't Support Ammo Another Player Team !!");

		else if(IsPlayerNearPlayer(playerid,targetid, 10.0))
		{
			format(string,sizeof(string),"[SYSTEM]: You Support Ammo  Player : %s",pname );
			format(string2, 256,"[SYSTEM]: You got Support Ammo  By Support Player %s",tname );
			SendClientMessage(playerid,COLOR_ORANGE,string);
			SendClientMessage(targetid,COLOR_ORANGE,string2);
			format(string3, 256,"[SYSTEM]: Player %s got Support Ammo  By Support Player %s",pname,tname );
			print(string3);
			//
			if(gPlayerClass[targetid] == ASSAULT_CLASS)
    {
	GivePlayerWeapon(targetid,31,800);
	GivePlayerWeapon(targetid,22,800);
	GivePlayerWeapon(targetid,4,1);
	GivePlayerWeapon(targetid,33,80);
	GivePlayerWeapon(targetid,45,1);
    GivePlayerWeapon(targetid,16,5);
    //SendClientMessage(targetid, COLOR_GREEN,"You Can Heal Player by /theal");
    }
    if(gPlayerClass[targetid] == SUPPORT_CLASS)
    {
	GivePlayerWeapon(targetid,30,1500);
	GivePlayerWeapon(targetid,39,10);
	GivePlayerWeapon(targetid,40,10);
	GivePlayerWeapon(targetid,27,1500);
	GivePlayerWeapon(targetid,18,10);
	GivePlayerWeapon(targetid,29,1500);
	//SendClientMessage(targetid, COLOR_GREEN,"You Can Give Ammo Player by /sp and Get A C4 Bomber ! ");
    //SendClientMessage(targetid, COLOR_GREEN,"Your Ammo is Enough to Killed all Player In server !");
    }
    if(gPlayerClass[targetid] == SNIPER_CLASS)
    {
	GivePlayerWeapon(targetid,34,800);
	GivePlayerWeapon(targetid,23,800);
	GivePlayerWeapon(targetid,4,1);
	GivePlayerWeapon(targetid,41,800);
	GivePlayerWeapon(targetid,29,800);
	GivePlayerWeapon(targetid,25,800);
	//SendClientMessage(targetid, COLOR_GREEN,"You Can stealth by /(un)stealth");
    }

    if(gPlayerClass[targetid] == ENGINEER_CLASS)
    {
	GivePlayerWeapon(targetid,29,400);
	GivePlayerWeapon(targetid,24,50);
	GivePlayerWeapon(targetid,4,1);
	GivePlayerWeapon(targetid,36,10);
	GivePlayerWeapon(targetid,26,10);
    GivePlayerWeapon(playerid,30,10);
   	//SendClientMessage(targetid, COLOR_GREEN,"You Can use Your Heat Launcher clear thos enemy vehicle out !");
    }
			//
		}
		else SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You Can't Support Ammo This Player because you need to get near him or another Error!");

}
return 1;
}
CMD:theal(playerid, params[])
{

if(gPlayerClass[playerid] == ASSAULT_CLASS)
{
	new pname[30];
	new string[64];
	new string2[64];
	new string3[64];
	new targetid;
	new tname[30];
    GetPlayerName(playerid,pname, sizeof(pname));
    GetPlayerName(playerid,tname, sizeof(tname));
    if(sscanf(params, "u", targetid)) return
		 SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /theal [playerid]") &&
		 SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will Heal Team Players");
		else if(targetid == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player is not connected!");
		else if(gTeam[playerid] != gTeam[targetid]) SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:You Can't Heal Another Player Team !!");
		
		else if(IsPlayerNearPlayer(playerid,targetid, 10.0))
		{
			format(string,sizeof(string),"[SYSTEM]: You Heal Player : %s",pname );
			format(string2, 256,"[SYSTEM]: You got heal By Assault Player %s",tname );
			SendClientMessage(playerid,COLOR_ORANGE,string);
			SendClientMessage(targetid,COLOR_ORANGE,string2);
			format(string3, 256,"[SYSTEM]: Player %s got heal By Assault Player %s",pname,tname );
			print(string3);
			SetPlayerHealth(targetid,100);
		}
		else SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You Can't Heal This Player because you need to get near him or another Error!");
		
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
if(gTeam[playerid] == UK)
{
   SetPlayerMarkerForPlayer(playerid, i, GetPlayerColor(playerid) & invisible);
}
else if(gTeam[playerid] == SPAIN)
{
   SetPlayerMarkerForPlayer(playerid, i, GetPlayerColor(playerid) & invisible);
}
}
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
}*/
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
}/*
CMD:cclass(playerid, params[])

		{

        ShowPlayerDialog(playerid, 1, DIALOG_STYLE_LIST, "Classes", "Assault\nMedic\nSniper\nAnti-Vehicle\nEngineer", "Select", "Cancel");
        SetPlayerHealth(playerid,0);
		return 1;

		}
		*/
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
/*
    if(dialogid == 1)
			{
			    if(response)
			    	{
                        SendClientMessage(playerid, COLOR_WHITE, "[SYSTEM]: You Selected as Assault Unit");
                        SendClientMessage(playerid, COLOR_WHITE, "[SYSTEM]: You can change class by /cclass");
                        gPlayerClass[playerid] = ASSAULT_CLASS;
                        PickedClass[playerid] = 1;
        				SetPlayerVirtualWorld(playerid, 0);
        				TogglePlayerControllable(playerid, 1);
        				SpawnPlayer(playerid);
						}


                if(listitem == 1)//sniper DONE
			        {

                        SendClientMessage(playerid, COLOR_WHITE, "[SYSTEM]: You Selected as Medic Unit");
                        SendClientMessage(playerid, COLOR_WHITE, "[SYSTEM]: You can change class by /cclass");
                        gPlayerClass[playerid] = MEDIC_CLASS;
                        PickedClass[playerid] = 1;
        				SetPlayerVirtualWorld(playerid, 0);
        				TogglePlayerControllable(playerid, 1);
                       	SpawnPlayer(playerid);
					}
				if(listitem == 2)//sniper DONE
			        {

                        SendClientMessage(playerid, COLOR_WHITE, "[SYSTEM]: You Selected as Sniper Unit");
                        SendClientMessage(playerid, COLOR_WHITE, "[SYSTEM]: You can change class by /cclass");
                        SendClientMessage(playerid, COLOR_WHITE, "[SYSTEM]: You can stealth and unsteath by (un)stealth");
                        gPlayerClass[playerid] = SNIPER_CLASS;
                        PickedClass[playerid] = 1;
        				SetPlayerVirtualWorld(playerid, 0);
        				TogglePlayerControllable(playerid, 1);
						SpawnPlayer(playerid);
					}
				if(listitem == 3)//sniper DONE
			        {

                        SendClientMessage(playerid, COLOR_WHITE, "[SYSTEM]: You Selected as Anti-Vehicle Unit");
                        SendClientMessage(playerid, COLOR_WHITE, "[SYSTEM]: You can change class by /cclass");
                        gPlayerClass[playerid] = ANTI_CLASS;
                        PickedClass[playerid] = 1;
        				SetPlayerVirtualWorld(playerid, 0);
        				TogglePlayerControllable(playerid, 1);
                        SpawnPlayer(playerid);
					}
				if(listitem == 4)//sniper DONE
			        {

                        SendClientMessage(playerid, COLOR_WHITE, "[SYSTEM]: You Selected as Engineer Unit");
                        SendClientMessage(playerid, COLOR_WHITE, "[SYSTEM]: You can change class by /cclass");
                        gPlayerClass[playerid] = ENGINEER_CLASS;
                        PickedClass[playerid] = 1;
        				SetPlayerVirtualWorld(playerid, 0);
        				TogglePlayerControllable(playerid, 1);
                        SpawnPlayer(playerid);
					}
                       
			}*/
				
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
					timer[playerid][crash] = SetTimerEx("crashTimer", 25000, false,"i",playerid);
					GameTextForPlayer(playerid,"~r~Capturing",2000,3);
			} else return SendClientMessage(playerid, COLOR_RED,"[SYSTEM]: *This Zone is Already Captured By Your Team  !");
		} else return CaptureZoneMessage(playerid, 2);    
	}
	if(checkpointid == CP[bigear])
	{
		if(UnderAttack[bigear] == 0)
		{
			if(tCP[bigear] != gTeam[playerid])
			{       CountVar[playerid][bigear] = 25;
					Activebigear(playerid);
					timer[playerid][bigear] = SetTimerEx("bigearTimer", 25000, false,"i",playerid);
					GameTextForPlayer(playerid,"~r~Capturing",2000,3);
			} else return SendClientMessage(playerid, COLOR_RED,"[SYSTEM]: *This Zone is Already Captured By Your Team  !");
		} else return CaptureZoneMessage(playerid, 2);
	}
	if(checkpointid == CP[otm])
	{
		if(UnderAttack[otm] == 0)
		{
			if(tCP[otm] != gTeam[playerid])
			{       CountVar[playerid][otm] = 25;
					Activeotm(playerid);
					timer[playerid][otm] = SetTimerEx("otmTimer", 25000, false,"i",playerid);
					GameTextForPlayer(playerid,"~r~Capturing",2000,3);
			} else return SendClientMessage(playerid, COLOR_RED,"[SYSTEM]: *This Zone is Already Captured By Your Team  !");
		} else return CaptureZoneMessage(playerid, 2);
	}
	if(checkpointid == CP[oil])
	{
		if(UnderAttack[oil] == 0)
		{
			if(tCP[oil] != gTeam[playerid])
			{       CountVar[playerid][oil] = 25;
					Activeoil(playerid);
					timer[playerid][oil] = SetTimerEx("oilTimer", 25000, false,"i",playerid);
					GameTextForPlayer(playerid,"~r~Capturing",2000,3);
			} else return SendClientMessage(playerid, COLOR_RED,"[SYSTEM]: *This Zone is Already Captured By Your Team  !");
		} else return CaptureZoneMessage(playerid, 2);
	}
	if(checkpointid == CP[ct])
	{
		if(UnderAttack[ct] == 0)
		{
			if(tCP[ct] != gTeam[playerid])
			{       CountVar[playerid][ct] = 25;
					Activect(playerid);
					timer[playerid][ct] = SetTimerEx("ctTimer", 25000, false,"i",playerid);
					GameTextForPlayer(playerid,"~r~Capturing",2000,3);
			} else return SendClientMessage(playerid, COLOR_RED,"[SYSTEM]: *This Zone is Already Captured By Your Team  !");
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

	if(checkpointid == CP[oil] && Captured[playerid][oil] == 0 && IsPlayerCapturing[playerid][oil] == 1 && !IsPlayerInDynamicCP(playerid, CP[oil]))
	{
		Leavingoil(playerid);
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
			SendClientMessage(playerid, COLOR_RED,"[SYSTEM]: You cannot capture while in a vehicle!");
		}       
		case 2:       
		{           
			SendClientMessage(playerid, COLOR_RED,"[SYSTEM]: This zone is already being taken over!");
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
		SendClientMessage(playerid, 0xFFFFFFFF,"[SYSTEM]:  Stay in this checkpoint for 25 seconds to capture it! |");
		if(gTeam[playerid] == UK)
		{                  
			GangZoneFlashForAll(Zone[crash], COLOR_UK);
		}                
		else if(gTeam[playerid] == SPAIN)
		{                  
			GangZoneFlashForAll(Zone[crash], COLOR_SPAIN);
		}
		else if(gTeam[playerid] == GERMAN)
		{
			GangZoneFlashForAll(Zone[crash], COLOR_GERMAN);
		}              //------Message-----
		if(tCP[crash] == UK)
		{                  
			SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by UK!");
			SendClientMessageToAll(COLOR_GREY,"*[SYSTEM]:Zone Desert Airport is under attack!");
		}                
		else if(tCP[crash] == SPAIN)
		{                  
			SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by SPAIN!");
			SendClientMessageToAll(COLOR_GREY,"*[SYSTEM]:Zone Desert Airport is under attack!");
		}
		else if(tCP[crash] == GERMAN)
		{
			SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by GERMAN!");
			SendClientMessageToAll(COLOR_GREY,"*[SYSTEM]:Zone Desert Airport is under attack!");
		}

		else if(tCP[crash] == TEAM_NONE)                
		{                  
			SendClientMessage(playerid, COLOR_WHITE,"[SYSTEM]: This flag is not controlled by any team!");
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
		SendClientMessage(playerid, 0xFFFFFFFF,"[SYSTEM]:  Stay in this checkpoint for 25 seconds to capture it! |");
		if(gTeam[playerid] == UK)
		{
			GangZoneFlashForAll(Zone[bigear], COLOR_UK);
		}
		else if(gTeam[playerid] == SPAIN)
		{
			GangZoneFlashForAll(Zone[bigear], COLOR_SPAIN);
		}
		else if(gTeam[playerid] == GERMAN)
		{
			GangZoneFlashForAll(Zone[bigear], COLOR_GERMAN);
		}                //------Message-----
		if(tCP[bigear] == UK)
		{
			SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by UK!");
			SendClientMessageToAll(COLOR_GREY,"*[SYSTEM]:Big Ear is under attack!");
		}
		else if(tCP[bigear] == SPAIN)
		{
			SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by SPAIN!");
			SendClientMessageToAll(COLOR_GREY,"*[SYSTEM]:Big Ear is under attack!");
		}
		else if(tCP[bigear] == GERMAN)
		{
			SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by GERMAN!");
			SendClientMessageToAll(COLOR_GREY,"*[SYSTEM]:Big Ear is under attack!");
		}
		else if(tCP[bigear] == TEAM_NONE)
		{
			SendClientMessage(playerid, COLOR_WHITE,"[SYSTEM]: This flag is not controlled by any team!");
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
		SendClientMessage(playerid, 0xFFFFFFFF,"[SYSTEM]:  Stay in this checkpoint for 25 seconds to capture it! |");
		if(gTeam[playerid] == UK)
		{
			GangZoneFlashForAll(Zone[otm], COLOR_UK);
		}
		else if(gTeam[playerid] == SPAIN)
		{
			GangZoneFlashForAll(Zone[otm], COLOR_SPAIN);
		}
		else if(gTeam[playerid] == GERMAN)
		{
			GangZoneFlashForAll(Zone[otm], COLOR_GERMAN);
		}                //------Message-----
		if(tCP[otm] == UK)
		{
			SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by UK!");
			SendClientMessageToAll(COLOR_GREY,"*[SYSTEM]:Area 51 Zone is under attack!");
		}
		else if(tCP[otm] == SPAIN)
		{
			SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by SPAIN!");
			SendClientMessageToAll(COLOR_GREY,"*[SYSTEM]:Area 51 Zone is under attack!");
		}
		else if(tCP[otm] == GERMAN)
		{
			SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by GERMAN!");
			SendClientMessageToAll(COLOR_GREY,"*[SYSTEM]:Area 51 Zone is under attack!");
		}
		else if(tCP[otm] == TEAM_NONE)
		{
			SendClientMessage(playerid, COLOR_WHITE,"[SYSTEM]: This flag is not controlled by any team!");
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
stock Activeoil(playerid)
{
	if(UnderAttack[oil] == 0)
	{
		if(!IsPlayerInAnyVehicle(playerid))
		{                UnderAttack[oil] = 1;
		timer[playerid][oil] = SetTimerEx("oilTimer", 25000, false,"i",playerid);
		Captured[playerid][oil] = 0;
		SendClientMessage(playerid, 0xFFFFFFFF,"[SYSTEM]:  Stay in this checkpoint for 25 seconds to capture it! |");
		if(gTeam[playerid] == UK)
		{
			GangZoneFlashForAll(Zone[oil], COLOR_UK);
		}
		else if(gTeam[playerid] == SPAIN)
		{
			GangZoneFlashForAll(Zone[oil], COLOR_SPAIN);
		}
		else if(gTeam[playerid] == GERMAN)
		{
			GangZoneFlashForAll(Zone[oil], COLOR_GERMAN);
		}                 //------Message-----
		if(tCP[oil] == UK)
		{
			SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by UK!");
			SendClientMessageToAll(COLOR_GREY,"*[SYSTEM]:Octane Spring is under attack!");
		}
		else if(tCP[oil] == SPAIN)
		{
			SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by SPAIN!");
			SendClientMessageToAll(COLOR_GREY,"*[SYSTEM]:Octane Spring is under attack!");
		}
		else if(tCP[oil] == GERMAN)
		{
			SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by GERMAN!");
			SendClientMessageToAll(COLOR_GREY,"*[SYSTEM]:Octane Spring is under attack!");
		}
		else if(tCP[oil] == TEAM_NONE)
		{
			SendClientMessage(playerid, COLOR_WHITE,"[SYSTEM]: This flag is not controlled by any team!");
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
stock Activect(playerid)
{
	if(UnderAttack[ct] == 0)
	{
		if(!IsPlayerInAnyVehicle(playerid))
		{                UnderAttack[ct] = 1;
		timer[playerid][dam] = SetTimerEx("ctTimer", 25000, false,"i",playerid);
		Captured[playerid][ct] = 0;
		SendClientMessage(playerid, 0xFFFFFFFF,"[SYSTEM]:  Stay in this checkpoint for 25 seconds to capture it! |");
		if(gTeam[playerid] == UK)
		{
			GangZoneFlashForAll(Zone[ct], COLOR_UK);
		}
		else if(gTeam[playerid] == SPAIN)
		{
			GangZoneFlashForAll(Zone[ct], COLOR_SPAIN);
		}
		else if(gTeam[playerid] == GERMAN)
		{
			GangZoneFlashForAll(Zone[ct], COLOR_GERMAN);
		}                 //------Message-----
		if(tCP[ct] == UK)
		{
			SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by UK!");
			SendClientMessageToAll(COLOR_GREY,"*[SYSTEM]:Electric Zone is under attack!");
		}
		else if(tCP[ct] == SPAIN)
		{
			SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by SPAIN!");
			SendClientMessageToAll(COLOR_GREY,"*[SYSTEM]:Electric Zone is under attack!");
		}
		else if(tCP[ct] == GERMAN)
		{
			SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by GERMAN!");
			SendClientMessageToAll(COLOR_GREY,"*[SYSTEM]:Electric Zone is under attack!");
		}
		else if(tCP[ct] == TEAM_NONE)
		{
			SendClientMessage(playerid, COLOR_WHITE,"[SYSTEM]: This flag is not controlled by any team!");
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
	SendClientMessage(playerid, COLOR_GREEN,"Congratulations! You have captured the Desert Airport area! You received +5 scores and +$1500 cash!");    //==========================================================================
	for(new i = 0; i < MAX_PLAYERS; i++)    
	{       
		IsPlayerCapturing[i][crash] = 0;       
		if(gTeam[i] == gTeam[playerid])       
		{           
			SendClientMessage(i, 0xFFFFFFFF,"*[SYSTEM]:Your team has captured the Desert Airport area! You received +1 score for it!");
			GivePlayerScore(i, 1);       
			}    
		}    //==========================================================================    
	tCP[crash] = gTeam[playerid];    
	GangZoneStopFlashForAll(Zone[crash]);    //==========================================================================    
	if(gTeam[playerid] == SPAIN)
	{       
		GangZoneShowForAll(Zone[crash], COLOR_SPAIN);
	}    
	else if(gTeam[playerid] == UK)
	{    
		GangZoneShowForAll(Zone[crash], COLOR_UK);
	}
	else if(gTeam[playerid] == GERMAN)
	{
		GangZoneShowForAll(Zone[crash], COLOR_GERMAN);
	}    //==========================================================================
	new str[128];    
	format(str, sizeof(str),"%s has captured the Desert Airport zone!", GetName(playerid));
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
	SendClientMessage(playerid, COLOR_GREEN,"Congratulations! You have captured the BigEar area! You received +5 scores and +$1500 cash!");    //==========================================================================
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		IsPlayerCapturing[i][bigear] = 0;
		if(gTeam[i] == gTeam[playerid])
		{
			SendClientMessage(i, 0xFFFFFFFF,"*[SYSTEM]:Your team has captured the BigEar area! You received +1 score for it!");
			GivePlayerScore(i, 1);
			}
		}    //==========================================================================
	tCP[bigear] = gTeam[playerid];
	GangZoneStopFlashForAll(Zone[bigear]);    //==========================================================================
	if(gTeam[playerid] == SPAIN)
	{
		GangZoneShowForAll(Zone[bigear], COLOR_SPAIN);
	}
	else if(gTeam[playerid] == UK)
	{
		GangZoneShowForAll(Zone[bigear], COLOR_UK);
	}
	else if(gTeam[playerid] == GERMAN)
	{
		GangZoneShowForAll(Zone[bigear], COLOR_GERMAN);
	}   //==========================================================================
	new str[128];
	format(str, sizeof(str),"%s has captured the BigEar zone!", GetName(playerid));
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
	SendClientMessage(playerid, COLOR_GREEN,"Congratulations! You have captured the Area51! You received +5 scores and +$1500 cash!");    //==========================================================================
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		IsPlayerCapturing[i][otm] = 0;
		if(gTeam[i] == gTeam[playerid])
		{
			SendClientMessage(i, 0xFFFFFFFF,"*[SYSTEM]:Your team has captured the Area51! You received +1 score for it!");
			GivePlayerScore(i, 1);
			}
		}    //==========================================================================
	tCP[otm] = gTeam[playerid];
	GangZoneStopFlashForAll(Zone[otm]);    //==========================================================================
	if(gTeam[playerid] == SPAIN)
	{
		GangZoneShowForAll(Zone[otm], COLOR_SPAIN);
	}
	else if(gTeam[playerid] == UK)
	{
		GangZoneShowForAll(Zone[otm], COLOR_UK);
	}
	else if(gTeam[playerid] == GERMAN)
	{
		GangZoneShowForAll(Zone[otm], COLOR_GERMAN);
	}    //==========================================================================
	new str[128];
	format(str, sizeof(str),"%s has captured the Area51 zone!", GetName(playerid));
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
	SendClientMessage(playerid, COLOR_GREEN,"Congratulations! You have captured the Octane Spring area! You received +5 scores and +$1500 cash!");    //==========================================================================
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		IsPlayerCapturing[i][oil] = 0;
		if(gTeam[i] == gTeam[playerid])
		{
			SendClientMessage(i, 0xFFFFFFFF,"*[SYSTEM]:Your team has captured the Octane Spring area! You received +1 score for it!");
			GivePlayerScore(i, 1);
			}
		}    //==========================================================================
	tCP[oil] = gTeam[playerid];
	GangZoneStopFlashForAll(Zone[oil]);    //==========================================================================
	if(gTeam[playerid] == SPAIN)
	{
		GangZoneShowForAll(Zone[oil], COLOR_SPAIN);
	}
	else if(gTeam[playerid] == UK)
	{
		GangZoneShowForAll(Zone[oil], COLOR_UK);
	}
	else if(gTeam[playerid] == GERMAN)
	{
		GangZoneShowForAll(Zone[oil], COLOR_GERMAN);
	}     //==========================================================================
	new str[128];
	format(str, sizeof(str),"%s has captured the Octane Spring zone!", GetName(playerid));
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
	SendClientMessage(playerid, COLOR_GREEN,"Congratulations! You have captured the electroserver area! You received +5 scores and +$1500 cash!");    //==========================================================================
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		IsPlayerCapturing[i][ct] = 0;
		if(gTeam[i] == gTeam[playerid])
		{
			SendClientMessage(i, 0xFFFFFFFF,"*[SYSTEM]:Your team has captured the electroserver area! You received +1 score for it!");
			GivePlayerScore(i, 1);
			}
		}    //==========================================================================
	tCP[ct] = gTeam[playerid];
	GangZoneStopFlashForAll(Zone[ct]);    //==========================================================================
	if(gTeam[playerid] == SPAIN)
	{
		GangZoneShowForAll(Zone[ct], COLOR_SPAIN);
	}
	else if(gTeam[playerid] == UK)
	{
		GangZoneShowForAll(Zone[ct], COLOR_UK);
	}
	else if(gTeam[playerid] == GERMAN)
	{
		GangZoneShowForAll(Zone[ct], COLOR_GERMAN);
	}   //==========================================================================
	new str[128];
	format(str, sizeof(str),"%s has captured the electroserver zone!", GetName(playerid));
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
	SendClientMessage(playerid, COLOR_RED,"*[SYSTEM]:You have failed to capture this zone!");
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
	SendClientMessage(playerid, COLOR_RED,"*[SYSTEM]:You have failed to capture this zone!");
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
	SendClientMessage(playerid, COLOR_RED,"*[SYSTEM]:You have failed to capture this zone!");
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
	SendClientMessage(playerid, COLOR_RED,"*[SYSTEM]:You have failed to capture this zone!");
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
	SendClientMessage(playerid, COLOR_RED,"*[SYSTEM]:You have failed to capture this zone!");
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
forward oilTimer(playerid);
public oilTimer(playerid)
{
	oilCaptured(playerid);
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
public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
    if(issuerid != INVALID_PLAYER_ID && (weaponid == 34 || weaponid == 33) && bodypart == 9)
    {
        SetPlayerHealth(playerid, 0.0);
        new stringq[80];
        new name[20];
        new pname[20];
        GetPlayerName(playerid, name, sizeof(name));
        GetPlayerName(issuerid, pname, sizeof(pname));
        format(stringq, sizeof(stringq), "[SYSTEM]: %s was Killed by Headshot By %s ", name,pname);
        SendClientMessageToAll(COLOR_BLUE,stringq);
    }
    return 1;
}


