


// This is a comment
// uncomment the line below if you want to write a filterscript
//#define FILTERSCRIPT

#include <a_samp>
#include <Geoip>
//#include <ladmin>
#pragma tabsize 0
//#include <sfunc>
#include <OPSP>
//#include <dudb>
//#include <dini>
//#include <Dutils>   // This include is used for some important function
#include <streamer>
#include <sscanf2>
#include <zcmd>
//#include <j_inventory_v2>
#define savefolder "/save/%s.ini"
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
#define TEAM_USAARMY 0
#define TEAM_BRITISH 1
#define TEAM_EUROPE 2
#define TEAM_RUSSIA 3
#define TEAM_GERMANY 4
#define TEAM_ITALY 5


#define savefolder "/save/%s.ini"

//#pragma unused ret_memcpy // This avoid the ret_memcpy warning
/*
new Float:RandomSpawns[][] =
	{
        {-1793.4851,-2216.7256,72.8541},
        {-1720.7323,-2310.8562,44.6797},
        {-1640.3942,-2238.8123,31.4766,83.9035}

	};
new Float:RandomSpawns2[][] =
	{
        {-1021.2409,-2311.3049,60.5184,67.3494},
        {-1063.4803,-2224.9275,48.5141},
        {-1063.7050,-2317.7498,58.9786}

	};
	*/

new randomMessages[][] =  //here, we're creating the array with the name "randomMessages"
    {

	"{FFC400} Jarvis : {00aeff} Register/ Visits On Our Forum soon !",
	"{FFC400} Jarvis : {00aeff} In World War III Satuation British America And Europe are Aliance",
	"{FFC400} Jarvis : {00aeff} Donate For Extra Benefit Be VIP",
	"{FFC400} Jarvis : {00aeff} See hacker ? use /report id reason",
	"{FFC400} Jarvis : {00aeff} /animhelp &/animlist Is menu of animation !",
	"{FFC400} Jarvis : {00aeff} No Admin In Server ? Use report On Our Forum ! ",
	"{FFC400} Jarvis : {00aeff} Welcome To War Of Future 2020's World War III",
	"{FFC400} Jarvis : {00aeff} Purple is Russia Team",
	"{FFC400} Jarvis : {00aeff} Green is Europe Team",
	"{FFC400} Jarvis : {00aeff} /rules For Show Rules Of server",
	"{FFC400} Jarvis : {00aeff} Earn Score For Money ! And By Weapons !",
	"{FFC400} Jarvis : {00aeff} /help to show basic help menu",
	"{FFC400} Jarvis : {00aeff} Donate Today ! Receive VIP and Special Option!",
"{FFC400} Jarvis : {00aeff}Yellow is British Team",
 "{FFC400} Jarvis : {00aeff}/animhelp To See Animation Help !",


 "{FFC400} Jarvis : {00aeff}do /cmds to see cmd !",
 "{FFC400} Jarvis : {00aeff}Want be VIP ? just donate Ingame 2500$ got Lv.1 !",
 "{FFC400} Jarvis : {00aeff}You are VIP ? try this if you dont know ! /vcmds 1,2,3",

 "{FFC400} Jarvis : {00aeff}/animlist For animation menu",
 "{FFC400} Jarvis : {00aeff}/help for show help and /rules for show the rules",
 "{FFC400} Jarvis : {00aeff}Do not hack if you hack jarvis will Kill you :D",
 "{FFC400} Jarvis : {00aeff}Have Problem ? /ask [question] Admin Will Answer You !",
 "{FFC400} Jarvis : {00aeff}Got A Bug ? /reportbug [text] will send to admin !",
"{FFC400} Jarvis : {00aeff}How many rank in server ? use /rank",
"{FFC400} Jarvis : {00aeff}See who is richest here type /richlist",
"{FFC400} Jarvis : {00aeff}Blue is U.S.A. Army Team",
"{FFC400} Jarvis : {00aeff}Red is Germany Team",
"{FFC400} Jarvis : {00aeff}Brown is Italy Team",
"{FFC400} Jarvis : {00aeff}See who is Top Score ? /topscore",
	"{FFC400} Jarvis : {00aeff} Earn Rank to Recieve Many Bonus !",
	"{FFC400} Jarvis : {00aeff} >>> War Of Future <<< **World War III The Future Of Worldwar 2020's**",
	"{FFC400} Jarvis : {00aeff} Respect All Administrator And All Players ",
	"{FFC400} Jarvis : {00aeff} Watch RP time ! May Be After RP You will got Bonus !"
};
forward RandomMessages();
public RandomMessages()
{
    new randomMsg = random(sizeof(randomMessages)); //create a variable "randomMsg" and give it the value of our array we've created ("randomMessages")
//the word "random" is included into PAWN, which will tell the script, to work randomly with the array
    SendClientMessageToAll(COLOR_ORANGE, randomMessages[randomMsg]); //this will send the content of our array to EVERYBODY on the server
// the content are strings, and we're using our array "randomMessages" with our created variable "randomMsg" again
}
new gTeam[MAX_PLAYERS];

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
	print(" War Of Future TDM Server GAMEMODE Loaded");
	print("----------------------------------\n");
}

#endif
new Text:killstext;
public OnGameModeInit()

{
    SetGameModeText("WOF WW3 TDM/RP");
   
	
 	#include <war.txt>
    DisableInteriorEnterExits();
    
	SetTimer("RandomMessages", 100000, true);
	AddPlayerClass(287,-435.0710,888.7910,4.5297,246.7639,0,0,0,0,0,0); // 0
	AddPlayerClass(285,-435.0710,888.7910,4.5297,246.7639,0,0,0,0,0,0);
	AddPlayerClass(286,-435.0710,888.7910,4.5297,246.7639,0,0,0,0,0,0);
	AddPlayerClass(164,-435.0710,888.7910,4.5297,246.7639,0,0,0,0,0,0);
	AddPlayerClass(299,-435.0710,888.7910,4.5297,246.7639,0,0,0,0,0,0);
	AddPlayerClass(126,-435.0710,888.7910,4.5297,246.7639,0,0,0,0,0,0);
	UsePlayerPedAnims();
	EnableStuntBonusForAll(0);
	killstext = TextDrawCreate(1.0, 5.6, " ");
    TextDrawAlignment(killstext, 2);
    TextDrawBackgroundColor(killstext, 255);
    TextDrawFont(killstext, 3);
    TextDrawLetterSize(killstext, 0.709998, 2.100001);
    TextDrawColor(killstext, -1);
    TextDrawSetOutline(killstext, 1);
    TextDrawSetProportional(killstext, 0);
    //
  

	return 1;
}

public OnGameModeExit()
{
	return 1;
}
stock HandleKS(playerid, killerid) //put this function outside of any callbacks or functions
{
     killstreak[playerid] = 0;
     killstreak[killerid] ++;

     new msg1[64], msg2[64], name1[MAX_PLAYER_NAME], name2[MAX_PLAYER_NAME], textdraw[41];

     GetPlayerName(playerid, name1, strlen(name1));
     GetPlayerName(playerid, name2, strlen(name2));

     format(msg1, strlen(msg1), "%s has ended %s's killstreak", name2, name1);
     format(msg2, strlen(msg2), "%s is now on a killsreak of %i", name2, killstreak[killerid]);
     format(textdraw, sizeof(textdraw), "%s: %i", name, killstreak[killerid]);
    TextDrawSetString(killstext, newtext);
    TextDrawShowForAll(killstext);

     SendClientMessageToAll(COLOR_CYAN, msg1);
     SendClientMessageToAll(COLOR_CYAN, msg2);

     switch(killstreak[killerid])
     {
          case 3:
          {
              new string[64], pName[MAX_PLAYER_NAME];
              GetPlayerName(playerid,pName,MAX_PLAYER_NAME);
              format(string,sizeof string,"%s is now on a Killstreak of 3 Kills.",pName);
              SendClientMessageToAll(COLOR_CYAN,string);
          }
          case 4:
          {
              new string[64], pName[MAX_PLAYER_NAME];
              GetPlayerName(playerid,pName,MAX_PLAYER_NAME);
              format(string,sizeof string,"%s is now on a Killstreak of 4 Kills.",pName);
              SendClientMessageToAll(COLOR_CYAN,string);
          }
          case 5:
          {
              new string[64], pName[MAX_PLAYER_NAME];
              GetPlayerName(playerid,pName,MAX_PLAYER_NAME);
              format(string,sizeof string,"%s is now on a Killstreak of 5 Kills.",pName);
              SendClientMessageToAll(COLOR_CYAN,string);
          }
          case 6:
          {
              new string[64], pName[MAX_PLAYER_NAME];
              GetPlayerName(playerid,pName,MAX_PLAYER_NAME);
              format(string,sizeof string,"%s is now on a Killstreak of 6 Kills.",pName);
              SendClientMessageToAll(COLOR_CYAN,string);
          }
          case 7:
          {
              new string[64], pName[MAX_PLAYER_NAME];
              GetPlayerName(playerid,pName,MAX_PLAYER_NAME);
              format(string,sizeof string,"%s is now on a Killstreak of 7 Kills.",pName);
              SendClientMessageToAll(COLOR_CYAN,string);
          }
          case 8:
          {
              new string[64], pName[MAX_PLAYER_NAME];
              GetPlayerName(playerid,pName,MAX_PLAYER_NAME);
              format(string,sizeof string,"%s is now on a Killstreak of 8 Kills.",pName);
              SendClientMessageToAll(COLOR_CYAN,string);
          }
          case 9:  //change the numbers as desired and add/remove as many as you want
          {
              new string[64], pName[MAX_PLAYER_NAME];
              GetPlayerName(playerid,pName,MAX_PLAYER_NAME);
              format(string,sizeof string,"%s is now limit on a Killstreak of 9 Kills.",pName);
              SendClientMessageToAll(COLOR_CYAN,string);
          }
     }
     return 1;
}

forward SetPlayerTeamFromClass (playerid, classid);
public OnPlayerRequestClass(playerid, classid)
{
   
 	SetPlayerPos(playerid, 1553.4327,-1278.3240,250.6563);
	SetPlayerCameraPos(playerid, 1553.0516,-1273.1624,250.6563);
	SetPlayerCameraLookAt(playerid, 1553.4327,-1278.3240,250.6563);
	SetPlayerTeamFromClass(playerid, classid);
	return 1;
}



public SetPlayerTeamFromClass(playerid, classid)
{
  
    if(classid == 0)
    {
        GameTextForPlayer(playerid,"~b~U.S.A.Army",1000,4);
        gTeam[playerid] = TEAM_USAARMY;
        
		SetPlayerColor (playerid, COLOR_BLUE);
		SetPlayerTeam (playerid,0);
        
    	
    	
        
	
		}
	else if(classid == 1)
	{
        GameTextForPlayer(playerid,"~y~British England",1000,4);
        gTeam[playerid] = TEAM_BRITISH;
        
		SetPlayerColor (playerid, COLOR_YELLOW);
		SetPlayerTeam (playerid,1);
			}

			if(classid == 2)
    {
        GameTextForPlayer(playerid,"~g~Europe Alliance",1000,4);
        gTeam[playerid] = TEAM_EUROPE;
        
		SetPlayerColor (playerid, COLOR_GREEN);
		SetPlayerTeam (playerid,2);





		}
	else if(classid == 3)
	{
        GameTextForPlayer(playerid,"~p~Russia",1000,4);
        gTeam[playerid] = TEAM_RUSSIA;
        
		SetPlayerColor (playerid, COLOR_PURPLE);
		SetPlayerTeam (playerid,3);
			}
			if(classid == 4)
    {
        GameTextForPlayer(playerid,"~r~Germany",1000,4);
        gTeam[playerid] = TEAM_GERMANY;
        
		SetPlayerColor (playerid, COLOR_RED);
		SetPlayerTeam (playerid,4);





		}
	else if(classid == 5)
	{
        GameTextForPlayer(playerid,"~o~Italy",1000,4);
        gTeam[playerid] = TEAM_ITALY;
        
		SetPlayerColor (playerid, COLOR_BROWN);
		SetPlayerTeam (playerid,5);
			}
	
	return 0;
}

public OnPlayerConnect(playerid)
{
    GameTextForPlayer(playerid,"~y~Welcome~n~~p~To~n~~r~W~g~a~b~r ~w~O~y~f ~p~F~g~u~b~t~y~u~p~r~r~e ~g~2~i~0~y~20's ~g~War" , 3000, 3);
    PlayAudioStreamForPlayer(playerid, "http://k002.kiwi6.com/hotlink/9pi5k45wez/havana_brown_feat._pitbul_-_we_run_the_night_-_ring_download.mp3");
    SendClientMessage(playerid, COLOR_DARKBLUE,">> War Of Future << **WorldWar Future 2020's**");
    
    SendClientMessage(playerid, COLOR_GREEN,"Loading Gamemode.... This Will Take Few Second....");
    SendClientMessage(playerid, COLOR_BLUE," Loading SAMP WORLD");
    SendClientMessage(playerid, COLOR_YELLOW,"Loading World Object.....");
    SendClientMessage(playerid, COLOR_ORANGE,"Welcome To War of Future 'The World War Future'");
    #include <remove.txt>
    

	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
  
    
	return 1;
}

new Float:PosX,Float:PosY,Float:PosZ;
//new Float:PosX2,Float:PosY2,Float:PosZ2;

        
public OnPlayerSpawn(playerid)
{
    GameTextForPlayer(playerid,"~Y~Loading ~n~~r~ WORLD ~g~OBJECT ~p~.~b~.~w~.",5000,5);
	if(GetPlayerScore(playerid) <= 10)
{
    return SendClientMessage(playerid, COLOR_YELLOW,"Are You New ? May be This Cmd Can help you ! | /help , /rules ,/animhelp ,/endanim|");
}
		
     //    GetPlayerCameraLookAtPos(playerid,PosX2,PosY2,PosZ2) ;
         GetPlayerCameraPos(playerid,PosX,PosY,PosZ) ;
        SetPlayerCameraPos(playerid,525.9901,-812.7970,94.8128);
	//	SetPlayerCameraLookAt(playerid,525.9901,-812.7970,94.8128);//setting player to same pos to avoid entering vehicle
	
        if(GetPlayerTeam(playerid) == 0|| 1 || 2)
    	{
    	SendClientMessage(playerid, COLOR_RED,"Your Are Alliance With America British Europe Are 1 Team in World War times");
    	}
    	if(GetPlayerTeam(playerid) == 3||4||5)
    	{
    	SendClientMessage(playerid, COLOR_RED,"Your Are Alliance With Russia Germany Italy Are 1 Team in World War times");
    	}
        SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);
		ClearAnimations(playerid);
        ResetPlayerWeapons(playerid);
		TogglePlayerControllable(playerid, false); // Freeze the player
    	SetTimerEx("Unfreeze", 5000, false, "i", playerid); // Make a 5 second timer for that player to get unfrozen
   		SetTimerEx("cam", 3000, false, "i", playerid); // Make a 5 second timer for that player to get unfrozen
		{
		GameTextForPlayer(playerid,"~Y~Loading ~n~~r~ WORLD ~g~OBJECT ~p~.~b~.~w~.",5000,5);

        
        if(GetPlayerScore(playerid) >= 0 && GetPlayerScore(playerid) <= 30)
		{
    	new string[64];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Private & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        new Text3D:label = Create3DTextLabel("Rank : Private", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
		if(GetPlayerScore(playerid) >= 31 && GetPlayerScore(playerid) <= 60)
    	{
    	new string[64];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Second Private & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        new Text3D:label = Create3DTextLabel("Rank : Second Private", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
        if(GetPlayerScore(playerid) >= 61 && GetPlayerScore(playerid) <= 90)
    	{
    	new string[64];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Corporal & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        new Text3D:label = Create3DTextLabel("Rank : Corporal", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
		if(GetPlayerScore(playerid) >= 91 && GetPlayerScore(playerid) <= 120)
    	{
    	new string[64];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Sergeant & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        new Text3D:label = Create3DTextLabel("Rank : Sergeant", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
        if(GetPlayerScore(playerid) >= 121 && GetPlayerScore(playerid) <= 200)
    	{
    	new string[64];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Staff Sergeant & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        new Text3D:label = Create3DTextLabel("Rank : Staff Sergeant", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
		if(GetPlayerScore(playerid) >= 201 && GetPlayerScore(playerid) <= 350)
    	{
    	new string[64];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Lieutenant & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        new Text3D:label = Create3DTextLabel("Rank : Lieutenant", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
        if(GetPlayerScore(playerid) >= 351 && GetPlayerScore(playerid) <= 450)
    	{
    	new string[64];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Scond Lieutenant & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        new Text3D:label = Create3DTextLabel("Rank : Second Lieutenant", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
        if(GetPlayerScore(playerid) >= 451 && GetPlayerScore(playerid) <= 700)
    	{
    	new string[64];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Captain & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        new Text3D:label = Create3DTextLabel("Rank : Captain", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
		if(GetPlayerScore(playerid) >= 701 && GetPlayerScore(playerid) <= 900)
    	{
    	new string[64];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Major & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        new Text3D:label = Create3DTextLabel("Rank : Major", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
		if(GetPlayerScore(playerid) >= 901 && GetPlayerScore(playerid) <= 1500)
    	{
    	new string[64];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Colonel & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        new Text3D:label = Create3DTextLabel("Rank : Colonel", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		if(GetPlayerScore(playerid) >= 1501 && GetPlayerScore(playerid) <= 2200)
    	{
    	new string[64];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Marshall & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        new Text3D:label = Create3DTextLabel("Rank : Marshall", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
		if(GetPlayerScore(playerid) >= 2201 && GetPlayerScore(playerid) <= 2800)
    	{
    	new string[64];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Commander & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        new Text3D:label = Create3DTextLabel("Rank : Commander", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
        if(GetPlayerScore(playerid) >= 2801 && GetPlayerScore(playerid) <= 3500)
    	{
    	new string[64];
		format(string, sizeof(string), "Rank INFO : Your Rank Is Staff Commander & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        new Text3D:label = Create3DTextLabel("Rank : Staff Commander", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
		if(GetPlayerScore(playerid) >= 3501 && GetPlayerScore(playerid) <= 4000)
    	{
    	new string[64];
		format(string, sizeof(string), "Rank INFO : Your Rank Is General & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        new Text3D:label = Create3DTextLabel("Rank : General", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
		if(GetPlayerScore(playerid) >= 4001 )
    	{
    	new string[64];
		format(string, sizeof(string), "Rank INFO : Your Rank Is General Of Army & Your Score is %d", GetPlayerScore(playerid));
		SendClientMessage(playerid, 0x33AA33AA, string);
        new Text3D:label = Create3DTextLabel("Rank : General Of Army", 0x33CCFFAA, 15.0, 25.0, 35.0, 25.0, 0);
		Attach3DTextLabelToPlayer(label, playerid, 0.0, 0.0, 0.4);
		}
		//
		/*
		if(IsPlayerVipMember(playerid))
		{
		    new Text3D:VIPtag = Create3DTextLabel("VIP Members", COLOR_ORANGE, 30.0, 40.0, 50.0, 40.0, 0);
			Attach3DTextLabelToPlayer(VIPtag, playerid, 0.0, 0.0, 0.7);

		}
		*/
        if (IsPlayerNPC(playerid))
    	{
		SetPlayerColor(playerid, COLOR_BLUE);
		return 1;
    	}
	
/*
		if(IsPlayerVipMember(playerid))
		{
		    new Text3D:VIPtag = Create3DTextLabel("VIP Members", COLOR_ORANGE, 30.0, 40.0, 50.0, 40.0, 0);
			Attach3DTextLabelToPlayer(VIPtag, playerid, 0.0, 0.0, 0.7);

		}
		*/
		
  		 
	
}

	return 1;

}

forward Unfreeze(playerid);
public Unfreeze(playerid)
{
    TogglePlayerControllable(playerid, true); // Unfreeze the player after 5 seconds
    return 1;
}
 
forward cam(playerid);
public cam(playerid)
{
    SetPlayerCameraPos(playerid,PosX,PosY,PosZ);//setting player to same pos to avoid entering vehicle
   // SetPlayerCameraLookAt(playerid,PosX2,PosY2,PosZ2);
    return 1;
}
public OnPlayerDeath(playerid, killerid, reason)
{
   
	GivePlayerMoney(playerid, GetPlayerMoney(playerid) + 100);
	SendDeathMessage(killerid, playerid, reason);
    ResetPlayerWeapons(playerid);

    SetPlayerScore(killerid, GetPlayerScore(killerid)+1);
    GivePlayerMoney(killerid, GetPlayerMoney(killerid)+1);

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
/*
public OnPlayerCommandText(playerid, cmdtext[])
{

    if(strcmp ("/restart",cmdtext, true) == 0)
    {
    	if(IsPlayerJAdminLvl(playerid, 4))
    {
        	for (new i=0; i < MAX_PLAYERS; i++)
	{
     	GameTextForPlayer(playerid,"~y~The~n~~p~Server~n~ ~w~I~y~s ~p~R~g~e~b~s~y~t~p~a~r~r~y~t~g~i~p~n~w~g~n~~r~Please Stay In Server!" , 8500, 5);
	    GangZoneDestroy(GZ_ZONE1);
    	GangZoneDestroy(GZ_ZONE2);
	    SendRconCommand("gmx");


	}
		SendClientMessageToAll(COLOR_BLUE, "Server Restart in 5 second Please Stay In Server! ...");
		GameTextForPlayer(playerid,"~y~The~n~~p~Server~n~ ~w~I~y~s ~p~R~g~e~b~s~y~t~p~a~r~r~y~t~g~i~p~n~w~g~n~~r~Please Stay In Server!" , 8500, 5);
    }
    return 1;
	}
	if(strcmp("/myrank", cmdtext,true) == 0)
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

		return 1;
	 }
    new PlayerFlareObject[MAX_PLAYERS];
// in on player command text
	if (strcmp("/flare", cmdtext,true) == 0 )
	{
		if(IsPlayerJAdminLvl(playerid, 5))
		{
    		if (PlayerFlareObject[playerid] == -1) // player haves no flare, create it
			{
        		PlayerFlareObject[playerid] = CreateDynamicObject(18732, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
    		}
    		else // player haves a flare, delete it
    		{
        	DestroyObject(PlayerFlareObject[playerid]);
        	PlayerFlareObject[playerid] = -1;
    		}
    	}
    	return 1;
    }


    if(strcmp("/rank", cmdtext,true) == 0 )
	{
	    SendClientMessage(playerid,0x99FFFFAA,"Rank ");
	    SendClientMessage(playerid,0x99FFFFAA,"-Private,-Second Private,-Corporal");
	    SendClientMessage(playerid,0x99FFFFAA,"-Sergeant,-Staff Sergeant,-Lieutenant");
	    SendClientMessage(playerid,0x99FFFFAA,"-Second Lieutenant,-Captain,-Major,-Colonel");
	    SendClientMessage(playerid,0x99FFFFAA,"-Marshall,-Commander,-Staff Commander,-General,-General Of army");
	    return 1;
	}
    if(!strcmp(cmdtext, "/djcolonel", true, 3)) // 3 is the length of /me
    {
        SendClientMessage(playerid,COLOR_BLUE,"/fearless,/bdl,/harlemshake,/werunthenight,/turnupthelove,/dktc");
        SendClientMessage(playerid,COLOR_BLUE,"/chasingthesun,/rollinginthedeep,/whistle,/low,/turnaround");
        SendClientMessage(playerid,COLOR_BLUE,"/igottafeeling,/wildones,/partyrock,/boomboompow,/rainitoverme");
        SendClientMessage(playerid,COLOR_BLUE,"/dontwannagohomeremix,/payphone,/gmevt,/gangnamstyle,/gtasa");
        return 1;
    }

    if(!strcmp(cmdtext, "/selectclass", true, 3)) // 3 is the length of /me
    {
        ForceClassSelection(playerid);
		TogglePlayerSpectating(playerid, true);
		TogglePlayerSpectating(playerid, false);
        return 1;
    }

	//
    if(!strcmp(cmdtext, "/me", true, 3)) // 3 is the length of /me
    {
        if(!cmdtext[3])return SendClientMessage(playerid, COLOR_RED, "USAGE: /me [text]");
        new str[128];
        GetPlayerName(playerid, str, sizeof(str));
        format(str, sizeof(str), "* %s %s", str, cmdtext[4]);
        SendClientMessageToAll( COLOR_PINK, str);
        return 1;
    }
    if(!strcmp(cmdtext, "/Jarvis", true, 7)) // 3 is the length of /me
    {
        if(IsPlayerJAdminLvl(playerid, 5))
        {
        if(!cmdtext[7])return SendClientMessage(playerid, COLOR_RED, "USAGE: /Jarvis [text]");
        new string[128];

        format(string, sizeof(string), "Jarvis : {00aeff} %s ", cmdtext[8]);
        SendClientMessage(playerid, COLOR_ORANGE, string);
		return 1;
		}
		else
		SendClientMessage(playerid, COLOR_WHITE,"SERVER: Unknown Command");
        return 1;
    }
    if(!strcmp(cmdtext, "/Jarvisy", true, 7)) // 3 is the length of /me
    {
        if(IsPlayerJAdminLvl(playerid, 5))
        {



        SendClientMessage(playerid, COLOR_ORANGE,"Jarvis : {00aeff} Yes Sir ! ");

		return 1;
		}
		else
		SendClientMessage(playerid, COLOR_WHITE,"SERVER: Unknown Command");
        return 1;
    }

	if(strcmp("/rpk", cmdtext, true ) == 0)
    {
    if(IsPlayerJAdminLvl(playerid, 5)) { // Check if you're an admin.
      if(!strlen(cmdtext[6]))
	  	{
   		return SendClientMessage(playerid, 0xFFAA00AA, "Usage: /rpk [targetid]");
   		}
        new targetid = strval(cmdtext[6]);
        if(IsPlayerConnected(targetid))
		{
          new string[128], playername[MAX_PLAYER_NAME], targetname[MAX_PLAYER_NAME];
          GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
          GetPlayerName(targetid, targetname, MAX_PLAYER_NAME);
          format(string, 128, "Admin %s Roleplay Kill  you from the server.", playername);
          SendClientMessage(targetid, 0xFFAA00AA, string);
          Ban(targetid);
          format(string, 128, "Admin %s RP Killed ( Roleplay Kill ) %s from the server.", playername, targetname);
          SendClientMessageToAll(0xFFAA00AA, string);
        }
        else{
        return SendClientMessage(playerid, 0xFFAA00AA, "That player is not connected.");
        }
    }
    else{
      return SendClientMessage(playerid, 0xFFAA00AA, "Server Owner Developer Only");
    }
      return 1;
    }
    if(!strcmp(cmdtext, "/aa", true))
    {
        if(IsPlayerJAdminLvl(playerid, 5) || IsPlayerAdmin(playerid))
    	{
		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
 		CreateExplosion(x, y, z, 7, 12.0);
		}


        SetPlayerPos(playerid, 1213.0519,700.7701,10.9141);//AmmunationEntrance


    }

	//
	if(!strcmp(cmdtext, "/getbeer", true))
    {
        if(IsPlayerInRangeOfPoint(playerid, 10.0, 1455.3368,-1634.0420,14.0393))
        {
        	SendClientMessage(playerid,COLOR_BLUE,"Press F TO Drop it");
    		SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DRINK_BEER);
        }
        if(IsPlayerInRangeOfPoint(playerid, 25.0, 1477.9614,-1681.7452,14.0469))
        {
            SendClientMessage(playerid,COLOR_BLUE,"Press F TO Drop it");
    		SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DRINK_BEER);
        }
        if(!IsPlayerInRangeOfPoint(playerid, 25.0, 1477.9614,-1681.7452,14.0469)) return SendClientMessage(playerid, COLOR_RED,"You Need Get Near Bar !");
        if(!IsPlayerInRangeOfPoint(playerid, 10.0, 1455.3368,-1634.0420,14.0393)) return SendClientMessage(playerid, COLOR_RED,"You Need Get Near Bar !");


    }
    if(!strcmp(cmdtext, "/enter", true))
    {
        if(IsPlayerInRangeOfPoint(playerid, 3.0, 1262.12,780.706,12.7565))
        {
            SetPlayerPos(playerid, 1265.78,786.407,3.63281);//AmmunationEntrance
            SetPlayerInterior(playerid, 1);
        }
        if(IsPlayerInRangeOfPoint(playerid, 3.0, 1285.30,807.034,3.67187))
        {
            SetPlayerPos(playerid, 1297.72,834.979,-2.99218);//AmmunationEntrance
            SetPlayerInterior(playerid, 1);
        }
    }
    if(!strcmp(cmdtext, "/exit", true))
    {
        if(IsPlayerInRangeOfPoint(playerid, 3.0, 1265.78,786.407,3.63281))
        {
            SetPlayerPos(playerid, 1262.12,780.706,12.7565);//AmmunationExit
            SetPlayerInterior(playerid, 0);
        }
         if(IsPlayerInRangeOfPoint(playerid, 3.0, 1297.72,834.979,-2.99218))
        {
            SetPlayerPos(playerid, 1285.30,807.034,3.67187);//AmmunationExit
            SetPlayerInterior(playerid, 0);
        }
    }
	//
	//
	if (strcmp("/endanim", cmdtext, true) == 0)
	{
	    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);
	    ClearAnimations(playerid);
	    return 1;
	}
	if (strcmp("/chute", cmdtext, true) == 0)
	{
	GivePlayerWeapon(playerid,46,1);
	return 1;
	}
    if (strcmp("/kill", cmdtext, true) == 0)
	{
	SetPlayerHealth(playerid,0.0);
	SendClientMessage(playerid, COLOR_BLUE,"You Commit SUicide ");
	return 1;
	}

	if(strcmp("/handsup", cmdtext, true) == 0)
	{
    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_HANDSUP);
    return 1;
	}
	if(strcmp("/beer", cmdtext, true) == 0)
	{
            SendClientMessage(playerid,COLOR_BLUE,"Press f TO Drop it");
    		SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DRINK_BEER);
    		return 1;
	}
	if(strcmp("/rank", cmdtext,true) == 0 )
	{
	    SendClientMessage(playerid,0x99FFFFAA,"Rank ");
	    SendClientMessage(playerid,0x99FFFFAA,"-Private,-Second Private,-Corporal");
	    SendClientMessage(playerid,0x99FFFFAA,"-Sergeant,-Staff Sergeant,-Lieutenant");
	    SendClientMessage(playerid,0x99FFFFAA,"-Second Lieutenant,-Captain,-Major,-Colonel");
	    SendClientMessage(playerid,0x99FFFFAA,"-Marshall,-Commander,-Staff Commander,-General,-General Of army");
	    return 1;
	}



    if(strcmp ("/ciggy", cmdtext, true) == 0)
    {
	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_SMOKE_CIGGY);
	return 1;
	}
	if(strcmp ("/help", cmdtext, true) == 0)
	{
    SendClientMessage(playerid,COLOR_BLUE,"Welcome TO help menu ");
    SendClientMessage(playerid,COLOR_BLUE,"/animhelp To see Animation help");
    SendClientMessage(playerid,COLOR_BLUE,"/rules TO see RUles Of server");
    SendClientMessage(playerid,COLOR_BLUE,"/admins To see admins name and how much online");
    SendClientMessage(playerid,COLOR_BLUE,"/report [id] [reason] to Report Hacker");
    SendClientMessage(playerid,COLOR_BLUE,"/animlist");
    return 1;
	}
	if(strcmp ("/animhelp", cmdtext, true) == 0)
	{
    SendClientMessage(playerid,COLOR_BLUE,"/ciggy ~ Cigarett");
    SendClientMessage(playerid,COLOR_BLUE,"/beer ~ buy 1 beer for 1$");
    SendClientMessage(playerid,COLOR_BLUE,"/handsup ~ put ur handsup");
    SendClientMessage(playerid,COLOR_BLUE,"/animlist");

    return 1;
    }
    if(strcmp ("/rules", cmdtext, true) == 0)
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

    //

    //


    if(strcmp ("/stopmusic",cmdtext, true) == 0)
    {
    	if(IsPlayerJAdminLvl(playerid, 4))
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
    if(strcmp ("/fearless",cmdtext, true) == 0)
    {
    	if(IsPlayerJAdminLvl(playerid, 4))
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
    if(strcmp ("/cocktail",cmdtext, true) == 0)
    {
    	if(IsPlayerJAdminLvl(playerid, 4))
    {
        	for (new i=0; i < MAX_PLAYERS; i++)
	{
	    StopAudioStreamForPlayer(i);
	    PlayAudioStreamForPlayer(i, "http://k007.kiwi6.com/hotlink/kh80bc7z65/audio_-_cocktail.mp3");

	}
		SendClientMessageToAll(COLOR_BLUE, "Fearless Taylor Swift");
    }
    else SendClientMessage(playerid, COLOR_WHITE, "SERVER: UNKNOWN COMMAND");
  return 1;
    }
    if(strcmp ("/bdl",cmdtext, true) == 0)
    {
    	if(IsPlayerJAdminLvl(playerid, 4))
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
    if(strcmp ("/harlemshake",cmdtext, true) == 0)
    {
    	if(IsPlayerJAdminLvl(playerid, 4))
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
    if(strcmp ("/danza",cmdtext, true) == 0)
    {
    	if(IsPlayerJAdminLvl(playerid, 4))
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
    if(strcmp ("/werunthenight",cmdtext, true) == 0)
    {
    	if(IsPlayerJAdminLvl(playerid, 4))
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
    if(strcmp ("/turnupthelove",cmdtext, true) == 0)
    {
    	if(IsPlayerJAdminLvl(playerid, 4))
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
    if(strcmp ("/dktc",cmdtext, true) == 0)
    {
    	if(IsPlayerJAdminLvl(playerid, 4))
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
    if(strcmp ("/chasingthesun",cmdtext, true) == 0)
    {
    	if(IsPlayerJAdminLvl(playerid, 4))
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
    if(strcmp ("/rollinginthedeep",cmdtext, true) == 0)
    {
    	if(IsPlayerJAdminLvl(playerid, 4))
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
    if(strcmp ("/whistle",cmdtext, true) == 0)
    {
    	if(IsPlayerJAdminLvl(playerid, 4))
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
    if(strcmp ("/low",cmdtext, true) == 0)
    {
    	if(IsPlayerJAdminLvl(playerid, 4))
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
    if(strcmp ("/turnaround",cmdtext, true) == 0)
    {
    	if(IsPlayerJAdminLvl(playerid, 4))
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
    if(strcmp ("/igottafeeling",cmdtext, true) == 0)
    {
    	if(IsPlayerJAdminLvl(playerid, 4))
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
    if(strcmp ("/wildones",cmdtext, true) == 0)
    {
    	if(IsPlayerJAdminLvl(playerid, 4))
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
    if(strcmp ("/partyrock",cmdtext, true) == 0)
    {
    	if(IsPlayerJAdminLvl(playerid, 4))
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
    if(strcmp ("/boomboompow",cmdtext, true) == 0)
    {
    	if(IsPlayerJAdminLvl(playerid, 4))
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
    if(strcmp ("/rainitoverme",cmdtext, true) == 0)
    {
    	if(IsPlayerJAdminLvl(playerid, 4))
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
    if(strcmp ("/dontwannagohomeremix",cmdtext, true) == 0)
    {
    	if(IsPlayerJAdminLvl(playerid, 4))
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
    if(strcmp ("/payphone",cmdtext, true) == 0)
    {
    	if(IsPlayerJAdminLvl(playerid, 4))
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
    if(strcmp ("/gmevt",cmdtext, true) == 0)
    {
    	if(IsPlayerJAdminLvl(playerid, 4))
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
    if(strcmp ("/gangnamstyle",cmdtext, true) == 0)
    {
    	if(IsPlayerJAdminLvl(playerid, 4))
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
    if(strcmp ("/gtasa",cmdtext, true) == 0)
    {
    	if(IsPlayerJAdminLvl(playerid, 4))
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
    if(strcmp ("/mylovesong",cmdtext, true) == 0)
    {
    	if(IsPlayerJAdminLvl(playerid, 4))
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
    if(strcmp ("/naked",cmdtext, true) == 0)
    {
    	if(IsPlayerJAdminLvl(playerid, 4))
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
    if(strcmp("/allbeer",cmdtext, true) == 0)
    {
    if(IsPlayerJAdminLvl(playerid, 4))
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
    if(strcmp("/midnight",cmdtext, true) == 0)
    {
    if(IsPlayerJAdminLvl(playerid, 4))
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
    if(strcmp("/evening",cmdtext, true) == 0)
    {
    if(IsPlayerJAdminLvl(playerid, 4))
    {
        for(new i = 0; i < MAX_PLAYERS; i++)
		{
		    SetWorldTime(21);
		}
		SetWorldTime(21);
	}
    else SendClientMessage(playerid, COLOR_WHITE, "ERROR: You not is Administrator Level 4");
  return 1;
    }
    if(strcmp("/morning",cmdtext, true) == 0)
    {
    if(IsPlayerJAdminLvl(playerid, 4))
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
    if(strcmp("/early",cmdtext, true) == 0)
    {
    if(IsPlayerJAdminLvl(playerid, 4))
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
    if(strcmp("/evening",cmdtext, true) == 0)
    {
    if(IsPlayerJAdminLvl(playerid, 4))
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
    if(strcmp("/level6",cmdtext, true) == 0)
    {
    if(IsPlayerJAdminLvl(playerid, 6))
    {
        SendClientMessage(playerid, COLOR_RED, "/lockserver,/unlockserver,/uconfig,/settemplevel,/crash,/lconfig,/jetpack");
        SendClientMessage(playerid, COLOR_RED, "/lcam,/observations,/setskin,/setlevel,/setvip,/console,/ctele");
        SendClientMessage(playerid, COLOR_RED, "/fu,/minigun,/fakecmd,/fakechat,/fakedeath,/kickall,/execcmd");
	}
    else SendClientMessage(playerid, COLOR_WHITE, "SERVER:Unknown Command");
  return 1;
    }

    if(strcmp("/changefaction",cmdtext, true) == 0)
	{
	if (GetPlayerTeam(playerid) ==0)
		{
			new pname;
			GetPlayerName(playerid),pname;
			print("%s Has Change Team To Government Team !"),pname;
			SetPlayerTeam (playerid,1);
			SetPlayerHealth(playerid,0);
		}
	else
		{
		    new pname;
			GetPlayerName(playerid),pname;
			print("%s Has Change Team To Terrorist Team !"),pname;
			SetPlayerTeam (playerid,0);
			SetPlayerHealth(playerid,0);
		}
  	return 1;
    }

	return 0;
}
*/
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


    
    /*
if(GetPlayerTeam(playerid) == 0)
		{
		SetPlayerColor (playerid, COLOR_GREY);
		GivePlayerWeapon(playerid, 30, 420);//AK
        GivePlayerWeapon(playerid, 27, 120);//combat
        GivePlayerWeapon(playerid, 32, 360);//tec-9
        //GivePlayerWeapon(playerid, 44, 100);//niviosn
        GivePlayerWeapon(playerid, 16, 5);//granade
        GivePlayerWeapon(playerid, 22, 250);//9mm
        GivePlayerWeapon(playerid, 4, 1);//knife
		new Random = random(sizeof(RandomSpawns2));
		SetPlayerPos(playerid, RandomSpawns2[Random][0], RandomSpawns2[Random][1], RandomSpawns2[Random][2]);
		SetPlayerFacingAngle(playerid, RandomSpawns2[Random][3]);
  		}
  		if(GetPlayerTeam(playerid) == 1)
		{
		SetPlayerColor (playerid, COLOR_GREEN);
	     GivePlayerWeapon(playerid, 31, 420);//m4
        GivePlayerWeapon(playerid, 27, 120);//combat
        GivePlayerWeapon(playerid, 25, 360);//mp5
        GivePlayerWeapon(playerid, 16, 5);//niviosn
        GivePlayerWeapon(playerid, 23, 250);//niviosn
        GivePlayerWeapon(playerid, 4, 1);//niviosn
		new Random = random(sizeof(RandomSpawns));
		SetPlayerPos(playerid, RandomSpawns[Random][0], RandomSpawns[Random][1], RandomSpawns[Random][2]);
		SetPlayerFacingAngle(playerid, RandomSpawns[Random][3]);
  		}
  		*/
    	SendClientMessage(playerid ,COLOR_PURPLE,"Welcome To War Of Future We Hope You Fun!");
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
   /*
    if(GetPlayerWeapon(playerid) == WEAPON_MINIGUN)
	{
	    SendClientMessage(playerid,0xFF0000FF,"you are Banned By Admin Jarvis : Reason Minigun \n");
		SendClientMessage(playerid,0xFF0000FF,"YOu can show appeal to unban on www.warofexistence.linkmaster.com");
	    Ban(playerid);
	    new string[128];
	    new PlayerName[MAX_PLAYER_NAME];
		format(string,sizeof(string),"|- Player %s (Id:%d) has been Banned By Administrator Jarvis | Reason: Spawn Weapon Minigun -|",PlayerName,playerid);
		SendClientMessageToAll(0xAA3333AA, string);  print(string);

	 }

	if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USEJETPACK)
	{
		SendClientMessage(playerid,0xFF0000FF,"you are Banned By Admin Jarvis : Reason Jetpack \n");
		SendClientMessage(playerid,0xFF0000FF,"YOu can show appeal to unban on www.warofexistence.linkmaster.com");
	    Ban(playerid);
	    new string[128];
	    new PlayerName[MAX_PLAYER_NAME];
		format(string,sizeof(string),"|- Player %s (Id:%d) has been Banned By Administrator Jarvis | Reason: Spawn Jetpack -|",PlayerName,playerid);
		SendClientMessageToAll(0xAA3333AA, string);  print(string);
	    return 0;
	}
 */
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


	return 1;
}



public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}
