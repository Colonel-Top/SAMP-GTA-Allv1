// This is a comment
// uncomment the line below if you want to write a filterscript
//#define FILTERSCRIPT

#include <a_samp>
#include <zcmd>
#include <dini>
#include <sscanf2>
#include <dudb>
#include <foreach>
#pragma tabsize 0
#include <mapandreas> //you have to set it up on your own (see http://forum.sa-mp.com/index.php?topic=145196.0 )
#define players 500 //maximum of players in your server
#define chopperid 497 //ID of the vehicle model ( http://wiki.sa-mp.com/wiki/Vehicles:Helicopters )
#define ropelength 100 //length of slideable rope (ingame meters)
#define skinid 280 || 281 || 282 || 266 || 267 || 283 || 285 || 285 || 165 || 164 || 163 || 166 //the skin, who may slide down the rope ( http://wiki.sa-mp.com/wiki/Skins:All )
new r0pes[players][ropelength],Float:pl_pos[players][128]; //cause pvar + array = sux
#define offsetz 90
#define dur 1800
#define DIALOGID 6969
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
/*
new Hour_ini[MAX_PLAYERS];
new Minute_ini[MAX_PLAYERS];
new Second_ini[MAX_PLAYERS];
new Minute[MAX_PLAYERS];*/
new FreezeTimes[MAX_PLAYERS];
new Moneyz[MAX_PLAYERS];
new wpid[MAX_PLAYERS];

new  Float:SpecX[MAX_PLAYERS], Float:SpecY[MAX_PLAYERS], Float:SpecZ[MAX_PLAYERS], vWorld[MAX_PLAYERS], Inter[MAX_PLAYERS];
new IsSpecing[MAX_PLAYERS], Name[MAX_PLAYER_NAME], IsBeingSpeced[MAX_PLAYERS],spectatorid[MAX_PLAYERS];
stock emsg(playerid, errorID)
{
if(errorID == 1)  return SendClientMessage(playerid,COLOR_RED1,"[SYSTEM][ERROR]:You not have Permission to use this Command");
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
};/*
new VehicleNames[212][] = {
{"Landstalker"},{"Bravura"},{"Buffalo"},{"Linerunner"},{"Perrenial"},{"Sentinel"},{"Dumper"},
{"Firetruck"},{"Trashmaster"},{"Stretch"},{"Manana"},{"Infernus"},{"Voodoo"},{"Pony"},{"Mule"},
{"Cheetah"},{"Ambulance"},{"Leviathan"},{"Moonbeam"},{"Esperanto"},{"Taxi"},{"Washington"},
{"Bobcat"},{"Mr Whoopee"},{"BF Injection"},{"Hunter"},{"Premier"},{"Enforcer"},{"Securicar"},
{"Banshee"},{"Predator"},{"Bus"},{"Rhino"},{"Barracks"},{"Hotknife"},{"Trailer 1"},{"Previon"},
{"Coach"},{"Cabbie"},{"Stallion"},{"Rumpo"},{"RC Bandit"},{"Romero"},{"Packer"},{"Monster"},
{"Admiral"},{"Squalo"},{"Seasparrow"},{"Pizzaboy"},{"Tram"},{"Trailer 2"},{"Turismo"},
{"Speeder"},{"Reefer"},{"Tropic"},{"Flatbed"},{"Yankee"},{"Caddy"},{"Solair"},{"Berkley's RC Van"},
{"Skimmer"},{"PCJ-600"},{"Faggio"},{"Freeway"},{"RC Baron"},{"RC Raider"},{"Glendale"},{"Oceanic"},
{"Sanchez"},{"Sparrow"},{"Patriot"},{"Quad"},{"Coastguard"},{"Dinghy"},{"Hermes"},{"Sabre"},
{"Rustler"},{"ZR-350"},{"Walton"},{"Regina"},{"Comet"},{"BMX"},{"Burrito"},{"Camper"},{"Marquis"},
{"Baggage"},{"Dozer"},{"Maverick"},{"News Chopper"},{"Rancher"},{"FBI Rancher"},{"Virgo"},{"Greenwood"},
{"Jetmax"},{"Hotring"},{"Sandking"},{"Blista Compact"},{"Police Maverick"},{"Boxville"},{"Benson"},
{"Mesa"},{"RC Goblin"},{"Hotring Racer A"},{"Hotring Racer B"},{"Bloodring Banger"},{"Rancher"},
{"Super GT"},{"Elegant"},{"Journey"},{"Bike"},{"Mountain Bike"},{"Beagle"},{"Cropdust"},{"Stunt"},
{"Tanker"}, {"Roadtrain"},{"Nebula"},{"Majestic"},{"Buccaneer"},{"Shamal"},{"Hydra"},{"FCR-900"},
{"NRG-500"},{"HPV1000"},{"Cement Truck"},{"Tow Truck"},{"Fortune"},{"Cadrona"},{"FBI Truck"},
{"Willard"},{"Forklift"},{"Tractor"},{"Combine"},{"Feltzer"},{"Remington"},{"Slamvan"},
{"Blade"},{"Freight"},{"Streak"},{"Vortex"},{"Vincent"},{"Bullet"},{"Clover"},{"Sadler"},
{"Firetruck LA"},{"Hustler"},{"Intruder"},{"Primo"},{"Cargobob"},{"Tampa"},{"Sunrise"},{"Merit"},
{"Utility"},{"Nevada"},{"Yosemite"},{"Windsor"},{"Monster A"},{"Monster B"},{"Uranus"},{"Jester"},
{"Sultan"},{"Stratum"},{"Elegy"},{"Raindance"},{"RC Tiger"},{"Flash"},{"Tahoma"},{"Savanna"},
{"Bandito"},{"Freight Flat"},{"Streak Carriage"},{"Kart"},{"Mower"},{"Duneride"},{"Sweeper"},
{"Broadway"},{"Tornado"},{"AT-400"},{"DFT-30"},{"Huntley"},{"Stafford"},{"BF-400"},{"Newsvan"},
{"Tug"},{"Trailer 3"},{"Emperor"},{"Wayfarer"},{"Euros"},{"Hotdog"},{"Club"},{"Freight Carriage"},
{"Trailer 3"},{"Andromada"},{"Dodo"},{"RC Cam"},{"Launch"},{"Police Car (LSPD)"},{"Police Car (SFPD)"},
{"Police Car (LVPD)"},{"Police Ranger"},{"Picador"},{"S.W.A.T. Van"},{"Alpha"},{"Phoenix"},{"Glendale"},
{"Sadler"},{"Luggage Trailer A"},{"Luggage Trailer B"},{"Stair Trailer"},{"Boxville"},{"Farm Plow"},
{"Utility Trailer"}
};*/
//new Pstatus[MAX_PLAYERS][playerstatus];
new bool:deathz[MAX_PLAYERS];
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
	printf("\n--------------------------------------");
	printf(" System Organization Administrator");
	printf("--------------------------------------\n");
	DisableInteriorEnterExits();
	MapAndreas_Init(MAP_ANDREAS_MODE_FULL);
	//
		Textdraw0 = TextDrawCreate(340.000000, 10.000000, "2020's Battlefield");
TextDrawAlignment(Textdraw0, 2);
TextDrawBackgroundColor(Textdraw0, 16777215);
TextDrawFont(Textdraw0, 1);
TextDrawLetterSize(Textdraw0, 0.490000, 1.300000);
TextDrawColor(Textdraw0, -16776961);
TextDrawSetOutline(Textdraw0, 1);
TextDrawSetProportional(Textdraw0, 1);
TextDrawSetSelectable(Textdraw0, 0);
	//
	TextDrawKD = TextDrawCreate(10.000000, 426.000000, "Kill :      Death :       Wanted Level :    Name :");
TextDrawBackgroundColor(TextDrawKD, 255);
TextDrawFont(TextDrawKD, 1);
TextDrawLetterSize(TextDrawKD, 0.460000, 1.600000);
TextDrawColor(TextDrawKD, 65535);
TextDrawSetOutline(TextDrawKD, 0);
TextDrawSetProportional(TextDrawKD, 1);
TextDrawSetShadow(TextDrawKD, 1);
TextDrawUseBox(TextDrawKD, 1);
TextDrawBoxColor(TextDrawKD, 1970632191);
TextDrawTextSize(TextDrawKD, 632.000000, 0.000000);
TextDrawSetSelectable(TextDrawKD, 0);
	//
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
new newtext[512], plname[MAX_PLAYER_NAME];


public OnPlayerConnect(playerid)
{
//
    

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
	if(PlayerInfo[playerid][RPK]== 1)
	{
	 new name[MAX_PLAYER_NAME], file[128];
	 GetPlayerName(playerid, name, sizeof(name));
	 format(file, sizeof(file), SERVER_USER_FILE, name);
	 if(dini_Exists(file))
	 {
	 	dini_Remove(file);
	 }
	 new welcometext[128], playerswelcome[MAX_PLAYER_NAME];
	GetPlayerName(playerid, playerswelcome, sizeof(playerswelcome));
	format(welcometext, sizeof(welcometext), "Welcome To Our Server %s ", playerswelcome);
	 SendClientMessage(playerid,COLOR_CYAN,"Your Account has been Roleplay Killed Sorry Please Register with new one ...");
	 ShowPlayerDialog(playerid, 2323, DIALOG_STYLE_PASSWORD, welcometext, "Welcome, your name didn't registered now, Please input your registration password below", "Register", "Quit");
	 return 1;
 	}
	new name[MAX_PLAYER_NAME], file[128];
	GetPlayerName(playerid, name, sizeof(name));
	format(file, sizeof(file), SERVER_USER_FILE, name);
	if (!dini_Exists(file))
	{
	    if(PlayerInfo[playerid][Register] == 0)
	    {
	    new welcometext[128], playerswelcome[MAX_PLAYER_NAME];
		GetPlayerName(playerid, playerswelcome, sizeof(playerswelcome));
		format(welcometext, sizeof(welcometext), "Welcome To Our Server %s ", playerswelcome);
	    SendClientMessage(playerid,COLOR_CYAN,"Your Name is not registered Please Register !");
		ShowPlayerDialog(playerid, 2323, DIALOG_STYLE_PASSWORD, welcometext , "Welcome, your name didn't registered now, Please input your registration password below", "Register", "Quit");
		}
		
	}
	if(fexist(file))
	{
	    new welcomeback[128], playerswelcome[MAX_PLAYER_NAME];
		GetPlayerName(playerid, playerswelcome, sizeof(playerswelcome));
		format(welcomeback, sizeof(welcomeback), "Welcome To Back Our Server %s ", playerswelcome);
		ShowPlayerDialog(playerid, 2424, DIALOG_STYLE_PASSWORD, welcomeback, "Let's Login to your account Please input your password to login", "Login", "Quit");

	}
	//
	new pname[MAX_PLAYER_NAME], string[256 + MAX_PLAYER_NAME];
    GetPlayerName(playerid, pname, sizeof(pname));
    format(string, sizeof(string), "Player %s (Id:%d) has Connected To the server", pname,playerid);
    SendClientMessageToAll(COLOR_LEMON, string);
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
public OnPlayerDisconnect(playerid, reason)
{
	if(PlayerInfo[playerid][RPK] == 1)
	{
	    new stext[128];
        new name[MAX_PLAYER_NAME];
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
    PlayerInfo[playerid][Money] = GetPlayerMoney(playerid);
	PlayerInfo[playerid][Score] = GetPlayerScore(playerid);
    TextDrawHideForPlayer(playerid,Textdraw0);
    new name[MAX_PLAYER_NAME], file[128];
	GetPlayerName(playerid, name, sizeof(name));
	format(file, sizeof(file), SERVER_USER_FILE, name);
	
	if(PlayerInfo[playerid][LoggedIn] == 1)
	{
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
	}
	PlayerInfo[playerid][LoggedIn] = 0;
	PlayerInfo[playerid][FailLogin]=0;
	PlayerInfo[playerid][pmstatus]=0;
	//
	new pname[MAX_PLAYER_NAME], string[128 + MAX_PLAYER_NAME];
    GetPlayerName(playerid, pname, sizeof(pname));
    switch(reason)
    {
        case 0: format(string, sizeof(string), "Player : %s has Disconnected from the server. (Lost Connection)", pname);
        case 1: format(string, sizeof(string), "Player : %s has Disconnected from the server. (Leaving)", pname);
        case 2: format(string, sizeof(string), "Player : %s has Disconnected from the server. (Kicked/Banned)", pname);
    }
    SendClientMessageToAll(COLOR_LEMON, string);
	printf(string);
	if(GetPVarInt(playerid,"roped") == 1)
	{
	    for(new destr=0;destr<=ropelength;destr++)
		{
		    DestroyObject(r0pes[playerid][destr]);
		}
		SetPVarInt(playerid,"roped",0);
	}
	return 1;
}

public OnPlayerSpawn(playerid)
{
    if(IsSpecing[playerid] == 1)
    {
        SetPlayerPos(playerid,SpecX[playerid],SpecY[playerid],SpecZ[playerid]);// Remember earlier we stored the positions in these variables, now we're gonna get them from the variables.
		SetPlayerInterior(playerid,Inter[playerid]);//Setting the player's interior to when they typed '/spec'
		SetPlayerVirtualWorld(playerid,vWorld[playerid]);//Setting the player's virtual world to when they typed '/spec'
		IsSpecing[playerid] = 0;//Just saying you're free to use '/spec' again YAY :D
		IsBeingSpeced[spectatorid[playerid]] = 0;//Just saying that the player who was being spectated
    }
	if(deathz[playerid]==true)
 	{
		SetTimerEx("GiveMoney", 2800, false, "i", playerid);
		deathz[playerid]=false;
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
	return 1;
}
forward GiveMoney(playerid);
public GiveMoney(playerid)
{
	if(deathz[playerid] == true)
	{
	    GivePlayerMoney(playerid,Moneyz[playerid]);
	}
	return 1;
}
public OnPlayerDeath(playerid, killerid, reason)
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
	}
	
    if(PlayerInfo[playerid][RPK] == 1)
    {
        new stext[512];
        new name[MAX_PLAYER_NAME];
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
	//
	if(GetPVarInt(playerid,"roped") == 1)
	{
	    for(new destr2=0;destr2<=ropelength;destr2++)
		{
		    DestroyObject(r0pes[playerid][destr2]);
		}
		SetPVarInt(playerid,"roped",0);
		DisablePlayerCheckpoint(playerid);
	}
	//
    SendDeathMessage(killerid, playerid, reason);
    PlayerInfo[killerid][Kills]++;
    
	PlayerInfo[playerid][Death]++;
	deathz[playerid] = true;
	Moneyz[playerid] = GetPlayerMoney(playerid);
	ResetPlayerMoney(playerid);
	if(killerid != INVALID_PLAYER_ID)
	{
	new gunname[512], string[512], fName[MAX_PLAYER_NAME], sName[MAX_PLAYER_NAME];
    GetWeaponName(reason,gunname,sizeof(gunname));
    GetPlayerName(playerid,fName,MAX_PLAYER_NAME);
    GetPlayerName(killerid,sName,MAX_PLAYER_NAME);
    format(string, sizeof(string), "Player : %s has Killed %s by using Weapons : %s.", sName, fName, gunname);
    SendClientMessageToAll(COLOR_PINK,string);

	}
	 format(newtext, sizeof(newtext), "Name : %s     Kill : %d     Death : %d     Wanted Level : %d   Warning : %d",plname, PlayerInfo[playerid][Kills],PlayerInfo[playerid][Death],GetPlayerWantedLevel(playerid),PlayerInfo[playerid][Warnings]);
    TextDrawSetString(TextDrawKD, newtext);
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
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
	}
	return 1;
}


public OnPlayerText( playerid, text[ ] )
{    // code..
	if(PlayerInfo[playerid][Muted]==0)
	{
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
CMD:car(playerid, params[])
{
	if(PlayerInfo[playerid][Level] < 3) return emsg(playerid,1);
	if(PlayerInfo[playerid][Level] >= 3 && PlayerInfo[playerid][LoggedIn] == 1)
	{
		new allvehicles[] = "1\tAirplanes\n2\tHelicopters\n3\tBikes\n4\tConvertibles\n5\tIndustrial\n6\tLowriders\n7\tOffRoad\n8\tPublic Service Vehicles\n9\tSaloons\n10\tSport Vehicles\n11\tStation Wagons\n12\tBoats\n13\tUnique Vehicles\n14\tRC Vehicles\n15\tTrailers";
	   	ShowPlayerDialog(playerid,555,DIALOG_STYLE_LIST," Vehicles: || Scroll Down for more",allvehicles,"Select","Cancel");
	}
	else return emsg(playerid,1);
		return 1;
}

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
	return 1;
}
forward end(playerid);
public end(playerid)
{
    SetPVarInt(playerid,"roped",0);
    SetPVarInt(playerid,"chop_id",0);
	return 1;
}
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
	        	new name[24];
	        	new string128[128];
				GetPlayerName(playerid,name,24);
	            format(string128,sizeof(string128),"[SYSTEM][WARNING] Kicked ID:[%i] Player %s for CAR SPAM hacks",playerid,name);
	            SendClientMessageToAll(COLOR_RED,string128);
	            printf(string128);
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
    	if(/*GetPlayerSkin(playerid) == skinid && */GetPVarInt(playerid,"roped") == 0 && GetPlayerVehicleSeat(playerid) != 0 && IsPlayerInAnyVehicle(playerid) && (newkeys & KEY_SUBMISSION || newkeys == KEY_SUBMISSION))
	{
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
		new string[128];
		new playername[60];
		GetPlayerName(playerid,playername,sizeof(playername));
		format(string,sizeof(string),"[SYSTEM]: Player %s has catch a rope and start Roping Down From Helicopter",playername);
		SendClientMessageToAll(COLOR_GREEN,string);
	}
	//

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
new Float: X, Float: Y, Float: Z;
    GetPlayerPos(playerid,X,Y,Z);
   
	if(dialogid == 555)
	{
		if(response)
		{
			if(listitem == 0)
			{
			    new allvehicles[] = "1\tAndromada\n2\tAT-400\n3\tBeagle\n4\tCropduster\n5\tDodo\n6\tHydra\n7\tNevada\n8\tRustler\n9\tShamal\n10\tSkimmer\n11\tStunt Plane";
	    		ShowPlayerDialog(playerid,3,DIALOG_STYLE_LIST,"Airplanes: || Scroll Down for more",allvehicles,"Select","Cancel");
	    	}
	    	else if(listitem == 1)
			{
			    new allvehicles[] = "1\tCargobob\n2\tHunter\n3\tLeviathan\n4\tMaverick\n5\tNews Maverick\n6\tPolice Maverick\n7\tRaindance\n8\tSeasparrow\n9\tSparrow";
	    		ShowPlayerDialog(playerid,4,DIALOG_STYLE_LIST,"Helicopters: || Scroll Down for more",allvehicles,"Select","Cancel");
			}
			else if(listitem == 2)
			{
			    new allvehicles[] = "1\tBF-400\n2\tBike\n3\tBMX\n4\tFaggio\n5\tFCR-900\n6\tFreeway\n7\tMountain Bike\n8\tNRG-500\n9\tPCJ-600\n10\tPizzaBoy\n11\tQuad\n12\tSanchez\n13\tWayfarer";
	    		ShowPlayerDialog(playerid,5,DIALOG_STYLE_LIST,"Bikes: || Scroll Down for more",allvehicles,"Select","Cancel");
			}
			else if(listitem == 3)
			{
			    new allvehicles[] = "1\tComet\n2\tFeltzer\n3\tStallion\n4\tWindsor";
	    		ShowPlayerDialog(playerid,6,DIALOG_STYLE_LIST,"Convertibles:",allvehicles,"Select","Cancel");
			}
			else if(listitem == 4)
			{
			    new allvehicles[] = "1\tBenson\n2\tBobcat\n3\tBurrito\n4\tBoxville\n5\tBoxburg\n6\tCement Truck\n7\tDFT-300\n8\tFlatbed\n9\tLinerunner\n10\tMule\n11\tNews Van\n12\tPacker\n13\tPetrol Tanker\n14\tPicador\n15\tPony\n16\tRoad Train\n17\tRumpo\n18\tSadler\n19\tSadler Shit( Ghost Car )\n20\tTopfun\n21\tTractor\n22\tTrashmaster\n23\tUitlity Van\n24\tWalton\n25\tYankee\n26\tYosemite";
	    		ShowPlayerDialog(playerid,7,DIALOG_STYLE_LIST,"Industrial Vehicles:",allvehicles,"Select","Cancel");
			}
			else if(listitem == 5)
			{
			    new allvehicles[] = "1\tBlade\n2\tBroadway\n3\tRemington\n4\tSavanna\n5\tSlamvan\n6\tTahoma\n7\tTornado\n8\tVoodoo";
	    		ShowPlayerDialog(playerid,8,DIALOG_STYLE_LIST,"Lowriders:",allvehicles,"Select","Cancel");
			}
			else if(listitem == 6)
			{
			    new allvehicles[] = "1\tBandito\n2\tBF Injection\n3\tDune\n4\tHuntley\n5\tLandstalker\n6\tMesa\n7\tMonster Truck\n8\tMonster Truck 'A'\n9\tMonster Truck 'B'\n10\tPatriot\n11\tRancher 'A'\n12\tRancher 'B'\n13\tSandking";
	    		ShowPlayerDialog(playerid,9,DIALOG_STYLE_LIST,"Off Road Vehicles:",allvehicles,"Select","Cancel");
			}
			else if(listitem == 7)
			{
			    new allvehicles[] = "1\tAmbulance\n2\tBarracks\n3\tBus\n4\tCabbie\n5\tCoach\n6\tHPV-1000 ( Cop Bike )\n7\tEnforcer\n8\tF.B.I Rancher\n9\tF.B.I Truck\n10\tFiretruck\n11\tFireTruck LA\n12\tPolice Car ( LSPD )\n13\tPolice Car ( LVPD )\n14\tPolice Car ( SFPD )\n15\tRanger\n16\tS.W.A.T\n17\tTaxi\n18\nRhino";
	    		ShowPlayerDialog(playerid,10,DIALOG_STYLE_LIST,"Public Service Vehicles:",allvehicles,"Select","Cancel");
			}
			else if(listitem == 8)
			{
			    new allvehicles[] = "1\tAdmiral\n2\tBloodring Banger\n3\tBravura\n4\tBuccaneer\n5\tCadrona\n6\tClover\n7\tElegant\n8\tElegy\n9\tEmperor\n10\tEsperanto\n11\tFortune\n12\tGlendale Shit ( Ghost Car )\n13\tGlendale\n14\tGreenwood\n15\tHermes\n16\tIntruder\n17\tMajestic\n18\tMananal\n19\tMerit\n20\tNebula\n21\tOceanic\n22\tPremier\n23\tPrevion\n24\tPrimo\n25\tSentinel\n26\tStafford\n27\tSultan \n28\tSunrise\n29\tTampa\n30\tVicent\n31\tVirgo\n32\tWillard\n33\tWashington";
	    		ShowPlayerDialog(playerid,11,DIALOG_STYLE_LIST,"Saloons Vehicles:",allvehicles,"Select","Cancel");
			}
			else if(listitem == 9)
			{
			    new allvehicles[] = "1\tAlpha\n2\tBanshee\n3\tBlista Compact\n4\tBuffalo\n5\tBullet\n6\tCheetah\n7\tClub\n8\tEuros\n9\tFlash\n10\tHotring Racer 'A'\n11\tHotring Racer 'B'\n12\tHotring Racer 'C'\n13\tInfernus\n14\tJester\n15\tPhoenix\n16\tSabre\n17\tSuper GT\n18\tTurismo\n19\tUranus\n20\tZR-350";
	    		ShowPlayerDialog(playerid,12,DIALOG_STYLE_LIST,"Sport Vehicles:",allvehicles,"Select","Cancel");
			}
			else if(listitem == 10)
			{
			    new allvehicles[] = "1\tMoonbeam\n2\tPerenniel\n3\tRegina\n4\tSolair\n5\tStratum";
	    		ShowPlayerDialog(playerid,13,DIALOG_STYLE_LIST,"Station Wagons Vehicles:",allvehicles,"Select","Cancel");
			}
			else if(listitem == 11)
			{
			    new allvehicles[] = "1\tCoastguard\n2\tDinghy\n3\tJetmax\n4\tLaunch\n5\tMarquis\n6\tPredator\n7\tReefer\n8\tSpeeder\n9\tSquallo\n10\tTropic";
	    		ShowPlayerDialog(playerid,14,DIALOG_STYLE_LIST,"Boats:",allvehicles,"Select","Cancel");
			}
			else if(listitem == 12)
			{
			    new allvehicles[] = "1\tBaggage\n2\tCaddy\n3\tCamper 'A'\n4\tCamper 'B'\n5\tCobine Harvester\n6\tDozer\n7\tDumper\n8\tForklift\n9\tHotknife\n10\tHustler\n11\tHotdog\n12\tKart\n13\tMower\n14\tMr. Whoopee\n15\tRomero\n16\tSecuricar\n17\tStretch\n18\tSweeper\n19\tTowtruck\n20\tTug\n21\tVortex";
	    		ShowPlayerDialog(playerid,15,DIALOG_STYLE_LIST,"Unique Vehicles:",allvehicles,"Select","Cancel");
			}
			else if(listitem == 13)
			{
			    new allvehicles[] = "1\tRC Bandit\n2\tRC Baron\n3\tRC Raider'\n4\tRC Goblin'\n5\tRC Tiger\n6\tRC Cam";
	    		ShowPlayerDialog(playerid,16,DIALOG_STYLE_LIST,"RC Vehicles:",allvehicles,"Select","Cancel");
			}
			else if(listitem == 14)
			{
			    new allvehicles[] = "1\tArticle Trailer\n2\tArticle Trailer 2\n3\tArticle Trailer 3'\n4\tBaggage Trailer 'A''\n5\tBaggage Trailer 'B'\n6\tFarm Trailer\n7\tFreight Frat Trailer(Train)\n8\tFreight Box Trailer(Train)\n9\tPetrol Trailer\n10\tStreak Trailer(Train)\n11\tStairs Trailer\n12\tUitlity Trailer";
	    		ShowPlayerDialog(playerid,17,DIALOG_STYLE_LIST,"Trailers Vehicles:",allvehicles,"Select","Cancel");
			}
		}
	}
	else if(dialogid == 3)
	{
	    if(response)
		{
			if(listitem == 0)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(592,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 1)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(577,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 2)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(511,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 3)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(512,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 4)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(593,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 5)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(520,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 6)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(553,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 7)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(476,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 8)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(510,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 9)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(460,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 10)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(513,X,Y,Z,0,-1,-1,-1),0);
			}
		}
		else
		{
		    new allvehicles[] = "1\tAirplanes\n2\tHelicopters\n3\tBikes\n4\tConvertibles\n5\tIndustrial\n6\tLowriders\n7\tOffRoad\n8\tPublic Service Vehicles\n9\tSaloons\n10\tSport Vehicles\n11\tStation Wagons\n12\tBoats\n13\tUnique Vehicles\n14\tRC Vehicles\n15\tTrailers";
	   		ShowPlayerDialog(playerid,2,DIALOG_STYLE_LIST," Vehicles: || Scroll Down for more",allvehicles,"Select","Cancel");
		}
	}
	else if(dialogid == 4)
	{
	    if(response)
		{
			if(listitem == 0)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(548,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 1)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(425,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 2)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(417,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 3)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(487,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 4)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(488,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 5)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(497,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 6)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(563,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 7)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(447,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 8)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(469,X,Y,Z,0,-1,-1,-1),0);
			}
		}
		else
		{
		    new allvehicles[] = "1\tAirplanes\n2\tHelicopters\n3\tBikes\n4\tConvertibles\n5\tIndustrial\n6\tLowriders\n7\tOffRoad\n8\tPublic Service Vehicles\n9\tSaloons\n10\tSport Vehicles\n11\tStation Wagons\n12\tBoats\n13\tUnique Vehicles\n14\tRC Vehicles\n15\tTrailers";
	   		ShowPlayerDialog(playerid,2,DIALOG_STYLE_LIST," Vehicles: || Scroll Down for more",allvehicles,"Select","Cancel");
		}
	}
	else if(dialogid == 5)
	{
	    if(response)
		{
			if(listitem == 0)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(581,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 1)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(509,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 2)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(481,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 3)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(462,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 4)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(521,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 5)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(463,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 6)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(510,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 7)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(522,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 8)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(461,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 9)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(448,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 10)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(471,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 11)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(468,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 12)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(586,X,Y,Z,0,-1,-1,-1),0);
			}
		}
		else
		{
		    new allvehicles[] = "1\tAirplanes\n2\tHelicopters\n3\tBikes\n4\tConvertibles\n5\tIndustrial\n6\tLowriders\n7\tOffRoad\n8\tPublic Service Vehicles\n9\tSaloons\n10\tSport Vehicles\n11\tStation Wagons\n12\tBoats\n13\tUnique Vehicles\n14\tRC Vehicles\n15\tTrailers";
	   		ShowPlayerDialog(playerid,2,DIALOG_STYLE_LIST," Vehicles: || Scroll Down for more",allvehicles,"Select","Cancel");
		}
	}
	else if(dialogid == 6)
	{
	    if(response)
		{
			if(listitem == 0)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(480,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 1)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(533,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 2)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(439,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 3)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(555,X,Y,Z,0,-1,-1,-1),0);
			}
		}
		else
		{
		    new allvehicles[] = "1\tAirplanes\n2\tHelicopters\n3\tBikes\n4\tConvertibles\n5\tIndustrial\n6\tLowriders\n7\tOffRoad\n8\tPublic Service Vehicles\n9\tSaloons\n10\tSport Vehicles\n11\tStation Wagons\n12\tBoats\n13\tUnique Vehicles\n14\tRC Vehicles\n15\tTrailers";
	   		ShowPlayerDialog(playerid,2,DIALOG_STYLE_LIST," Vehicles: || Scroll Down for more",allvehicles,"Select","Cancel");
		}
	}
	else if(dialogid == 7)
	{
	    if(response)
		{
			if(listitem == 0)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(499,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 1)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(422,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 2)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(482,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 3)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(498,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 4)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(609,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 5)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(524,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 6)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(578,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 7)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(455,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 8)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(403,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 9)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(414,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 10)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(582,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 11)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(443,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 12)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(514,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 13)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(600,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 14)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(413,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 15)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(515,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 16)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(440,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 17)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(543,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 18)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(605,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 19)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(459,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 20)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(531,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 21)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(408,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 22)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(552,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 23)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(478,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 24)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(556,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 25)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(554,X,Y,Z,0,-1,-1,-1),0);
			}
		}
		else
		{
		    new allvehicles[] = "1\tAirplanes\n2\tHelicopters\n3\tBikes\n4\tConvertibles\n5\tIndustrial\n6\tLowriders\n7\tOffRoad\n8\tPublic Service Vehicles\n9\tSaloons\n10\tSport Vehicles\n11\tStation Wagons\n12\tBoats\n13\tUnique Vehicles\n14\tRC Vehicles\n15\tTrailers";
	   		ShowPlayerDialog(playerid,2,DIALOG_STYLE_LIST," Vehicles: || Scroll Down for more",allvehicles,"Select","Cancel");
		}
	}
	else if(dialogid == 8)
	{
	    if(response)
		{
			if(listitem == 0)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(536,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 1)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(575,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 2)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(534,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 3)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(567,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 4)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(535,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 5)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(566,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 6)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(576,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 7)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(412,X,Y,Z,0,-1,-1,-1),0);
			}
		}
		else
		{
		     new allvehicles[] = "1\tAirplanes\n2\tHelicopters\n3\tBikes\n4\tConvertibles\n5\tIndustrial\n6\tLowriders\n7\tOffRoad\n8\tPublic Service Vehicles\n9\tSaloons\n10\tSport Vehicles\n11\tStation Wagons\n12\tBoats\n13\tUnique Vehicles\n14\tRC Vehicles\n15\tTrailers";
	   		 ShowPlayerDialog(playerid,2,DIALOG_STYLE_LIST," Vehicles: || Scroll Down for more",allvehicles,"Select","Cancel");
		}
	}
	else if(dialogid == 9)
	{
	    if(response)
		{
			if(listitem == 0)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(568,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 1)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(424,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 2)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(573,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 3)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(579,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 4)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(400,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 5)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(500,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 6)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(444,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 7)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(556,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 8)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(557,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 9)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(470,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 10)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(489,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 11)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(505,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 12)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(495,X,Y,Z,0,-1,-1,-1),0);
			}
		}
		else
		{
		    new allvehicles[] = "1\tAirplanes\n2\tHelicopters\n3\tBikes\n4\tConvertibles\n5\tIndustrial\n6\tLowriders\n7\tOffRoad\n8\tPublic Service Vehicles\n9\tSaloons\n10\tSport Vehicles\n11\tStation Wagons\n12\tBoats\n13\tUnique Vehicles\n14\tRC Vehicles\n15\tTrailers";
	   		ShowPlayerDialog(playerid,2,DIALOG_STYLE_LIST," Vehicles: || Scroll Down for more",allvehicles,"Select","Cancel");
		}
	}
	else if(dialogid == 10)
	{
	    if(response)
		{
			if(listitem == 0)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(416,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 1)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(433,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 2)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(431,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 3)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(438,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 4)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(437,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 5)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(523,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 6)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(427,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 7)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(490,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 8)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(528,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 9)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(407,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 10)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(544,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 11)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(596,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 12)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(598,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 13)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(597,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 14)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(599,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 15)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(601,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 16)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(420,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 17)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(432,X,Y,Z,0,-1,-1,-1),0);
			}
		}
		else
		{
		    new allvehicles[] = "1\tAirplanes\n2\tHelicopters\n3\tBikes\n4\tConvertibles\n5\tIndustrial\n6\tLowriders\n7\tOffRoad\n8\tPublic Service Vehicles\n9\tSaloons\n10\tSport Vehicles\n11\tStation Wagons\n12\tBoats\n13\tUnique Vehicles\n14\tRC Vehicles\n15\tTrailers";
	   		ShowPlayerDialog(playerid,2,DIALOG_STYLE_LIST," Vehicles: || Scroll Down for more",allvehicles,"Select","Cancel");
		}
	}
	else if(dialogid == 11)
	{
	    if(response)
		{
			if(listitem == 0)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(445,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 1)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(504,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 2)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(401,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 3)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(518,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 4)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(527,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 5)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(542,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 6)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(507,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 7)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(562,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 8)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(585,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 9)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(419,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 10)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(526,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 11)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(604,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 12)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(466,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 13)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(492,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 14)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(474,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 15)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(546,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 16)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(517,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 17)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(310,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 18)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(551,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 19)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(516,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 20)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(467,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 21)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(426,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 22)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(436,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 23)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(547,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 24)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(405,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 25)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(580,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 26)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(560,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 27)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(550,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 28)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(549,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 29)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(540,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 30)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(491,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 31)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(529,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 32)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(421,X,Y,Z,0,-1,-1,-1),0);
			}
		}
		else
		{
		    new allvehicles[] = "1\tAirplanes\n2\tHelicopters\n3\tBikes\n4\tConvertibles\n5\tIndustrial\n6\tLowriders\n7\tOffRoad\n8\tPublic Service Vehicles\n9\tSaloons\n10\tSport Vehicles\n11\tStation Wagons\n12\tBoats\n13\tUnique Vehicles\n14\tRC Vehicles\n15\tTrailers";
	   		ShowPlayerDialog(playerid,2,DIALOG_STYLE_LIST," Vehicles: || Scroll Down for more",allvehicles,"Select","Cancel");
		}
	}
	else if(dialogid == 12)
	{
	    if(response)
		{
			if(listitem == 0)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(602,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 1)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(429,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 2)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(496,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 3)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(402,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 4)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(541,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 5)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(415,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 6)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(589,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 7)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(587,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 8)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(565,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 9)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(494,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 10)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(502,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 11)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(503,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 12)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(411,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 13)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(559,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 14)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(603,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 15)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(475,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 16)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(506,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 17)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(451,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 18)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(558,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 19)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(477,X,Y,Z,0,-1,-1,-1),0);
			}
		}
		else
		{
		    new allvehicles[] = "1\tAirplanes\n2\tHelicopters\n3\tBikes\n4\tConvertibles\n5\tIndustrial\n6\tLowriders\n7\tOffRoad\n8\tPublic Service Vehicles\n9\tSaloons\n10\tSport Vehicles\n11\tStation Wagons\n12\tBoats\n13\tUnique Vehicles\n14\tRC Vehicles\n15\tTrailers";
	   		ShowPlayerDialog(playerid,2,DIALOG_STYLE_LIST," Vehicles: || Scroll Down for more",allvehicles,"Select","Cancel");
		}
	}
	else if(dialogid == 13)
	{
	    if(response)
		{
			if(listitem == 0)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(418,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 1)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(404,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 2)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(479,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 3)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(458,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 4)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(561,X,Y,Z,0,-1,-1,-1),0);
			}
		}
		else
		{
		   	new allvehicles[] = "1\tAirplanes\n2\tHelicopters\n3\tBikes\n4\tConvertibles\n5\tIndustrial\n6\tLowriders\n7\tOffRoad\n8\tPublic Service Vehicles\n9\tSaloons\n10\tSport Vehicles\n11\tStation Wagons\n12\tBoats\n13\tUnique Vehicles\n14\tRC Vehicles\n15\tTrailers";
			ShowPlayerDialog(playerid,2,DIALOG_STYLE_LIST," Vehicles: || Scroll Down for more",allvehicles,"Select","Cancel");
		}
	}
	else if(dialogid == 14)
	{
	    if(response)
		{
			if(listitem == 0)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(472,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 1)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(473,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 2)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(493,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 3)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(595,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 4)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(484,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 5)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(430,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 6)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(453,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 7)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(452,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 8)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(446,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 9)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(454,X,Y,Z,0,-1,-1,-1),0);
			}
		}
		else
		{
		    new allvehicles[] = "1\tAirplanes\n2\tHelicopters\n3\tBikes\n4\tConvertibles\n5\tIndustrial\n6\tLowriders\n7\tOffRoad\n8\tPublic Service Vehicles\n9\tSaloons\n10\tSport Vehicles\n11\tStation Wagons\n12\tBoats\n13\tUnique Vehicles\n14\tRC Vehicles\n15\tTrailers";
	   		ShowPlayerDialog(playerid,2,DIALOG_STYLE_LIST," Vehicles: || Scroll Down for more",allvehicles,"Select","Cancel");
		}
	}
	else if(dialogid == 15)
	{
	    if(response)
		{
			if(listitem == 0)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(485,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 1)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(457,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 2)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(483,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 3)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(508,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 4)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(532,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 5)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(486,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 6)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(406,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 7)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(530,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 8)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(434,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 9)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(545,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 10)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(588,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 11)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(571,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 12)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(572,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 13)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(423,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 14)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(442,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 15)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(428,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 16)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(409,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 17)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(574,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 18)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(525,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 19)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(583,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 20)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(539,X,Y,Z,0,-1,-1,-1),0);
			}
		}
		else
		{
		    new allvehicles[] = "1\tAirplanes\n2\tHelicopters\n3\tBikes\n4\tConvertibles\n5\tIndustrial\n6\tLowriders\n7\tOffRoad\n8\tPublic Service Vehicles\n9\tSaloons\n10\tSport Vehicles\n11\tStation Wagons\n12\tBoats\n13\tUnique Vehicles\n14\tRC Vehicles\n15\tTrailers";
	   		ShowPlayerDialog(playerid,2,DIALOG_STYLE_LIST," Vehicles: || Scroll Down for more",allvehicles,"Select","Cancel");
		}
	}
	else if(dialogid == 16)
	{
	    if(response)
		{
			if(listitem == 0)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(441,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 1)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(464,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 2)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(465,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 3)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(501,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 4)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(564,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 5)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(594,X,Y,Z,0,-1,-1,-1),0);
			}
		}
		else
		{
		    new allvehicles[] = "1\tAirplanes\n2\tHelicopters\n3\tBikes\n4\tConvertibles\n5\tIndustrial\n6\tLowriders\n7\tOffRoad\n8\tPublic Service Vehicles\n9\tSaloons\n10\tSport Vehicles\n11\tStation Wagons\n12\tBoats\n13\tUnique Vehicles\n14\tRC Vehicles\n15\tTrailers";
	   		ShowPlayerDialog(playerid,2,DIALOG_STYLE_LIST," Vehicles: || Scroll Down for more",allvehicles,"Select","Cancel");
		}
	}
	else if(dialogid == 17)
	{
	    if(response)
		{
			if(listitem == 0)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(435,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 1)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(450,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 2)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(591,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 3)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(606,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 4)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(607,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 5)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(610,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 6)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(569,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 7)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(590,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 8)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(584,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 9)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(570,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 10)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(608,X,Y,Z,0,-1,-1,-1),0);
			}
			else if(listitem == 11)
			{
			    PutPlayerInVehicle(playerid,CreateVehicle(611,X,Y,Z,0,-1,-1,-1),0);
			}
		}
		else
		{
		    new allvehicles[] = "1\tAirplanes\n2\tHelicopters\n3\tBikes\n4\tConvertibles\n5\tIndustrial\n6\tLowriders\n7\tOffRoad\n8\tPublic Service Vehicles\n9\tSaloons\n10\tSport Vehicles\n11\tStation Wagons\n12\tBoats\n13\tUnique Vehicles\n14\tRC Vehicles\n15\tTrailers";
	   		ShowPlayerDialog(playerid,2,DIALOG_STYLE_LIST," Vehicles: || Scroll Down for more",allvehicles,"Select","Cancel");
		}
	}
///
///
 if(dialogid == 2323)
 {
    new welcometext[128], playerswelcome[MAX_PLAYER_NAME];
		GetPlayerName(playerid, playerswelcome, sizeof(playerswelcome));
		format(welcometext, sizeof(welcometext), "Welcome To Our Server %s ", playerswelcome);
 	new name[MAX_PLAYER_NAME], file[128], string[128];
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
            format(newtext, sizeof(newtext), "Name : %s     Kill : %d     Death : %d     Wanted Level : %d   Warning : %d",plname, PlayerInfo[playerid][Kills],PlayerInfo[playerid][Death],GetPlayerWantedLevel(playerid),PlayerInfo[playerid][Warnings]);
    TextDrawSetString(TextDrawKD, newtext);
    
 	ShowPlayerDialog(playerid, 334, DIALOG_STYLE_LIST, "Please Select Your Sex", "Male\nFemale", "Select", "");

}
if(dialogid == 9876)
 {
    new welcometext[128], playerswelcome[MAX_PLAYER_NAME];
		GetPlayerName(playerid, playerswelcome, sizeof(playerswelcome));
		format(welcometext, sizeof(welcometext), "Welcome To Our Server %s ", playerswelcome);
 	new name[MAX_PLAYER_NAME], file[128], string[128];
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
            format(newtext, sizeof(newtext), "Name : %s     Kill : %d     Death : %d     Wanted Level : %d   Warning : %d",plname, PlayerInfo[playerid][Kills],PlayerInfo[playerid][Death],GetPlayerWantedLevel(playerid),PlayerInfo[playerid][Warnings]);
    TextDrawSetString(TextDrawKD, newtext);

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
			new name[MAX_PLAYER_NAME], file[128];
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
			new name[MAX_PLAYER_NAME], file[128];
			GetPlayerName(playerid, name, sizeof(name));
			format(file, sizeof(file), SERVER_USER_FILE, name);
            PlayerInfo[playerid][age]= strval(inputtext);
			dini_IntSet(file, "age", PlayerInfo[playerid][age]);
			ShowPlayerDialog(playerid, 560, DIALOG_STYLE_LIST, "Please Select Your Nationality From City ", "Newyork City (USA.)\nMoscow City (Russia)", "Select", "");
            
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
			new name[MAX_PLAYER_NAME], file[128];
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
        
        new welcomeback[128], playerswelcome[MAX_PLAYER_NAME];
		GetPlayerName(playerid, playerswelcome, sizeof(playerswelcome));
		if(PlayerInfo[playerid][Banned]==1)
            {
                new fmsg[128];
				format(fmsg,sizeof(fmsg),"-|Players %s (%d) has been Automatically Kicked By System Protected [President Secreatary] Reason : Ban Evade|- ", playerswelcome);
                SendClientMessageToAll(COLOR_RED1,fmsg);
                Kick(playerid);
                printf(fmsg);
            }
		format(welcomeback, sizeof(welcomeback), "Welcome To Back Our Server %s ", playerswelcome);
    	new name[MAX_PLAYER_NAME], file[128],string[128];
		GetPlayerName(playerid, name, sizeof(name));
		format(file, sizeof(file), SERVER_USER_FILE, name);
		if(!response) return Kick(playerid);
		if (!strlen(inputtext)) return ShowPlayerDialog(playerid, 2424, DIALOG_STYLE_PASSWORD, welcomeback, "Let's Login to your account Please input your password to login", "Login", "Quit");
		new tmp;
		tmp = dini_Int(file, "Password");
		if(udb_hash(inputtext) != tmp)
		{
		    format(string,sizeof(string),"[SYSTEM][KICKED]: Players %s has kicked by Input Invalid password. |Faild Login Name Plz Reconnect|",name);
			SendClientMessageToAll( COLOR_RED1,string);
			SendClientMessage(playerid,COLOR_RED1,string);
			printf(string);
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
            PlayerInfo[playerid][Warnings] = dini_Int(file, "Warnings");
            PlayerInfo[playerid][Hours] = dini_Int(file, "Hours");
            PlayerInfo[playerid][Mins] = dini_Int(file, "Mins");
            PlayerInfo[playerid][Secs] = dini_Int(file, "Secs");
            PlayerInfo[playerid][Muted] = dini_Int(file, "Muted");
            PlayerInfo[playerid][Kills] = dini_Int(file, "Kills");
            PlayerInfo[playerid][Death] = dini_Int(file, "Death");
            PlayerInfo[playerid][Spawned] = dini_Int(file, "Spawned");
            PlayerInfo[playerid][ArmyLevel] = dini_Int(file, "ArmyLevel");
            PlayerInfo[playerid][Skin] = dini_Int(file, "Skin");
            PlayerInfo[playerid][SkinStatus] = dini_Int(file, "SkinStatus");
   			PlayerInfo[playerid][Muted] = dini_Int(file, "Muted");
	        PlayerInfo[playerid][Hours] = dini_Int(file, "Hours");
	        PlayerInfo[playerid][Mins] = dini_Int(file, "Mins");
	        PlayerInfo[playerid][Secs] = dini_Int(file, "Secs");
			PlayerInfo[playerid][Kicked] = dini_Int(file, "Kicked");
			PlayerInfo[playerid][Jail] = dini_Int(file, "Jail");
            PlayerInfo[playerid][savepos] = dini_Int(file, "savepos");
            PlayerInfo[playerid][Hungry] = dini_Int(file, "Hungry");
            PlayerInfo[playerid][pmstatus] = dini_Int(file, "pmstatus");
            SetPlayerScore(playerid, PlayerInfo[playerid][Score]);
            GivePlayerMoney(playerid, dini_Int(file, "Money")-GetPlayerMoney(playerid));
            SendClientMessage(playerid,COLOR_RED1, "[SYSTEM]: Successfully logged in!");
            //SetTimerEx("TotalTime", 1000, true, "i", playerid); // put this somewhere in your scriptforward TotalTime(playerid);
            PlayerInfo[playerid][Register]=1;
            PlayerInfo[playerid][pmstatus]=1;
            PlayerInfo[playerid][FailLogin]=0;
         //   SetTimerEx("HungryTime", 1000, true, "i", playerid);
         GetPlayerName(playerid, plname, MAX_PLAYER_NAME);
            format(newtext, sizeof(newtext), "Name : %s     Kill : %d     Death : %d     Wanted Level : %d   Warning : %d",plname, PlayerInfo[playerid][Kills],PlayerInfo[playerid][Death],GetPlayerWantedLevel(playerid),PlayerInfo[playerid][Warnings]);
    TextDrawSetString(TextDrawKD, newtext);
    TextDrawShowForPlayer(playerid, TextDrawKD);
    
			
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
    new name[MAX_PLAYER_NAME], file[128] ;
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
CMD:setarmylevel(playerid, params[])
{
	new pID, value;
	new ArmyRank[128];
	if(PlayerInfo[playerid][Level]<5 || PlayerInfo[playerid][ArmyLevel] < 5) return 0;
	else if(sscanf(params, "ui", pID, value)) return
	SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /setarmylevel (id) (level)") &&
	SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will Set Army Level To Players");
	else if(value < -1 || value > 5) return SendClientMessage(playerid, -1, "[SYSTEM][ERROR]: Level 0-5");
	else if(pID == INVALID_PLAYER_ID) return SendClientMessage(playerid, -1, "Player Is Not Currently Connected");
	else if(PlayerInfo[pID][LoggedIn]==0) return SendClientMessage(playerid, -1, "Player Is Not Currently Connected");
	else
	{
		new string[128], string1[128], target[MAX_PLAYER_NAME], pName[MAX_PLAYER_NAME];
		new msg[128];
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
	
		printf(msg);
		new name[MAX_PLAYER_NAME], file[128];
 		GetPlayerName(playerid, name, sizeof(name));
 		format(file, sizeof(file), SERVER_USER_FILE, name);
 		dini_IntSet(file, "ArmyLevel", PlayerInfo[playerid][ArmyLevel]);
	}
	return 1;
}
CMD:armys(playerid,params[])
{
	if(PlayerInfo[playerid][Level] < 1 || PlayerInfo[playerid][ArmyLevel] < 1) return emsg(playerid,1);
	  new string[128];
	  new fstring[64];
	  new ArmyRank[50];
	  for(new i=0; i<MAX_PLAYERS; i++)
	  {
	  	if(PlayerInfo[i][ArmyLevel] > 0)
	  	{
		  	new pname[MAX_PLAYER_NAME];
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
	new AdminRank[128];
	if(PlayerInfo[playerid][Level]<5 && !IsPlayerAdmin(playerid)) return 0;
	else if(sscanf(params, "ui", pID, value)) return
	SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /setlevel (id) (level)") &&
	SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will Set Level To Players");
	else if(value < -1 || value > 5) return SendClientMessage(playerid, -1, "[SYSTEM][ERROR]: Level 0-5");
	else if(pID == INVALID_PLAYER_ID) return SendClientMessage(playerid, -1, "Player Is Not Currently Connected");
	else if(PlayerInfo[pID][LoggedIn]==0) return SendClientMessage(playerid, -1, "Player Is Not Currently Connected");
	else
	{
		new string[128], string1[128], target[MAX_PLAYER_NAME], pName[MAX_PLAYER_NAME];
		new msg[128];
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
		printf(msg);
		new name[MAX_PLAYER_NAME], file[128];
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
	
    new str[128];
	new str2[128];
	new id, Name1[MAX_PLAYER_NAME], Name2[MAX_PLAYER_NAME];
    if(sscanf(params, "us[128]", id, str2))
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
	SendClientMessage(playerid, COLOR_GREEN,"[SYSTEM]:Your PM has closed If you want to open pm type /spm again !");
	PlayerInfo[playerid][pmstatus]=1;
	}
	else if(PlayerInfo[playerid][pmstatus]==1)
    {
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
	new reason[128];
	if(sscanf(params, "us[128]", id, reason)) return
	SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /report [ID] [REASON]") &&
	SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will report players to Administrator");
	new string[150], sender[MAX_PLAYER_NAME], receiver[MAX_PLAYER_NAME];
	GetPlayerName(playerid, sender, sizeof(sender));
	GetPlayerName(id, receiver, sizeof(receiver));
	format(string, sizeof(string), "[SYSTEM]: - %s(%d) has reported %s(%d)", sender, playerid, receiver, id);
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(PlayerInfo[i][Level] >=1)
		{
			SendClientMessage(i, COLOR_LIME, string);
		}
	}
	printf(string);
	format(string, sizeof(string), "[SYSTEM]: - Reason: %s", reason);
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(PlayerInfo[i][Level] >=1)
		{
			SendClientMessage(i, COLOR_LIME, string);
		}
	}
	printf(string);
	SendClientMessage(playerid, COLOR_ORANGE, "Your report has been sent.");
	return 1;
}

CMD:admins(playerid,params[])
{
	  new string[128];
	  new fstring[64];
	  new AdminRank[50];
	  for(new i=0; i<MAX_PLAYERS; i++)
	  {
	  	if(PlayerInfo[i][Level] > 0)
	  	{
		  	new pname[MAX_PLAYER_NAME];
		  	GetPlayerName(i,pname, sizeof(pname));
		  	switch(PlayerInfo[i][Level])
			   		{
			   		    case 1: AdminRank = "Organization Employee";
			   		    case 2: AdminRank = "Organization Master Employee";
			   		    case 3: AdminRank = "Organization Secretary";
			   		    case 4: AdminRank = "Organization Agent";
			   		    case 5: AdminRank = "President of System Organization";
			   		  

			   		}
		  	format(fstring, sizeof(fstring),"Rank %s | Player : %s (ID : %d)",AdminRank,pname,playerid);
		  	
		  	strcat(string, fstring, sizeof(string));
	  	}
	  	else if(PlayerInfo[i][Level] <1) return SendClientMessage(playerid,COLOR_VIOLET,"[SYSTEM]: There's No Admins Online But System Protected Still Running");
	  	
	  }
	  ShowPlayerDialog(playerid,2563,DIALOG_STYLE_MSGBOX,"=====|Online Admins|=====",string,"OK","Close");
	

	return 1;
}

/*
CMD:changepass(playerid, params[])
{
	new fileL[64];
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
		new name[MAX_PLAYER_NAME], file[128] ;
 		GetPlayerName(playerid, name, sizeof(name));
 		format(file, sizeof(file), SERVER_USER_FILE, name);
 		PlayerInfo[playerid][Skin] = GetPlayerSkin(playerid);
 		PlayerInfo[playerid][SkinStatus] = 0;
 		dini_IntSet(file, "Skin", PlayerInfo[playerid][Skin]);
 		dini_IntSet(file, "SkinStatus", PlayerInfo[playerid][SkinStatus]);
 		SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM]: Saveskin Successful");
 		new string[128];
 		format(string,sizeof(string),"[SYSTEM]: UnSaveskin Successful");
 		SendClientMessage(playerid,COLOR_ORANGE,string);
 		printf(string);
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
		new name[MAX_PLAYER_NAME], file[128] ;
 		GetPlayerName(playerid, name, sizeof(name));
 		format(file, sizeof(file), SERVER_USER_FILE, name);
 		PlayerInfo[playerid][Skin] = GetPlayerSkin(playerid);
 		PlayerInfo[playerid][SkinStatus] = 1;
 		dini_IntSet(file, "Skin", PlayerInfo[playerid][Skin]);
 		dini_IntSet(file, "SkinStatus", PlayerInfo[playerid][SkinStatus]);
 		SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM]: Saveskin Successful");
 		new string[128];
 		format(string,sizeof(string),"[SYSTEM]: Saveskin Successful (Skin Number %d)",PlayerInfo[playerid][Skin]);
 		SendClientMessage(playerid,COLOR_ORANGE,string);
 		printf(string);
	}
	return 1;
}
CMD:setskin(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 5 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		new target,skin;
		new name[50];
		new name2[50];
		GetPlayerName(playerid, name2, sizeof(name2));
		GetPlayerName(target, name, sizeof(name));
		new string[128];
		new string2[128];
		if(sscanf(params, "ud", target)) return
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
			new string3[128];
 			format(string3,sizeof(string3),"[SYSTEM]: Administrator %s Setskin to Player : %s Successful (Skin Number %d)",name2,name,PlayerInfo[playerid][Skin]);
 			printf(string3);
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
			new adminname [MAX_PLAYER_NAME];
	    	new player1, string[128];
	    	new string2[128],string3[128];
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
     				printf(string2);
					format(string3,sizeof(string3),"|-  You have Muted %s | Reason: %s -|", playername,params[2]);
					
					return SendClientMessage(playerid,COLOR_CYAN,string3);
					}
					else
					{
					format(string,sizeof(string),"|- You have been muted by Administrator %s | No Specified Reason! -| |Warning %d/3|",adminname,PlayerInfo[playerid][Warnings]);
					SendClientMessage(player1,COLOR_RED1,string);
					format(string2,sizeof(string2),"[SYSTEM]: Administrator %s has Muted Player %s Reason : %s", adminname,playername,params[2]);
					SendClientMessageToAll(COLOR_VIOLET,string2);
     				printf(string2);
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
			new adminname [MAX_PLAYER_NAME];
	    	new player1, string[128],string2[128],string3[128];
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
					printf(string);
					SendClientMessage(player1,COLOR_RED1,string);
					format(string,sizeof(string2),"[SYSTEM]: Administrator %s has UnMuted Player %s", adminname,playername);
					SendClientMessageToAll(COLOR_VIOLET,string2);
					printf(string2);
					format(string3,sizeof(string3),"|-  You have UnMuted %s ", playername);
					return SendClientMessage(playerid,COLOR_CYAN,string3);
					}
					else
					{
					format(string,sizeof(string),"|- You have been Unmuted by Administrator %s ",adminname);

					SendClientMessage(player1,COLOR_RED1,string);
					format(string2,sizeof(string2),"[SYSTEM]: Administrator %s has UnMuted Player %s", adminname,playername);
					SendClientMessageToAll(COLOR_VIOLET,string2);
					printf(string2);
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
 		
		new i, reason[50];
		new name[50];
		new string[250];
		new msg[250];
  		new adminname[50];
  		new wadmin[50];
  		GetPlayerName(playerid,adminname, sizeof(adminname));
		if(sscanf(params, "us[50]", i, reason)) return
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
				    new names[MAX_PLAYER_NAME], file[128];
 					GetPlayerName(playerid, names, sizeof(names));
 					format(file, sizeof(file), SERVER_USER_FILE, names);
					format(string, sizeof(string), "-|Players %s  has been Automatically Kicked By System Protected [System Organization President Secretary] Reason : 3/3 Warnned|- ", i);
					SendClientMessageToAll(COLOR_RED1, string);
					PlayerInfo[i][Kicked]++;
					dini_IntSet(file, "Kicked", PlayerInfo[i][Kicked]++);
					Kick(i);
     				printf(string);
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
	    				new str[128],namess[128];
	    				GetPlayerName(playerid, namess, sizeof(namess));
						format(str, sizeof(str), "-|Players %s (%d) has been Automatically Kicked By System Protected [President Secreatary] Reason : 3/3 Warnned|- ", namess, playerid);
						SendClientMessageToAll(COLOR_RED1, str);
					}
				format(msg,sizeof(msg),"[SYSTEM]: Administrator %s Has Given A Warn To Player : %s |Reason : %s |",adminname , name , reason);
				SendClientMessageToAll(COLOR_VIOLET, msg);
				printf(msg);
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
		new name[50];
		new name2[50];
		GetPlayerName(playerid, name2, sizeof(name2));
		GetPlayerName(target, name, sizeof(name));
		new string[128];
		new string2[128];
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
  		new targetid;
		new pname[50];
		new aname[50];
		GetPlayerName(playerid, aname, sizeof(aname));
		GetPlayerName(targetid, pname, sizeof(pname));
		new string[128];
		new string2[128];
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
			printf(string);
			printf(string2);
		}
	}
	return 1;
}
CMD:repair(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 1 && PlayerInfo[playerid][LoggedIn]==1)
	{
	        new string[128];
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
  		new targetid;
		new pname[50];
		new aname[50];
		GetPlayerName(playerid, aname, sizeof(aname));
		GetPlayerName(targetid, pname, sizeof(pname));
		new string[128];
		new string2[128];
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
			printf(string);
			printf(string2);
		}
	}
	return 1;
}

CMD:addnosv(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 1 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		new targetid;
		new pname[50];
		new aname[50];
		GetPlayerName(playerid, aname, sizeof(aname));
		GetPlayerName(targetid, pname, sizeof(pname));
		new string[128];
		new string2[128];
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
			printf(string);
			printf(string2);
		}
	}
	return 1;
}
CMD:addnos(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 1 && PlayerInfo[playerid][LoggedIn]==1)
	{
	        new string[128];
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
    new name[MAX_PLAYER_NAME], file[128];
 	GetPlayerName(playerid, name, sizeof(name));
 	format(file, sizeof(file), SERVER_USER_FILE, name);
	new Float:x,Float:y,Float:z,interiors;
	interiors = GetPlayerInterior(playerid);
	GetPlayerPos(playerid,x,y,z);
	
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
	new string[128];
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
    new name[MAX_PLAYER_NAME], file[128];
 	GetPlayerName(playerid, name, sizeof(name));
 	format(file, sizeof(file), SERVER_USER_FILE, name);
	PlayerInfo[playerid][PosX] = dini_Float(file, "PosX");
    PlayerInfo[playerid][PosY] = dini_Float(file, "PosY");
    PlayerInfo[playerid][PosZ] = dini_Float(file, "PosZ");
	PlayerInfo[playerid][interior] = dini_Int(file, "interior");
	SetPlayerPos(playerid,PlayerInfo[playerid][PosX],PlayerInfo[playerid][PosY],PlayerInfo[playerid][PosZ]);
	SetPlayerInterior(playerid,PlayerInfo[playerid][interior]);
	new string[128];
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
  		new targetid;
		new pname[50];
		new aname[50];
		GetPlayerName(playerid, aname, sizeof(aname));
		GetPlayerName(targetid, pname, sizeof(pname));
		new string[128];
		new string2[128];
		new Float:X,Float:Y,Float:Z;
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
			new string3[128];
			format(string3, 256,"[SYSTEM]: Administrator %s has Teleport Players %s To Administrator Place",aname,pname );
   			printf(string3);
		}
	}
	return 1;
}
CMD:get(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 1 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		new targetid;
		new pname[50];
		new aname[50];
		GetPlayerName(playerid, aname, sizeof(aname));
		GetPlayerName(targetid, pname, sizeof(pname));
		new string[128];
		new string2[128];
		new Float:X,Float:Y,Float:Z;
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
			new string3[128];
			format(string3, 256,"[SYSTEM]: Administrator %s has Teleport to %s ",aname,pname );
   			printf(string3);
		}
	}
	return 1;
}
// Master Employee //
CMD:spec(playerid, params[])
{
	new id,string[128];// This will hold the ID of the player you are going to be spectating.
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
	GetPlayerName(id, Name, sizeof(Name));//Getting the name of the player being spectated.
	format(string, sizeof(string),"You have started to spectate %s.",Name);// Formatting a string to send to the spectator.
	SendClientMessage(playerid,0x0080C0FF,string);//Sending the formatted message to the spectator.
	IsSpecing[playerid] = 1;// Just saying that the spectator has begun to spectate someone.
	IsBeingSpeced[id] = 1;// Just saying that a player is being spectated (You'll see where this comes in)
	spectatorid[playerid] = id;// Saving the spectator's id into this variable.
	new aname[50];
	new pname[50];
	GetPlayerName(playerid, aname, sizeof(aname));
	GetPlayerName(id, pname, sizeof(pname));
//	new string[128];
	format(string, sizeof(string),"[SYSTEM]: Administrator %s has Spectating Player %s",aname,pname);
	printf(string);
	return 1;// Returning 1 - saying that the command has been sent.
}
CMD:specoff(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 2 && PlayerInfo[playerid][LoggedIn]==1)// This checks if the player is logged into RCON, if not it will return 0; (Showing "SERVER: Unknown Command")
	if(IsSpecing[playerid] == 0)return SendClientMessage(playerid,COLOR_RED1,"[SYSTEM][ERROR]: You are not spectating anyone.");
	TogglePlayerSpectating(playerid, 0);//Toggling spectate mode, off. Note: Once this is called, the player will be spawned, there we'll need to reset their positions, virtual world and interior to where they typed '/spec'
	new aname[50];
	GetPlayerName(playerid, aname, sizeof(aname));
	new string[128];
	format(string, sizeof(string),"[SYSTEM]: Administrator %s has Stop Spectating Player ",aname);
	printf(string);
	return 1;
}
CMD:clearchat(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 2 && PlayerInfo[playerid][LoggedIn]==1)
	{
	        new aname[50];
			GetPlayerName(playerid, aname, sizeof(aname));
			new string[128];
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
            printf(string);
	}
	else return emsg(playerid, 1);
	return 1;
}
CMD:kick(playerid ,params[])
{
	if(PlayerInfo[playerid][Level] >= 2 && PlayerInfo[playerid][LoggedIn]==1)
	{

		new i, reason[50];
		new name[50];
//		new string[250];
		new msg[250];
  		new adminname[50];
  		new wadmin[500];
  		GetPlayerName(playerid,adminname, sizeof(adminname));
		if(sscanf(params, "us[50]", i, reason)) return
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
				    new names[MAX_PLAYER_NAME], file[128];
 					GetPlayerName(playerid, names, sizeof(names));
 					format(file, sizeof(file), SERVER_USER_FILE, names);
 					format(msg,sizeof(msg),"[SYSTEM]: Administrator %s Has Kick Player : %s |Reason : %s |",adminname , i , reason);
					SendClientMessageToAll(COLOR_VIOLET, msg);
					printf(msg);
					format(wadmin,sizeof(wadmin),"[SYSTEM]: You Have Kick Player : %s with Reason: %s, ", i,reason);
					SendClientMessage(playerid, COLOR_PINK, wadmin);
					PlayerInfo[i][Kicked]++;
					dini_IntSet(file, "Kicked", PlayerInfo[i][Kicked]++);
					Kick(i);
     				printf(msg);
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
  		new targetid;
		new pname[50];
		new aname[50];
		GetPlayerName(playerid, aname, sizeof(aname));
		GetPlayerName(targetid, pname, sizeof(pname));
		new string[128];
		new string2[128];
		new string3[128];
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
			printf(string3);
			SetPlayerHealth(targetid,100);
		}
	}
	return 1;
}
CMD:acar(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 2 && PlayerInfo[playerid][LoggedIn]==1)
	{
   			new Float:X, Float:Y, Float:Z, Float:angle;
			new carid = 451;
			new aname[50];
			GetPlayerName(playerid, aname, sizeof(aname));
			new string3[128];
			new string[128];
			format(string3, 256,"[SYSTEM]: Spawn Admin Car Successful");
			SendClientMessage(playerid,COLOR_ORANGE,string3);
			format(string, 256,"[SYSTEM]: Administrator %s Used Admin Car Spawning",aname);
			printf(string);
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
            new Float:X, Float:Y, Float:Z, Float:angle;
			new carid = 522;
			new aname[50];
			GetPlayerName(playerid, aname, sizeof(aname));
			new string3[128];
			new string[128];
			format(string3, 256,"[SYSTEM]: Spawn Admin Bike Successful");
			SendClientMessage(playerid,COLOR_ORANGE,string3);
			format(string, 256,"[SYSTEM]: Administrator %s Used Admin Bike Spawning",aname);
			printf(string);
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
   			new Float:X, Float:Y, Float:Z, Float:angle;
			new carid = 497;
			new aname[50];
			GetPlayerName(playerid, aname, sizeof(aname));
			new string3[128];
			new string[128];
			format(string3, 256,"[SYSTEM]: Spawn Admin Helicopter Successful");
			SendClientMessage(playerid,COLOR_ORANGE,string3);
			format(string, 256,"[SYSTEM]: Administrator %s Used Admin Helicopter Spawning",aname);
			printf(string);
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
   			new Float:X, Float:Y, Float:Z, Float:angle;
			new carid = 513;
			new aname[50];
			GetPlayerName(playerid, aname, sizeof(aname));
			new string3[128];
			new string[128];
			format(string3, 256,"[SYSTEM]: Spawn Admin StuntPlane Successful");
			SendClientMessage(playerid,COLOR_ORANGE,string3);
			format(string, 256,"[SYSTEM]: Administrator %s Used Admin StuntPlane Spawning",aname);
			printf(string);
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
   			new Float:X, Float:Y, Float:Z, Float:angle;
			new carid = 519;
			new aname[50];
			GetPlayerName(playerid, aname, sizeof(aname));
			new string3[128];
			new string[128];
			format(string3, 256,"[SYSTEM]: Spawn Admin Private Plane Successful");
			SendClientMessage(playerid,COLOR_ORANGE,string3);
			format(string, 256,"[SYSTEM]: Administrator %s Used Admin Private Plane Spawning",aname);
			printf(string);
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
   			new Float:X, Float:Y, Float:Z, Float:angle;
			new carid = 493;
			new aname[50];
			GetPlayerName(playerid, aname, sizeof(aname));
			new string3[128];
			new string[128];
			format(string3, 256,"[SYSTEM]: Spawn Admin Boat Successful");
			SendClientMessage(playerid,COLOR_ORANGE,string3);
			format(string, 256,"[SYSTEM]: Administrator %s Used Admin Boat Spawning",aname);
			printf(string);
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
		new Float:X, Float:Y, Float:Z, Float:angle;
  		new targetid,carid;
		new pname[50];
		new aname[50];
		GetPlayerName(playerid, aname, sizeof(aname));
		GetPlayerName(targetid, pname, sizeof(pname));
		new string[128];
		new string2[128];
		new string3[128];
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
			printf(string3);
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
  		new stext[128],text[128];
	
		new aname[50];
		GetPlayerName(playerid, aname, sizeof(aname));
		
	
		if(sscanf(params, "s[128]",text)) return
		 SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /announce [text]") &&
		 SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will announce To All Players");
		//else if(targetid == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player is not connected!");
		else
		{
		    format(stext, sizeof(stext),"%s",text);
			GameTextForAll( stext, 5000, 3 );
			new form[128];
			format(form,sizeof(form),"Administrator %s has Announce Text : %s on Server",aname,sizeof(aname),text);
			printf(form);
		}
	}
	return 1;
}

CMD:destroycars(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 1 && PlayerInfo[playerid][LoggedIn]==1)
	{
	    new aname[50];
	    GetPlayerName(playerid,aname,sizeof(aname));
  		new vehicleid;
          vehicleid= GetPlayerVehicleID(playerid);
          DestroyVehicle(vehicleid);
	new string[128];
	format(string,sizeof(string),"[SYSTEM]: Administrator %s Destroy Cars",aname,sizeof(aname));
	printf(string);
	}
	return 1;
}
CMD:announce2(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 3 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		new style,stext[128],text[128];

		new aname[50];
		GetPlayerName(playerid, aname, sizeof(aname));
		

		if(sscanf(params, "ds[128]", style,text)) return
		 SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /announce2 [style1-6] [playerid]") &&
		 SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will announce option To All Players");
		//else if(targetid == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player is not connected!");
		else
		{
		    format(stext, sizeof(stext),"%s",text);
			GameTextForAll( stext, 5000, style );
			new form[128];
			format(form,sizeof(form),"Administrator %s has Announce Text : %s on Server",aname,sizeof(aname),text);
			printf(form);
		}
	}
	return 1;
}
CMD:heal(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 2 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		
			
			new aname[50];
			GetPlayerName(playerid, aname, sizeof(aname));
			new string3[128];
			new string[128];
			format(string3, 256,"[SYSTEM]: Heal Successful");
			SendClientMessage(playerid,COLOR_ORANGE,string3);
			format(string, 256,"[SYSTEM]: Administrator %s Used Heal",aname);
			printf(string);
			SetPlayerHealth(playerid,100);

	}
	return 1;
}
CMD:armour(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 2 && PlayerInfo[playerid][LoggedIn]==1)
	{


			new aname[50];
			GetPlayerName(playerid, aname, sizeof(aname));
			new string3[128];
			new string[128];
			format(string3, 256,"[SYSTEM]: Armour Successful");
			SendClientMessage(playerid,COLOR_ORANGE,string3);
			format(string, 256,"[SYSTEM]: Administrator %s Used Armour",aname);
			printf(string);
			SetPlayerArmour(playerid,100);

	}
	return 1;
}
CMD:disarm(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 2 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		new targetid;
		new pname[50];
		new aname[50];
		GetPlayerName(playerid, aname, sizeof(aname));
		GetPlayerName(targetid, pname, sizeof(pname));
		new string[128];
		new string2[128];
		new string3[128];
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
			printf(string3);
			SendClientMessage(targetid,COLOR_RED1,string3);
			ResetPlayerWeapons(targetid);

		}
	}
	return 1;
}
CMD:jail(playerid ,params[])
{
	if(PlayerInfo[playerid][Level] >= 2 && PlayerInfo[playerid][LoggedIn]==1)
	{

		new i, reason[50];
		new name[50];
		new string[250];
		new msg[250];
  		new adminname[50];
  		new wadmin[500];
  		GetPlayerName(playerid,adminname, sizeof(adminname));
		if(sscanf(params, "us[50]d", i, reason,PlayerInfo[playerid][Jail]*60)) return
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
				    new names[MAX_PLAYER_NAME], file[128];
 					GetPlayerName(playerid, names, sizeof(names));
 					format(file, sizeof(file), SERVER_USER_FILE, names);
				format(msg,sizeof(msg),"[SYSTEM]: Administrator %s Has Jail Player : %s |Reason : %s | |%d Minutes|",adminname , i , reason,PlayerInfo[playerid][Jail]);
					SendClientMessageToAll(COLOR_VIOLET, msg);
					printf(msg);
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
		new name[50];
		new string[250];
		new msg[250];
  		new adminname[50];
  		new wadmin[500];
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
 					new names[MAX_PLAYER_NAME], file[128];
 					GetPlayerName(playerid, names, sizeof(names));
 					format(file, sizeof(file), SERVER_USER_FILE, names);
				format(msg,sizeof(msg),"[SYSTEM]: Administrator %s Has UnJail Player : %s ",adminname , i );
					SendClientMessageToAll(COLOR_VIOLET, msg);
					printf(msg);
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

		new i, reason[50];
		new name[50];
		new string[250];
		new msg[250];
  		new adminname[50];
  		new wadmin[500];
  		GetPlayerName(playerid,adminname, sizeof(adminname));
		if(sscanf(params, "us[50]d", i, reason,FreezeTimes[playerid]*60)) return
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
				    new names[MAX_PLAYER_NAME], file[128];
 					GetPlayerName(playerid, names, sizeof(names));
 					format(file, sizeof(file), SERVER_USER_FILE, names);
				format(msg,sizeof(msg),"[SYSTEM]: Administrator %s Has Freeze Player : %s |Reason : %s | |%d Minutes|",adminname , i , reason,PlayerInfo[playerid][Jail]);
					SendClientMessageToAll(COLOR_VIOLET, msg);
					printf(msg);
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
		new name[50];
		new string[250];
		new msg[250];
  		new adminname[50];
  		new wadmin[500];
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
 					new names[MAX_PLAYER_NAME], file[128];
 					GetPlayerName(playerid, names, sizeof(names));
 					format(file, sizeof(file), SERVER_USER_FILE, names);
					format(msg,sizeof(msg),"[SYSTEM]: Administrator %s Has Unfreeze Player : %s ",adminname , i );
					SendClientMessageToAll(COLOR_VIOLET, msg);
					printf(msg);
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
  		new targetid;
		new pname[50];
		new aname[50];
		GetPlayerName(playerid, aname, sizeof(aname));
		GetPlayerName(targetid, pname, sizeof(pname));
		new string[128];
		new string2[128];
		new string3[128];
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
			printf(string3);
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
		new name[50];
		new name2[50];
		GetPlayerName(playerid, name2, sizeof(name2));
		GetPlayerName(target, name, sizeof(name));
		new string[128];
		new string2[128];
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
			new stringtext[128];
			format(stringtext,sizeof(stringtext),"[SYSTEM]: Administrator %s has slap Player %s ",name2,name);
			printf(stringtext);
		}
	}
	return 1;
}
CMD:punch(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 2 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		new target;
		new name[50];
		new name2[50];
		GetPlayerName(playerid, name2, sizeof(name2));
		GetPlayerName(target, name, sizeof(name));
		new string[128];
		new string2[128];
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
			new stringtext[128];
			format(stringtext,sizeof(stringtext),"[SYSTEM]: Administrator %s has punch Player %s ",name2,name);
			printf(stringtext);
		}
	}
	return 1;
}
CMD:kickass(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 2 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		new target;
		new name[50];
		new name2[50];
		GetPlayerName(playerid, name2, sizeof(name2));
		GetPlayerName(target, name, sizeof(name));
		new string[128];
		new string2[128];
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
			new stringtext[128];
			format(stringtext,sizeof(stringtext),"[SYSTEM]: Administrator %s has kickass Player %s ",name2,name);
			printf(stringtext);
		}
	}
	return 1;
}
//-Secreatary//
CMD:ban(playerid ,params[])
{
	if(PlayerInfo[playerid][Level] >= 3 && PlayerInfo[playerid][LoggedIn]==1)
	{

		new i, reason[50];
		new name[50];
		new string[250];
		new msg[250];
  		new adminname[50];
  		new wadmin[500];
  		GetPlayerName(playerid,adminname, sizeof(adminname));
		if(sscanf(params, "us[50]", i, reason)) return
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
				    new names[MAX_PLAYER_NAME], file[128];
 					GetPlayerName(playerid, names, sizeof(names));
 					format(file, sizeof(file), SERVER_USER_FILE, names);
 					format(msg,sizeof(msg),"[SYSTEM]: Administrator %s Has banned Player : %s |Reason : %s |",adminname , i , reason);
					SendClientMessageToAll(COLOR_VIOLET, msg);
					printf(msg);
					format(wadmin,sizeof(wadmin),"[SYSTEM]: You Have ban Player : %s with Reason: %s, ", i,reason);
					SendClientMessage(playerid, COLOR_PINK, wadmin);
					format(string, sizeof(string),"[SYSTEM]: You Got Banned By Administrator %s With Reason %s You Can Unban or explain at Our webboard",adminname,reason);
					SendClientMessage(playerid, COLOR_RED1, string);
					dini_IntSet(file, "Banned", PlayerInfo[i][Banned]=1);
					Kick(i);
     				printf(msg);
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
	    new adminname[60];
	    GetPlayerName(playerid, adminname,sizeof(adminname));
	    new string[128];
	    format(string,sizeof(string),"[SYSTEM]: Administrator %s has Heal All Players !",adminname);
	    SendClientMessageToAll(COLOR_PINK,string);
	    printf(string);
     	for(new i=0; i<MAX_PLAYERS; i++)
	    {
	        SetPlayerHealth(i,100);
	    }
	    new msg[250];
	    format(msg,sizeof(msg),"[SYSTEM]: Heal All Players Successful");
	    SendClientMessage(playerid,COLOR_GREEN,msg);
	}
	return 1;
}
CMD:armourall(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 3 && PlayerInfo[playerid][LoggedIn]==1)
	{
	    new adminname[60];
	    GetPlayerName(playerid, adminname,sizeof(adminname));
	    new string[128];
	    format(string,sizeof(string),"[SYSTEM]: Administrator %s has Armour All Players !",adminname);
	    SendClientMessageToAll(COLOR_PINK,string);
	    printf(string);
     	for(new i=0; i<MAX_PLAYERS; i++)
	    {
	        SetPlayerArmour(i,100);
	    }
	    new msg[250];
	    format(msg,sizeof(msg),"[SYSTEM]: Armour All Players Successful");
	    SendClientMessage(playerid,COLOR_GREEN,msg);
	}
	return 1;
}
CMD:killall(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 3 && PlayerInfo[playerid][LoggedIn]==1)
	{
	    new adminname[60];
	    GetPlayerName(playerid, adminname,sizeof(adminname));
	    new string[128];
	    format(string,sizeof(string),"[SYSTEM]: Administrator %s has Kill All Players !",adminname);
	    SendClientMessageToAll(COLOR_PINK,string);
	    printf(string);
     	for(new i=0; i<MAX_PLAYERS; i++)
	    {
	        SetPlayerHealth(i,0);
	    }
	    new msg[250];
	    format(msg,sizeof(msg),"[SYSTEM]: Kill All Players Successful");
	    SendClientMessage(playerid,COLOR_GREEN,msg);
	}
	return 1;
}
CMD:respawnall(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 3 && PlayerInfo[playerid][LoggedIn]==1)
	{
	    new adminname[60];
	    GetPlayerName(playerid, adminname,sizeof(adminname));
	    new string[128];
	    format(string,sizeof(string),"[SYSTEM]: Administrator %s has Respawn All Players !",adminname);
	    SendClientMessageToAll(COLOR_PINK,string);
	    printf(string);
     	for(new i=0; i<MAX_PLAYERS; i++)
	    {
	        SpawnPlayer(i);
	    }
	    new msg[250];
	    format(msg,sizeof(msg),"[SYSTEM]: Respawn All Players Successful");
	    SendClientMessage(playerid,COLOR_GREEN,msg);
	}
	return 1;
}
CMD:getall(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 3 && PlayerInfo[playerid][LoggedIn]==1)
	{
	    new adminname[60];
	    GetPlayerName(playerid, adminname,sizeof(adminname));
	    new string[128];
	    format(string,sizeof(string),"[SYSTEM]: Administrator %s has Teleported All Players !",adminname);
	    new Float:PX,Float:PY,Float:PZ;
	    GetPlayerPos(playerid,PX,PY,PZ);
	    SendClientMessageToAll(COLOR_PINK,string);
	    printf(string);
     	for(new i=0; i<MAX_PLAYERS; i++)
	    {
	        SetPlayerPos(i,PX+0.6,PY,PZ);
	    }
	    SetPlayerPos(playerid,PX,PY,PZ);
	    new msg[250];
	    format(msg,sizeof(msg),"[SYSTEM]: Teleported All Players Successful");
	    SendClientMessage(playerid,COLOR_GREEN,msg);
	}
	return 1;
}
CMD:god(playerid,params[])
{
	if(god[playerid]==false)
 	{
	new aname[50];
	GetPlayerName(playerid, aname,sizeof(aname));
	new string[128];
	format(string,sizeof(string),"[SYSTEM]: Administrator %s Enable God Mode",aname);
	printf(string);
	SendClientMessage(playerid, COLOR_GREEN,"[SYSTEM]: God Mode Enabled");
	SetPlayerHealth(playerid,999999999);
	god[playerid]=true;
	}
	else if(god[playerid]==true)
	{
	new aname[50];
	GetPlayerName(playerid, aname,sizeof(aname));
	new string[128];
	format(string,sizeof(string),"[SYSTEM]: Administrator %s Disable God Mode",aname);
	SendClientMessage(playerid, COLOR_GREEN,"[SYSTEM]: God Mode Disable");
	SetPlayerHealth(playerid,100);
	printf(string);
	god[playerid]=false;
	}
	return 1;
}
CMD:settime(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 3 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		new target,hour,mins;
		new name[50];
		new name2[50];
		GetPlayerName(playerid, name2, sizeof(name2));
		GetPlayerName(target, name, sizeof(name));
		new string[128];
		new string2[128];
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
			new stringtext[128];
			format(stringtext,sizeof(stringtext),"[SYSTEM]: Administrator %s has set time Player %s To Hour : %d Min : %d",name2,name,hour,mins);
			printf(stringtext);
		}
	}
	return 1;
}
CMD:setworld(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 3 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		new target,worldnum;
		new name[50];
		new name2[50];
		GetPlayerName(playerid, name2, sizeof(name2));
		GetPlayerName(target, name, sizeof(name));
		new string[128];
		new string2[128];
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
			new stringtext[128];
			format(stringtext,sizeof(stringtext),"[SYSTEM]: Administrator %s has set World Player %s To World %d",name2,name,worldnum);
			printf(stringtext);
		}
	}
	return 1;
}
CMD:setpweather(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 3 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		new target,weatherids;
		new name[50];
		new name2[50];
		GetPlayerName(playerid, name2, sizeof(name2));
		GetPlayerName(target, name, sizeof(name));
		new string[128];
		new string2[128];
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
			new stringtext[128];
			format(stringtext,sizeof(stringtext),"[SYSTEM]: Administrator %s has set Weather Player %s To Weather %d",name2,name,weatherids);
			printf(stringtext);
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
		new name[50];
		new name2[50];
		GetPlayerName(playerid, name2, sizeof(name2));
		GetPlayerName(target, name, sizeof(name));
		new string[128];
		new string2[128];
		if(sscanf(params, "ud", target,health)) return
		SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /sethealth [playerid] [health]") &&
		SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will Set Health To Players ");
		else if(target == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player is not connected!");
		else
		{
			SetPlayerHealth(target,health);
			format(string,sizeof(string),"[SYSTEM]: You Have Set Health Player : %s",name );
			format(string2, 256,"[SYSTEM]: You Were Set health By Administrator %s",name2 );
			SendClientMessage(playerid,COLOR_ORANGE,string);
			SendClientMessage(target,COLOR_ORANGE,string2);
			new stringtext[128];
			format(stringtext,sizeof(stringtext),"[SYSTEM]: Administrator %s has set Health Player %s To Health %d",name2,name,health);
			printf(stringtext);
		}
	}
	return 1;
}
CMD:setarmour(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 3 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		new target,armour;
		new name[50];
		new name2[50];
		GetPlayerName(playerid, name2, sizeof(name2));
		GetPlayerName(target, name, sizeof(name));
		new string[128];
		new string2[128];
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
			new stringtext[128];
			format(stringtext,sizeof(stringtext),"[SYSTEM]: Administrator %s has set armour Player %s To armour %d",name2,name,armour);
			printf(stringtext);
		}
	}
	return 1;
}
CMD:setname(playerid, params[])
{
    
    if(PlayerInfo[playerid][Level] >= 3 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		new target,name3[50];
		new name[50];
		new name2[50];
		GetPlayerName(playerid, name2, sizeof(name2));
		GetPlayerName(target, name, sizeof(name));
		new string[128];
		new string2[128];
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
			new stringtext[128];
			format(stringtext,sizeof(stringtext),"[SYSTEM]: Administrator %s has set Name Player %s To Name : %d",name2,name,name3);
			printf(stringtext);
			//
			new welcometext[128], playerswelcome[MAX_PLAYER_NAME];
			GetPlayerName(target, playerswelcome, sizeof(playerswelcome));
			format(welcometext, sizeof(welcometext), "Welcome To Our Server %s ", playerswelcome);
			new name5[MAX_PLAYER_NAME], file[128];
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
  		new targetid;
		new name[50];
		new name2[50];
	
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
CMD:setcash(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 3 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		new target,cash;
		new name[50];
		new name2[50];
		GetPlayerName(playerid, name2, sizeof(name2));
		GetPlayerName(target, name, sizeof(name));
		new string[128];
		new string2[128];
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
			new stringtext[128];
			format(stringtext,sizeof(stringtext),"[SYSTEM]: Administrator %s has set cash Player %s To cash %d",name2,name,cash);
			printf(stringtext);
		}
	}
	return 1;
}
CMD:setscore(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 3 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		new target,score;
		new name[50];
		new name2[50];
		GetPlayerName(playerid, name2, sizeof(name2));
		GetPlayerName(target, name, sizeof(name));
		new string[128];
		new string2[128];
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
			new stringtext[128];
			format(stringtext,sizeof(stringtext),"[SYSTEM]: Administrator %s has set score Player %s Set score to %d",name2,name,score);
			printf(stringtext);
		}
	}
	return 1;
}
CMD:givecash(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 3 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		new target,cash;
		new name[50];
		new name2[50];
		GetPlayerName(playerid, name2, sizeof(name2));
		GetPlayerName(target, name, sizeof(name));
		new string[128];
		new string2[128];
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
			new stringtext[128];
			format(stringtext,sizeof(stringtext),"[SYSTEM]: Administrator %s has Give cash Player %s Give cash %d",name2,name,cash);
			printf(stringtext);
		}
	}
	return 1;
}
CMD:givescore(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 3 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		new target,score,scorebehind;
		new name[50];
		new name2[50];
		GetPlayerName(playerid, name2, sizeof(name2));
		GetPlayerName(target, name, sizeof(name));
		new string[128];
		new string2[128];
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
			new stringtext[128];
			format(stringtext,sizeof(stringtext),"[SYSTEM]: Administrator %s has Give score Player %s Give score %d",name2,name,score);
			printf(stringtext);
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
CMD:respawncars(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 4 && PlayerInfo[playerid][LoggedIn]==1)
	{


			new aname[50];
			GetPlayerName(playerid, aname, sizeof(aname));
			new string3[512];
			new string[512];
			format(string3, 512,"[SYSTEM]: Respawncars Successful");
			SendClientMessage(playerid,COLOR_ORANGE,string3);
			format(string, 512,"[SYSTEM]: Administrator %s Respawncars in Server !",aname);
			SendClientMessageToAll(COLOR_RED,string);
			printf(string);
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
	//	new name[50];
		new name2[50];
		GetPlayerName(playerid, name2, sizeof(name2));
		//GetPlayerName(target, name, sizeof(name));
		new string[128];
		new string2[128];
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
		   	new stringtext[128];
		   	
			format(stringtext,sizeof(stringtext),"[SYSTEM]: Administrator %s has Give All score To Player | Give score %d",name2,score);
            SendClientMessageToAll(COLOR_ORANGE,stringtext);
           	printf(stringtext);
		}
	}
	return 1;
}
CMD:giveallcash(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 4 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		new cash;
//		new name[50];
		new name2[50];
		GetPlayerName(playerid, name2, sizeof(name2));
		//GetPlayerName(target, name, sizeof(name));
		new string[128];
		new string2[128];
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
		   	new stringtext[128];
		   	format(string,sizeof(string),"[SYSTEM]: You Have Give cash To All Player  %s");
			
			format(stringtext,sizeof(stringtext),"[SYSTEM]: Administrator %s has Give All cash To Player | Give cash %d",name2,cash);
            SendClientMessageToAll(COLOR_ORANGE,stringtext);
            SendClientMessage(playerid,COLOR_ORANGE,string);
			
			printf(stringtext);
		}
	}
	return 1;
}
CMD:giveallweapons(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 4 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		new weaps;
		//new name[50];
		new name2[50];
		GetPlayerName(playerid, name2, sizeof(name2));
		//GetPlayerName(target, name, sizeof(name));
		new string[128];
		new string2[128];
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
		   	new stringtext[128];
		   	format(string,sizeof(string),"[SYSTEM]: You Have Give weapons To All Player");
			format(stringtext,sizeof(stringtext),"[SYSTEM]: Administrator %s has Give All weapons To Player | Give weapons ID: %d",name2,weaps);
            SendClientMessageToAll(COLOR_ORANGE,stringtext);
            SendClientMessage(playerid,COLOR_ORANGE,string);
			printf(stringtext);
		}
	}
	return 1;
}
CMD:setallscore(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 4 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		new score;
		//new name[50];
		new name2[50];
		GetPlayerName(playerid, name2, sizeof(name2));
		//GetPlayerName(target, name, sizeof(name));
		new string[128];
		new string2[128];
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
		   	new stringtext[128];
		   	format(string,sizeof(string),"[SYSTEM]: You Have Set Score To All Player");
			format(stringtext,sizeof(stringtext),"[SYSTEM]: Administrator %s has Set All Score To Player | Set Score to %d",name2,score);
            SendClientMessageToAll(COLOR_ORANGE,stringtext);
            SendClientMessage(playerid,COLOR_ORANGE,string);
			
			printf(stringtext);
		}
	}
	return 1;
}
CMD:setallcash(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 4 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		new pv;
		//new name[50];
		new name2[50];
		GetPlayerName(playerid, name2, sizeof(name2));
		new string[128];
		new string2[128];
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
		   	new stringtext[128];
			format(stringtext,sizeof(stringtext),"[SYSTEM]: Administrator %s has Set All cash To Player | Set cash to %d",name2,pv);
            SendClientMessageToAll(COLOR_ORANGE,stringtext);
            SendClientMessage(playerid,COLOR_ORANGE,string);

			printf(stringtext);
		}
	}
	return 1;
}
CMD:setweather(playerid,params[])
{
    if(PlayerInfo[playerid][Level] >= 4 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		//new target,weatherids;
		//new name[50];
		new name2[50];
		GetPlayerName(playerid, name2, sizeof(name2));
		//GetPlayerName(target, name, sizeof(name));
		new string[128];
		//new string2[128];
		SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /setweather ") &&
		SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will Set Server Weather To All Players ");
		//else if(target == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player is not connected!");
		ShowPlayerDialog(playerid, DIALOGID, DIALOG_STYLE_LIST, "Server Weather", "Blue Sky\nStormy\nFoggy\nScorching Hot\nDull\nSandstorm\nGreen Fog\nDark - Purple\nDark - Green\nPink Sky\nRed Sky\nPurple Sky\nBlack Sky\nMorning Sky\nMystic Blue Sky", "Select", "Cancel");

			GetWeather();
			format(string,sizeof(string),"[SYSTEM]: You Have Set Server Weather for All Player ");
			//format(string2, 256,"[SYSTEM]: You Were Set Weather By Administrator %s",name2 );
			SendClientMessage(playerid,COLOR_ORANGE,string);
			//SendClientMessage(target,COLOR_ORANGE,string2);
			new stringtext[128];
			format(stringtext,sizeof(stringtext),"[SYSTEM]: Administrator %s has set Weather To All Player To Weather %d",name2,CurrentWeather);
			printf(stringtext);

	}
	return 1;
}
CMD:setweatherid(playerid,params[])
{
    if(PlayerInfo[playerid][Level] >= 4 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		new weatherids;
		//new name[50];
		new name2[50];
		GetPlayerName(playerid, name2, sizeof(name2));
		//GetPlayerName(target, name, sizeof(name));
		new string[128];
		//new string2[128];
		SendClientMessage(playerid, COLOR_RED1, "[SYSTEM]: /setweather [id] ") &&
		SendClientMessage(playerid, COLOR_INDIGO,"[SYSTEM][EXPLAIN] : Will Set Server Weather By ID To All Players ");
		//else if(target == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOR_RED1, "[SYSTEM][ERROR]:Player is not connected!");
		//ShowPlayerDialog(playerid, DIALOGID, DIALOG_STYLE_LIST, "Server Weather", "Blue Sky\nStormy\nFoggy\nScorching Hot\nDull\nSandstorm\nGreen Fog\nDark - Purple\nDark - Green\nPink Sky\nRed Sky\nPurple Sky\nBlack Sky\nMorning Sky\nMystic Blue Sky", "Select", "Cancel");

			SetWeather(weatherids);
			format(string,sizeof(string),"[SYSTEM]: You Have Set Server Weather ID %d for All Player ",weatherids);
			//format(string2, 256,"[SYSTEM]: You Were Set Weather By Administrator %s",name2 );
			SendClientMessage(playerid,COLOR_ORANGE,string);
			//SendClientMessage(target,COLOR_ORANGE,string2);
			new stringtext[128];
			format(stringtext,sizeof(stringtext),"[SYSTEM]: Administrator %s has set Weather To All Player To Weather %d",name2,weatherids);
			printf(stringtext);

	}
	return 1;
}
//level 5//
CMD:setkills(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 5 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		new target,kills;
		new name[50];
		new name2[50];
		GetPlayerName(playerid, name2, sizeof(name2));
		GetPlayerName(target, name, sizeof(name));
		new string[128];
		new string2[128];
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
			new stringtext[128];
			format(stringtext,sizeof(stringtext),"[SYSTEM]: Administrator %s has set Kills Player %s To %d Kills",name2,name,kills);
			printf(stringtext);
		}
	}
	return 1;
}
CMD:setdeath(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 5 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		new target,deaths;
		new name[50];
		new name2[50];
		GetPlayerName(playerid, name2, sizeof(name2));
		GetPlayerName(target, name, sizeof(name));
		new string[128];
		new string2[128];
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
			new stringtext[128];
			format(stringtext,sizeof(stringtext),"[SYSTEM]: Administrator %s has set Kills Player %s To %d Death",name2,name,deaths);
			printf(stringtext);
		}
	}
	return 1;
}
CMD:rpk(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 5 && PlayerInfo[playerid][LoggedIn]==1)
	{
  		new target;
		new name[50];
		new name2[50];
		GetPlayerName(playerid, name2, sizeof(name2));
		GetPlayerName(target, name, sizeof(name));
		new string[128];
		new string2[128];
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
			new stringtext[128];
			format(stringtext,sizeof(stringtext),"[SYSTEM]: Administrator %s has Start Roleplay Kills Player %s ",name2,name);
			SendClientMessageToAll(COLOR_RED,stringtext);
			SendClientMessageToAll(COLOR_RED,"[COLONEL]: Dear %s You will died with Honor or Died like Bitches ?");
			printf(stringtext);
			//
			new name3[MAX_PLAYER_NAME], file[128];
			printf("Set File Path Finished");
			GetPlayerName(playerid, name3, sizeof(name3));
			printf("GetPlayerName Finish");
			format(file, sizeof(file), SERVER_USER_FILE, name3);
			printf("File Path Loaded");
			dini_IntSet(file, "RPK", PlayerInfo[target][RPK]);
			printf("RoleplayKilled Profile Writed!");
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
		new name[50];
		new name2[50];
		GetPlayerName(playerid, name2, sizeof(name2));
		GetPlayerName(target, name, sizeof(name));
		new string[128];
		new string2[128];
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
			new stringtext[128];
			format(stringtext,sizeof(stringtext),"[SYSTEM]: Administrator %s has Stop Roleplay Kills Player %s ",name2,name);
			SendClientMessageToAll(COLOR_RED,stringtext);
			printf(stringtext);
			//
			new name3[MAX_PLAYER_NAME], file[128];
			printf("Set File Path Finished");
			GetPlayerName(playerid, name3, sizeof(name3));
			printf("GetPlayerName Finish");
			format(file, sizeof(file), SERVER_USER_FILE, name3);
			printf("File Path Loaded");
			dini_IntSet(file, "RPK", PlayerInfo[target][RPK]);
			printf("RoleplayKilled Profile Writed!");
			SetWeather(0);
			//
		}
	}
	return 1;
}
//addition//
CMD:myrank(playerid,params[])
	{
	     if(GetPlayerScore(playerid) >= 0 && GetPlayerScore(playerid) <= 30)
		{
    	new string[64];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Private & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        //new Text3D:label = Create3DTextLabel("Rank : Private", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		//Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
		if(GetPlayerScore(playerid) >= 31 && GetPlayerScore(playerid) <= 60)
    	{
    	new string[64];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Second Private & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        //new Text3D:label = Create3DTextLabel("Rank : Second Private", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		//Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
        if(GetPlayerScore(playerid) >= 61 && GetPlayerScore(playerid) <= 90)
    	{
    	new string[64];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Corporal & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        //new Text3D:label = Create3DTextLabel("Rank : Corporal", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		//Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
		if(GetPlayerScore(playerid) >= 91 && GetPlayerScore(playerid) <= 120)
    	{
    	new string[64];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Sergeant & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        //new Text3D:label = Create3DTextLabel("Rank : Sergeant", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		//Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
        if(GetPlayerScore(playerid) >= 121 && GetPlayerScore(playerid) <= 200)
    	{
    	new string[64];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Staff Sergeant & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        //new Text3D:label = Create3DTextLabel("Rank : Staff Sergeant", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
	//	Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
		if(GetPlayerScore(playerid) >= 201 && GetPlayerScore(playerid) <= 350)
    	{
    	new string[64];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Lieutenant & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        //new Text3D:label = Create3DTextLabel("Rank : Lieutenant", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		//Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
        if(GetPlayerScore(playerid) >= 351 && GetPlayerScore(playerid) <= 450)
    	{
    	new string[64];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Scond Lieutenant & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
       // new Text3D:label = Create3DTextLabel("Rank : Second Lieutenant", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		//Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
        if(GetPlayerScore(playerid) >= 451 && GetPlayerScore(playerid) <= 700)
    	{
    	new string[64];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Captain & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        //new Text3D:label = Create3DTextLabel("Rank : Captain", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		//Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
		if(GetPlayerScore(playerid) >= 701 && GetPlayerScore(playerid) <= 900)
    	{
    	new string[64];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Major & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        //new Text3D:label = Create3DTextLabel("Rank : Major", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		//Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
		if(GetPlayerScore(playerid) >= 901 && GetPlayerScore(playerid) <= 1500)
    	{
    	new string[64];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Colonel & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        //new Text3D:label = Create3DTextLabel("Rank : Colonel", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		//Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		if(GetPlayerScore(playerid) >= 1501 && GetPlayerScore(playerid) <= 2200)
    	{
    	new string[64];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Marshall & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        //new Text3D:label = Create3DTextLabel("Rank : Marshall", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		//Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
		if(GetPlayerScore(playerid) >= 2201 && GetPlayerScore(playerid) <= 2800)
    	{
    	new string[64];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Commander & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        //new Text3D:label = Create3DTextLabel("Rank : Commander", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		//Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
        if(GetPlayerScore(playerid) >= 2801 && GetPlayerScore(playerid) <= 3500)
    	{
    	new string[64];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Staff Commander & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        //new Text3D:label = Create3DTextLabel("Rank : Staff Commander", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		//Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
		if(GetPlayerScore(playerid) >= 3501 && GetPlayerScore(playerid) <= 4000)
    	{
    	new string[64];
		format(string, sizeof(string), "Rank INFO : Your Rank Is General & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        //new Text3D:label = Create3DTextLabel("Rank : General", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		//Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
		if(GetPlayerScore(playerid) >= 4001 )
    	{
    	new string[64];
		format(string, sizeof(string), "Rank INFO : Your Rank Is General Of Army & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        //new Text3D:label = Create3DTextLabel("Rank : General Of Army", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		//Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
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
    CMD:kill(playerid,params[])
	{
	SetPlayerHealth(playerid,0.0);
	SendClientMessage(playerid, COLOR_BLUE,"You Commit SUicide ");
	return 1;
	}

	CMD:handsup(playerid,params[])
	{
    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_HANDSUP);
    return 1;
	}
	CMD:beer(playerid,params[])
	{
            SendClientMessage(playerid,COLOR_BLUE,"Press f TO Drop it");
    		SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DRINK_BEER);
    		return 1;
	}

    CMD:ciggy(playerid,params[])
    {
	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_SMOKE_CIGGY);
	return 1;
	}
		CMD:animhelp(playerid,params[])
	{
    SendClientMessage(playerid,COLOR_BLUE,"/ciggy ~ Cigarett");
    SendClientMessage(playerid,COLOR_BLUE,"/beer ~ buy 1 beer for 1$");
    SendClientMessage(playerid,COLOR_BLUE,"/handsup ~ put ur handsup");
    SendClientMessage(playerid,COLOR_BLUE,"/animlist");

    return 1;
    }
    CMD:rules(playerid,params[])
	{
    SendClientMessage(playerid,COLOR_RED,"This is Rules Of server");
    SendClientMessage(playerid,COLOR_RED,"1. Do not Spawnkilling + Spawn camping Who Do this will Got warn");
    SendClientMessage(playerid,COLOR_RED,"2. Do not Cheat , Hack or use CLEO MOD If Broke this RUles = Kicked/Banned");
    SendClientMessage(playerid,COLOR_RED,"3. Respect Another Players If u Flamming U Will got Warn");
    SendClientMessage(playerid,COLOR_RED,"4. No G-Abuse ");
    SendClientMessage(playerid,COLOR_RED,"5. No Bug Abuse Ex: C-BUg");
    SendClientMessage(playerid,COLOR_RED,"6. Do not Spamming Text in server");
    SendClientMessage(playerid,COLOR_RED,"7. No Pausing , AFK To Avoid die");
    SendClientMessage(playerid,COLOR_RED,"8. DO not RUIN RP whe server have RP Who Broke this Will GOt warn");
    SendClientMessage(playerid,COLOR_RED,"9. If U Flaming Admin U will ot kicked !");
    SendClientMessage(playerid,COLOR_RED,"10. Do not Do ur self fake admin ");
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
    new name[MAX_PLAYER_NAME], file[128];
	GetPlayerName(playerid, name, sizeof(name));
	format(file, sizeof(file), SERVER_USER_FILE, name);
	if (!dini_Exists(file))
	{
	    if(PlayerInfo[playerid][Register] == 0)
	    {
	    new welcometext[128], playerswelcome[MAX_PLAYER_NAME];
		GetPlayerName(playerid, playerswelcome, sizeof(playerswelcome));
		format(welcometext, sizeof(welcometext), "Welcome To Our Server %s ", playerswelcome);
	    SendClientMessage(playerid,COLOR_CYAN,"Your Name is not registered Please Register !");
		ShowPlayerDialog(playerid, 2323, DIALOG_STYLE_PASSWORD, welcometext , "Welcome, your name didn't registered now, Please input your registration password below", "Register", "Quit");
		}

	}
	if(fexist(file))
	{
	    new welcomeback[128], playerswelcome[MAX_PLAYER_NAME];
		GetPlayerName(playerid, playerswelcome, sizeof(playerswelcome));
		format(welcomeback, sizeof(welcomeback), "Welcome To Back Our Server %s ", playerswelcome);
		ShowPlayerDialog(playerid, 2424, DIALOG_STYLE_PASSWORD, welcomeback, "Let's Login to your account Please input your password to login", "Login", "Quit");

	}
	//
	new pname[MAX_PLAYER_NAME], string[256 + MAX_PLAYER_NAME];
    GetPlayerName(playerid, pname, sizeof(pname));
    format(string, sizeof(string), "Player %s (Id:%d) has Connected To the server", pname,playerid);
    SendClientMessageToAll(COLOR_LEMON, string);
    return 1;
 }
