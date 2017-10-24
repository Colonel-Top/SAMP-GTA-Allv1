// This is a comment
// uncomment the line below if you want to write a filterscript
//#define FILTERSCRIPT

#include <a_samp>
//#include <file_ex>
//#define FILE_EX_NO_TRACKING
#include <zcmd>
#include <dini>
#include <sscanf2>
#include <dudb>
#include <foreach>
//#include <float>
#pragma tabsize 0
//#pragma dynamic 450000
#include <mapandreas> //you have to set it up on your own (see http://forum.sa-mp.com/index.php?topic=145196.0 )
#define players 150 //maximum of players in your server
#define chopperid 497 //ID of the vehicle model ( http://wiki.sa-mp.com/wiki/Vehicles:Helicopters )
#define ropelength 100 //length of slideable rope (ingame meters)
#define skinid 280 || 281 || 282 || 266 || 267 || 283 || 285 || 285 || 165 || 164 || 163 || 166 //the skin, who may slide down the rope ( http://wiki.sa-mp.com/wiki/Skins:All )
//new r0pes[players][ropelength],Float:pl_pos[players][100]; //cause pvar + array = sux
#define offsetz 90
#define dur 1800
#define DIALOGID 6969
static carid;
static adminname[45];
static wadmin[45];
//#emit
//#pragma tabsize 0
#pragma unused ret_memcpy
#define COLOR_LIGHTBLUE 0x33CCFFAA
//#define COLOR_RED 0xFF0000C8
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
#define SERVER_USER_FILE "AFadmin/Users/%s.ini"
#define ERROR "[SYSTEM][ERROR]:You not have Permission to use this Command"
#define l_red 0xFF0000AA
#define l_green 0x33FF33AA
static string3[200];
static string2[200];
static stringtext[64];
static aname[64];
static targetid;
static pname[64];
static msg[200];
static name[64];
static name2[64];
static Float:X, Float:Y, Float:Z, Float:angle;
//static Float:x, Float:y, Float:z;
new w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11;
//

//#pragma dynamic "string3"
/*
new Hour_ini[MAX_PLAYERS];
new Minute_ini[MAX_PLAYERS];
new Second_ini[MAX_PLAYERS];
new Minute[MAX_PLAYERS];*/
new bool:AdminDuty[MAX_PLAYERS];
new FreezeTimes[MAX_PLAYERS];

new wpid[MAX_PLAYERS];
static string[100];
new /*String[100],*/ Float:SpecX[MAX_PLAYERS], Float:SpecY[MAX_PLAYERS], Float:SpecZ[MAX_PLAYERS], vWorld[MAX_PLAYERS], Inter[MAX_PLAYERS];
new IsSpecing[MAX_PLAYERS], /*name[MAX_PLAYER_NAME],*/ IsBeingSpeced[MAX_PLAYERS],spectatorid[MAX_PLAYERS];
stock emsg(playerid, errorID)
{
if(errorID == 1)  return SendClientMessage(playerid,COLOR_RED1,"[SYSTEM][ERROR]:You not have Permission to use this Command");
if(errorID == 2)  return SendClientMessage(playerid,COLOR_RED1,"[SYSTEM][ERROR]:You not have Money Enough To Buy This Weapons !");
return 1;
}

enum gPlayerInfo
{
	LoggedIn,
	Register,
	Level,
	Muted,
	Kills,
	Death,
	Spawned,
	Hours,
 	Mins,
 	Secs,
 	Warnings,
 	Spec,
 	FailLogin,
	Kicked,
	Banned,
	Password,
	RPK,
	Money,
	Score,
	Skin,
	SkinStatus,
	savepos,
	Float:PosX,
	Float:PosY,
	Float:PosZ,
	interior,
	sex,
	age,
	team,
	Jail,
	ArmyLevel,
	pmstatus,
 Hungry
};
new PlayerText:TDKILLS[MAX_PLAYERS];
new PlayerText:TDDEATHS[MAX_PLAYERS];
new PlayerText:TDSCORE[MAX_PLAYERS];
new PlayerText:TDRANK[MAX_PLAYERS];
new PlayerText:TDWARN[MAX_PLAYERS];
new PlayerText:TDPMSTATUS[MAX_PLAYERS];
new PlayerText3D:label;
static str0[128],str10[128],form2[64],form3[64],form4[64],form5[64];//,form6[32];
new PlayerInfo[MAX_PLAYERS][gPlayerInfo];
enum ServerData
{
 	
	NameKick,
	PartNameKick,
	ForbiddenWeaps,
	MaxMuteWarnings,
	AntiAds,
	WarStatus
	
};
//new SInfo[ServerData];
enum playerstatus
{
	Sex,
	Age
};
//
//
//new Pstatus[MAX_PLAYERS][playerstatus];
//new bool:deathz[MAX_PLAYERS];
new bool:god[MAX_PLAYERS];
//new Moneyz[MAX_PLAYERS];
new Text:Textdraw0;
new Text:TextDrawKD;
//new Scores[MAX_PLAYERS];


forward Slide(playerid);
forward IsAChopper(vehicleid);
new Sliding[MAX_PLAYERS];
public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" System Organization Administrator");
	print("--------------------------------------\n");
	DisableInteriorEnterExits();
	MapAndreas_Init(MAP_ANDREAS_MODE_FULL);
	w1=CreatePickup(1210, 2, -72.9442,1211.7712,19.7422, -1);
	w2=CreatePickup(1210, 2,-182.7710,1160.4967,19.7500, -1);
	w3=CreatePickup(1210, 2, 221.8372,1869.0743,13.140, -1);
	w4=CreatePickup(1210, 2, -403.8879,2253.1096,42.4297, -1);
	w5=CreatePickup(1210, 2, -234.8588,2660.7241,62.6417, -1);
	w6=CreatePickup(1210, 2,-262.0183,2759.4980,62.3897, -1);
	w7=CreatePickup(1210, 2, 431.6148,2537.4353,16.2627, -1);
	w8=CreatePickup(1210, 2, 702.6701,1924.7272,5.6875 -1);
	w9=CreatePickup(1210, 2, 629.7870,1671.9229,6.9922, -1);
	w10=CreatePickup(1210,2, 588.3524,1247.4437,11.7188, -1);
	w11=CreatePickup(1210, 2,-309.8214,1590.2134,75.5625, -1);
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}


//=============================
//Forwards
forward GetVehicleModelIDFromName(vname[]);

//Defines


//PlayerInfo


//=============================
new /* newtext[45],*/ plname[MAX_PLAYER_NAME];


public OnPlayerConnect(playerid)
{
//

//Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);

  

TDSCORE[playerid] = CreatePlayerTextDraw(playerid,21.000000, 270.000000, "");//score
PlayerTextDrawBackgroundColor(playerid,TDSCORE[playerid], 255);
PlayerTextDrawFont(playerid,TDSCORE[playerid], 1);
PlayerTextDrawLetterSize(playerid,TDSCORE[playerid], 0.500000, 1.900000);
PlayerTextDrawColor(playerid,TDSCORE[playerid], -1);
PlayerTextDrawSetOutline(playerid,TDSCORE[playerid], 0);
PlayerTextDrawSetProportional(playerid,TDSCORE[playerid], 1);
PlayerTextDrawSetShadow(playerid,TDSCORE[playerid], 1);

TDRANK[playerid] = CreatePlayerTextDraw(playerid,496.000000, 109.000000, "");//rank
PlayerTextDrawBackgroundColor(playerid,TDRANK[playerid], 255);
PlayerTextDrawFont(playerid,TDRANK[playerid], 1);
PlayerTextDrawLetterSize(playerid,TDRANK[playerid], 0.500000, 1.900000);
PlayerTextDrawColor(playerid,TDRANK[playerid], -1);
PlayerTextDrawSetOutline(playerid,TDRANK[playerid], 0);
PlayerTextDrawSetProportional(playerid,TDRANK[playerid], 1);
PlayerTextDrawSetShadow(playerid,TDRANK[playerid], 1);

TDWARN[playerid] = CreatePlayerTextDraw(playerid,21.000000, 303.000000, "");//warn
PlayerTextDrawBackgroundColor(playerid,TDWARN[playerid], 255);
PlayerTextDrawFont(playerid,TDWARN[playerid], 1);
PlayerTextDrawLetterSize(playerid,TDWARN[playerid], 0.500000, 1.900000);
PlayerTextDrawColor(playerid,TDWARN[playerid], -1);
PlayerTextDrawSetOutline(playerid,TDWARN[playerid], 0);
PlayerTextDrawSetProportional(playerid,TDWARN[playerid], 1);
PlayerTextDrawSetShadow(playerid,TDWARN[playerid], 1);

TDPMSTATUS[playerid] = CreatePlayerTextDraw(playerid,150.000000, 400.000000, "");//pm
PlayerTextDrawBackgroundColor(playerid,TDPMSTATUS[playerid], 255);
PlayerTextDrawFont(playerid,TDPMSTATUS[playerid], 1);
PlayerTextDrawLetterSize(playerid,TDPMSTATUS[playerid], 0.500000, 1.900000);
PlayerTextDrawColor(playerid,TDPMSTATUS[playerid], -1);
PlayerTextDrawSetOutline(playerid,TDPMSTATUS[playerid], 0);
PlayerTextDrawSetProportional(playerid,TDPMSTATUS[playerid], 1);
PlayerTextDrawSetShadow(playerid,TDPMSTATUS[playerid], 1);

 TDKILLS[playerid] = CreatePlayerTextDraw(playerid,20.000000, 207.000000, "");//kill
PlayerTextDrawBackgroundColor(playerid,TDKILLS[playerid], 255);
PlayerTextDrawFont(playerid,TDKILLS[playerid], 1);
PlayerTextDrawLetterSize(playerid,TDKILLS[playerid], 0.500000, 1.900000);
PlayerTextDrawColor(playerid,TDKILLS[playerid], -1);
PlayerTextDrawSetOutline(playerid,TDKILLS[playerid], 0);
PlayerTextDrawSetProportional(playerid,TDKILLS[playerid], 1);
PlayerTextDrawSetShadow(playerid,TDKILLS[playerid], 1);

TDDEATHS[playerid] = CreatePlayerTextDraw(playerid,21.000000, 239.000000, "");//death
PlayerTextDrawBackgroundColor(playerid,TDDEATHS[playerid], 255);
PlayerTextDrawFont(playerid,TDDEATHS[playerid], 1);
PlayerTextDrawLetterSize(playerid,TDDEATHS[playerid], 0.500000, 1.900000);
PlayerTextDrawColor(playerid,TDDEATHS[playerid], -1);
PlayerTextDrawSetOutline(playerid,TDDEATHS[playerid], 0);
PlayerTextDrawSetProportional(playerid,TDDEATHS[playerid], 1);
PlayerTextDrawSetShadow(playerid,TDDEATHS[playerid], 1);
//
	Sliding[playerid] = 0;

TextDrawShowForPlayer(playerid,Textdraw0);
	/*
    PlayerInfo[playerid][LoggedIn] = 0;
	PlayerInfo[playerid][Register] = 0;
	PlayerInfo[playerid][Level] = 0;
	PlayerInfo[playerid][Muted] = 0;
	PlayerInfo[playerid][Kills] = 0;
	PlayerInfo[playerid][Death] = 0;
	PlayerInfo[playerid][Spawned] = 0;
	PlayerInfo[playerid][Hours] = 0;
 	PlayerInfo[playerid][Mins] = 0;
 	PlayerInfo[playerid][Secs] = 0;
 	PlayerInfo[playerid][Warnings] = 0;
 	PlayerInfo[playerid][Spec] = 0;
 	PlayerInfo[playerid][FailLogin] = 0;
	PlayerInfo[playerid][Kicked] = 0;
	PlayerInfo[playerid][Banned] = 0;
	PlayerInfo[playerid][RPK] = 0;
	PlayerInfo[playerid][Money] = 0;
	PlayerInfo[playerid][Score] = 0;
	*/
	//if(PlayerInfo[playerid][Banned]==1) return Kick(playerid);

	new /*name[MAX_PLAYER_NAME],*/ file[45];
	GetPlayerName(playerid, name, sizeof(name));
	format(file, sizeof(file), SERVER_USER_FILE, name);
	if (!dini_Exists(file))
	{
	    if(PlayerInfo[playerid][Register] == 0)
	    {
	    new welcometext[45], playerswelcome[MAX_PLAYER_NAME];
		GetPlayerName(playerid, playerswelcome, sizeof(playerswelcome));
		format(welcometext, sizeof(welcometext), "Welcome To Our Server %s ", playerswelcome);
	    SendClientMessage(playerid,COLOR_CYAN,"Your Name is not registered Please Register !");
		ShowPlayerDialog(playerid, 2323, DIALOG_STYLE_PASSWORD, welcometext , "Welcome, your name didn't registered now, Please input your registration password below", "Register", "Quit");
		}
		
	}
	if(fexist(file))
	{
	    new welcomeback[45], playerswelcome[MAX_PLAYER_NAME];
		GetPlayerName(playerid, playerswelcome, sizeof(playerswelcome));
		format(welcomeback, sizeof(welcomeback), "Welcome To Back Our Server %s ", playerswelcome);
		ShowPlayerDialog(playerid, 2424, DIALOG_STYLE_PASSWORD, welcomeback, "Let's Login to your account Please input your password to login", "Login", "Quit");

	}
	GetPlayerName(playerid, pname, sizeof(pname));
    format(string, sizeof(string), "Player %s (ID:%d) has Connected To the server", pname,playerid);
    SendClientMessageToAll(COLOR_LEMON, string);
	//
	//new pname[MAX_PLAYER_NAME];//, string[256 + MAX_PLAYER_NAME];
    
    return 1;


}


/*
forward TotalTime(playerid);
public TotalTime(playerid)
{
	if(PlayerInfo[playerid][Mins] == 60) return PlayerInfo[playerid][Mins]=0, PlayerInfo[playerid][Mins]++;
	if(Minute_ini[playerid] == 60) return Minute_ini[playerid]=0;
	if(PlayerInfo[playerid][Mins] == 60*60) return Hour_ini[playerid]++;
	if(Second_ini[playerid] == 60) return Second_ini[playerid]=0;
	PlayerInfo[playerid][Mins]++;
	Second_ini[playerid]++;
	return 1;
}*/
public OnPlayerUpdate(playerid)
{
     PlayerInfo[playerid][Money] = GetPlayerMoney(playerid);
	PlayerInfo[playerid][Score] = GetPlayerScore(playerid);
	return 1;
}
public OnPlayerDisconnect(playerid, reason)
{
    PlayerInfo[playerid][Money] = GetPlayerMoney(playerid);
	PlayerInfo[playerid][Score] = GetPlayerScore(playerid);
	if(PlayerInfo[playerid][RPK] == 1)
	{
	    new stext[45];
        //new name[MAX_PLAYER_NAME];
    	GetPlayerName(playerid, name, sizeof(name));
        format(stext, sizeof(stext), "[SYSTEM][WARNING] : Player %s has Died From Roleplay killed ! [SYSTEM][WARNING]", name);
        SendClientMessageToAll(COLOR_RED,stext);
        SendClientMessageToAll(COLOR_BLUE,stext);
        SendClientMessageToAll(COLOR_RED,stext);
         SendClientMessageToAll(COLOR_BLUE,stext);
         SendClientMessageToAll(COLOR_RED,stext);
        SendClientMessageToAll(COLOR_BLUE,stext);
        SendClientMessageToAll(COLOR_RED,stext);
         SendClientMessageToAll(COLOR_BLUE,stext);
         SetWeather(0);
	}
    
   // TextDrawHideForPlayer(playerid,Textdraw0);
    new /*name[MAX_PLAYER_NAME],*/ file[45];
	GetPlayerName(playerid, name, sizeof(name));
	format(file, sizeof(file), SERVER_USER_FILE, name);
	
	if(PlayerInfo[playerid][LoggedIn] == 1)
	{

//	dini_IntSet(file, "Password",udb_hash(inputtext));
	dini_IntSet(file, "Register", PlayerInfo[playerid][Register]);
	dini_IntSet(file, "Skin", PlayerInfo[playerid][Skin]);
	dini_IntSet(file, "SkinStatus", PlayerInfo[playerid][SkinStatus]);
	dini_IntSet(file, "Level", PlayerInfo[playerid][Level]);
	dini_IntSet(file, "Muted", PlayerInfo[playerid][Muted]);
	dini_IntSet(file, "Kills", PlayerInfo[playerid][Kills]);
	dini_IntSet(file, "Death", PlayerInfo[playerid][Death]);
	dini_IntSet(file, "Spawned", PlayerInfo[playerid][Spawned]);
	dini_IntSet(file, "Hours", PlayerInfo[playerid][Hours]);
	dini_IntSet(file, "Mins", PlayerInfo[playerid][Mins]);
	dini_IntSet(file, "Secs", PlayerInfo[playerid][Secs]);
	dini_IntSet(file, "Warnings", PlayerInfo[playerid][Warnings]);
	dini_IntSet(file, "Spec", PlayerInfo[playerid][Spec]);
	dini_IntSet(file, "FailLogin", PlayerInfo[playerid][FailLogin]);
	dini_IntSet(file, "Kicked", PlayerInfo[playerid][Kicked]);
	dini_IntSet(file, "Banned", PlayerInfo[playerid][Banned]);
	dini_IntSet(file, "RPK", PlayerInfo[playerid][RPK]);
	dini_IntSet(file, "pmstatus", PlayerInfo[playerid][pmstatus]);
	dini_IntSet(file, "Money", GetPlayerMoney(playerid));
	dini_IntSet(file, "Jail", PlayerInfo[playerid][Jail]);
	dini_IntSet(file, "Score", GetPlayerScore(playerid));
	dini_IntSet(file, "savepos", PlayerInfo[playerid][savepos]);
	dini_FloatSet(file, "PosX", PlayerInfo[playerid][PosX]);
	dini_FloatSet(file, "PosY", PlayerInfo[playerid][PosY]);
	dini_FloatSet(file, "PosZ", PlayerInfo[playerid][PosZ]);
	dini_FloatSet(file, "ArmyLevel", PlayerInfo[playerid][ArmyLevel]);
	dini_IntSet(file, "Interior", PlayerInfo[playerid][interior]);
	dini_IntSet(file, "Hungry", PlayerInfo[playerid][Hungry]);
	}
	PlayerInfo[playerid][LoggedIn] = 0;
	PlayerInfo[playerid][FailLogin]=0;
	PlayerInfo[playerid][pmstatus]=0;
	//
	//new pname[MAX_PLAYER_NAME];//, string[128 + MAX_PLAYER_NAME];
    GetPlayerName(playerid, pname, sizeof(pname));
    switch(reason)
    {
        case 0: format(string, sizeof(string), "Player : %s has Disconnected from the server. (Lost Connection)", pname);
        case 1: format(string, sizeof(string), "Player : %s has Disconnected from the server. (Leaving)", pname);
        case 2: format(string, sizeof(string), "Player : %s has Disconnected from the server. (Kicked/Banned)", pname);
    }
    SendClientMessageToAll(COLOR_LEMON, string);
	print(string);
	/*if(GetPVarInt(playerid,"roped") == 1)
	{
	    for(new destr=0;destr<=ropelength;destr++)
		{
		    DestroyObject(r0pes[playerid][destr]);
		}
		SetPVarInt(playerid,"roped",0);
	}*/
	PlayerTextDrawDestroy(playerid,TDKILLS[playerid]);
	PlayerTextDrawDestroy(playerid,TDDEATHS[playerid]);
	PlayerTextDrawDestroy(playerid,TDSCORE[playerid]);
	PlayerTextDrawDestroy(playerid,TDWARN[playerid]);
	PlayerTextDrawDestroy(playerid,TDRANK[playerid]);
	PlayerTextDrawDestroy(playerid,TDPMSTATUS[playerid]);
	return 1;
}

public OnPlayerSpawn(playerid)
{
 format(str0,sizeof(str0),"Kills : %d",PlayerInfo[playerid][Kills]);
     format(str10,sizeof(str10),"Death : %d",PlayerInfo[playerid][Death]);
	 PlayerTextDrawSetString(playerid,TDKILLS[playerid], str0);
    PlayerTextDrawSetString(playerid,TDDEATHS[playerid], str10);
  

/*
    if(deathz[playerid]==true)
 	{
		SetTimerEx("GiveMoney", 2800, false, "i", playerid);
		deathz[playerid]=false;
	}*/
    if(IsSpecing[playerid] == 1)
    {
        SetPlayerPos(playerid,SpecX[playerid],SpecY[playerid],SpecZ[playerid]);// Remember earlier we stored the positions in these variables, now we're gonna get them from the variables.
		SetPlayerInterior(playerid,Inter[playerid]);//Setting the player's interior to when they typed '/spec'
		SetPlayerVirtualWorld(playerid,vWorld[playerid]);//Setting the player's virtual world to when they typed '/spec'
		IsSpecing[playerid] = 0;//Just saying you're free to use '/spec' again YAY :D
		IsBeingSpeced[spectatorid[playerid]] = 0;//Just saying that the player who was being spectated
    }
    if(PlayerInfo[playerid][Skin] !=0 && PlayerInfo[playerid][SkinStatus]==1)
    {
	       SetPlayerSkin(playerid,PlayerInfo[playerid][Skin]);
    }
	
	if(PlayerInfo[playerid][Jail] > 0)
	{
	    SetTimerEx("SetPlayerUnjail",PlayerInfo[playerid][Jail], 1, "d", playerid);
	    SetPlayerPos(playerid,264.0814, 77.6404, 1001.0391);
		SetPlayerInterior(playerid,6);
		SendClientMessage(playerid,COLOR_RED1,"[SYSTEM]: You Can't Escape Your punishment you need to stay in jail until you're free");
	}
 	if(PlayerInfo[playerid][SkinStatus] == 1)
    {
        SetPlayerSkin(playerid,PlayerInfo[playerid][Skin]);
    }
    new /*name[MAX_PLAYER_NAME],*/ file[45];
	GetPlayerName(playerid, name, sizeof(name));
	format(file, sizeof(file), SERVER_USER_FILE, name);
PlayerInfo[playerid][Score]=GetPlayerScore(playerid);
    if(PlayerInfo[playerid][Score] >= 0 && PlayerInfo[playerid][Score] <= 50)
    {

		format(form2,sizeof(form2),"RANK : Pvt.");
  GetPlayerPos(playerid,X,Y,Z);
        label = CreatePlayer3DTextLabel(playerid,form2,COLOR_BLUE,X,Y,Z+0.4,35.0,playerid,INVALID_VEHICLE_ID,0);
    	PlayerTextDrawSetString(playerid,TDRANK[playerid], form2);
	}
	if(PlayerInfo[playerid][Score] >= 51 && PlayerInfo[playerid][Score] <= 100)
    {
    	format(form2,sizeof(form2),"RANK : Pvt St.");
     GetPlayerPos(playerid,X,Y,Z);
        label = CreatePlayer3DTextLabel(playerid,form2,COLOR_BLUE,X,Y,Z+0.4,35.0,playerid,INVALID_VEHICLE_ID,0);
    	PlayerTextDrawSetString(playerid,TDRANK[playerid], form2);
	}
	if(PlayerInfo[playerid][Score] >= 101 && PlayerInfo[playerid][Score] <= 150)
    {
    	format(form2,sizeof(form2),"RANK : Lance Cpl.");
     GetPlayerPos(playerid,X,Y,Z);
        label = CreatePlayer3DTextLabel(playerid,form2,COLOR_BLUE,X,Y,Z+0.4,35.0,playerid,INVALID_VEHICLE_ID,0);
    	PlayerTextDrawSetString(playerid,TDRANK[playerid], form2);
	}
	if(PlayerInfo[playerid][Score] >= 151 && PlayerInfo[playerid][Score] <= 250)
    {
	   	format(form2,sizeof(form2),"RANK : Cpl.");
     GetPlayerPos(playerid,X,Y,Z);
        label = CreatePlayer3DTextLabel(playerid,form2,COLOR_BLUE,X,Y,Z+0.4,35.0,playerid,INVALID_VEHICLE_ID,0);
    	PlayerTextDrawSetString(playerid,TDRANK[playerid], form2);
	}
	if(PlayerInfo[playerid][Score] >= 251 && PlayerInfo[playerid][Score] <= 350)
    {
	   	format(form2,sizeof(form2),"RANK : Sgt.");
     GetPlayerPos(playerid,X,Y,Z);
        label = CreatePlayer3DTextLabel(playerid,form2,COLOR_BLUE,X,Y,Z+0.4,35.0,playerid,INVALID_VEHICLE_ID,0);
    	PlayerTextDrawSetString(playerid,TDRANK[playerid], form2);
	}
	if(PlayerInfo[playerid][Score] >= 351 && PlayerInfo[playerid][Score] <= 500)
    {
	   	format(form2,sizeof(form2),"RANK : SSgt.");
     GetPlayerPos(playerid,X,Y,Z);
        label = CreatePlayer3DTextLabel(playerid,form2,COLOR_BLUE,X,Y,Z+0.4,35.0,playerid,INVALID_VEHICLE_ID,0);
    	PlayerTextDrawSetString(playerid,TDRANK[playerid], form2);
	}
	if(PlayerInfo[playerid][Score] >= 500 && PlayerInfo[playerid][Score] <= 750)
    {
	   	format(form2,sizeof(form2),"RANK : Wrnt Ofc.");
     GetPlayerPos(playerid,X,Y,Z);
        label = CreatePlayer3DTextLabel(playerid,form2,COLOR_BLUE,X,Y,Z+0.4,35.0,playerid,INVALID_VEHICLE_ID,0);
    	PlayerTextDrawSetString(playerid,TDRANK[playerid], form2);
	}
	if(PlayerInfo[playerid][Score] >= 751 && PlayerInfo[playerid][Score] <= 1000)
    {
	   	format(form2,sizeof(form2),"RANK : C.Wrnt.Ofc.");
     GetPlayerPos(playerid,X,Y,Z);
        label = CreatePlayer3DTextLabel(playerid,form2,COLOR_BLUE,X,Y,Z+0.4,35.0,playerid,INVALID_VEHICLE_ID,0);
    	PlayerTextDrawSetString(playerid,TDRANK[playerid], form2);
	}
	if(PlayerInfo[playerid][Score] >= 1001 && PlayerInfo[playerid][Score] <= 1600)
    {
	   	format(form2,sizeof(form2),"RANK : S.Lt.");
     GetPlayerPos(playerid,X,Y,Z);
        label = CreatePlayer3DTextLabel(playerid,form2,COLOR_BLUE,X,Y,Z+0.4,35.0,playerid,INVALID_VEHICLE_ID,0);
    	PlayerTextDrawSetString(playerid,TDRANK[playerid], form2);
	}
	if(PlayerInfo[playerid][Score] >= 1601 && PlayerInfo[playerid][Score] <= 2200)
    {
	   	format(form2,sizeof(form2),"RANK : Lt.");
     GetPlayerPos(playerid,X,Y,Z);
        label = CreatePlayer3DTextLabel(playerid,form2,COLOR_BLUE,X,Y,Z+0.4,35.0,playerid,INVALID_VEHICLE_ID,0);
    	PlayerTextDrawSetString(playerid,TDRANK[playerid], form2);
	}
	if(PlayerInfo[playerid][Score] >=  2201 && PlayerInfo[playerid][Score] <= 3500)
    {
	   	format(form2,sizeof(form2),"RANK : Cpt.");
     GetPlayerPos(playerid,X,Y,Z);
        label = CreatePlayer3DTextLabel(playerid,form2,COLOR_BLUE,X,Y,Z+0.4,35.0,playerid,INVALID_VEHICLE_ID,0);
    	PlayerTextDrawSetString(playerid,TDRANK[playerid], form2);
	}
	if(PlayerInfo[playerid][Score] >=  3501 && PlayerInfo[playerid][Score] <= 4000)
    {
	   	format(form2,sizeof(form2),"RANK : Major");
     GetPlayerPos(playerid,X,Y,Z);
        label = CreatePlayer3DTextLabel(playerid,form2,COLOR_BLUE,X,Y,Z+0.4,35.0,playerid,INVALID_VEHICLE_ID,0);
    	PlayerTextDrawSetString(playerid,TDRANK[playerid], form2);
	}
	if(PlayerInfo[playerid][Score] >=  4001 && PlayerInfo[playerid][Score] <= 4500)
    {
	   	format(form2,sizeof(form2),"RANK : Lt.Col.");
     GetPlayerPos(playerid,X,Y,Z);
        label = CreatePlayer3DTextLabel(playerid,form2,COLOR_BLUE,X,Y,Z+0.4,35.0,playerid,INVALID_VEHICLE_ID,0);
    	PlayerTextDrawSetString(playerid,TDRANK[playerid], form2);
	}
		if(PlayerInfo[playerid][Score] >=  4501 && PlayerInfo[playerid][Score] <= 5000)
    {
	   	format(form2,sizeof(form2),"RANK : Maj.Col.");
     GetPlayerPos(playerid,X,Y,Z);
        label = CreatePlayer3DTextLabel(playerid,form2,COLOR_BLUE,X,Y,Z+0.4,35.0,playerid,INVALID_VEHICLE_ID,0);
    	PlayerTextDrawSetString(playerid,TDRANK[playerid], form2);
	}
	if(PlayerInfo[playerid][Score] >=  5001 && PlayerInfo[playerid][Score] <= 5500)
    {
	   	format(form2,sizeof(form2),"RANK : Colonel");
     GetPlayerPos(playerid,X,Y,Z);
        label = CreatePlayer3DTextLabel(playerid,form2,COLOR_BLUE,X,Y,Z+0.4,35.0,playerid,INVALID_VEHICLE_ID,0);
    	PlayerTextDrawSetString(playerid,TDRANK[playerid], form2);
	}
	if(PlayerInfo[playerid][Score] >=  5501 && PlayerInfo[playerid][Score] <= 6000)
    {
	   	format(form2,sizeof(form2),"RANK : Maj.Gen.");
     GetPlayerPos(playerid,X,Y,Z);
        label = CreatePlayer3DTextLabel(playerid,form2,COLOR_BLUE,X,Y,Z+0.4,35.0,playerid,INVALID_VEHICLE_ID,0);
    	PlayerTextDrawSetString(playerid,TDRANK[playerid], form2);
	}
	if(PlayerInfo[playerid][Score] >=  6001 && PlayerInfo[playerid][Score] <= 7000)
    {
	   	format(form2,sizeof(form2),"RANK : Lt.General");
     GetPlayerPos(playerid,X,Y,Z);
        label = CreatePlayer3DTextLabel(playerid,form2,COLOR_BLUE,X,Y,Z+0.4,35.0,playerid,INVALID_VEHICLE_ID,0);
    	PlayerTextDrawSetString(playerid,TDRANK[playerid], form2);
	}
	if(PlayerInfo[playerid][Score] >=  7001 && PlayerInfo[playerid][Score] <= 8500)
    {
	   	format(form2,sizeof(form2),"RANK : General");
     GetPlayerPos(playerid,X,Y,Z);
        label = CreatePlayer3DTextLabel(playerid,form2,COLOR_BLUE,X,Y,Z+0.4,35.0,playerid,INVALID_VEHICLE_ID,0);
    	PlayerTextDrawSetString(playerid,TDRANK[playerid], form2);
	}
	if(PlayerInfo[playerid][Score] >=  8501 )
    {
	   	format(form2,sizeof(form2),"RANK : Gen.of Army");
     GetPlayerPos(playerid,X,Y,Z);
        label = CreatePlayer3DTextLabel(playerid,form2,COLOR_BLUE,X,Y,Z+0.4,35.0,playerid,INVALID_VEHICLE_ID,0);
    	PlayerTextDrawSetString(playerid,TDRANK[playerid], form2);
	}
    format(form3,sizeof(form3),"Score : %d",PlayerInfo[playerid][Score]);
    PlayerTextDrawSetString(playerid,TDSCORE[playerid], form3);
    format(form4,sizeof(form4),"Warning : %d",PlayerInfo[playerid][Warnings]);
    PlayerTextDrawSetString(playerid,TDWARN[playerid], form4);
	if(PlayerInfo[playerid][pmstatus]==1)
	{
    	format(form5,sizeof(form5),"PM STATUS : ON");
    	PlayerTextDrawSetString(playerid,TDPMSTATUS[playerid], form5);
 	}
 		if(PlayerInfo[playerid][pmstatus]==0)
	{
    	format(form5,sizeof(form5),"PM STATUS : OFF");
    	PlayerTextDrawSetString(playerid,TDPMSTATUS[playerid], form5);
 	}
  if(GetPlayerScore(playerid) >= 0 && GetPlayerScore(playerid) <= 50)
		{
    	//new string[45];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Private & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        //new Text3D:label = Create3DTextLabel("Rank : Private", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		//Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
		if(GetPlayerScore(playerid) >= 51 && GetPlayerScore(playerid) <= 100)
    	{
    	//new string[45];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Second Private & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        //new Text3D:label = Create3DTextLabel("Rank : Second Private", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		//Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
        if(GetPlayerScore(playerid) >= 101 && GetPlayerScore(playerid) <= 150)
    	{
    	//new string[45];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Lance Corporal & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        //new Text3D:label = Create3DTextLabel("Rank : Corporal", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		//Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
		if(GetPlayerScore(playerid) >= 151 && GetPlayerScore(playerid) <= 250)
    	{
    	//new string[45];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Corporal & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        //new Text3D:label = Create3DTextLabel("Rank : Sergeant", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		//Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
        if(GetPlayerScore(playerid) >= 251 && GetPlayerScore(playerid) <= 350)
    	{
    	//new string[45];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Sergeant & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        //new Text3D:label = Create3DTextLabel("Rank : Staff Sergeant", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
	//	Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
		if(GetPlayerScore(playerid) >= 351 && GetPlayerScore(playerid) <= 500)
    	{
    	//new string[45];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Staff Sergeant & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        //new Text3D:label = Create3DTextLabel("Rank : Lieutenant", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		//Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
        if(GetPlayerScore(playerid) >= 501 && GetPlayerScore(playerid) <= 750)
    	{
    	//new string[45];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Warrant Officer & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
       // new Text3D:label = Create3DTextLabel("Rank : Second Lieutenant", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		//Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
        if(GetPlayerScore(playerid) >= 751 && GetPlayerScore(playerid) <= 1000)
    	{
    	//new string[45];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Corporal Warrant Officer & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        //new Text3D:label = Create3DTextLabel("Rank : Captain", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		//Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
		if(GetPlayerScore(playerid) >= 1001 && GetPlayerScore(playerid) <= 1600)
    	{
    	//new string[45];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Second Lieutinant & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        //new Text3D:label = Create3DTextLabel("Rank : Major", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		//Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
		if(GetPlayerScore(playerid) >= 1601 && GetPlayerScore(playerid) <= 2200)
    	{
    	//new string[45];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Lieutinant & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        //new Text3D:label = Create3DTextLabel("Rank : Colonel", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		//Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		if(GetPlayerScore(playerid) >= 2201 && GetPlayerScore(playerid) <= 3500)
    	{
    	//new string[45];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Captain & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        //new Text3D:label = Create3DTextLabel("Rank : Marshall", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		//Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
		if(GetPlayerScore(playerid) >= 3501 && GetPlayerScore(playerid) <= 4000)
    	{
    	//new string[45];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Major & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        //new Text3D:label = Create3DTextLabel("Rank : Commander", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		//Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
        if(GetPlayerScore(playerid) >= 4001 && GetPlayerScore(playerid) <= 4500)
    	{
    	//new string[45];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Lieutinant Colonel & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        //new Text3D:label = Create3DTextLabel("Rank : Staff Commander", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		//Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
		if(GetPlayerScore(playerid) >= 4501 && GetPlayerScore(playerid) <= 5000)
    	{
    	//new string[45];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Major Colonel & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        //new Text3D:label = Create3DTextLabel("Rank : General", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		//Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		if(GetPlayerScore(playerid) >= 5001 && GetPlayerScore(playerid) <= 5500)
    	{
    	//new string[45];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Colonel & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        //new Text3D:label = Create3DTextLabel("Rank : General", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		//Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
		if(GetPlayerScore(playerid) >= 5501 && GetPlayerScore(playerid) <= 6000)
    	{
    	//new string[45];
		format(string, sizeof(string), "Rank INFO : Your Rank Is  Colonel & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        //new Text3D:label = Create3DTextLabel("Rank : General", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		//Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
		if(GetPlayerScore(playerid) >= 6001 && GetPlayerScore(playerid) <= 7000)
    	{
    	//new string[45];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Lieutenant General & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        //new Text3D:label = Create3DTextLabel("Rank : General", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		//Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
		if(GetPlayerScore(playerid) >= 7001 && GetPlayerScore(playerid) <= 8500)
    	{
    	//new string[45];
		format(string, sizeof(string), "Rank INFO : Your Rank Is General & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        //new Text3D:label = Create3DTextLabel("Rank : General", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		//Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		if(GetPlayerScore(playerid) >= 8601)
    	{
    	//new string[45];
		format(string, sizeof(string), "Rank INFO : Your Rank Is General of army & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        //new Text3D:label = Create3DTextLabel("Rank : General", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		//Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
 if(GetPVarInt(playerid,"typestatus") == 1)
 {
    PlayerTextDrawShow(playerid,TDKILLS[playerid]);
    PlayerTextDrawShow(playerid,TDDEATHS[playerid]);
    PlayerTextDrawShow(playerid,TDRANK[playerid]);
    PlayerTextDrawShow(playerid,TDSCORE[playerid]);
    PlayerTextDrawShow(playerid,TDPMSTATUS[playerid]);
    PlayerTextDrawShow(playerid,TDWARN[playerid]);
}

	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
/*
PlayerTextDrawHide(playerid,TDKILLS[playerid]);
    PlayerTextDrawHide(playerid,TDDEATHS[playerid]);
    PlayerTextDrawHide(playerid,TDRANK[playerid]);
    PlayerTextDrawHide(playerid,TDSCORE[playerid]);
    PlayerTextDrawHide(playerid,TDPMSTATUS[playerid]);
    PlayerTextDrawHide(playerid,TDWARN[playerid]);*/
    DeletePlayer3DTextLabel(playerid, label);
if(killerid != INVALID_PLAYER_ID)
	{
    
	if(IsBeingSpeced[playerid] == 1)
	{
	    for(new i=0; i<MAX_PLAYERS; i++)
	 	{
	 	    if(spectatorid[i] == playerid)
	 	    {
	 	        TogglePlayerSpectating(i,false);
			}
		}
	/*	deathz[playerid] = true;
	Moneyz[playerid] = GetPlayerMoney(playerid);
	ResetPlayerMoney(playerid);*/
	   
     if(PlayerInfo[playerid][RPK] == 1)
    {
        new stext[45];
//        new name[MAX_PLAYER_NAME];
    	GetPlayerName(playerid, name, sizeof(name));
        format(stext, sizeof(stext), "[SYSTEM][WARNING] : Player %s has Died From Roleplay killed ! [SYSTEM][WARNING]", name,sizeof(name));
        SendClientMessageToAll(COLOR_RED,stext);
        SendClientMessageToAll(COLOR_BLUE,stext);
        SendClientMessageToAll(COLOR_RED,stext);
         SendClientMessageToAll(COLOR_BLUE,stext);
         SendClientMessageToAll(COLOR_RED,stext);
        SendClientMessageToAll(COLOR_BLUE,stext);
        SendClientMessageToAll(COLOR_RED,stext);
         SendClientMessageToAll(COLOR_BLUE,stext);
         SetWeather(0);
    }
	/*
	if(GetPVarInt(playerid,"roped") == 1)
	{
	    for(new destr2=0;destr2<=ropelength;destr2++)
		{
		    DestroyObject(r0pes[playerid][destr2]);
		}
		SetPVarInt(playerid,"roped",0);
		DisablePlayerCheckpoint(playerid);
	}
	*/
    SendDeathMessage(killerid, playerid, reason);
     PlayerInfo[playerid][Money] = GetPlayerMoney(playerid);
	PlayerInfo[playerid][Score] = GetPlayerScore(playerid);
 PlayerInfo[killerid][Money] = GetPlayerMoney(killerid);
	PlayerInfo[killerid][Score] = GetPlayerScore(killerid);

	new gunname[45], stringt[86], fName[MAX_PLAYER_NAME], sName[MAX_PLAYER_NAME];
    GetWeaponName(reason,gunname,sizeof(gunname));
    GetPlayerName(playerid,fName,MAX_PLAYER_NAME);
    GetPlayerName(killerid,sName,MAX_PLAYER_NAME);
    format(stringt, sizeof(stringt), "Player : %s has Killed %s by using Weapons : %s.", sName, fName, gunname);
    SendClientMessageToAll(COLOR_PINK,stringt);
    //

    //
 

	}

   

	}
	
	//format(newtext, sizeof(newtext), "Name : %s     Kill : %d     Death : %d     Wanted Level : %d   Warning : %d",plname, PlayerInfo[playerid][Kills],PlayerInfo[playerid][Death],GetPlayerWantedLevel(playerid),PlayerInfo[playerid][Warnings]);
   // TextDrawSetString(TextDrawKD, newtext);
else
{
 //


  
    PlayerInfo[playerid][Death]++;
PlayerInfo[playerid][Money] = GetPlayerMoney(playerid);
	PlayerInfo[playerid][Score] = GetPlayerScore(playerid);
	

   // SetPlayerScore(playerid,PlayerInfo[playerid][Score]);
}


 new /*name[MAX_PLAYER_NAME],*/ file[45];
	GetPlayerName(playerid, name, sizeof(name));
	format(file, sizeof(file), SERVER_USER_FILE, name);

	if(PlayerInfo[playerid][LoggedIn] == 1)
	{
//	dini_IntSet(file, "Password",udb_hash(inputtext));
	dini_IntSet(file, "Register", PlayerInfo[playerid][Register]);
	dini_IntSet(file, "Skin", PlayerInfo[playerid][Skin]);
	dini_IntSet(file, "SkinStatus", PlayerInfo[playerid][SkinStatus]);
	dini_IntSet(file, "Level", PlayerInfo[playerid][Level]);
	dini_IntSet(file, "Muted", PlayerInfo[playerid][Muted]);
	dini_IntSet(file, "Kills", PlayerInfo[playerid][Kills]);
	dini_IntSet(file, "Death", PlayerInfo[playerid][Death]);
	dini_IntSet(file, "Spawned", PlayerInfo[playerid][Spawned]);
	dini_IntSet(file, "Hours", PlayerInfo[playerid][Hours]);
	dini_IntSet(file, "Mins", PlayerInfo[playerid][Mins]);
	dini_IntSet(file, "Secs", PlayerInfo[playerid][Secs]);
	dini_IntSet(file, "Warnings", PlayerInfo[playerid][Warnings]);
	dini_IntSet(file, "Spec", PlayerInfo[playerid][Spec]);
	dini_IntSet(file, "FailLogin", PlayerInfo[playerid][FailLogin]);
	dini_IntSet(file, "Kicked", PlayerInfo[playerid][Kicked]);
	dini_IntSet(file, "Banned", PlayerInfo[playerid][Banned]);
	dini_IntSet(file, "RPK", PlayerInfo[playerid][RPK]);
	dini_IntSet(file, "pmstatus", PlayerInfo[playerid][pmstatus]);
	dini_IntSet(file, "Money", GetPlayerMoney(playerid));
	dini_IntSet(file, "Jail", PlayerInfo[playerid][Jail]);
	dini_IntSet(file, "Score", GetPlayerScore(playerid));
	dini_IntSet(file, "savepos", PlayerInfo[playerid][savepos]);
	dini_FloatSet(file, "PosX", PlayerInfo[playerid][PosX]);
	dini_FloatSet(file, "PosY", PlayerInfo[playerid][PosY]);
	dini_FloatSet(file, "PosZ", PlayerInfo[playerid][PosZ]);
	dini_FloatSet(file, "ArmyLevel", PlayerInfo[playerid][ArmyLevel]);
	dini_IntSet(file, "Interior", PlayerInfo[playerid][interior]);
	dini_IntSet(file, "Hungry", PlayerInfo[playerid][Hungry]);
//	printf("Prnting when died %d",PlayerInfo[playerid][Kills]);
	}
	    format(str0,sizeof(str0),"Kills : %d",PlayerInfo[playerid][Kills]);
     format(str10,sizeof(str10),"Death : %d",PlayerInfo[playerid][Death]);
	 PlayerTextDrawSetString(playerid,TDKILLS[playerid], str0);
    PlayerTextDrawSetString(playerid,TDDEATHS[playerid], str10);
    
 
return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
/*
    if(GetVehicleModel(vehicleid) == chopperid)
	{
	    for(new shg=0;shg<=players;shg++)
	    {
	        if(GetPVarInt(shg,"chop_id") == vehicleid && GetPVarInt(shg,"roped") == 1)
	        {
	            DisablePlayerCheckpoint(shg);
	            SetPVarInt(shg,"roped",0);
	            DisablePlayerCheckpoint(shg);
	            ClearAnimations(shg);
	            TogglePlayerControllable(shg,1);
	            for(new destr3=0;destr3<=ropelength;destr3++)
				{
				    DestroyObject(r0pes[shg][destr3]);
				}
			}
		}
	}*/
	return 1;
}


public OnPlayerText( playerid, text[ ] )
{    // code..
	if(PlayerInfo[playerid][Muted]==0)
	{
	    if(text[0] == '!')
    	{
    //new string[128];
    		GetPlayerName(playerid, string, sizeof(string));
    		format(string, sizeof(string), "[Team Radio] %s: %s", string, text[1]);
    		for(new i = 0; i < MAX_PLAYERS; i++)
    		{
    			if(GetPlayerTeam(i) == GetPlayerTeam(playerid)) SendClientMessage(i, GetPlayerColor(playerid), string);
    		}
		}
	   format(string,sizeof(string),"%s[%d]: {FFFFFF}%s",name,playerid,text);
    SendClientMessageToAll(GetPlayerColor(playerid),string);
    SetPlayerChatBubble(playerid, text, COLOR_BLUE, 100.0, 8000);
    
	}
	else
	{
		SendClientMessage(playerid, COLOR_CYAN, "[SYSTEM][MUTED] - You can't talk while you're muted!");
		return 0;
	}
	return 0; // Return 0 at the end as well to prevent the default chat from being sent}
}





#define GELTONA 0xFFFF00FF
#define BALTA 0xFFFFFFFF


public IsAChopper(vehicleid)
{
	if(vehicleid >= 1 && vehicleid <= 497) // < Define your Chopper ID's Here
	{
	return 1;
	}
	return 0;
}




forward syncanim(playerid);
public syncanim(playerid)
{
	if(GetPVarInt(playerid,"roped") == 0)
	{
	    SetTimerEx("timeout", 100, false, "i", playerid);
	}
	else
	{
	SetTimerEx("syncanim",dur,0,"i",playerid);
	ApplyAnimation(playerid,"ped","abseil",4.0,0,0,0,1,0);
 	}

	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if(GetVehicleModel(vehicleid) == chopperid && ispassenger)
	{
		SetPVarInt(playerid,"chop_id",GetPlayerVehicleID(playerid));
		SetPVarInt(playerid,"roped",0);
	}
	else SetPVarInt(playerid,"chop_id",0);
for(new i=0; i<MAX_PLAYERS; i++)
{

	if(vehicleid == GetPlayerVehicleID(i))
	{
		if(IsPlayerInVehicle(i, vehicleid))
		{
			if(GetPlayerTeam(i) == GetPlayerTeam(playerid))
			{
			
				GetPlayerPos(playerid, X, Y, Z);
				SetPlayerPos(playerid, X, Y, Z+2);
				SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]: You can not jack a team vehicle !");
				RemovePlayerFromVehicle(playerid);
			}
		}
	}
}
	return 1;
}
forward end(playerid);
public end(playerid)
{
    SetPVarInt(playerid,"roped",0);
    SetPVarInt(playerid,"chop_id",0);
	return 1;
}/*
forward timeout(playerid);
public timeout(playerid)
{
    SetPVarInt(playerid,"roped",0);
    SetPVarInt(playerid,"chop_id",0);
    	ClearAnimations(playerid);
        TogglePlayerControllable(playerid,0);
        TogglePlayerControllable(playerid,1);
        //DisablePlayerCheckpoint(playerid);
        for(new destr4=0;destr4<=ropelength;destr4++)
		{
		    DestroyObject(r0pes[playerid][destr4]);
		}
 	 return 1;
}
*/
public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    if(newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)//
    {
        if(IsBeingSpeced[playerid] == 1)//
        {
            foreach(Player,i)
            {
                 if(spectatorid[i] == playerid)
                 PlayerSpectateVehicle(i, GetPlayerVehicleID(playerid));// Letting the spectator, spectate the vehicle of the player being spectated (I hope you understand this xD)
			}
		}
	}
 	if(newstate == PLAYER_STATE_ONFOOT)
  	{
	  	if(IsBeingSpeced[playerid] == 1)//If the player being spectated, exists a vehicle, then let the spectator spectate the player.
	  	{
		  	foreach(Player,i)
		  	{
			  	if(spectatorid[i] == playerid)
			  	{
				  	PlayerSpectatePlayer(i, playerid);// Letting the spectator, spectate the player who exited the vehicle
				}
			}
		}
	}
		if(newstate == PLAYER_STATE_DRIVER)
	{
		if((GetTickCount()-GetPVarInt(playerid, "cartime")) < 1000) // enters veh as driver faster than 1 once
	    {
			SetPVarInt(playerid, "carspam", GetPVarInt(playerid, "carspam")+1);
			if(GetPVarInt(playerid, "carspam") >= 5) // allows 5 seconds leeway to compensate for glitching, then kicks
	        {
	        	//new name[24];
	        	new string128[45];
				GetPlayerName(playerid,name,24);
	            format(string128,sizeof(string128),"[SYSTEM][WARNING] Kicked ID:[%i] Player %s for CAR SPAM hacks",playerid,name);
	            SendClientMessageToAll(COLOR_RED,string128);
	            print(string128);
				return Kick(playerid);
	        }
	  	}
	  	SetPVarInt(playerid, "cartime", GetTickCount());
  	}
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
	if(pickupid == w1 || w2 || w3 || w4|| w5||w6||w7||w8||w9||w10||w11)
	{
	    ShowPlayerDialog(playerid, 8177, 2, "Weapons Store", "Melee 200$\nExplosive 750$\nPistols 600$\nShotguns 1200$\nSub-machine guns1500$\nAssault-Rifles 2000$\nHeavy weapons 3500$\nHand held 100$\nApparel 200$\nSpecial 800$", "Select", "Exit");
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
    if(IsBeingSpeced[playerid] == 1)
    {
        foreach(Player,i)
        {
            if(spectatorid[i] == playerid)
            {
                SetPlayerInterior(i,GetPlayerInterior(playerid));
				SetPlayerVirtualWorld(i,GetPlayerVirtualWorld(playerid));
            }
        }
    }
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    //	if(GetPlayerSkin(playerid) == skinid && GetPVarInt(playerid,"roped") == 0 && GetPlayerVehicleSeat(playerid) != 0 && IsPlayerInAnyVehicle(playerid) && (newkeys & KEY_SUBMISSION || newkeys == KEY_SUBMISSION))
/*	{
		GetPlayerPos(playerid,pl_pos[playerid][0],pl_pos[playerid][1],pl_pos[playerid][2]);
		MapAndreas_FindZ_For2DCoord(pl_pos[playerid][0],pl_pos[playerid][1],pl_pos[playerid][3]);
		pl_pos[playerid][4] = floatsub(pl_pos[playerid][2],pl_pos[playerid][3]);
		if(pl_pos[playerid][4] >= ropelength) return SendClientMessage(playerid,0xAA3333AA,"[SYSTEM][ERROR]: You are too scared to slide from this height");
		if(pl_pos[playerid][4] <= 2) return RemovePlayerFromVehicle(playerid);
		SetPVarInt(playerid,"roped",1);
		//SetPlayerCheckpoint(playerid,pl_pos[playerid][0],pl_pos[playerid][1],floatsub(pl_pos[playerid][3],offsetz),20);
		SetPlayerPos(playerid,pl_pos[playerid][0],pl_pos[playerid][1],floatsub(pl_pos[playerid][2],2));
		SetPlayerVelocity(playerid,0,0,0);
		for(new rep=0;rep!=10;rep++) ApplyAnimation(playerid,"ped","abseil",4.0,0,0,0,1,0);
		for(new cre=0;cre<=pl_pos[playerid][4];cre++)
		{
		    r0pes[playerid][cre] = CreateObject(3004,pl_pos[playerid][0],pl_pos[playerid][1],floatadd(pl_pos[playerid][3],cre),87.640026855469,342.13500976563, 350.07507324219);
		}
		SetTimerEx("syncanim",dur,0,"i",playerid);
		SetTimerEx("end", 1700, false, "i", playerid);
		new string[45];
		new playername[60];
		GetPlayerName(playerid,playername,sizeof(playername));
		format(string,sizeof(string),"[SYSTEM]: Player %s has catch a rope and start Roping Down From Helicopter",playername);
		SendClientMessageToAll(COLOR_GREEN,string);
	}
*/	//

	return 1;

}

public OnRconLoginAttempt(ip[], password[], success)
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

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
///
///
//new Float: X, Float: Y, Float: Z;
    GetPlayerPos(playerid,X,Y,Z);
   

///
///
 if(dialogid == 2323)
 {
    new welcometext[45], playerswelcome[MAX_PLAYER_NAME];
		GetPlayerName(playerid, playerswelcome, sizeof(playerswelcome));
		format(welcometext, sizeof(welcometext), "Welcome To Our Server %s ", playerswelcome);
 	new /*name[MAX_PLAYER_NAME],*/ file[45];//, /*string[45];*/
 	GetPlayerName(playerid, name, sizeof(name));
 	format(file, sizeof(file), SERVER_USER_FILE, name);
 	if(!response) return Kick(playerid);
 	if (!strlen(inputtext)) return
 	ShowPlayerDialog(playerid, 2323, DIALOG_STYLE_PASSWORD, welcometext, "Welcome, your name didn't registered now, Please Input your registration password below", "Register", "Quit");
	dini_Create(file);
    dini_IntSet(file, "Password",udb_hash(inputtext));
	dini_IntSet(file, "Register", PlayerInfo[playerid][Register]=1);
	dini_IntSet(file, "Skin", PlayerInfo[playerid][Skin]=0);
	dini_IntSet(file, "SkinStatus", PlayerInfo[playerid][SkinStatus]=0);
	dini_IntSet(file, "Level", PlayerInfo[playerid][Level]=0);
	dini_IntSet(file, "Muted", PlayerInfo[playerid][Muted]=0);
	dini_IntSet(file, "Kills", PlayerInfo[playerid][Kills]=0);
	dini_IntSet(file, "Death", PlayerInfo[playerid][Death]=0);
	dini_IntSet(file, "Spawned", PlayerInfo[playerid][Spawned]=0);
	dini_IntSet(file, "Hours", PlayerInfo[playerid][Hours]=0);
	dini_IntSet(file, "Mins", PlayerInfo[playerid][Mins]=0);
	dini_IntSet(file, "Secs", PlayerInfo[playerid][Secs]=0);
	dini_IntSet(file, "Warnings", PlayerInfo[playerid][Warnings]=0);
	dini_IntSet(file, "Spec", PlayerInfo[playerid][Spec]=0);
	dini_IntSet(file, "FailLogin", PlayerInfo[playerid][FailLogin]=0);
	dini_IntSet(file, "Kicked", PlayerInfo[playerid][Kicked]=0);
	dini_IntSet(file, "Banned", PlayerInfo[playerid][Banned]=0);
	dini_IntSet(file, "RPK", PlayerInfo[playerid][RPK]=0);
	dini_IntSet(file, "pmstatus", PlayerInfo[playerid][pmstatus]=1);
	dini_IntSet(file, "Money", PlayerInfo[playerid][Money]=0);
	dini_IntSet(file, "Jail", PlayerInfo[playerid][Jail]=0);
	dini_IntSet(file, "Score", PlayerInfo[playerid][Score]=0);
	dini_IntSet(file, "savepos", PlayerInfo[playerid][savepos]=0);
	dini_FloatSet(file, "PosX", PlayerInfo[playerid][PosX]=0);
	dini_FloatSet(file, "PosY", PlayerInfo[playerid][PosY]=0);
	dini_FloatSet(file, "PosZ", PlayerInfo[playerid][PosZ]=0);
	dini_FloatSet(file, "ArmyLevel", PlayerInfo[playerid][ArmyLevel]=0);
	dini_IntSet(file, "Interior", PlayerInfo[playerid][interior]=0);
	dini_IntSet(file, "Hungry", PlayerInfo[playerid][Hungry]=7200);
	PlayerInfo[playerid][pmstatus]=1;
	format(string, 128, "[SYSTEM]: You Succesfully Registered The Nickname %s with password %s, you have been automatically logged in.", name, inputtext);
	SendClientMessage(playerid, COLOR_RED1, string);
 	PlayerInfo[playerid][LoggedIn]=1;
 	PlayerInfo[playerid][Register]=1;
 	 GetPlayerName(playerid, plname, MAX_PLAYER_NAME);
     //       format(newtext, sizeof(newtext), "Name : %s     Kill : %d     Death : %d     Wanted Level : %d   Warning : %d",plname, PlayerInfo[playerid][Kills],PlayerInfo[playerid][Death],GetPlayerWantedLevel(playerid),PlayerInfo[playerid][Warnings]);
  //  TextDrawSetString(TextDrawKD, newtext);
    
 	ShowPlayerDialog(playerid, 334, DIALOG_STYLE_LIST, "Please Select Your Sex", "Male\nFemale", "Select", "");

}
if(dialogid == 9876)
 {
    new welcometext[45], playerswelcome[MAX_PLAYER_NAME];
		GetPlayerName(playerid, playerswelcome, sizeof(playerswelcome));
		format(welcometext, sizeof(welcometext), "Welcome To Our Server %s ", playerswelcome);
 	new /*name[MAX_PLAYER_NAME],*/ file[45];//, /*string[45];*/
 	GetPlayerName(playerid, name, sizeof(name));
 	format(file, sizeof(file), SERVER_USER_FILE, name);
 	if(!response) return Kick(playerid);
 	if (!strlen(inputtext)) return
 	ShowPlayerDialog(playerid, 9876, DIALOG_STYLE_PASSWORD, welcometext , "Welcome, your have changed your name by setname of administrator and server didn't registered , Please input your registration password below", "Register", "Quit");
	dini_Create(file);
    dini_IntSet(file, "Password",udb_hash(inputtext));
    PlayerInfo[playerid][LoggedIn] = 1;
	dini_IntSet(file, "Register", PlayerInfo[playerid][Register]);
	dini_IntSet(file, "Skin", PlayerInfo[playerid][Skin]);
	dini_IntSet(file, "SkinStatus", PlayerInfo[playerid][SkinStatus]);
	dini_IntSet(file, "Level", PlayerInfo[playerid][Level]);
	dini_IntSet(file, "Muted", PlayerInfo[playerid][Muted]);
	dini_IntSet(file, "Kills", PlayerInfo[playerid][Kills]);
	dini_IntSet(file, "Death", PlayerInfo[playerid][Death]);
	dini_IntSet(file, "Spawned", PlayerInfo[playerid][Spawned]);
	dini_IntSet(file, "Hours", PlayerInfo[playerid][Hours]);
	dini_IntSet(file, "Mins", PlayerInfo[playerid][Mins]);
	dini_IntSet(file, "Secs", PlayerInfo[playerid][Secs]);
	dini_IntSet(file, "Warnings", PlayerInfo[playerid][Warnings]);
	dini_IntSet(file, "Spec", PlayerInfo[playerid][Spec]);
	dini_IntSet(file, "FailLogin", PlayerInfo[playerid][FailLogin]);
	dini_IntSet(file, "Kicked", PlayerInfo[playerid][Kicked]);
	dini_IntSet(file, "Banned", PlayerInfo[playerid][Banned]);
	dini_IntSet(file, "RPK", PlayerInfo[playerid][RPK]);
	dini_IntSet(file, "pmstatus", PlayerInfo[playerid][pmstatus]);
	dini_IntSet(file, "Money", PlayerInfo[playerid][Money]);
	dini_IntSet(file, "Jail", PlayerInfo[playerid][Jail]);
	dini_IntSet(file, "Score", PlayerInfo[playerid][Score]);
	dini_IntSet(file, "savepos", PlayerInfo[playerid][savepos]);
	dini_FloatSet(file, "PosX", PlayerInfo[playerid][PosX]);
	dini_FloatSet(file, "PosY", PlayerInfo[playerid][PosY]);
	dini_FloatSet(file, "PosZ", PlayerInfo[playerid][PosZ]);
	dini_FloatSet(file, "ArmyLevel", PlayerInfo[playerid][ArmyLevel]);
	dini_IntSet(file, "Interior", PlayerInfo[playerid][interior]);
	dini_IntSet(file, "Hungry", PlayerInfo[playerid][Hungry]);
//	PlayerInfo[playerid][pmstatus]=1;
	format(string, 128, "[SYSTEM]: You Succesfully Registered The Nickname %s with password %s, you have been automatically logged in.", name, inputtext);
	SendClientMessage(playerid, COLOR_RED1, string);
 	PlayerInfo[playerid][LoggedIn]=1;
 	PlayerInfo[playerid][Register]=1;
 	 GetPlayerName(playerid, plname, MAX_PLAYER_NAME);
      //      format(newtext, sizeof(newtext), "Name : %s     Kill : %d     Death : %d     Wanted Level : %d   Warning : %d",plname, PlayerInfo[playerid][Kills],PlayerInfo[playerid][Death],GetPlayerWantedLevel(playerid),PlayerInfo[playerid][Warnings]);
   // TextDrawSetString(TextDrawKD, newtext);

 	ShowPlayerDialog(playerid, 334, DIALOG_STYLE_LIST, "Please Select Your Sex", "Male\nFemale", "Select", "");

}
     if(dialogid == 334)
    {
        if(response) // If they clicked 'Select' or double-clicked a weapon
        {
            // Give them the weapon
            switch(listitem)
            {
                case 0: PlayerInfo[playerid][sex]=1; //male
                case 1: PlayerInfo[playerid][sex]=2; //female
            }
			new /*name[MAX_PLAYER_NAME],*/ file[45];
			GetPlayerName(playerid, name, sizeof(name));
			format(file, sizeof(file), SERVER_USER_FILE, name);
			dini_IntSet(file, "sex", PlayerInfo[playerid][sex]);
            ShowPlayerDialog(playerid, 445, DIALOG_STYLE_INPUT, "Please Insert Your Age", "Insert Age Number Below : ", "Ok", "");
        }
        return 1;
    }
    if(dialogid == 445)
    {
        if(!response) // If they clicked 'Cancel' or pressed esc
        {
            Kick(playerid);

            //For info & code of this function please refer to the bottom of this article.
        }
        else // Pressed ENTER or clicked 'Login' button
        {
			new /*name[MAX_PLAYER_NAME],*/ file[45];
			GetPlayerName(playerid, name, sizeof(name));
			format(file, sizeof(file), SERVER_USER_FILE, name);
            PlayerInfo[playerid][age]= strval(inputtext);
			dini_IntSet(file, "age", PlayerInfo[playerid][age]);
			//ShowPlayerDialog(playerid, 560, DIALOG_STYLE_LIST, "Please Select Your Nationality From City ", "Newyork City (USA.)\nMoscow City (Russia)", "Select", "");
            
        }
        return 1; // We handled a dialog, so return 1. Just like OnPlayerCommandText.
    }
	if(dialogid == 560)
    {
        if(response) // If they clicked 'Select' or double-clicked a weapon
        {
            // Give them the weapon
            switch(listitem)
            {
                case 0: PlayerInfo[playerid][team]=1; //newyork
                case 1: PlayerInfo[playerid][team]=2; //moscow
            }
			new /*name[MAX_PLAYER_NAME],*/ file[45];
			GetPlayerName(playerid, name, sizeof(name));
			format(file, sizeof(file), SERVER_USER_FILE, name);
			SendClientMessage(playerid, COLOR_YELLOW,"[SYSTEM]: Registered Successful");
			dini_IntSet(file, "team", PlayerInfo[playerid][team]);
			TextDrawShowForPlayer(playerid, TextDrawKD);
        }
        return 1;
    }
    if (dialogid == 2424)
    {
  new welcomeback[45], playerswelcome[MAX_PLAYER_NAME];
        	format(welcomeback, sizeof(welcomeback), "Welcome To Back Our Server %s ", playerswelcome);
    	new /*name[MAX_PLAYER_NAME],*/ file[45];//,/*string[45];*/
		GetPlayerName(playerid, name, sizeof(name));
		format(file, sizeof(file), SERVER_USER_FILE, name);
      
		GetPlayerName(playerid, playerswelcome, sizeof(playerswelcome));
	
	
		if(!response) return Kick(playerid);
		if (!strlen(inputtext)) return ShowPlayerDialog(playerid, 2424, DIALOG_STYLE_PASSWORD, welcomeback, "Let's Login to your account Please input your password to login", "Login", "Quit");
		new tmp;
		tmp = dini_Int(file, "Password");
		if(udb_hash(inputtext) != tmp)
		{
		    format(string,sizeof(string),"[SYSTEM][KICKED]: Players %s has kicked by Input Invalid password. |Faild Login Name Plz Reconnect|",name);
			SendClientMessageToAll( COLOR_RED1,string);
			SendClientMessage(playerid,COLOR_RED1,string);
			print(string);
			//ShowPlayerDialog(playerid, 2424, DIALOG_STYLE_PASSWORD, welcomeback, "Let's Login to your account Please input your password to login", "Login", "Quit");
			PlayerInfo[playerid][FailLogin]++;
			PlayerInfo[playerid][FailLogin] = dini_Int(file, "FailLogin");
		    Kick(playerid);
		}
        else
        {
            PlayerInfo[playerid][FailLogin]=0;
            PlayerInfo[playerid][LoggedIn] = 1;
            PlayerInfo[playerid][Level] = dini_Int(file, "Level");
             PlayerInfo[playerid][Money] = dini_Int(file, "Money");
              PlayerInfo[playerid][Score] = dini_Int(file, "Score");
            PlayerInfo[playerid][Warnings] = dini_Int(file, "Warnings");
            PlayerInfo[playerid][Hours] = dini_Int(file, "Hours");
            PlayerInfo[playerid][Mins] = dini_Int(file, "Mins");
            PlayerInfo[playerid][Secs] = dini_Int(file, "Secs");
            PlayerInfo[playerid][Muted] = dini_Int(file, "Muted");
            PlayerInfo[playerid][Kills] = dini_Int(file, "Kills");
            PlayerInfo[playerid][Death] = dini_Int(file, "Death");
            PlayerInfo[playerid][Spawned] = dini_Int(file, "Spawned");
            PlayerInfo[playerid][Spec] = dini_Int(file, "Spec");
            PlayerInfo[playerid][ArmyLevel] = dini_Int(file, "ArmyLevel");
            PlayerInfo[playerid][Skin] = dini_Int(file, "Skin");
             PlayerInfo[playerid][FailLogin] = dini_Int(file, "FailLogin");
            PlayerInfo[playerid][SkinStatus] = dini_Int(file, "SkinStatus");
             PlayerInfo[playerid][Kicked] = dini_Int(file, "Kicked");
              PlayerInfo[playerid][Banned] = dini_Int(file, "Banned");
   			PlayerInfo[playerid][Muted] = dini_Int(file, "Muted");
   				PlayerInfo[playerid][RPK] = dini_Int(file, "RPK");
	        PlayerInfo[playerid][Hours] = dini_Int(file, "Hours");
	        PlayerInfo[playerid][Mins] = dini_Int(file, "Mins");
	        PlayerInfo[playerid][Secs] = dini_Int(file, "Secs");
//			PlayerInfo[playerid][Kicked] = dini_Int(file, "Kicked");
			 PlayerInfo[playerid][interior] = dini_Int(file, "Interior");
			PlayerInfo[playerid][Jail] = dini_Int(file, "Jail");
            PlayerInfo[playerid][savepos] = dini_Int(file, "savepos");
             PlayerInfo[playerid][PosX] = dini_Float(file, "PosX");
              PlayerInfo[playerid][PosY] = dini_Float(file, "PosY");
               PlayerInfo[playerid][PosZ] = dini_Float(file, "PosZ");
            PlayerInfo[playerid][Hungry] = dini_Int(file, "Hungry");
            PlayerInfo[playerid][pmstatus] = dini_Int(file, "pmstatus");
            SetPlayerScore(playerid, PlayerInfo[playerid][Score]);
            GivePlayerMoney(playerid, dini_Int(file, "Money")-GetPlayerMoney(playerid));
            SendClientMessage(playerid,COLOR_RED1, "[SYSTEM]: Successfully logged in!");
             format(str0,sizeof(str0),"Kills : %d",PlayerInfo[playerid][Kills]);
     format(str10,sizeof(str10),"Death : %d",PlayerInfo[playerid][Death]);
	 PlayerTextDrawSetString(playerid,TDKILLS[playerid], str0);
    PlayerTextDrawSetString(playerid,TDDEATHS[playerid], str10);
            //SetTimerEx("TotalTime", 1000, true, "i", playerid); // put this somewhere in your scriptforward TotalTime(playerid);
            PlayerInfo[playerid][Register]=1;
            PlayerInfo[playerid][pmstatus]=1;
            PlayerInfo[playerid][FailLogin]=0;
            	if(PlayerInfo[playerid][Banned]==1)
            {
                new fmsg[45];
				format(fmsg,sizeof(fmsg),"-|Players %s (%d) has been Automatically Kicked By System Protected [President Secreatary] Reason : Ban Evade|- ", playerswelcome);
                SendClientMessageToAll(COLOR_RED1,fmsg);
                Kick(playerid);
                print(fmsg);
            }
            	if(PlayerInfo[playerid][RPK]== 1)
	{
	
	 if(dini_Exists(file))
	 {
	 	dini_Remove(file);
	 }
	 new welcometext[45];
	GetPlayerName(playerid, playerswelcome, sizeof(playerswelcome));
	format(welcometext, sizeof(welcometext), "Welcome To Our Server %s ", playerswelcome);
	 SendClientMessage(playerid,COLOR_CYAN,"Your Account has been Roleplay Killed Sorry Please Register with new one ...");
	 ShowPlayerDialog(playerid, 2323, DIALOG_STYLE_PASSWORD, welcometext, "Welcome, your name didn't registered now, Please input your registration password below", "Register", "Quit");
	 return 1;
 	}
            if(PlayerInfo[playerid][Level] >= 1)
            {
                AdminDuty[playerid] = true;
            }/*
            LoggedInp[playerid]=dini_Int(file, "LoggedIn");
	Registerp[playerid]=dini_Int(file, "Register");
	Levelp[playerid]=dini_Int(file, "Level");
	Mutedp[playerid]=dini_Int(file, "Muted");
	Killsp[playerid]=dini_Int(file, "Kills");
	Deathp[playerid]=dini_Int(file, "Death");
	Spawnedp[playerid]=dini_Int(file, "Spawned");
	Hoursp[playerid]=dini_Int(file, "Hours");
 	Minsp[playerid]=dini_Int(file, "Mins");
 	Secsp[playerid]=dini_Int(file, "Secs");
 	Warningsp[playerid]=dini_Int(file, "Warnings");
 	Specp[playerid]=dini_Int(file, "Spec");
 	FailLoginp[playerid]=dini_Int(file, "FailLogin");
	Kickedp[playerid]=dini_Int(file, "Kicked");
	Bannedp[playerid]=dini_Int(file, "Banned");
	//Passwordp[playerid]=dini_Int(file, "Password");
	RPKp[playerid]=dini_Int(file, "RPK");
	Moneyp[playerid]=dini_Int(file, "LoggedIn");
	Scorep[playerid]=dini_Int(file, "Score");
	Skinp[playerid]=dini_Int(file, "Skin");
	SkinStatusp[playerid]=dini_Int(file, "SkinStatus");
	saveposp[playerid]=dini_Int(file, "savepos");
	
	interiorp[playerid]=dini_Int(file, "interior");
	sexp[playerid]=dini_Int(file, "sex");
	agep[playerid]=dini_Int(file, "age");
	teamp[playerid]=dini_Int(file, "team");
	Jailp[playerid]=dini_Int(file, "Jail");
	ArmyLevelp[playerid]=dini_Int(file, "ArmyLevel");
	pmstatusp[playerid]=dini_Int(file, "pmstatus");*/

         //   SetTimerEx("HungryTime", 1000, true, "i", playerid);
         GetPlayerName(playerid, plname, MAX_PLAYER_NAME);
           //format(newtext, sizeof(newtext), "Name : %s     Kill : %d     Death : %d     Wanted Level : %d   Warning : %d",plname, PlayerInfo[playerid][Kills],PlayerInfo[playerid][Death],GetPlayerWantedLevel(playerid),PlayerInfo[playerid][Warnings]);
   // TextDrawSetString(TextDrawKD, newtext);
    //TextDrawShowForPlayer(playerid, TextDrawKD);
    
			
        }
    }
    	if(response == 1)
	{
	    switch(dialogid)
	    {
	        case 8777:
	    	{
	    	    switch(listitem)
	    	    {
					case 0: ShowPlayerDialog(playerid, 8778, 2, "Melee", "Brass knuckles\nGolf club\nNite stick\nKnife\nBaseball bat\nShovel\nPool cue\nKatana\nChainsaw\nPurple dildo\nShort dildo\nLong vibrator\nLong vibrator\nFlowers\nCane", "Select", "Cancel");
                	case 1: ShowPlayerDialog(playerid, 8779, 2, "Thrown", "Grenades\nTear Gas\nMolotov cocktail", "Select", "Cancel");
                	case 2: ShowPlayerDialog(playerid, 8780, 2, "Pistols", "9mm Pistol\nSilenced pistol\nDesert eagle", "Select", "Cancel");
                	case 3: ShowPlayerDialog(playerid, 8781, 2, "Shotguns", "Shotgun\nSawn-off shotgun\nCombat shotgun", "Select", "Cancel");
                	case 4: ShowPlayerDialog(playerid, 8782, 2, "Sub-machine guns", "Micro Uzi\nMP5\nTEC9", "Select", "Cancel");
                	case 5: ShowPlayerDialog(playerid, 8783, 2, "Rifles", "AK47\nM4\nCountry rifle\nSniper rifle", "Select", "Cancel");
                	case 6: ShowPlayerDialog(playerid, 8784, 2, "Heavy weapons", "Rocket Launcher\nHS-Rocket Launcher\nFlame thrower\nMinigun", "Select", "Cancel");
                	case 7: ShowPlayerDialog(playerid, 8785, 2, "Hand held", "Spray can\nFire extinguisher\nCamera", "Select", "Cancel");
                	case 8: ShowPlayerDialog(playerid, 8786, 2, "Apparel", "Night vision\nThermal goggles\nParachute", "Select", "Cancel");
               		case 9: ShowPlayerDialog(playerid, 8787, 2, "Special", "Satchel charges\nDetonator", "Select", "Cancel");
				}
			}
			case 8778:
			{
				new weapons[] = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15};
				return GivePlayerWeapon(wpid[playerid], weapons[listitem], 500);
			}
			case 8779:
			{
				new weapons[] = {16,17,18};
				return GivePlayerWeapon(wpid[playerid], weapons[listitem], 500);
			}
			case 8780:
			{
				new weapons[] = {22,23,24};
				return GivePlayerWeapon(wpid[playerid], weapons[listitem], 500);
			}
			case 8781:
			{
				new weapons[] = {25,26,27};
				return GivePlayerWeapon(wpid[playerid], weapons[listitem], 500);
			}
			case 8782:
			{
				new weapons[] = {28,29,32};
				return GivePlayerWeapon(wpid[playerid], weapons[listitem], 500);
			}
			case 8783:
			{
				new weapons[] = {30,31,33,34};
				return GivePlayerWeapon(wpid[playerid], weapons[listitem], 500);
			}
			case 8784:
			{
				new weapons[] = {35,36,37,38};
				return GivePlayerWeapon(wpid[playerid], weapons[listitem], 500);
			}
			case 8785:
			{
				new weapons[] = {41,42,43,44};
				return GivePlayerWeapon(wpid[playerid], weapons[listitem], 500);
			}
			case 8786:
			{
				new weapons[] = {44,45,46};
				return GivePlayerWeapon(wpid[playerid], weapons[listitem], 500);
			}
			case 8787:
			{
				new weapons[] = {39,40};
				return GivePlayerWeapon(wpid[playerid], weapons[listitem], 500);
			}
			//
			//
			//
			case 8177:
	    	{
	    	    switch(listitem)
	    	    {
					case 0: ShowPlayerDialog(playerid, 8178, 2, "Melee 200$", "Brass knuckles\nGolf club\nNite stick\nKnife\nBaseball bat\nShovel\nPool cue\nKatana\nChainsaw\nPurple dildo\nShort dildo\nLong vibrator\nLong vibrator\nFlowers\nCane", "Select", "Cancel");
                	case 1: ShowPlayerDialog(playerid, 8179, 2, "Thrown 750$", "Grenades\nTear Gas\nMolotov cocktail", "Select", "Cancel");
                	case 2: ShowPlayerDialog(playerid, 8180, 2, "Pistols 600$", "9mm Pistol\nSilenced pistol\nDesert eagle", "Select", "Cancel");
                	case 3: ShowPlayerDialog(playerid, 8181, 2, "Shotguns 1200$", "Shotgun\nSawn-off shotgun\nCombat shotgun", "Select", "Cancel");
                	case 4: ShowPlayerDialog(playerid, 8182, 2, "Sub-machine guns 1500$", "Micro Uzi\nMP5\nTEC9", "Select", "Cancel");
                	case 5: ShowPlayerDialog(playerid, 8183, 2, "Rifles 2000$", "AK47\nM4\nCountry rifle\nSniper rifle", "Select", "Cancel");
                	case 6: ShowPlayerDialog(playerid, 8184, 2, "Heavy weapons 3500$", "Rocket Launcher\nHS-Rocket Launcher\nFlame thrower", "Select", "Cancel");
                	case 7: ShowPlayerDialog(playerid, 8185, 2, "Hand held 100$", "Spray can\nFire extinguisher\nCamera", "Select", "Cancel");
                	case 8: ShowPlayerDialog(playerid, 8186, 2, "Apparel 200$ ", "Night vision\nThermal goggles\nParachute(Free Typed /chute)", "Select", "Cancel");
               		case 9: ShowPlayerDialog(playerid, 8187, 2, "Special 800$", "Satchel charges\nDetonator", "Select", "Cancel");
				}
			}
			case 8178:
			{
			    
				new weapons[] = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15};
                if(PlayerInfo[playerid][Money] < 200) return emsg(playerid,2);
				return (GivePlayerWeapon(wpid[playerid], weapons[listitem], 500) && GivePlayerMoney(playerid,- 200));
			}
			case 8179:
			{
			   
				new weapons[] = {16,17,18};
				  if(PlayerInfo[playerid][Money] < 750) return emsg(playerid,2);
				return (GivePlayerWeapon(wpid[playerid], weapons[listitem], 500)&& GivePlayerMoney(playerid,- 750));
			}
			case 8180:
			{
				new weapons[] = {22,23,24};
				  if(PlayerInfo[playerid][Money] < 600) return emsg(playerid,2);
				return (GivePlayerWeapon(wpid[playerid], weapons[listitem], 500)&& GivePlayerMoney(playerid,- 600));
			}
			case 8181:
			{
				new weapons[] = {25,26,27};
				  if(PlayerInfo[playerid][Money] < 1200) return emsg(playerid,2);
				return (GivePlayerWeapon(wpid[playerid], weapons[listitem], 500)&& GivePlayerMoney(playerid,- 1200));
			}
			case 8182:
			{
				new weapons[] = {28,29,32};
				  if(PlayerInfo[playerid][Money] < 1500) return emsg(playerid,2);
				return (GivePlayerWeapon(wpid[playerid], weapons[listitem], 500)&& GivePlayerMoney(playerid,- 1500));
			}
			case 8183:
			{
				new weapons[] = {30,31,33,34};
				  if(PlayerInfo[playerid][Money] < 2000) return emsg(playerid,2);
				return (GivePlayerWeapon(wpid[playerid], weapons[listitem], 500)&& GivePlayerMoney(playerid,- 2000));
			}
			case 8184:
			{
				new weapons[] = {35,36,37};
				  if(PlayerInfo[playerid][Money] < 3500) return emsg(playerid,2);
				return (GivePlayerWeapon(wpid[playerid], weapons[listitem], 500)&& GivePlayerMoney(playerid,- 3500));
			}
			case 8185:
			{
				new weapons[] = {41,42,43,44};
				  if(PlayerInfo[playerid][Money] < 100) return emsg(playerid,2);
				return (GivePlayerWeapon(wpid[playerid], weapons[listitem], 500)&& GivePlayerMoney(playerid,- 100));
			}
			case 8186:
			{
				new weapons[] = {44,45,46};
				  if(PlayerInfo[playerid][Money] < 200) return emsg(playerid,2);
				return (GivePlayerWeapon(wpid[playerid], weapons[listitem], 500)&& GivePlayerMoney(playerid,- 200));
			}
			case 8187:
			{
				new weapons[] = {39,40};
				  if(PlayerInfo[playerid][Money] < 800) return emsg(playerid,2);
				return (GivePlayerWeapon(wpid[playerid], weapons[listitem], 500)&& GivePlayerMoney(playerid,- 800));
			}
			//
			//
		}
	}
    	if(dialogid == DIALOGID)
	{
		if(response)
		{
			if(listitem == 0)
			{
				SetWeather(0);
			}
			if(listitem == 1)
			{
				SetWeather(8);
			}
			if(listitem == 2)
			{
				SetWeather(9);
			}
			if(listitem == 3)
			{
				SetWeather(11);
			}
			if(listitem == 4)
			{
				SetWeather(16);
			}
			if(listitem == 5)
			{
				SetWeather(19);
			}
			if(listitem == 6)
			{
				SetWeather(20);
			}
			if(listitem == 7)
			{
				SetWeather(21);
			}
            if(listitem == 8)
			{
				SetWeather(22);
			}
			if(listitem == 9)
			{
				SetWeather(500);
			}
			if(listitem == 10)
			{
				SetWeather(62);
			}
            if(listitem == 11)
			{
				SetWeather(86);
			}
			if(listitem == 12)
			{
				SetWeather(91);
			}
			if(listitem == 13)
			{
				SetWeather(72);
			}
			if(listitem == 14)
			{
				SetWeather(75);
			}
		}
		return 1;
	}
		
	return 1;
}

//---public---//

//
forward SetPlayerUnjail(playerid);
public SetPlayerUnjail(playerid)
{ 
    new /*name[MAX_PLAYER_NAME],*/ file[45] ;
	GetPlayerName(playerid, name, sizeof(name));
	format(file, sizeof(file), SERVER_USER_FILE, name);
	new time[40]; 
	PlayerInfo[playerid][Jail]--; 
	dini_IntSet(file, "Jail", PlayerInfo[playerid][Jail]);
	if(PlayerInfo[playerid][Jail] > 0) 
	{ 
		format(time,sizeof(time),"Jailtime Left: %d",PlayerInfo[playerid][Jail]);
		GameTextForPlayer(playerid,time,500,3); 
	} 
	else if(PlayerInfo[playerid][Jail] == 0) 
	{ 
		SetPlayerPos(playerid, 0.0, 0.0, 0.0); 
		SetPlayerInterior(playerid,0);
		GameTextForPlayer(playerid, "You has been Unjailed Now You are free",500,3);
		PlayerInfo[playerid][Jail] = 0;
		dini_IntSet(file, "Jail", PlayerInfo[playerid][Jail]);
	} 
return 1;
}
forward SetPlayerUnFreeze(playerid);
public SetPlayerUnFreeze(playerid)
{
	new time[40];
	FreezeTimes[playerid]--;
	if(FreezeTimes[playerid] > 0)
	{
		format(time,sizeof(time),"Freezetime Left: %d",FreezeTimes[playerid]);
		GameTextForPlayer(playerid,time,500,3);
		TogglePlayerControllable(playerid,0);
	}
	else if(FreezeTimes[playerid] == 0)
	{
		GameTextForPlayer(playerid, "You has been Unfreeze",500,3);
		FreezeTimes[playerid] = 0;
		TogglePlayerControllable(playerid,1);
	}
return 1;
}
//---Command---//
	CMD:beer(playerid,params[])
	{
	if(GetPlayerMoney(playerid) < 1)
        {
            SendClientMessage(playerid, COLOR_RED, "[SYSTEM][ERROR]:not have enough money To buy beer");
        }
        else
        {
            SendClientMessage(playerid,COLOR_YELLOW, "[SYSTEM]:Thank you for buying a Beer");
            GivePlayerMoney(playerid,-1);
            SendClientMessage(playerid,COLOR_BLUE,"[SYSTEM]/;Press f TO Drop it");
    		SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DRINK_BEER);
        }

    return 1;
	}
    CMD:ciggy(playerid,params[])
    {
		SetPlayerSpecialAction(playerid,SPECIAL_ACTION_SMOKE_CIGGY);
		return 1;
	}
	CMD:kill(playerid,params[])
	{
	   GetPlayerName(playerid, pname, sizeof(pname));
	   format(string, sizeof(string), "%s Commit Suicide !", pname);
	SendClientMessageToAll(COLOR_PINK, string);
	SetPlayerHealth(playerid,0.0);
	SendClientMessage(playerid, COLOR_RED1,"[SYSTEM]: You Commit Suicide ");
	return 1;
	}
	CMD:me(playerid,params[])
	{
	    if(sscanf(params, "s[45]", string))
	{
		SendClientMessage(playerid, 0xFF0000FF, "[SYSTEM]: /me <message>");
		SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Send Message as you!");
		return 1;
 	}
	if(PlayerInfo[playerid][LoggedIn]==0) return SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]: You are not Connected or login !");
//	if(playerid == id) return SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]: You cannot pm yourself!");
	{
//	if(PlayerInfo[id][pmstatus]==0) return SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]: That Players Closed Their PM !");
	GetPlayerName(playerid, pname, sizeof(pname)); //The Sender's Name so we use (playerid).
//	GetPlayerName(id, Name2, sizeof(Name2)); //The Receiver's Name so we use (id).
	format(string, sizeof(string), "%s is %s", pname, string);
	SendClientMessageToAll(COLOR_PINK, string);

	}
	    return 1;
	}
	CMD:help(playerid,params[])
	{
		SendClientMessage(playerid,COLOR_YELLOW,"============================================================================");
    SendClientMessage(playerid,COLOR_ORANGE,"Welcome To help menu ");
    SendClientMessage(playerid,COLOR_ORANGE,"/animhelp To see Animation help");
    SendClientMessage(playerid,COLOR_ORANGE,"/rules to see Rules Of server");
    SendClientMessage(playerid,COLOR_ORANGE,"/admins To see admins name and how much online");
    SendClientMessage(playerid,COLOR_ORANGE,"/report [id] [reason] to Report Hacker");
    SendClientMessage(playerid,COLOR_ORANGE,"/cmds to see command");
    	SendClientMessage(playerid,COLOR_YELLOW,"============================================================================");
    return 1;
	}
	CMD:cmds(playerid,params[])
	{
	//	SendClientMessage(playerid,COLOR_YELLOW,"============================================================================");
    SendClientMessage(playerid,COLOR_VIOLET,"================================Commands==================================");
    SendClientMessage(playerid,COLOR_YELLOW,"============================================================================");
    SendClientMessage(playerid,COLOR_SEAGREEN,"/login,/help/animhelp,/rules,/pm,/spm");
    SendClientMessage(playerid,COLOR_SEAGREEN,"/admins,/report,/cmds,/cancelskin");
    SendClientMessage(playerid,COLOR_SEAGREEN,"/saveskin,/kill,/me,/beer,/ciggy");
    	SendClientMessage(playerid,COLOR_YELLOW,"============================================================================");
    return 1;
	}/*
	CMD:animhelp(playerid,params[])
	{
		SendClientMessage(playerid,COLOR_YELLOW,"============================================================================");
 	SendClientMessage(playerid,COLOR_ORANGE,"/ciggy ~ Cigarett");
    SendClientMessage(playerid,COLOR_ORANGE,"/ciggy ~ Cigarett");
    SendClientMessage(playerid,COLOR_ORANGE,"/beer ~ buy 1 beer for 1$");
    	SendClientMessage(playerid,COLOR_YELLOW,"============================================================================");
    //SendClientMessage(playerid,COLOR_BLUE,"/handsup ~ put ur handsup");
    //SendClientMessage(playerid,COLOR_BLUE,"~ Another Command in Process");
    return 1;
    }*/
    CMD:rules(playerid,params[])
	{
 	SendClientMessage(playerid,COLOR_YELLOW,"============================================================================");
    SendClientMessage(playerid,COLOR_ORANGE,"This is Rules Of server");
    	SendClientMessage(playerid,COLOR_YELLOW,"============================================================================");
    SendClientMessage(playerid,COLOR_GREEN,"1. Do not Spawnkilling Who Do this will Got warn");
    SendClientMessage(playerid,COLOR_GREEN,"2. Do not Cheat , Hack or use CLEO MOD If Broke this RUles = Kicked/Banned");
    SendClientMessage(playerid,COLOR_GREEN,"3. Respect Another Players If u Flamming U Will got Warn");
    SendClientMessage(playerid,COLOR_GREEN,"4. No G-Abuse ");
    SendClientMessage(playerid,COLOR_GREEN,"5. No Bug Abuse Ex: C-BUg");
    SendClientMessage(playerid,COLOR_GREEN,"6. Do not Spamming Text in server");
    SendClientMessage(playerid,COLOR_GREEN,"7. No Pausing , AFK To Avoid die");
    SendClientMessage(playerid,COLOR_GREEN,"8. DO not RUIN RP whe server have RP Who Broke this Will Got warn");
    SendClientMessage(playerid,COLOR_GREEN,"9. If U Flaming Admin U will ot kicked !");
    SendClientMessage(playerid,COLOR_GREEN,"10. Do not Do ur self fake admin ");
    	SendClientMessage(playerid,COLOR_YELLOW,"============================================================================");
    return 1;
    }
//
CMD:setarmylevel(playerid, params[])
{
	new pID, value;
	new ArmyRank[45];
	if(PlayerInfo[playerid][Level]<5 || PlayerInfo[playerid][ArmyLevel] < 5) return 0;
	else if(sscanf(params, "ui", pID, value)) return
	SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /setarmylevel (id) (level)") &&
	SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will Set Army Level To Players");
	else if(value < -1 || value > 5) return SendClientMessage(playerid, -1, "[SYSTEM][ERROR]: Level 0-5");
	else if(pID == INVALID_PLAYER_ID) return SendClientMessage(playerid, -1, "Player Is Not Currently Connected");
	else if(PlayerInfo[pID][LoggedIn]==0) return SendClientMessage(playerid, -1, "Player Is Not Currently Connected");
	else
	{
		new /*string[45],*/ string1[45], target[MAX_PLAYER_NAME], pName[MAX_PLAYER_NAME];
		//new msg[45];
		GetPlayerName(playerid, pName, sizeof(pName));
		GetPlayerName(pID, target, sizeof(target));
		format(string, sizeof(string), "You have set %s be Army Rank level %i", target, value);
		SendClientMessage(playerid, -1, string);
		format(string, sizeof(string), "Your Army Rank level has been set to Level %i by %s", value, pName);
		SendClientMessage(pID, -1, string1);
		PlayerInfo[pID][ArmyLevel] = value;
		switch(PlayerInfo[pID][Level]) /* << Change this var to yours*/
				{
					case 1: ArmyRank = "Private";
					case 2: ArmyRank = "Corporal";
					case 3: ArmyRank = "Sergeant";
					case 4: ArmyRank = "Captain";
					case 5: ArmyRank = "General Of Army";
				}
		format(msg, sizeof(msg),             "Army %s has Set %s be Army Rank %s",pName,target,ArmyRank);
		

		SendClientMessageToAll(COLOR_PINK, msg);
	
		print(msg);
		new /*name[MAX_PLAYER_NAME],*/ file[45];
 		GetPlayerName(playerid, name, sizeof(name));
 		format(file, sizeof(file), SERVER_USER_FILE, name);
 		dini_IntSet(file, "ArmyLevel", PlayerInfo[playerid][ArmyLevel]);
	}
	return 1;
}
CMD:armys(playerid,params[])
{
	if(PlayerInfo[playerid][Level] < 1 || PlayerInfo[playerid][ArmyLevel] < 1) return emsg(playerid,1);
	  ////new /*string[45];*/
	  new fstring[45];
	  new ArmyRank[45];
	  for(new i=0; i<MAX_PLAYERS; i++)
	  {
	  	if(PlayerInfo[i][ArmyLevel] > 0)
	  	{
		  	//new pname[MAX_PLAYER_NAME];
		  	GetPlayerName(i,pname, sizeof(pname));
		  	switch(PlayerInfo[playerid][ArmyLevel])
			   		{
			   		    case 1: ArmyRank = "Private";
					case 2: ArmyRank = "Corporal";
					case 3: ArmyRank = "Sergeant";
					case 4: ArmyRank = "Captain";
					case 5: ArmyRank = "General Of Army";

			   		}
		  	format(fstring, sizeof(fstring),"Army Rank %s | Player : %s (ID : %d)",ArmyRank,pname,playerid);

		  	strcat(string, fstring, sizeof(string));
	  	}
	  	else if(PlayerInfo[i][Level] <1) return SendClientMessage(playerid,COLOR_VIOLET,"[SYSTEM]: There's No Army Online");

	  }
	  ShowPlayerDialog(playerid,2562,DIALOG_STYLE_LIST,"=====|Online Armys|=====",string,"OK","");


	return 1;
}
//RCON// Function :  |Function : Will
CMD:setlevel(playerid, params[])
{
	new pID, value;
	new AdminRank[45];
	if(PlayerInfo[playerid][Level]<5 && !IsPlayerAdmin(playerid)) return 0;
	else if(sscanf(params, "ui", pID, value)) return
	SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /setlevel (id) (level)") &&
	SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will Set Level To Players");
	else if(value < -1 || value > 5) return SendClientMessage(playerid, -1, "[SYSTEM][ERROR]: Level 0-5");
	else if(pID == INVALID_PLAYER_ID) return SendClientMessage(playerid, -1, "Player Is Not Currently Connected");
	else if(PlayerInfo[pID][LoggedIn]==0) return SendClientMessage(playerid, -1, "Player Is Not Currently Connected");
	else
	{
		new /*string[45],*/ string1[45], target[MAX_PLAYER_NAME], pName[MAX_PLAYER_NAME];
		//new msg[45];
		GetPlayerName(playerid, pName, sizeof(pName));
		GetPlayerName(pID, target, sizeof(target));
		format(string, sizeof(string), "You have set %s be Administrator level %i", target, value);
		SendClientMessage(playerid, -1, string);
		format(string, sizeof(string), "Your Admin level has been set to Level %i by %s", value, pName);
		SendClientMessage(pID, -1, string1);
		PlayerInfo[pID][Level] = value;
		switch(PlayerInfo[pID][Level]) /* << Change this var to yours*/
				{
					case 1: AdminRank = "Organization Employee";
					case 2: AdminRank = "Organization Master Employee";
					case 3: AdminRank = "Organization Secretary";
					case 4: AdminRank = "Organization Agent";
					case 5: AdminRank = "Organization President Developer";
				}
		format(msg, sizeof(msg),             "Administrator %s has Set %s be Administrator Rank %s",pName,target,AdminRank);
		SendClientMessageToAll(COLOR_VIOLET, "====================================================");
		SendClientMessageToAll(COLOR_VIOLET, "----------------------------------------------------");
		SendClientMessageToAll(COLOR_VIOLET, "----------------------------------------------------");

		SendClientMessageToAll(COLOR_PINK, msg);
		SendClientMessageToAll(COLOR_VIOLET, "----------------------------------------------------");
		SendClientMessageToAll(COLOR_VIOLET, "----------------------------------------------------");
		SendClientMessageToAll(COLOR_VIOLET, "====================================================");
		print(msg);
		new /*name[MAX_PLAYER_NAME],*/ file[45];
 		GetPlayerName(playerid, name, sizeof(name));
 		format(file, sizeof(file), SERVER_USER_FILE, name);
 		dini_IntSet(file, "Level", PlayerInfo[playerid][Level]);
	}

	return 1;
}
//
//Civilian//
CMD:pm(playerid, params[])
{
	
    new str[45];
	new str2[45];
	new id, Name1[MAX_PLAYER_NAME], Name2[MAX_PLAYER_NAME];
    if(sscanf(params, "us[45]", id, str2))
	{
		SendClientMessage(playerid, 0xFF0000FF, "[SYSTEM]: /pm <id/name> <message>");
		SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will Send PM To Another Players");
		return 1;
 	}
	if(PlayerInfo[playerid][LoggedIn]==0) return SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]: That player is not Connected !");
	if(playerid == id) return SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]: You cannot pm yourself!");
	{
	if(PlayerInfo[id][pmstatus]==0) return SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]: That Players Closed Their PM !");
	GetPlayerName(playerid, Name1, sizeof(Name2)); //The Sender's Name so we use (playerid).
	GetPlayerName(id, Name2, sizeof(Name2)); //The Receiver's Name so we use (id).
	format(str, sizeof(str), "PM To %s(ID %d): %s", Name2, id, str2);
	SendClientMessage(playerid, COLOR_WHITE, str);
	format(str, sizeof(str), "PM From %s(ID %d): %s", Name1, playerid, str2);
	SendClientMessage(id, COLOR_WHITE, str);
	}
	return 1;
}
CMD:spm(playerid, params[])
{
    if(PlayerInfo[playerid][pmstatus]==0)
    {
    format(form5,sizeof(form5),"PM STATUS : OFF");
    	PlayerTextDrawSetString(playerid,TDPMSTATUS[playerid], form5);
	SendClientMessage(playerid, COLOR_GREEN,"[SYSTEM]:Your PM has closed If you want to open pm type /spm again !");
	PlayerInfo[playerid][pmstatus]=1;
	}
	else if(PlayerInfo[playerid][pmstatus]==1)
    {
    	format(form5,sizeof(form5),"PM STATUS : ON");
    	PlayerTextDrawSetString(playerid,TDPMSTATUS[playerid], form5);
	SendClientMessage(playerid, COLOR_GREEN,"[SYSTEM]:Your PM has openned If you want to close pm type /spm ");
	PlayerInfo[playerid][pmstatus]=0;
	}
	else
	{
	SendClientMessage(playerid, COLOR_RED1,"[SYSTEM] : Usage /spm");
	SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will Close/Open PM Box");
	}
	return 1;
}
CMD:report(playerid, params[])
{
	new id;
	new reason[45];
	if(sscanf(params, "us[50]", id, reason)) return
	SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /report [ID] [REASON]") &&
	SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will report players to Administrator");
	new stringw[150];
	new sender[MAX_PLAYER_NAME], receiver[MAX_PLAYER_NAME];
	GetPlayerName(playerid, sender, sizeof(sender));
	GetPlayerName(id, receiver, sizeof(receiver));
	format(stringw, sizeof(stringw), "[SYSTEM]: -Player %s(%d) has reported %s(%d) | Reason: %s ", sender, playerid, receiver, id,reason);
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(PlayerInfo[i][Level] >=1)
		{
			SendClientMessage(i, COLOR_LIME, stringw);
			GameTextForPlayer(i,"~r~New Report!",1500,3);
		}
	}
	print(stringw);
	
	return 1;
}/*
CMD:changepass(playerid, params[])
{
	new fileL[45];
 new Name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, Name , sizeof(Name));
	format(fileL, sizeof(fileL), SERVER_USER_FILE, Name);
	new NewPass;
	if(sscanf(params, "s", NewPass)) return SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /changepass (new password)");
	dini_IntSet(fileL, "Password",udb_hash(NewPass));
	SendClientMessage(playerid, COLOR_GREEN, "[SYSTEM]:You have changed your password.");
	return 1;
}*/
CMD:cancelskin(playerid,params [])
{
	if(PlayerInfo[playerid][SkinStatus]==0)
	{
		SendClientMessage(playerid, COLOR_RED1, ERROR);
		SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will Saveskin (Only Admin Permission)");
	}
	else if(PlayerInfo[playerid][SkinStatus]==1)
	{
		new /*name[MAX_PLAYER_NAME],*/ file[45] ;
 		GetPlayerName(playerid, name, sizeof(name));
 		format(file, sizeof(file), SERVER_USER_FILE, name);
 		PlayerInfo[playerid][Skin] = GetPlayerSkin(playerid);
 		PlayerInfo[playerid][SkinStatus] = 0;
 		dini_IntSet(file, "Skin", PlayerInfo[playerid][Skin]);
 		dini_IntSet(file, "SkinStatus", PlayerInfo[playerid][SkinStatus]);
 		SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM]: Saveskin Successful");
 	//	//new /*string[45];*/
 		format(string,sizeof(string),"[SYSTEM]: UnSaveskin Successful");
 		SendClientMessage(playerid,COLOR_ORANGE,string);
 		print(string);
	}
	return 1;
}
CMD:saveskin(playerid,params [])
{
	if(PlayerInfo[playerid][SkinStatus]==0)
	{
		SendClientMessage(playerid, COLOR_RED1, ERROR);
		SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will Saveskin & useskin (Only Admin Permission)");
	}
	else if(PlayerInfo[playerid][SkinStatus]==1)
	{
		new /*name[MAX_PLAYER_NAME],*/ file[45] ;
 		GetPlayerName(playerid, name, sizeof(name));
 		format(file, sizeof(file), SERVER_USER_FILE, name);
 		PlayerInfo[playerid][Skin] = GetPlayerSkin(playerid);
 		PlayerInfo[playerid][SkinStatus] = 1;
 		dini_IntSet(file, "Skin", PlayerInfo[playerid][Skin]);
 		dini_IntSet(file, "SkinStatus", PlayerInfo[playerid][SkinStatus]);
 		SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM]: Saveskin Successful");
 		//new /*string[45];*/
 		format(string,sizeof(string),"[SYSTEM]: Saveskin Successful (Skin Number %d)",PlayerInfo[playerid][Skin]);
 		SendClientMessage(playerid,COLOR_ORANGE,string);
 		print(string);
	}
	return 1;
}
CMD:setskin(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 5 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		new target,skin;
		//new name[45];
		//new name2[45];
		GetPlayerName(playerid, name2, sizeof(name2));
		GetPlayerName(target, name, sizeof(name));
		//new /*string[45];*/
	//	new string2[45];
		if(sscanf(params, "ud", target,skin)) return
		SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /setskin [playerid] [skin]") &&
		SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will Setskin To Players");
		else if(target == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player is not connected!");
		else
		{
			SetPlayerSkin(target,skin);
			PlayerInfo[target][Skin] = GetPlayerSkin(target);
 			PlayerInfo[target][SkinStatus] = 1;
			format(string,sizeof(string),"[SYSTEM]: You Have Setskin Player : %s",name );
			format(string2, 256,"[SYSTEM]: You Have Setskin %d By Administrator %s",skin,name2 );
			SendClientMessage(playerid,COLOR_ORANGE,string);
			SendClientMessage(target,COLOR_ORANGE,string2);
			//new string3[45];
 			format(string3,sizeof(string3),"[SYSTEM]: Administrator %s Setskin to Player : %s Successful (Skin Number %d)",name2,name,PlayerInfo[playerid][Skin]);
 			print(string3);
		}
	}
	return 1;
}

//System Organization Employee Command//
CMD:mute(playerid,params[])
{
	if(PlayerInfo[playerid][LoggedIn] == 1)
	{
		if(PlayerInfo[playerid][Level] >= 1 && PlayerInfo[playerid][LoggedIn]==1)
		{
		    new tmp[256];
			new tmp2[256];
			new Index;
			tmp = strtok(params,Index);
			tmp2 = strtok(params,Index);
		    if(isnull(params)) return
			SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]: /mute [PlayerID] [Reason]") &&
			SendClientMessage(playerid, COLOR_CYAN, "[SYSTEM][EXPLAIN]: Will mute the specified player");
			new playername[MAX_PLAYER_NAME];
			//new adminname [MAX_PLAYER_NAME];
	    	new player1;//, /*string[45];*/
	    	//new string2[45],string3[45];
			player1 = strval(tmp);
		 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && (PlayerInfo[player1][Level] != 5) )
			 {
		 	    if(PlayerInfo[player1][Muted] == 0)
		 	    {
					GetPlayerName(player1, playername, sizeof(playername));
					GetPlayerName(playerid, adminname, sizeof(adminname));
					PlayerPlaySound(player1,1057,0.0,0.0,0.0);
					PlayerInfo[player1][Muted] = 1;
					PlayerInfo[player1][Warnings]++;
					if(strlen(tmp2))
					{
					format(string,sizeof(string),"|- You have been Muted by Administrator %s | Reason: %s -| |Warning %d/3|",adminname,params[2],PlayerInfo[playerid][Warnings]);
					SendClientMessage(player1,COLOR_RED1,string);
					format(string2,sizeof(string2),"[SYSTEM]: Administrator %s has Muted Player %s Reason : %s", adminname,playername,params[2]);
					SendClientMessageToAll(COLOR_VIOLET,string2);
     				print(string2);
					format(string3,sizeof(string3),"|-  You have Muted %s | Reason: %s -|", playername,params[2]);
					
					return SendClientMessage(playerid,COLOR_CYAN,string3);
					}
					else
					{
					format(string,sizeof(string),"|- You have been muted by Administrator %s | No Specified Reason! -| |Warning %d/3|",adminname,PlayerInfo[playerid][Warnings]);
					SendClientMessage(player1,COLOR_RED1,string);
					format(string2,sizeof(string2),"[SYSTEM]: Administrator %s has Muted Player %s Reason : %s", adminname,playername,params[2]);
					SendClientMessageToAll(COLOR_VIOLET,string2);
     				print(string2);
					format(string3,sizeof(string3),"|- You have Muted %s -|", playername);
					return SendClientMessage(playerid,COLOR_ORANGE,string3);
					}
				}
				else return SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]: Player is already muted");
			}
			else return SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]: Player is not connected or is the highest level admin");
		}
		else return SendClientMessage(playerid,COLOR_RED1,ERROR);
	}
	else return SendClientMessage(playerid,COLOR_RED1,"[SYSTEM][ERROR]: You must be logged in to use this commands");

}
CMD:unmute(playerid,params[])
{
	if(PlayerInfo[playerid][LoggedIn] == 1)
	{
		if(PlayerInfo[playerid][Level] >= 1 && PlayerInfo[playerid][LoggedIn]==1)
		{
		    new tmp[256];
			new tmp2[256];
			new Index;
			tmp = strtok(params,Index);
			tmp2 = strtok(params,Index);
		    if(isnull(params)) return
			SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]: /unmute [PlayerID] ") &&
			SendClientMessage(playerid, COLOR_CYAN, "[SYSTEM][EXPLAIN]: Will mute the specified player");
			new playername[MAX_PLAYER_NAME];
			//new adminname [MAX_PLAYER_NAME];
	    	new player1;//, /*string[45],*/string2[45],string3[45];
			player1 = strval(tmp);
		 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && (PlayerInfo[player1][Level] != 5) )
			 {
		 	    if(PlayerInfo[player1][Muted] == 1)
		 	    {
					GetPlayerName(player1, playername, sizeof(playername));
					GetPlayerName(playerid, adminname, sizeof(adminname));
					PlayerPlaySound(player1,1057,0.0,0.0,0.0);
					PlayerInfo[player1][Muted] = 0;
					PlayerInfo[player1][Warnings] = 0;
					if(strlen(tmp2))
					{
					format(string,sizeof(string),"|- You have been UnMuted by Administrator %s|",adminname);
					print(string);
					SendClientMessage(player1,COLOR_RED1,string);
					format(string,sizeof(string2),"[SYSTEM]: Administrator %s has UnMuted Player %s", adminname,playername);
					SendClientMessageToAll(COLOR_VIOLET,string2);
					print(string2);
					format(string3,sizeof(string3),"|-  You have UnMuted %s ", playername);
					return SendClientMessage(playerid,COLOR_CYAN,string3);
					}
					else
					{
					format(string,sizeof(string),"|- You have been Unmuted by Administrator %s ",adminname);

					SendClientMessage(player1,COLOR_RED1,string);
					format(string2,sizeof(string2),"[SYSTEM]: Administrator %s has UnMuted Player %s", adminname,playername);
					SendClientMessageToAll(COLOR_VIOLET,string2);
					print(string2);
					format(string3,sizeof(string3),"|- You have UnMuted %s -|", playername);
					return SendClientMessage(playerid,COLOR_ORANGE,string);
					}
				}
				else return SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]: Player is already unmuted");
			}
			else return SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]: Player is not connected or is the highest level admin");
		}
		else return SendClientMessage(playerid,COLOR_RED1,ERROR);
	}
	else return SendClientMessage(playerid,COLOR_RED1,"[SYSTEM][ERROR]: You must be logged in to use this commands");

}
CMD:warn(playerid ,params[])
{
	if(PlayerInfo[playerid][Level] >= 1 && PlayerInfo[playerid][LoggedIn]==1)
	{
 		
		new i, reason[45];
		//new name[45];
		////new string[45];
		//new msg[45];
  		//new adminname[45];
//  		new wadmin[45];
  		GetPlayerName(playerid,adminname, sizeof(adminname));
		if(sscanf(params, "us[45]", i, reason)) return
		SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /warn [playerid] [reason]") &&
		SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will give warning To Players");
		else if(i == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player is not connected!");
		else
		{
			GetPlayerName(i, name, sizeof(name));
			if(playerid!=i)
			{
				if(PlayerInfo[i][Warnings]>=3)
				{
				    new names[MAX_PLAYER_NAME], file[45];
 					GetPlayerName(playerid, names, sizeof(names));
 					format(file, sizeof(file), SERVER_USER_FILE, names);
					format(string, sizeof(string), "-|Players %s  has been Automatically Kicked By System Protected [System Organization President Secretary] Reason : 3/3 Warnned|- ", i);
					SendClientMessageToAll(COLOR_RED1, string);
					PlayerInfo[i][Kicked]++;
					dini_IntSet(file, "Kicked", PlayerInfo[i][Kicked]++);
					Kick(i);
     				print(string);
				}
				else
				{
					PlayerInfo[playerid][Warnings]+=1;
					if(PlayerInfo[playerid][Warnings]==1)
					{
						format(string,sizeof(string),"[SYSTEM]: You Have Received A Warning, Reason: %s, [1/3 Warnings]", reason);
						SendClientMessage(i, COLOR_RED1, string);

      					
					}
					else if(PlayerInfo[playerid][Warnings]==2)
					{
						format(string,sizeof(string),"[SYSTEM]: You Have Received A Warning, Reason: %s, [2/3 Warnings]", reason);
						SendClientMessage(i, COLOR_RED1, string);
					     
					}
					else if(PlayerInfo[playerid][Warnings]==3)
					{
	    				new str[45],namess[45];
	    				GetPlayerName(playerid, namess, sizeof(namess));
						format(str, sizeof(str), "-|Players %s (%d) has been Automatically Kicked By System Protected [President Secreatary] Reason : 3/3 Warnned|- ", namess, playerid);
						SendClientMessageToAll(COLOR_RED1, str);
					}
				format(msg,sizeof(msg),"[SYSTEM]: Administrator %s Has Given A Warn To Player : %s |Reason : %s |",adminname , name , reason);
				SendClientMessageToAll(COLOR_VIOLET, msg);
				print(msg);
				format(wadmin,sizeof(wadmin),"[SYSTEM]: You Gived A Warning, To Player : %s with Reason: %s, ", name,reason);
				SendClientMessage(playerid, COLOR_PINK, wadmin);
				GameTextForPlayer(i,"~G~You Have Received A ~n~  ~R~Warning",5000,3);

				}
			}
			else SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:You Can't Warn Your Self");
			}
		}
		else SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Command Not Found Use /cmds or /commands.!");
		return 1;
}
CMD:spawn(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 1 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		new target;
		//new name[45];
		//new name2[45];
		GetPlayerName(playerid, name2, sizeof(name2));
		GetPlayerName(target, name, sizeof(name));
		//new /*string[45];*/
	//	new string2[45];
		if(sscanf(params, "u", target)) return
		SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /spawn [playerid]") &&
		SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will Spawn Players");
		else if(target == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player is not connected!");
		else
		{
			SpawnPlayer(target);
			format(string,sizeof(string),"[SYSTEM]: You Have Spawn Player : %s",name );
			format(string2, 256,"[SYSTEM]: You Have Spawn By Administrator %s",name2 );
			SendClientMessage(playerid,COLOR_ORANGE,string);
			SendClientMessage(target,COLOR_ORANGE,string2);
		}
	}
	return 1;
}
CMD:repairv(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 1 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		//new targetid;
		//new pname[45];
		//new aname[45];
		GetPlayerName(playerid, aname, sizeof(aname));
		GetPlayerName(targetid, pname, sizeof(pname));
		//new /*string[45];*/
	//	new string2[45];
		if(sscanf(params, "u", targetid)) return
		SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /repairv [playerid]") &&
		SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will Repair Vehicle Players");
		else if(targetid == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player is not connected!");
		else
		{
		    if(!IsPlayerInAnyVehicle(targetid)) return SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player are not in a vehicle!");
			RepairVehicle(GetPlayerVehicleID(targetid));
		    format(string,sizeof(string),"[SYSTEM]: You Have Repair Vehicle Player : %s",pname );
			format(string2, 256,"[SYSTEM]: Your Vehicle has Repaired By Administrator %s",aname );
			SendClientMessage(playerid,COLOR_ORANGE,string);
			SendClientMessage(targetid,COLOR_ORANGE,string2);
			print(string);
			print(string2);
		}
	}
	return 1;
}
CMD:repair(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 1 && PlayerInfo[playerid][LoggedIn]==1)
	{
	        //new /*string[45];*/
  			if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:You are not in a vehicle!");
        		RepairVehicle(GetPlayerVehicleID(playerid));
			format(string,sizeof(string),"[SYSTEM]: You Have Repair Your Vehicle");
			SendClientMessage(playerid,COLOR_GREEN,string);

	}
	return 1;
}
CMD:fixv(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 1 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		//new targetid;
		//new pname[45];
		//new aname[45];
		GetPlayerName(playerid, aname, sizeof(aname));
		GetPlayerName(targetid, pname, sizeof(pname));
		//new /*string[45];*/
	//	new string2[45];
		if(sscanf(params, "u", targetid)) return
		SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /fixv [playerid]") &&
		SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will Set Fix Vehicles To Players");
		else if(targetid == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player is not connected!");
		else
		{
		    if(!IsPlayerInAnyVehicle(targetid)) return SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player are not in a vehicle!");
			new vehicleid = GetPlayerVehicleID(targetid);
    		SetVehicleHealth(vehicleid, 1000);
			format(string,sizeof(string),"[SYSTEM]: You Have Fixed Vehicle Engine to Player : %s",pname );
			format(string2, 256,"[SYSTEM]: Your Vehicle Engine has Fixed By Administrator %s",aname );
			SendClientMessage(playerid,COLOR_ORANGE,string);
			SendClientMessage(targetid,COLOR_ORANGE,string2);
			print(string);
			print(string2);
		}
	}
	return 1;
}

CMD:addnosv(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 1 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		//new targetid;
		//new pname[45];
		//new aname[45];
		GetPlayerName(playerid, aname, sizeof(aname));
		GetPlayerName(targetid, pname, sizeof(pname));
		//new /*string[45];*/
	//	new string2[45];
		if(sscanf(params, "u", targetid)) return
		SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /addnosv [playerid]") &&
		SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will Addnos To Players Vehicle");
		else if(targetid == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player is not connected!");
		else
		{
		    if(!IsPlayerInAnyVehicle(targetid)) return SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player are not in a vehicle!");
	 		new vehicleid = GetPlayerVehicleID(targetid);
        	AddVehicleComponent(vehicleid, 1010); // Add NOS to the vehicle
			format(string,sizeof(string),"[SYSTEM]: You Have Addnos To Vehicle Player : %s",pname );
			format(string2, 256,"[SYSTEM]: You Vehicle has Addnos By Administrator %s",aname );
			SendClientMessage(playerid,COLOR_ORANGE,string);
			SendClientMessage(targetid,COLOR_ORANGE,string2);
			print(string);
			print(string2);
		}
	}
	return 1;
}
CMD:addnos(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 1 && PlayerInfo[playerid][LoggedIn]==1)
	{
	        //new /*string[45];*/
  			if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:You are not in a vehicle!");
	 		new vehicleid = GetPlayerVehicleID(playerid);
        	AddVehicleComponent(vehicleid, 1010); // Add NOS to the vehicle
			format(string,sizeof(string),"[SYSTEM]: You Have Addnos To Your Vehicle");
			SendClientMessage(playerid,COLOR_GREEN,string);

	}
	return 1;
}
CMD:saveplace(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 1 && PlayerInfo[playerid][LoggedIn]==1)
    {
    new /*name[MAX_PLAYER_NAME],*/ file[45];
 	GetPlayerName(playerid, name, sizeof(name));
 	format(file, sizeof(file), SERVER_USER_FILE, name);
	new Float:x,Float:y,Float:z,interiors;
	interiors = GetPlayerInterior(playerid);
 GetPlayerPos(playerid,X,Y,Z);
	
	PlayerInfo[playerid][savepos]=1;
	PlayerInfo[playerid][interior]=interiors;
	dini_FloatSet(file, "PosX", PlayerInfo[playerid][PosX]=x);
	dini_FloatSet(file, "PosY", PlayerInfo[playerid][PosY]=y);
	dini_FloatSet(file, "PosZ", PlayerInfo[playerid][PosZ]=z);
	dini_IntSet(file, "Interior", PlayerInfo[playerid][interior]);
	PlayerInfo[playerid][PosX] = dini_Float(file, "PosX");
    PlayerInfo[playerid][PosY] = dini_Float(file, "PosY");
    PlayerInfo[playerid][PosZ] = dini_Float(file, "PosZ");
	PlayerInfo[playerid][interior] = dini_Int(file, "interior");
	//new /*string[45];*/
	format(string,sizeof(string),"[SYSTEM]:You have saveplace for load : /gotoplace |Save Coordinates [%.4f],[%.4f],[%.4f]|",x,y,z);
	SendClientMessage(playerid ,COLOR_GREEN,string);
	SendClientMessage(playerid ,COLOR_GREEN,"[SYSTEM]: SavePlace Succesful !");
	}
	else return emsg(playerid, 1);
	return 1;
}
CMD:gotoplace(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 1 && PlayerInfo[playerid][LoggedIn]==1)
    {
    new /*name[MAX_PLAYER_NAME],*/ file[45];
 	GetPlayerName(playerid, name, sizeof(name));
 	format(file, sizeof(file), SERVER_USER_FILE, name);
	PlayerInfo[playerid][PosX] = dini_Float(file, "PosX");
    PlayerInfo[playerid][PosY] = dini_Float(file, "PosY");
    PlayerInfo[playerid][PosZ] = dini_Float(file, "PosZ");
	PlayerInfo[playerid][interior] = dini_Int(file, "interior");
	SetPlayerPos(playerid,PlayerInfo[playerid][PosX],PlayerInfo[playerid][PosY],PlayerInfo[playerid][PosZ]);
	SetPlayerInterior(playerid,PlayerInfo[playerid][interior]);
	//new /*string[45];*/
	format(string,sizeof(string),"[SYSTEM]:Load Place |Load Coordinates [%.4f],[%.4f],[%.4f]|",PlayerInfo[playerid][PosX],PlayerInfo[playerid][PosY],PlayerInfo[playerid][PosZ]);
	SendClientMessage(playerid ,COLOR_GREEN,string);
	SendClientMessage(playerid ,COLOR_GREEN,"[SYSTEM]: LoadPlace Succesful !");
	}
	else return emsg(playerid, 1);
	return 1;
}
CMD:goto(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 1 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		//new targetid;
		//new pname[45];
		//new aname[45];
		GetPlayerName(playerid, aname, sizeof(aname));
		GetPlayerName(targetid, pname, sizeof(pname));
		//new /*string[45];*/
	//	new string2[45];
		//new Float:X,Float:Y,Float:Z;
		if(sscanf(params, "u", targetid)) return
		SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /goto [playerid]") &&
		SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will Set Level To Players");
		else if(targetid == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player is not connected!");
		else
		{
		    GetPlayerPos(targetid,X,Y,Z);
		    SetPlayerPos(playerid,X+0.5,Y,Z);
			format(string,sizeof(string),"[SYSTEM]: You Teleport To Player : %s (%d)",pname,targetid );
			format(string2, 256,"[SYSTEM]: Administrator %s Teleport to you",aname );
			SendClientMessage(playerid,COLOR_ORANGE,string);
			SendClientMessage(targetid,COLOR_ORANGE,string2);
			//new string3[45];
			format(string3, 256,"[SYSTEM]: Administrator %s has Teleport Players %s To Administrator Place",aname,pname );
   			print(string3);
		}
	}
	return 1;
}
CMD:get(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 1 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		//new targetid;
		//new pname[45];
		//new aname[45];
		GetPlayerName(playerid, aname, sizeof(aname));
		GetPlayerName(targetid, pname, sizeof(pname));
		//new /*string[45];*/
	//	new string2[45];
		//new Float:X,Float:Y,Float:Z;
		if(sscanf(params, "u", targetid)) return
		SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /get [playerid]") &&
		SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will Set Level To Players");
		else if(targetid == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player is not connected!");
		else
		{
      GetPlayerPos(playerid,X,Y,Z);
		    SetPlayerPos(targetid,X+0.5,Y,Z);
			format(string,sizeof(string),"[SYSTEM]: You Teleport Player : %s (%d) To Your Place ",pname,targetid );
			format(string2, 256,"[SYSTEM]: Administrator %s has Teleport you",aname );
			SendClientMessage(playerid,COLOR_ORANGE,string);
			SendClientMessage(targetid,COLOR_ORANGE,string2);
			//new string3[45];
			format(string3, 256,"[SYSTEM]: Administrator %s has Teleport to %s ",aname,pname );
   			print(string3);
		}
	}
	return 1;
}
// Master Employee //
CMD:spec(playerid, params[])
{
	new id;// This will hold the ID of the player you are going to be spectating.
	if(PlayerInfo[playerid][Level] >= 2 && PlayerInfo[playerid][LoggedIn]==1)
	if(sscanf(params,"u", id))return SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /spec [id]") &&
	SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will Specification on Players");// Now this is where we use sscanf to check if the params were filled, if not we'll ask you to fill them
	if(id == playerid)return SendClientMessage(playerid,COLOR_RED1,"[SYSTEM][ERROR]: You cannot spec yourself.");// Just making sure.
	if(id == INVALID_PLAYER_ID)return SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player not found!");// This is to ensure that you don't fill the param with an invalid player id.
	if(IsSpecing[playerid] == 1)return SendClientMessage(playerid,COLOR_RED1,"[SYSTEM][ERROR]: You are already spectating someone.");// This will make you not automatically spec someone else by mistake.
	GetPlayerPos(playerid,SpecX[playerid],SpecY[playerid],SpecZ[playerid]);// This is getting and saving the player's position in a variable so they'll respawn at the same place they typed '/spec'
	Inter[playerid] = GetPlayerInterior(playerid);// Getting and saving the interior.
	vWorld[playerid] = GetPlayerVirtualWorld(playerid);//Getting and saving the virtual world.
	TogglePlayerSpectating(playerid, true);// Now before we use any of the 3 functions listed above, we need to use this one. It turns the spectating mode on.
	if(IsPlayerInAnyVehicle(id))//Checking if the player is in a vehicle.
	{
		if(GetPlayerInterior(id) > 0)//If the player's interior is more than 0 (the default) then.....
		{
			SetPlayerInterior(playerid,GetPlayerInterior(id));//.....set the spectator's interior to that of the player being spectated.
		}
		if(GetPlayerVirtualWorld(id) > 0)//If the player's virtual world is more than 0 (the default) then.....
		{
			SetPlayerVirtualWorld(playerid,GetPlayerVirtualWorld(id));//.....set the spectator's virtual world to that of the player being spectated.
		}
		PlayerSpectateVehicle(playerid,GetPlayerVehicleID(id));// Now remember we checked if the player is in a vehicle, well if they're in a vehicle then we'll spec the vehicle.
	}
	else// If they're not in a vehicle, then we'll spec the player.
	{
		if(GetPlayerInterior(id) > 0)
		{
			SetPlayerInterior(playerid,GetPlayerInterior(id));
		}
		if(GetPlayerVirtualWorld(id) > 0)
		{
			SetPlayerVirtualWorld(playerid,GetPlayerVirtualWorld(id));
		}
		PlayerSpectatePlayer(playerid,id);// Letting the spectator spec the person and not a vehicle.
	}
	GetPlayerName(id, name, sizeof(name));//Getting the name of the player being spectated.
	format(string, sizeof(string),"You have started to spectate %s.",name);// Formatting a string to send to the spectator.
	SendClientMessage(playerid,0x0080C0FF,string);//Sending the formatted message to the spectator.
	IsSpecing[playerid] = 1;// Just saying that the spectator has begun to spectate someone.
	IsBeingSpeced[id] = 1;// Just saying that a player is being spectated (You'll see where this comes in)
	spectatorid[playerid] = id;// Saving the spectator's id into this variable.
	//new aname[45];
	//new pname[45];
	GetPlayerName(playerid, aname, sizeof(aname));
	GetPlayerName(id, pname, sizeof(pname));
	//new /*string[45];*/
	format(string, sizeof(string),"[SYSTEM]: Administrator %s has Spectating Player %s",aname,pname);
	print(string);
	return 1;// Returning 1 - saying that the command has been sent.
}
CMD:specoff(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 2 && PlayerInfo[playerid][LoggedIn]==1)// This checks if the player is logged into RCON, if not it will return 0; (Showing "SERVER: Unknown Command")
	if(IsSpecing[playerid] == 0)return SendClientMessage(playerid,COLOR_RED1,"[SYSTEM][ERROR]: You are not spectating anyone.");
	TogglePlayerSpectating(playerid, 0);//Toggling spectate mode, off. Note: Once this is called, the player will be spawned, there we'll need to reset their positions, virtual world and interior to where they typed '/spec'
	//new aname[45];
	GetPlayerName(playerid, aname, sizeof(aname));
	//new /*string[45];*/
	format(string, sizeof(string),"[SYSTEM]: Administrator %s has Stop Spectating Player ",aname);
	print(string);
	return 1;
}
CMD:clearchat(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 2 && PlayerInfo[playerid][LoggedIn]==1)
	{
	        //new aname[45];
			GetPlayerName(playerid, aname, sizeof(aname));
			//new /*string[45];*/
			format(string, sizeof(string),"[SYSTEM]: Administrator %s has Activated Clearchat",aname);
   			
            SendClientMessageToAll(COLOR_PINK,"");
            SendClientMessageToAll(COLOR_PINK,"");
            SendClientMessageToAll(COLOR_PINK,"");
            SendClientMessageToAll(COLOR_PINK,"");
            SendClientMessageToAll(COLOR_PINK,"");
            SendClientMessageToAll(COLOR_PINK,"");
            SendClientMessageToAll(COLOR_PINK,"");
            SendClientMessageToAll(COLOR_PINK,"");
            SendClientMessageToAll(COLOR_PINK,"");
            SendClientMessageToAll(COLOR_PINK,"");
            SendClientMessageToAll(COLOR_PINK,"");
            SendClientMessageToAll(COLOR_PINK,"");
            SendClientMessageToAll(COLOR_PINK,"");
            SendClientMessageToAll(COLOR_PINK,string);
            print(string);
	}
	else return emsg(playerid, 1);
	return 1;
}
CMD:kick(playerid ,params[])
{
	if(PlayerInfo[playerid][Level] >= 2 && PlayerInfo[playerid][LoggedIn]==1)
	{

		new i, reason[45];
		//new name[45];
//		//new string[45];
		//new msg[45];
  		//new adminname[45];
  		//new wadmin[45];
  		GetPlayerName(playerid,adminname, sizeof(adminname));
		if(sscanf(params, "us[45]", i, reason)) return
		 SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /kick [playerid] [reason]") &&
		 SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will Kick Players");
		else if(i == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player is not connected!");
		else
		{
			GetPlayerName(i, name, sizeof(name));
			if(playerid!=i)
			{
				if(PlayerInfo[i][LoggedIn]==1)
				{
				    new names[MAX_PLAYER_NAME], file[45];
 					GetPlayerName(playerid, names, sizeof(names));
 					format(file, sizeof(file), SERVER_USER_FILE, names);
 					format(msg,sizeof(msg),"[SYSTEM]: Administrator %s Has Kick Player : %s |Reason : %s |",adminname , i , reason);
					SendClientMessageToAll(COLOR_VIOLET, msg);
					print(msg);
					format(wadmin,sizeof(wadmin),"[SYSTEM]: You Have Kick Player : %s with Reason: %s, ", i,reason);
					SendClientMessage(playerid, COLOR_PINK, wadmin);
					PlayerInfo[i][Kicked]++;
					dini_IntSet(file, "Kicked", PlayerInfo[i][Kicked]++);
					Kick(i);
     				print(msg);
				}
				else
				{
				
                    SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player is not connected!");
				}
			}
			else SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:You Can't Kick Your Self");
			}
		}
		else SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Command Not Found Use /cmds or /commands.!");
		return 1;
}
CMD:pheal(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 2 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		//new targetid;
		//new pname[45];
		//new aname[45];
		GetPlayerName(playerid, aname, sizeof(aname));
		GetPlayerName(targetid, pname, sizeof(pname));
		//new /*string[45];*/
	//	new string2[45];
		//new string3[45];
		if(sscanf(params, "u", targetid)) return
		 SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /pheal [playerid]") &&
		 SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will Heal Players");
		else if(targetid == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player is not connected!");
		else
		{
			format(string,sizeof(string),"[SYSTEM]: You Heal Player : %s",pname );
			format(string2, 256,"[SYSTEM]: You got heal By Administrator %s",aname );
			SendClientMessage(playerid,COLOR_ORANGE,string);
			SendClientMessage(targetid,COLOR_ORANGE,string2);
			format(string3, 256,"[SYSTEM]: Player %s got heal By Administrator %s",pname,aname );
			print(string3);
			SetPlayerHealth(targetid,100);
		}
	}
	return 1;
}
CMD:acar(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 2 && PlayerInfo[playerid][LoggedIn]==1)
	{
   			//new Float:X, Float:Y, Float:Z, Float:angle;
			carid = 451;
			//new aname[45];
			GetPlayerName(playerid, aname, sizeof(aname));
			//new string3[45];
			//new /*string[45];*/
			format(string3, 256,"[SYSTEM]: Spawn Admin Car Successful");
			SendClientMessage(playerid,COLOR_ORANGE,string3);
			format(string, 256,"[SYSTEM]: Administrator %s Used Admin Car Spawning",aname);
			print(string);
			GetPlayerPos(playerid, X, Y, Z);
		 	GetPlayerFacingAngle(playerid, angle);

			PutPlayerInVehicle(playerid,CreateVehicle(carid, X, Y, Z, angle, -1, -1, -1),0);
  
	}
	return 1;
}
CMD:abike(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 2 && PlayerInfo[playerid][LoggedIn]==1)
	{
            //new Float:X, Float:Y, Float:Z, Float:angle;
		carid = 522;
			//new aname[45];
			GetPlayerName(playerid, aname, sizeof(aname));
			//new string3[45];
			//new /*string[45];*/
			format(string3, 256,"[SYSTEM]: Spawn Admin Bike Successful");
			SendClientMessage(playerid,COLOR_ORANGE,string3);
			format(string, 256,"[SYSTEM]: Administrator %s Used Admin Bike Spawning",aname);
			print(string);
			GetPlayerPos(playerid, X, Y, Z);
		 	GetPlayerFacingAngle(playerid, angle);
           PutPlayerInVehicle(playerid,CreateVehicle(carid, X, Y, Z, angle, -1, -1, -1),0);
			

	}
	return 1;
}
CMD:aheli(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 2 && PlayerInfo[playerid][LoggedIn]==1)
	{
   			//new Float:X, Float:Y, Float:Z, Float:angle;
			carid = 497;
			//new aname[45];
			GetPlayerName(playerid, aname, sizeof(aname));
			//new string3[45];
			//new /*string[45];*/
			format(string3, 256,"[SYSTEM]: Spawn Admin Helicopter Successful");
			SendClientMessage(playerid,COLOR_ORANGE,string3);
			format(string, 256,"[SYSTEM]: Administrator %s Used Admin Helicopter Spawning",aname);
			print(string);
			GetPlayerPos(playerid, X, Y, Z);
		 	GetPlayerFacingAngle(playerid, angle);
            PutPlayerInVehicle(playerid,CreateVehicle(carid, X, Y, Z, angle, -1, -1, -1),0);

	}
	return 1;
}
CMD:aplane(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 2 && PlayerInfo[playerid][LoggedIn]==1)
	{
   			//new Float:X, Float:Y, Float:Z, Float:angle;
			carid = 513;
			//new aname[45];
			GetPlayerName(playerid, aname, sizeof(aname));
			//new string3[45];
			//new /*string[45];*/
			format(string3, sizeof(string3),"[SYSTEM]: Spawn Admin StuntPlane Successful");
			SendClientMessage(playerid,COLOR_ORANGE,string3);
			format(string, sizeof(string),"[SYSTEM]: Administrator %s Used Admin StuntPlane Spawning",aname);
			print(string);
			GetPlayerPos(playerid, X, Y, Z);
		 	GetPlayerFacingAngle(playerid, angle);
            PutPlayerInVehicle(playerid,CreateVehicle(carid, X, Y, Z, angle, -1, -1, -1),0);

	}
	return 1;
}
CMD:paplane(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 2 && PlayerInfo[playerid][LoggedIn]==1)
	{
   			//new Float:X, Float:Y, Float:Z, Float:angle;
			carid = 519;
			//new aname[45];
			GetPlayerName(playerid, aname, sizeof(aname));
			//new string3[45];
			//new /*string[45];*/
			format(string3, 256,"[SYSTEM]: Spawn Admin Private Plane Successful");
			SendClientMessage(playerid,COLOR_ORANGE,string3);
			format(string, 256,"[SYSTEM]: Administrator %s Used Admin Private Plane Spawning",aname);
			print(string);
			GetPlayerPos(playerid, X, Y, Z);
		 	GetPlayerFacingAngle(playerid, angle);
            PutPlayerInVehicle(playerid,CreateVehicle(carid, X, Y, Z, angle, -1, -1, -1),0);

	}
	return 1;
}
CMD:aboat(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 2 && PlayerInfo[playerid][LoggedIn]==1)
	{
   			//new Float:X, Float:Y, Float:Z, Float:angle;
			carid = 493;
			//new aname[45];
			GetPlayerName(playerid, aname, sizeof(aname));
			//new string3[45];
			//new /*string[45];*/
			format(string3, 256,"[SYSTEM]: Spawn Admin Boat Successful");
			SendClientMessage(playerid,COLOR_ORANGE,string3);
			format(string, 256,"[SYSTEM]: Administrator %s Used Admin Boat Spawning",aname);
			print(string);
			GetPlayerPos(playerid, X, Y, Z);
		 	GetPlayerFacingAngle(playerid, angle);
            PutPlayerInVehicle(playerid,CreateVehicle(carid, X, Y, Z, angle, -1, -1, -1),0);

	}
	return 1;
}
CMD:givecar(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 2 && PlayerInfo[playerid][LoggedIn]==1)
	{
		//new Float:X, Float:Y, Float:Z, Float:angle;
//  		new carid;
		//new pname[45];
		//new aname[45];
		GetPlayerName(playerid, aname, sizeof(aname));
		GetPlayerName(targetid, pname, sizeof(pname));
		//new /*string[45];*/
	//	new string2[45];
		//new string3[45];
		if(sscanf(params, "ud", targetid,carid)) return
		 SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /givecar [playerid][carid]") &&
		 SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will Givecar to Players");
        if(carid < 400 || carid > 611) return  SendClientMessage(playerid, COLOR_RED, "[SYSTEM][ERROR]:Car ID between 400-611 Only !");
		else if(targetid == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player is not connected!");
		else
		{
			format(string,sizeof(string),"[SYSTEM]: You Givecar Player : %s ID:%d",pname,carid);
			format(string2, 256,"[SYSTEM]: You has been recieve car From Administrator %s",aname );
			SendClientMessage(playerid,COLOR_ORANGE,string);
			SendClientMessage(targetid,COLOR_ORANGE,string2);
			format(string3, 256,"[SYSTEM]: Player %s has been recieve By givecar from Administrator %s ID:%d",pname,aname,carid);
			print(string3);
			SendClientMessage(targetid,COLOR_RED1,string3);
			PutPlayerInVehicle(targetid,CreateVehicle(carid, X, Y, Z, angle, -1, -1, -1),0);


		}
	}
	return 1;
}
CMD:announce(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 3 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		new stext[45],text[45];
	
		//new aname[45];
		GetPlayerName(playerid, aname, sizeof(aname));
		
	
		if(sscanf(params, "s[45]",text)) return
		 SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /announce [text]") &&
		 SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will announce To All Players");
		//else if(targetid == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player is not connected!");
		else
		{
		    format(stext, sizeof(stext),"%s",text);
			GameTextForAll( stext, 5000, 3 );
			new form[45];
			format(form,sizeof(form),"Administrator %s has Announce Text : %s on Server",aname,sizeof(aname),text);
			print(form);
		}
	}
	return 1;
}

CMD:destroycars(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 1 && PlayerInfo[playerid][LoggedIn]==1)
	{
	    //new aname[45];
	    GetPlayerName(playerid,aname,sizeof(aname));
  		new vehicleid;
          vehicleid= GetPlayerVehicleID(playerid);
          DestroyVehicle(vehicleid);
	//new /*string[45];*/
	format(string,sizeof(string),"[SYSTEM]: Administrator %s Destroy Cars",aname,sizeof(aname));
	print(string);
	}
	return 1;
}
CMD:announce2(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 3 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		new style,stext[45],text[45];

		//new aname[45];
		GetPlayerName(playerid, aname, sizeof(aname));
		

		if(sscanf(params, "ds[45]", style,text)) return
		 SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /announce2 [style1-6] [playerid]") &&
		 SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will announce option To All Players");
		//else if(targetid == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player is not connected!");
		else
		{
		    format(stext, sizeof(stext),"%s",text);
			GameTextForAll( stext, 5000, style );
			new form[45];
			format(form,sizeof(form),"Administrator %s has Announce Text : %s on Server",aname,sizeof(aname),text);
			print(form);
		}
	}
	return 1;
}
CMD:heal(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 2 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		
			
			//new aname[45];
			GetPlayerName(playerid, aname, sizeof(aname));
			//new string3[45];
			//new /*string[45];*/
			format(string3, 256,"[SYSTEM]: Heal Successful");
			SendClientMessage(playerid,COLOR_ORANGE,string3);
			format(string, 256,"[SYSTEM]: Administrator %s Used Heal",aname);
			print(string);
			SetPlayerHealth(playerid,100);

	}
	return 1;
}
CMD:armour(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 2 && PlayerInfo[playerid][LoggedIn]==1)
	{


			//new aname[45];
			GetPlayerName(playerid, aname, sizeof(aname));
			//new string3[45];
			//new /*string[45];*/
			format(string3, 256,"[SYSTEM]: Armour Successful");
			SendClientMessage(playerid,COLOR_ORANGE,string3);
			format(string, 256,"[SYSTEM]: Administrator %s Used Armour",aname);
			print(string);
			SetPlayerArmour(playerid,100);

	}
	return 1;
}
CMD:disarm(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 2 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		//new targetid;
		//new pname[45];
		//new aname[45];
		GetPlayerName(playerid, aname, sizeof(aname));
		GetPlayerName(targetid, pname, sizeof(pname));
		//new /*string[45];*/
	//	new string2[45];
		//new string3[45];
		if(sscanf(params, "u", targetid)) return
		 SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /disarm [playerid]") &&
		 SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will Disarm Players");
		else if(targetid == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player is not connected!");
		else
		{
			format(string,sizeof(string),"[SYSTEM]: You Disarm Player : %s",pname );
			format(string2, 256,"[SYSTEM]: You has been Disarm By Administrator %s",aname );
			SendClientMessage(playerid,COLOR_ORANGE,string);
			SendClientMessage(targetid,COLOR_ORANGE,string2);
			format(string3, 256,"[SYSTEM]: Player %s has been Disarm By Administrator %s",pname,aname );
			print(string3);
			SendClientMessage(targetid,COLOR_RED1,string3);
			ResetPlayerWeapons(targetid);

		}
	}
	return 1;
}
CMD:hide(playerid,params[])
{
	if(PlayerInfo[playerid][Level] >=1 && PlayerInfo[playerid][LoggedIn]==1)
	{
	    if(AdminDuty[playerid] == true)
	    {
	        AdminDuty[playerid] = false;
	        SendClientMessage(playerid ,COLOR_BLUE,"[SYSTEM]: Now You are Hiding from Admins List!");
	    }
	    else if(AdminDuty[playerid] == false)
	    {
	        AdminDuty[playerid] = true;
	        SendClientMessage(playerid ,COLOR_BLUE,"[SYSTEM]: Now You are Showing at Admins List!");
	    }
 	}
 	else return 0;
	return 1;
}
CMD:admins(playerid,params[])
{
	if(PlayerInfo[playerid][LoggedIn] == 1)
	{
	    SendClientMessage(playerid, COLOR_GREEN, "====================Administrator Online===================");
	    foreach(Player,i)
	    {
	        if(PlayerInfo[i][Level] >=1 && PlayerInfo[i][LoggedIn] == 1)
	        {
				new admtext[64];
				if(PlayerInfo[i][Level] == 1) {admtext="Agent Moderator";}
				else if(PlayerInfo[i][Level] == 2) {admtext="Training Administrator";}
				else if(PlayerInfo[i][Level] == 3) {admtext="Agent Administrator";}
				else if(PlayerInfo[i][Level] == 4) {admtext="Senior Agent Administrator";}
				else if(PlayerInfo[i][Level] == 5) {admtext="Server Owner Developer";}
				GetPlayerName(i, pname, sizeof(pname));
				if(AdminDuty[i] == true)
				{
				    format(string, sizeof(string), "Player: %s | Rank : %s ", pname, admtext);

					SendClientMessage(playerid, COLOR_PINK, string);
				}

	        }
	        else
	        {
	            SendClientMessage(playerid, COLOR_RED, "There is No Admins Online but Server Protected System is Working (Admins Possible To hidden)");
	        }
	    }
	    SendClientMessage(playerid, COLOR_GREEN, "===========================================================");
	}
	return 1;
}

CMD:jail(playerid ,params[])
{
	if(PlayerInfo[playerid][Level] >= 2 && PlayerInfo[playerid][LoggedIn]==1)
	{

		new i, reason[45];
		//new name[45];
		//new string[45];
		//new msg[45];
  		//new adminname[45];
  		//new wadmin[45];
  		GetPlayerName(playerid,adminname, sizeof(adminname));
		if(sscanf(params, "us[45]d", i, reason,PlayerInfo[playerid][Jail]*60)) return
		 SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /jail [playerid] [reason] [time]") &&
		 SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will Jail Players");
		else if(i == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player is not connected!");
		else
		{
			GetPlayerName(i, name, sizeof(name));
			if(playerid!=i)
			{
				if(PlayerInfo[i][LoggedIn]==1)
				{
				    new names[MAX_PLAYER_NAME], file[45];
 					GetPlayerName(playerid, names, sizeof(names));
 					format(file, sizeof(file), SERVER_USER_FILE, names);
				format(msg,sizeof(msg),"[SYSTEM]: Administrator %s Has Jail Player : %s |Reason : %s | |%d Minutes|",adminname , i , reason,PlayerInfo[playerid][Jail]);
					SendClientMessageToAll(COLOR_VIOLET, msg);
					print(msg);
					format(wadmin,sizeof(wadmin),"[SYSTEM]: You Have Jail Player : %s  | Reason: %s | |%d Minutes| ", i,reason,PlayerInfo[playerid][Jail]);
					SendClientMessage(playerid, COLOR_PINK, wadmin);
					format(string,sizeof(string),"[SYSTEM]: You got Jailed by Administrator %s | Reason %s | |%d Minutes|",adminname,reason,PlayerInfo[playerid][Jail]);
					//dini_IntSet(file, "Jail", PlayerInfo[i][Jail]);
					SetPlayerPos(i,264.0814, 77.6404, 1001.0391);
					SetPlayerInterior(i,6);
					new jtimes;
					jtimes =  PlayerInfo[playerid][Jail];
     				SetTimerEx("SetPlayerUnjail",jtimes, 1, "d", playerid);
				}
				else
				{
				
                    SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player is not connected!");
				}
			}
			else SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:You Can't Jailed Your Self");
			}
		}
		else SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Command Not Found Use /cmds or /commands.!");
		return 1;
}
CMD:unjail(playerid ,params[])
{
	if(PlayerInfo[playerid][Level] >= 2 && PlayerInfo[playerid][LoggedIn]==1)
	{

		new i;
		//new name[45];
		//new string[45];
		//new msg[45];
  		//new adminname[45];
  		//new wadmin[45];
  		GetPlayerName(playerid,adminname, sizeof(adminname));
		if(sscanf(params, "u", i)) return
		 SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /unjail [playerid] ") &&
		 SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will UnJail Players");
		else if(i == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player is not connected!");
		else
		{
			GetPlayerName(i, name, sizeof(name));
			if(playerid!=i)
			{
				if(PlayerInfo[i][LoggedIn]==1)
				{
				    if(PlayerInfo[i][Jail] <= 0) return SendClientMessage(playerid, COLOR_RED1,"[SYSTEM][ERROR]: That Players isn't in Jail");
 					new names[MAX_PLAYER_NAME], file[45];
 					GetPlayerName(playerid, names, sizeof(names));
 					format(file, sizeof(file), SERVER_USER_FILE, names);
				format(msg,sizeof(msg),"[SYSTEM]: Administrator %s Has UnJail Player : %s ",adminname , i );
					SendClientMessageToAll(COLOR_VIOLET, msg);
					print(msg);
					format(wadmin,sizeof(wadmin),"[SYSTEM]: You Have UnJail Player : %s  ", i);
					SendClientMessage(playerid, COLOR_PINK, wadmin);
					format(string,sizeof(string),"[SYSTEM]: You got UnJailed by Administrator %s ",adminname);
					dini_IntSet(file, "Jail", PlayerInfo[i][Jail]=0);
					//SetPlayerPos(i,264.0814, 77.6404, 1001.0391);
					SetPlayerInterior(i,0);
					
				}
				else
				{

                    SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player is not connected!");
				}
			}
			else SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:You aren't Injail");
			}
		}
		else SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Command Not Found Use /cmds or /commands.!");
		return 1;
}
CMD:freeze(playerid ,params[])
{
	if(PlayerInfo[playerid][Level] >= 2 && PlayerInfo[playerid][LoggedIn]==1)
	{

		new i, reason[45];
		//new name[45];
		//new string[45];
		//new msg[45];
  		//new adminname[45];
  		//new wadmin[45];
  		GetPlayerName(playerid,adminname, sizeof(adminname));
		if(sscanf(params, "us[45]d", i, reason,FreezeTimes[playerid]*60)) return
		 SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /freeze [playerid] [reason] [time]") &&
		 SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will freeze Players");
		else if(i == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player is not connected!");
		else
		{
			GetPlayerName(i, name, sizeof(name));
			if(playerid!=i)
			{
				if(PlayerInfo[i][LoggedIn]==1)
				{
				    new names[MAX_PLAYER_NAME], file[45];
 					GetPlayerName(playerid, names, sizeof(names));
 					format(file, sizeof(file), SERVER_USER_FILE, names);
				format(msg,sizeof(msg),"[SYSTEM]: Administrator %s Has Freeze Player : %s |Reason : %s | |%d Minutes|",adminname , i , reason,PlayerInfo[playerid][Jail]);
					SendClientMessageToAll(COLOR_VIOLET, msg);
					print(msg);
					format(wadmin,sizeof(wadmin),"[SYSTEM]: You Have Freeze Player : %s  | Reason: %s | |%d Minutes| ", i,reason,PlayerInfo[playerid][Jail]);
					SendClientMessage(playerid, COLOR_PINK, wadmin);
					format(string,sizeof(string),"[SYSTEM]: You got Freeze by Administrator %s | Reason %s | |%d Minutes|",adminname,reason,PlayerInfo[playerid][Jail]);
					//dini_IntSet(file, "Jail", PlayerInfo[i][Jail]);
				
					TogglePlayerControllable(i,0);
     				SetTimerEx("SetPlayerUnFreeze",FreezeTimes[playerid], 1, "d", playerid);
				}
				else
				{

                    SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player is not connected!");
				}
			}
			else SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:You Can't Freeze Your Self");
			}
		}
		else SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Command Not Found Use /cmds or /commands.!");
		return 1;
}
CMD:unfreeze(playerid ,params[])
{
	if(PlayerInfo[playerid][Level] >= 2 && PlayerInfo[playerid][LoggedIn]==1)
	{

		new i;
		//new name[45];
		//new string[45];
		//new msg[45];
  		//new adminname[45];
  		//new wadmin[45];
  		GetPlayerName(playerid,adminname, sizeof(adminname));
		if(sscanf(params, "u", i)) return
		 SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /unfreeze [playerid] ") &&
		 SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will Unfreeze Players");
		else if(i == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player is not connected!");
		else
		{
			GetPlayerName(i, name, sizeof(name));
			if(playerid!=i)
			{
				if(PlayerInfo[i][LoggedIn]==1)
				{
				    if(FreezeTimes[i] <= 0) return SendClientMessage(playerid, COLOR_RED1,"[SYSTEM][ERROR]: That Players isn't in Unfreeze Status");
 					new names[MAX_PLAYER_NAME], file[45];
 					GetPlayerName(playerid, names, sizeof(names));
 					format(file, sizeof(file), SERVER_USER_FILE, names);
					format(msg,sizeof(msg),"[SYSTEM]: Administrator %s Has Unfreeze Player : %s ",adminname , i );
					SendClientMessageToAll(COLOR_VIOLET, msg);
					print(msg);
					format(wadmin,sizeof(wadmin),"[SYSTEM]: You Have Unfreeze Player : %s  ", i);
					SendClientMessage(playerid, COLOR_PINK, wadmin);
					format(string,sizeof(string),"[SYSTEM]: You got Unfreeze by Administrator %s ",adminname);
     				TogglePlayerControllable(i,1);
     				FreezeTimes[playerid]=0;

				}
				else
				{

                    SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player is not connected!");
				}
			}
			else SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:You aren't Freezed");
			}
		}
		else SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Command Not Found Use /cmds or /commands.!");
		return 1;
}
CMD:akill(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 2 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		//new targetid;
		//new pname[45];
		//new aname[45];
		GetPlayerName(playerid, aname, sizeof(aname));
		GetPlayerName(targetid, pname, sizeof(pname));
		//new /*string[45];*/
	//	new string2[45];
		//new string3[45];
		if(sscanf(params, "u", targetid)) return
		 SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /akill [playerid]") &&
		 SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will Use Permission Administrator Kill Players");
		else if(targetid == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player is not connected!");
		else
		{
			format(string,sizeof(string),"[SYSTEM]: You Use Permission Administrator To Kill Player : %s",pname );
			format(string2, 256,"[SYSTEM]: You Got Killed By Administrator %s",aname );
			SendClientMessage(playerid,COLOR_ORANGE,string);
			SendClientMessage(targetid,COLOR_ORANGE,string2);
			format(string3, 256,"[SYSTEM]: Player %s got Killled By Administrator %s",pname,aname );
			print(string3);
			SetPlayerHealth(targetid,0);
		}
	}
	return 1;
}
CMD:slap(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 2 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		new target;
		//new name[45];
		//new name2[45];
		GetPlayerName(playerid, name2, sizeof(name2));
		GetPlayerName(target, name, sizeof(name));
		//new /*string[45];*/
	//	new string2[45];
		if(sscanf(params, "ud", target)) return
		SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /slap [playerid] ") &&
		SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will slap To Players (25%) ");
		else if(target == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player is not connected!");
		else
		{
			SetPlayerHealth(target,-25);
			format(string,sizeof(string),"[SYSTEM]: You Have slap Player : %s",name );
			format(string2, 256,"[SYSTEM]: You Were slap By Administrator %s",name2 );
			SendClientMessage(playerid,COLOR_ORANGE,string);
			SendClientMessage(target,COLOR_ORANGE,string2);
			//new stringtext[45];
			format(stringtext,sizeof(stringtext),"[SYSTEM]: Administrator %s has slap Player %s ",name2,name);
			print(stringtext);
		}
	}
	return 1;
}
CMD:punch(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 2 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		new target;
		//new name[45];
		//new name2[45];
		GetPlayerName(playerid, name2, sizeof(name2));
		GetPlayerName(target, name, sizeof(name));
		//new /*string[45];*/
	//	new string2[45];
		if(sscanf(params, "ud", target)) return
		SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /punch [playerid] ") &&
		SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will punch To Players (50%) ");
		else if(target == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player is not connected!");
		else
		{
			SetPlayerHealth(target,-50);
			format(string,sizeof(string),"[SYSTEM]: You Have punch Player : %s",name );
			format(string2, 256,"[SYSTEM]: You Were punch By Administrator %s",name2 );
			SendClientMessage(playerid,COLOR_ORANGE,string);
			SendClientMessage(target,COLOR_ORANGE,string2);
			//new stringtext[45];
			format(stringtext,sizeof(stringtext),"[SYSTEM]: Administrator %s has punch Player %s ",name2,name);
			print(stringtext);
		}
	}
	return 1;
}
CMD:kickass(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 2 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		new target;
		//new name[45];
		//new name2[45];
		GetPlayerName(playerid, name2, sizeof(name2));
		GetPlayerName(target, name, sizeof(name));
		//new /*string[45];*/
	//	new string2[45];
		if(sscanf(params, "ud", target)) return
		SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /kickass [playerid] ") &&
		SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will kickass To Players (50%) ");
		else if(target == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player is not connected!");
		else
		{
			SetPlayerHealth(target,-75);
			format(string,sizeof(string),"[SYSTEM]: You Have kickass Player : %s",name );
			format(string2, 256,"[SYSTEM]: You Were kickass By Administrator %s",name2 );
			SendClientMessage(playerid,COLOR_ORANGE,string);
			SendClientMessage(target,COLOR_ORANGE,string2);
			//new stringtext[45];
			format(stringtext,sizeof(stringtext),"[SYSTEM]: Administrator %s has kickass Player %s ",name2,name);
			print(stringtext);
		}
	}
	return 1;
}
//-Secreatary//
CMD:ban(playerid ,params[])
{
	if(PlayerInfo[playerid][Level] >= 3 && PlayerInfo[playerid][LoggedIn]==1)
	{

		new i, reason[45];
		//new name[45];
		//new string[45];
		//new msg[45];
  		//new adminname[45];
  		//new wadmin[45];
  		GetPlayerName(playerid,adminname, sizeof(adminname));
		if(sscanf(params, "us[45]", i, reason)) return
		 SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /ban [playerid] [reason]") &&
		 SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will ban Players");
		else if(i == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player is not connected!");
		else
		{
			GetPlayerName(i, name, sizeof(name));
			if(playerid!=i)
			{
				if(PlayerInfo[i][LoggedIn]==1)
				{
				    new names[MAX_PLAYER_NAME], file[45];
 					GetPlayerName(playerid, names, sizeof(names));
 					format(file, sizeof(file), SERVER_USER_FILE, names);
 					format(msg,sizeof(msg),"[SYSTEM]: Administrator %s Has banned Player : %s |Reason : %s |",adminname , i , reason);
					SendClientMessageToAll(COLOR_VIOLET, msg);
					print(msg);
					format(wadmin,sizeof(wadmin),"[SYSTEM]: You Have ban Player : %s with Reason: %s, ", i,reason);
					SendClientMessage(playerid, COLOR_PINK, wadmin);
					format(string, sizeof(string),"[SYSTEM]: You Got Banned By Administrator %s With Reason %s You Can Unban or explain at Our webboard",adminname,reason);
					SendClientMessage(playerid, COLOR_RED1, string);
					dini_IntSet(file, "Banned", PlayerInfo[i][Banned]=1);
					Kick(i);
     				print(msg);
				}
				else
				{

                    SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player is not connected!");
				}
			}
			else SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:You Can't Ban Your Self");
			}
		}
		else SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Command Not Found Use /cmds or /commands.!");
		return 1;
}
CMD:healall(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 3 && PlayerInfo[playerid][LoggedIn]==1)
	{
	    //new adminname[60];
	    GetPlayerName(playerid, adminname,sizeof(adminname));
	    //new /*string[45];*/
	    format(string,sizeof(string),"[SYSTEM]: Administrator %s has Heal All Players !",adminname);
	    SendClientMessageToAll(COLOR_PINK,string);
	    print(string);
     	for(new i=0; i<MAX_PLAYERS; i++)
	    {
	        SetPlayerHealth(i,100);
	    }
	    //new msg[45];
	    format(msg,sizeof(msg),"[SYSTEM]: Heal All Players Successful");
	    SendClientMessage(playerid,COLOR_GREEN,msg);
	}
	return 1;
}
CMD:armourall(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 3 && PlayerInfo[playerid][LoggedIn]==1)
	{
	    //new adminname[60];
	    GetPlayerName(playerid, adminname,sizeof(adminname));
	    //new /*string[45];*/
	    format(string,sizeof(string),"[SYSTEM]: Administrator %s has Armour All Players !",adminname);
	    SendClientMessageToAll(COLOR_PINK,string);
	    print(string);
     	for(new i=0; i<MAX_PLAYERS; i++)
	    {
	        SetPlayerArmour(i,100);
	    }
	    //new msg[45];
	    format(msg,sizeof(msg),"[SYSTEM]: Armour All Players Successful");
	    SendClientMessage(playerid,COLOR_GREEN,msg);
	}
	return 1;
}
CMD:killall(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 3 && PlayerInfo[playerid][LoggedIn]==1)
	{
	    //new adminname[60];
	    GetPlayerName(playerid, adminname,sizeof(adminname));
	    //new /*string[45];*/
	    format(string,sizeof(string),"[SYSTEM]: Administrator %s has Kill All Players !",adminname);
	    SendClientMessageToAll(COLOR_PINK,string);
	    print(string);
     	for(new i=0; i<MAX_PLAYERS; i++)
	    {
	        SetPlayerHealth(i,0);
	    }
	    //new msg[45];
	    format(msg,sizeof(msg),"[SYSTEM]: Kill All Players Successful");
	    SendClientMessage(playerid,COLOR_GREEN,msg);
	}
	return 1;
}
CMD:respawnall(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 3 && PlayerInfo[playerid][LoggedIn]==1)
	{
	    //new adminname[60];
	    GetPlayerName(playerid, adminname,sizeof(adminname));
	    //new /*string[45];*/
	    format(string,sizeof(string),"[SYSTEM]: Administrator %s has Respawn All Players !",adminname);
	    SendClientMessageToAll(COLOR_PINK,string);
	    print(string);
     	for(new i=0; i<MAX_PLAYERS; i++)
	    {
	        SpawnPlayer(i);
	    }
	    //new msg[45];
	    format(msg,sizeof(msg),"[SYSTEM]: Respawn All Players Successful");
	    SendClientMessage(playerid,COLOR_GREEN,msg);
	}
	return 1;
}
CMD:getall(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 3 && PlayerInfo[playerid][LoggedIn]==1)
	{
	    //new adminname[60];
	    GetPlayerName(playerid, adminname,sizeof(adminname));
	    //new /*string[45];*/
	    format(string,sizeof(string),"[SYSTEM]: Administrator %s has Teleported All Players !",adminname);
	    new Float:PX,Float:PY,Float:PZ;
	    GetPlayerPos(playerid,PX,PY,PZ);
	    SendClientMessageToAll(COLOR_PINK,string);
	    print(string);
     	for(new i=0; i<MAX_PLAYERS; i++)
	    {
	        SetPlayerPos(i,PX+0.6,PY,PZ);
	    }
	    SetPlayerPos(playerid,PX,PY,PZ);
	    //new msg[45];
	    format(msg,sizeof(msg),"[SYSTEM]: Teleported All Players Successful");
	    SendClientMessage(playerid,COLOR_GREEN,msg);
	}
	return 1;
}
CMD:god(playerid,params[])
{
	if(god[playerid]==false)
 	{
	//new aname[45];
	GetPlayerName(playerid, aname,sizeof(aname));
	//new /*string[45];*/
	format(string,sizeof(string),"[SYSTEM]: Administrator %s Enable God Mode",aname);
	print(string);
	SendClientMessage(playerid, COLOR_GREEN,"[SYSTEM]: God Mode Enabled");
	SetPlayerHealth(playerid,999999999);
	god[playerid]=true;
	}
	else if(god[playerid]==true)
	{
	//new aname[45];
	GetPlayerName(playerid, aname,sizeof(aname));
	//new /*string[45];*/
	format(string,sizeof(string),"[SYSTEM]: Administrator %s Disable God Mode",aname);
	SendClientMessage(playerid, COLOR_GREEN,"[SYSTEM]: God Mode Disable");
	SetPlayerHealth(playerid,100);
	print(string);
	god[playerid]=false;
	}
	return 1;
}
CMD:settime(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 3 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		new target,hour,mins;
		//new name[45];
		//new name2[45];
		GetPlayerName(playerid, name2, sizeof(name2));
		GetPlayerName(target, name, sizeof(name));
		//new /*string[45];*/
	//	new string2[45];
		if(sscanf(params, "udd", target,hour,mins)) return
		SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /settime [playerid] [hour] [minute]") &&
		SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will Settime To Players");
		else if(target == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player is not connected!");
		else
		{
			SetPlayerTime(target,hour,mins);
			format(string,sizeof(string),"[SYSTEM]: You Have Settime Player : %s",name );
			format(string2, 256,"[SYSTEM]: You Were Settime By Administrator %s",name2 );
			SendClientMessage(playerid,COLOR_ORANGE,string);
			SendClientMessage(target,COLOR_ORANGE,string2);
			//new stringtext[45];
			format(stringtext,sizeof(stringtext),"[SYSTEM]: Administrator %s has set time Player %s To Hour : %d Min : %d",name2,name,hour,mins);
			print(stringtext);
		}
	}
	return 1;
}
CMD:setworld(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 3 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		new target,worldnum;
		//new name[45];
		//new name2[45];
		GetPlayerName(playerid, name2, sizeof(name2));
		GetPlayerName(target, name, sizeof(name));
		//new /*string[45];*/
	//	new string2[45];
		if(sscanf(params, "ud", target,worldnum)) return
		SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /setworld [playerid] [world]") &&
		SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will Set Virtual World To Players ");
		else if(target == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player is not connected!");
		else
		{
			SetPlayerVirtualWorld(target,worldnum);
			format(string,sizeof(string),"[SYSTEM]: You Have SetVirtualWorld Player : %s",name );
			format(string2, 256,"[SYSTEM]: You Were Set World By Administrator %s",name2 );
			SendClientMessage(playerid,COLOR_ORANGE,string);
			SendClientMessage(target,COLOR_ORANGE,string2);
			//new stringtext[45];
			format(stringtext,sizeof(stringtext),"[SYSTEM]: Administrator %s has set World Player %s To World %d",name2,name,worldnum);
			print(stringtext);
		}
	}
	return 1;
}
CMD:setpweather(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 3 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		new target,weatherids;
		//new name[45];
		//new name2[45];
		GetPlayerName(playerid, name2, sizeof(name2));
		GetPlayerName(target, name, sizeof(name));
		//new /*string[45];*/
	//	new string2[45];
		if(sscanf(params, "ud", target,weatherids)) return
		SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /setweather [playerid] [weatherid]") &&
		SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will Set Weather To Players ");
		else if(target == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player is not connected!");
		else
		{
			SetPlayerWeather(target,weatherids);
			format(string,sizeof(string),"[SYSTEM]: You Have Set Weather to Player : %s",name );
			format(string2, 256,"[SYSTEM]: You Were Set Weather By Administrator %s",name2 );
			SendClientMessage(playerid,COLOR_ORANGE,string);
			SendClientMessage(target,COLOR_ORANGE,string2);
			//new stringtext[45];
			format(stringtext,sizeof(stringtext),"[SYSTEM]: Administrator %s has set Weather Player %s To Weather %d",name2,name,weatherids);
			print(stringtext);
		}
	}
	return 1;
}
forward SetWeatherEx(weatherid);
forward GetWeather();

new CurrentWeather;

public SetWeatherEx(weatherid)
{
  SetWeather(weatherid);
  CurrentWeather = weatherid;
}

public GetWeather()
{
  return CurrentWeather;
}

CMD:sethealth(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 3 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		new target,health;
		//new name[45];
		//new name2[45];
		GetPlayerName(playerid, name2, sizeof(name2));
		GetPlayerName(target, name, sizeof(name));
		//new /*string[45];*/
	//	new string2[45];
		if(sscanf(params, "ud", target,health)) return
		SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /sethealth [playerid] [health]") &&
		SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will Set Health To Players ");
		else if(target == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player is not connected!");
		else
		{
			SetPlayerHealth(target,health);
			format(string,sizeof(string),"[SYSTEM]: You Have Set Health Player : %s",name );
			format(string2, sizeof(string2),"[SYSTEM]: You Were Set health By Administrator %s",name2 );
			SendClientMessage(playerid,COLOR_ORANGE,string);
			SendClientMessage(target,COLOR_ORANGE,string2);
			//new stringtext[45];
			format(stringtext,sizeof(stringtext),"[SYSTEM]: Administrator %s has set Health Player %s To Health %d",name2,name,health);
			print(stringtext);
		}
	}
	return 1;
}
CMD:setarmour(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 3 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		new target,armour;
		//new name[45];
		//new name2[45];
		GetPlayerName(playerid, name2, sizeof(name2));
		GetPlayerName(target, name, sizeof(name));
		//new /*string[45];*/
	//	new string2[45];
		if(sscanf(params, "ud", target,armour)) return
		SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /setarmour [playerid] [armour]") &&
		SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will Set armour To Players ");
		else if(target == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player is not connected!");
		else
		{
			SetPlayerArmour(target,armour);
			format(string,sizeof(string),"[SYSTEM]: You Have Set armour Player : %s",name );
			format(string2, 256,"[SYSTEM]: You Were Set armour By Administrator %s",name2 );
			SendClientMessage(playerid,COLOR_ORANGE,string);
			SendClientMessage(target,COLOR_ORANGE,string2);
			//new stringtext[45];
			format(stringtext,sizeof(stringtext),"[SYSTEM]: Administrator %s has set armour Player %s To armour %d",name2,name,armour);
			print(stringtext);
		}
	}
	return 1;
}
CMD:setname(playerid, params[])
{
    
    if(PlayerInfo[playerid][Level] >= 3 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		new target,name3[45];
		//new name[45];
		//new name2[45];
		GetPlayerName(playerid, name2, sizeof(name2));
		GetPlayerName(target, name, sizeof(name));
		//new /*string[45];*/
	//	new string2[45];
		if(sscanf(params, "us", target,name3,sizeof(name3))) return
		SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /setname [playerid] [name]") &&
		SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will Set Name To Players ");
		else if(target == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player is not connected!");
		else
		{
			SetPlayerName(target,name3);
			format(string,sizeof(string),"[SYSTEM]: You Have Set name Player : %s",name );
			format(string2, 256,"[SYSTEM]: You Were Set name By Administrator %s",name2 );
			SendClientMessage(playerid,COLOR_ORANGE,string);
			SendClientMessage(target,COLOR_ORANGE,string2);
			//new stringtext[45];
			format(stringtext,sizeof(stringtext),"[SYSTEM]: Administrator %s has set Name Player %s To Name : %d",name2,name,name3);
			print(stringtext);
			//
			new welcometext[45], playerswelcome[MAX_PLAYER_NAME];
			GetPlayerName(target, playerswelcome, sizeof(playerswelcome));
			format(welcometext, sizeof(welcometext), "Welcome To Our Server %s ", playerswelcome);
			new name5[MAX_PLAYER_NAME], file[45];
			GetPlayerName(target, name5, sizeof(name5));
			format(file, sizeof(file), SERVER_USER_FILE, name5);
    		ShowPlayerDialog(target, 9876, DIALOG_STYLE_PASSWORD, welcometext , "Welcome, your have changed your name by setname of administrator and server didn't registered , Please input your registration password below", "Register", "Quit");
		}
    
	}
	return 1;
}
CMD:giveweapon(playerid,params[])
{
    if(PlayerInfo[playerid][Level] >= 3 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		//new targetid;
		//new name[45];
		//new name2[45];
	
		GetPlayerName(playerid, name2, sizeof(name2));
		GetPlayerName(targetid, name, sizeof(name));
			if(sscanf(params, "u", targetid)) return
		SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /giveweapon [playerid]") &&
		SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will Giveweapon To  Players ");
		if(targetid == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player is not connected!");
		//
        ShowPlayerDialog(playerid, 8777, 2, "Please Weapons to give !", "Melee\nEexplosive\nPistols\nShotguns\nSub-machine guns\nAssault-Rifles\nHeavy weapons\nHand held\nApparel\nSpecial", "Select", "Exit");
  	    wpid[playerid] = targetid;


	}
	return 1;
}
//
CMD:setcash(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 3 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		new target,cash;
		//new name[45];
		//new name2[45];
		GetPlayerName(playerid, name2, sizeof(name2));
		GetPlayerName(target, name, sizeof(name));
		//new /*string[45];*/
	//	new string2[45];
		if(sscanf(params, "ud", target,cash)) return
		SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /setcash [playerid] [cash]") &&
		SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will Set cash To Players ");
		else if(target == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player is not connected!");
		else
		{
		    ResetPlayerMoney(target);
		   	GivePlayerMoney(target,cash);
			format(string,sizeof(string),"[SYSTEM]: You Have Set cash Player : %s",name );
			format(string2, 256,"[SYSTEM]: You Were Set cash By Administrator %s",name2 );
			SendClientMessage(playerid,COLOR_ORANGE,string);
			SendClientMessage(target,COLOR_ORANGE,string2);
			//new stringtext[45];
			format(stringtext,sizeof(stringtext),"[SYSTEM]: Administrator %s has set cash Player %s To cash %d",name2,name,cash);
			print(stringtext);
		}
	}
	return 1;
}
CMD:setscore(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 3 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		new target,score;
		//new name[45];
		//new name2[45];
		GetPlayerName(playerid, name2, sizeof(name2));
		GetPlayerName(target, name, sizeof(name));
		//new /*string[45];*/
	//	new string2[45];
		if(sscanf(params, "ud", target,score)) return
		SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /setscore [playerid] [score]") &&
		SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will set score To Players ");
		else if(target == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player is not connected!");
		else
		{
		   	SetPlayerScore(target,score);
			format(string,sizeof(string),"[SYSTEM]: You Have Give score Player : %s",name );
			format(string2, 256,"[SYSTEM]: You Were Give score By Administrator %s",name2 );
			SendClientMessage(playerid,COLOR_ORANGE,string);
			SendClientMessage(target,COLOR_ORANGE,string2);
			//new stringtext[45];
			format(stringtext,sizeof(stringtext),"[SYSTEM]: Administrator %s has set score Player %s Set score to %d",name2,name,score);
			print(stringtext);
		}
	}
	return 1;
}
CMD:givecash(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 3 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		new target,cash;
		//new name[45];
		//new name2[45];
		GetPlayerName(playerid, name2, sizeof(name2));
		GetPlayerName(target, name, sizeof(name));
		//new /*string[45];*/
	//	new string2[45];
		if(sscanf(params, "ud", target,cash)) return
		SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /givecash [playerid] [cash]") &&
		SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will give cash To Players ");
		else if(target == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player is not connected!");
		else
		{

		   	GivePlayerMoney(target,cash);
			format(string,sizeof(string),"[SYSTEM]: You Have Give cash Player : %s",name );
			format(string2, 256,"[SYSTEM]: You Were Give cash By Administrator %s",name2 );
			SendClientMessage(playerid,COLOR_ORANGE,string);
			SendClientMessage(target,COLOR_ORANGE,string2);
			//new stringtext[45];
			format(stringtext,sizeof(stringtext),"[SYSTEM]: Administrator %s has Give cash Player %s Give cash %d",name2,name,cash);
			print(stringtext);
		}
	}
	return 1;
}
CMD:givescore(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 3 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		new target,score,scorebehind;
		//new name[45];
		//new name2[45];
		GetPlayerName(playerid, name2, sizeof(name2));
		GetPlayerName(target, name, sizeof(name));
		//new /*string[45];*/
	//	new string2[45];
		if(sscanf(params, "ud", target,score)) return
		SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /givescore [playerid] [score]") &&
		SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will give score To Players ");
		else if(target == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player is not connected!");
		else
		{
			scorebehind = GetPlayerScore(target) ;
			score = score+scorebehind;
		   	SetPlayerScore(target,score);
			format(string,sizeof(string),"[SYSTEM]: You Have Give score Player : %s",name );
			format(string2, 256,"[SYSTEM]: You Were Give score By Administrator %s",name2 );
			SendClientMessage(playerid,COLOR_ORANGE,string);
			SendClientMessage(target,COLOR_ORANGE,string2);
			//new stringtext[45];
			format(stringtext,sizeof(stringtext),"[SYSTEM]: Administrator %s has Give score Player %s Give score %d",name2,name,score);
			print(stringtext);
		}
	}
	return 1;
}
stock IsVehicleOccupied(vehicleid)
{
	for(new i =0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerInVehicle(i,vehicleid))
		{
			return 1;
		}
	}return 0;
}
//Level 4//
CMD:respawncar(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 4 && PlayerInfo[playerid][LoggedIn]==1)
	{


			//new aname[45];
			GetPlayerName(playerid, aname, sizeof(aname));
			//new string3[45];
			//new string[45];
			format(string3, 100,"[SYSTEM]: Respawncars Successful");
			SendClientMessage(playerid,COLOR_ORANGE,string3);
			format(string, 100,"[SYSTEM]: Administrator %s Respawncars in Server !",aname);
			SendClientMessageToAll(COLOR_RED,string);
			print(string);
			new bool:VehicleUsed[MAX_VEHICLES] = false;
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerInAnyVehicle(i)) VehicleUsed[GetPlayerVehicleID(i)] = true;
			}
			for(new i = 0; i < MAX_VEHICLES; i++)
			{
				if(VehicleUsed[i] == false) SetVehicleToRespawn(i);
			}

	}
	return 1;
}
CMD:giveallscore(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 4 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		new score;
	//	//new name[45];
		//new name2[45];
		GetPlayerName(playerid, name2, sizeof(name2));
		//GetPlayerName(target, name, sizeof(name));
		//new /*string[45];*/
	//	new string2[45];
		if(sscanf(params, "d",score)) return
		SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /giveallscore [score]") &&
		SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will give score To All Players ");
		else
		{
		    new pscore[MAX_PLAYERS];
			for(new i=0;i<MAX_PLAYERS;i++)
			{
			    pscore[i] = GetPlayerScore(i) + score;
			    SetPlayerScore(i,pscore[i]);
			    
				format(string2, 256,"[SYSTEM]: You Were Give score By Administrator %s",name2 );
				SendClientMessage(i,COLOR_ORANGE,string2);
			}
			format(string,sizeof(string),"[SYSTEM]: You Have Give score To All Player");
			SendClientMessage(playerid,COLOR_ORANGE,string);
		   	//new stringtext[45];
		   	
			format(stringtext,sizeof(stringtext),"[SYSTEM]: Administrator %s has Give All score To Player | Give score %d",name2,score);
            SendClientMessageToAll(COLOR_ORANGE,stringtext);
           	print(stringtext);
		}
	}
	return 1;
}
CMD:giveallcash(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 4 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		new cash;
//		//new name[45];
		//new name2[45];
		GetPlayerName(playerid, name2, sizeof(name2));
		//GetPlayerName(target, name, sizeof(name));
		//new /*string[45];*/
	//	new string2[45];
		if(sscanf(params, "d",cash)) return
		SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /giveallcash [cash]") &&
		SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will give cash To All Players ");
		else
		{
		    
			for(new i=0;i<MAX_PLAYERS;i++)
			{
			   GivePlayerMoney(i,cash);
			   format(string2, 256,"[SYSTEM]: You Were Give cash By Administrator %s",name2 );
			   SendClientMessage(i,COLOR_ORANGE,string2);
			}
		   	//new stringtext[45];
		   	format(string,sizeof(string),"[SYSTEM]: You Have Give cash To All Player  %s");
			
			format(stringtext,sizeof(stringtext),"[SYSTEM]: Administrator %s has Give All cash To Player | Give cash %d",name2,cash);
            SendClientMessageToAll(COLOR_ORANGE,stringtext);
            SendClientMessage(playerid,COLOR_ORANGE,string);
			
			print(stringtext);
		}
	}
	return 1;
}
CMD:giveallweapons(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 4 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		new weaps;
		////new name[45];
		//new name2[45];
		GetPlayerName(playerid, name2, sizeof(name2));
		//GetPlayerName(target, name, sizeof(name));
		//new /*string[45];*/
	//	new string2[45];
		if(sscanf(params, "d",weaps)) return
		SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /giveallweapons [weaponsID]") &&
		SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will give weapons To All Players ");
		else
		{

			for(new i=0;i<MAX_PLAYERS;i++)
			{
			   GivePlayerWeapon(i,weaps,500);
			   format(string2, 256,"[SYSTEM]: You Were Give weapons By Administrator %s",name2 );
			   SendClientMessage(i,COLOR_ORANGE,string2);
			}
		   	//new stringtext[45];
		   	format(string,sizeof(string),"[SYSTEM]: You Have Give weapons To All Player");
			format(stringtext,sizeof(stringtext),"[SYSTEM]: Administrator %s has Give All weapons To Player | Give weapons ID: %d",name2,weaps);
            SendClientMessageToAll(COLOR_ORANGE,stringtext);
            SendClientMessage(playerid,COLOR_ORANGE,string);
			print(stringtext);
		}
	}
	return 1;
}
CMD:setallscore(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 4 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		new score;
		////new name[45];
		//new name2[45];
		GetPlayerName(playerid, name2, sizeof(name2));
		//GetPlayerName(target, name, sizeof(name));
		//new /*string[45];*/
	//	new string2[45];
		if(sscanf(params, "d",score)) return
		SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /setallscore [score]") &&
		SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will set score To All Players ");
		else
		{

			for(new i=0;i<MAX_PLAYERS;i++)
			{
			   SetPlayerScore(i,score);
			   format(string2, 256,"[SYSTEM]: You Were Set Score By Administrator %s",name2 );
			   SendClientMessage(i,COLOR_ORANGE,string2);
			}
		   	//new stringtext[45];
		   	format(string,sizeof(string),"[SYSTEM]: You Have Set Score To All Player");
			format(stringtext,sizeof(stringtext),"[SYSTEM]: Administrator %s has Set All Score To Player | Set Score to %d",name2,score);
            SendClientMessageToAll(COLOR_ORANGE,stringtext);
            SendClientMessage(playerid,COLOR_ORANGE,string);
			
			print(stringtext);
		}
	}
	return 1;
}
CMD:setallcash(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 4 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		new pv;
		////new name[45];
		//new name2[45];
		GetPlayerName(playerid, name2, sizeof(name2));
		//new /*string[45];*/
	//	new string2[45];
		if(sscanf(params, "d",pv)) return
		SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /setallcash [cash]") &&
		SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will set cash To All Players ");
		else
		{

			for(new i=0;i<MAX_PLAYERS;i++)
			{
			    ResetPlayerMoney(i);
			   GivePlayerMoney(i,pv);
			   format(string2, 256,"[SYSTEM]: You Were Set cash By Administrator %s",name2 );
			   SendClientMessage(i,COLOR_ORANGE,string2);
			}
		   	//new stringtext[45];
			format(stringtext,sizeof(stringtext),"[SYSTEM]: Administrator %s has Set All cash To Player | Set cash to %d",name2,pv);
            SendClientMessageToAll(COLOR_ORANGE,stringtext);
            SendClientMessage(playerid,COLOR_ORANGE,string);

			print(stringtext);
		}
	}
	return 1;
}
CMD:setweather(playerid,params[])
{
    if(PlayerInfo[playerid][Level] >= 4 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		//new target,weatherids;
		////new name[45];
		//new name2[45];
		GetPlayerName(playerid, name2, sizeof(name2));
		//GetPlayerName(target, name, sizeof(name));
		//new /*string[45];*/
		//new string2[45];
		SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /setweather ") &&
		SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will Set Server Weather To All Players ");
		//else if(target == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player is not connected!");
		ShowPlayerDialog(playerid, DIALOGID, DIALOG_STYLE_LIST, "Server Weather", "Blue Sky\nStormy\nFoggy\nScorching Hot\nDull\nSandstorm\nGreen Fog\nDark - Purple\nDark - Green\nPink Sky\nRed Sky\nPurple Sky\nBlack Sky\nMorning Sky\nMystic Blue Sky", "Select", "Cancel");

			GetWeather();
			format(string,sizeof(string),"[SYSTEM]: You Have Set Server Weather for All Player ");
			//format(string2, 256,"[SYSTEM]: You Were Set Weather By Administrator %s",name2 );
			SendClientMessage(playerid,COLOR_ORANGE,string);
			//SendClientMessage(target,COLOR_ORANGE,string2);
			//new stringtext[45];
			format(stringtext,sizeof(stringtext),"[SYSTEM]: Administrator %s has set Weather To All Player To Weather %d",name2,CurrentWeather);
			print(stringtext);

	}
	return 1;
}
CMD:setweatherid(playerid,params[])
{
    if(PlayerInfo[playerid][Level] >= 4 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		new weatherids;
		////new name[45];
		//new name2[45];
		GetPlayerName(playerid, name2, sizeof(name2));
		//GetPlayerName(target, name, sizeof(name));
		//new /*string[45];*/
		//new string2[45];
		SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /setweather [id] ") &&
		SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will Set Server Weather By ID To All Players ");
		//else if(target == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player is not connected!");
		//ShowPlayerDialog(playerid, DIALOGID, DIALOG_STYLE_LIST, "Server Weather", "Blue Sky\nStormy\nFoggy\nScorching Hot\nDull\nSandstorm\nGreen Fog\nDark - Purple\nDark - Green\nPink Sky\nRed Sky\nPurple Sky\nBlack Sky\nMorning Sky\nMystic Blue Sky", "Select", "Cancel");

			SetWeather(weatherids);
			format(string,sizeof(string),"[SYSTEM]: You Have Set Server Weather ID %d for All Player ",weatherids);
			//format(string2, 256,"[SYSTEM]: You Were Set Weather By Administrator %s",name2 );
			SendClientMessage(playerid,COLOR_ORANGE,string);
			//SendClientMessage(target,COLOR_ORANGE,string2);
			//new stringtext[45];
			format(stringtext,sizeof(stringtext),"[SYSTEM]: Administrator %s has set Weather To All Player To Weather %d",name2,weatherids);
			print(stringtext);

	}
	return 1;
}
//level 5//
CMD:setkills(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 5 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		new target,kills;
		//new name[45];
		//new name2[45];
		GetPlayerName(playerid, name2, sizeof(name2));
		GetPlayerName(target, name, sizeof(name));
		//new /*string[45];*/
	//	new string2[45];
		if(sscanf(params, "ud", target,kills)) return
		SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /setkills [playerid] [kills]") &&
		SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will Set kills To Players ");
		else if(target == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player is not connected!");
		else
		{
			PlayerInfo[playerid][Kills] = kills;
			format(string,sizeof(string),"[SYSTEM]: You Have Set kills Player : %s",name );
			format(string2, 256,"[SYSTEM]: You Were Set Kills By Administrator %s",name2 );
			SendClientMessage(playerid,COLOR_ORANGE,string);
			SendClientMessage(target,COLOR_ORANGE,string2);
			//new stringtext[45];
			format(stringtext,sizeof(stringtext),"[SYSTEM]: Administrator %s has set Kills Player %s To %d Kills",name2,name,kills);
			print(stringtext);
		}
	}
	return 1;
}
CMD:setdeath(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 5 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		new target,deaths;
		//new name[45];
		//new name2[45];
		GetPlayerName(playerid, name2, sizeof(name2));
		GetPlayerName(target, name, sizeof(name));
		//new /*string[45];*/
	//	new string2[45];
		if(sscanf(params, "ud", target,deaths)) return
		SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /setdeath [playerid] [deaths]") &&
		SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will Set deaths To Players ");
		else if(target == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player is not connected!");
		else
		{
			PlayerInfo[playerid][Death] = deaths;
			format(string,sizeof(string),"[SYSTEM]: You Have Set kills Player : %s",name );
			format(string2, 256,"[SYSTEM]: You Were Set Kills By Administrator %s",name2 );
			SendClientMessage(playerid,COLOR_ORANGE,string);
			SendClientMessage(target,COLOR_ORANGE,string2);
			//new stringtext[45];
			format(stringtext,sizeof(stringtext),"[SYSTEM]: Administrator %s has set Kills Player %s To %d Death",name2,name,deaths);
			print(stringtext);
		}
	}
	return 1;
}
CMD:rpk(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 5 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		new target;
		//new name[45];
		//new name2[45];
		GetPlayerName(playerid, name2, sizeof(name2));
		GetPlayerName(target, name, sizeof(name));
		//new /*string[45];*/
	//	new string2[45];
		if(sscanf(params, "u", target)) return
		SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /rpk [playerid]") &&
		SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will Start Set RPK To Players ") &&
		SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][WARNING] : Important This Mean Destroy Player Account ! ") &&
		SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][WARNING] : Important This Mean Destroy Player Account ! ") &&
		SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][WARNING] : Important This Mean Destroy Player Account ! ") &&
		SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][WARNING] : Important This Mean Destroy Player Account ! ") &&
		SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][WARNING] : Important This Mean Destroy Player Account ! ");
		else if(target == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player is not connected!");
		else
		{
			PlayerInfo[target][RPK] = 1;
			format(string,sizeof(string),"[SYSTEM]: You Have Start Roleplay Killed Player : %s",name );
			format(string2, 256,"[SYSTEM]: You Were Started be Roleplay Killed By Administrator %s ",name2 );
			SendClientMessage(playerid,COLOR_ORANGE,string);
			SendClientMessage(target,COLOR_ORANGE,string2);
			//SendClientMessage(target,COLOR_ORANGE,"[COLONEL]: Died with Honor or Died with Bitches ?");
			//new stringtext[45];
			format(stringtext,sizeof(stringtext),"[SYSTEM]: Administrator %s has Start Roleplay Kills Player %s ",name2,name);
			SendClientMessageToAll(COLOR_RED,stringtext);
			SendClientMessageToAll(COLOR_RED,"[COLONEL]: Dear %s You will died with Honor or Died like Bitches ?");
			print(stringtext);
			//
			new name3[MAX_PLAYER_NAME], file[45];
			print("Set File Path Finished");
			GetPlayerName(playerid, name3, sizeof(name3));
			print("GetPlayerName Finish");
			format(file, sizeof(file), SERVER_USER_FILE, name3);
			print("File Path Loaded");
			dini_IntSet(file, "RPK", PlayerInfo[target][RPK]);
			print("RoleplayKilled Profile Writed!");
			SetWeather(8);
			//
		}
	}
	return 1;
}
CMD:cancelrpk(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 5 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		new target;
		//new name[45];
		//new name2[45];
		GetPlayerName(playerid, name2, sizeof(name2));
		GetPlayerName(target, name, sizeof(name));
		//new /*string[45];*/
	//	new string2[45];
		if(sscanf(params, "u", target)) return
		SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /cancelrpk [playerid]") &&
		SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will Stop Set RPK To Players ");
		else if(target == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player is not connected!");
		else
		{
			PlayerInfo[target][RPK] = 0;
			format(string,sizeof(string),"[SYSTEM]: You Have Stop Roleplay Killed Player : %s",name );
			format(string2, 256,"[SYSTEM]: You Were Stop be Roleplay Killed By Administrator %s ",name2 );
			SendClientMessage(playerid,COLOR_ORANGE,string);
			SendClientMessage(target,COLOR_ORANGE,string2);
			//SendClientMessage(target,COLOR_ORANGE,"[COLONEL]: Died with Honor or Died with Bitches ?");
			//new stringtext[45];
			format(stringtext,sizeof(stringtext),"[SYSTEM]: Administrator %s has Stop Roleplay Kills Player %s ",name2,name);
			SendClientMessageToAll(COLOR_RED,stringtext);
			print(stringtext);
			//
			new name3[MAX_PLAYER_NAME], file[45];
			print("Set File Path Finished");
			GetPlayerName(playerid, name3, sizeof(name3));
			print("GetPlayerName Finish");
			format(file, sizeof(file), SERVER_USER_FILE, name3);
			print("File Path Loaded");
			dini_IntSet(file, "RPK", PlayerInfo[target][RPK]);
			print("RoleplayKilled Profile Writed!");
			SetWeather(0);
			//
		}
	}
	return 1;
}
//addition//
CMD:myrank(playerid,params[])
	{
	     if(GetPlayerScore(playerid) >= 0 && GetPlayerScore(playerid) <= 50)
		{
    	//new string[45];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Private & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        //new Text3D:label = Create3DTextLabel("Rank : Private", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		//Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
		if(GetPlayerScore(playerid) >= 51 && GetPlayerScore(playerid) <= 100)
    	{
    	//new string[45];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Second Private & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        //new Text3D:label = Create3DTextLabel("Rank : Second Private", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		//Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
        if(GetPlayerScore(playerid) >= 101 && GetPlayerScore(playerid) <= 150)
    	{
    	//new string[45];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Lance Corporal & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        //new Text3D:label = Create3DTextLabel("Rank : Corporal", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		//Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
		if(GetPlayerScore(playerid) >= 151 && GetPlayerScore(playerid) <= 250)
    	{
    	//new string[45];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Corporal & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        //new Text3D:label = Create3DTextLabel("Rank : Sergeant", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		//Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
        if(GetPlayerScore(playerid) >= 251 && GetPlayerScore(playerid) <= 350)
    	{
    	//new string[45];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Sergeant & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        //new Text3D:label = Create3DTextLabel("Rank : Staff Sergeant", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
	//	Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
		if(GetPlayerScore(playerid) >= 351 && GetPlayerScore(playerid) <= 500)
    	{
    	//new string[45];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Staff Sergeant & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        //new Text3D:label = Create3DTextLabel("Rank : Lieutenant", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		//Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
        if(GetPlayerScore(playerid) >= 501 && GetPlayerScore(playerid) <= 750)
    	{
    	//new string[45];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Warrant Officer & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
       // new Text3D:label = Create3DTextLabel("Rank : Second Lieutenant", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		//Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
        if(GetPlayerScore(playerid) >= 751 && GetPlayerScore(playerid) <= 1000)
    	{
    	//new string[45];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Corporal Warrant Officer & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        //new Text3D:label = Create3DTextLabel("Rank : Captain", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		//Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
		if(GetPlayerScore(playerid) >= 1001 && GetPlayerScore(playerid) <= 1600)
    	{
    	//new string[45];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Second Lieutinant & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        //new Text3D:label = Create3DTextLabel("Rank : Major", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		//Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
		if(GetPlayerScore(playerid) >= 1601 && GetPlayerScore(playerid) <= 2200)
    	{
    	//new string[45];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Lieutinant & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        //new Text3D:label = Create3DTextLabel("Rank : Colonel", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		//Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		if(GetPlayerScore(playerid) >= 2201 && GetPlayerScore(playerid) <= 3500)
    	{
    	//new string[45];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Captain & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        //new Text3D:label = Create3DTextLabel("Rank : Marshall", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		//Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
		if(GetPlayerScore(playerid) >= 3501 && GetPlayerScore(playerid) <= 4000)
    	{
    	//new string[45];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Major & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        //new Text3D:label = Create3DTextLabel("Rank : Commander", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		//Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
        if(GetPlayerScore(playerid) >= 4001 && GetPlayerScore(playerid) <= 4500)
    	{
    	//new string[45];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Lieutinant Colonel & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        //new Text3D:label = Create3DTextLabel("Rank : Staff Commander", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		//Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
		if(GetPlayerScore(playerid) >= 4501 && GetPlayerScore(playerid) <= 5000)
    	{
    	//new string[45];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Major Colonel & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        //new Text3D:label = Create3DTextLabel("Rank : General", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		//Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		if(GetPlayerScore(playerid) >= 5001 && GetPlayerScore(playerid) <= 5500)
    	{
    	//new string[45];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Colonel & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        //new Text3D:label = Create3DTextLabel("Rank : General", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		//Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
		if(GetPlayerScore(playerid) >= 5501 && GetPlayerScore(playerid) <= 6000)
    	{
    	//new string[45];
		format(string, sizeof(string), "Rank INFO : Your Rank Is  Colonel & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        //new Text3D:label = Create3DTextLabel("Rank : General", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		//Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
		if(GetPlayerScore(playerid) >= 6001 && GetPlayerScore(playerid) <= 7000)
    	{
    	//new string[45];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Lieutenant General & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        //new Text3D:label = Create3DTextLabel("Rank : General", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		//Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
		if(GetPlayerScore(playerid) >= 7001 && GetPlayerScore(playerid) <= 8500)
    	{
    	//new string[45];
		format(string, sizeof(string), "Rank INFO : Your Rank Is General & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        //new Text3D:label = Create3DTextLabel("Rank : General", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		//Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		if(GetPlayerScore(playerid) >= 8601)
    	{
    	//new string[45];
		format(string, sizeof(string), "Rank INFO : Your Rank Is General of army & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        //new Text3D:label = Create3DTextLabel("Rank : General", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		//Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
		//
		//
	
	}
   CMD:rank(playerid,params[])
	{
	    SendClientMessage(playerid,0x99FFFFAA,"Rank ");
	    SendClientMessage(playerid,0x99FFFFAA,"-Private,-Second Private,-Corporal");
	    SendClientMessage(playerid,0x99FFFFAA,"-Sergeant,-Staff Sergeant,-Lieutenant");
	    SendClientMessage(playerid,0x99FFFFAA,"-Second Lieutenant,-Captain,-Major,-Colonel");
	    SendClientMessage(playerid,0x99FFFFAA,"-Marshall,-Commander,-Staff Commander,-General,-General Of army");
	    return 1;
	}
    CMD:djcolonel(playerid,params[])
    {
        SendClientMessage(playerid,COLOR_BLUE,"/fearless,/bdl,/harlemshake,/werunthenight,/turnupthelove,/dktc");
        SendClientMessage(playerid,COLOR_BLUE,"/chasingthesun,/rollinginthedeep,/whistle,/low,/turnaround");
        SendClientMessage(playerid,COLOR_BLUE,"/igottafeeling,/wildones,/partyrock,/boomboompow,/rainitoverme");
        SendClientMessage(playerid,COLOR_BLUE,"/dontwannagohomeremix,/payphone,/gmevt,/gangnamstyle,/gtasa");
        return 1;
    }
    
    	CMD:endanim(playerid,params[])
	{
	    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);
	    ClearAnimations(playerid);
	    return 1;
	}
	CMD:chute(playerid,params[])
	{
	GivePlayerWeapon(playerid,46,1);
	return 1;
	}
    

	CMD:handsup(playerid,params[])
	{
    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_HANDSUP);
    return 1;
	}

    CMD:stopmusic(playerid,params[])
    {
    	if(PlayerInfo[playerid][Level] >= 4 && PlayerInfo[playerid][LoggedIn]==1)
    {
        	for (new i=0; i < MAX_PLAYERS; i++)
	{
	    StopAudioStreamForPlayer(i);

	}
		SendClientMessageToAll(COLOR_BLUE, "Music Has Been Stopped");
    }
    else SendClientMessage(playerid, COLOR_WHITE, "ERROR: You not is Administrator Level 4");
  return 1;
    }
   
     CMD:toulousefull(playerid,params[])
    {
    	if(PlayerInfo[playerid][Level] >= 4 && PlayerInfo[playerid][LoggedIn]==1)
    	{
        	for (new i=0; i < MAX_PLAYERS; i++)
			{
	    		StopAudioStreamForPlayer(i);
	    		PlayAudioStreamForPlayer(i, "http://k003.kiwi6.com/hotlink/rvjpg2aer7/Nicky_Romero_-_Toulouse_Headhunterz_Remix_HQ_Original_Full_.mp3");

			}
		SendClientMessageToAll(COLOR_BLUE, "Toulouse Nicky Romero");
		}
		else SendClientMessage(playerid, COLOR_WHITE, "SERVER: UNKNOWN COMMAND");
  		return 1;
    }
    CMD:fearless(playerid,params[])
    {
    	if(PlayerInfo[playerid][Level] >= 4 && PlayerInfo[playerid][LoggedIn]==1)
    {
        	for (new i=0; i < MAX_PLAYERS; i++)
	{
	    StopAudioStreamForPlayer(i);
	    PlayAudioStreamForPlayer(i, "http://k003.kiwi6.com/hotlink/t9isx037r6/01._fearless.mp3");

	}
		SendClientMessageToAll(COLOR_BLUE, "Fearless Taylor Swift");
    }
    else SendClientMessage(playerid, COLOR_WHITE, "SERVER: UNKNOWN COMMAND");
  return 1;
    }
    CMD:bdl(playerid,params[])
    {
    	if(PlayerInfo[playerid][Level] >= 4 && PlayerInfo[playerid][LoggedIn]==1)
    {
        	for (new i=0; i < MAX_PLAYERS; i++)
	{
	    StopAudioStreamForPlayer(i);
	    PlayAudioStreamForPlayer(i, "http://k004.kiwi6.com/hotlink/fi3oxk8cqv/dev_-_bass_down_low_explicit_ft._the_cataracs.mp3");

	}
		SendClientMessageToAll(COLOR_BLUE, "Dev- Bass Down Low");
    }
    else SendClientMessage(playerid, COLOR_WHITE, "SERVER: UNKNOWN COMMAND");
  return 1;
    }
    CMD:harlemshake(playerid,params[])
    {
    	if(PlayerInfo[playerid][Level] >= 4 && PlayerInfo[playerid][LoggedIn]==1)
    {
        	for (new i=0; i < MAX_PLAYERS; i++)
	{
	    StopAudioStreamForPlayer(i);
	    PlayAudioStreamForPlayer(i, "http://k006.kiwi6.com/hotlink/blj6m2nk7h/baauer_-_harlem_shake_hq_full_version_.mp3");

	}
		SendClientMessageToAll(COLOR_BLUE, "Baauer Harlem Shake!");
    }
    else SendClientMessage(playerid, COLOR_WHITE, "SERVER: UNKNOWN COMMAND");
  return 1;
    }
    CMD:danza(playerid,params[])
    {
    	if(PlayerInfo[playerid][Level] >= 4 && PlayerInfo[playerid][LoggedIn]==1)
    {
        	for (new i=0; i < MAX_PLAYERS; i++)
	{
	    StopAudioStreamForPlayer(i);
	    PlayAudioStreamForPlayer(i, "http://k004.kiwi6.com/hotlink/8n3iw9h6i1/15._don_omar_-_danza_kuduro_feat._lucenzo_urbananew.net_.mp3");

	}
		SendClientMessageToAll(COLOR_BLUE, "Don Omar Danza Kuduro");
    }
    else SendClientMessage(playerid, COLOR_WHITE, "SERVER: UNKNOWN COMMAND");
  return 1;
    }
    CMD:werunthenight(playerid,params[])
    {
    	if(PlayerInfo[playerid][Level] >= 4 && PlayerInfo[playerid][LoggedIn]==1)
    {
        	for (new i=0; i < MAX_PLAYERS; i++)
	{
	    StopAudioStreamForPlayer(i);
	    PlayAudioStreamForPlayer(i, "http://k005.kiwi6.com/hotlink/51k156iw7v/havana_brown_-_we_run_the_night_explicit_ft._pitbull.mp3");

	}
		SendClientMessageToAll(COLOR_BLUE, "We run the night havana brown");
    }
    else SendClientMessage(playerid, COLOR_WHITE, "SERVER: UNKNOWN COMMAND");
  return 1;
    }
    CMD:turnupthelove(playerid,params[])
    {
    	if(PlayerInfo[playerid][Level] >= 4 && PlayerInfo[playerid][LoggedIn]==1)
    {
        	for (new i=0; i < MAX_PLAYERS; i++)
	{
	    StopAudioStreamForPlayer(i);
	    PlayAudioStreamForPlayer(i, "http://k005.kiwi6.com/hotlink/uxh07l0628/far_east_movement_-_turn_up_the_love_ft._cover_drive.mp3");

	}
		SendClientMessageToAll(COLOR_BLUE, "Turn Up The Love Far east movement");
    }
    else SendClientMessage(playerid, COLOR_WHITE, "SERVER: UNKNOWN COMMAND");
  return 1;
    }
    CMD:dktc(playerid,params[])
    {
    	if(PlayerInfo[playerid][Level] >= 4 && PlayerInfo[playerid][LoggedIn]==1)
    {
        	for (new i=0; i < MAX_PLAYERS; i++)
	{
	    StopAudioStreamForPlayer(i);
	    PlayAudioStreamForPlayer(i, "http://k007.kiwi6.com/hotlink/8o508sp8bh/dia_frampton_-_don_t_kick_the_chair_feat._kid_cudi.mp3");

	}
		SendClientMessageToAll(COLOR_BLUE, "Dont Kick The Chair");
    }
    else SendClientMessage(playerid, COLOR_WHITE, "SERVER: UNKNOWN COMMAND");
  return 1;
    }
    CMD:chasingthesun(playerid,params[])
    {
    	if(PlayerInfo[playerid][Level] >= 4 && PlayerInfo[playerid][LoggedIn]==1)
    {
        	for (new i=0; i < MAX_PLAYERS; i++)
	{
	    StopAudioStreamForPlayer(i);
	    PlayAudioStreamForPlayer(i, "http://k006.kiwi6.com/hotlink/7d896rq3r3/the_wanted_chasing_the_sun_lyrics_.mp3");

	}
		SendClientMessageToAll(COLOR_BLUE, "Chasing The Sun The Wanted");
    }
    else SendClientMessage(playerid, COLOR_WHITE, "SERVER: UNKNOWN COMMAND");
  return 1;
    }
    CMD:rollinginthedeep(playerid,params[])
    {
    	if(PlayerInfo[playerid][Level] >= 4 && PlayerInfo[playerid][LoggedIn]==1)
    {
        	for (new i=0; i < MAX_PLAYERS; i++)
	{
	    StopAudioStreamForPlayer(i);
	    PlayAudioStreamForPlayer(i, "http://k005.kiwi6.com/hotlink/7m85s2j477/rolling_in_the_deep_adele_lyrics.mp3");

	}
		SendClientMessageToAll(COLOR_BLUE, "Adele Rolling in The Deep");
    }
    else SendClientMessage(playerid, COLOR_WHITE, "SERVER: UNKNOWN COMMAND");
  return 1;
    }
    CMD:whistle(playerid,params[])
    {
    	if(PlayerInfo[playerid][Level] >= 4 && PlayerInfo[playerid][LoggedIn]==1)
    {
        	for (new i=0; i < MAX_PLAYERS; i++)
	{
	    StopAudioStreamForPlayer(i);
	    PlayAudioStreamForPlayer(i, "http://k004.kiwi6.com/hotlink/6bnq403zgq/whistle_-_flo_rida_-_lyrics.mp3");

	}
		SendClientMessageToAll(COLOR_BLUE, "Whistle Florida");
    }
    else SendClientMessage(playerid, COLOR_WHITE, "SERVER: UNKNOWN COMMAND");
  return 1;
    }
    CMD:low(playerid,params[])
    {
    	if(PlayerInfo[playerid][Level] >= 4 && PlayerInfo[playerid][LoggedIn]==1)
    {
        	for (new i=0; i < MAX_PLAYERS; i++)
	{
	    StopAudioStreamForPlayer(i);
	    PlayAudioStreamForPlayer(i, "http://k002.kiwi6.com/hotlink/lkm07p4r3v/low.mp3");

	}
		SendClientMessageToAll(COLOR_BLUE, "Low Florida");
    }
    else SendClientMessage(playerid, COLOR_WHITE, "SERVER: UNKNOWN COMMAND");
  return 1;
    }
    CMD:turnaround(playerid,params[])
    {
    	if(PlayerInfo[playerid][Level] >= 4 && PlayerInfo[playerid][LoggedIn]==1)
    {
        	for (new i=0; i < MAX_PLAYERS; i++)
	{
	    StopAudioStreamForPlayer(i);
	    PlayAudioStreamForPlayer(i, "http://k007.kiwi6.com/hotlink/fi6xcn3faq/turaroun_54321.mp3");

	}
		SendClientMessageToAll(COLOR_BLUE, "Turn around 5 4 3 2 1 Florida");
    }
    else SendClientMessage(playerid, COLOR_WHITE, "SERVER: UNKNOWN COMMAND");
  return 1;
    }
    CMD:igottafeeling(playerid,params[])
    {
    	if(PlayerInfo[playerid][Level] >= 4 && PlayerInfo[playerid][LoggedIn]==1)
    {
        	for (new i=0; i < MAX_PLAYERS; i++)
	{
	    StopAudioStreamForPlayer(i);
	    PlayAudioStreamForPlayer(i, "http://k007.kiwi6.com/hotlink/4du8husn5v/black_eyed_pears_-_i_gotta_feeling.mp3");

	}
		SendClientMessageToAll(COLOR_BLUE, "Black eyed pears - i gotta feeling");
    }
    else SendClientMessage(playerid, COLOR_WHITE, "SERVER: UNKNOWN COMMAND");
  return 1;
    }
    CMD:wildones(playerid,params[])
    {
    	if(PlayerInfo[playerid][Level] >= 4 && PlayerInfo[playerid][LoggedIn]==1)
    {
        	for (new i=0; i < MAX_PLAYERS; i++)
	{
	    StopAudioStreamForPlayer(i);
	    PlayAudioStreamForPlayer(i, "http://k007.kiwi6.com/hotlink/76rhk279y5/flo_rida_feat_sia_-_wild_ones_lyric_video_.mp3");

	}
		SendClientMessageToAll(COLOR_BLUE, "Florida Wild ones");
    }
    else SendClientMessage(playerid, COLOR_WHITE, "SERVER: UNKNOWN COMMAND");
  return 1;
    }
    CMD:partyrock(playerid,params[])
    {
    	if(PlayerInfo[playerid][Level] >= 4 && PlayerInfo[playerid][LoggedIn]==1)
    {
        	for (new i=0; i < MAX_PLAYERS; i++)
	{
	    StopAudioStreamForPlayer(i);
	    PlayAudioStreamForPlayer(i, "http://k004.kiwi6.com/hotlink/y8s25t216e/lmfao_-_party_rock_anthem_ft._lauren_bennett_goonrock_saveyoutube.com_mp3_.mp3");

	}
		SendClientMessageToAll(COLOR_BLUE, "party Rock Anthem");
    }
    else SendClientMessage(playerid, COLOR_WHITE, "SERVER: UNKNOWN COMMAND");
  return 1;
    }
    CMD:boomboompow(playerid,params[])
    {
    	if(PlayerInfo[playerid][Level] >= 4 && PlayerInfo[playerid][LoggedIn]==1)
    {
        	for (new i=0; i < MAX_PLAYERS; i++)
	{
	    StopAudioStreamForPlayer(i);
	    PlayAudioStreamForPlayer(i, "http://k005.kiwi6.com/hotlink/749vz375qw/01_-_boom_boom_pow-black_eyed_peas.mp3");

	}
		SendClientMessageToAll(COLOR_BLUE, "Boom Boom Pow Black Eyes Pears");
    }
    else SendClientMessage(playerid, COLOR_WHITE, "SERVER: UNKNOWN COMMAND");
  return 1;
    }
    CMD:rainitoverme(playerid,params[])
    {
    	if(PlayerInfo[playerid][Level] >= 4 && PlayerInfo[playerid][LoggedIn]==1)
    {
        	for (new i=0; i < MAX_PLAYERS; i++)
	{
	    StopAudioStreamForPlayer(i);
	    PlayAudioStreamForPlayer(i, "http://k002.kiwi6.com/hotlink/wa479lko42/pitbul_ft_marc_anthony_-_rain_over_me_dj._android_ecuador.mp3");

	}
		SendClientMessageToAll(COLOR_BLUE, "Rain It Over Me Pitbull");
    }
    else SendClientMessage(playerid, COLOR_WHITE, "SERVER: UNKNOWN COMMAND");
  return 1;
    }
    CMD:dontwannagohomeremix(playerid,params[])
    {
    	if(PlayerInfo[playerid][Level] >= 4 && PlayerInfo[playerid][LoggedIn]==1)
    {
        	for (new i=0; i < MAX_PLAYERS; i++)
	{
	    StopAudioStreamForPlayer(i);
	    PlayAudioStreamForPlayer(i, "http://k006.kiwi6.com/hotlink/1d8er9611n/dont_wannagohome_remix.mp3");

	}
		SendClientMessageToAll(COLOR_BLUE, "Dont wannagohome remix (DJ COLONEL)");
    }
    else SendClientMessage(playerid, COLOR_WHITE, "SERVER: UNKNOWN COMMAND");
  return 1;
    }
    CMD:payphone(playerid,params[])
    {
    	if(PlayerInfo[playerid][Level] >= 4 && PlayerInfo[playerid][LoggedIn]==1)
    {
        	for (new i=0; i < MAX_PLAYERS; i++)
	{
	    StopAudioStreamForPlayer(i);
	    PlayAudioStreamForPlayer(i, "http://k004.kiwi6.com/hotlink/zh2th40925/maroon_5_-_payphone_lyrics_ft._wiz_khalifa.mp3");

	}
		SendClientMessageToAll(COLOR_BLUE, "Payphone Maroon 5");
    }
    else SendClientMessage(playerid, COLOR_WHITE, "SERVER: UNKNOWN COMMAND");
  return 1;
    }
    CMD:gmevt(playerid,params[])
    {
    	if(PlayerInfo[playerid][Level] >= 4 && PlayerInfo[playerid][LoggedIn]==1)
    {
        	for (new i=0; i < MAX_PLAYERS; i++)
	{
	    StopAudioStreamForPlayer(i);
	    PlayAudioStreamForPlayer(i, "http://k002.kiwi6.com/hotlink/ysl4qs4unc/givemeeverything_pitbull_remix.mp3");

	}
		SendClientMessageToAll(COLOR_BLUE, "Givemeeverything pitbull remix (DJ COLONEL)");
    }
    else SendClientMessage(playerid, COLOR_WHITE, "SERVER: UNKNOWN COMMAND");
  return 1;
    }
    CMD:gangnamstyle(playerid,params[])
    {
    	if(PlayerInfo[playerid][Level] >= 4 && PlayerInfo[playerid][LoggedIn]==1)
    {
        	for (new i=0; i < MAX_PLAYERS; i++)
	{
	    StopAudioStreamForPlayer(i);
	    PlayAudioStreamForPlayer(i, "http://k002.kiwi6.com/hotlink/de1pvm2789/psy_-_gangnam_style_m_v.mp3");

	}
		SendClientMessageToAll(COLOR_BLUE, "PSY Gangnam style");
    }
    else SendClientMessage(playerid, COLOR_WHITE, "SERVER: UNKNOWN COMMAND");
  return 1;
    }
    CMD:gtasa(playerid,params[])
    {
    	if(PlayerInfo[playerid][Level] >= 4 && PlayerInfo[playerid][LoggedIn]==1)
    {
        	for (new i=0; i < MAX_PLAYERS; i++)
	{
	    StopAudioStreamForPlayer(i);
	    PlayAudioStreamForPlayer(i, "http://k004.kiwi6.com/hotlink/o8ofo2yvj9/gta_san_andreas_trailer.mp3");

	}
		SendClientMessageToAll(COLOR_BLUE, "Gta san andreas ");
    }
    else SendClientMessage(playerid, COLOR_WHITE, "SERVER: UNKNOWN COMMAND");
  return 1;
    }
    CMD:mylovesong(playerid,params[])
    {
    	if(PlayerInfo[playerid][Level] >= 4 && PlayerInfo[playerid][LoggedIn]==1)
    {
        	for (new i=0; i < MAX_PLAYERS; i++)
	{
	    StopAudioStreamForPlayer(i);
	    PlayAudioStreamForPlayer(i, "http://k002.kiwi6.com/hotlink/kp58fg663k/chipmunk_feat_chris_brown_-_champion_www.mp3fiber.com_.mp3");

	}
		SendClientMessageToAll(COLOR_BLUE, "Gta san andreas ");
    }
    else SendClientMessage(playerid, COLOR_WHITE, "SERVER: UNKNOWN COMMAND");
  return 1;
    }
    CMD:naked(playerid,params[])
    {
    	if(PlayerInfo[playerid][Level] >= 4 && PlayerInfo[playerid][LoggedIn]==1)
    {
        	for (new i=0; i < MAX_PLAYERS; i++)
	{
	    StopAudioStreamForPlayer(i);
	    PlayAudioStreamForPlayer(i, "http://k007.kiwi6.com/hotlink/53gjt4xf3s/dev_-_naked_ft_enrique_iglesias_www.mp3fiber.com_.mp3");

	}
		SendClientMessageToAll(COLOR_BLUE, "Dev Naked");
    }
    else SendClientMessage(playerid, COLOR_WHITE, "SERVER: UNKNOWN COMMAND");
  return 1;
    }
   CMD:allbeer(playerid,params[])
    {
    if(PlayerInfo[playerid][Level] >= 4 && PlayerInfo[playerid][LoggedIn]==1)
    {
        for(new i = 0; i < MAX_PLAYERS; i++)
	{
		SetPlayerSpecialAction(i,SPECIAL_ACTION_DRINK_BEER);
	}
	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DRINK_BEER);
	}
    else SendClientMessage(playerid, COLOR_WHITE, "ERROR: You not is Administrator Level 4");
  return 1;
    }
    CMD:midnight(playerid,params[])
    {
    if(PlayerInfo[playerid][Level] >= 4 && PlayerInfo[playerid][LoggedIn]==1)
    {
        for(new i = 0; i < MAX_PLAYERS; i++)
		{
		    SetWorldTime(24);
		}
		SetWorldTime(24);
	}
    else SendClientMessage(playerid, COLOR_WHITE, "ERROR: You not is Administrator Level 4");
  return 1;
    }

   CMD:morning(playerid,params[])
    {
    if(PlayerInfo[playerid][Level] >= 4 && PlayerInfo[playerid][LoggedIn]==1)
    {
        for(new i = 0; i < MAX_PLAYERS; i++)
		{
		    SetWorldTime(9);
		}
		SetWorldTime(9);
	}
    else SendClientMessage(playerid, COLOR_WHITE, "ERROR: You not is Administrator Level 4");
  return 1;
    }
   CMD:early(playerid,params[])
    {
    if(PlayerInfo[playerid][Level] >= 4 && PlayerInfo[playerid][LoggedIn]==1)
    {
        for(new i = 0; i < MAX_PLAYERS; i++)
		{
		    SetWorldTime(4);
		}
		SetWorldTime(4);
	}
    else SendClientMessage(playerid, COLOR_WHITE, "ERROR: You not is Administrator Level 4");
  return 1;
    }
   CMD:evening(playerid,params[])
    {
    if(PlayerInfo[playerid][Level] >= 4 && PlayerInfo[playerid][LoggedIn]==1)
    {
        for(new i = 0; i < MAX_PLAYERS; i++)
		{
		    SetWorldTime(18);
		}
		SetWorldTime(18);
	}
    else SendClientMessage(playerid, COLOR_WHITE, "ERROR: You not is Administrator Level 4");
  return 1;
    }
 CMD:login(playerid,params[])
 {
    new /*name[MAX_PLAYER_NAME],*/ file[45];
	GetPlayerName(playerid, name, sizeof(name));
	format(file, sizeof(file), SERVER_USER_FILE, name);
	if (!dini_Exists(file))
	{
	    if(PlayerInfo[playerid][Register] == 0)
	    {
	    new welcometext[45], playerswelcome[MAX_PLAYER_NAME];
		GetPlayerName(playerid, playerswelcome, sizeof(playerswelcome));
		format(welcometext, sizeof(welcometext), "Welcome To Our Server %s ", playerswelcome);
	    SendClientMessage(playerid,COLOR_CYAN,"Your Name is not registered Please Register !");
		ShowPlayerDialog(playerid, 2323, DIALOG_STYLE_PASSWORD, welcometext , "Welcome, your name didn't registered now, Please input your registration password below", "Register", "Quit");
		}

	}
	if(fexist(file))
	{
	    new welcomeback[45], playerswelcome[MAX_PLAYER_NAME];
		GetPlayerName(playerid, playerswelcome, sizeof(playerswelcome));
		format(welcomeback, sizeof(welcomeback), "Welcome To Back Our Server %s ", playerswelcome);
		ShowPlayerDialog(playerid, 2424, DIALOG_STYLE_PASSWORD, welcomeback, "Let's Login to your account Please input your password to login", "Login", "Quit");

	}
	//
	//new pname[MAX_PLAYER_NAME];//, string[256 + MAX_PLAYER_NAME];
    GetPlayerName(playerid, pname, sizeof(pname));
    format(string, sizeof(string), "Player %s (Id:%d) has Connected To the server", pname,playerid);
    SendClientMessageToAll(COLOR_LEMON, string);
    return 1;
 }
 

#define GELTONA 0xFF66FFAA
#define BALTA 0x33AA33AA


	//=== MENIU ===
    CMD:cars(playerid,params[])
	{

	    //GameTextForPlayer(playerid,"~w~~h~IN-GAME CAR SPAWNER~n~by:~r~~h~cepiokas",2500,1);
	    if(PlayerInfo[playerid][Level] <= 2) return emsg(playerid,1);
	    if(PlayerInfo[playerid][LoggedIn] ==0) return emsg(playerid,1);
		SendClientMessage(playerid,GELTONA,"999999999999999999999 Help Menu 6666666666666666666666");
		SendClientMessage(playerid,BALTA,"=== /huntley /landstalker /perrenial /rancher /rancher2 /regina /banshee /bullet /zr-350 /benson /dumper ===");
		SendClientMessage(playerid,BALTA,"=== /romero /solair /alpha /blista /bravura /buccaneer /cadrona /cheetah /comet /turismo /windsor /dozer ===");
		SendClientMessage(playerid,BALTA,"=== /club /esperanto /feltzer /fortune /hermes /hustler /majestic /hotknife /infernus /supergt /mesa ===");
        SendClientMessage(playerid,BALTA,"=== /manana /picador /previon /stafford /stallion /tampa /virgo /hotring /hotringa /hotringb /dft-30 ===");
		SendClientMessage(playerid,BALTA,"=== /admiral /elegant /emperor /euros /glendale /glendale2 /greenwood /boxville /boxville2 /cementtruck ===");
		SendClientMessage(playerid,BALTA,"=== /intruder /merit /nebula /oceanic /premier /primo /sentinel /stretch /dune /flatbed /hotdog /linerunner ===");
		SendClientMessage(playerid,BALTA,"=== /sunrise /tahoma /vincent /washington /willard /buffalo /clover /mrwoopee /mule /packer /roadtrain ===");
		SendClientMessage(playerid,BALTA,"=== /phoenix /sabre /elegy /flash /jester /stratum /sultan /uranus /tanker /tractor /yankee /topfun ===");
		SendClientMessage(playerid,BALTA,"=== /bobcat /burrito /forklift /moonbeam /mower /newsvan /pony /rumpo /sadler /sadler2 /tug /walton ===");
		SendClientMessage(playerid,BALTA,"=== /blade /broadway /remington /savanna /slamvan /tornado /voodoo /yosemite /linerunner  /combine ===");
        SendClientMessage(playerid,GELTONA,"=== /other /bikes /public /security /aircrafts /boats /rccars ===");
		return 1;
	}
	CMD:other(playerid,params[])
	{
	    if(PlayerInfo[playerid][Level] <= 2) return emsg(playerid,1);
	    if(PlayerInfo[playerid][LoggedIn] ==0) return emsg(playerid,1);
		SendClientMessage(playerid,GELTONA,"=========================== OTHER ========================");
        SendClientMessage(playerid,BALTA,"=== /bandito /bfinjection /bloodringbanger /caddy /camper /journey /kart /monster /monstera /monsterb ===");
        SendClientMessage(playerid,BALTA,"=== /quad /sandking /vortex ===");
	 	return 1;
 		}
		CMD:bikes(playerid,params[])
	{
	    if(PlayerInfo[playerid][Level] <= 2) return emsg(playerid,1);
	    if(PlayerInfo[playerid][LoggedIn] ==0) return emsg(playerid,1);
		SendClientMessage(playerid,GELTONA,"=========================== BIKES ========================");
        SendClientMessage(playerid,BALTA,"=== /bmx /bike /mountainbike /bf-400 /faggio /fcr-900 /freeway /nrg-500 /pcj-600 /pizzaboy /sanchez /wayfarer ===");
		return 1;
		}
		CMD:public(playerid,params[])
	{
	    if(PlayerInfo[playerid][Level] <= 2) return emsg(playerid,1);
	    if(PlayerInfo[playerid][LoggedIn] ==0) return emsg(playerid,1);
		SendClientMessage(playerid,GELTONA,"=========================== PUBLIC ========================");
        SendClientMessage(playerid,BALTA,"=== /baggage /bus /ambulance /cabbie /coach /sweeper /taxi /towtruck /trashmaster /utilityvan ===");
		return 1;
		}
		CMD:security(playerid,params[])
	{
	    if(PlayerInfo[playerid][Level] <= 2) return emsg(playerid,1);
	    if(PlayerInfo[playerid][LoggedIn] ==0) return emsg(playerid,1);
		SendClientMessage(playerid,GELTONA,"*=========================== SECURITY ========================");
        SendClientMessage(playerid,BALTA,"=== /barracks /enforcer /fbirancher /fbitruck /firetruck /firetrucka /hpv-1000 /patriot /rhino ===");
        SendClientMessage(playerid,BALTA,"=== /policels /policesf /policelv /policeranger /securicar /swattank ===");
		return 1;
		}
		CMD:aircrafts(playerid,params[])
	{
	    if(PlayerInfo[playerid][Level] <= 2) return emsg(playerid,1);
	    if(PlayerInfo[playerid][LoggedIn] ==0) return emsg(playerid,1);
		SendClientMessage(playerid,GELTONA,"*=========================== AIRCRAFTS ========================");
        SendClientMessage(playerid,BALTA,"=== /andromada /at-400 /beagle /cargobob /cropduster /dodo /hunter /leviathan /maverick /nevada /hydra ===");
        SendClientMessage(playerid,BALTA,"=== /newsmaverick /policemaverick /raindance /rustler /seasparrow /shamal /skimmer /sparrow /stuntplane ===");
		return 1;
		}
		CMD:boats(playerid,params[])
	{
	    if(PlayerInfo[playerid][Level] <= 2) return emsg(playerid,1);
	    if(PlayerInfo[playerid][LoggedIn] ==0) return emsg(playerid,1);
		SendClientMessage(playerid,GELTONA,"*=========================== BOATS ========================");
        SendClientMessage(playerid,BALTA,"=== /coastguard /dingy /jetmax /launch /marquis /predator /reefer /speeder /squallo /tropic ===");
		return 1;
		}
		CMD:rccars(playerid,params[])
	{
	    if(PlayerInfo[playerid][Level] <= 2) return emsg(playerid,1);
	    if(PlayerInfo[playerid][LoggedIn] ==0) return emsg(playerid,1);
		SendClientMessage(playerid,GELTONA,"*=========================== RC CARS ========================");
        SendClientMessage(playerid,BALTA,"=== /rcbandit /rcbaron /rccam /rcgoblin /rcgoblin2 /rctiger ===");
		return 1;
		}
	//=== CAR CODES ===
		CMD:huntley(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~HUNTLEY~n~~h~~w~ID:~h~~r~579",2500,1);
	CreateVehicle(579,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:landstalker(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~LANDSTALKER~n~~h~~w~ID:~h~~r~400",2500,1);
	CreateVehicle(400,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:perrenial(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~PERRENIAL~n~~h~~w~ID:~h~~r~404",2500,1);
	CreateVehicle(404,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:rancher(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~RANCHER~n~~h~~w~ID:~h~~r~489",2500,1);
	CreateVehicle(489,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:rancher2(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~ANOTHER RANCHER~n~~h~~w~ID:~h~~r~505",2500,1);
	CreateVehicle(505,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:regina(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~REGINA~n~~h~~w~ID:~h~~r~479",2500,1);
	CreateVehicle(479,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:romero(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~ROMERO~n~~h~~w~ID:~h~~r~442",2500,1);
	CreateVehicle(442,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:solair(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~SOLAIR~n~~h~~w~ID:~h~~r~458",2500,1);
	CreateVehicle(458,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:alpha(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~ALPHA~n~~h~~w~ID:~h~~r~602",2500,1);
	CreateVehicle(602,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:blista(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~BLISTA COMPACT~n~~h~~w~ID:~h~~r~496",2500,1);
	CreateVehicle(496,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:bravura(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~BRAVURA~n~~h~~w~ID:~h~~r~401",2500,1);
	CreateVehicle(401,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:buccaneer(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~BUCCANEER~n~~h~~w~ID:~h~~r~518",2500,1);
	CreateVehicle(518,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:cadrona(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~CADRONA~n~~h~~w~ID:~h~~r~527",2500,1);
	CreateVehicle(527,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:club(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~CLUB~n~~h~~w~ID:~h~~r~589",2500,1);
	CreateVehicle(589,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:esperanto(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~ESPERANTO~n~~h~~w~ID:~h~~r~419",2500,1);
	CreateVehicle(419,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:feltzer(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~FELTZER~n~~h~~w~ID:~h~~r~533",2500,1);
	CreateVehicle(533,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:fortune(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~FORTUNE~n~~h~~w~ID:~h~~r~526",2500,1);
	CreateVehicle(526,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:hermes(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~HERMES~n~~h~~w~ID:~h~~r~474",2500,1);
	CreateVehicle(474,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:hustler(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~HUSTLER~n~~h~~w~ID:~h~~r~545",2500,1);
	CreateVehicle(545,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:majestic(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~MAJESTIC~n~~h~~w~ID:~h~~r~517",2500,1);
	CreateVehicle(517,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:manana(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~MANANA~n~~h~~w~ID:~h~~r~410",2500,1);
	CreateVehicle(410,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:picador(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~PICADOR~n~~h~~w~ID:~h~~r~600",2500,1);
	CreateVehicle(600,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:previon(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~PREVION~n~~h~~w~ID:~h~~r~436",2500,1);
	CreateVehicle(436,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:stafford(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~STAFFORD~n~~h~~w~ID:~h~~r~580",2500,1);
	CreateVehicle(580,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:stallion(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~STALLION~n~~h~~w~ID:~h~~r~439",2500,1);
	CreateVehicle(439,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:tampa(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~TAMPA~n~~h~~w~ID:~h~~r~549",2500,1);
	CreateVehicle(549,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:virgo(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~VIRGO~n~~h~~w~ID:~h~~r~491",2500,1);
	CreateVehicle(491,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:admiral(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~ADMIRAL~n~~h~~w~ID:~h~~r~445",2500,1);
	CreateVehicle(445,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:elegant(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~ELEGANT~n~~h~~w~ID:~h~~r~507",2500,1);
	CreateVehicle(507,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:emperor(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~EMPEROR~n~~h~~w~ID:~h~~r~585",2500,1);
	CreateVehicle(585,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:euros(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~EUROS~n~~h~~w~ID:~h~~r~587",2500,1);
	CreateVehicle(587,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:glendale(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~GLENDALE~n~~h~~w~ID:~h~~r~466",2500,1);
	CreateVehicle(466,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:greenwood(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~GREENWOOD~n~~h~~w~ID:~h~~r~492",2500,1);
	CreateVehicle(492,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:intruder(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~INTRUDER~n~~h~~w~ID:~h~~r~546",2500,1);
	CreateVehicle(546,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:merit(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~MERIT~n~~h~~w~ID:~h~~r~551",2500,1);
	CreateVehicle(551,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:nebula(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~NEBULA~n~~h~~w~ID:~h~~r~516",2500,1);
	CreateVehicle(516,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:oceanic(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~OCEANIC~n~~h~~w~ID:~h~~r~467",2500,1);
	CreateVehicle(467,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:premier(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~PREMIER~n~~h~~w~ID:~h~~r~426",2500,1);
	CreateVehicle(426,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:primo(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~PRIMO~n~~h~~w~ID:~h~~r~547",2500,1);
	CreateVehicle(547,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:sentinel(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~SENTINEL~n~~h~~w~ID:~h~~r~405",2500,1);
	CreateVehicle(405,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:stretch(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~STRETCH~n~~h~~w~ID:~h~~r~409",2500,1);
	CreateVehicle(409,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:sunrise(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~SUNRISE~n~~h~~w~ID:~h~~r~550",2500,1);
	CreateVehicle(550,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:tahoma(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~TAHOMA~n~~h~~w~ID:~h~~r~566",2500,1);
	CreateVehicle(566,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:vincent(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~VINCENT~n~~h~~w~ID:~h~~r~540",2500,1);
	CreateVehicle(540,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:washington(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~WASHINGTON~n~~h~~w~ID:~h~~r~421",2500,1);
	CreateVehicle(421,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:willard(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~WILLARD~n~~h~~w~ID:~h~~r~529",2500,1);
	CreateVehicle(529,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
/*		CMD:majestic(playerid,params[])
	{
	new Float:X;
	new Float:Y;
	new Float:Z;
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~MAJESTIC~n~~h~~w~ID:~h~~r~517",2500,1);
	CreateVehicle(517,X,Y+5,Z,1,1,1,90000);
	return 1;
	}*/
		CMD:buffalo(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~BUFFALO~n~~h~~w~ID:~h~~r~402",2500,1);
	CreateVehicle(402,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:clover(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~CLOVER~n~~h~~w~ID:~h~~r~542",2500,1);
	CreateVehicle(542,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:phoenix(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~PHOENIX~n~~h~~w~ID:~h~~r~603",2500,1);
	CreateVehicle(603,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:sabre(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~SABRE~n~~h~~w~ID:~h~~r~475",2500,1);
	CreateVehicle(475,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:elegy(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~ELEGY~n~~h~~w~ID:~h~~r~562",2500,1);
	CreateVehicle(562,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:flash(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~FLASH~n~~h~~w~ID:~h~~r~565",2500,1);
	CreateVehicle(565,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:jester(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~JESTER~n~~h~~w~ID:~h~~r~559",2500,1);
	CreateVehicle(559,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:stratum(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~STRATUM~n~~h~~w~ID:~h~~r~561",2500,1);
	CreateVehicle(561,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:sultan(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~SULTAN~n~~h~~w~ID:~h~~r~560",2500,1);
	CreateVehicle(560,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
  		CMD:uranus(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~URANUS~n~~h~~w~ID:~h~~r~558",2500,1);
	CreateVehicle(558,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:banshee(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~BANSHEE~n~~h~~w~ID:~h~~r~429",2500,1);
	CreateVehicle(429,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:bullet(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~BULLET~n~~h~~w~ID:~h~~r~541",2500,1);
	CreateVehicle(541,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:cheetah(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~CHEETAH~n~~h~~w~ID:~h~~r~415",2500,1);
	CreateVehicle(415,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:comet(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~COMET~n~~h~~w~ID:~h~~r~480",2500,1);
	CreateVehicle(480,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:hotknife(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~HOTKNIFE~n~~h~~w~ID:~h~~r~434",2500,1);
	CreateVehicle(434,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:hotring(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~HOTRING~n~~h~~w~ID:~h~~r~494",2500,1);
	CreateVehicle(494,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:hotringa(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~HOTRING A~n~~h~~w~ID:~h~~r~502",2500,1);
	CreateVehicle(502,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:hotringb(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~HOTRING B~n~~h~~w~ID:~h~~r~503",2500,1);
	CreateVehicle(503,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:infernus(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~INFERNUS~n~~h~~w~ID:~h~~r~411",2500,1);
	CreateVehicle(411,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:supergt(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~SUPER GT~n~~h~~w~ID:~h~~r~506",2500,1);
	CreateVehicle(506,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:turismo(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~TURISMO~n~~h~~w~ID:~h~~r~451",2500,1);
	CreateVehicle(451,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
  		CMD:windsor(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~WINDSOR~n~~h~~w~ID:~h~~r~555",2500,1);
	CreateVehicle(555,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:zr350(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~ZR-350~n~~h~~w~ID:~h~~r~477",2500,1);
	CreateVehicle(477,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:benson(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~BENSON~n~~h~~w~ID:~h~~r~499",2500,1);
	CreateVehicle(499,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
	  	CMD:boxville(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~BOXVILLE~n~~h~~w~ID:~h~~r~498",2500,1);
	CreateVehicle(498,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:boxville2(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~BOXVILLE ( black )~n~~h~~w~ID:~h~~r~609",2500,1);
	CreateVehicle(609,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:cementtruck(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~CEMENT TRUCK~n~~h~~w~ID:~h~~r~524",2500,1);
	CreateVehicle(524,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:combine(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~COMBINE HARVESTOR~n~~h~~w~ID:~h~~r~532",2500,1);
	CreateVehicle(532,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:dft30(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~DFT-30~n~~h~~w~ID:~h~~r~578",2500,1);
	CreateVehicle(578,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:dozer(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~DOZER~n~~h~~w~ID:~h~~r~486",2500,1);
	CreateVehicle(486,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:dumper(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~DUMPER~n~~h~~w~ID:~h~~r~406",2500,1);
	CreateVehicle(406,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:dune(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~DUNE~n~~h~~w~ID:~h~~r~573",2500,1);
	CreateVehicle(573,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:flatbed(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~FLATBED~n~~h~~w~ID:~h~~r~455",2500,1);
	CreateVehicle(455,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:hotdog(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~HOTDOG~n~~h~~w~ID:~h~~r~588",2500,1);
	CreateVehicle(588,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:linerunner(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~LINERUNNER~n~~h~~w~ID:~h~~r~403",2500,1);
	CreateVehicle(403,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:mrwoopee(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~MR WOOPEE~n~~h~~w~ID:~h~~r~423",2500,1);
	CreateVehicle(423,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
  		CMD:mule(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~MULE~n~~h~~w~ID:~h~~r~414",2500,1);
	CreateVehicle(414,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:packer(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~PACKER~n~~h~~w~ID:~h~~r~443",2500,1);
	CreateVehicle(443,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:roadtrain(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~ROADTRAIN~n~~h~~w~ID:~h~~r~515",2500,1);
	CreateVehicle(515,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:tanker(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~TANKER~n~~h~~w~ID:~h~~r~514",2500,1);
	CreateVehicle(514,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:tractor(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~TRACTOR~n~~h~~w~ID:~h~~r~531",2500,1);
	CreateVehicle(531,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:yankee(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~YANKEE~n~~h~~w~ID:~h~~r~456",2500,1);
	CreateVehicle(456,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:topfun(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~TOPFUN~n~~h~~w~ID:~h~~r~459",2500,1);
	CreateVehicle(459,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:bobcat(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~BOBCAT~n~~h~~w~ID:~h~~r~422",2500,1);
	CreateVehicle(422,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:burrito(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~BURRITO~n~~h~~w~ID:~h~~r~482",2500,1);
	CreateVehicle(482,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:forklift(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~FORKLIFT~n~~h~~w~ID:~h~~r~530",2500,1);
	CreateVehicle(530,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:moonbeam(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~MOONBEAM~n~~h~~w~ID:~h~~r~418",2500,1);
	CreateVehicle(418,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:mower(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~MOWER~n~~h~~w~ID:~h~~r~572",2500,1);
	CreateVehicle(572,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:newsvan(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~NEWSVAN~n~~h~~w~ID:~h~~r~582",2500,1);
	CreateVehicle(582,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
  		CMD:pony(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~PONY~n~~h~~w~ID:~h~~r~413",2500,1);
	CreateVehicle(413,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:rumpo(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~RUMPO~n~~h~~w~ID:~h~~r~440",2500,1);
	CreateVehicle(440,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:sadler(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~SADLER~n~~h~~w~ID:~h~~r~543",2500,1);
	CreateVehicle(543,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:tug(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~TUG~n~~h~~w~ID:~h~~r~583",2500,1);
	CreateVehicle(583,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:walton(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~WALTON~n~~h~~w~ID:~h~~r~478",2500,1);
	CreateVehicle(478,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:yosemite(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~YOSEMITE~n~~h~~w~ID:~h~~r~554",2500,1);
	CreateVehicle(554,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:blade(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~BLADE~n~~h~~w~ID:~h~~r~536",2500,1);
	CreateVehicle(536,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
  		CMD:broadway(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~BROADWAY~n~~h~~w~ID:~h~~r~575",2500,1);
	CreateVehicle(575,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:remington(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~REMINGTON~n~~h~~w~ID:~h~~r~534",2500,1);
	CreateVehicle(534,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:savanna(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~SAVANNA~n~~h~~w~ID:~h~~r~567",2500,1);
	CreateVehicle(567,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:slamvan(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~SLAMVAN~n~~h~~w~ID:~h~~r~535",2500,1);
	CreateVehicle(535,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:tornado(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~TORNADO~n~~h~~w~ID:~h~~r~576",2500,1);
	CreateVehicle(576,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:voodoo(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~VOODOO~n~~h~~w~ID:~h~~r~412",2500,1);
	CreateVehicle(412,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:bandito(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~BANDITO~n~~h~~w~ID:~h~~r~568",2500,1);
	CreateVehicle(568,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
  		CMD:bfinjection(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~BF INJECTION~n~~h~~w~ID:~h~~r~424",2500,1);
	CreateVehicle(424,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:bloodringbanger(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~BLOODRING BANGER~n~~h~~w~ID:~h~~r~504",2500,1);
	CreateVehicle(504,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:caddy(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~CADDY~n~~h~~w~ID:~h~~r~457",2500,1);
	CreateVehicle(457,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:camper(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~CAMPER~n~~h~~w~ID:~h~~r~483",2500,1);
	CreateVehicle(483,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:journey(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~JOURNEY~n~~h~~w~ID:~h~~r~508",2500,1);
	CreateVehicle(508,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:kart(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~KART~n~~h~~w~ID:~h~~r~571",2500,1);
	CreateVehicle(571,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:mesa(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~MESA~n~~h~~w~ID:~h~~r~500",2500,1);
	CreateVehicle(500,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
  		CMD:monster(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~MONSTER~n~~h~~w~ID:~h~~r~444",2500,1);
	CreateVehicle(444,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:monstera(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~MONSTER A~n~~h~~w~ID:~h~~r~556",2500,1);
	CreateVehicle(556,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:monsterb(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~MONSTER B~n~~h~~w~ID:~h~~r~557",2500,1);
	CreateVehicle(557,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:quad(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~QUAD~n~~h~~w~ID:~h~~r~471",2500,1);
	CreateVehicle(471,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:sandking(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~SANDKING~n~~h~~w~ID:~h~~r~495",2500,1);
	CreateVehicle(495,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:vortex(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~VORTEX~n~~h~~w~ID:~h~~r~539",2500,1);
	CreateVehicle(539,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:bmx(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~BMX~n~~h~~w~ID:~h~~r~481",2500,1);
	CreateVehicle(481,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:bike(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~BIKE~n~~h~~w~ID:~h~~r~509",2500,1);
	CreateVehicle(509,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:mountainbike(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~MOUNTAIN BIKE~n~~h~~w~ID:~h~~r~510",2500,1);
	CreateVehicle(510,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:bf400(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~BF-400~n~~h~~w~ID:~h~~r~581",2500,1);
	CreateVehicle(581,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:faggio(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~FAGGIO~n~~h~~w~ID:~h~~r~462",2500,1);
	CreateVehicle(462,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:fcr900(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~FCR-900~n~~h~~w~ID:~h~~r~521",2500,1);
	CreateVehicle(521,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
  		CMD:freeway(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~FREEWAY~n~~h~~w~ID:~h~~r~463",2500,1);
	CreateVehicle(463,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:nrg500(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~NRG-500~n~~h~~w~ID:~h~~r~522",2500,1);
	CreateVehicle(522,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:pcj600(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~PCJ-600~n~~h~~w~ID:~h~~r~461",2500,1);
	CreateVehicle(461,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:pizzaboy(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~PIZZABOY~n~~h~~w~ID:~h~~r~448",2500,1);
	CreateVehicle(448,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:sanchez(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~SANCHEZ~n~~h~~w~ID:~h~~r~468",2500,1);
	CreateVehicle(468,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:wayfarer(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~WAYFARER~n~~h~~w~ID:~h~~r~586",2500,1);
	CreateVehicle(586,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:baggage(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~BAGGAGE~n~~h~~w~ID:~h~~r~485",2500,1);
	CreateVehicle(485,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:bus(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~BUS~n~~h~~w~ID:~h~~r~431",2500,1);
	CreateVehicle(431,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:cabbie(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~CABBIE~n~~h~~w~ID:~h~~r~438",2500,1);
	CreateVehicle(438,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:coach(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~COACH~n~~h~~w~ID:~h~~r~437",2500,1);
	CreateVehicle(437,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:sweeper(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~SWEEPER~n~~h~~w~ID:~h~~r~574",2500,1);
	CreateVehicle(574,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
  		CMD:taxi(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~TAXI~n~~h~~w~ID:~h~~r~420",2500,1);
	CreateVehicle(420,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:towtruck(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~TOWTRUCK~n~~h~~w~ID:~h~~r~525",2500,1);
	CreateVehicle(525,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:trashmaster(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~TRASHMASTER~n~~h~~w~ID:~h~~r~408",2500,1);
	CreateVehicle(408,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:utilityvan(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~UTILITY VAN~n~~h~~w~ID:~h~~r~552",2500,1);
	CreateVehicle(552,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:ambulance(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~AMBULANCE~n~~h~~w~ID:~h~~r~416",2500,1);
	CreateVehicle(416,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
  		CMD:barracks(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~BARRACKS~n~~h~~w~ID:~h~~r~433",2500,1);
	CreateVehicle(433,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:enforcer(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~ENFORCER~n~~h~~w~ID:~h~~r~427",2500,1);
	CreateVehicle(427,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:fbirancher(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~FBI RANCHER~n~~h~~w~ID:~h~~r~490",2500,1);
	CreateVehicle(490,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:fbitruck(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~FBI TRUCK~n~~h~~w~ID:~h~~r~528",2500,1);
	CreateVehicle(528,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:firetruck(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~FIRETRUCK~n~~h~~w~ID:~h~~r~407",2500,1);
	CreateVehicle(407,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:firetrucka(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~FIRETRUCK A~n~~h~~w~ID:~h~~r~544",2500,1);
	CreateVehicle(544,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:hpv1000(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~HPV-1000~n~~h~~w~ID:~h~~r~523",2500,1);
	CreateVehicle(523,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:patriot(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~PATRIOT~n~~h~~w~ID:~h~~r~470",2500,1);
	CreateVehicle(470,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:policels(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~POLICE LOS SANTOS~n~~h~~w~ID:~h~~r~596",2500,1);
	CreateVehicle(596,X,Y+5,Z,1,1,0,90000);
	return 1;
	}
		CMD:policesf(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~POLICE SAN FIERRO~n~~h~~w~ID:~h~~r~597",2500,1);
	CreateVehicle(597,X,Y+5,Z,1,1,0,90000);
	return 1;
	}
		CMD:policelv(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~POLICE LAS VENTURAS~n~~h~~w~ID:~h~~r~598",2500,1);
	CreateVehicle(598,X,Y+5,Z,1,1,0,90000);
	return 1;
	}
  		CMD:policeranger(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~POLICE RANGER~n~~h~~w~ID:~h~~r~599",2500,1);
	CreateVehicle(599,X,Y+5,Z,1,1,0,90000);
	return 1;
	}
		CMD:rhino(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~RHINO~n~~h~~w~ID:~h~~r~432",2500,1);
	CreateVehicle(432,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:securicar(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~SECURICAR~n~~h~~w~ID:~h~~r~428",2500,1);
	CreateVehicle(428,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:swattank(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~SWAT TANK~n~~h~~w~ID:~h~~r~601",2500,1);
	CreateVehicle(601,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
	  	CMD:andromada(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~ANDROMADA~n~~h~~w~ID:~h~~r~592",2500,1);
	CreateVehicle(592,X,Y+20,Z,1,1,1,90000);
	return 1;
	}
		CMD:at400(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~AT-400~n~~h~~w~ID:~h~~r~577",2500,1);
	CreateVehicle(577,X,Y+20,Z,1,1,1,90000);
	return 1;
	}
		CMD:beagle(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~BEAGLE~n~~h~~w~ID:~h~~r~511",2500,1);
	CreateVehicle(511,X,Y+20,Z,1,1,1,90000);
	return 1;
	}
		CMD:cargobob(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~CARGOBOB~n~~h~~w~ID:~h~~r~548",2500,1);
	CreateVehicle(548,X,Y+10,Z,1,1,1,90000);
	return 1;
	}
		CMD:cropduster(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~CROPDUSTER~n~~h~~w~ID:~h~~r~512",2500,1);
	CreateVehicle(512,X,Y+10,Z,1,1,1,90000);
	return 1;
	}
  		CMD:dodo(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~DODO~n~~h~~w~ID:~h~~r~593",2500,1);
	CreateVehicle(593,X,Y+10,Z,1,1,1,90000);
	return 1;
	}
		CMD:hunter(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~HUNTER~n~~h~~w~ID:~h~~r~425",2500,1);
	CreateVehicle(425,X,Y+10,Z,1,1,1,90000);
	return 1;
	}
		CMD:leviathan(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~leviathan~n~~h~~w~ID:~h~~r~417",2500,1);
	CreateVehicle(417,X,Y+10,Z,1,1,1,90000);
	return 1;
	}
		CMD:maverick(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~MAVERICK~n~~h~~w~ID:~h~~r~487",2500,1);
	CreateVehicle(487,X,Y+10,Z,1,1,1,90000);
	return 1;
	}
		CMD:nevada(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~NEVADA~n~~h~~w~ID:~h~~r~553",2500,1);
	CreateVehicle(553,X,Y+10,Z,1,1,1,90000);
	return 1;
	}
		CMD:newsmaverick(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~NEWS MAVERICK~n~~h~~w~ID:~h~~r~488",2500,1);
	CreateVehicle(488,X,Y+10,Z,1,1,1,90000);
	return 1;
	}
		CMD:policemaverick(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~POLICE MAVERICK~n~~h~~w~ID:~h~~r~497",2500,1);
	CreateVehicle(497,X,Y+10,Z,1,1,0,90000);
	return 1;
	}
		CMD:raindance(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~RAINDANCE~n~~h~~w~ID:~h~~r~563",2500,1);
	CreateVehicle(563,X,Y+10,Z,1,1,1,90000);
	return 1;
	}
		CMD:rustler(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~RUSTLER~n~~h~~w~ID:~h~~r~476",2500,1);
	CreateVehicle(476,X,Y+10,Z,1,1,1,90000);
	return 1;
	}
		CMD:seasparrow(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~SEA SPARROW~n~~h~~w~ID:~h~~r~447",2500,1);
	CreateVehicle(447,X,Y+10,Z,1,1,1,90000);
	return 1;
	}
		CMD:shamal(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~SHAMAL~n~~h~~w~ID:~h~~r~519",2500,1);
	CreateVehicle(519,X,Y+10,Z,1,1,1,90000);
	return 1;
	}
  		CMD:skimmer(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~SKIMMER~n~~h~~w~ID:~h~~r~460",2500,1);
	CreateVehicle(460,X,Y+10,Z,1,1,1,90000);
	return 1;
	}
		CMD:sparrow(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~SPARROW~n~~h~~w~ID:~h~~r~469",2500,1);
	CreateVehicle(469,X,Y+10,Z,1,1,1,90000);
	return 1;
	}
		CMD:stuntplane(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~STUNT PLANE~n~~h~~w~ID:~h~~r~513",2500,1);
	CreateVehicle(513,X,Y+10,Z,1,1,1,90000);
	return 1;
	}
		CMD:hydra(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~HYDRA~n~~h~~w~ID:~h~~r~520",2500,1);
	CreateVehicle(520,X,Y+10,Z,1,1,1,90000);
	return 1;
	}
		CMD:coastguar(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~COASTGUARD~n~~h~~w~ID:~h~~r~472",2500,1);
	CreateVehicle(472,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:dingy(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~DINGY~n~~h~~w~ID:~h~~r~473",2500,1);
	CreateVehicle(473,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:jetmax(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~JETMAX~n~~h~~w~ID:~h~~r~493",2500,1);
	CreateVehicle(493,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
  		CMD:launch(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~LAUNCH~n~~h~~w~ID:~h~~r~595",2500,1);
	CreateVehicle(595,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:marquis(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~MARQUIS~n~~h~~w~ID:~h~~r~484",2500,1);
	CreateVehicle(484,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:predator(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~PREDATOR~n~~h~~w~ID:~h~~r~430",2500,1);
	CreateVehicle(430,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:reefer(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~REEFER~n~~h~~w~ID:~h~~r~453",2500,1);
	CreateVehicle(453,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:speeder(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~SPEEDER~n~~h~~w~ID:~h~~r~452",2500,1);
	CreateVehicle(452,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:squallo(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~SQUALLO~n~~h~~w~ID:~h~~r~446",2500,1);
	CreateVehicle(446,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:tropic(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~TROPIC~n~~h~~w~ID:~h~~r~454",2500,1);
	CreateVehicle(454,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:rcbandit(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~RC BANDIT~n~~h~~w~ID:~h~~r~441",2500,1);
	CreateVehicle(441,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
  		CMD:rcbaron(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~RC BARON~n~~h~~w~ID:~h~~r~464",2500,1);
	CreateVehicle(464,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:rccam(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~RC CAM~n~~h~~w~ID:~h~~r~594",2500,1);
	CreateVehicle(594,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:rcgoblin(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~RC GOBLIN~n~~h~~w~ID:~h~~r~465",2500,1);
	CreateVehicle(465,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:rcgoblin2(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~ANOTHER RC GOBLIN~n~~h~~w~ID:~h~~r~501",2500,1);
	CreateVehicle(501,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:rctiger(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~RC TIGER~n~~h~~w~ID:~h~~r~564",2500,1);
	CreateVehicle(564,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:glendale2(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~GET GLENDALE~n~~h~~w~ID:~h~~r~604",2500,1);
	CreateVehicle(604,X,Y+5,Z,1,1,1,90000);
	return 1;
	}
		CMD:sadler2(playerid,params[])
	{
if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_RED,"[SYSTEM][ERROR]: You not have Permission to use this Command !");/*	new Float:X;
	new Float:Y;
	new Float:Z;*/
 GetPlayerPos(playerid,X,Y,Z);
	GameTextForPlayer(playerid,"~h~~w~GET SADLER~n~~h~~w~ID:~h~~r~605",2500,1);
	CreateVehicle(605,X,Y+5,Z,1,1,1,90000);
	return 1;
	}

